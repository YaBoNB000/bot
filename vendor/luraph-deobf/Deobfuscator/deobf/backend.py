"""
Lifter back end, shared by every devirtualizer front end.

A front end walks one VM function and produces its instruction graph as
`order`: [(state key, ir.Node)], where a state key is a tuple starting
(mode, pc, ...) and ir.Next(state).state.key(link) names the successor.
lower() turns that into Luau lines: CFG (structure.build_cfg), loops,
simplification, variables, structuring (goto elimination), idioms, render.
The text passes (polish, finish) run once on the whole program.
"""
import os
import re
import sys
import threading


def lower(entry_key, order, D, link, prefix, upnames, closure):
    """Luau lines of one function.

    D        the IR module (ir.py, or a front end that re-exports it)
    link     passed to state.key() for successor keys (the front end's loop-stack link)
    prefix   register name prefix for this nesting depth
    upnames  {upvalue index: name} of the function's upvalues
    closure  closure(ClosureExpr, names) -> codegen.FuncE: lifts a child
             function once its captured variables have names

    Returns (lines, params, unlifted block count, unstructured jump count)."""
    import structure as ST
    import codegen as CG
    import loops as LP
    import variables as VR
    import idioms as IDI
    from luasym import ClosureExpr, Pseudo
    entry, blocks = ST.build_cfg(entry_key, order, D, link)
    if not os.environ.get("DEVIRT_NO_MERGE"):
        entry, _ = ST.merge_equivalent(entry, blocks, D)
    entry = ST.thread_empty(entry, blocks)
    LP.recognize(entry, blocks, D)
    # dropping the VM's loop bookkeeping leaves empty hops (e.g. `break` paths)
    entry = ST.thread_empty(entry, blocks)
    CG.simplify_blocks(blocks, D)
    own = set(VR.rename(entry, blocks, prefix, set()).values())
    names = {("up", i): nm for i, nm in (upnames or {}).items()}

    # child closures, now that the captured variables have names
    def conv(x):
        return closure(x, names) if isinstance(x, ClosureExpr) else None
    for b in blocks.values():
        for i, s_ in enumerate(b.stmts):
            if isinstance(s_, CG.AssignS):
                s_.values = CG.map_multi(s_.values, conv)
                s_.targets = [t if isinstance(t, (CG.LocalName, Pseudo)) else CG.map_expr(t, conv)
                              for t in s_.targets]
            elif isinstance(s_, (CG.CallS, CG.TempDef, CG.SetListS, CG.ForPrepS)):
                b.stmts[i] = CG.map_stmt(s_, lambda e: CG.map_expr(e, conv), lambda m: CG.map_multi(m, conv))
        if b.kind == "cond":
            b.cond = CG.map_expr(b.cond, conv)
        elif b.kind == "ret" and b.values is not None:
            b.values = CG.map_multi(b.values, conv)

    nerr = sum(1 for b in blocks.values() if b.kind == "error")
    entry, body, sr = ST.structure(entry, blocks, own)
    body = ST.cleanup(body)
    body = IDI.drop_blank_branches(body)
    body = IDI.and_or(body)
    body = IDI.fold_single_use(body)
    body = IDI.while_cond(body)
    body = IDI.strip_trailing_continue(body)
    body = IDI.conditions(body)
    body = IDI.while_cond(body)     # (again: `conditions` joins nested ifs into one `and` test)
    body = IDI.strip_trailing_continue(body)
    body = IDI.loop_vars(body)
    body = IDI.strip_trailing_return(body)
    if getattr(D, "INLINE_CONST_LOCALS", False):
        body = IDI.inline_const_locals(body)
        body = IDI.fold_single_use(body)    # (literals no longer stand between a temp and its use)
    body = VR.declare(body, (), own)
    body = VR.limit_locals(body)
    params = VR.extract_params(body)
    rend = CG.Renderer(names)
    return rend.block(body, ""), params, nerr, sr.fallbacks


#: 原始脚本的 chunk 本来就有 `...`；提升器还会多写一句 `local ... = ...`，
#: 那是非法 Luau。直接把这种声明行丢掉（丢掉了语义一样，因为 chunk 自带 ...）。
BOGUS_LOCAL_VARARG = re.compile(r"^[\t ]*local[\t ]+\.\.\.[\t ]*=[\t ]*\.\.\.[\t ]*$", re.M)

#: Luraph 的寄存器帧被当成函数调用（`Q(...)`，LPH_NO_VIRTUALIZE 的原生片段里
#: 常见）：帧的内容无法从 dump 复原，上游渲染成 `nil --[[ the caller's registers ]](...)`，
#: 那是非法语法。这里换成一个明确的桩函数，保证整份文件能通过语法检查。
FRAME_CALL = "nil --[[ the caller's registers ]](nil, nil)"
FRAME_STUB_NAME = "luraph_frame"
FRAME_STUB = (
    "-- Luraph 把寄存器帧当函数来调（原生片段的一种取寄存器方式）；\n"
    "-- 帧内容无法从运行时 dump 里复原，这里用安全桩占位，保证语法正确。\n"
    "local function " + FRAME_STUB_NAME + "(...)\n"
    "\treturn nil\n"
    "end\n\n"
)


#: 纯标量的表项行：`[12] = 34,` / `[5] = "gsub",` 这种。整段整段出现时就是
#: VM 的常量表（obfuscator 的内部数据），对读代码没帮助，只会把文件撑到几万行。
SCALAR_ENTRY = re.compile(
    r"^[\t ]*\[[^\]\n]{1,48}\][\t ]*=[\t ]*(-?\d+(?:\.\d+)?|\"[^\"\n]*\"|'[^'\n]*'"
    r"|true|false|nil),?[\t ]*$")
COLLAPSE_MIN = int(os.environ.get("DEVIRT_COLLAPSE_MIN", "60"))


#: 一个表字面量的开头：`[12] = {` / `local x = {` / `x = {`
TABLE_OPEN = re.compile(r"^[\t ]*(?:\[[^\]\n]{1,48}\][\t ]*=[\t ]*|(?:local[\t ]+)?"
                        r"[A-Za-z_][\w]*[\t ]*=[\t ]*|return[\t ]+)?\{[\t ]*$")
#: 数据块内部允许出现的行：标量表项、子表开头/结尾、空行
DATA_INNER = re.compile(r"^[\t ]*(?:\[[^\]\n]{1,48}\][\t ]*=[\t ]*.*"
                        r"|(?:local[\t ]+)?[A-Za-z_][\w]*[\t ]*=[\t ]*.*"
                        r"|\}?[\t ]*,?[\t ]*)$")
_STRINGS = re.compile(r'"(?:\\.|[^"\\\n])*"|\'(?:\\.|[^\'\\\n])*\'')


def _brace_delta(line):
    """这一行的花括号净增量（先去掉字符串字面量，避免误判）。"""
    stripped = _STRINGS.sub("", line)
    return stripped.count("{") - stripped.count("}")


def collapse_tables(text, min_run=None):
    """把整整一块 VM 常量表折成一行注释。

    只折叠「整块都是数据」的表字面量（标量表项/子表，没有一行代码），
    所以脚本自己的表、以及任何混着代码的表都不会被动到。
    """
    if os.environ.get("DEVIRT_NO_COLLAPSE"):
        return text
    min_run = COLLAPSE_MIN if min_run is None else min_run
    lines = text.split("\n")
    out, i, folded, folded_lines = [], 0, 0, 0
    while i < len(lines):
        line = lines[i]
        if TABLE_OPEN.match(line):
            depth, j, inner_ok, inner_n = 0, i, True, 0
            while j < len(lines):
                if j > i and not DATA_INNER.match(lines[j]):
                    inner_ok = False
                    break
                depth += _brace_delta(lines[j])
                if j > i:
                    inner_n += 1
                if depth <= 0:
                    break
                j += 1
            if inner_ok and depth <= 0 and inner_n >= min_run:
                indent = line[: len(line) - len(line.lstrip())]
                head = line.rstrip().rstrip("{").rstrip()          # `[5] =` / `local x =`
                close = lines[j].rstrip()
                tail = close[close.rfind("}") + 1:]                # 后面可能还有 `,`
                out.append("%s%s { --[[ 已折叠 %d 行数据表（VM 常量表，读代码用不上；"
                           "完整版见同名 .full.lua） ]] }%s"
                           % (indent, head, inner_n, tail))
                folded += 1
                folded_lines += inner_n
                i = j + 1
                continue
        out.append(line)
        i += 1
    if folded:
        print("[*] 折叠数据表：%d 块 / %d 行" % (folded, folded_lines), file=sys.stderr)
    return "\n".join(out)


def fix_frame_calls(text):
    """把「调用寄存器帧」渲染成桩调用，并补上桩的声明（幂等）。"""
    if FRAME_CALL not in text:
        return text
    text = text.replace(FRAME_CALL, FRAME_STUB_NAME + "(nil, nil)")
    if FRAME_STUB_NAME + "(nil, nil)" in text and "function " + FRAME_STUB_NAME not in text:
        text = FRAME_STUB + text
    return text


def polish(text):
    """Whole-program text passes: local names from use (names.py, unless
    DEVIRT_NO_NAMES), `local function` (localfuncs.py). Each is skipped
    with a warning if it fails."""
    import codegen
    text = text.replace(codegen.LONG_NL, "\n")     # long strings' newlines, kept out of re-indenting
    text = BOGUS_LOCAL_VARARG.sub("", text)       # `local ... = ...`：非法，且本来就不需要
    text = fix_frame_calls(text)                  # 帧调用桩：语法得先修好，
    global LAST_FULL_TEXT                         # 不然后面的重命名/`local function`
    LAST_FULL_TEXT = text                         # 两遍都会因为解析失败被跳过
    text = collapse_tables(text)
    if not os.environ.get("DEVIRT_NO_NAMES"):
        import names
        try:
            text = names.rename_text(text)
        except Exception as ex:  # noqa: BLE001 - keep the register names
            print("[!] naming pass failed: %s" % ex, file=sys.stderr)
    import localfuncs
    try:
        text = localfuncs.rewrite(text)
    except Exception as ex:  # noqa: BLE001
        print("[!] local function pass failed: %s" % ex, file=sys.stderr)
    return text


#: collapse_tables 之前的全文（含全部 VM 数据表），cli 写 <输出>.full.lua 用
LAST_FULL_TEXT = ""


def finish_text(text):
    """Blank lines between blocks (only for the final output, not every round)."""
    import spacing
    return spacing.space(text)


def run_big_stack(fn, *a):
    """Deeply nested scripts need deep recursion: run in a thread with a big stack."""
    sys.setrecursionlimit(200000)
    threading.stack_size(256 * 1024 * 1024 - 4096)
    res = {}

    def target():
        try:
            res["v"] = fn(*a)
        except BaseException as ex:  # noqa: BLE001
            res["e"] = ex
    t = threading.Thread(target=target)
    t.start()
    t.join()
    if "e" in res:
        raise res["e"]
    return res.get("v")
