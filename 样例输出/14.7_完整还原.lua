-- deobf by https://discord.gg/ck3k7nAVS

-- [best effort] the strict pass produced nothing usable for this sample,
-- so this is the partial lift: the walk stopped at the first VM state it
-- could not follow (see the devirt: error() calls in the body).  Everything
-- above the first such marker was recovered normally.
-- Set DEVIRT_V14_STRICT_ONLY=1 to get the strict behaviour back.

-- unresolved Luraph runtime helper; preserved as a safe stub

local function luraph_runtime1(...)
	return nil
end

-- unresolved Luraph runtime helper; preserved as a safe stub
local function luraph_runtime2(...)
	return nil
end

-- unresolved Luraph runtime helper; preserved as a safe stub
local function luraph_runtime3(...)
	return nil
end

local ... = ...
luraph_runtime1(...)
local r1 = Enum
local r3 = game
local r6 = string
local r7 = Instance
local r8 = BrickColor
local r10 = loadstring
local r11 = type
local r12 = ColorSequence
local r13 = CFrame
local r15 = gethwid
local r16 = UDim2
local r17 = RaycastParams
local r18 = ColorSequenceKeypoint
local r19 = UDim
local r20 = ipairs
local r21 = pcall
local r22 = table
local r25 = os
local r26 = Vector3
local r29 = task
local r30 = Color3
local r31 = Vector2
local r33 = math
local r34 = tostring
local r35 = r29 and r29.wait
local r36 = r16 and r16.fromOffset
local r37 = r7 and r7.new
local r38 = r30 and r30.new
local r39 = r1 and r1.ApplyStrokeMode
local r40 = r12 and r12.new
local r41 = r18 and r18.new
local r42 = r30 and r30.fromRGB
if r31 then
end
if r29 then
end
local r45 = r19 and r19.new
if r30 then
end
if r25 then
end
if r13 then
end
if r13 then
end
if r1 then
end
if r16 then
end
if r22 then
end
if r26 then
end
if r17 then
end
if r1 then
end
if r33 then
end
if r33 then
end
if r33 then
end
if r33 then
end
if r6 then
end
if r22 then
end
if r33 then
end
if r22 then
end
if r6 then
end
if r1 then
end
if r8 then
end
if r1 then
end
if r1 then
end
if r33 then
end
if r33 then
end
local r72 = r3
local r71 = r3.GetService
local r71_1
if nil --[[ the caller's registers ]](nil, nil) > 73 then
	local t904_126_2 = table.pack(r71(r72, nil))
	r71_1 = t904_126_2[1]
	nil --[[ the caller's registers ]](nil, nil)
else
	local t904_126_2 = table.pack(r71(r72, nil))
	r71_1 = t904_126_2[1]
	nil --[[ the caller's registers ]](nil, nil)
end
local r73 = r3
local r72_1 = r3.GetService
local r74 = "StarterGui"
if nil --[[ the caller's registers ]](nil, nil) > 74 then
	local t907_129_2 = table.pack(r72_1(r73, r74))
	nil --[[ the caller's registers ]](nil, nil)
else
	local t907_129_2 = table.pack(r72_1(r73, r74))
	nil --[[ the caller's registers ]](nil, nil)
end
local r74_1 = r3
local r73_1 = r3.GetService
local r75 = "HttpService"
if nil --[[ the caller's registers ]](nil, nil) > 75 then
	local t943_133_2 = table.pack(r73_1(r74_1, r75))
	nil --[[ the caller's registers ]](nil, nil)
else
	local t943_133_2 = table.pack(r73_1(r74_1, r75))
	nil --[[ the caller's registers ]](nil, nil)
end
local r74_2 = r71_1.LocalPlayer
local r75_1 = r15
local r75_2
if nil --[[ the caller's registers ]](nil, nil) > 75 then
	local t797_138_2 = table.pack(r75_1())
	r75_2 = t797_138_2[1]
	nil --[[ the caller's registers ]](nil, nil)
else
	local t797_138_2 = table.pack(r75_1())
	r75_2 = t797_138_2[1]
	nil --[[ the caller's registers ]](nil, nil)
end
r75_2 = r75_2 or "unknown"
local r77 = function(arg1)
	local s4 = upv0.SetCore
	local s7 = {}
	local s8 = arg1
	if s8 then
		s7.Title = s8
		s7.Text = s8
	end
	s7.Duration = s8
	if not (nil --[[ the caller's registers ]](nil, nil) > 7) then
		local t60_34_2 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 5, 7))
		s4(table.unpack(t60_34_2, 1, t60_34_2.n))
		nil --[[ the caller's registers ]](nil, nil)
	else
		local t60_34_2 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 5, 7))
		s4(table.unpack(t60_34_2, 1, t60_34_2.n))
		nil --[[ the caller's registers ]](nil, nil)
	end
end
local r78 = luraph_runtime2({
	[1] = {
		[1] = 100,
		[10] = 14,
		[100] = 76,
		[101] = 3,
		[102] = 0,
		[103] = 13,
		[105] = 1,
		[106] = 77,
		[107] = 74,
		[11] = 14,
		[12] = 13,
		[14] = 6,
		[15] = 74,
		[16] = 1,
		[17] = 0,
		[18] = 0,
		[19] = 23,
		[2] = 9,
		[20] = 0,
		[24] = 16,
		[25] = 94,
		[26] = 145,
		[27] = 225,
		[28] = 79,
		[29] = 97,
		[3] = 82,
		[30] = 0,
		[31] = 0,
		[34] = 16,
		[35] = 5,
		[36] = 42,
		[37] = 119,
		[38] = 31,
		[39] = 101,
		[4] = 97,
		[42] = 4,
		[43] = 96,
		[44] = 41,
		[45] = 2,
		[46] = 95,
		[47] = 221,
		[48] = 175,
		[49] = 173,
		[5] = 101,
		[50] = 221,
		[51] = 15,
		[52] = 4,
		[53] = 2,
		[54] = 2,
		[55] = 39,
		[57] = 0,
		[58] = 51,
		[59] = 0,
		[6] = 2,
		[60] = 0,
		[61] = 18,
		[62] = 23,
		[69] = 16,
		[70] = 188,
		[71] = 70,
		[72] = 21,
		[73] = 6,
		[74] = 51,
		[75] = 5,
		[76] = 81,
		[77] = 106,
		[78] = 78,
		[79] = 1366,
		[80] = 1,
		[81] = 120,
		[82] = 55,
		[84] = 9,
		[85] = 4,
		[86] = 202,
		[87] = 76,
		[88] = 2,
		[89] = 59,
		[9] = 84,
		[90] = 106,
		[91] = 221,
		[92] = 227,
		[93] = 6,
		[94] = 2,
		[97] = 57,
		[98] = 0,
		[99] = 55,
	},
	[10] = {
		[0] = {
			[1] = 0,
			[100] = 0,
			[101] = 0,
			[102] = 0,
			[103] = 0,
			[105] = 14,
			[106] = 0,
			[107] = 0,
			[12] = 14,
			[13] = 9,
			[14] = 15,
			[15] = 0,
			[16] = 2,
			[17] = 0,
			[18] = 0,
			[19] = 0,
			[2] = 14,
			[20] = 0,
			[21] = 23,
			[22] = 17,
			[23] = 19,
			[24] = 23,
			[25] = 216,
			[26] = 110,
			[27] = 236,
			[28] = 234,
			[29] = 0,
			[3] = 0,
			[30] = 0,
			[31] = 0,
			[32] = 17,
			[33] = 19,
			[34] = 23,
			[35] = 58,
			[36] = 75,
			[37] = 65,
			[38] = 165,
			[39] = 0,
			[4] = 0,
			[40] = 0,
			[41] = 0,
			[42] = 2,
			[43] = 75,
			[44] = 1,
			[45] = 32,
			[46] = 19,
			[47] = 218,
			[48] = 63,
			[49] = 152,
			[5] = 0,
			[50] = 186,
			[51] = 0,
			[52] = 2,
			[53] = 1,
			[55] = 0,
			[56] = 0,
			[57] = 0,
			[58] = 0,
			[59] = 0,
			[60] = 0,
			[61] = 0,
			[62] = 0,
			[63] = 23,
			[64] = 17,
			[65] = 19,
			[66] = 18,
			[67] = 23,
			[68] = 19,
			[69] = 23,
			[7] = 0,
			[70] = 229,
			[71] = 85,
			[72] = 114,
			[73] = 49,
			[74] = 0,
			[75] = 1,
			[76] = 0,
			[77] = 0,
			[78] = 0,
			[79] = 0,
			[8] = 0,
			[80] = 0,
			[81] = 407,
			[82] = 0,
			[83] = 0,
			[84] = 0,
			[85] = 2,
			[86] = 22,
			[87] = 1,
			[88] = 152,
			[89] = 114,
			[9] = 0,
			[90] = 61,
			[91] = 61,
			[92] = 228,
			[93] = 179,
			[95] = 0,
			[96] = 0,
			[97] = 0,
			[98] = 1,
			[99] = 1,
		},
		[10] = 2203,
		[104] = 335,
		[11] = -2020,
		[54] = "gsub",
		[6] = "gsub",
		[94] = "gsub",
	},
	[11] = {
		[1] = 241,
		[10] = 254,
		[100] = 241,
		[101] = 241,
		[102] = 239,
		[103] = 151,
		[104] = 212,
		[105] = 156,
		[106] = 241,
		[107] = 241,
		[11] = 149,
		[12] = 165,
		[13] = 38,
		[14] = 140,
		[15] = 241,
		[16] = 207,
		[17] = 53,
		[18] = 37,
		[19] = 151,
		[2] = 123,
		[20] = 239,
		[21] = 38,
		[22] = 38,
		[23] = 38,
		[24] = 265,
		[25] = 61,
		[26] = 229,
		[27] = 218,
		[28] = 117,
		[29] = 241,
		[3] = 241,
		[30] = 239,
		[31] = 37,
		[32] = 38,
		[33] = 38,
		[34] = 265,
		[35] = 61,
		[36] = 229,
		[37] = 218,
		[38] = 117,
		[39] = 241,
		[4] = 241,
		[40] = 145,
		[41] = 145,
		[42] = 116,
		[43] = 73,
		[44] = 49,
		[45] = 52,
		[46] = 250,
		[47] = 61,
		[48] = 229,
		[49] = 218,
		[5] = 241,
		[50] = 117,
		[51] = 241,
		[52] = 116,
		[53] = 207,
		[54] = 144,
		[55] = 241,
		[56] = 145,
		[57] = 53,
		[58] = 241,
		[59] = 37,
		[6] = 144,
		[60] = 239,
		[61] = 121,
		[62] = 151,
		[63] = 38,
		[64] = 38,
		[65] = 38,
		[66] = 38,
		[67] = 38,
		[68] = 38,
		[69] = 265,
		[7] = 145,
		[70] = 61,
		[71] = 229,
		[72] = 218,
		[73] = 117,
		[74] = 241,
		[75] = 161,
		[76] = 241,
		[77] = 241,
		[78] = 241,
		[79] = 145,
		[8] = 145,
		[80] = 241,
		[81] = 196,
		[82] = 241,
		[83] = 145,
		[84] = 241,
		[85] = 116,
		[86] = 73,
		[87] = 49,
		[88] = 52,
		[89] = 250,
		[9] = 241,
		[90] = 61,
		[91] = 229,
		[92] = 218,
		[93] = 117,
		[94] = 144,
		[95] = 145,
		[96] = 145,
		[97] = 241,
		[98] = 227,
		[99] = 156,
	},
	[2] = {
		[1] = 0,
		[10] = 14,
		[100] = 0,
		[101] = 0,
		[102] = 9,
		[103] = 0,
		[104] = 14,
		[105] = 0,
		[106] = 0,
		[107] = 0,
		[11] = 14,
		[14] = 0,
		[15] = 0,
		[16] = 0,
		[17] = 2,
		[18] = 17,
		[19] = 0,
		[2] = 0,
		[20] = 19,
		[24] = 212,
		[25] = 208,
		[26] = 203,
		[27] = 108,
		[28] = 202,
		[29] = 0,
		[3] = 0,
		[30] = 19,
		[31] = 17,
		[34] = 249,
		[35] = 116,
		[36] = 99,
		[37] = 217,
		[38] = 241,
		[39] = 0,
		[4] = 0,
		[40] = 4,
		[41] = 5,
		[42] = 0,
		[43] = 87,
		[44] = 164,
		[45] = 254,
		[46] = 165,
		[47] = 254,
		[48] = 199,
		[49] = 155,
		[5] = 0,
		[50] = 208,
		[51] = 0,
		[52] = 0,
		[53] = 0,
		[54] = 1,
		[55] = 0,
		[56] = 2,
		[57] = 2,
		[58] = 0,
		[59] = 17,
		[6] = 1,
		[60] = 19,
		[61] = 0,
		[62] = 0,
		[69] = 168,
		[7] = 4,
		[70] = 18,
		[71] = 245,
		[72] = 101,
		[73] = 123,
		[74] = 0,
		[76] = 0,
		[77] = 0,
		[78] = 0,
		[79] = 14,
		[8] = 5,
		[80] = 0,
		[81] = 86,
		[82] = 0,
		[83] = 14,
		[84] = 0,
		[85] = 0,
		[86] = 98,
		[87] = 251,
		[88] = 63,
		[89] = 45,
		[9] = 0,
		[90] = 207,
		[91] = 167,
		[92] = 147,
		[93] = 228,
		[94] = 1,
		[95] = 4,
		[96] = 5,
		[97] = 0,
		[98] = 0,
		[99] = 0,
	},
	[3] = {
		[0] = {
			[1] = 0,
			[10] = 14,
			[100] = 0,
			[101] = 0,
			[102] = 9,
			[103] = 0,
			[104] = 14,
			[105] = 0,
			[106] = 0,
			[107] = 0,
			[11] = 14,
			[14] = 0,
			[15] = 0,
			[16] = 0,
			[17] = 2,
			[18] = 17,
			[19] = 0,
			[2] = 0,
			[20] = 19,
			[24] = 212,
			[25] = 208,
			[26] = 203,
			[27] = 108,
			[28] = 202,
			[29] = 0,
			[3] = 0,
			[30] = 19,
			[31] = 17,
			[34] = 249,
			[35] = 116,
			[36] = 99,
			[37] = 217,
			[38] = 241,
			[39] = 0,
			[4] = 0,
			[40] = 4,
			[41] = 5,
			[42] = 0,
			[43] = 87,
			[44] = 164,
			[45] = 254,
			[46] = 165,
			[47] = 254,
			[48] = 199,
			[49] = 155,
			[5] = 0,
			[50] = 208,
			[51] = 0,
			[52] = 0,
			[53] = 0,
			[54] = 1,
			[55] = 0,
			[56] = 2,
			[57] = 2,
			[58] = 0,
			[59] = 17,
			[6] = 1,
			[60] = 19,
			[61] = 0,
			[62] = 0,
			[69] = 168,
			[7] = 4,
			[70] = 18,
			[71] = 245,
			[72] = 101,
			[73] = 123,
			[74] = 0,
			[76] = 0,
			[77] = 0,
			[78] = 0,
			[79] = 14,
			[8] = 5,
			[80] = 0,
			[81] = 86,
			[82] = 0,
			[83] = 14,
			[84] = 0,
			[85] = 0,
			[86] = 98,
			[87] = 251,
			[88] = 63,
			[89] = 45,
			[9] = 0,
			[90] = 207,
			[91] = 167,
			[92] = 147,
			[93] = 228,
			[94] = 1,
			[95] = 4,
			[96] = 5,
			[97] = 0,
			[98] = 0,
			[99] = 0,
		},
		[12] = 9,
		[13] = 74,
		[21] = 156,
		[22] = 14,
		[23] = 97,
		[32] = 0,
		[33] = 101,
		[63] = 116,
		[64] = 0,
		[65] = 4,
		[66] = 0,
		[67] = 116,
		[68] = 51,
		[75] = "",
	},
	[5] = {
		[0] = {
			[1] = 100,
			[10] = 14,
			[100] = 76,
			[101] = 3,
			[102] = 0,
			[103] = 13,
			[105] = 1,
			[106] = 77,
			[107] = 74,
			[11] = 14,
			[12] = 13,
			[14] = 6,
			[15] = 74,
			[16] = 1,
			[17] = 0,
			[18] = 0,
			[19] = 23,
			[2] = 9,
			[20] = 0,
			[24] = 16,
			[25] = 94,
			[26] = 145,
			[27] = 225,
			[28] = 79,
			[29] = 97,
			[3] = 82,
			[30] = 0,
			[31] = 0,
			[34] = 16,
			[35] = 5,
			[36] = 42,
			[37] = 119,
			[38] = 31,
			[39] = 101,
			[4] = 97,
			[42] = 4,
			[43] = 96,
			[44] = 41,
			[45] = 2,
			[46] = 95,
			[47] = 221,
			[48] = 175,
			[49] = 173,
			[5] = 101,
			[50] = 221,
			[51] = 15,
			[52] = 4,
			[53] = 2,
			[54] = 2,
			[55] = 39,
			[57] = 0,
			[58] = 51,
			[59] = 0,
			[6] = 2,
			[60] = 0,
			[61] = 18,
			[62] = 23,
			[69] = 16,
			[70] = 188,
			[71] = 70,
			[72] = 21,
			[73] = 6,
			[74] = 51,
			[75] = 5,
			[76] = 81,
			[77] = 106,
			[78] = 78,
			[79] = 1366,
			[80] = 1,
			[81] = 120,
			[82] = 55,
			[84] = 9,
			[85] = 4,
			[86] = 202,
			[87] = 76,
			[88] = 2,
			[89] = 59,
			[9] = 84,
			[90] = 106,
			[91] = 221,
			[92] = 227,
			[93] = 6,
			[94] = 2,
			[97] = 57,
			[98] = 0,
			[99] = 55,
		},
		[104] = 506,
		[13] = 107,
		[21] = 105,
		[22] = 104,
		[23] = 4,
		[32] = 14,
		[33] = 5,
		[40] = ",(%s*[%]%}])",
		[41] = "%1",
		[56] = "",
		[63] = 52,
		[64] = 52,
		[65] = 52,
		[66] = 41,
		[67] = 42,
		[68] = 58,
		[7] = "^\u{FEFF}",
		[8] = "",
		[83] = 58,
		[95] = "%s*%-%-[^\n\r]*",
		[96] = "",
	},
	[6] = {
		[1] = 0,
		[100] = 0,
		[101] = 0,
		[102] = 0,
		[103] = 0,
		[105] = 14,
		[106] = 0,
		[107] = 0,
		[12] = 14,
		[13] = 9,
		[14] = 15,
		[15] = 0,
		[16] = 2,
		[17] = 0,
		[18] = 0,
		[19] = 0,
		[2] = 14,
		[20] = 0,
		[21] = 23,
		[22] = 17,
		[23] = 19,
		[24] = 23,
		[25] = 216,
		[26] = 110,
		[27] = 236,
		[28] = 234,
		[29] = 0,
		[3] = 0,
		[30] = 0,
		[31] = 0,
		[32] = 17,
		[33] = 19,
		[34] = 23,
		[35] = 58,
		[36] = 75,
		[37] = 65,
		[38] = 165,
		[39] = 0,
		[4] = 0,
		[40] = 0,
		[41] = 0,
		[42] = 2,
		[43] = 75,
		[44] = 1,
		[45] = 32,
		[46] = 19,
		[47] = 218,
		[48] = 63,
		[49] = 152,
		[5] = 0,
		[50] = 186,
		[51] = 0,
		[52] = 2,
		[53] = 1,
		[55] = 0,
		[56] = 0,
		[57] = 0,
		[58] = 0,
		[59] = 0,
		[60] = 0,
		[61] = 0,
		[62] = 0,
		[63] = 23,
		[64] = 17,
		[65] = 19,
		[66] = 18,
		[67] = 23,
		[68] = 19,
		[69] = 23,
		[7] = 0,
		[70] = 229,
		[71] = 85,
		[72] = 114,
		[73] = 49,
		[74] = 0,
		[75] = 1,
		[76] = 0,
		[77] = 0,
		[78] = 0,
		[79] = 0,
		[8] = 0,
		[80] = 0,
		[81] = 407,
		[82] = 0,
		[83] = 0,
		[84] = 0,
		[85] = 2,
		[86] = 22,
		[87] = 1,
		[88] = 152,
		[89] = 114,
		[9] = 0,
		[90] = 61,
		[91] = 61,
		[92] = 228,
		[93] = 179,
		[95] = 0,
		[96] = 0,
		[97] = 0,
		[98] = 1,
		[99] = 1,
	},
	[7] = {},
	[8] = 0,
	[9] = 24,
}, false)
local r79 = nil
local r80 = r21
local r81 = function()
	local s2 = upv1
	local s1 = upv1.HttpGet
	local s3 = "https://raw.githubusercontent.com/GKye9178/okokok91787891kkk/refs/heads/main/gk%E8%8E%B7%E5%8F%96%E7%99%BD%E5%90%8D%E5%8D%95.lua"
	local s1_1
	if nil --[[ the caller's registers ]](nil, nil) > 3 then
		local t25_7_2 = table.pack(s1(s2, s3))
		s1_1 = t25_7_2[1]
		nil --[[ the caller's registers ]](nil, nil)
	else
		local t25_7_2 = table.pack(s1(s2, s3))
		s1_1 = t25_7_2[1]
		nil --[[ the caller's registers ]](nil, nil)
	end
	upv0 = s1_1
end
local r80_1
if not (nil --[[ the caller's registers ]](nil, nil) > 81) then
	local t1134_146_2 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 81, 81))
	local t1134_146_3 = table.pack(r80(table.unpack(t1134_146_2, 1, t1134_146_2.n)))
	local t1134_146_4 = table.pack(luraph_runtime1(table.unpack(t1134_146_3, 1, t1134_146_3.n)))
	r80_1 = (t1134_146_4[2])[1]
	nil --[[ the caller's registers ]](nil, nil)
else
	local t1134_146_2 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 81, 81))
	local t1134_146_3 = table.pack(r80(table.unpack(t1134_146_2, 1, t1134_146_2.n)))
	local t1134_146_4 = table.pack(luraph_runtime1(table.unpack(t1134_146_3, 1, t1134_146_3.n)))
	r80_1 = (t1134_146_4[2])[1]
	nil --[[ the caller's registers ]](nil, nil)
end
if r80_1 then
	local r82 = r78
	local r83 = r79
	if nil --[[ the caller's registers ]](nil, nil) > 83 then
		local t676_150_2 = table.pack(r82(r83))
		nil --[[ the caller's registers ]](nil, nil)
	else
		local t676_150_2 = table.pack(r82(r83))
		nil --[[ the caller's registers ]](nil, nil)
	end
	local r84 = r21
	local r85 = function()
		local s1 = upv0.JSONDecode
		if nil --[[ the caller's registers ]](nil, nil) > 3 then
			local t2_6_2 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 2, 3))
			local t2_6_3 = table.pack(s1(table.unpack(t2_6_2, 1, t2_6_2.n)))
			return table.unpack(t2_6_3, 1, t2_6_3.n)
		end
		local t2_6_2 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 2, 3))
		local t2_6_3 = table.pack(s1(table.unpack(t2_6_2, 1, t2_6_2.n)))
		return table.unpack(t2_6_3, 1, t2_6_3.n)
	end
	local r84_1, r85_1
	if not (nil --[[ the caller's registers ]](nil, nil) > 85) then
		local t22_155_2 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 85, 85))
		local t22_155_3 = table.pack(r84(table.unpack(t22_155_2, 1, t22_155_2.n)))
		local t22_155_4 = table.pack(luraph_runtime1(table.unpack(t22_155_3, 1, t22_155_3.n)))
		r84_1 = (t22_155_4[2])[1]
		r85_1 = (t22_155_4[2])[2]
		nil --[[ the caller's registers ]](nil, nil)
	else
		local t22_155_2 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 85, 85))
		local t22_155_3 = table.pack(r84(table.unpack(t22_155_2, 1, t22_155_2.n)))
		local t22_155_4 = table.pack(luraph_runtime1(table.unpack(t22_155_3, 1, t22_155_3.n)))
		r84_1 = (t22_155_4[2])[1]
		r85_1 = (t22_155_4[2])[2]
		nil --[[ the caller's registers ]](nil, nil)
	end
	if r84_1 then
		local r86_3 = r11
		local r87_2 = r85_1
		local r86_4
		if nil --[[ the caller's registers ]](nil, nil) > 87 then
			local t418_175_2 = table.pack(r86_3(r87_2))
			r86_4 = t418_175_2[1]
			nil --[[ the caller's registers ]](nil, nil)
		else
			local t418_175_2 = table.pack(r86_3(r87_2))
			r86_4 = t418_175_2[1]
			nil --[[ the caller's registers ]](nil, nil)
		end
		if r86_4 == "table" then
			local r83_1 = r85_1
			if not (r83_1.mode == false) then
				local r87_3 = r83_1.devices or {}
				local r88_1 = false
				local r89 = r20
				local r89_1, r90
				if not (nil --[[ the caller's registers ]](nil, nil) > 90) then
					local t401_188_2 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 90, 90))
					local t401_188_3 = table.pack(r89(table.unpack(t401_188_2, 1, t401_188_2.n)))
					local t401_188_4 = table.pack(luraph_runtime1(table.unpack(t401_188_3, 1, t401_188_3.n)))
					r89_1 = (t401_188_4[2])[1]
					r90 = (t401_188_4[2])[2]
					nil --[[ the caller's registers ]](nil, nil)
				else
					local t401_188_2 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 90, 90))
					local t401_188_3 = table.pack(r89(table.unpack(t401_188_2, 1, t401_188_2.n)))
					local t401_188_4 = table.pack(luraph_runtime1(table.unpack(t401_188_3, 1, t401_188_3.n)))
					r89_1 = (t401_188_4[2])[1]
					r90 = (t401_188_4[2])[2]
					nil --[[ the caller's registers ]](nil, nil)
				end
				nil --[[ the caller's registers ]](nil, nil)
				while true do
					local t745_190_1 = table.pack(o_1())
					if not t745_190_1[1] then
						break
					else
						r90 = t745_190_1[2]
						local r92 = r34
						local r93 = t745_190_1[3]
						local r92_4
						if nil --[[ the caller's registers ]](nil, nil) > 93 then
							local t803_306_2 = table.pack(r92(r93))
							r92_4 = t803_306_2[1]
							nil --[[ the caller's registers ]](nil, nil)
						else
							local t803_306_2 = table.pack(r92(r93))
							r92_4 = t803_306_2[1]
							nil --[[ the caller's registers ]](nil, nil)
						end
						if r92_4 ~= "" then
							local r93_4 = r34
							local r94_1 = r75_2
							local r93_5
							if nil --[[ the caller's registers ]](nil, nil) > 94 then
								local t1119_311_2 = table.pack(r93_4(r94_1))
								r93_5 = t1119_311_2[1]
								nil --[[ the caller's registers ]](nil, nil)
							else
								local t1119_311_2 = table.pack(r93_4(r94_1))
								r93_5 = t1119_311_2[1]
								nil --[[ the caller's registers ]](nil, nil)
							end
							if r92_4 == r93_5 then
								r88_1 = true
								break
							end
						end
					end
				end
				if r88_1 then
					local r89_2 = r77
					if not (nil --[[ the caller's registers ]](nil, nil) > 92) then
						local t1149_214_2 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 90, 92))
						r89_2(table.unpack(t1149_214_2, 1, t1149_214_2.n))
						nil --[[ the caller's registers ]](nil, nil)
					else
						local t1149_214_2 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 90, 92))
						r89_2(table.unpack(t1149_214_2, 1, t1149_214_2.n))
						nil --[[ the caller's registers ]](nil, nil)
					end
					error("devirt: symbolic value of a VM local carried between instructions (<Bin {'op': 'Sub', 'a': <Bin {'op': 'Add', 'a': <TempVal {'t': '163_220_4', 'i': 1}>, 'b': <Const {'v': 88}>}>, 'b': <Const {'v': 1}>}>) (at 0:163)")
				end
				local r91 = r36
				local r92_1 = 400
				local r93_1 = 300
				local r91_1
				if nil --[[ the caller's registers ]](nil, nil) > 93 then
					local t1225_227_2 = table.pack(r91(r92_1, r93_1))
					r91_1 = t1225_227_2[1]
					nil --[[ the caller's registers ]](nil, nil)
				else
					local t1225_227_2 = table.pack(r91(r92_1, r93_1))
					r91_1 = t1225_227_2[1]
					nil --[[ the caller's registers ]](nil, nil)
				end
				r90.Size = r91_1
				r90.Background = "video:https://raw.githubusercontent.com/GKye9178/okokok91787891kkk/refs/heads/main/video_260713_173228.mp4"
				r90.Transparent = true
				r90.User = {
					Enabled = true,
					Callback = luraph_runtime2({
						[1] = {
							[1] = 23,
							[10] = 164,
							[11] = 12,
							[12] = 22,
							[13] = 0,
							[14] = 10,
							[15] = 11,
							[16] = 11,
							[17] = 11,
							[18] = 10,
							[19] = 51,
							[2] = 15,
							[20] = 3,
							[21] = 24,
							[22] = 428,
							[23] = 1,
							[24] = 11,
							[25] = 1,
							[26] = 792,
							[27] = 0,
							[28] = 0,
							[3] = 0,
							[6] = 13,
							[7] = 29,
							[8] = 218,
							[9] = 190,
						},
						[10] = {
							[0] = {
								[1] = 0,
								[10] = 0,
								[11] = 0,
								[12] = 0,
								[13] = 0,
								[14] = 0,
								[15] = 623,
								[16] = 751,
								[17] = 746,
								[18] = 11,
								[19] = 6,
								[2] = 0,
								[20] = 247,
								[21] = 0,
								[22] = 126,
								[23] = 0,
								[24] = 0,
								[25] = 0,
								[26] = 0,
								[27] = 0,
								[28] = 1,
								[3] = 0,
								[4] = 15,
								[5] = 16,
								[6] = 20,
								[7] = 172,
								[8] = 17,
								[9] = 164,
							},
						},
						[11] = {
							[1] = 241,
							[10] = 117,
							[11] = 241,
							[12] = 241,
							[13] = 239,
							[14] = 151,
							[15] = 18,
							[16] = 254,
							[17] = 149,
							[18] = 165,
							[19] = 38,
							[2] = 121,
							[20] = 140,
							[21] = 241,
							[22] = 252,
							[23] = 241,
							[24] = 241,
							[25] = 98,
							[26] = 145,
							[27] = 138,
							[28] = 24,
							[3] = 239,
							[4] = 38,
							[5] = 38,
							[6] = 265,
							[7] = 61,
							[8] = 229,
							[9] = 218,
						},
						[2] = {
							[1] = 0,
							[10] = 241,
							[11] = 0,
							[12] = 0,
							[13] = 6,
							[14] = 0,
							[15] = 369,
							[16] = 11,
							[17] = 11,
							[18] = 94,
							[2] = 0,
							[20] = 0,
							[21] = 0,
							[22] = 367,
							[23] = 0,
							[24] = 0,
							[25] = 0,
							[26] = 2,
							[27] = 1,
							[28] = 0,
							[3] = 16,
							[4] = 51,
							[5] = 51,
							[6] = 117,
							[7] = 51,
							[8] = 55,
							[9] = 21,
						},
						[3] = {
							[0] = {
								[1] = 0,
								[10] = 241,
								[11] = 0,
								[12] = 0,
								[13] = 6,
								[14] = 0,
								[15] = 369,
								[16] = 11,
								[17] = 11,
								[18] = 94,
								[2] = 0,
								[20] = 0,
								[21] = 0,
								[22] = 367,
								[23] = 0,
								[24] = 0,
								[25] = 0,
								[26] = 2,
								[27] = 1,
								[28] = 0,
								[3] = 16,
								[4] = 51,
								[5] = 51,
								[6] = 117,
								[7] = 51,
								[8] = 55,
								[9] = 21,
							},
							[19] = 24,
						},
						[5] = {
							[0] = {
								[1] = 23,
								[10] = 164,
								[11] = 12,
								[12] = 22,
								[13] = 0,
								[14] = 10,
								[15] = 11,
								[16] = 11,
								[17] = 11,
								[18] = 10,
								[19] = 51,
								[2] = 15,
								[20] = 3,
								[21] = 24,
								[22] = 428,
								[23] = 1,
								[24] = 11,
								[25] = 1,
								[26] = 792,
								[27] = 0,
								[28] = 0,
								[3] = 0,
								[6] = 13,
								[7] = 29,
								[8] = 218,
								[9] = 190,
							},
							[4] = 20,
							[5] = 23,
						},
						[6] = {
							[1] = 0,
							[10] = 0,
							[11] = 0,
							[12] = 0,
							[13] = 0,
							[14] = 0,
							[15] = 623,
							[16] = 751,
							[17] = 746,
							[18] = 11,
							[19] = 6,
							[2] = 0,
							[20] = 247,
							[21] = 0,
							[22] = 126,
							[23] = 0,
							[24] = 0,
							[25] = 0,
							[26] = 0,
							[27] = 0,
							[28] = 1,
							[3] = 0,
							[4] = 15,
							[5] = 16,
							[6] = 20,
							[7] = 172,
							[8] = 17,
							[9] = 164,
						},
						[7] = { { 28, 1 } },
						[8] = 0,
						[9] = 21,
					}, {}),
					Anonymous = false,
				}
				r90.SideBarWidth = 200
				r90.ScrollBarEnabled = true
				local r88_2
				if nil --[[ the caller's registers ]](nil, nil) > 90 then
					local t154_242_2 = table.pack(r88_1(r89_1, r90))
					r88_2 = t154_242_2[1]
					nil --[[ the caller's registers ]](nil, nil)
				else
					local t154_242_2 = table.pack(r88_1(r89_1, r90))
					r88_2 = t154_242_2[1]
					nil --[[ the caller's registers ]](nil, nil)
				end
				if not r88_2.UIElements.Main then
					local r92_2 = { Title = "Bacon Head", Icon = "" }
					local r93_2 = r45
					local r94 = 0
					local r95 = 16
					local r93_3
					if nil --[[ the caller's registers ]](nil, nil) > 95 then
						local t1001_255_2 = table.pack(r93_2(r94, r95))
						r93_3 = t1001_255_2[1]
						nil --[[ the caller's registers ]](nil, nil)
					else
						local t1001_255_2 = table.pack(r93_2(r94, r95))
						r93_3 = t1001_255_2[1]
						nil --[[ the caller's registers ]](nil, nil)
					end
					r92_2.CornerRadius = r93_3
					r92_2.StrokeThickness = 2
					error("devirt: symbolic value of a VM local carried between instructions (<Bin {'op': 'Sub', 'a': <Bin {'op': 'Add', 'a': <TempVal {'t': '1584_267_4', 'i': 1}>, 'b': <Const {'v': 97}>}>, 'b': <Const {'v': 1}>}>) (at 0:1584)")
				end
				local r90_1 = r37
				local r91_2 = "UIStroke"
				local r90_2
				if nil --[[ the caller's registers ]](nil, nil) > 91 then
					local t682_272_2 = table.pack(r90_1(r91_2))
					r90_2 = t682_272_2[1]
					nil --[[ the caller's registers ]](nil, nil)
				else
					local t682_272_2 = table.pack(r90_1(r91_2))
					r90_2 = t682_272_2[1]
					nil --[[ the caller's registers ]](nil, nil)
				end
				r90_2.Name = "BaconStroke"
				r90_2.Thickness = 1.5
				local r91_3 = r38
				local r91_4
				if not (nil --[[ the caller's registers ]](nil, nil) > 94) then
					local t12_280_2 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 92, 94))
					local t12_280_3 = table.pack(r91_3(table.unpack(t12_280_2, 1, t12_280_2.n)))
					r91_4 = t12_280_3[1]
					nil --[[ the caller's registers ]](nil, nil)
				else
					local t12_280_2 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 92, 94))
					local t12_280_3 = table.pack(r91_3(table.unpack(t12_280_2, 1, t12_280_2.n)))
					r91_4 = t12_280_3[1]
					nil --[[ the caller's registers ]](nil, nil)
				end
				r90_2.Color = r91_4
				r90_2.ApplyStrokeMode = r39.Border
				local r91_5 = r37
				local r92_3 = "UIGradient"
				if nil --[[ the caller's registers ]](nil, nil) > 92 then
					local t448_288_2 = table.pack(r91_5(r92_3))
					nil --[[ the caller's registers ]](nil, nil)
				else
					local t448_288_2 = table.pack(r91_5(r92_3))
					nil --[[ the caller's registers ]](nil, nil)
				end
				error("devirt: symbolic value of a VM local carried between instructions (<Bin {'op': 'Sub', 'a': <Bin {'op': 'Add', 'a': <TempVal {'t': '1540_303_4', 'i': 1}>, 'b': <Const {'v': 96}>}>, 'b': <Const {'v': 1}>}>) (at 0:1540)")
			end
			local r87_4 = r77
			if not (nil --[[ the caller's registers ]](nil, nil) > 90) then
				local t1472_397_2 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 88, 90))
				r87_4(table.unpack(t1472_397_2, 1, t1472_397_2.n))
				nil --[[ the caller's registers ]](nil, nil)
			else
				local t1472_397_2 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 88, 90))
				r87_4(table.unpack(t1472_397_2, 1, t1472_397_2.n))
				nil --[[ the caller's registers ]](nil, nil)
			end
			error("devirt: symbolic value of a VM local carried between instructions (<Bin {'op': 'Sub', 'a': <Bin {'op': 'Add', 'a': <TempVal {'t': '163_403_4', 'i': 1}>, 'b': <Const {'v': 88}>}>, 'b': <Const {'v': 1}>}>) (at 0:163)")
		end
	end
	local r86 = r77
	if not (nil --[[ the caller's registers ]](nil, nil) > 89) then
		local t866_162_2 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 87, 89))
		r86(table.unpack(t866_162_2, 1, t866_162_2.n))
		nil --[[ the caller's registers ]](nil, nil)
	else
		local t866_162_2 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 87, 89))
		r86(table.unpack(t866_162_2, 1, t866_162_2.n))
		nil --[[ the caller's registers ]](nil, nil)
	end
	local r86_1 = r35
	local r87 = 1
	if not (nil --[[ the caller's registers ]](nil, nil) > 87) then
		r86_1(r87)
		nil --[[ the caller's registers ]](nil, nil)
	else
		r86_1(r87)
		nil --[[ the caller's registers ]](nil, nil)
	end
	local r87_1 = r74_2
	local r86_2 = r74_2.Kick
	local r88 = "❌ 数据解析失败"
	if not (nil --[[ the caller's registers ]](nil, nil) > 88) then
		r86_2(r87_1, r88)
		nil --[[ the caller's registers ]](nil, nil)
	else
		r86_2(r87_1, r88)
		nil --[[ the caller's registers ]](nil, nil)
	end
	return
end
local r82_1 = r77
if not (nil --[[ the caller's registers ]](nil, nil) > 85) then
	local t1646_411_2 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 83, 85))
	r82_1(table.unpack(t1646_411_2, 1, t1646_411_2.n))
	nil --[[ the caller's registers ]](nil, nil)
else
	local t1646_411_2 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 83, 85))
	r82_1(table.unpack(t1646_411_2, 1, t1646_411_2.n))
	nil --[[ the caller's registers ]](nil, nil)
end
local r82_2 = r35
local r83_2 = 1
if not (nil --[[ the caller's registers ]](nil, nil) > 83) then
	r82_2(r83_2)
	nil --[[ the caller's registers ]](nil, nil)
else
	r82_2(r83_2)
	nil --[[ the caller's registers ]](nil, nil)
end
local r83_3 = r74_2
local r82_3 = r74_2.Kick
local r84_2 = "❌ 网络错误，验证失败"
if not (nil --[[ the caller's registers ]](nil, nil) > 84) then
	r82_3(r83_3, r84_2)
	nil --[[ the caller's registers ]](nil, nil)
else
	r82_3(r83_3, r84_2)
	nil --[[ the caller's registers ]](nil, nil)
end
