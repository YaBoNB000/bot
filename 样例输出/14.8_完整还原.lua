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

local v = luraph_runtime2({
	[1] = {
		[1] = 5,
		[10] = 10,
		[11] = 0,
		[12] = 0,
		[13] = 1,
		[14] = 161,
		[2] = 0,
		[3] = 21,
		[4] = 0,
		[5] = 6,
		[6] = 1,
		[7] = 0,
		[8] = 0,
		[9] = 145,
	},
	[10] = {
		[1] = 0,
		[10] = 0,
		[11] = 3,
		[12] = 1,
		[13] = 0,
		[14] = 52,
		[2] = 1,
		[3] = 0,
		[4] = 0,
		[5] = 0,
		[6] = 0,
		[7] = 1,
		[8] = 2,
		[9] = 2,
	},
	[11] = 4,
	[2] = 0,
	[3] = {
		[1] = 0,
		[10] = 0,
		[12] = 0,
		[13] = 0,
		[14] = 493,
		[3] = 2,
		[4] = 1,
		[5] = 0,
		[6] = 0,
		[9] = 2,
	},
	[4] = {
		[0] = {
			[1] = 0,
			[10] = 0,
			[12] = 0,
			[13] = 0,
			[14] = 493,
			[3] = 2,
			[4] = 1,
			[5] = 0,
			[6] = 0,
			[9] = 2,
		},
		[11] = "game",
		[2] = "pcall",
		[7] = "pcall",
		[8] = "game",
	},
	[5] = {
		[0] = {
			[1] = 5,
			[10] = 10,
			[11] = 0,
			[12] = 0,
			[13] = 1,
			[14] = 161,
			[2] = 0,
			[3] = 21,
			[4] = 0,
			[5] = 6,
			[6] = 1,
			[7] = 0,
			[8] = 0,
			[9] = 145,
		},
		[3] = {
			[1] = { [1] = 7, [2] = 0, [5] = 1, [6] = 0, [7] = 1, [8] = 1, [9] = 289 },
			[10] = { 0, 1, 1, 1, 150, 0, 0, 0, 259 },
			[11] = 4,
			[2] = 0,
			[3] = { [1] = 0, [3] = 1, [4] = 1, [5] = 1, [6] = 1, [7] = 0, [8] = 0, [9] = 252 },
			[4] = {
				[0] = { [1] = 0, [3] = 1, [4] = 1, [5] = 1, [6] = 1, [7] = 0, [8] = 0, [9] = 252 },
				[2] = "game",
			},
			[5] = {
				[0] = { [1] = 7, [2] = 0, [5] = 1, [6] = 0, [7] = 1, [8] = 1, [9] = 289 },
				[3] = "Players",
				[4] = "LocalPlayer",
			},
			[6] = { 65, 138, 192, 192, 38, 59, 30, 65, 20 },
			[7] = { [0] = { 0, 1, 1, 1, 150, 0, 0, 0, 259 } },
			[8] = {},
			[9] = { 0, 3, 3, 3, 3, 3, 0, 0 },
		},
	},
	[6] = {
		[1] = 65,
		[10] = 65,
		[11] = 138,
		[12] = 29,
		[13] = 30,
		[14] = 144,
		[2] = 138,
		[3] = 174,
		[4] = 59,
		[5] = 65,
		[6] = 65,
		[7] = 138,
		[8] = 138,
		[9] = 192,
	},
	[7] = {
		[0] = {
			[1] = 0,
			[10] = 0,
			[11] = 3,
			[12] = 1,
			[13] = 0,
			[14] = 52,
			[2] = 1,
			[3] = 0,
			[4] = 0,
			[5] = 0,
			[6] = 0,
			[7] = 1,
			[8] = 2,
			[9] = 2,
		},
	},
	[8] = {},
	[9] = {
		[1] = 0,
		[10] = 3,
		[11] = 3,
		[12] = 3,
		[13] = 3,
		[2] = 3,
		[3] = 3,
		[4] = 3,
		[5] = 3,
		[6] = 0,
		[7] = 3,
		[8] = 3,
		[9] = 3,
	},
}, false)

local v2 = luraph_runtime2({
	[1] = { 3, 0, 1, 1, 275 },
	[10] = { 0, 1, 0, 0, 241 },
	[11] = 3,
	[2] = 0,
	[3] = { [1] = 0, [3] = 0, [4] = 0, [5] = 436 },
	[4] = { [0] = { [1] = 0, [3] = 0, [4] = 0, [5] = 436 }, [2] = "a" },
	[5] = { [0] = { 3, 0, 1, 1, 275 } },
	[6] = { 65, 66, 5, 65, 46 },
	[7] = { [0] = { 0, 1, 0, 0, 241 } },
	[8] = {},
	[9] = { 0, 5, 5, 0 },
}, false)

local v3 = hookfunction

local v4 = luraph_runtime2({
	[1] = { 4, 73, 0, 1, 2 },
	[10] = { 0, 54, 1, 0, 0 },
	[11] = 3,
	[2] = 0,
	[3] = { [1] = 0, [2] = 37, [4] = 0, [5] = 0 },
	[4] = { [0] = { [1] = 0, [2] = 37, [4] = 0, [5] = 0 }, [3] = "b" },
	[5] = { [0] = { 4, 73, 0, 1, 2 } },
	[6] = { 65, 102, 66, 5, 65 },
	[7] = { [0] = { 0, 54, 1, 0, 0 } },
	[8] = {},
	[9] = { 0, 83, 6, 6 },
}, false)

v3(v2, v4)

if isfunctionhooked then
	if isfunctionhooked(v2) then
		local httpGet = game.HttpGet
		local v5 = hookfunction

		local v6 = luraph_runtime2({
			[1] = { 1, 1, 200 },
			[10] = { 0, 0, 274 },
			[11] = 1,
			[2] = 0,
			[3] = { 0, 0, 75 },
			[4] = { [0] = { 0, 0, 75 } },
			[5] = { [0] = { 1, 1, 200 } },
			[6] = { 65, 30, 144 },
			[7] = { [0] = { 0, 0, 274 } },
			[8] = {},
			[9] = { 0, 1 },
		}, false)

		v5(httpGet, v6)

		if isfunctionhooked(httpGet) then
			restorefunction(httpGet)

			if not isfunctionhooked(httpGet) then
				local request_ = request or http_request

				if not request_ then
					request_ = syn
					request_ = request_ and request_.request
				end

				if not request_ then
					if fluxus then
					end
				end

				spawn(function()
					while task.wait(0.5) do
						pcall(function()
							local httpGet2 = game.HttpGet
							local v7 = isfunctionhooked(httpGet2)

							if v7 then
								v7()
							end

							local httpPost = httpGet2.HttpPost

							if isfunctionhooked(httpPost) then
								upv0()
							end

							if isfunctionhooked(httpPost) then
								upv0()
							end

							local v8 = isfunctionhooked(setclipboard)

							if v8 then
								v8()
							end

							if upv1 then
								if isfunctionhooked(upv1) then
									upv0()
								end
							end

							if isfolder("HttpGetFolder") then
								upv0()
							elseif isfolder("WebhookFolder") then
								upv0()
								return
							elseif isfolder("RequestFolder") then
								upv0()
								return
							end
						end)
					end
				end)

				local v7 = table.pack(luraph_runtime1(pairs(luraph_runtime3(6, nil --[[ the caller's registers ]], 6))))

				while true do
					local v8 = table.pack((nil)())

					if v8[1] then
						local v9 = v8[3]
						getgenv()[v9] = nil
					else
						break
					end
				end

				local Players = game:GetService("Players")
				game:GetService("RunService")
				local Lighting = game:GetService("Lighting")
				game:GetService("TweenService")
				local v8 = loadstring
				local v9 = table.pack(luraph_runtime1(game.HttpGet(luraph_runtime3(15, nil --[[ the caller's registers ]], 16))))[2][1]
				local v10 = v8(luraph_runtime3(14, nil --[[ the caller's registers ]], 1))()

				v10:AddTheme({
					Name = "Qcq制作",
					Accent = Color3.fromHex("#18181b"),
					Background = Color3.fromHex("#101010"),
					Outline = Color3.fromHex("#FFFFFF"),
					Text = Color3.fromHex("#FFFFFF"),
					Placeholder = Color3.fromHex("#7a7a7a"),
					Button = Color3.fromHex("#52525b"),
					Icon = Color3.fromHex("#a1a1aa"),
				})

				local createWindow = v10.CreateWindow

				local tbl = {
					Title = "死冯夺舍 ",
					Folder = "dead",
					SideBarWidth = 180,
					Background = "https://raw.githubusercontent.com/dream6-e/rbx/main/pppp.png",
					BackgroundImageTransparency = 0.5,
				}

				local openButton = {
					Title = "OPEN UI",
					CornerRadius = UDim.new(1, 0),
					StrokeThickness = 3,
					Enabled = true,
					Draggable = true,
					OnlyMobile = false,
					Scale = 0.9,
				}

				local colorSequence = ColorSequence.new
				Color3.fromHex("#30FF6A")
				local v11 = table.pack(luraph_runtime1(Color3.fromHex(luraph_runtime3(21, nil --[[ the caller's registers ]], 21))))[2][1]
				openButton.Color = colorSequence(luraph_runtime3(19, nil --[[ the caller's registers ]], 1))
				tbl.OpenButton = openButton
				tbl.Topbar = { Height = 44, ButtonsType = "Mac" }
				local v12 = createWindow(v10, tbl)
				v12:Tag({ Title = "乐子Yes", Color = Color3.fromHex("00CED1"), Radius = 2 })
				v12:Tag({ Title = "Qcq", Icon = "crown", Color = Color3.fromHex("00CED1"), Radius = 2 })
				local tbl2 = {}
				local tbl3 = {}
				local colorSequence2 = ColorSequence.new
				local new = ColorSequenceKeypoint.new
				local v13 = table.pack(luraph_runtime1(Color3.fromHex(luraph_runtime3(22, nil --[[ the caller's registers ]], 22))))[2][1]
				new(luraph_runtime3(20, nil --[[ the caller's registers ]], 1))
				local new2 = ColorSequenceKeypoint.new
				local v14 = table.pack(luraph_runtime1(Color3.fromHex(luraph_runtime3(23, nil --[[ the caller's registers ]], 23))))[2][1]
				new2(luraph_runtime3(21, nil --[[ the caller's registers ]], 1))
				local new3 = (0.16).new
				local v15 = table.pack(luraph_runtime1(Color3.fromHex(luraph_runtime3(24, nil --[[ the caller's registers ]], 24))))[2][1]
				new3(luraph_runtime3(22, nil --[[ the caller's registers ]], 1))
				local new4 = ColorSequenceKeypoint.new
				local v16 = table.pack(luraph_runtime1(Color3.fromHex(luraph_runtime3(25, nil --[[ the caller's registers ]], 25))))[2][1]
				new4(luraph_runtime3(23, nil --[[ the caller's registers ]], 1))
				local new5 = ColorSequenceKeypoint.new
				local v17 = table.pack(luraph_runtime1(Color3.fromHex(luraph_runtime3(26, nil --[[ the caller's registers ]], 26))))[2][1]
				new5(luraph_runtime3(24, nil --[[ the caller's registers ]], 1))
				local new6 = ColorSequenceKeypoint.new
				local v18 = table.pack(luraph_runtime1(Color3.fromHex(luraph_runtime3(27, nil --[[ the caller's registers ]], 27))))[2][1]
				new6(luraph_runtime3(25, nil --[[ the caller's registers ]], 1))
				local new7 = ColorSequenceKeypoint.new
				local v19 = table.pack(luraph_runtime1(Color3.fromHex(luraph_runtime3(28, nil --[[ the caller's registers ]], 28))))[2][1]
				local v20 = table.pack(luraph_runtime1(new7(luraph_runtime3(26, nil --[[ the caller's registers ]], 1))))[2][1]
				tbl3[1] = colorSequence2({})
				tbl3[2] = "palette"
				tbl2["彩虹颜色"] = tbl3
				local tbl4 = {}
				local v21 = ColorSequence
				local tbl5 = {}
				local new8 = ColorSequenceKeypoint.new
				local v22 = table.pack(luraph_runtime1(Color3.fromHex(luraph_runtime3(22, nil --[[ the caller's registers ]], 22))))[2][1]
				new8(luraph_runtime3(20, nil --[[ the caller's registers ]], 1))
				local new9 = ColorSequenceKeypoint.new
				local v23 = table.pack(luraph_runtime1(Color3.fromHex(luraph_runtime3(23, nil --[[ the caller's registers ]], 23))))[2][1]
				new9(luraph_runtime3(21, nil --[[ the caller's registers ]], 1))
				local new10 = ColorSequenceKeypoint.new
				local v24 = table.pack(luraph_runtime1(Color3.fromHex(luraph_runtime3(24, nil --[[ the caller's registers ]], 24))))[2][1]
				local v25 = table.pack(luraph_runtime1(new10(luraph_runtime3(22, nil --[[ the caller's registers ]], 1))))[2][1]
				tbl4[1] = v21(tbl5)
				tbl4[2] = tbl5
				tbl2["绿黄渐变"] = tbl4

				local function fn()
					local v26 = (t1[2])[2]
					local main = (t1[2])[1].UIElements.Main

					if main then
						local v27 = main:FindFirstChild(nil)

						if v27 then
							v27:Destroy()
						end

						if not main:FindFirstChildOfClass("UICorner") then
							local new11 = Instance.new
							new11.CornerRadius = UDim.new(0, 16)
							new11.Parent = main
						end

						local uiStroke = Instance.new("UIStroke")
						uiStroke.Thickness = 2
						uiStroke.Color = Color3.new(luraph_runtime3(7, nil --[[ the caller's registers ]], 9))
						uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
						uiStroke.LineJoinMode = Enum.LineJoinMode.Round
						uiStroke.Parent = main
						local uiGradient = Instance.new("UIGradient")
						uiGradient.Name = "GlowEffect"
						local v28 = upv0[v26 or "彩虹颜色"]
						uiGradient.Color = v28 and v28[1] or upv0["彩虹颜色"]
						uiGradient.Rotation = 0
						uiGradient.Parent = uiStroke
						return luraph_runtime3(8, nil --[[ the caller's registers ]], 8)
					end

					return luraph_runtime3(4, nil --[[ the caller's registers ]], 4)
				end

				local v26 = luraph_runtime2({
					[1] = {
						[1] = 3,
						[10] = 4,
						[11] = 0,
						[12] = 0,
						[13] = 43,
						[14] = 9,
						[15] = 18,
						[16] = 13,
						[17] = 83,
						[18] = 76,
						[19] = 0,
						[2] = 27,
						[20] = 6,
						[21] = 381,
						[22] = 17,
						[23] = 0,
						[24] = 6,
						[25] = 182,
						[26] = 176,
						[27] = 4,
						[28] = 70,
						[29] = 22,
						[3] = 21,
						[30] = 0,
						[33] = 20,
						[34] = 9,
						[35] = 79,
						[36] = 0,
						[37] = 22,
						[4] = 34,
						[42] = 20,
						[43] = 34,
						[44] = 1,
						[45] = 0,
						[46] = 22,
						[49] = 20,
						[5] = 0,
						[50] = 23,
						[51] = 1,
						[52] = 0,
						[53] = 22,
						[56] = 20,
						[57] = 22,
						[58] = 0,
						[59] = 11,
						[60] = 0,
						[62] = 0,
						[63] = 0,
						[64] = 0,
						[65] = 17,
						[66] = 10,
						[68] = 9,
						[69] = 9,
						[7] = 6,
						[70] = 79,
						[71] = 5,
						[72] = 143,
						[73] = 170,
						[74] = 0,
						[75] = 78,
						[76] = 14,
						[77] = 0,
						[78] = 5,
						[79] = 22,
						[8] = 20,
						[80] = 0,
						[83] = 15,
						[84] = 125,
						[85] = 13,
						[86] = 4,
						[87] = 23,
						[88] = 22,
						[9] = 3,
						[92] = 20,
						[93] = 70,
					},
					[10] = {
						[1] = 0,
						[11] = 6,
						[12] = 4,
						[13] = 0,
						[14] = 0,
						[15] = 0,
						[16] = 3,
						[17] = 0,
						[18] = 0,
						[19] = 6,
						[2] = 4,
						[20] = 0,
						[21] = 101,
						[22] = 0,
						[23] = 6,
						[25] = 8,
						[26] = 129,
						[27] = 0,
						[28] = 0,
						[29] = 0,
						[3] = 0,
						[30] = 0,
						[31] = 21,
						[32] = 22,
						[33] = 0,
						[34] = 0,
						[35] = 0,
						[36] = 0,
						[37] = 0,
						[38] = 21,
						[39] = 22,
						[4] = 0,
						[40] = 21,
						[41] = 22,
						[42] = 0,
						[43] = 0,
						[44] = 0,
						[45] = 0,
						[46] = 0,
						[47] = 21,
						[48] = 22,
						[49] = 138,
						[5] = 6,
						[50] = 63,
						[51] = 0,
						[52] = 0,
						[53] = 0,
						[54] = 21,
						[55] = 22,
						[56] = 0,
						[57] = 0,
						[58] = 0,
						[59] = 0,
						[6] = 6,
						[60] = 17,
						[61] = 17,
						[62] = 18,
						[63] = 19,
						[64] = 17,
						[65] = 17,
						[67] = 11,
						[68] = 155,
						[69] = 219,
						[70] = 0,
						[72] = 7,
						[73] = 80,
						[74] = 5,
						[75] = 5,
						[76] = 0,
						[77] = 5,
						[78] = 0,
						[79] = 0,
						[8] = 0,
						[80] = 0,
						[81] = 1,
						[82] = 3,
						[83] = 0,
						[84] = 4,
						[85] = 108,
						[86] = 0,
						[87] = 0,
						[88] = 0,
						[89] = 22,
						[9] = 0,
						[90] = 23,
						[91] = 22,
						[92] = 0,
						[93] = 0,
					},
					[11] = 28,
					[2] = 0,
					[3] = {
						[1] = 0,
						[10] = 3,
						[12] = 0,
						[13] = 0,
						[14] = 0,
						[15] = 0,
						[16] = 0,
						[17] = 0,
						[18] = 0,
						[19] = 0,
						[2] = 0,
						[20] = 0,
						[21] = 338,
						[22] = 0,
						[24] = 6,
						[26] = 177,
						[27] = 0,
						[28] = 0,
						[29] = 0,
						[3] = 0,
						[30] = 21,
						[33] = 27,
						[34] = 0,
						[35] = 0,
						[36] = 21,
						[37] = 0,
						[4] = 0,
						[42] = 27,
						[43] = 0,
						[44] = 0,
						[45] = 21,
						[46] = 0,
						[49] = 27,
						[5] = 0,
						[50] = 111,
						[51] = 0,
						[52] = 21,
						[53] = 0,
						[56] = 27,
						[57] = 0,
						[58] = 10,
						[59] = 0,
						[6] = 6,
						[60] = 1,
						[61] = 17,
						[64] = 0,
						[66] = 17,
						[68] = 19,
						[69] = 126,
						[7] = 6,
						[70] = 0,
						[71] = 4,
						[73] = 179,
						[74] = 0,
						[75] = 0,
						[76] = 0,
						[77] = 0,
						[78] = 0,
						[79] = 0,
						[8] = 8,
						[80] = 2,
						[81] = 3,
						[82] = 3,
						[83] = 0,
						[84] = 13,
						[85] = 248,
						[86] = 0,
						[87] = 0,
						[88] = 0,
						[9] = 6,
						[92] = 27,
						[93] = 0,
					},
					[4] = {
						[0] = {
							[1] = 0,
							[10] = 3,
							[12] = 0,
							[13] = 0,
							[14] = 0,
							[15] = 0,
							[16] = 0,
							[17] = 0,
							[18] = 0,
							[19] = 0,
							[2] = 0,
							[20] = 0,
							[21] = 338,
							[22] = 0,
							[24] = 6,
							[26] = 177,
							[27] = 0,
							[28] = 0,
							[29] = 0,
							[3] = 0,
							[30] = 21,
							[33] = 27,
							[34] = 0,
							[35] = 0,
							[36] = 21,
							[37] = 0,
							[4] = 0,
							[42] = 27,
							[43] = 0,
							[44] = 0,
							[45] = 21,
							[46] = 0,
							[49] = 27,
							[5] = 0,
							[50] = 111,
							[51] = 0,
							[52] = 21,
							[53] = 0,
							[56] = 27,
							[57] = 0,
							[58] = 10,
							[59] = 0,
							[6] = 6,
							[60] = 1,
							[61] = 17,
							[64] = 0,
							[66] = 17,
							[68] = 19,
							[69] = 126,
							[7] = 6,
							[70] = 0,
							[71] = 4,
							[73] = 179,
							[74] = 0,
							[75] = 0,
							[76] = 0,
							[77] = 0,
							[78] = 0,
							[79] = 0,
							[8] = 8,
							[80] = 2,
							[81] = 3,
							[82] = 3,
							[83] = 0,
							[84] = 13,
							[85] = 248,
							[86] = 0,
							[87] = 0,
							[88] = 0,
							[9] = 6,
							[92] = 27,
							[93] = 0,
						},
						[11] = "RainbowStroke",
						[23] = "game",
						[25] = "RunService",
						[31] = 38,
						[32] = 9,
						[38] = 66,
						[39] = 0,
						[40] = 66,
						[41] = 34,
						[47] = 65,
						[48] = 1,
						[54] = 81,
						[55] = 22,
						[62] = 119,
						[63] = 246,
						[65] = 65,
						[67] = 79,
						[72] = "GlowEffect",
						[89] = 5,
						[90] = 4,
						[91] = 70,
					},
					[5] = {
						[0] = {
							[1] = 3,
							[10] = 4,
							[11] = 0,
							[12] = 0,
							[13] = 43,
							[14] = 9,
							[15] = 18,
							[16] = 13,
							[17] = 83,
							[18] = 76,
							[19] = 0,
							[2] = 27,
							[20] = 6,
							[21] = 381,
							[22] = 17,
							[23] = 0,
							[24] = 6,
							[25] = 182,
							[26] = 176,
							[27] = 4,
							[28] = 70,
							[29] = 22,
							[3] = 21,
							[30] = 0,
							[33] = 20,
							[34] = 9,
							[35] = 79,
							[36] = 0,
							[37] = 22,
							[4] = 34,
							[42] = 20,
							[43] = 34,
							[44] = 1,
							[45] = 0,
							[46] = 22,
							[49] = 20,
							[5] = 0,
							[50] = 23,
							[51] = 1,
							[52] = 0,
							[53] = 22,
							[56] = 20,
							[57] = 22,
							[58] = 0,
							[59] = 11,
							[60] = 0,
							[62] = 0,
							[63] = 0,
							[64] = 0,
							[65] = 17,
							[66] = 10,
							[68] = 9,
							[69] = 9,
							[7] = 6,
							[70] = 79,
							[71] = 5,
							[72] = 143,
							[73] = 170,
							[74] = 0,
							[75] = 78,
							[76] = 14,
							[77] = 0,
							[78] = 5,
							[79] = 22,
							[8] = 20,
							[80] = 0,
							[83] = 15,
							[84] = 125,
							[85] = 13,
							[86] = 4,
							[87] = 23,
							[88] = 22,
							[9] = 3,
							[92] = 20,
							[93] = 70,
						},
						[31] = 10,
						[32] = 14,
						[38] = 62,
						[39] = 63,
						[40] = 63,
						[41] = 4,
						[47] = 18,
						[48] = 44,
						[54] = 5,
						[55] = 79,
						[6] = "Heartbeat",
						[61] = 6,
						[67] = 35,
						[8] = {
							[1] = {
								[1] = 48,
								[10] = 26,
								[11] = 39,
								[12] = 7,
								[13] = 6,
								[14] = 0,
								[16] = 0,
								[17] = 0,
								[18] = 93,
								[19] = 94,
								[2] = 446,
								[20] = 0,
								[21] = 5,
								[22] = 12,
								[23] = 7,
								[25] = 4,
								[26] = 56,
								[27] = 1,
								[28] = 1,
								[3] = 0,
								[30] = 1,
								[31] = 1,
								[32] = 33,
								[33] = 11,
								[34] = 1,
								[35] = 0,
								[36] = 55,
								[37] = 0,
								[38] = 2,
								[39] = 10,
								[4] = 0,
								[40] = 1,
								[41] = 0,
								[42] = 19,
								[46] = 17,
								[47] = 248,
								[48] = 36,
								[49] = 31,
								[5] = 2,
								[50] = 19,
								[51] = 0,
								[54] = 17,
								[55] = 31,
								[56] = 36,
								[57] = 31,
								[58] = 0,
								[59] = 0,
								[6] = 32,
								[60] = 19,
								[65] = 17,
								[66] = 44,
								[67] = 11,
								[7] = 63,
								[8] = 55,
								[9] = 124,
							},
							[10] = {
								[1] = 0,
								[10] = 0,
								[11] = 0,
								[12] = 0,
								[13] = 0,
								[14] = 12,
								[15] = 12,
								[16] = 13,
								[17] = 14,
								[18] = 15,
								[19] = 161,
								[2] = 44,
								[20] = 16,
								[21] = 12,
								[22] = 12,
								[24] = 6,
								[25] = 0,
								[26] = 0,
								[27] = 1,
								[29] = 1,
								[3] = 1,
								[31] = 0,
								[32] = 0,
								[33] = 0,
								[34] = 0,
								[35] = 39,
								[36] = 0,
								[37] = 1,
								[38] = 0,
								[39] = 0,
								[4] = 1,
								[40] = 0,
								[41] = 0,
								[42] = 0,
								[43] = 21,
								[44] = 19,
								[45] = 19,
								[46] = 98,
								[47] = 4,
								[48] = 0,
								[49] = 0,
								[5] = 225,
								[50] = 0,
								[51] = 0,
								[52] = 18,
								[53] = 19,
								[54] = 0,
								[55] = 0,
								[56] = 0,
								[57] = 0,
								[58] = 0,
								[59] = 0,
								[6] = 204,
								[60] = 0,
								[61] = 18,
								[62] = 18,
								[63] = 21,
								[64] = 19,
								[65] = 57,
								[66] = 220,
								[67] = 0,
								[7] = 2,
								[8] = 140,
								[9] = 75,
							},
							[11] = 25,
							[2] = 0,
							[3] = {
								[1] = 0,
								[10] = 0,
								[11] = 0,
								[12] = 0,
								[13] = 0,
								[14] = 1,
								[15] = 12,
								[19] = 85,
								[2] = 506,
								[21] = 0,
								[23] = 12,
								[25] = 16,
								[26] = 0,
								[27] = 2,
								[28] = 1,
								[29] = 1,
								[30] = 1,
								[31] = 0,
								[32] = 0,
								[33] = 0,
								[34] = 0,
								[35] = 1,
								[36] = 0,
								[38] = 1,
								[39] = 0,
								[4] = 0,
								[40] = 0,
								[41] = 21,
								[42] = 0,
								[46] = 24,
								[47] = 201,
								[48] = 0,
								[49] = 0,
								[5] = 25,
								[50] = 0,
								[51] = 18,
								[54] = 24,
								[55] = 0,
								[56] = 0,
								[57] = 0,
								[58] = 18,
								[59] = 21,
								[6] = 144,
								[60] = 0,
								[65] = 24,
								[66] = 164,
								[67] = 0,
								[7] = 189,
								[8] = 53,
								[9] = 4,
							},
							[4] = {
								[0] = {
									[1] = 0,
									[10] = 0,
									[11] = 0,
									[12] = 0,
									[13] = 0,
									[14] = 1,
									[15] = 12,
									[19] = 85,
									[2] = 506,
									[21] = 0,
									[23] = 12,
									[25] = 16,
									[26] = 0,
									[27] = 2,
									[28] = 1,
									[29] = 1,
									[30] = 1,
									[31] = 0,
									[32] = 0,
									[33] = 0,
									[34] = 0,
									[35] = 1,
									[36] = 0,
									[38] = 1,
									[39] = 0,
									[4] = 0,
									[40] = 0,
									[41] = 21,
									[42] = 0,
									[46] = 24,
									[47] = 201,
									[48] = 0,
									[49] = 0,
									[5] = 25,
									[50] = 0,
									[51] = 18,
									[54] = 24,
									[55] = 0,
									[56] = 0,
									[57] = 0,
									[58] = 18,
									[59] = 21,
									[6] = 144,
									[60] = 0,
									[65] = 24,
									[66] = 164,
									[67] = 0,
									[7] = 189,
									[8] = 53,
									[9] = 4,
								},
								[16] = 66,
								[17] = 93,
								[18] = 250,
								[20] = 200,
								[22] = -7,
								[24] = 31,
								[3] = "tick",
								[37] = "Parent",
								[43] = 0,
								[44] = 0,
								[45] = 36,
								[52] = 52,
								[53] = 31,
								[61] = 192,
								[62] = 66,
								[63] = 14,
								[64] = 11,
							},
							[5] = {
								[0] = {
									[1] = 48,
									[10] = 26,
									[11] = 39,
									[12] = 7,
									[13] = 6,
									[14] = 0,
									[16] = 0,
									[17] = 0,
									[18] = 93,
									[19] = 94,
									[2] = 446,
									[20] = 0,
									[21] = 5,
									[22] = 12,
									[23] = 7,
									[25] = 4,
									[26] = 56,
									[27] = 1,
									[28] = 1,
									[3] = 0,
									[30] = 1,
									[31] = 1,
									[32] = 33,
									[33] = 11,
									[34] = 1,
									[35] = 0,
									[36] = 55,
									[37] = 0,
									[38] = 2,
									[39] = 10,
									[4] = 0,
									[40] = 1,
									[41] = 0,
									[42] = 19,
									[46] = 17,
									[47] = 248,
									[48] = 36,
									[49] = 31,
									[5] = 2,
									[50] = 19,
									[51] = 0,
									[54] = 17,
									[55] = 31,
									[56] = 36,
									[57] = 31,
									[58] = 0,
									[59] = 0,
									[6] = 32,
									[60] = 19,
									[65] = 17,
									[66] = 44,
									[67] = 11,
									[7] = 63,
									[8] = 55,
									[9] = 124,
								},
								[15] = 1,
								[24] = 49,
								[29] = 360,
								[43] = 31,
								[44] = 4,
								[45] = 56,
								[52] = 37,
								[53] = 57,
								[61] = 15,
								[62] = 17,
								[63] = 17,
								[64] = 33,
							},
							[6] = {
								[1] = 65,
								[10] = 65,
								[11] = 65,
								[12] = 196,
								[13] = 124,
								[14] = 153,
								[15] = 192,
								[16] = 66,
								[17] = 66,
								[18] = 26,
								[19] = 179,
								[2] = 101,
								[20] = 66,
								[21] = 33,
								[22] = 173,
								[23] = 151,
								[24] = 184,
								[25] = 18,
								[26] = 65,
								[27] = 41,
								[28] = 89,
								[29] = 78,
								[3] = 138,
								[30] = 131,
								[31] = 30,
								[32] = 65,
								[33] = 65,
								[34] = 87,
								[35] = 53,
								[36] = 65,
								[37] = 52,
								[38] = 7,
								[39] = 65,
								[4] = 199,
								[40] = 30,
								[41] = 107,
								[42] = 124,
								[43] = 184,
								[44] = 184,
								[45] = 184,
								[46] = 144,
								[47] = 93,
								[48] = 65,
								[49] = 65,
								[5] = 119,
								[50] = 124,
								[51] = 108,
								[52] = 184,
								[53] = 184,
								[54] = 18,
								[55] = 65,
								[56] = 65,
								[57] = 65,
								[58] = 108,
								[59] = 107,
								[6] = 193,
								[60] = 124,
								[61] = 184,
								[62] = 184,
								[63] = 184,
								[64] = 184,
								[65] = 144,
								[66] = 93,
								[67] = 65,
								[7] = 74,
								[8] = 114,
								[9] = 179,
							},
							[7] = {
								[0] = {
									[1] = 0,
									[10] = 0,
									[11] = 0,
									[12] = 0,
									[13] = 0,
									[14] = 12,
									[15] = 12,
									[16] = 13,
									[17] = 14,
									[18] = 15,
									[19] = 161,
									[2] = 44,
									[20] = 16,
									[21] = 12,
									[22] = 12,
									[24] = 6,
									[25] = 0,
									[26] = 0,
									[27] = 1,
									[29] = 1,
									[3] = 1,
									[31] = 0,
									[32] = 0,
									[33] = 0,
									[34] = 0,
									[35] = 39,
									[36] = 0,
									[37] = 1,
									[38] = 0,
									[39] = 0,
									[4] = 1,
									[40] = 0,
									[41] = 0,
									[42] = 0,
									[43] = 21,
									[44] = 19,
									[45] = 19,
									[46] = 98,
									[47] = 4,
									[48] = 0,
									[49] = 0,
									[5] = 225,
									[50] = 0,
									[51] = 0,
									[52] = 18,
									[53] = 19,
									[54] = 0,
									[55] = 0,
									[56] = 0,
									[57] = 0,
									[58] = 0,
									[59] = 0,
									[6] = 204,
									[60] = 0,
									[61] = 18,
									[62] = 18,
									[63] = 21,
									[64] = 19,
									[65] = 57,
									[66] = 220,
									[67] = 0,
									[7] = 2,
									[8] = 140,
									[9] = 75,
								},
								[23] = 35,
								[28] = 10,
								[30] = "Rotation",
							},
							[8] = { { [1] = 1, [3] = 4 }, { [1] = 1, [3] = 5 }, { [1] = 1, [3] = 2 } },
							[9] = {
								[1] = 0,
								[10] = 157,
								[11] = 156,
								[12] = 0,
								[13] = 0,
								[14] = 0,
								[15] = 0,
								[16] = 0,
								[17] = 0,
								[18] = 0,
								[19] = 0,
								[2] = 120,
								[20] = 0,
								[21] = 0,
								[22] = 0,
								[23] = 0,
								[24] = 0,
								[25] = 0,
								[26] = 0,
								[27] = 157,
								[28] = 157,
								[29] = 157,
								[3] = 157,
								[30] = 157,
								[31] = 157,
								[32] = 0,
								[33] = 0,
								[34] = 156,
								[35] = 156,
								[36] = 156,
								[37] = 156,
								[38] = 156,
								[39] = 156,
								[4] = 157,
								[40] = 156,
								[41] = 156,
								[42] = 156,
								[43] = 156,
								[44] = 156,
								[45] = 156,
								[46] = 156,
								[47] = 156,
								[48] = 156,
								[49] = 0,
								[5] = 157,
								[50] = 0,
								[51] = 0,
								[52] = 0,
								[53] = 0,
								[54] = 0,
								[55] = 0,
								[56] = 156,
								[57] = 0,
								[58] = 0,
								[59] = 0,
								[6] = 157,
								[60] = 0,
								[61] = 0,
								[62] = 0,
								[63] = 0,
								[64] = 0,
								[65] = 0,
								[66] = 0,
								[7] = 157,
								[8] = 157,
								[9] = 157,
							},
						},
						[81] = "UIElements",
						[82] = "Main",
						[89] = 71,
						[90] = 71,
						[91] = 28,
					},
					[6] = {
						[1] = 65,
						[10] = 38,
						[11] = 66,
						[12] = 81,
						[13] = 65,
						[14] = 65,
						[15] = 65,
						[16] = 149,
						[17] = 65,
						[18] = 65,
						[19] = 17,
						[2] = 149,
						[20] = 5,
						[21] = 190,
						[22] = 65,
						[23] = 138,
						[24] = 38,
						[25] = 26,
						[26] = 179,
						[27] = 65,
						[28] = 65,
						[29] = 124,
						[3] = 65,
						[30] = 108,
						[31] = 184,
						[32] = 184,
						[33] = 18,
						[34] = 65,
						[35] = 65,
						[36] = 108,
						[37] = 124,
						[38] = 184,
						[39] = 184,
						[4] = 65,
						[40] = 184,
						[41] = 184,
						[42] = 18,
						[43] = 65,
						[44] = 65,
						[45] = 108,
						[46] = 124,
						[47] = 184,
						[48] = 184,
						[49] = 144,
						[5] = 81,
						[50] = 93,
						[51] = 65,
						[52] = 108,
						[53] = 124,
						[54] = 184,
						[55] = 184,
						[56] = 18,
						[57] = 65,
						[58] = 108,
						[59] = 124,
						[6] = 192,
						[60] = 153,
						[61] = 192,
						[62] = 66,
						[63] = 66,
						[64] = 81,
						[65] = 173,
						[66] = 151,
						[67] = 184,
						[68] = 144,
						[69] = 93,
						[7] = 38,
						[70] = 65,
						[71] = 38,
						[72] = 26,
						[73] = 179,
						[74] = 81,
						[75] = 149,
						[76] = 65,
						[77] = 17,
						[78] = 5,
						[79] = 65,
						[8] = 174,
						[80] = 160,
						[81] = 192,
						[82] = 192,
						[83] = 65,
						[84] = 83,
						[85] = 163,
						[86] = 5,
						[87] = 196,
						[88] = 124,
						[89] = 184,
						[9] = 9,
						[90] = 184,
						[91] = 184,
						[92] = 18,
						[93] = 65,
					},
					[7] = {
						[0] = {
							[1] = 0,
							[11] = 6,
							[12] = 4,
							[13] = 0,
							[14] = 0,
							[15] = 0,
							[16] = 3,
							[17] = 0,
							[18] = 0,
							[19] = 6,
							[2] = 4,
							[20] = 0,
							[21] = 101,
							[22] = 0,
							[23] = 6,
							[25] = 8,
							[26] = 129,
							[27] = 0,
							[28] = 0,
							[29] = 0,
							[3] = 0,
							[30] = 0,
							[31] = 21,
							[32] = 22,
							[33] = 0,
							[34] = 0,
							[35] = 0,
							[36] = 0,
							[37] = 0,
							[38] = 21,
							[39] = 22,
							[4] = 0,
							[40] = 21,
							[41] = 22,
							[42] = 0,
							[43] = 0,
							[44] = 0,
							[45] = 0,
							[46] = 0,
							[47] = 21,
							[48] = 22,
							[49] = 138,
							[5] = 6,
							[50] = 63,
							[51] = 0,
							[52] = 0,
							[53] = 0,
							[54] = 21,
							[55] = 22,
							[56] = 0,
							[57] = 0,
							[58] = 0,
							[59] = 0,
							[6] = 6,
							[60] = 17,
							[61] = 17,
							[62] = 18,
							[63] = 19,
							[64] = 17,
							[65] = 17,
							[67] = 11,
							[68] = 155,
							[69] = 219,
							[70] = 0,
							[72] = 7,
							[73] = 80,
							[74] = 5,
							[75] = 5,
							[76] = 0,
							[77] = 5,
							[78] = 0,
							[79] = 0,
							[8] = 0,
							[80] = 0,
							[81] = 1,
							[82] = 3,
							[83] = 0,
							[84] = 4,
							[85] = 108,
							[86] = 0,
							[87] = 0,
							[88] = 0,
							[89] = 22,
							[9] = 0,
							[90] = 23,
							[91] = 22,
							[92] = 0,
							[93] = 0,
						},
						[10] = "FindFirstChild",
						[24] = "GetService",
						[66] = 83,
						[7] = "Connect",
						[71] = "FindFirstChild",
					},
					[8] = {},
					[9] = {
						[1] = 0,
						[10] = 150,
						[11] = 150,
						[12] = 150,
						[13] = 150,
						[14] = 150,
						[15] = 153,
						[16] = 149,
						[17] = 149,
						[18] = 151,
						[19] = 153,
						[2] = 151,
						[20] = 153,
						[21] = 111,
						[22] = 151,
						[23] = 155,
						[24] = 155,
						[25] = 155,
						[26] = 155,
						[27] = 155,
						[28] = 152,
						[29] = 150,
						[3] = 151,
						[30] = 150,
						[31] = 150,
						[32] = 150,
						[33] = 150,
						[34] = 150,
						[35] = 1,
						[36] = 1,
						[37] = 1,
						[38] = 1,
						[39] = 1,
						[4] = 1,
						[40] = 1,
						[41] = 1,
						[42] = 1,
						[43] = 1,
						[44] = 151,
						[45] = 151,
						[46] = 151,
						[47] = 151,
						[48] = 151,
						[49] = 151,
						[5] = 155,
						[50] = 151,
						[51] = 151,
						[52] = 155,
						[53] = 155,
						[54] = 155,
						[55] = 155,
						[56] = 155,
						[57] = 155,
						[58] = 1,
						[59] = 1,
						[6] = 155,
						[60] = 1,
						[61] = 1,
						[62] = 1,
						[63] = 1,
						[64] = 1,
						[65] = 1,
						[66] = 1,
						[67] = 1,
						[68] = 1,
						[69] = 1,
						[7] = 155,
						[70] = 1,
						[71] = 152,
						[72] = 152,
						[73] = 152,
						[74] = 152,
						[75] = 153,
						[76] = 153,
						[77] = 151,
						[78] = 151,
						[79] = 155,
						[8] = 156,
						[80] = 1,
						[81] = 148,
						[82] = 148,
						[83] = 148,
						[84] = 149,
						[85] = 149,
						[86] = 149,
						[87] = 152,
						[88] = 152,
						[89] = 152,
						[9] = 155,
						[90] = 152,
						[91] = 152,
						[92] = 152,
					},
				}, false)

				if fn(v12, "彩虹颜色") then
					v26(v12, 5)
				end

				game:GetService("TweenService")

				if not Lighting:FindFirstChildOfClass("BlurEffect") then
					local blurEffect = Instance.new("BlurEffect")
					blurEffect.Size = 0
					blurEffect.Parent = Lighting
				end

				task.spawn(function()
					local flag = false

					while true do
						task.wait(0.1)
						local main = upv0.UIElements and upv0.UIElements.Main
						local visible = main and main.Visible or false

						if visible ~= flag then
							flag = visible
							local create = upv1.Create

							TweenInfo.new(0.3)
							;({}).Size = visible and 20 or 0
							create(luraph_runtime3(5, nil --[[ the caller's registers ]], 8)):Play()
						end
					end
				end)

				local function fn2()
					if upv0 then
						upv0:Disconnect()
						upv0 = nil
					end

					if upv1 then
						upv1:Destroy()
						upv1 = nil
					end

					local character = upv2.Character

					if character then
						local humanoid = character:FindFirstChildOfClass("Humanoid")
						local v27 = character:FindFirstChild(nil)

						if humanoid then
							humanoid.PlatformStand = false
						end

						if v27 then
							v27.Anchored = false
						end

						local v28 = ipairs
						local v29 = table.pack(luraph_runtime1(character.GetDescendants(luraph_runtime3(6, nil --[[ the caller's registers ]], 6))))[2][1]
						local v30 = table.pack(luraph_runtime1(v28(luraph_runtime3(5, nil --[[ the caller's registers ]], 1))))
						local str

						while true do
							local v31 = table.pack((nil)())

							if v31[1] then
								local v32 = v31[3]

								if not v32:IsA(str) then
									str = "Decal"
									if not v32:IsA(str) then
										continue
									end
								end

								v32.Transparency = 0
							else
								break
							end
						end
					end
				end

				local function fn3()
					local v27 = (t1[2])[1]

					if v27 then
						local character = v27.Character

						if character then
							if character:FindFirstChild("HumanoidRootPart") then
								(nil)()
								task.wait(0.2)
								local character2 = upv2.Character
								local notify, humanoid, humanoid2, v28

								if character2 then
									notify = character2:FindFirstChild(nil)
									humanoid = character2:FindFirstChildOfClass("Humanoid")
									character.Archivable = true
									upv3 = character:Clone()
									upv3.Name = "PossessedClone"
									upv3.Parent = workspace
									humanoid2 = upv3:FindFirstChildOfClass("Humanoid")
									upv3:FindFirstChild("HumanoidRootPart")

									if notify then
										if humanoid then
											local v29 = ipairs
											local v30 = table.pack(luraph_runtime1(character2.GetDescendants(luraph_runtime3(11, nil --[[ the caller's registers ]], 11))))[2][1]
											local v31 = table.pack(luraph_runtime1(v29(luraph_runtime3(10, nil --[[ the caller's registers ]], 1))))

											while true do
												local v32 = table.pack((nil)())

												if v32[1] then
													v28 = v32[3]

													if not v28:IsA("BasePart") then
														if not v28:IsA("Decal") then
															continue
														end
													end

													v28.Transparency = 1
												else
													break
												end
											end

											notify.CanCollide = false
											humanoid.PlatformStand = true
											notify.Anchored = true

											upv4 = upv5.Heartbeat:Connect(function()
												if upv0 then
													if upv0.Parent then
														upv0.CFrame = CFrame(upv1)
														upv0.Velocity = Vector3.zero
														upv0.RotVelocity = Vector3.zero
													end
												end
											end)
										end
									end
								else
									humanoid = upv0
									notify = upv0.Notify
									humanoid2 = { Title = "错误", Content = "自己的角色未加载", Type = "error" }
									notify(humanoid, humanoid2)

									while true do
										local v29 = table.pack((nil)())

										if v29[1] then
											v28 = v29[3]

											if not v28:IsA("BasePart") then
												if not v28:IsA("Decal") then
													continue
												end
											end

											v28.Transparency = 1
										else
											break
										end
									end

									notify.CanCollide = false
									humanoid.PlatformStand = true
									notify.Anchored = true

									upv4 = upv5.Heartbeat:Connect(function()
										if upv0 then
											if upv0.Parent then
												upv0.CFrame = CFrame(upv1)
												upv0.Velocity = Vector3.zero
												upv0.RotVelocity = Vector3.zero
											end
										end
									end)
								end

								upv2.Character = upv3
								upv6.CameraSubject = humanoid2
								local animate = upv3:FindFirstChild("Animate")

								if animate then
									animate.Disabled = true
									task.wait(0.1)
									animate.Disabled = false
								end

								if humanoid2 then
									humanoid2.Died:Connect(function()
										if upv0 then
											local v29 = upv0
											upv1.Character = v29
											local humanoid3 = v29:FindFirstChildOfClass("Humanoid")

											if humanoid3 then
												humanoid3.PlatformStand = false
											end

											local humanoidRootPart = upv0:FindFirstChild("HumanoidRootPart")

											if humanoidRootPart then
												humanoidRootPart.Anchored = false
											end
										end

										if upv2 then
											upv2:Destroy()
											upv2 = nil
										end

										if upv3 then
											upv3:Disconnect()
											upv3 = nil
										end
									end)
								end

								upv0:Notify({ Title = "成功", Content = "已伪装: " .. v27.Name, Type = "success" })
								return
							end
						end

						upv0:Notify({ Title = "错误", Type = "error" })
						return
					end
				end

				local function fn4()
					local tbl6 = {}
					local v27 = ipairs
					upv0:GetPlayers()
					local v28 = table.pack(luraph_runtime1(v27(luraph_runtime3(4, nil --[[ the caller's registers ]], 4))))

					while true do
						local v29 = table.pack((nil)())

						if v29[1] then
							local v30 = v29[3]

							if v30 ~= upv1 then
								if v30.Character then
									if v30.Character:FindFirstChild(nil) then
										table.insert(tbl6, v30)
									end
								end
							end
						else
							break
						end
					end

					error("devirt: len of None (at 0:108)")
				end

				local v27 = v12:Tab({ Title = "伪装", Icon = "user-round-cog" })
				local n = 1
				v12:SelectTab(n)
				local button = v27.Button
				n.Title = "随机伪装"

				n.Callback = function()
					upv0()
				end

				button(v27, n)

				v27:Button({
					Title = "重置回本体",
					Callback = function()
						(nil)()

						if upv1.Character then
							local character = upv1.Character
							upv1.Character = character
							upv2.CameraSubject = character:FindFirstChildOfClass("Humanoid")
						end

						upv3:Notify({ Title = "提示", Content = "已重置回本体", Type = "success" })
					end,
				})

				v27:Divider()

				v27:Dropdown({
					Title = "选择玩家",
					Multi = false,
					Options = {},
					Callback = luraph_runtime2({
						[1] = { 4, 0, 1, 422, 1 },
						[10] = { 0, 0, 0, 183, 0 },
						[11] = 3,
						[2] = 0,
						[3] = { 0, 1, 0, 414, 0 },
						[4] = { [0] = { 0, 1, 0, 414, 0 } },
						[5] = { [0] = { 4, 0, 1, 422, 1 } },
						[6] = { 65, 160, 30, 99, 65 },
						[7] = { [0] = { 0, 0, 0, 183, 0 } },
						[8] = {},
						[9] = { 0, 1, 1, 50 },
					}, false),
				})

				local function fn5()
					local tbl6 = {}
					local v28 = ipairs
					local v29 = table.pack(luraph_runtime1(upv0.GetPlayers(luraph_runtime3(4, nil --[[ the caller's registers ]], 4))))[2][1]
					local v30 = table.pack(luraph_runtime1(v28(luraph_runtime3(3, nil --[[ the caller's registers ]], 1))))
					local v31 = (v30[2])[3]

					while true do
						local v32 = table.pack((nil)())

						if v32[1] then
							v31 = v32[3]

							if v31 ~= upv1 then
								table.insert(tbl6, v31.Name)
							end
						else
							break
						end
					end

					upv2:Refresh(v31)
				end

				v27:Button({
					Title = "刷新玩家列表",
					Callback = function()
						upv0()
						upv1:Notify({ Title = "提示", Content = "列表已刷新", Type = "success" })
					end,
				})

				v27:Button({
					Title = "伪装选中玩家",
					Callback = function()
						local value = upv0.Value
						local v28, notify

						if not value then
							v28 = upv3

							notify = upv3.Notify
							;(nil).Content = "请先选择一名玩家"
							;(nil).Type = "warning"
							notify(v28, nil)
						elseif value == "" then
							v28 = upv3

							notify = upv3.Notify
							;(nil).Content = "请先选择一名玩家"
							;(nil).Type = "warning"
							notify(v28, nil)
							return
						else
							local v29 = upv1:FindFirstChild(value)

							if not v29 then
								upv3:Notify({ Title = "错误", Content = "玩家不存在", Type = "error" })
							else
								upv2(v29)
							end
						end
					end,
				})

				fn5()
				Players.PlayerAdded:Connect(fn5)
				Players.PlayerRemoving:Connect(fn5)
				return
			end

			v()
			return
		end

		v()
		return
	end

	v()
	return
end

v()
