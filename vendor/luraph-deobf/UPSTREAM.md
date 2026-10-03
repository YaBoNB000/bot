# Upstream source pin

The engine source under `Deobfuscator/deobf/` is copied from the upstream
repository below, without local edits to the engine code:

- Repository: https://github.com/KryptIT/luraph-v15-v14.x-deobfuscator
- Branch: `main`
- Commit: `ed79a86cc41187af0480e69f45a4838723fdb099` (2026-09-27)

The vendored runtime keeps the upstream Python/Luau source and the upstream
Windows executables in `bin/`. It omits `.git`, Python bytecode caches,
upstream scratch captures, a duplicate source snapshot placed under `bin/`,
and other temporary inputs/results.

The Discord bot and its process adapter are project-specific. The adapter
invokes the upstream v14 `cli.py` or `deob.py` frontend, supervises one process,
and records its log. For v14 it passes the upstream-supported `--trace-fallback`
flag so the same CLI invocation can write a behavior trace if static recovery
produces no source. It does not patch the engine, rewrite/watermark the Lua
output, retry through local recovery strategies, or generate local deep-capture
attachments. Discord delivery remains limited to the primary Lua output (or a
ZIP containing only that output when needed).

A direct call through the upstream frontend can still produce a behavior trace
or partial output for a sample. Copying the same pinned engine again does not
change its capabilities; output quality depends on the sample and upstream
engine behavior. Historical sample metrics and reports describe older project
adaptations and are not validation results for this direct-call path.
