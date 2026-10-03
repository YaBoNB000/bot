-- 部分反编译（来自深度捕获）：主结果里被跳过/加密、但这里能还原成真代码的部分
-- 引擎 Luraph v14.7；共 1 段，1 段单独通过语法检查
-- 说明：每段是一块独立代码，段与段之间可能不连贯（缺的那部分 VM 状态没解出来），
--       但里面的逻辑都是真的；需要完整源码请以主结果为准。


-- ============================================================
-- root proto #1　语法检查：通过　（这一段可以单独阅读）
-- ============================================================
luraph_runtime1(...)
return ({
	[34] = true,
	[127] = "IsStudio",
	[129] = "IsClient",
	[88] = "typeof",
	[163] = bit32.countrz,
	[9] = table,
	[119] = "Connected",
	[60] = "",
	[41] = type,
	[118] = "AttributeChanged",
	[82] = "rawget",
	[72] = "function",
	[36] = rawset,
	[67] = "short_src",
	[109] = "X",
	[166] = bit32.bnot,
	[5] = "format",
	[155] = "setconstant",
	[46] = xpcall,
	[57] = tostring,
	[2] = Vector3,
	[168] = "__index",
	[78] = "rawset",
	[132] = "Enums",
	[63] = "C",
	[112] = "string",
	[12] = task,
	[53] = Random,
	[162] = bit32.bor,
	[11] = "char",
	[80] = unpack,
	[110] = "Y",
	[156] = "setstack",
	[0] = function(...)
		-- unresolved native/runtime closure: refusing partial devirtualization: 1 unresolved VM state(s): 0:1538: symbolic generic for
		return nil
	end,
	[43] = debug,
	[35] = typeof,
	[47] = "info",
	[64] = "source",
	[42] = getmetatable,
	[44] = "The debug library is required on Luau platforms. Please open a support ticket.",
	[66] = "currentline",
	[146] = "WaitForChild",
	[120] = "Disconnect",
	[115] = "ClassName",
	[158] = "getupvalues",
	[70] = "linedefined",
	[20] = "defer",
	[154] = "getconstant",
	[10] = "byte",
	[55] = islclosure,
	[81] = "select",
	[17] = "sub",
	[13] = "concat",
	[103] = "Size",
	[22] = "close",
	[4] = "gmatch",
	[151] = "NextNumber",
	[75] = "getmetatable",
	[58] = "lastlinedefined",
	[59] = "namewhat",
	[98] = utf8.nfcnormalize,
	[8] = "find",
	[157] = "getstack",
	[19] = "isyieldable",
	[100] = utf8.nfdnormalize,
	[14] = coroutine,
	[126] = "RunService",
	[149] = "NextUnitVector",
	[71] = "new",
	[123] = "GetAsync",
	[48] = tonumber,
	[89] = "getinfo",
	[152] = "Shuffle",
	[117] = "Connect",
	[116] = "AncestryChanged",
	[153] = "Clone",
	[69] = "isvararg",
	[25] = "spawn",
	[73] = "slnaf",
	[159] = "getupvalue",
	[23] = "resume",
	[105] = "Frame",
	[106] = "Parent",
	[87] = "assert",
	[125] = "RequestAsync",
	[111] = "Name",
	[26] = rawget,
	[40] = assert,
	[164] = bit32.band,
	[18] = "gsub",
	[51] = Instance,
	[27] = "create",
	[104] = "ScreenGui",
	[56] = math,
	[148] = "Random",
	[61] = "nparams",
	[131] = Enum,
	[95] = Path2DControlPoint.new,
	[135] = "R6",
	[133] = "R15",
	[45] = "traceback",
	[3] = string,
	[33] = false,
	[138] = "EnumItem",
	[142] = "FromValue",
	[147] = "getconstants",
	[76] = "setmetatable",
	[121] = "The metatable is locked",
	[165] = bit32.rrotate,
	[79] = "xpcall",
	[85] = "next",
	[86] = "error",
	[92] = UDim.new,
	[130] = "StarterPlayer",
	[90] = "pack",
	[54] = "table",
	[122] = "HttpService",
	[28] = "running",
	[145] = "Folder",
	[99] = "졹탴뺋읏휌",
	[91] = "unpack",
	[32] = select,
	nil,
	[74] = "tonumber",
	[144] = "Workspace",
	[24] = "status",
	[38] = pcall,
	[31] = setmetatable,
	[108] = "Scale",
	[39] = "wait",
	[93] = game,
	[134] = "EnumType",
	[124] = "PostAsync",
	[114] = "Instance",
	[137] = "IsA",
	[161] = "sl",
	[113] = "userdata",
	[140] = "Enum",
	[65] = "=[C]",
	[136] = "HumanoidRigType",
	[167] = "setupvalue",
	[30] = "yield",
	[83] = "pcall",
	[160] = ":(%d+)[:\r\n]",
	[143] = "FromName",
	[94] = UDim2.new,
	[139] = "Value",
	[84] = "type",
	[77] = "tostring",
	[16] = "cancel",
	[102] = "Position",
	[107] = "Path2D",
	[7] = iscclosure,
	[101] = "뚈쌕챭넆먼욟런펺",
	[128] = "IsServer",
	[68] = "[C]",
	[6] = "match",
	[96] = workspace,
	[141] = "number",
	[150] = "NextInteger",
	[50] = "wrap",
	[37] = identifyexecutor,
	[29] = "rep",
	[15] = loadstring,
})[0]({
	[34] = true,
	[127] = "IsStudio",
	[129] = "IsClient",
	[88] = "typeof",
	[163] = bit32.countrz,
	[9] = table,
	[119] = "Connected",
	[60] = "",
	[41] = type,
	[118] = "AttributeChanged",
	[82] = "rawget",
	[72] = "function",
	[36] = rawset,
	[67] = "short_src",
	[109] = "X",
	[166] = bit32.bnot,
	[5] = "format",
	[155] = "setconstant",
	[46] = xpcall,
	[57] = tostring,
	[2] = Vector3,
	[168] = "__index",
	[78] = "rawset",
	[132] = "Enums",
	[63] = "C",
	[112] = "string",
	[12] = task,
	[53] = Random,
	[162] = bit32.bor,
	[11] = "char",
	[80] = unpack,
	[110] = "Y",
	[156] = "setstack",
	[0] = function(...)
		-- unresolved native/runtime closure: refusing partial devirtualization: 1 unresolved VM state(s): 0:1538: symbolic generic for
		return nil
	end,
	[43] = debug,
	[35] = typeof,
	[47] = "info",
	[64] = "source",
	[42] = getmetatable,
	[44] = "The debug library is required on Luau platforms. Please open a support ticket.",
	[66] = "currentline",
	[146] = "WaitForChild",
	[120] = "Disconnect",
	[115] = "ClassName",
	[158] = "getupvalues",
	[70] = "linedefined",
	[20] = "defer",
	[154] = "getconstant",
	[10] = "byte",
	[55] = islclosure,
	[81] = "select",
	[17] = "sub",
	[13] = "concat",
	[103] = "Size",
	[22] = "close",
	[4] = "gmatch",
	[151] = "NextNumber",
	[75] = "getmetatable",
	[58] = "lastlinedefined",
	[59] = "namewhat",
	[98] = utf8.nfcnormalize,
	[8] = "find",
	[157] = "getstack",
	[19] = "isyieldable",
	[100] = utf8.nfdnormalize,
	[14] = coroutine,
	[126] = "RunService",
	[149] = "NextUnitVector",
	[71] = "new",
	[123] = "GetAsync",
	[48] = tonumber,
	[89] = "getinfo",
	[152] = "Shuffle",
	[117] = "Connect",
	[116] = "AncestryChanged",
	[153] = "Clone",
	[69] = "isvararg",
	[25] = "spawn",
	[73] = "slnaf",
	[159] = "getupvalue",
	[23] = "resume",
	[105] = "Frame",
	[106] = "Parent",
	[87] = "assert",
	[125] = "RequestAsync",
	[111] = "Name",
	[26] = rawget,
	[40] = assert,
	[164] = bit32.band,
	[18] = "gsub",
	[51] = Instance,
	[27] = "create",
	[104] = "ScreenGui",
	[56] = math,
	[148] = "Random",
	[61] = "nparams",
	[131] = Enum,
	[95] = Path2DControlPoint.new,
	[135] = "R6",
	[133] = "R15",
	[45] = "traceback",
	[3] = string,
	[33] = false,
	[138] = "EnumItem",
	[142] = "FromValue",
	[147] = "getconstants",
	[76] = "setmetatable",
	[121] = "The metatable is locked",
	[165] = bit32.rrotate,
	[79] = "xpcall",
	[85] = "next",
	[86] = "error",
	[92] = UDim.new,
	[130] = "StarterPlayer",
	[90] = "pack",
	[54] = "table",
	[122] = "HttpService",
	[28] = "running",
	[145] = "Folder",
	[99] = "졹탴뺋읏휌",
	[91] = "unpack",
	[32] = select,
	nil,
	[74] = "tonumber",
	[144] = "Workspace",
	[24] = "status",
	[38] = pcall,
	[31] = setmetatable,
	[108] = "Scale",
	[39] = "wait",
	[93] = game,
	[134] = "EnumType",
	[124] = "PostAsync",
	[114] = "Instance",
	[137] = "IsA",
	[161] = "sl",
	[113] = "userdata",
	[140] = "Enum",
	[65] = "=[C]",
	[136] = "HumanoidRigType",
	[167] = "setupvalue",
	[30] = "yield",
	[83] = "pcall",
	[160] = ":(%d+)[:\r\n]",
	[143] = "FromName",
	[94] = UDim2.new,
	[139] = "Value",
	[84] = "type",
	[77] = "tostring",
	[16] = "cancel",
	[102] = "Position",
	[107] = "Path2D",
	[7] = iscclosure,
	[101] = "뚈쌕챭넆먼욟런펺",
	[128] = "IsServer",
	[68] = "[C]",
	[6] = "match",
	[96] = workspace,
	[141] = "number",
	[150] = "NextInteger",
	[50] = "wrap",
	[37] = identifyexecutor,
	[29] = "rep",
	[15] = loadstring,
})
-- stats {'functions': 2, 'errors': 0, 'fallbacks': 0, 'approx_carried': 0}, 0 constant requests

