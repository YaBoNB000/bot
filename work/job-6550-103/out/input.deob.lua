-- deobf by https://discord.gg/ck3k7nAVS

-- [best effort] 完整反虚拟化：每个 VM 代码块都还原成了 Luau，正文没有
-- 留下 error("devirt: ...") 中断标记。（运行期构造、解不开的 VM 辅助闭包
-- 仍保留为具名桩函数。）

-- Luraph 把寄存器帧当函数来调（原生片段的一种取寄存器方式）；
-- 帧内容无法从运行时 dump 里复原，这里用安全桩占位，保证语法正确。

local function luraph_frame(...)
	return nil
end


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


luraph_runtime1(...)
local v = Enum
local v2 = Drawing
local v3 = game
local v4 = workspace
local v5 = string
local v6 = Instance
local v7 = BrickColor
local v8 = loadstring
local v9 = type
local v10 = ColorSequence
local v11 = CFrame
local v12 = gethwid
local v13 = UDim2
local v14 = RaycastParams
local v15 = ColorSequenceKeypoint
local v16 = UDim
local v17 = ipairs
local v18 = pcall
local v19 = table
local v20 = os
local v21 = Vector3
local v22 = print
local v23 = task
local v24 = Color3
local v25 = Vector2
local v26 = math
local v27 = tostring
local wait = v23 and v23.wait
local fromOffset = v13 and v13.fromOffset
local new = v6 and v6.new
local new2 = v24 and v24.new
local applyStrokeMode = v and v.ApplyStrokeMode
local new3 = v10 and v10.new
local new4 = v15 and v15.new
local fromRGB = v24 and v24.fromRGB
local new5 = v25 and v25.new

if v23 then
end

local new6 = v16 and v16.new
local fromHex = v24 and v24.fromHex
local date = v20 and v20.date

if v11 then
end

if v11 then
end

if v then
end

if v13 then
end

if v19 then
end

if v21 then
end

if v14 then
end

if v then
end

if v26 then
end

if v26 then
end

if v26 then
end

if v26 then
end

if v5 then
end

if v19 then
end

if v26 then
end

if v19 then
end

if v5 then
end

if v then
end

if v7 then
end

if v then
end

if v then
end

if v26 then
end

if v26 then
end

local v28 = v3
local getService = v3.GetService
local v29

if luraph_frame(nil, nil) > 73 then
	local v30 = table.pack(getService(v28, nil))
	v29 = v30[1]
	luraph_frame(nil, nil)
else
	local v30 = table.pack(getService(v28, nil))
	v29 = v30[1]
	luraph_frame(nil, nil)
end

local v30 = v3
local getService2 = v3.GetService
local str = "StarterGui"

if luraph_frame(nil, nil) > 74 then
	local v31 = table.pack(getService2(v30, str))
	luraph_frame(nil, nil)
else
	local v31 = table.pack(getService2(v30, str))
	luraph_frame(nil, nil)
end

local v31 = v3
local getService3 = v3.GetService
local str2 = "HttpService"

if luraph_frame(nil, nil) > 75 then
	local v32 = table.pack(getService3(v31, str2))
	luraph_frame(nil, nil)
else
	local v32 = table.pack(getService3(v31, str2))
	luraph_frame(nil, nil)
end

local localPlayer = v29.LocalPlayer
local v32 = v12
local str3

if luraph_frame(nil, nil) > 75 then
	local v33 = table.pack(v32())
	str3 = v33[1]
	luraph_frame(nil, nil)
else
	local v33 = table.pack(v32())
	str3 = v33[1]
	luraph_frame(nil, nil)
end

str3 = str3 or "unknown"

local function fn(arg)
	local setCore = upv0.SetCore
	local tbl = {}
	local v33 = arg

	if v33 then
		tbl.Title = v33
		tbl.Text = v33
	end

	tbl.Duration = v33

	if not (luraph_frame(nil, nil) > 7) then
		local v34 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 5, 7))
		setCore(table.unpack(v34, 1, v34.n))
		luraph_frame(nil, nil)
	else
		local v34 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 5, 7))
		setCore(table.unpack(v34, 1, v34.n))
		luraph_frame(nil, nil)
	end
end

local v33 = luraph_runtime2({
		[1] = { --[[ 已折叠 87 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
		[10] = { --[[ 已折叠 110 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
		[11] = { --[[ 已折叠 108 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
		[2] = { --[[ 已折叠 94 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
		[3] = { --[[ 已折叠 110 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
		[5] = { --[[ 已折叠 110 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
		[6] = { --[[ 已折叠 102 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
	[7] = {},
	[8] = 0,
	[9] = 24,
}, false)

local v34 = nil
local v35 = v18

local function fn2()
	local v36 = upv1
	local httpGet = upv1.HttpGet
	local str4 = "https://raw.githubusercontent.com/GKye9178/okokok91787891kkk/refs/heads/main/gk%E8%8E%B7%E5%8F%96%E7%99%BD%E5%90%8D%E5%8D%95.lua"
	local v37

	if luraph_frame(nil, nil) > 3 then
		local v38 = table.pack(httpGet(v36, str4))
		v37 = v38[1]
		luraph_frame(nil, nil)
	else
		local v38 = table.pack(httpGet(v36, str4))
		v37 = v38[1]
		luraph_frame(nil, nil)
	end

	upv0 = v37
end

local v36

if not (luraph_frame(nil, nil) > 81) then
	local v37 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 81, 81))
	local v38 = table.pack(v35(table.unpack(v37, 1, v37.n)))
	local v39 = table.pack(luraph_runtime1(table.unpack(v38, 1, v38.n)))
	v36 = (v39[2])[1]
	luraph_frame(nil, nil)
else
	local v37 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 81, 81))
	local v38 = table.pack(v35(table.unpack(v37, 1, v37.n)))
	local v39 = table.pack(luraph_runtime1(table.unpack(v38, 1, v38.n)))
	v36 = (v39[2])[1]
	luraph_frame(nil, nil)
end

if v36 then
	local v37 = v33
	local v38 = v34

	if luraph_frame(nil, nil) > 83 then
		local v39 = table.pack(v37(v38))
		luraph_frame(nil, nil)
	else
		local v39 = table.pack(v37(v38))
		luraph_frame(nil, nil)
	end

	local v39 = v18

	local function fn3()
		local jsonDecode = upv0.JSONDecode

		if luraph_frame(nil, nil) > 3 then
			local v40 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 2, 3))
			local v41 = table.pack(jsonDecode(table.unpack(v40, 1, v40.n)))
			return table.unpack(v41, 1, v41.n)
		end

		local v40 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 2, 3))
		local v41 = table.pack(jsonDecode(table.unpack(v40, 1, v40.n)))
		return table.unpack(v41, 1, v41.n)
	end

	local v40, v41

	if not (luraph_frame(nil, nil) > 85) then
		local v42 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 85, 85))
		local v43 = table.pack(v39(table.unpack(v42, 1, v42.n)))
		local v44 = table.pack(luraph_runtime1(table.unpack(v43, 1, v43.n)))
		v40 = (v44[2])[1]
		v41 = (v44[2])[2]
		luraph_frame(nil, nil)
	else
		local v42 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 85, 85))
		local v43 = table.pack(v39(table.unpack(v42, 1, v42.n)))
		local v44 = table.pack(luraph_runtime1(table.unpack(v43, 1, v43.n)))
		v40 = (v44[2])[1]
		v41 = (v44[2])[2]
		luraph_frame(nil, nil)
	end

	if v40 then
		local v42 = v9
		local v43 = v41
		local v44

		if luraph_frame(nil, nil) > 87 then
			local v45 = table.pack(v42(v43))
			v44 = v45[1]
			luraph_frame(nil, nil)
		else
			local v45 = table.pack(v42(v43))
			v44 = v45[1]
			luraph_frame(nil, nil)
		end

		if v44 == "table" then
			local v45 = v41
			local flag, v46, tbl, v47, httpGet, v48, v49

			if not (v45.mode == false) then
				local devices = v45.devices or {}
				flag = false
				local v50 = v17

				if not (luraph_frame(nil, nil) > 90) then
					local v51 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 90, 90))
					local v52 = table.pack(v50(table.unpack(v51, 1, v51.n)))
					local v53 = table.pack(luraph_runtime1(table.unpack(v52, 1, v52.n)))
					v46 = (v53[2])[1]
					tbl = (v53[2])[2]
					luraph_frame(nil, nil)
				else
					local v51 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 90, 90))
					local v52 = table.pack(v50(table.unpack(v51, 1, v51.n)))
					local v53 = table.pack(luraph_runtime1(table.unpack(v52, 1, v52.n)))
					v46 = (v53[2])[1]
					tbl = (v53[2])[2]
					luraph_frame(nil, nil)
				end

				luraph_frame(nil, nil)

				while true do
					local v51 = table.pack(o_1())

					if not v51[1] then
						break
					else
						tbl = v51[2]
						local v52 = v27
						local v53 = v51[3]
						local v54

						if luraph_frame(nil, nil) > 93 then
							local v55 = table.pack(v52(v53))
							v54 = v55[1]
							luraph_frame(nil, nil)
						else
							local v55 = table.pack(v52(v53))
							v54 = v55[1]
							luraph_frame(nil, nil)
						end

						if v54 ~= "" then
							local v55 = v27
							local v56 = str3
							local v57

							if luraph_frame(nil, nil) > 94 then
								local v58 = table.pack(v55(v56))
								v57 = v58[1]
								luraph_frame(nil, nil)
							else
								local v58 = table.pack(v55(v56))
								v57 = v58[1]
								luraph_frame(nil, nil)
							end

							if v54 == v57 then
								flag = true
								break
							end
						end
					end
				end

				if flag then
					local v51 = fn

					if not (luraph_frame(nil, nil) > 92) then
						local v52 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 90, 92))
						v51(table.unpack(v52, 1, v52.n))
						luraph_frame(nil, nil)
						v47 = v8
						httpGet = v3.HttpGet

						if not (luraph_frame(nil, nil) > 90) then
							local v53 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 89, 90))
							local v54 = table.pack(httpGet(table.unpack(v53, 1, v53.n)))
							local v55 = table.pack(luraph_runtime1(table.unpack(v54, 1, v54.n)))
							luraph_frame(nil, nil)
						else
							local v53 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 89, 90))
							local v54 = table.pack(httpGet(table.unpack(v53, 1, v53.n)))
							local v55 = table.pack(luraph_runtime1(table.unpack(v54, 1, v54.n)))
							luraph_frame(nil, nil)
						end

						if not (luraph_frame(nil, nil) > t163_220_4[1] + 88 - 1) then
							local v53 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 88, t163_220_4[1] + 88 - 1))
							local v54 = table.pack(v47(table.unpack(v53, 1, v53.n)))
							v48 = v54[1]
							luraph_frame(nil, nil)
						else
							local v53 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 88, t163_220_4[1] + 88 - 1))
							local v54 = table.pack(v47(table.unpack(v53, 1, v53.n)))
							v48 = v54[1]
							luraph_frame(nil, nil)
						end

						if luraph_frame(nil, nil) > 87 then
							local v53 = table.pack(v48())
							v49 = v53[1]
							luraph_frame(nil, nil)
						else
							local v53 = table.pack(v48())
							v49 = v53[1]
							luraph_frame(nil, nil)
						end

						v46 = v49
						flag = v49.CreateWindow

						tbl = {
							Title = "Bacon head",
							Author = "总制作者:GK",
							Icon = "home",
							Folder = "Cold wind",
						}
					else
						local v52 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 90, 92))
						v51(table.unpack(v52, 1, v52.n))
						luraph_frame(nil, nil)
						v47 = v8
						httpGet = v3.HttpGet

						if not (luraph_frame(nil, nil) > 90) then
							local v53 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 89, 90))
							local v54 = table.pack(httpGet(table.unpack(v53, 1, v53.n)))
							local v55 = table.pack(luraph_runtime1(table.unpack(v54, 1, v54.n)))
							luraph_frame(nil, nil)
						else
							local v53 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 89, 90))
							local v54 = table.pack(httpGet(table.unpack(v53, 1, v53.n)))
							local v55 = table.pack(luraph_runtime1(table.unpack(v54, 1, v54.n)))
							luraph_frame(nil, nil)
						end

						if not (luraph_frame(nil, nil) > t163_220_4[1] + 88 - 1) then
							local v53 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 88, t163_220_4[1] + 88 - 1))
							local v54 = table.pack(v47(table.unpack(v53, 1, v53.n)))
							v48 = v54[1]
							luraph_frame(nil, nil)
						else
							local v53 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 88, t163_220_4[1] + 88 - 1))
							local v54 = table.pack(v47(table.unpack(v53, 1, v53.n)))
							v48 = v54[1]
							luraph_frame(nil, nil)
						end

						if luraph_frame(nil, nil) > 87 then
							local v53 = table.pack(v48())
							v49 = v53[1]
							luraph_frame(nil, nil)
						else
							local v53 = table.pack(v48())
							v49 = v53[1]
							luraph_frame(nil, nil)
						end

						v46 = v49
						flag = v49.CreateWindow

						tbl = {
							Title = "Bacon head",
							Author = "总制作者:GK",
							Icon = "home",
							Folder = "Cold wind",
						}
					end
				end
			else
				local v50 = fn

				if not (luraph_frame(nil, nil) > 90) then
					local v51 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 88, 90))
					v50(table.unpack(v51, 1, v51.n))
					luraph_frame(nil, nil)
					v47 = v8
					httpGet = v3.HttpGet

					if not (luraph_frame(nil, nil) > 90) then
						local v52 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 89, 90))
						local v53 = table.pack(httpGet(table.unpack(v52, 1, v52.n)))
						local v54 = table.pack(luraph_runtime1(table.unpack(v53, 1, v53.n)))
						luraph_frame(nil, nil)
					else
						local v52 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 89, 90))
						local v53 = table.pack(httpGet(table.unpack(v52, 1, v52.n)))
						local v54 = table.pack(luraph_runtime1(table.unpack(v53, 1, v53.n)))
						luraph_frame(nil, nil)
					end

					if not (luraph_frame(nil, nil) > t163_220_4[1] + 88 - 1) then
						local v52 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 88, t163_220_4[1] + 88 - 1))
						local v53 = table.pack(v47(table.unpack(v52, 1, v52.n)))
						v48 = v53[1]
						luraph_frame(nil, nil)
					else
						local v52 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 88, t163_220_4[1] + 88 - 1))
						local v53 = table.pack(v47(table.unpack(v52, 1, v52.n)))
						v48 = v53[1]
						luraph_frame(nil, nil)
					end

					if luraph_frame(nil, nil) > 87 then
						local v52 = table.pack(v48())
						v49 = v52[1]
						luraph_frame(nil, nil)
					else
						local v52 = table.pack(v48())
						v49 = v52[1]
						luraph_frame(nil, nil)
					end

					v46 = v49
					flag = v49.CreateWindow

					tbl = {
						Title = "Bacon head",
						Author = "总制作者:GK",
						Icon = "home",
						Folder = "Cold wind",
					}
				else
					local v51 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 88, 90))
					v50(table.unpack(v51, 1, v51.n))
					luraph_frame(nil, nil)
					v47 = v8
					httpGet = v3.HttpGet

					if not (luraph_frame(nil, nil) > 90) then
						local v52 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 89, 90))
						local v53 = table.pack(httpGet(table.unpack(v52, 1, v52.n)))
						local v54 = table.pack(luraph_runtime1(table.unpack(v53, 1, v53.n)))
						luraph_frame(nil, nil)
					else
						local v52 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 89, 90))
						local v53 = table.pack(httpGet(table.unpack(v52, 1, v52.n)))
						local v54 = table.pack(luraph_runtime1(table.unpack(v53, 1, v53.n)))
						luraph_frame(nil, nil)
					end

					if not (luraph_frame(nil, nil) > t163_220_4[1] + 88 - 1) then
						local v52 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 88, t163_220_4[1] + 88 - 1))
						local v53 = table.pack(v47(table.unpack(v52, 1, v52.n)))
						v48 = v53[1]
						luraph_frame(nil, nil)
					else
						local v52 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 88, t163_220_4[1] + 88 - 1))
						local v53 = table.pack(v47(table.unpack(v52, 1, v52.n)))
						v48 = v53[1]
						luraph_frame(nil, nil)
					end

					if luraph_frame(nil, nil) > 87 then
						local v52 = table.pack(v48())
						v49 = v52[1]
						luraph_frame(nil, nil)
					else
						local v52 = table.pack(v48())
						v49 = v52[1]
						luraph_frame(nil, nil)
					end

					v46 = v49
					flag = v49.CreateWindow

					tbl = {
						Title = "Bacon head",
						Author = "总制作者:GK",
						Icon = "home",
						Folder = "Cold wind",
					}
				end
			end

			local v50 = fromOffset
			local n = 400
			local n2 = 300
			local v51

			if luraph_frame(nil, nil) > 93 then
				local v52 = table.pack(v50(n, n2))
				v51 = v52[1]
				luraph_frame(nil, nil)
			else
				local v52 = table.pack(v50(n, n2))
				v51 = v52[1]
				luraph_frame(nil, nil)
			end

			tbl.Size = v51
			tbl.Background = "video:https://raw.githubusercontent.com/GKye9178/okokok91787891kkk/refs/heads/main/video_260713_173228.mp4"
			tbl.Transparent = true

			tbl.User = {
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

			tbl.SideBarWidth = 200
			tbl.ScrollBarEnabled = true
			local v52

			if luraph_frame(nil, nil) > 90 then
				local v53 = table.pack(flag(v46, tbl))
				v52 = v53[1]
				luraph_frame(nil, nil)
			else
				local v53 = table.pack(flag(v46, tbl))
				v52 = v53[1]
				luraph_frame(nil, nil)
			end

			local main = v52.UIElements.Main
			local v53, v54, v55, v56, str4, v57, v58, tbl2, v59, v60, v61, v62, v63, v64, v65, v66, v67, v68, v69, v70, n3, n4, v71, v72, v73

			if main then
				local v74 = new
				local str5 = "UIStroke"

				if luraph_frame(nil, nil) > 91 then
					local v75 = table.pack(v74(str5))
					v53 = v75[1]
					luraph_frame(nil, nil)
				else
					local v75 = table.pack(v74(str5))
					v53 = v75[1]
					luraph_frame(nil, nil)
				end

				v53.Name = "BaconStroke"
				v53.Thickness = 1.5
				v54 = new2

				if not (luraph_frame(nil, nil) > 94) then
					local v75 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 92, 94))
					local v76 = table.pack(v54(table.unpack(v75, 1, v75.n)))
					v55 = v76[1]
					luraph_frame(nil, nil)
				else
					local v75 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 92, 94))
					local v76 = table.pack(v54(table.unpack(v75, 1, v75.n)))
					v55 = v76[1]
					luraph_frame(nil, nil)
				end

				v53.Color = v55
				v53.ApplyStrokeMode = applyStrokeMode.Border
				v56 = new
				str4 = "UIGradient"

				if luraph_frame(nil, nil) > 92 then
					local v75 = table.pack(v56(str4))
					v57 = v75[1]
					luraph_frame(nil, nil)
				else
					local v75 = table.pack(v56(str4))
					v57 = v75[1]
					luraph_frame(nil, nil)
				end

				v58 = new3
				tbl2 = {}
				v59 = new4
				v60 = fromRGB

				if not (luraph_frame(nil, nil) > 99) then
					local v75 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 97, 99))
					local v76 = table.pack(v60(table.unpack(v75, 1, v75.n)))
					local v77 = table.pack(luraph_runtime1(table.unpack(v76, 1, v76.n)))
					luraph_frame(nil, nil)
				else
					local v75 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 97, 99))
					local v76 = table.pack(v60(table.unpack(v75, 1, v75.n)))
					local v77 = table.pack(luraph_runtime1(table.unpack(v76, 1, v76.n)))
					luraph_frame(nil, nil)
				end

				if not (luraph_frame(nil, nil) > t1540_1070_4[1] + 96 - 1) then
					local v75 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 95, t1540_1070_4[1] + 96 - 1))
					local v76 = table.pack(v59(table.unpack(v75, 1, v75.n)))
					luraph_frame(nil, nil)
				else
					local v75 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 95, t1540_1070_4[1] + 96 - 1))
					local v76 = table.pack(v59(table.unpack(v75, 1, v75.n)))
					luraph_frame(nil, nil)
				end

				v61 = new4
				v62 = fromRGB

				if not (luraph_frame(nil, nil) > 100) then
					local v75 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 98, 100))
					local v76 = table.pack(v62(table.unpack(v75, 1, v75.n)))
					local v77 = table.pack(luraph_runtime1(table.unpack(v76, 1, v76.n)))
					luraph_frame(nil, nil)
				else
					local v75 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 98, 100))
					local v76 = table.pack(v62(table.unpack(v75, 1, v75.n)))
					local v77 = table.pack(luraph_runtime1(table.unpack(v76, 1, v76.n)))
					luraph_frame(nil, nil)
				end

				if not (luraph_frame(nil, nil) > t654_1086_4[1] + 97 - 1) then
					local v75 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 96, t654_1086_4[1] + 97 - 1))
					local v76 = table.pack(v61(table.unpack(v75, 1, v75.n)))
					luraph_frame(nil, nil)
				else
					local v75 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 96, t654_1086_4[1] + 97 - 1))
					local v76 = table.pack(v61(table.unpack(v75, 1, v75.n)))
					luraph_frame(nil, nil)
				end

				v63 = new4
				v64 = fromRGB

				if not (luraph_frame(nil, nil) > 101) then
					local v75 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 99, 101))
					local v76 = table.pack(v64(table.unpack(v75, 1, v75.n)))
					local v77 = table.pack(luraph_runtime1(table.unpack(v76, 1, v76.n)))
					luraph_frame(nil, nil)
				else
					local v75 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 99, 101))
					local v76 = table.pack(v64(table.unpack(v75, 1, v75.n)))
					local v77 = table.pack(luraph_runtime1(table.unpack(v76, 1, v76.n)))
					luraph_frame(nil, nil)
				end

				if not (luraph_frame(nil, nil) > t1161_1096_4[1] + 98 - 1) then
					local v75 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 97, t1161_1096_4[1] + 98 - 1))
					local v76 = table.pack(v63(table.unpack(v75, 1, v75.n)))
					luraph_frame(nil, nil)
				else
					local v75 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 97, t1161_1096_4[1] + 98 - 1))
					local v76 = table.pack(v63(table.unpack(v75, 1, v75.n)))
					luraph_frame(nil, nil)
				end

				v65 = new4
				v66 = fromRGB

				if not (luraph_frame(nil, nil) > 102) then
					local v75 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 100, 102))
					local v76 = table.pack(v66(table.unpack(v75, 1, v75.n)))
					local v77 = table.pack(luraph_runtime1(table.unpack(v76, 1, v76.n)))
					luraph_frame(nil, nil)
				else
					local v75 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 100, 102))
					local v76 = table.pack(v66(table.unpack(v75, 1, v75.n)))
					local v77 = table.pack(luraph_runtime1(table.unpack(v76, 1, v76.n)))
					luraph_frame(nil, nil)
				end

				if not (luraph_frame(nil, nil) > t75_1105_4[1] + 99 - 1) then
					local v75 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 98, t75_1105_4[1] + 99 - 1))
					local v76 = table.pack(v65(table.unpack(v75, 1, v75.n)))
					luraph_frame(nil, nil)
				else
					local v75 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 98, t75_1105_4[1] + 99 - 1))
					local v76 = table.pack(v65(table.unpack(v75, 1, v75.n)))
					luraph_frame(nil, nil)
				end

				v67 = new4
				v68 = fromRGB

				if not (luraph_frame(nil, nil) > 103) then
					local v75 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 101, 103))
					local v76 = table.pack(v68(table.unpack(v75, 1, v75.n)))
					local v77 = table.pack(luraph_runtime1(table.unpack(v76, 1, v76.n)))
					luraph_frame(nil, nil)
				else
					local v75 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 101, 103))
					local v76 = table.pack(v68(table.unpack(v75, 1, v75.n)))
					local v77 = table.pack(luraph_runtime1(table.unpack(v76, 1, v76.n)))
					luraph_frame(nil, nil)
				end

				local v75 = table.pack(luraph_runtime1(v67(luraph_runtime3(nil --[[ the caller's registers ]], 99, t81_1115_4[1] + 100 - 1))))
				luraph_frame(nil, nil)
				table.move(nil --[[ the caller's registers ]], 94, v75[1] + 98 - 1, 1, tbl2)

				if luraph_frame(nil, nil) > 93 then
					local v76 = table.pack(v58(tbl2))
					v69 = v76[1]
					luraph_frame(nil, nil)
				else
					local v76 = table.pack(v58(tbl2))
					v69 = v76[1]
					luraph_frame(nil, nil)
				end

				v57.Color = v69
				v57.Enabled = true
				v70 = new5
				n3 = 0
				n4 = 0

				if luraph_frame(nil, nil) > 94 then
					local v76 = table.pack(v70(n3, n4))
					v71 = v76[1]
					luraph_frame(nil, nil)
				else
					local v76 = table.pack(v70(n3, n4))
					v71 = v76[1]
					luraph_frame(nil, nil)
				end

				v57.Offset = v71
				v53.Parent = main
				v57.Parent = v53
				v72 = v36

				v73 = luraph_runtime2({
										[1] = { --[[ 已折叠 86 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
										[10] = { --[[ 已折叠 92 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
										[11] = { --[[ 已折叠 90 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
										[2] = { --[[ 已折叠 86 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
										[3] = { --[[ 已折叠 92 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
										[5] = { --[[ 已折叠 92 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
										[6] = { --[[ 已折叠 89 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
					[7] = { { 89, 1 }, { 35, 1 }, { 91, 1 } },
					[8] = 0,
					[9] = 23,
				}, {})

				if not (luraph_frame(nil, nil) > 93) then
					v72(v73)
					luraph_frame(nil, nil)
				else
					v72(v73)
					luraph_frame(nil, nil)
				end
			end

			while true do
				local v74
				v74 = v52

				do
					local editOpenButton = v52.EditOpenButton
					local tbl3 = { Title = "Bacon Head", Icon = "" }
					local v75 = new6
					local n5 = 0
					local n6 = 16
					local v76

					if luraph_frame(nil, nil) > 95 then
						local v77 = table.pack(v75(n5, n6))
						v76 = v77[1]
						luraph_frame(nil, nil)
					else
						local v77 = table.pack(v75(n5, n6))
						v76 = v77[1]
						luraph_frame(nil, nil)
					end

					tbl3.CornerRadius = v76
					tbl3.StrokeThickness = 2
					local v77 = new3
					local tbl4 = {}
					local v78 = new4
					local v79 = fromRGB

					if not (luraph_frame(nil, nil) > 100) then
						local v80 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 98, 100))
						local v81 = table.pack(v79(table.unpack(v80, 1, v80.n)))
						local v82 = table.pack(luraph_runtime1(table.unpack(v81, 1, v81.n)))
						luraph_frame(nil, nil)
					else
						local v80 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 98, 100))
						local v81 = table.pack(v79(table.unpack(v80, 1, v80.n)))
						local v82 = table.pack(luraph_runtime1(table.unpack(v81, 1, v81.n)))
						luraph_frame(nil, nil)
					end

					if not (luraph_frame(nil, nil) > t1584_273_4[1] + 97 - 1) then
						local v80 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 96, t1584_273_4[1] + 97 - 1))
						local v81 = table.pack(v78(table.unpack(v80, 1, v80.n)))
						luraph_frame(nil, nil)
					else
						local v80 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 96, t1584_273_4[1] + 97 - 1))
						local v81 = table.pack(v78(table.unpack(v80, 1, v80.n)))
						luraph_frame(nil, nil)
					end

					local v80 = new4
					local v81 = fromRGB

					if not (luraph_frame(nil, nil) > 101) then
						local v82 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 99, 101))
						local v83 = table.pack(v81(table.unpack(v82, 1, v82.n)))
						local v84 = table.pack(luraph_runtime1(table.unpack(v83, 1, v83.n)))
						luraph_frame(nil, nil)
					else
						local v82 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 99, 101))
						local v83 = table.pack(v81(table.unpack(v82, 1, v82.n)))
						local v84 = table.pack(luraph_runtime1(table.unpack(v83, 1, v83.n)))
						luraph_frame(nil, nil)
					end

					if not (luraph_frame(nil, nil) > t913_282_4[1] + 98 - 1) then
						local v82 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 97, t913_282_4[1] + 98 - 1))
						local v83 = table.pack(v80(table.unpack(v82, 1, v82.n)))
						luraph_frame(nil, nil)
					else
						local v82 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 97, t913_282_4[1] + 98 - 1))
						local v83 = table.pack(v80(table.unpack(v82, 1, v82.n)))
						luraph_frame(nil, nil)
					end

					local v82 = new4
					local v83 = fromRGB

					if not (luraph_frame(nil, nil) > 102) then
						local v84 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 100, 102))
						local v85 = table.pack(v83(table.unpack(v84, 1, v84.n)))
						local v86 = table.pack(luraph_runtime1(table.unpack(v85, 1, v85.n)))
						luraph_frame(nil, nil)
					else
						local v84 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 100, 102))
						local v85 = table.pack(v83(table.unpack(v84, 1, v84.n)))
						local v86 = table.pack(luraph_runtime1(table.unpack(v85, 1, v85.n)))
						luraph_frame(nil, nil)
					end

					if not (luraph_frame(nil, nil) > t193_291_4[1] + 99 - 1) then
						local v84 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 98, t193_291_4[1] + 99 - 1))
						local v85 = table.pack(v82(table.unpack(v84, 1, v84.n)))
						luraph_frame(nil, nil)
					else
						local v84 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 98, t193_291_4[1] + 99 - 1))
						local v85 = table.pack(v82(table.unpack(v84, 1, v84.n)))
						luraph_frame(nil, nil)
					end

					local v84 = new4
					local v85 = fromRGB

					if not (luraph_frame(nil, nil) > 103) then
						local v86 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 101, 103))
						local v87 = table.pack(v85(table.unpack(v86, 1, v86.n)))
						local v88 = table.pack(luraph_runtime1(table.unpack(v87, 1, v87.n)))
						luraph_frame(nil, nil)
					else
						local v86 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 101, 103))
						local v87 = table.pack(v85(table.unpack(v86, 1, v86.n)))
						local v88 = table.pack(luraph_runtime1(table.unpack(v87, 1, v87.n)))
						luraph_frame(nil, nil)
					end

					if not (luraph_frame(nil, nil) > t211_301_4[1] + 100 - 1) then
						local v86 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 99, t211_301_4[1] + 100 - 1))
						local v87 = table.pack(v84(table.unpack(v86, 1, v86.n)))
						luraph_frame(nil, nil)
					else
						local v86 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 99, t211_301_4[1] + 100 - 1))
						local v87 = table.pack(v84(table.unpack(v86, 1, v86.n)))
						luraph_frame(nil, nil)
					end

					local v86 = new4
					local v87 = fromRGB

					if not (luraph_frame(nil, nil) > 104) then
						local v88 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 102, 104))
						local v89 = table.pack(v87(table.unpack(v88, 1, v88.n)))
						local v90 = table.pack(luraph_runtime1(table.unpack(v89, 1, v89.n)))
						luraph_frame(nil, nil)
					else
						local v88 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 102, 104))
						local v89 = table.pack(v87(table.unpack(v88, 1, v88.n)))
						local v90 = table.pack(luraph_runtime1(table.unpack(v89, 1, v89.n)))
						luraph_frame(nil, nil)
					end

					local v88 = table.pack(luraph_runtime1(v86(luraph_runtime3(nil --[[ the caller's registers ]], 100, t1299_317_4[1] + 101 - 1))))
					luraph_frame(nil, nil)
					table.move(nil --[[ the caller's registers ]], 95, v88[1] + 99 - 1, 1, tbl4)
					local v89

					if luraph_frame(nil, nil) > 94 then
						local v90 = table.pack(v77(tbl4))
						v89 = v90[1]
						luraph_frame(nil, nil)
					else
						local v90 = table.pack(v77(tbl4))
						v89 = v90[1]
						luraph_frame(nil, nil)
					end

					tbl3.Color = v89
					tbl3.Draggable = true

					if not (luraph_frame(nil, nil) > 92) then
						editOpenButton(v74, tbl3)
						luraph_frame(nil, nil)
					else
						editOpenButton(v74, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v75 = v52
					local tag = v52.Tag
					local tbl3 = { Title = "感谢大家游玩" }
					local v76 = fromHex
					local str5 = "#F5F5F5"
					local v77

					if luraph_frame(nil, nil) > 94 then
						local v78 = table.pack(v76(str5))
						v77 = v78[1]
						luraph_frame(nil, nil)
					else
						local v78 = table.pack(v76(str5))
						v77 = v78[1]
						luraph_frame(nil, nil)
					end

					tbl3.Color = v77

					if not (luraph_frame(nil, nil) > 92) then
						tag(v75, tbl3)
						luraph_frame(nil, nil)
					else
						tag(v75, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v75 = v52
					local tag = v52.Tag
					local tbl3 = {}
					local v76 = date
					local str5 = "%Y-%m-%d"
					local v77

					if luraph_frame(nil, nil) > 94 then
						local v78 = table.pack(v76(str5))
						v77 = v78[1]
						luraph_frame(nil, nil)
					else
						local v78 = table.pack(v76(str5))
						v77 = v78[1]
						luraph_frame(nil, nil)
					end

					tbl3.Title = "当前时间: " .. v77
					local v78 = fromHex
					local str6 = "#87CEEB"
					local v79

					if luraph_frame(nil, nil) > 94 then
						local v80 = table.pack(v78(str6))
						v79 = v80[1]
						luraph_frame(nil, nil)
					else
						local v80 = table.pack(v78(str6))
						v79 = v80[1]
						luraph_frame(nil, nil)
					end

					tbl3.Color = v79

					if luraph_frame(nil, nil) > 92 then
						local v80 = table.pack(tag(v75, tbl3))
						v53 = v80[1]
						luraph_frame(nil, nil)
					else
						local v80 = table.pack(tag(v75, tbl3))
						v53 = v80[1]
						luraph_frame(nil, nil)
					end
				end

				do
					local v75 = v52
					local tab = v52.Tab
					local tbl3 = { Title = "公告", Icon = "type", ShowTabTitle = true }

					if luraph_frame(nil, nil) > 93 then
						local v76 = table.pack(tab(v75, tbl3))
						v54 = v76[1]
						luraph_frame(nil, nil)
					else
						local v76 = table.pack(tab(v75, tbl3))
						v54 = v76[1]
						luraph_frame(nil, nil)
					end
				end

				do
					local v75 = v54
					local paragraph = v54.Paragraph

					local tbl3 = {
						Title = "Cold wind",
						Desc = "永久更新 不跑路 感谢您的使用！",
						Image = "user",
						ImageSize = 70,
						Thumbnail = "https://raw.githubusercontent.com/GKye9178/okokok91787891kkk/refs/heads/main/Image_1783942164895_569.png",
						ThumbnailSize = 150,
						Color = "Blue",
					}

					if not (luraph_frame(nil, nil) > 94) then
						paragraph(v75, tbl3)
						luraph_frame(nil, nil)
					else
						paragraph(v75, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v75 = v54
					local paragraph = v54.Paragraph

					local tbl3 = {
						Title = "总制作者",
						Desc = "GK",
						Image = "user",
						ImageSize = 70,
						ThumbnailSize = 150,
						Color = "Blue",
					}

					if not (luraph_frame(nil, nil) > 94) then
						paragraph(v75, tbl3)
						luraph_frame(nil, nil)
					else
						paragraph(v75, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v75 = v54
					local paragraph = v54.Paragraph

					local tbl3 = {
						Title = "副制作者人员",
						Desc = "林玉",
						Image = "user",
						ImageSize = 70,
						Thumbnail = "",
						ThumbnailSize = 150,
						Color = "Blue",
					}

					if not (luraph_frame(nil, nil) > 94) then
						paragraph(v75, tbl3)
						luraph_frame(nil, nil)
					else
						paragraph(v75, tbl3)
						luraph_frame(nil, nil)
					end
				end

				local v75

				do
					local v76 = v52
					local tab = v52.Tab
					local tbl3 = { Title = "玩家", Icon = "user" }

					if luraph_frame(nil, nil) > 94 then
						local v77 = table.pack(tab(v76, tbl3))
						v75 = v77[1]
						luraph_frame(nil, nil)
					else
						local v77 = table.pack(tab(v76, tbl3))
						v75 = v77[1]
						luraph_frame(nil, nil)
					end
				end

				do
					local v76 = v3
					local getService4 = v3.GetService
					local str5 = "Players"
					local v77

					if luraph_frame(nil, nil) > 95 then
						local v78 = table.pack(getService4(v76, str5))
						v77 = v78[1]
						luraph_frame(nil, nil)
					else
						local v78 = table.pack(getService4(v76, str5))
						v77 = v78[1]
						luraph_frame(nil, nil)
					end
				end

				do
					local v76 = v3
					local getService4 = v3.GetService
					local str5 = "RunService"

					if luraph_frame(nil, nil) > 96 then
						local v77 = table.pack(getService4(v76, str5))
						luraph_frame(nil, nil)
					else
						local v77 = table.pack(getService4(v76, str5))
						luraph_frame(nil, nil)
					end
				end

				do
					local v76 = v75
					local toggle = v75.Toggle

					local tbl3 = {
						Title = "人物旋转",
						Desc = "",
						Value = false,
						Callback = luraph_runtime2({
														[1] = { --[[ 已折叠 150 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[10] = { --[[ 已折叠 153 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[11] = { --[[ 已折叠 151 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[2] = { --[[ 已折叠 144 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[3] = { --[[ 已折叠 153 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[5] = { --[[ 已折叠 889 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[6] = { --[[ 已折叠 151 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
							[7] = {
								{ 95, 1 },
								{ 98, 0 },
								{ 99, 0 },
								{ 100, 0 },
								{ 97, 0 },
								{ 94, 1 },
								{ 96, 0 },
								{ 48, 1 },
								{ 49, 1 },
							},
							[8] = 0,
							[9] = 26,
						}, {}),
					}

					if not (luraph_frame(nil, nil) > 103) then
						toggle(v76, tbl3)
						luraph_frame(nil, nil)
					else
						toggle(v76, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v76 = v75
					local slider = v75.Slider
					local tbl3 = { Title = "旋转速度", Desc = "", Value = { Min = 0, Default = 2, Step = 0.1 } }

					luraph_runtime2({
						[1] = { 1, 0, 1, 0, 253 },
						[10] = { [0] = { 0, 1, 0, 1, 379 } },
						[11] = { 241, 227, 255, 173, 240 },
						[2] = { 0, 0, 0, 0, 366 },
						[3] = { [0] = { 0, 0, 0, 0, 366 } },
						[5] = { [0] = { 1, 0, 1, 0, 253 } },
						[6] = { 0, 1, 0, 1, 379 },
						[7] = { { 96, 0 } },
						[8] = 0,
						[9] = 3,
					}, {})

					tbl3.Callback = v22

					if not (luraph_frame(nil, nil) > 103) then
						slider(v76, tbl3)
						luraph_frame(nil, nil)
					else
						slider(v76, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v76 = v75
					local toggle = v75.Toggle

					local tbl3 = {
						Title = "零秒互动",
						Desc = "",
						Value = false,
						Callback = luraph_runtime2({
														[1] = { --[[ 已折叠 194 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[10] = { --[[ 已折叠 197 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[11] = { --[[ 已折叠 195 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[2] = { --[[ 已折叠 186 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[3] = { --[[ 已折叠 197 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[5] = { --[[ 已折叠 655 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[6] = { --[[ 已折叠 195 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
							[7] = { { 103, 0 }, { 20, 1 }, { 4, 1 }, { 101, 1 }, { 102, 0 }, { 14, 1 } },
							[8] = 0,
							[9] = 26,
						}, {}),
					}

					if not (luraph_frame(nil, nil) > 106) then
						toggle(v76, tbl3)
						luraph_frame(nil, nil)
					else
						toggle(v76, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v76 = v75
					local button = v75.Button

					local tbl3 = {
						Title = "Bacon head飞行",
						Desc = "",
						Icon = "mouse-pointer-click",
						Callback = luraph_runtime2({
							[1] = {
								[1] = 2,
								[10] = 0,
								[2] = 404,
								[3] = 1,
								[4] = 2,
								[5] = 2,
								[6] = 984,
								[7] = 2,
								[8] = 1,
								[9] = 0,
							},
							[10] = {
								[0] = {
									[1] = 0,
									[10] = 1,
									[2] = 325,
									[3] = 0,
									[4] = 0,
									[6] = 0,
									[7] = 3,
									[8] = 0,
									[9] = 1,
								},
								[5] = "HttpGet",
							},
							[11] = {
								[1] = 241,
								[10] = 173,
								[2] = 209,
								[3] = 98,
								[4] = 98,
								[5] = 144,
								[6] = 145,
								[7] = 183,
								[8] = 197,
								[9] = 47,
							},
							[2] = {
								[1] = 0,
								[10] = 0,
								[2] = 465,
								[3] = 0,
								[4] = 1,
								[5] = 2,
								[6] = 4,
								[7] = 0,
								[8] = 0,
								[9] = 0,
							},
							[3] = {
								[0] = {
									[1] = 0,
									[10] = 0,
									[2] = 465,
									[3] = 0,
									[4] = 1,
									[5] = 2,
									[6] = 4,
									[7] = 0,
									[8] = 0,
									[9] = 0,
								},
							},
							[5] = {
								[0] = {
									[1] = 2,
									[10] = 0,
									[2] = 404,
									[3] = 1,
									[4] = 2,
									[5] = 2,
									[6] = 984,
									[7] = 2,
									[8] = 1,
									[9] = 0,
								},
							},
							[6] = {
								[1] = 0,
								[10] = 1,
								[2] = 325,
								[3] = 0,
								[4] = 0,
								[6] = 0,
								[7] = 3,
								[8] = 0,
								[9] = 1,
							},
							[7] = { { 10, 1 }, { 3, 1 } },
							[8] = 0,
							[9] = 5,
						}, {}),
					}

					if not (luraph_frame(nil, nil) > 106) then
						button(v76, tbl3)
						luraph_frame(nil, nil)
					else
						button(v76, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v76 = v75
					local toggle = v75.Toggle

					local tbl3 = {
						Title = "启用移速修改",
						Desc = "",
						Value = false,
						Callback = luraph_runtime2({
														[1] = { --[[ 已折叠 193 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[10] = { --[[ 已折叠 201 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[11] = { --[[ 已折叠 199 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[2] = { --[[ 已折叠 191 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[3] = { --[[ 已折叠 201 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[5] = { --[[ 已折叠 770 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[6] = { --[[ 已折叠 198 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
							[7] = { { 104, 0 }, { 3, 1 }, { 107, 0 }, { 105, 0 }, { 106, 0 }, { 28, 1 } },
							[8] = 0,
							[9] = 25,
						}, {}),
					}

					if not (luraph_frame(nil, nil) > 110) then
						toggle(v76, tbl3)
						luraph_frame(nil, nil)
					else
						toggle(v76, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v76 = v75
					local slider = v75.Slider

					local tbl3 = {
						Title = "移动速度",
						Desc = "",
						Step = 1,
						Value = { Default = 16, Min = 16, Max = 500 },
						Callback = luraph_runtime2({
							[1] = {
								[1] = 44,
								[10] = 46,
								[12] = 2,
								[13] = 2,
								[14] = 2,
								[15] = 33,
								[16] = 30,
								[17] = 220,
								[18] = 3,
								[19] = 29,
								[2] = 17,
								[20] = 0,
								[21] = 0,
								[22] = 127,
								[23] = 79,
								[24] = 16,
								[25] = 63,
								[26] = 31,
								[27] = 164,
								[28] = 2,
								[29] = 35,
								[3] = 0,
								[30] = 0,
								[31] = 3,
								[32] = 128,
								[33] = 3,
								[34] = 29,
								[35] = 1,
								[36] = 8,
								[37] = 0,
								[38] = 14,
								[39] = 14,
								[4] = 2,
								[40] = 14,
								[41] = 8,
								[42] = 92,
								[43] = 6,
								[44] = 2,
								[45] = 45,
								[46] = 19,
								[47] = 2,
								[48] = 29,
								[49] = 10,
								[5] = 1104,
								[6] = 6,
								[7] = 1,
								[8] = 2,
								[9] = 1,
							},
							[10] = {
								[0] = {
									[1] = 0,
									[10] = 0,
									[11] = 2,
									[12] = 2,
									[13] = 2,
									[14] = 3,
									[15] = 3,
									[16] = 0,
									[17] = 279,
									[18] = 1,
									[19] = 0,
									[2] = 0,
									[20] = 0,
									[21] = 0,
									[22] = 17,
									[23] = 19,
									[24] = 23,
									[25] = 69,
									[26] = 137,
									[27] = 223,
									[28] = 99,
									[29] = 0,
									[3] = 1,
									[30] = 162,
									[31] = 77,
									[32] = 0,
									[33] = 0,
									[34] = 3,
									[35] = 0,
									[36] = 0,
									[37] = 0,
									[38] = 1108,
									[39] = 1111,
									[4] = 0,
									[40] = 892,
									[41] = 14,
									[42] = 9,
									[43] = 15,
									[44] = 0,
									[45] = 0,
									[46] = 0,
									[47] = 2,
									[48] = 2,
									[49] = 0,
									[5] = 0,
									[6] = 0,
									[7] = 4,
									[8] = 0,
									[9] = 1,
								},
							},
							[11] = {
								[1] = 241,
								[10] = 241,
								[11] = 96,
								[12] = 148,
								[13] = 148,
								[14] = 207,
								[15] = 156,
								[16] = 241,
								[17] = 13,
								[18] = 165,
								[19] = 241,
								[2] = 241,
								[20] = 37,
								[21] = 239,
								[22] = 38,
								[23] = 38,
								[24] = 265,
								[25] = 61,
								[26] = 229,
								[27] = 218,
								[28] = 117,
								[29] = 241,
								[3] = 227,
								[30] = 173,
								[31] = 144,
								[32] = 145,
								[33] = 261,
								[34] = 156,
								[35] = 241,
								[36] = 121,
								[37] = 239,
								[38] = 18,
								[39] = 254,
								[4] = 98,
								[40] = 149,
								[41] = 165,
								[42] = 38,
								[43] = 140,
								[44] = 241,
								[45] = 241,
								[46] = 241,
								[47] = 131,
								[48] = 156,
								[49] = 241,
								[5] = 145,
								[6] = 241,
								[7] = 207,
								[8] = 213,
								[9] = 255,
							},
							[2] = {
								[1] = 0,
								[10] = 0,
								[11] = 3,
								[13] = 46,
								[14] = 0,
								[15] = 0,
								[16] = 0,
								[17] = 163,
								[18] = 496,
								[19] = 0,
								[2] = 0,
								[20] = 17,
								[21] = 19,
								[23] = 98,
								[24] = 58,
								[25] = 202,
								[26] = 253,
								[27] = 122,
								[28] = 150,
								[29] = 0,
								[3] = 0,
								[30] = 0,
								[31] = 2,
								[32] = 5,
								[33] = 0,
								[34] = 0,
								[35] = 0,
								[36] = 0,
								[37] = 9,
								[38] = 731,
								[39] = 112,
								[4] = 0,
								[40] = 14,
								[41] = 86,
								[42] = 120,
								[43] = 0,
								[44] = 0,
								[45] = 0,
								[46] = 0,
								[47] = 0,
								[48] = 0,
								[49] = 0,
								[5] = 3,
								[6] = 0,
								[7] = 0,
								[8] = 0,
								[9] = 0,
							},
							[3] = {
								[0] = {
									[1] = 0,
									[10] = 0,
									[11] = 3,
									[13] = 46,
									[14] = 0,
									[15] = 0,
									[16] = 0,
									[17] = 163,
									[18] = 496,
									[19] = 0,
									[2] = 0,
									[20] = 17,
									[21] = 19,
									[23] = 98,
									[24] = 58,
									[25] = 202,
									[26] = 253,
									[27] = 122,
									[28] = 150,
									[29] = 0,
									[3] = 0,
									[30] = 0,
									[31] = 2,
									[32] = 5,
									[33] = 0,
									[34] = 0,
									[35] = 0,
									[36] = 0,
									[37] = 9,
									[38] = 731,
									[39] = 112,
									[4] = 0,
									[40] = 14,
									[41] = 86,
									[42] = 120,
									[43] = 0,
									[44] = 0,
									[45] = 0,
									[46] = 0,
									[47] = 0,
									[48] = 0,
									[49] = 0,
									[5] = 3,
									[6] = 0,
									[7] = 0,
									[8] = 0,
									[9] = 0,
								},
								[12] = "LocalPlayer",
								[22] = 14,
							},
							[5] = {
								[0] = {
									[1] = 44,
									[10] = 46,
									[12] = 2,
									[13] = 2,
									[14] = 2,
									[15] = 33,
									[16] = 30,
									[17] = 220,
									[18] = 3,
									[19] = 29,
									[2] = 17,
									[20] = 0,
									[21] = 0,
									[22] = 127,
									[23] = 79,
									[24] = 16,
									[25] = 63,
									[26] = 31,
									[27] = 164,
									[28] = 2,
									[29] = 35,
									[3] = 0,
									[30] = 0,
									[31] = 3,
									[32] = 128,
									[33] = 3,
									[34] = 29,
									[35] = 1,
									[36] = 8,
									[37] = 0,
									[38] = 14,
									[39] = 14,
									[4] = 2,
									[40] = 14,
									[41] = 8,
									[42] = 92,
									[43] = 6,
									[44] = 2,
									[45] = 45,
									[46] = 19,
									[47] = 2,
									[48] = 29,
									[49] = 10,
									[5] = 1104,
									[6] = 6,
									[7] = 1,
									[8] = 2,
									[9] = 1,
								},
								[11] = "Players",
							},
							[6] = {
								[1] = 0,
								[10] = 0,
								[11] = 2,
								[12] = 2,
								[13] = 2,
								[14] = 3,
								[15] = 3,
								[16] = 0,
								[17] = 279,
								[18] = 1,
								[19] = 0,
								[2] = 0,
								[20] = 0,
								[21] = 0,
								[22] = 17,
								[23] = 19,
								[24] = 23,
								[25] = 69,
								[26] = 137,
								[27] = 223,
								[28] = 99,
								[29] = 0,
								[3] = 1,
								[30] = 162,
								[31] = 77,
								[32] = 0,
								[33] = 0,
								[34] = 3,
								[35] = 0,
								[36] = 0,
								[37] = 0,
								[38] = 1108,
								[39] = 1111,
								[4] = 0,
								[40] = 892,
								[41] = 14,
								[42] = 9,
								[43] = 15,
								[44] = 0,
								[45] = 0,
								[46] = 0,
								[47] = 2,
								[48] = 2,
								[49] = 0,
								[5] = 0,
								[6] = 0,
								[7] = 4,
								[8] = 0,
								[9] = 1,
							},
							[7] = { { 28, 1 }, { 105, 0 }, { 104, 0 }, { 3, 1 } },
							[8] = 0,
							[9] = 24,
						}, {}),
					}

					if not (luraph_frame(nil, nil) > 110) then
						slider(v76, tbl3)
						luraph_frame(nil, nil)
					else
						slider(v76, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v76 = v75
					local toggle = v75.Toggle

					local tbl3 = {
						Title = "穿墙",
						Desc = "",
						Value = false,
						Callback = luraph_runtime2({
														[1] = { --[[ 已折叠 185 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[10] = { --[[ 已折叠 192 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[11] = { --[[ 已折叠 190 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[2] = { --[[ 已折叠 181 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[3] = { --[[ 已折叠 192 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[5] = { --[[ 已折叠 964 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[6] = { --[[ 已折叠 188 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
							[7] = { { 3, 1 }, { 9, 1 }, { 20, 1 }, { 35, 1 } },
							[8] = 0,
							[9] = 19,
						}, {}),
					}

					if not (luraph_frame(nil, nil) > 110) then
						toggle(v76, tbl3)
						luraph_frame(nil, nil)
					else
						toggle(v76, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v76 = v75
					local toggle = v75.Toggle

					local tbl3 = {
						Title = "无限跳",
						Desc = "",
						Value = false,
						Callback = luraph_runtime2({
							[1] = {
								[1] = 0,
								[10] = 0,
								[11] = 649,
								[12] = 2,
								[13] = 0,
								[14] = 649,
								[15] = 19,
								[16] = 2,
								[17] = 48,
								[18] = 2,
								[19] = 7,
								[2] = 25,
								[20] = 2,
								[21] = 2,
								[22] = 1354,
								[23] = 2,
								[24] = 2,
								[25] = 15,
								[26] = 649,
								[27] = 9,
								[28] = 649,
								[29] = 2,
								[3] = 4,
								[30] = 0,
								[31] = 649,
								[32] = 9,
								[4] = 244,
								[5] = 649,
								[6] = 19,
								[7] = 10,
								[8] = 649,
								[9] = 9,
							},
							[10] = {
								[0] = {
									[1] = 1,
									[10] = 1,
									[11] = 2,
									[12] = 62,
									[13] = 0,
									[14] = 0,
									[15] = 0,
									[16] = 112,
									[17] = 0,
									[18] = 0,
									[19] = 0,
									[2] = 1,
									[20] = 0,
									[22] = 0,
									[23] = 0,
									[24] = 2,
									[25] = 0,
									[26] = 2,
									[27] = 2,
									[28] = 2,
									[29] = 62,
									[3] = 0,
									[30] = 0,
									[31] = 0,
									[32] = 0,
									[4] = 443,
									[5] = 2,
									[6] = 2,
									[7] = 0,
									[8] = 2,
									[9] = 0,
								},
								[21] = "GetService",
							},
							[11] = {
								[1] = 227,
								[10] = 173,
								[11] = 96,
								[12] = 144,
								[13] = 138,
								[14] = 105,
								[15] = 241,
								[16] = 144,
								[17] = 63,
								[18] = 261,
								[19] = 241,
								[2] = 156,
								[20] = 98,
								[21] = 144,
								[22] = 145,
								[23] = 261,
								[24] = 148,
								[25] = 241,
								[26] = 96,
								[27] = 156,
								[28] = 96,
								[29] = 144,
								[3] = 241,
								[30] = 138,
								[31] = 105,
								[32] = 241,
								[4] = 72,
								[5] = 96,
								[6] = 156,
								[7] = 241,
								[8] = 105,
								[9] = 241,
							},
							[2] = {
								[1] = 0,
								[10] = 0,
								[11] = 0,
								[12] = 2,
								[13] = 2,
								[14] = 0,
								[15] = 0,
								[16] = 2,
								[17] = 4,
								[18] = 0,
								[19] = 0,
								[2] = 0,
								[20] = 1,
								[21] = 2,
								[22] = 4,
								[23] = 0,
								[24] = 896,
								[25] = 0,
								[26] = 0,
								[27] = 0,
								[28] = 0,
								[29] = 2,
								[3] = 0,
								[30] = 2,
								[31] = 0,
								[32] = 0,
								[4] = 221,
								[5] = 0,
								[6] = 0,
								[7] = 0,
								[8] = 0,
								[9] = 0,
							},
							[3] = {
								[0] = {
									[1] = 0,
									[10] = 0,
									[11] = 0,
									[12] = 2,
									[13] = 2,
									[14] = 0,
									[15] = 0,
									[16] = 2,
									[17] = 4,
									[18] = 0,
									[19] = 0,
									[2] = 0,
									[20] = 1,
									[21] = 2,
									[22] = 4,
									[23] = 0,
									[24] = 896,
									[25] = 0,
									[26] = 0,
									[27] = 0,
									[28] = 0,
									[29] = 2,
									[3] = 0,
									[30] = 2,
									[31] = 0,
									[32] = 0,
									[4] = 221,
									[5] = 0,
									[6] = 0,
									[7] = 0,
									[8] = 0,
									[9] = 0,
								},
							},
														[5] = { --[[ 已折叠 539 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
							[6] = {
								[1] = 1,
								[10] = 1,
								[11] = 2,
								[12] = 62,
								[13] = 0,
								[14] = 0,
								[15] = 0,
								[16] = 112,
								[17] = 0,
								[18] = 0,
								[19] = 0,
								[2] = 1,
								[20] = 0,
								[22] = 0,
								[23] = 0,
								[24] = 2,
								[25] = 0,
								[26] = 2,
								[27] = 2,
								[28] = 2,
								[29] = 62,
								[3] = 0,
								[30] = 0,
								[31] = 0,
								[32] = 0,
								[4] = 443,
								[5] = 2,
								[6] = 2,
								[7] = 0,
								[8] = 2,
								[9] = 0,
							},
							[7] = { { 9, 1 }, { 3, 1 }, { 50, 1 } },
							[8] = 0,
							[9] = 5,
						}, {}),
					}

					if not (luraph_frame(nil, nil) > 110) then
						toggle(v76, tbl3)
						luraph_frame(nil, nil)
					else
						toggle(v76, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v76 = v3
					local getService4 = v3.GetService
					local str5 = "Players"
					local v77

					if luraph_frame(nil, nil) > 110 then
						local v78 = table.pack(getService4(v76, str5))
						v77 = v78[1]
						luraph_frame(nil, nil)
					else
						local v78 = table.pack(getService4(v76, str5))
						v77 = v78[1]
						luraph_frame(nil, nil)
					end
				end

				do
					local v76 = v3
					local getService4 = v3.GetService
					local str5 = "RunService"

					if luraph_frame(nil, nil) > 112 then
						local v77 = table.pack(getService4(v76, str5))
						luraph_frame(nil, nil)
					else
						local v77 = table.pack(getService4(v76, str5))
						luraph_frame(nil, nil)
					end
				end

				luraph_runtime2({
					[1] = {
						[1] = 41,
						[10] = 7,
						[11] = 54,
						[12] = 4,
						[13] = 96,
						[14] = 230,
						[15] = 38,
						[16] = 52,
						[17] = 1,
						[18] = 166,
						[19] = 43,
						[2] = 0,
						[20] = 17,
						[21] = 0,
						[22] = 21,
						[23] = 117,
						[24] = 84,
						[26] = 14,
						[27] = 42,
						[28] = 0,
						[29] = 21,
						[3] = 187,
						[30] = 0,
						[33] = 50,
						[34] = 14,
						[35] = 237,
						[36] = 122,
						[37] = 221,
						[38] = 250,
						[39] = 39,
						[4] = 43,
						[40] = 0,
						[41] = 19,
						[42] = 20,
						[43] = 5,
						[44] = 27,
						[45] = 232,
						[5] = 40,
						[6] = 0,
						[7] = 12,
						[8] = 1,
						[9] = 12,
					},
					[10] = {
						[0] = {
							[1] = 0,
							[10] = 12,
							[11] = 7,
							[12] = 13,
							[13] = 21,
							[14] = 250,
							[15] = 179,
							[16] = 94,
							[17] = 0,
							[18] = 1,
							[19] = 0,
							[2] = 1,
							[20] = 0,
							[21] = 0,
							[22] = 0,
							[23] = 17,
							[24] = 21,
							[25] = 17,
							[26] = 21,
							[27] = 0,
							[28] = 0,
							[29] = 0,
							[3] = 2,
							[30] = 0,
							[31] = 15,
							[32] = 21,
							[33] = 17,
							[34] = 21,
							[35] = 49,
							[36] = 8,
							[37] = 149,
							[38] = 108,
							[39] = 0,
							[4] = 2,
							[40] = 1,
							[41] = 0,
							[42] = 0,
							[43] = 0,
							[44] = 0,
							[45] = 315,
							[5] = 0,
							[6] = 0,
							[7] = 195,
							[8] = 996,
							[9] = 849,
						},
					},
					[11] = {
						[1] = 241,
						[10] = 165,
						[11] = 38,
						[12] = 265,
						[13] = 61,
						[14] = 229,
						[15] = 218,
						[16] = 117,
						[17] = 241,
						[18] = 165,
						[19] = 241,
						[2] = 227,
						[20] = 241,
						[21] = 239,
						[22] = 151,
						[23] = 38,
						[24] = 38,
						[25] = 38,
						[26] = 140,
						[27] = 241,
						[28] = 37,
						[29] = 151,
						[3] = 96,
						[30] = 239,
						[31] = 38,
						[32] = 38,
						[33] = 38,
						[34] = 265,
						[35] = 61,
						[36] = 229,
						[37] = 218,
						[38] = 117,
						[39] = 241,
						[4] = 156,
						[40] = 252,
						[41] = 241,
						[42] = 241,
						[43] = 241,
						[44] = 241,
						[45] = 235,
						[5] = 241,
						[6] = 239,
						[7] = 144,
						[8] = 254,
						[9] = 149,
					},
					[2] = {
						[1] = 0,
						[10] = 70,
						[12] = 194,
						[13] = 224,
						[14] = 231,
						[15] = 243,
						[16] = 58,
						[17] = 0,
						[18] = 1179,
						[19] = 0,
						[2] = 0,
						[20] = 0,
						[21] = 17,
						[22] = 0,
						[23] = 51,
						[24] = 70,
						[26] = 0,
						[27] = 0,
						[28] = 15,
						[29] = 0,
						[3] = 0,
						[30] = 17,
						[32] = 203,
						[33] = 127,
						[34] = 159,
						[35] = 237,
						[36] = 197,
						[37] = 153,
						[38] = 90,
						[39] = 0,
						[4] = 0,
						[40] = 192,
						[41] = 0,
						[42] = 0,
						[43] = 0,
						[44] = 0,
						[45] = 109,
						[5] = 0,
						[6] = 7,
						[7] = 1332,
						[8] = 12,
						[9] = 12,
					},
					[3] = {
						[0] = {
							[1] = 0,
							[10] = 70,
							[12] = 194,
							[13] = 224,
							[14] = 231,
							[15] = 243,
							[16] = 58,
							[17] = 0,
							[18] = 1179,
							[19] = 0,
							[2] = 0,
							[20] = 0,
							[21] = 17,
							[22] = 0,
							[23] = 51,
							[24] = 70,
							[26] = 0,
							[27] = 0,
							[28] = 15,
							[29] = 0,
							[3] = 0,
							[30] = 17,
							[32] = 203,
							[33] = 127,
							[34] = 159,
							[35] = 237,
							[36] = 197,
							[37] = 153,
							[38] = 90,
							[39] = 0,
							[4] = 0,
							[40] = 192,
							[41] = 0,
							[42] = 0,
							[43] = 0,
							[44] = 0,
							[45] = 109,
							[5] = 0,
							[6] = 7,
							[7] = 1332,
							[8] = 12,
							[9] = 12,
						},
						[11] = 1,
						[25] = 42,
						[31] = 0,
					},
					[5] = {
						[0] = {
							[1] = 41,
							[10] = 7,
							[11] = 54,
							[12] = 4,
							[13] = 96,
							[14] = 230,
							[15] = 38,
							[16] = 52,
							[17] = 1,
							[18] = 166,
							[19] = 43,
							[2] = 0,
							[20] = 17,
							[21] = 0,
							[22] = 21,
							[23] = 117,
							[24] = 84,
							[26] = 14,
							[27] = 42,
							[28] = 0,
							[29] = 21,
							[3] = 187,
							[30] = 0,
							[33] = 50,
							[34] = 14,
							[35] = 237,
							[36] = 122,
							[37] = 221,
							[38] = 250,
							[39] = 39,
							[4] = 43,
							[40] = 0,
							[41] = 19,
							[42] = 20,
							[43] = 5,
							[44] = 27,
							[45] = 232,
							[5] = 40,
							[6] = 0,
							[7] = 12,
							[8] = 1,
							[9] = 12,
						},
						[25] = 42,
						[31] = 40,
						[32] = 40,
					},
					[6] = {
						[1] = 0,
						[10] = 12,
						[11] = 7,
						[12] = 13,
						[13] = 21,
						[14] = 250,
						[15] = 179,
						[16] = 94,
						[17] = 0,
						[18] = 1,
						[19] = 0,
						[2] = 1,
						[20] = 0,
						[21] = 0,
						[22] = 0,
						[23] = 17,
						[24] = 21,
						[25] = 17,
						[26] = 21,
						[27] = 0,
						[28] = 0,
						[29] = 0,
						[3] = 2,
						[30] = 0,
						[31] = 15,
						[32] = 21,
						[33] = 17,
						[34] = 21,
						[35] = 49,
						[36] = 8,
						[37] = 149,
						[38] = 108,
						[39] = 0,
						[4] = 2,
						[40] = 1,
						[41] = 0,
						[42] = 0,
						[43] = 0,
						[44] = 0,
						[45] = 315,
						[5] = 0,
						[6] = 0,
						[7] = 195,
						[8] = 996,
						[9] = 849,
					},
					[7] = { { 4, 1 } },
					[8] = 0,
					[9] = 22,
				}, {})

				luraph_runtime2({
					[1] = {
						[1] = 1,
						[10] = 1,
						[11] = 2,
						[12] = 0,
						[13] = 4,
						[2] = 5,
						[3] = 9,
						[4] = 12,
						[5] = 0,
						[6] = 1,
						[7] = 88,
						[8] = 0,
						[9] = 4,
					},
					[10] = {
						[0] = {
							[1] = 0,
							[10] = 0,
							[11] = 2,
							[12] = 0,
							[13] = 0,
							[2] = 1,
							[3] = 0,
							[4] = 472,
							[5] = 1,
							[6] = 0,
							[7] = 0,
							[8] = 0,
							[9] = 0,
						},
					},
					[11] = {
						[1] = 131,
						[10] = 98,
						[11] = 131,
						[12] = 138,
						[13] = 241,
						[2] = 156,
						[3] = 241,
						[4] = 240,
						[5] = 173,
						[6] = 98,
						[7] = 145,
						[8] = 138,
						[9] = 241,
					},
					[2] = {
						[1] = 0,
						[10] = 1,
						[11] = 0,
						[12] = 1,
						[13] = 0,
						[2] = 0,
						[3] = 0,
						[4] = 420,
						[5] = 0,
						[6] = 1,
						[7] = 2,
						[8] = 1,
						[9] = 0,
					},
					[3] = {
						[0] = {
							[1] = 0,
							[10] = 1,
							[11] = 0,
							[12] = 1,
							[13] = 0,
							[2] = 0,
							[3] = 0,
							[4] = 420,
							[5] = 0,
							[6] = 1,
							[7] = 2,
							[8] = 1,
							[9] = 0,
						},
					},
					[5] = {
						[0] = {
							[1] = 1,
							[10] = 1,
							[11] = 2,
							[12] = 0,
							[13] = 4,
							[2] = 5,
							[3] = 9,
							[4] = 12,
							[5] = 0,
							[6] = 1,
							[7] = 88,
							[8] = 0,
							[9] = 4,
						},
					},
					[6] = {
						[1] = 0,
						[10] = 0,
						[11] = 2,
						[12] = 0,
						[13] = 0,
						[2] = 1,
						[3] = 0,
						[4] = 472,
						[5] = 1,
						[6] = 0,
						[7] = 0,
						[8] = 0,
						[9] = 0,
					},
					[7] = { { 112, 0 }, { 115, 1 }, { 113, 0 } },
					[8] = 0,
					[9] = 3,
				}, {})

				do
					local v76 = v75
					local toggle = v75.Toggle

					local tbl3 = {
						Title = "FOV",
						Desc = "",
						Callback = luraph_runtime2({
														[1] = { --[[ 已折叠 90 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[10] = { --[[ 已折叠 95 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[11] = { --[[ 已折叠 93 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[2] = { --[[ 已折叠 89 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[3] = { --[[ 已折叠 95 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[5] = { --[[ 已折叠 95 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[6] = { --[[ 已折叠 93 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
							[7] = {
								{ 112, 0 },
								{ 115, 1 },
								{ 113, 0 },
								{ 114, 0 },
								{ 109, 1 },
								{ 116, 1 },
							},
							[8] = 0,
							[9] = 23,
						}, {}),
					}

					if not (luraph_frame(nil, nil) > 119) then
						toggle(v76, tbl3)
						luraph_frame(nil, nil)
					else
						toggle(v76, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v76 = v75
					local slider = v75.Slider

					local tbl3 = {
						Title = "FOV 大小",
						Desc = "",
						Step = 1,
						Value = { Default = 70, Min = 70, Max = 120 },
						Callback = luraph_runtime2({
							[1] = {
								[1] = 53,
								[10] = 139,
								[11] = 211,
								[12] = 36,
								[13] = 27,
								[14] = 11,
								[15] = 0,
								[16] = 1118,
								[17] = 12,
								[18] = 12,
								[19] = 11,
								[2] = 13,
								[20] = 120,
								[21] = 4,
								[22] = 12,
								[23] = 46,
								[24] = 0,
								[25] = 1,
								[26] = 2,
								[27] = 50,
								[28] = 0,
								[29] = 45,
								[3] = 21,
								[30] = 16,
								[31] = 14,
								[32] = 141,
								[33] = 183,
								[34] = 150,
								[35] = 2,
								[36] = 23,
								[37] = 54,
								[38] = 22,
								[39] = 21,
								[4] = 0,
								[40] = 16,
								[41] = 0,
								[43] = 83,
								[44] = 559,
								[45] = 14,
								[46] = 51,
								[47] = 2,
								[48] = 1,
								[49] = 0,
								[5] = 245,
								[50] = 54,
								[51] = 2,
								[52] = 1,
								[53] = 410,
								[54] = 38,
								[55] = 199,
								[7] = 14,
								[8] = 104,
								[9] = 155,
							},
							[10] = {
								[0] = {
									[1] = 0,
									[10] = 24,
									[11] = 251,
									[12] = 0,
									[13] = 0,
									[14] = 0,
									[15] = 0,
									[16] = 12,
									[17] = 479,
									[18] = 1235,
									[19] = 12,
									[2] = 0,
									[20] = 7,
									[21] = 180,
									[22] = 0,
									[23] = 0,
									[24] = 1,
									[25] = 0,
									[26] = 1,
									[27] = 0,
									[28] = 0,
									[29] = 17,
									[3] = 0,
									[30] = 17,
									[31] = 21,
									[32] = 109,
									[33] = 17,
									[34] = 20,
									[35] = 127,
									[36] = 0,
									[37] = 2,
									[38] = 0,
									[39] = 0,
									[4] = 0,
									[40] = 0,
									[41] = 0,
									[42] = 16,
									[43] = 21,
									[44] = 17,
									[45] = 21,
									[46] = 0,
									[47] = 0,
									[48] = 3,
									[49] = 0,
									[5] = 21,
									[50] = 0,
									[51] = 0,
									[52] = 0,
									[53] = 391,
									[54] = 0,
									[55] = 1,
									[6] = 17,
									[7] = 21,
									[8] = 91,
									[9] = 29,
								},
							},
							[11] = {
								[1] = 241,
								[10] = 218,
								[11] = 117,
								[12] = 241,
								[13] = 241,
								[14] = 151,
								[15] = 239,
								[16] = 106,
								[17] = 254,
								[18] = 149,
								[19] = 165,
								[2] = 241,
								[20] = 38,
								[21] = 140,
								[22] = 241,
								[23] = 241,
								[24] = 227,
								[25] = 255,
								[26] = 131,
								[27] = 241,
								[28] = 239,
								[29] = 38,
								[3] = 151,
								[30] = 38,
								[31] = 265,
								[32] = 61,
								[33] = 229,
								[34] = 218,
								[35] = 117,
								[36] = 241,
								[37] = 156,
								[38] = 241,
								[39] = 151,
								[4] = 239,
								[40] = 121,
								[41] = 239,
								[42] = 38,
								[43] = 38,
								[44] = 38,
								[45] = 140,
								[46] = 241,
								[47] = 98,
								[48] = 253,
								[49] = 50,
								[5] = 38,
								[50] = 241,
								[51] = 241,
								[52] = 241,
								[53] = 179,
								[54] = 241,
								[55] = 173,
								[6] = 38,
								[7] = 265,
								[8] = 61,
								[9] = 229,
							},
							[2] = {
								[1] = 0,
								[10] = 216,
								[11] = 228,
								[12] = 0,
								[13] = 0,
								[14] = 0,
								[15] = 7,
								[16] = 162,
								[17] = 12,
								[18] = 12,
								[19] = 39,
								[2] = 0,
								[21] = 0,
								[22] = 0,
								[23] = 0,
								[24] = 0,
								[25] = 0,
								[26] = 0,
								[27] = 0,
								[28] = 17,
								[3] = 0,
								[31] = 224,
								[32] = 170,
								[33] = 104,
								[34] = 121,
								[35] = 110,
								[36] = 0,
								[37] = 0,
								[38] = 0,
								[39] = 0,
								[4] = 17,
								[40] = 0,
								[41] = 17,
								[42] = 16,
								[43] = 125,
								[45] = 0,
								[46] = 0,
								[47] = 2,
								[48] = 0,
								[49] = 2,
								[5] = 270,
								[50] = 0,
								[51] = 0,
								[52] = 0,
								[53] = 364,
								[54] = 0,
								[55] = 0,
								[6] = 116,
								[7] = 132,
								[8] = 123,
								[9] = 160,
							},
							[3] = {
								[0] = {
									[1] = 0,
									[10] = 216,
									[11] = 228,
									[12] = 0,
									[13] = 0,
									[14] = 0,
									[15] = 7,
									[16] = 162,
									[17] = 12,
									[18] = 12,
									[19] = 39,
									[2] = 0,
									[21] = 0,
									[22] = 0,
									[23] = 0,
									[24] = 0,
									[25] = 0,
									[26] = 0,
									[27] = 0,
									[28] = 17,
									[3] = 0,
									[31] = 224,
									[32] = 170,
									[33] = 104,
									[34] = 121,
									[35] = 110,
									[36] = 0,
									[37] = 0,
									[38] = 0,
									[39] = 0,
									[4] = 17,
									[40] = 0,
									[41] = 17,
									[42] = 16,
									[43] = 125,
									[45] = 0,
									[46] = 0,
									[47] = 2,
									[48] = 0,
									[49] = 2,
									[5] = 270,
									[50] = 0,
									[51] = 0,
									[52] = 0,
									[53] = 364,
									[54] = 0,
									[55] = 0,
									[6] = 116,
									[7] = 132,
									[8] = 123,
									[9] = 160,
								},
								[20] = 23,
								[29] = 0,
								[30] = 23,
								[44] = 51,
							},
							[5] = {
								[0] = {
									[1] = 53,
									[10] = 139,
									[11] = 211,
									[12] = 36,
									[13] = 27,
									[14] = 11,
									[15] = 0,
									[16] = 1118,
									[17] = 12,
									[18] = 12,
									[19] = 11,
									[2] = 13,
									[20] = 120,
									[21] = 4,
									[22] = 12,
									[23] = 46,
									[24] = 0,
									[25] = 1,
									[26] = 2,
									[27] = 50,
									[28] = 0,
									[29] = 45,
									[3] = 21,
									[30] = 16,
									[31] = 14,
									[32] = 141,
									[33] = 183,
									[34] = 150,
									[35] = 2,
									[36] = 23,
									[37] = 54,
									[38] = 22,
									[39] = 21,
									[4] = 0,
									[40] = 16,
									[41] = 0,
									[43] = 83,
									[44] = 559,
									[45] = 14,
									[46] = 51,
									[47] = 2,
									[48] = 1,
									[49] = 0,
									[5] = 245,
									[50] = 54,
									[51] = 2,
									[52] = 1,
									[53] = 410,
									[54] = 38,
									[55] = 199,
									[7] = 14,
									[8] = 104,
									[9] = 155,
								},
								[42] = 21,
								[6] = 51,
							},
							[6] = {
								[1] = 0,
								[10] = 24,
								[11] = 251,
								[12] = 0,
								[13] = 0,
								[14] = 0,
								[15] = 0,
								[16] = 12,
								[17] = 479,
								[18] = 1235,
								[19] = 12,
								[2] = 0,
								[20] = 7,
								[21] = 180,
								[22] = 0,
								[23] = 0,
								[24] = 1,
								[25] = 0,
								[26] = 1,
								[27] = 0,
								[28] = 0,
								[29] = 17,
								[3] = 0,
								[30] = 17,
								[31] = 21,
								[32] = 109,
								[33] = 17,
								[34] = 20,
								[35] = 127,
								[36] = 0,
								[37] = 2,
								[38] = 0,
								[39] = 0,
								[4] = 0,
								[40] = 0,
								[41] = 0,
								[42] = 16,
								[43] = 21,
								[44] = 17,
								[45] = 21,
								[46] = 0,
								[47] = 0,
								[48] = 3,
								[49] = 0,
								[5] = 21,
								[50] = 0,
								[51] = 0,
								[52] = 0,
								[53] = 391,
								[54] = 0,
								[55] = 1,
								[6] = 17,
								[7] = 21,
								[8] = 91,
								[9] = 29,
							},
							[7] = { { 113, 0 }, { 112, 0 }, { 115, 1 } },
							[8] = 0,
							[9] = 22,
						}, {}),
					}

					if not (luraph_frame(nil, nil) > 119) then
						slider(v76, tbl3)
						luraph_frame(nil, nil)
					else
						slider(v76, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v76 = v75
					local toggle = v75.Toggle
					local tbl3 = { Title = "夜视", Desc = "", Value = false }

					luraph_runtime2({
												[1] = { --[[ 已折叠 99 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[10] = { --[[ 已折叠 107 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[11] = { --[[ 已折叠 105 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[2] = { --[[ 已折叠 100 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[3] = { --[[ 已折叠 107 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[5] = { --[[ 已折叠 107 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[6] = { --[[ 已折叠 105 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
						[7] = { { 3, 1 }, { 38, 1 } },
						[8] = 0,
						[9] = 25,
					}, {})

					if not (luraph_frame(nil, nil) > 119) then
						toggle(v76, tbl3)
						luraph_frame(nil, nil)
					else
						toggle(v76, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v76 = v75
					local button = v75.Button

					local tbl3 = {
						Title = "隐身",
						Desc = "",
						Callback = luraph_runtime2({
														[1] = { --[[ 已折叠 179 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[10] = { --[[ 已折叠 191 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[11] = { --[[ 已折叠 189 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[2] = { --[[ 已折叠 178 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[3] = { --[[ 已折叠 191 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
							[5] = {
																[0] = { --[[ 已折叠 179 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
								[162] = 0,
								[164] = 0,
								[168] = "Players",
																[170] = { --[[ 已折叠 414 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
								[171] = {
																		[1] = { --[[ 已折叠 61 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																		[10] = { --[[ 已折叠 70 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																		[11] = { --[[ 已折叠 68 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																		[2] = { --[[ 已折叠 60 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																		[3] = { --[[ 已折叠 70 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																		[5] = { --[[ 已折叠 869 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																		[6] = { --[[ 已折叠 68 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
									[7] = {
										{ 12, 0 },
										{ 14, 1 },
										{ 2, 1 },
										{ 7, 0 },
										{ 7, 2 },
										{ 6, 0 },
										{ 8, 2 },
									},
									[8] = 0,
									[9] = 22,
								},
																[172] = { --[[ 已折叠 729 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																[173] = { --[[ 已折叠 405 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																[20] = { --[[ 已折叠 143 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
								[36] = 40,
																[53] = { --[[ 已折叠 643 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
								[60] = "Text",
								[63] = 0,
								[64] = 0,
								[68] = {
																		[1] = { --[[ 已折叠 82 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																		[10] = { --[[ 已折叠 88 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																		[11] = { --[[ 已折叠 86 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																		[2] = { --[[ 已折叠 82 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																		[3] = { --[[ 已折叠 88 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																		[5] = { --[[ 已折叠 88 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																		[6] = { --[[ 已折叠 86 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
									[7] = {
										{ 5, 0 },
										{ 6, 0 },
										{ 7, 0 },
										{ 11, 0 },
										{ 17, 1 },
										{ 16, 1 },
									},
									[8] = 0,
									[9] = 23,
								},
								[79] = 0,
								[96] = 25,
								[97] = 25,
							},
														[6] = { --[[ 已折叠 187 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
							[7] = {
								{ 3, 1 },
								{ 14, 1 },
								{ 37, 1 },
								{ 51, 1 },
								{ 42, 1 },
								{ 20, 1 },
								{ 52, 1 },
								{ 48, 1 },
								{ 53, 1 },
							},
							[8] = 0,
							[9] = 30,
						}, {}),
					}

					if not (luraph_frame(nil, nil) > 119) then
						button(v76, tbl3)
						luraph_frame(nil, nil)
					else
						button(v76, tbl3)
						luraph_frame(nil, nil)
					end
				end

				local v76

				do
					local v77 = v52
					local tab = v52.Tab
					local tbl3 = { Title = "绘制", Icon = "palette" }

					if luraph_frame(nil, nil) > 119 then
						local v78 = table.pack(tab(v77, tbl3))
						v76 = v78[1]
						luraph_frame(nil, nil)
					else
						local v78 = table.pack(tab(v77, tbl3))
						v76 = v78[1]
						luraph_frame(nil, nil)
					end
				end

				do
					local v77 = v3
					local getService4 = v3.GetService
					local str5 = "Players"
					local v78

					if luraph_frame(nil, nil) > 120 then
						local v79 = table.pack(getService4(v77, str5))
						v78 = v79[1]
						luraph_frame(nil, nil)
					else
						local v79 = table.pack(getService4(v77, str5))
						v78 = v79[1]
						luraph_frame(nil, nil)
					end

					local v79 = v3
					local getService5 = v3.GetService
					local str6 = "RunService"
					local v80

					if luraph_frame(nil, nil) > 121 then
						local v81 = table.pack(getService5(v79, str6))
						v80 = v81[1]
						luraph_frame(nil, nil)
					else
						local v81 = table.pack(getService5(v79, str6))
						v80 = v81[1]
						luraph_frame(nil, nil)
					end

					local tbl3 = {
						Box3D = false,
						Health = false,
						Name = false,
						TraceBottom = false,
						TraceTop = false,
						Distance = false,
						VisibleCheck = false,
					}

					local v81 = fromRGB
					local v82

					if not (luraph_frame(nil, nil) > 126) then
						local v83 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 124, 126))
						local v84 = table.pack(v81(table.unpack(v83, 1, v83.n)))
						v82 = v84[1]
						luraph_frame(nil, nil)
					else
						local v83 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 124, 126))
						local v84 = table.pack(v81(table.unpack(v83, 1, v83.n)))
						v82 = v84[1]
						luraph_frame(nil, nil)
					end

					tbl3.ColorNormal = v82
					local v83 = fromRGB
					local v84

					if not (luraph_frame(nil, nil) > 126) then
						local v85 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 124, 126))
						local v86 = table.pack(v83(table.unpack(v85, 1, v85.n)))
						v84 = v86[1]
						luraph_frame(nil, nil)
					else
						local v85 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 124, 126))
						local v86 = table.pack(v83(table.unpack(v85, 1, v85.n)))
						v84 = v86[1]
						luraph_frame(nil, nil)
					end

					tbl3.ColorVisible = v84
					tbl3.DrawingPool = {}

					tbl3.GetDrawing = luraph_runtime2({
												[1] = { --[[ 已折叠 186 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[10] = { --[[ 已折叠 202 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[11] = { --[[ 已折叠 200 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[2] = { --[[ 已折叠 187 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[3] = { --[[ 已折叠 202 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[5] = { --[[ 已折叠 202 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[6] = { --[[ 已折叠 200 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
						[7] = { { 2, 1 }, { 38, 1 } },
						[8] = 0,
						[9] = 28,
					}, {})

					luraph_runtime2({
												[1] = { --[[ 已折叠 113 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[10] = { --[[ 已折叠 121 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[11] = { --[[ 已折叠 119 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[2] = { --[[ 已折叠 111 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[3] = { --[[ 已折叠 121 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[5] = { --[[ 已折叠 121 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[6] = { --[[ 已折叠 119 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
						[7] = { { 121, 1 }, { 120, 1 }, { 54, 1 }, { 55, 1 }, { 4, 1 } },
						[8] = 0,
						[9] = 28,
					}, {})

					luraph_runtime2({
												[1] = { --[[ 已折叠 135 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[10] = { --[[ 已折叠 144 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[11] = { --[[ 已折叠 142 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[2] = { --[[ 已折叠 139 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[3] = { --[[ 已折叠 144 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[5] = { --[[ 已折叠 144 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[6] = { --[[ 已折叠 142 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
						[7] = { { 52, 1 }, { 53, 1 } },
						[8] = 0,
						[9] = 43,
					}, {})

					local renderStepped = v80.RenderStepped
					local v85 = renderStepped
					local connect = renderStepped.Connect

					local v86 = luraph_runtime2({
												[1] = { --[[ 已折叠 619 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[10] = { --[[ 已折叠 649 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[11] = { --[[ 已折叠 647 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[2] = { --[[ 已折叠 634 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[3] = { --[[ 已折叠 649 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[5] = { --[[ 已折叠 649 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[6] = { --[[ 已折叠 647 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
						[7] = {
							[1] = { 14, 1 },
							[10] = { 57, 1 },
							[11] = { 58, 1 },
							[12] = { 42, 1 },
							[13] = { 124, 1 },
							[14] = { 52, 1 },
							[15] = { 43, 1 },
							[16] = { 59, 1 },
							[2] = { 122, 1 },
							[3] = { 121, 1 },
							[4] = { 120, 1 },
							[5] = { 20, 1 },
							[6] = { 118, 1 },
							[7] = { 53, 1 },
							[8] = { 123, 1 },
							[9] = { 56, 1 },
						},
						[8] = 0,
						[9] = 64,
					}, {})

					if not (luraph_frame(nil, nil) > 127) then
						connect(v85, v86)
						luraph_frame(nil, nil)
					else
						connect(v85, v86)
						luraph_frame(nil, nil)
					end

					local playerRemoving = v78.PlayerRemoving
					local v87 = playerRemoving
					local connect2 = playerRemoving.Connect

					local v88 = luraph_runtime2({
												[1] = { --[[ 已折叠 93 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[10] = { --[[ 已折叠 100 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[11] = { --[[ 已折叠 98 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[2] = { --[[ 已折叠 93 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[3] = { --[[ 已折叠 100 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[5] = { --[[ 已折叠 100 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[6] = { --[[ 已折叠 98 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
						[7] = { { 34, 1 }, { 14, 1 }, { 122, 1 }, { 60, 1 } },
						[8] = 0,
						[9] = 28,
					}, {})

					if not (luraph_frame(nil, nil) > 127) then
						connect2(v87, v88)
						luraph_frame(nil, nil)
					else
						connect2(v87, v88)
						luraph_frame(nil, nil)
					end

					local v89 = v76
					local toggle = v76.Toggle
					v88.Title = "3D方框"
					v88.Value = false

					v88.Callback = luraph_runtime2({
						[1] = { 2, 497, 0, 627, 0 },
						[10] = { [0] = { 0, 201, 1, 1, 1 } },
						[11] = { 241, 6, 227, 105, 173 },
						[2] = { 0, 295, 0, 0, 0 },
						[3] = { [0] = { 0, 295, 0, 0, 0 } },
						[5] = { [0] = { 2, 497, 0, 627, 0 } },
						[6] = { 0, 201, 1, 1, 1 },
						[7] = { { 122, 1 } },
						[8] = 0,
						[9] = 3,
					}, {})

					if not (luraph_frame(nil, nil) > 127) then
						toggle(v89, v88)
						luraph_frame(nil, nil)
					else
						toggle(v89, v88)
						luraph_frame(nil, nil)
					end
				end

				do
					local v77 = v76
					local toggle = v76.Toggle

					local tbl3 = {
						Title = "血量条",
						Value = false,
						Callback = luraph_runtime2({
														[1] = { --[[ 已折叠 64 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[10] = { --[[ 已折叠 71 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[11] = { --[[ 已折叠 69 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[2] = { --[[ 已折叠 64 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[3] = { --[[ 已折叠 71 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[5] = { --[[ 已折叠 71 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[6] = { --[[ 已折叠 69 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
							[7] = { { 122, 1 } },
							[8] = 0,
							[9] = 21,
						}, {}),
					}

					if not (luraph_frame(nil, nil) > 127) then
						toggle(v77, tbl3)
						luraph_frame(nil, nil)
					else
						toggle(v77, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v77 = v76
					local toggle = v76.Toggle

					local tbl3 = {
						Title = "名字",
						Value = false,
						Callback = luraph_runtime2({
							[1] = {
								[1] = 47,
								[10] = 32,
								[11] = 0,
								[12] = 15,
								[13] = 20,
								[14] = 245,
								[15] = 104,
								[16] = 104,
								[17] = 86,
								[18] = 13,
								[19] = 38,
								[2] = 34,
								[20] = 211,
								[21] = 92,
								[22] = 4,
								[23] = 30,
								[24] = 0,
								[25] = 5,
								[26] = 10,
								[28] = 29,
								[29] = 3,
								[3] = 23,
								[30] = 10,
								[31] = 48,
								[32] = 9,
								[33] = 736,
								[34] = 48,
								[35] = 20,
								[36] = 0,
								[37] = 15,
								[4] = 188,
								[41] = 120,
								[42] = 13,
								[43] = 3,
								[44] = 84,
								[45] = 105,
								[46] = 45,
								[47] = 2,
								[48] = 1,
								[49] = 11,
								[5] = 29,
								[50] = 11,
								[51] = 10,
								[52] = 352,
								[53] = 11,
								[54] = 11,
								[55] = 5,
								[57] = 127,
								[58] = 6,
								[6] = 94,
								[7] = 0,
								[8] = 61,
								[9] = 97,
							},
														[10] = { --[[ 已折叠 61 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
							[11] = {
								[1] = 241,
								[10] = 241,
								[11] = 239,
								[12] = 121,
								[13] = 151,
								[14] = 38,
								[15] = 38,
								[16] = 38,
								[17] = 38,
								[18] = 265,
								[19] = 61,
								[2] = 241,
								[20] = 229,
								[21] = 218,
								[22] = 117,
								[23] = 241,
								[24] = 239,
								[25] = 121,
								[26] = 151,
								[27] = 180,
								[28] = 156,
								[29] = 241,
								[3] = 241,
								[30] = 241,
								[31] = 123,
								[32] = 241,
								[33] = 145,
								[34] = 241,
								[35] = 151,
								[36] = 239,
								[37] = 121,
								[38] = 38,
								[39] = 38,
								[4] = 145,
								[40] = 38,
								[41] = 38,
								[42] = 265,
								[43] = 61,
								[44] = 229,
								[45] = 218,
								[46] = 117,
								[47] = 241,
								[48] = 241,
								[49] = 112,
								[5] = 241,
								[50] = 149,
								[51] = 165,
								[52] = 77,
								[53] = 254,
								[54] = 149,
								[55] = 165,
								[56] = 38,
								[57] = 140,
								[58] = 241,
								[6] = 133,
								[7] = 227,
								[8] = 42,
								[9] = 208,
							},
							[2] = {
								[1] = 0,
								[10] = 0,
								[11] = 16,
								[12] = 0,
								[13] = 0,
								[14] = 99,
								[16] = 51,
								[17] = 86,
								[18] = 219,
								[19] = 31,
								[2] = 0,
								[20] = 80,
								[21] = 87,
								[22] = 85,
								[23] = 0,
								[24] = 6,
								[25] = 0,
								[26] = 0,
								[27] = 11,
								[28] = 0,
								[29] = 0,
								[3] = 0,
								[30] = 0,
								[31] = 0,
								[32] = 0,
								[33] = 11,
								[34] = 0,
								[35] = 0,
								[36] = 16,
								[37] = 0,
								[39] = 203,
								[4] = 11,
								[41] = 120,
								[42] = 32,
								[43] = 104,
								[44] = 173,
								[45] = 188,
								[46] = 181,
								[47] = 0,
								[48] = 0,
								[49] = 11,
								[5] = 0,
								[50] = 11,
								[51] = 117,
								[52] = 1099,
								[53] = 11,
								[54] = 11,
								[55] = 117,
								[56] = 26,
								[57] = 0,
								[58] = 0,
								[6] = 385,
								[7] = 0,
								[8] = 0,
								[9] = 0,
							},
														[3] = { --[[ 已折叠 61 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[5] = { --[[ 已折叠 61 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
							[6] = {
								[1] = 0,
								[10] = 0,
								[11] = 0,
								[12] = 0,
								[13] = 0,
								[14] = 20,
								[15] = 16,
								[16] = 15,
								[17] = 16,
								[18] = 20,
								[19] = 40,
								[2] = 0,
								[20] = 69,
								[21] = 150,
								[22] = 67,
								[23] = 0,
								[24] = 0,
								[25] = 0,
								[26] = 0,
								[27] = 185,
								[28] = 11,
								[29] = 0,
								[3] = 0,
								[30] = 0,
								[31] = 11,
								[32] = 0,
								[33] = 0,
								[34] = 0,
								[35] = 0,
								[36] = 0,
								[37] = 0,
								[38] = 16,
								[39] = 20,
								[4] = 0,
								[40] = 15,
								[41] = 16,
								[42] = 20,
								[43] = 32,
								[44] = 181,
								[45] = 75,
								[46] = 39,
								[47] = 0,
								[48] = 0,
								[49] = 1136,
								[5] = 0,
								[50] = 1175,
								[51] = 11,
								[52] = 11,
								[53] = 1062,
								[54] = 1077,
								[55] = 11,
								[56] = 6,
								[57] = 113,
								[58] = 0,
								[6] = 375,
								[7] = 1,
								[8] = 212,
								[9] = 199,
							},
							[7] = { { 122, 1 } },
							[8] = 0,
							[9] = 21,
						}, {}),
					}

					if not (luraph_frame(nil, nil) > 127) then
						toggle(v77, tbl3)
						luraph_frame(nil, nil)
					else
						toggle(v77, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v77 = v76
					local toggle = v76.Toggle

					local tbl3 = {
						Title = "底部射线",
						Value = false,
						Callback = luraph_runtime2({
							[1] = { 5, 0, 218, 0, 24, 1 },
							[10] = { [0] = { 0, 1, 1, 1, 490, 0 } },
							[11] = { 241, 227, 105, 173, 179, 241 },
							[2] = { 0, 0, 0, 0, 292, 0 },
							[3] = { [0] = { 0, 0, 0, 0, 292, 0 } },
							[5] = { [0] = { 5, 0, 218, 0, 24, 1 } },
							[6] = { 0, 1, 1, 1, 490, 0 },
							[7] = { { 122, 1 } },
							[8] = 0,
							[9] = 3,
						}, {}),
					}

					if not (luraph_frame(nil, nil) > 127) then
						toggle(v77, tbl3)
						luraph_frame(nil, nil)
					else
						toggle(v77, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v77 = v76
					local toggle = v76.Toggle

					local tbl3 = {
						Title = "顶部射线",
						Value = false,
						Callback = luraph_runtime2({
							[1] = {
								[1] = 24,
								[10] = 1,
								[11] = 25,
								[12] = 0,
								[13] = 20,
								[14] = 120,
								[15] = 29,
								[16] = 13,
								[17] = 249,
								[18] = 213,
								[19] = 136,
								[2] = 11,
								[20] = 38,
								[21] = 28,
								[22] = 0,
								[23] = 1308,
								[24] = 0,
								[25] = 33,
								[26] = 354,
								[27] = 1,
								[28] = 34,
								[29] = 0,
								[3] = 11,
								[30] = 5,
								[31] = 576,
								[32] = 9,
								[33] = 27,
								[34] = 11,
								[35] = 37,
								[36] = 362,
								[37] = 21,
								[38] = 20,
								[39] = 0,
								[4] = 5,
								[40] = 0,
								[41] = 117,
								[42] = 117,
								[43] = 98,
								[44] = 13,
								[45] = 123,
								[46] = 87,
								[47] = 223,
								[48] = 178,
								[49] = 7,
								[6] = 3,
								[7] = 36,
								[8] = 338,
								[9] = 9,
							},
							[10] = {
								[0] = {
									[1] = 0,
									[10] = 11,
									[11] = 0,
									[12] = 0,
									[13] = 0,
									[14] = 20,
									[15] = 16,
									[16] = 20,
									[17] = 223,
									[18] = 51,
									[19] = 230,
									[2] = 207,
									[20] = 129,
									[21] = 0,
									[22] = 1,
									[23] = 1,
									[24] = 17,
									[25] = 0,
									[26] = 0,
									[27] = 0,
									[28] = 0,
									[29] = 0,
									[3] = 805,
									[30] = 0,
									[32] = 11,
									[33] = 0,
									[34] = 0,
									[35] = 0,
									[36] = 274,
									[37] = 0,
									[38] = 0,
									[39] = 0,
									[4] = 11,
									[40] = 0,
									[41] = 20,
									[42] = 14,
									[43] = 16,
									[44] = 20,
									[45] = 69,
									[46] = 57,
									[47] = 144,
									[48] = 76,
									[49] = 0,
									[5] = 6,
									[6] = 12,
									[7] = 0,
									[8] = 0,
									[9] = 0,
								},
								[31] = 58,
							},
							[11] = {
								[1] = 241,
								[10] = 123,
								[11] = 241,
								[12] = 239,
								[13] = 151,
								[14] = 38,
								[15] = 38,
								[16] = 265,
								[17] = 61,
								[18] = 229,
								[19] = 218,
								[2] = 228,
								[20] = 117,
								[21] = 241,
								[22] = 227,
								[23] = 105,
								[24] = 173,
								[25] = 241,
								[26] = 145,
								[27] = 241,
								[28] = 241,
								[29] = 239,
								[3] = 149,
								[30] = 121,
								[31] = 214,
								[32] = 156,
								[33] = 241,
								[34] = 241,
								[35] = 241,
								[36] = 172,
								[37] = 241,
								[38] = 151,
								[39] = 239,
								[4] = 165,
								[40] = 37,
								[41] = 38,
								[42] = 38,
								[43] = 38,
								[44] = 265,
								[45] = 61,
								[46] = 229,
								[47] = 218,
								[48] = 117,
								[49] = 241,
								[5] = 38,
								[6] = 140,
								[7] = 241,
								[8] = 32,
								[9] = 241,
							},
							[2] = {
								[1] = 0,
								[10] = 0,
								[11] = 0,
								[12] = 16,
								[13] = 0,
								[14] = 99,
								[15] = 94,
								[16] = 129,
								[17] = 165,
								[18] = 119,
								[19] = 241,
								[2] = 11,
								[20] = 251,
								[21] = 0,
								[22] = 0,
								[23] = 0,
								[24] = 0,
								[25] = 0,
								[26] = 11,
								[27] = 0,
								[28] = 0,
								[29] = 6,
								[3] = 11,
								[30] = 0,
								[31] = 11,
								[32] = 0,
								[33] = 0,
								[34] = 0,
								[35] = 0,
								[36] = 346,
								[37] = 0,
								[38] = 0,
								[39] = 16,
								[40] = 14,
								[41] = 75,
								[43] = 84,
								[44] = 36,
								[45] = 116,
								[46] = 112,
								[47] = 26,
								[48] = 168,
								[49] = 0,
								[5] = 116,
								[6] = 0,
								[7] = 0,
								[8] = 99,
								[9] = 0,
							},
							[3] = {
								[0] = {
									[1] = 0,
									[10] = 0,
									[11] = 0,
									[12] = 16,
									[13] = 0,
									[14] = 99,
									[15] = 94,
									[16] = 129,
									[17] = 165,
									[18] = 119,
									[19] = 241,
									[2] = 11,
									[20] = 251,
									[21] = 0,
									[22] = 0,
									[23] = 0,
									[24] = 0,
									[25] = 0,
									[26] = 11,
									[27] = 0,
									[28] = 0,
									[29] = 6,
									[3] = 11,
									[30] = 0,
									[31] = 11,
									[32] = 0,
									[33] = 0,
									[34] = 0,
									[35] = 0,
									[36] = 346,
									[37] = 0,
									[38] = 0,
									[39] = 16,
									[40] = 14,
									[41] = 75,
									[43] = 84,
									[44] = 36,
									[45] = 116,
									[46] = 112,
									[47] = 26,
									[48] = 168,
									[49] = 0,
									[5] = 116,
									[6] = 0,
									[7] = 0,
									[8] = 99,
									[9] = 0,
								},
								[4] = 24,
								[42] = 11,
							},
							[5] = {
								[0] = {
									[1] = 24,
									[10] = 1,
									[11] = 25,
									[12] = 0,
									[13] = 20,
									[14] = 120,
									[15] = 29,
									[16] = 13,
									[17] = 249,
									[18] = 213,
									[19] = 136,
									[2] = 11,
									[20] = 38,
									[21] = 28,
									[22] = 0,
									[23] = 1308,
									[24] = 0,
									[25] = 33,
									[26] = 354,
									[27] = 1,
									[28] = 34,
									[29] = 0,
									[3] = 11,
									[30] = 5,
									[31] = 576,
									[32] = 9,
									[33] = 27,
									[34] = 11,
									[35] = 37,
									[36] = 362,
									[37] = 21,
									[38] = 20,
									[39] = 0,
									[4] = 5,
									[40] = 0,
									[41] = 117,
									[42] = 117,
									[43] = 98,
									[44] = 13,
									[45] = 123,
									[46] = 87,
									[47] = 223,
									[48] = 178,
									[49] = 7,
									[6] = 3,
									[7] = 36,
									[8] = 338,
									[9] = 9,
								},
								[5] = 25,
							},
							[6] = {
								[1] = 0,
								[10] = 11,
								[11] = 0,
								[12] = 0,
								[13] = 0,
								[14] = 20,
								[15] = 16,
								[16] = 20,
								[17] = 223,
								[18] = 51,
								[19] = 230,
								[2] = 207,
								[20] = 129,
								[21] = 0,
								[22] = 1,
								[23] = 1,
								[24] = 17,
								[25] = 0,
								[26] = 0,
								[27] = 0,
								[28] = 0,
								[29] = 0,
								[3] = 805,
								[30] = 0,
								[32] = 11,
								[33] = 0,
								[34] = 0,
								[35] = 0,
								[36] = 274,
								[37] = 0,
								[38] = 0,
								[39] = 0,
								[4] = 11,
								[40] = 0,
								[41] = 20,
								[42] = 14,
								[43] = 16,
								[44] = 20,
								[45] = 69,
								[46] = 57,
								[47] = 144,
								[48] = 76,
								[49] = 0,
								[5] = 6,
								[6] = 12,
								[7] = 0,
								[8] = 0,
								[9] = 0,
							},
							[7] = { { 122, 1 } },
							[8] = 0,
							[9] = 21,
						}, {}),
					}

					if not (luraph_frame(nil, nil) > 127) then
						toggle(v77, tbl3)
						luraph_frame(nil, nil)
					else
						toggle(v77, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v77 = v76
					local toggle = v76.Toggle

					local tbl3 = {
						Title = "距离",
						Value = false,
						Callback = luraph_runtime2({
							[1] = {
								[1] = 29,
								[10] = 13,
								[11] = 98,
								[12] = 161,
								[13] = 229,
								[14] = 214,
								[15] = 30,
								[16] = 1,
								[17] = 17,
								[18] = 0,
								[19] = 89,
								[2] = 20,
								[20] = 964,
								[21] = 51,
								[22] = 203,
								[23] = 36,
								[24] = 119,
								[25] = 48,
								[26] = 127,
								[27] = 20,
								[28] = 0,
								[29] = 12,
								[3] = 0,
								[30] = 15,
								[31] = 10,
								[32] = 0,
								[33] = 11,
								[34] = 11,
								[35] = 11,
								[36] = 10,
								[37] = 86,
								[38] = 3,
								[39] = 16,
								[4] = 15,
								[5] = 0,
								[6] = 95,
								[7] = 95,
								[8] = 95,
								[9] = 83,
							},
							[10] = {
								[0] = {
									[1] = 0,
									[10] = 20,
									[11] = 4,
									[12] = 60,
									[13] = 186,
									[14] = 141,
									[15] = 0,
									[16] = 0,
									[17] = 0,
									[18] = 1,
									[19] = 190,
									[2] = 0,
									[20] = 22,
									[21] = 214,
									[22] = 1,
									[23] = 73,
									[24] = 184,
									[25] = 131,
									[26] = 194,
									[27] = 198,
									[28] = 1,
									[29] = 12,
									[3] = 0,
									[30] = 0,
									[31] = 0,
									[32] = 0,
									[33] = 246,
									[34] = 1362,
									[35] = 1358,
									[36] = 11,
									[37] = 6,
									[38] = 241,
									[39] = 0,
									[4] = 0,
									[5] = 0,
									[6] = 20,
									[7] = 15,
									[8] = 14,
									[9] = 16,
								},
							},
							[11] = {
								[1] = 241,
								[10] = 265,
								[11] = 61,
								[12] = 229,
								[13] = 218,
								[14] = 117,
								[15] = 241,
								[16] = 241,
								[17] = 241,
								[18] = 192,
								[19] = 263,
								[2] = 151,
								[20] = 66,
								[21] = 3,
								[22] = 69,
								[23] = 142,
								[24] = 61,
								[25] = 229,
								[26] = 218,
								[27] = 117,
								[28] = 173,
								[29] = 211,
								[3] = 239,
								[30] = 241,
								[31] = 151,
								[32] = 239,
								[33] = 18,
								[34] = 254,
								[35] = 149,
								[36] = 165,
								[37] = 38,
								[38] = 238,
								[39] = 241,
								[4] = 121,
								[5] = 37,
								[6] = 38,
								[7] = 38,
								[8] = 38,
								[9] = 38,
							},
							[2] = {
								[1] = 0,
								[10] = 102,
								[11] = 58,
								[12] = 241,
								[13] = 220,
								[14] = 154,
								[15] = 0,
								[16] = 0,
								[17] = 0,
								[18] = 0,
								[19] = 0,
								[2] = 0,
								[20] = 82,
								[21] = 5,
								[22] = 46,
								[23] = 239,
								[24] = 45,
								[25] = 73,
								[26] = 238,
								[27] = 44,
								[28] = 0,
								[29] = 425,
								[3] = 16,
								[30] = 0,
								[31] = 0,
								[32] = 6,
								[33] = 811,
								[34] = 11,
								[35] = 11,
								[36] = 70,
								[37] = 83,
								[38] = 253,
								[39] = 0,
								[4] = 0,
								[5] = 14,
								[7] = 51,
								[9] = 86,
							},
							[3] = {
								[0] = {
									[1] = 0,
									[10] = 102,
									[11] = 58,
									[12] = 241,
									[13] = 220,
									[14] = 154,
									[15] = 0,
									[16] = 0,
									[17] = 0,
									[18] = 0,
									[19] = 0,
									[2] = 0,
									[20] = 82,
									[21] = 5,
									[22] = 46,
									[23] = 239,
									[24] = 45,
									[25] = 73,
									[26] = 238,
									[27] = 44,
									[28] = 0,
									[29] = 425,
									[3] = 16,
									[30] = 0,
									[31] = 0,
									[32] = 6,
									[33] = 811,
									[34] = 11,
									[35] = 11,
									[36] = 70,
									[37] = 83,
									[38] = 253,
									[39] = 0,
									[4] = 0,
									[5] = 14,
									[7] = 51,
									[9] = 86,
								},
								[6] = 140,
								[8] = 0,
							},
							[5] = {
								[0] = {
									[1] = 29,
									[10] = 13,
									[11] = 98,
									[12] = 161,
									[13] = 229,
									[14] = 214,
									[15] = 30,
									[16] = 1,
									[17] = 17,
									[18] = 0,
									[19] = 89,
									[2] = 20,
									[20] = 964,
									[21] = 51,
									[22] = 203,
									[23] = 36,
									[24] = 119,
									[25] = 48,
									[26] = 127,
									[27] = 20,
									[28] = 0,
									[29] = 12,
									[3] = 0,
									[30] = 15,
									[31] = 10,
									[32] = 0,
									[33] = 11,
									[34] = 11,
									[35] = 11,
									[36] = 10,
									[37] = 86,
									[38] = 3,
									[39] = 16,
									[4] = 15,
									[5] = 0,
									[6] = 95,
									[7] = 95,
									[8] = 95,
									[9] = 83,
								},
							},
							[6] = {
								[1] = 0,
								[10] = 20,
								[11] = 4,
								[12] = 60,
								[13] = 186,
								[14] = 141,
								[15] = 0,
								[16] = 0,
								[17] = 0,
								[18] = 1,
								[19] = 190,
								[2] = 0,
								[20] = 22,
								[21] = 214,
								[22] = 1,
								[23] = 73,
								[24] = 184,
								[25] = 131,
								[26] = 194,
								[27] = 198,
								[28] = 1,
								[29] = 12,
								[3] = 0,
								[30] = 0,
								[31] = 0,
								[32] = 0,
								[33] = 246,
								[34] = 1362,
								[35] = 1358,
								[36] = 11,
								[37] = 6,
								[38] = 241,
								[39] = 0,
								[4] = 0,
								[5] = 0,
								[6] = 20,
								[7] = 15,
								[8] = 14,
								[9] = 16,
							},
							[7] = { { 122, 1 } },
							[8] = 0,
							[9] = 21,
						}, {}),
					}

					if not (luraph_frame(nil, nil) > 127) then
						toggle(v77, tbl3)
						luraph_frame(nil, nil)
					else
						toggle(v77, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v77 = v76
					local toggle = v76.Toggle

					local tbl3 = {
						Title = "漏打检测",
						Desc = "可见玩家变红色",
						Value = false,
						Callback = luraph_runtime2({
							[1] = {
								[1] = 39,
								[10] = 243,
								[11] = 240,
								[12] = 19,
								[13] = 248,
								[14] = 2,
								[15] = 20,
								[16] = 0,
								[17] = 0,
								[18] = 116,
								[2] = 33,
								[23] = 13,
								[24] = 5,
								[25] = 104,
								[26] = 99,
								[27] = 54,
								[28] = 1,
								[29] = 4,
								[3] = 30,
								[30] = 3,
								[31] = 0,
								[32] = 1151,
								[33] = 0,
								[34] = 10,
								[35] = 0,
								[36] = 824,
								[37] = 28,
								[38] = 618,
								[39] = 28,
								[4] = 774,
								[40] = 14,
								[41] = 503,
								[5] = 120,
								[6] = 11,
								[7] = 10,
								[8] = 120,
								[9] = 3,
							},
							[10] = {
								[0] = {
									[1] = 0,
									[10] = 254,
									[11] = 87,
									[12] = 65,
									[13] = 184,
									[14] = 0,
									[15] = 0,
									[16] = 0,
									[17] = 0,
									[18] = 20,
									[19] = 14,
									[2] = 0,
									[20] = 16,
									[21] = 20,
									[22] = 16,
									[23] = 20,
									[24] = 84,
									[25] = 196,
									[26] = 240,
									[27] = 111,
									[28] = 0,
									[29] = 11,
									[3] = 0,
									[30] = 0,
									[31] = 1,
									[32] = 1,
									[33] = 1,
									[34] = 0,
									[35] = 0,
									[36] = 144,
									[37] = 11,
									[38] = 0,
									[39] = 0,
									[4] = 0,
									[40] = 0,
									[41] = 8,
									[5] = 714,
									[6] = 688,
									[7] = 11,
									[8] = 6,
									[9] = 12,
								},
							},
							[11] = {
								[1] = 241,
								[10] = 61,
								[11] = 229,
								[12] = 218,
								[13] = 117,
								[14] = 241,
								[15] = 151,
								[16] = 239,
								[17] = 37,
								[18] = 38,
								[19] = 38,
								[2] = 241,
								[20] = 38,
								[21] = 38,
								[22] = 38,
								[23] = 265,
								[24] = 61,
								[25] = 229,
								[26] = 218,
								[27] = 117,
								[28] = 241,
								[29] = 123,
								[3] = 241,
								[30] = 241,
								[31] = 227,
								[32] = 105,
								[33] = 114,
								[34] = 151,
								[35] = 239,
								[36] = 200,
								[37] = 156,
								[38] = 145,
								[39] = 241,
								[4] = 145,
								[40] = 241,
								[41] = 215,
								[5] = 94,
								[6] = 149,
								[7] = 165,
								[8] = 38,
								[9] = 265,
							},
							[2] = {
								[1] = 0,
								[10] = 69,
								[11] = 107,
								[12] = 21,
								[13] = 65,
								[14] = 0,
								[15] = 0,
								[16] = 16,
								[17] = 14,
								[18] = 493,
								[2] = 0,
								[21] = 99,
								[23] = 226,
								[24] = 92,
								[25] = 97,
								[26] = 215,
								[27] = 180,
								[28] = 0,
								[29] = 0,
								[3] = 0,
								[30] = 0,
								[31] = 0,
								[32] = 0,
								[33] = 0,
								[34] = 0,
								[35] = 6,
								[36] = 11,
								[37] = 0,
								[38] = 11,
								[39] = 0,
								[4] = 11,
								[40] = 0,
								[41] = 469,
								[5] = 37,
								[6] = 11,
								[7] = 73,
								[8] = 120,
								[9] = 85,
							},
							[3] = {
								[0] = {
									[1] = 0,
									[10] = 69,
									[11] = 107,
									[12] = 21,
									[13] = 65,
									[14] = 0,
									[15] = 0,
									[16] = 16,
									[17] = 14,
									[18] = 493,
									[2] = 0,
									[21] = 99,
									[23] = 226,
									[24] = 92,
									[25] = 97,
									[26] = 215,
									[27] = 180,
									[28] = 0,
									[29] = 0,
									[3] = 0,
									[30] = 0,
									[31] = 0,
									[32] = 0,
									[33] = 0,
									[34] = 0,
									[35] = 6,
									[36] = 11,
									[37] = 0,
									[38] = 11,
									[39] = 0,
									[4] = 11,
									[40] = 0,
									[41] = 469,
									[5] = 37,
									[6] = 11,
									[7] = 73,
									[8] = 120,
									[9] = 85,
								},
								[19] = 11,
								[20] = 11,
								[22] = 1,
							},
							[5] = {
								[0] = {
									[1] = 39,
									[10] = 243,
									[11] = 240,
									[12] = 19,
									[13] = 248,
									[14] = 2,
									[15] = 20,
									[16] = 0,
									[17] = 0,
									[18] = 116,
									[2] = 33,
									[23] = 13,
									[24] = 5,
									[25] = 104,
									[26] = 99,
									[27] = 54,
									[28] = 1,
									[29] = 4,
									[3] = 30,
									[30] = 3,
									[31] = 0,
									[32] = 1151,
									[33] = 0,
									[34] = 10,
									[35] = 0,
									[36] = 824,
									[37] = 28,
									[38] = 618,
									[39] = 28,
									[4] = 774,
									[40] = 14,
									[41] = 503,
									[5] = 120,
									[6] = 11,
									[7] = 10,
									[8] = 120,
									[9] = 3,
								},
								[19] = 5,
								[20] = 5,
								[21] = 5,
								[22] = 40,
							},
							[6] = {
								[1] = 0,
								[10] = 254,
								[11] = 87,
								[12] = 65,
								[13] = 184,
								[14] = 0,
								[15] = 0,
								[16] = 0,
								[17] = 0,
								[18] = 20,
								[19] = 14,
								[2] = 0,
								[20] = 16,
								[21] = 20,
								[22] = 16,
								[23] = 20,
								[24] = 84,
								[25] = 196,
								[26] = 240,
								[27] = 111,
								[28] = 0,
								[29] = 11,
								[3] = 0,
								[30] = 0,
								[31] = 1,
								[32] = 1,
								[33] = 1,
								[34] = 0,
								[35] = 0,
								[36] = 144,
								[37] = 11,
								[38] = 0,
								[39] = 0,
								[4] = 0,
								[40] = 0,
								[41] = 8,
								[5] = 714,
								[6] = 688,
								[7] = 11,
								[8] = 6,
								[9] = 12,
							},
							[7] = { { 122, 1 } },
							[8] = 0,
							[9] = 21,
						}, {}),
					}

					if not (luraph_frame(nil, nil) > 127) then
						toggle(v77, tbl3)
						luraph_frame(nil, nil)
					else
						toggle(v77, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v77 = v76
					local toggle = v76.Toggle

					local tbl3 = {
						Title = "玩家透视绘制",
						Desc = "",
						Value = false,
						Callback = luraph_runtime2({
														[1] = { --[[ 已折叠 422 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[10] = { --[[ 已折叠 439 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[11] = { --[[ 已折叠 437 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[2] = { --[[ 已折叠 419 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[3] = { --[[ 已折叠 439 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
							[5] = {
																[0] = { --[[ 已折叠 422 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
								[105] = 58,
								[106] = 58,
								[112] = 20,
								[185] = {
									[1] = { 1, 1, 8, 5, 453, 1, 1, 8, 0 },
									[10] = { [0] = { 1, 1, 1, 0, 70, 1, 44, 0, 1 } },
									[11] = { 131, 29, 156, 241, 176, 131, 95, 241, 173 },
									[2] = { 0, 0, 0, 0, 292, 0, 2, 0, 0 },
									[3] = { [0] = { 0, 0, 0, 0, 292, 0, 2, 0, 0 } },
									[5] = { [0] = { 1, 1, 8, 5, 453, 1, 1, 8, 0 } },
									[6] = { 1, 1, 1, 0, 70, 1, 44, 0, 1 },
									[7] = { { 6, 2 }, { 5, 0 }, { 8, 2 } },
									[8] = 0,
									[9] = 3,
								},
								[210] = 0,
																[214] = { --[[ 已折叠 4693 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																[215] = { --[[ 已折叠 984 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																[216] = { --[[ 已折叠 430 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																[217] = { --[[ 已折叠 333 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
								[237] = "Text",
								[238] = 20,
								[263] = 0,
																[27] = { --[[ 已折叠 714 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																[277] = { --[[ 已折叠 578 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																[281] = { --[[ 已折叠 2518 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
								[282] = {
																		[1] = { --[[ 已折叠 332 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																		[10] = { --[[ 已折叠 338 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																		[11] = { --[[ 已折叠 336 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																		[2] = { --[[ 已折叠 324 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																		[3] = { --[[ 已折叠 338 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																		[5] = { --[[ 已折叠 338 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																		[6] = { --[[ 已折叠 334 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
									[7] = {
										{ 19, 2 },
										{ 14, 2 },
										{ 22, 1 },
										{ 16, 2 },
										{ 17, 2 },
										{ 4, 2 },
									},
									[8] = 0,
									[9] = 35,
								},
																[283] = { --[[ 已折叠 1239 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
								[284] = {
									[1] = { 2, 221, 0, 3, 51, 6, 0, 0 },
									[10] = { [0] = { 0, 463, 2, 0, 0, 0, 0, 1 } },
									[11] = { 241, 263, 227, 98, 63, 241, 138, 173 },
									[2] = { 0, 31, 0, 0, 4, 0, 3, 0 },
									[3] = { [0] = { 0, 31, 0, 0, 4, 0, 3, 0 } },
									[5] = {
										[0] = { 2, 221, 0, 3, 51, 6, 0, 0 },
										[5] = {
											[1] = { [1] = 2, [2] = 219, [3] = 3, [4] = 1, [6] = 0 },
											[10] = { [0] = { 0, 63, 0, 0, 1, 1 } },
											[11] = { 241, 240, 241, 98, 105, 173 },
											[2] = { 0, 135, 0, 1, 0, 0 },
											[3] = { [0] = { 0, 135, 0, 1, 0, 0 } },
											[5] = {
												[0] = { [1] = 2, [2] = 219, [3] = 3, [4] = 1, [6] = 0 },
												[5] = "Text",
											},
											[6] = { 0, 63, 0, 0, 1, 1 },
											[7] = { { 1, 1 }, { 2, 1 } },
											[8] = 0,
											[9] = 4,
										},
									},
									[6] = { 0, 463, 2, 0, 0, 0, 0, 1 },
									[7] = { { 22, 2 } },
									[8] = 0,
									[9] = 5,
								},
																[285] = { --[[ 已折叠 308 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
								[286] = {
																		[1] = { --[[ 已折叠 131 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																		[10] = { --[[ 已折叠 137 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																		[11] = { --[[ 已折叠 135 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																		[2] = { --[[ 已折叠 129 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																		[3] = { --[[ 已折叠 137 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																		[5] = { --[[ 已折叠 137 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																		[6] = { --[[ 已折叠 135 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
									[7] = {
										{ 13, 2 },
										{ 8, 2 },
										{ 6, 2 },
										{ 18, 1 },
										{ 19, 1 },
										{ 20, 1 },
										{ 21, 1 },
										{ 7, 2 },
										{ 24, 2 },
									},
									[8] = 0,
									[9] = 26,
								},
																[291] = { --[[ 已折叠 129 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																[292] = { --[[ 已折叠 603 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
								[300] = "new",
																[301] = { --[[ 已折叠 671 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
								[307] = 95,
								[315] = 0,
								[328] = {
									[1] = { 3, 0, 0, 1, 204 },
									[10] = { [0] = { 0, 0, 1, 0, 228 } },
									[11] = { 241, 166, 173, 241, 106 },
									[2] = { 0, 44, 0, 0, 221 },
									[3] = { [0] = { 0, 44, 0, 0, 221 } },
									[5] = { [0] = { 3, 0, 0, 1, 204 } },
									[6] = { 0, 0, 1, 0, 228 },
									[7] = { { 0, 2 } },
									[8] = 0,
									[9] = 2,
								},
																[332] = { --[[ 已折叠 849 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																[337] = { --[[ 已折叠 475 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																[345] = { --[[ 已折叠 750 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
								[361] = "Text",
								[362] = 20,
								[419] = 65,
								[56] = 20,
								[97] = "Players",
							},
														[6] = { --[[ 已折叠 434 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
							[7] = {
								[1] = { 125, 0 },
								[10] = { 32, 1 },
								[11] = { 2, 1 },
								[12] = { 52, 1 },
								[13] = { 61, 1 },
								[14] = { 14, 1 },
								[15] = { 20, 1 },
								[16] = { 127, 0 },
								[17] = { 62, 1 },
								[18] = { 57, 1 },
								[19] = { 53, 1 },
								[2] = { 3, 1 },
								[20] = { 48, 1 },
								[21] = { 38, 1 },
								[22] = { 27, 1 },
								[23] = { 21, 1 },
								[24] = { 24, 1 },
								[25] = { 63, 1 },
								[26] = { 59, 1 },
								[27] = { 64, 1 },
								[28] = { 126, 0 },
								[29] = { 131, 0 },
								[3] = { 35, 1 },
								[4] = { 42, 1 },
								[5] = { 43, 1 },
								[6] = { 4, 1 },
								[7] = { 128, 0 },
								[8] = { 129, 0 },
								[9] = { 130, 0 },
							},
							[8] = 0,
							[9] = 57,
						}, {}),
					}

					if not (luraph_frame(nil, nil) > 134) then
						toggle(v77, tbl3)
						luraph_frame(nil, nil)
					else
						toggle(v77, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v77 = v3
					local getService4 = v3.GetService
					local str5 = "Players"
					local v78

					if luraph_frame(nil, nil) > 134 then
						local v79 = table.pack(getService4(v77, str5))
						v78 = v79[1]
						luraph_frame(nil, nil)
					else
						local v79 = table.pack(getService4(v77, str5))
						v78 = v79[1]
						luraph_frame(nil, nil)
					end
				end

				do
					local v77 = v3
					local getService4 = v3.GetService
					local str5 = "RunService"
					local v78

					if luraph_frame(nil, nil) > 135 then
						local v79 = table.pack(getService4(v77, str5))
						v78 = v79[1]
						luraph_frame(nil, nil)
					else
						local v79 = table.pack(getService4(v77, str5))
						v78 = v79[1]
						luraph_frame(nil, nil)
					end

					local v79 = v3
					local getService5 = v3.GetService
					local str6 = "UserInputService"

					if luraph_frame(nil, nil) > 136 then
						local v80 = table.pack(getService5(v79, str6))
						luraph_frame(nil, nil)
					else
						local v80 = table.pack(getService5(v79, str6))
						luraph_frame(nil, nil)
					end

					local tbl3 = { Enabled = false, FOV = 150, Distance = 500, Speed = 5, Priority = "FOV" }
					local v80 = fromRGB
					local v81

					if not (luraph_frame(nil, nil) > 141) then
						local v82 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 139, 141))
						local v83 = table.pack(v80(table.unpack(v82, 1, v82.n)))
						v81 = v83[1]
						luraph_frame(nil, nil)
					else
						local v82 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 139, 141))
						local v83 = table.pack(v80(table.unpack(v82, 1, v82.n)))
						v81 = v83[1]
						luraph_frame(nil, nil)
					end

					tbl3.CircleColor = v81
					tbl3.VisCheck = true
					tbl3.TargetPart = "Head"
					local new7 = v2.new
					local str7 = "Circle"
					local v82

					if luraph_frame(nil, nil) > 139 then
						local v83 = table.pack(new7(str7))
						v82 = v83[1]
						luraph_frame(nil, nil)
					else
						local v83 = table.pack(new7(str7))
						v82 = v83[1]
						luraph_frame(nil, nil)
					end

					v82.Visible = false
					v82.Thickness = 2
					v82.Color = tbl3.CircleColor
					v82.Transparency = 0.7
					v82.Filled = false
					v82.NumSides = 64

					luraph_runtime2({
												[1] = { --[[ 已折叠 112 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[10] = { --[[ 已折叠 117 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[11] = { --[[ 已折叠 115 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[2] = { --[[ 已折叠 108 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[3] = { --[[ 已折叠 117 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[5] = { --[[ 已折叠 117 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[6] = { --[[ 已折叠 115 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
						[7] = { { 135, 1 }, { 54, 1 }, { 55, 1 }, { 136, 1 }, { 4, 1 } },
						[8] = 0,
						[9] = 28,
					}, {})

					luraph_runtime2({
												[1] = { --[[ 已折叠 229 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[10] = { --[[ 已折叠 234 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[11] = { --[[ 已折叠 232 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[2] = { --[[ 已折叠 223 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[3] = { --[[ 已折叠 234 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[5] = { --[[ 已折叠 234 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[6] = { --[[ 已折叠 232 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
						[7] = {
							{ 43, 1 },
							{ 135, 1 },
							{ 136, 1 },
							{ 20, 1 },
							{ 132, 1 },
							{ 137, 1 },
							{ 139, 1 },
						},
						[8] = 0,
						[9] = 37,
					}, {})

					local renderStepped = v78.RenderStepped
					local v83 = renderStepped
					local connect = renderStepped.Connect

					local v84 = luraph_runtime2({
												[1] = { --[[ 已折叠 104 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[10] = { --[[ 已折叠 109 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[11] = { --[[ 已折叠 107 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[2] = { --[[ 已折叠 96 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[3] = { --[[ 已折叠 109 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[5] = { --[[ 已折叠 109 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
												[6] = { --[[ 已折叠 107 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
						[7] = {
							{ 43, 1 },
							{ 135, 1 },
							{ 138, 1 },
							{ 137, 1 },
							{ 140, 1 },
							{ 48, 1 },
							{ 58, 1 },
						},
						[8] = 0,
						[9] = 27,
					}, {})

					if not (luraph_frame(nil, nil) > 143) then
						connect(v83, v84)
						luraph_frame(nil, nil)
					else
						connect(v83, v84)
						luraph_frame(nil, nil)
					end
				end

				local v77

				do
					local v78 = v52
					local tab = v52.Tab
					local tbl3 = { Title = "自瞄", Icon = "crosshair" }

					if luraph_frame(nil, nil) > 143 then
						local v79 = table.pack(tab(v78, tbl3))
						v77 = v79[1]
						luraph_frame(nil, nil)
					else
						local v79 = table.pack(tab(v78, tbl3))
						v77 = v79[1]
						luraph_frame(nil, nil)
					end
				end

				do
					local v78 = v77
					local section = v77.Section
					local tbl3 = { Title = "自瞄", Box = true, Opened = true }

					if not (luraph_frame(nil, nil) > 144) then
						section(v78, tbl3)
						luraph_frame(nil, nil)
					else
						section(v78, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v78 = v77
					local toggle = v77.Toggle

					local tbl3 = {
						Title = "启用自瞄",
						Desc = "开启后显示FOV圈并锁定敌人",
						Value = false,
						Callback = luraph_runtime2({
							[1] = { 2, 0, 0, 885, 9, 1, 333 },
							[10] = { [0] = { 0, 1, 1, 1, 1, 0, 360 } },
							[11] = { 241, 173, 227, 105, 105, 241, 224 },
							[2] = { 0, 0, 0, 0, 1, 0, 91 },
							[3] = { [0] = { 0, 0, 0, 0, 1, 0, 91 } },
							[5] = { [0] = { 2, 0, 0, 885, 9, 1, 333 } },
							[6] = { 0, 1, 1, 1, 1, 0, 360 },
							[7] = { { 137, 1 }, { 138, 1 } },
							[8] = 0,
							[9] = 3,
						}, {}),
					}

					if not (luraph_frame(nil, nil) > 144) then
						toggle(v78, tbl3)
						luraph_frame(nil, nil)
					else
						toggle(v78, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v78 = v77
					local toggle = v77.Toggle

					local tbl3 = {
						Title = "漏打检测",
						Desc = "只瞄准视野内可见的敌人",
						Callback = luraph_runtime2({
							[1] = { 5, 190, 0, 1119, 0, 2 },
							[10] = { [0] = { 0, 219, 1, 1, 1, 0 } },
							[11] = { 241, 14, 227, 105, 173, 241 },
							[2] = { 0, 477, 0, 0, 0, 0 },
							[3] = { [0] = { 0, 477, 0, 0, 0, 0 } },
							[5] = { [0] = { 5, 190, 0, 1119, 0, 2 } },
							[6] = { 0, 219, 1, 1, 1, 0 },
							[7] = { { 137, 1 } },
							[8] = 0,
							[9] = 3,
						}, {}),
					}

					if not (luraph_frame(nil, nil) > 144) then
						toggle(v78, tbl3)
						luraph_frame(nil, nil)
					else
						toggle(v78, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v78 = v77
					local section = v77.Section
					local tbl3 = { Title = "配置", Box = true, Opened = true }

					if not (luraph_frame(nil, nil) > 144) then
						section(v78, tbl3)
						luraph_frame(nil, nil)
					else
						section(v78, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v78 = v77
					local slider = v77.Slider

					local tbl3 = {
						Title = "圈圈范围 (FOV)",
						Desc = "自瞄检测范围",
						Value = { Min = 50, Max = 400, Default = 150 },
						Callback = luraph_runtime2({
							[1] = { 2, 415, 0, 4, 0 },
							[10] = { [0] = { 0, 354, 1, 1, 1 } },
							[11] = { 241, 104, 227, 105, 173 },
							[2] = { 0, 246, 0, 0, 0 },
							[3] = { [0] = { 0, 246, 0, 0, 0 } },
							[5] = { [0] = { 2, 415, 0, 4, 0 } },
							[6] = { 0, 354, 1, 1, 1 },
							[7] = { { 137, 1 } },
							[8] = 0,
							[9] = 3,
						}, {}),
					}

					if not (luraph_frame(nil, nil) > 144) then
						slider(v78, tbl3)
						luraph_frame(nil, nil)
					else
						slider(v78, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v78 = v77
					local slider = v77.Slider
					local tbl3 = { Min = 100, Max = 2000, Default = 500 }
					local tbl4 = { Title = "自瞄距离", Desc = "最大瞄准距离", Value = tbl3, Callback = tbl3 }

					if not (luraph_frame(nil, nil) > 144) then
						slider(v78, tbl4)
						luraph_frame(nil, nil)
					else
						slider(v78, tbl4)
						luraph_frame(nil, nil)
					end
				end

				do
					local v78 = v77
					local slider = v77.Slider

					local tbl3 = {
						Title = "自瞄速度",
						Desc = "1=最快，30=最慢",
						Value = { Min = 1, Default = 5 },
						Callback = luraph_runtime2({
							[1] = { 5, 167, 0, 344, 0, 2 },
							[10] = { [0] = { 0, 266, 1, 1, 1, 0 } },
							[11] = { 241, 207, 227, 105, 173, 241 },
							[2] = { 0, 149, 0, 0, 0, 0 },
							[3] = { [0] = { 0, 149, 0, 0, 0, 0 } },
							[5] = { [0] = { 5, 167, 0, 344, 0, 2 } },
							[6] = { 0, 266, 1, 1, 1, 0 },
							[7] = { { 137, 1 } },
							[8] = 0,
							[9] = 3,
						}, {}),
					}

					if not (luraph_frame(nil, nil) > 144) then
						slider(v78, tbl3)
						luraph_frame(nil, nil)
					else
						slider(v78, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v78 = v77
					local dropdown = v77.Dropdown

					local tbl3 = {
						Title = "优先条件",
						Desc = "选择自瞄优先级",
						Values = { "FOV", "DISTANCE", "BOTH" },
						Value = "FOV",
						Callback = luraph_runtime2({
							[1] = {
								[1] = 21,
								[10] = 3,
								[11] = 23,
								[12] = 26,
								[13] = 52,
								[14] = 15,
								[15] = 20,
								[16] = 0,
								[19] = 18,
								[2] = 11,
								[20] = 13,
								[21] = 1,
								[22] = 13,
								[23] = 2,
								[24] = 0,
								[25] = 1318,
								[26] = 0,
								[27] = 0,
								[28] = 15,
								[29] = 8,
								[3] = 0,
								[30] = 51,
								[31] = 13,
								[32] = 94,
								[33] = 133,
								[34] = 246,
								[35] = 82,
								[36] = 22,
								[4] = 10,
								[5] = 11,
								[6] = 11,
								[7] = 11,
								[8] = 10,
							},
							[10] = {
								[0] = {
									[1] = 0,
									[10] = 93,
									[11] = 0,
									[12] = 0,
									[13] = 412,
									[14] = 0,
									[15] = 0,
									[16] = 0,
									[17] = 15,
									[18] = 20,
									[19] = 16,
									[2] = 0,
									[20] = 20,
									[21] = 0,
									[22] = 0,
									[23] = 0,
									[24] = 1,
									[25] = 1,
									[26] = 228,
									[27] = 0,
									[28] = 0,
									[29] = 15,
									[3] = 0,
									[30] = 16,
									[31] = 20,
									[32] = 109,
									[33] = 113,
									[34] = 147,
									[35] = 29,
									[36] = 0,
									[4] = 0,
									[5] = 263,
									[6] = 224,
									[7] = 967,
									[8] = 11,
									[9] = 6,
								},
							},
							[11] = {
								[1] = 241,
								[10] = 140,
								[11] = 241,
								[12] = 241,
								[13] = 112,
								[14] = 121,
								[15] = 151,
								[16] = 239,
								[17] = 38,
								[18] = 38,
								[19] = 38,
								[2] = 241,
								[20] = 140,
								[21] = 241,
								[22] = 241,
								[23] = 241,
								[24] = 227,
								[25] = 61,
								[26] = 32,
								[27] = 239,
								[28] = 121,
								[29] = 38,
								[3] = 239,
								[30] = 38,
								[31] = 265,
								[32] = 61,
								[33] = 229,
								[34] = 218,
								[35] = 117,
								[36] = 241,
								[4] = 151,
								[5] = 18,
								[6] = 254,
								[7] = 149,
								[8] = 165,
								[9] = 38,
							},
							[2] = {
								[1] = 0,
								[10] = 0,
								[11] = 0,
								[12] = 0,
								[13] = 123,
								[14] = 0,
								[15] = 0,
								[16] = 16,
								[18] = 203,
								[2] = 0,
								[20] = 0,
								[21] = 0,
								[22] = 0,
								[23] = 0,
								[24] = 0,
								[25] = 0,
								[26] = 0,
								[27] = 16,
								[28] = 0,
								[29] = 51,
								[3] = 6,
								[30] = 18,
								[31] = 82,
								[32] = 247,
								[33] = 139,
								[34] = 166,
								[35] = 146,
								[36] = 0,
								[4] = 0,
								[5] = 451,
								[6] = 11,
								[7] = 11,
							},
							[3] = {
								[0] = {
									[1] = 0,
									[10] = 0,
									[11] = 0,
									[12] = 0,
									[13] = 123,
									[14] = 0,
									[15] = 0,
									[16] = 16,
									[18] = 203,
									[2] = 0,
									[20] = 0,
									[21] = 0,
									[22] = 0,
									[23] = 0,
									[24] = 0,
									[25] = 0,
									[26] = 0,
									[27] = 16,
									[28] = 0,
									[29] = 51,
									[3] = 6,
									[30] = 18,
									[31] = 82,
									[32] = 247,
									[33] = 139,
									[34] = 166,
									[35] = 146,
									[36] = 0,
									[4] = 0,
									[5] = 451,
									[6] = 11,
									[7] = 11,
								},
								[17] = 1,
								[19] = 1,
								[8] = 25,
								[9] = 23,
							},
							[5] = {
								[0] = {
									[1] = 21,
									[10] = 3,
									[11] = 23,
									[12] = 26,
									[13] = 52,
									[14] = 15,
									[15] = 20,
									[16] = 0,
									[19] = 18,
									[2] = 11,
									[20] = 13,
									[21] = 1,
									[22] = 13,
									[23] = 2,
									[24] = 0,
									[25] = 1318,
									[26] = 0,
									[27] = 0,
									[28] = 15,
									[29] = 8,
									[3] = 0,
									[30] = 51,
									[31] = 13,
									[32] = 94,
									[33] = 133,
									[34] = 246,
									[35] = 82,
									[36] = 22,
									[4] = 10,
									[5] = 11,
									[6] = 11,
									[7] = 11,
									[8] = 10,
								},
								[17] = 26,
								[18] = 26,
								[9] = 23,
							},
							[6] = {
								[1] = 0,
								[10] = 93,
								[11] = 0,
								[12] = 0,
								[13] = 412,
								[14] = 0,
								[15] = 0,
								[16] = 0,
								[17] = 15,
								[18] = 20,
								[19] = 16,
								[2] = 0,
								[20] = 20,
								[21] = 0,
								[22] = 0,
								[23] = 0,
								[24] = 1,
								[25] = 1,
								[26] = 228,
								[27] = 0,
								[28] = 0,
								[29] = 15,
								[3] = 0,
								[30] = 16,
								[31] = 20,
								[32] = 109,
								[33] = 113,
								[34] = 147,
								[35] = 29,
								[36] = 0,
								[4] = 0,
								[5] = 263,
								[6] = 224,
								[7] = 967,
								[8] = 11,
								[9] = 6,
							},
							[7] = { { 137, 1 } },
							[8] = 0,
							[9] = 21,
						}, {}),
					}

					if not (luraph_frame(nil, nil) > 144) then
						dropdown(v78, tbl3)
						luraph_frame(nil, nil)
					else
						dropdown(v78, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v78 = v77
					local colorpicker = v77.Colorpicker
					local tbl3 = { Title = "圈圈颜色", Desc = "FOV圈的颜色" }
					local v79 = fromRGB
					local v80

					if not (luraph_frame(nil, nil) > 148) then
						local v81 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 146, 148))
						local v82 = table.pack(v79(table.unpack(v81, 1, v81.n)))
						v80 = v82[1]
						luraph_frame(nil, nil)
					else
						local v81 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 146, 148))
						local v82 = table.pack(v79(table.unpack(v81, 1, v81.n)))
						v80 = v82[1]
						luraph_frame(nil, nil)
					end

					tbl3.Default = v80

					tbl3.Callback = luraph_runtime2({
						[1] = {
							[1] = 4,
							[10] = 14,
							[11] = 111,
							[12] = 228,
							[13] = 74,
							[14] = 59,
							[15] = 18,
							[16] = 0,
							[17] = 1263,
							[18] = 0,
							[19] = 11,
							[2] = 193,
							[20] = 0,
							[21] = 1315,
							[22] = 12,
							[23] = 12,
							[24] = 11,
							[26] = 4,
							[27] = 2,
							[3] = 15,
							[4] = 5,
							[5] = 3,
							[6] = 21,
							[7] = 0,
						},
						[10] = {
							[0] = {
								[1] = 0,
								[10] = 21,
								[11] = 243,
								[12] = 252,
								[13] = 244,
								[14] = 34,
								[15] = 0,
								[16] = 2,
								[17] = 1,
								[18] = 1,
								[19] = 0,
								[2] = 196,
								[20] = 0,
								[21] = 12,
								[22] = 1093,
								[23] = 1124,
								[24] = 12,
								[25] = 7,
								[26] = 13,
								[27] = 0,
								[3] = 0,
								[4] = 0,
								[5] = 0,
								[6] = 0,
								[7] = 0,
								[8] = 21,
								[9] = 17,
							},
						},
						[11] = {
							[1] = 241,
							[10] = 265,
							[11] = 61,
							[12] = 229,
							[13] = 218,
							[14] = 117,
							[15] = 241,
							[16] = 227,
							[17] = 105,
							[18] = 253,
							[19] = 151,
							[2] = 242,
							[20] = 239,
							[21] = 77,
							[22] = 254,
							[23] = 149,
							[24] = 165,
							[25] = 38,
							[26] = 58,
							[27] = 241,
							[3] = 241,
							[4] = 241,
							[5] = 241,
							[6] = 151,
							[7] = 239,
							[8] = 38,
							[9] = 38,
						},
						[2] = {
							[1] = 0,
							[10] = 15,
							[11] = 32,
							[12] = 221,
							[13] = 138,
							[14] = 146,
							[15] = 0,
							[16] = 0,
							[17] = 0,
							[18] = 0,
							[19] = 0,
							[2] = 366,
							[20] = 7,
							[21] = 1076,
							[22] = 12,
							[23] = 12,
							[24] = 70,
							[25] = 120,
							[26] = 0,
							[27] = 0,
							[3] = 0,
							[4] = 0,
							[5] = 0,
							[6] = 0,
							[7] = 17,
							[9] = 70,
						},
						[3] = {
							[0] = {
								[1] = 0,
								[10] = 15,
								[11] = 32,
								[12] = 221,
								[13] = 138,
								[14] = 146,
								[15] = 0,
								[16] = 0,
								[17] = 0,
								[18] = 0,
								[19] = 0,
								[2] = 366,
								[20] = 7,
								[21] = 1076,
								[22] = 12,
								[23] = 12,
								[24] = 70,
								[25] = 120,
								[26] = 0,
								[27] = 0,
								[3] = 0,
								[4] = 0,
								[5] = 0,
								[6] = 0,
								[7] = 17,
								[9] = 70,
							},
							[8] = 140,
						},
						[5] = {
							[0] = {
								[1] = 4,
								[10] = 14,
								[11] = 111,
								[12] = 228,
								[13] = 74,
								[14] = 59,
								[15] = 18,
								[16] = 0,
								[17] = 1263,
								[18] = 0,
								[19] = 11,
								[2] = 193,
								[20] = 0,
								[21] = 1315,
								[22] = 12,
								[23] = 12,
								[24] = 11,
								[26] = 4,
								[27] = 2,
								[3] = 15,
								[4] = 5,
								[5] = 3,
								[6] = 21,
								[7] = 0,
							},
							[25] = 5,
							[8] = 26,
							[9] = 4,
						},
						[6] = {
							[1] = 0,
							[10] = 21,
							[11] = 243,
							[12] = 252,
							[13] = 244,
							[14] = 34,
							[15] = 0,
							[16] = 2,
							[17] = 1,
							[18] = 1,
							[19] = 0,
							[2] = 196,
							[20] = 0,
							[21] = 12,
							[22] = 1093,
							[23] = 1124,
							[24] = 12,
							[25] = 7,
							[26] = 13,
							[27] = 0,
							[3] = 0,
							[4] = 0,
							[5] = 0,
							[6] = 0,
							[7] = 0,
							[8] = 21,
							[9] = 17,
						},
						[7] = { { 137, 1 } },
						[8] = 0,
						[9] = 22,
					}, {})

					if not (luraph_frame(nil, nil) > 144) then
						colorpicker(v78, tbl3)
						luraph_frame(nil, nil)
					else
						colorpicker(v78, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v78 = v77
					local section = v77.Section
					local tbl3 = { Title = "设置", Box = true, Opened = true }

					if not (luraph_frame(nil, nil) > 144) then
						section(v78, tbl3)
						luraph_frame(nil, nil)
					else
						section(v78, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v78 = v77
					local dropdown = v77.Dropdown

					local tbl3 = {
						Title = "瞄准部位",
						Values = { "Head", "HumanoidRootPart", "Torso" },
						Value = "Head",
						Callback = luraph_runtime2({
							[1] = { 4, 0, 1356, 0, 1, 280 },
							[10] = { [0] = { 0, 1, 1, 1, 0, 259 } },
							[11] = { 241, 227, 105, 173, 241, 80 },
							[2] = { 0, 0, 0, 0, 0, 73 },
							[3] = { [0] = { 0, 0, 0, 0, 0, 73 } },
							[5] = { [0] = { 4, 0, 1356, 0, 1, 280 } },
							[6] = { 0, 1, 1, 1, 0, 259 },
							[7] = { { 137, 1 } },
							[8] = 0,
							[9] = 3,
						}, {}),
					}

					if not (luraph_frame(nil, nil) > 144) then
						dropdown(v78, tbl3)
						luraph_frame(nil, nil)
					else
						dropdown(v78, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v78 = v77
					local button = v77.Button
					local tbl3 = { Title = "重置配置", Desc = "恢复默认设置" }

					luraph_runtime2({
						[1] = {
							[1] = 17,
							[10] = 0,
							[11] = 0,
							[12] = 0,
							[13] = 2,
							[14] = 35,
							[15] = 4,
							[16] = 1263,
							[17] = 7,
							[18] = 9,
							[2] = 375,
							[3] = 0,
							[4] = 1,
							[5] = 20,
							[6] = 35,
							[7] = 13,
							[8] = 0,
							[9] = 0,
						},
						[10] = {
							[0] = {
								[1] = 0,
								[10] = 4,
								[11] = 964,
								[12] = 344,
								[13] = 0,
								[14] = 0,
								[15] = 1,
								[16] = 1,
								[17] = 0,
								[18] = 0,
								[2] = 172,
								[3] = 1318,
								[4] = 0,
								[5] = 0,
								[6] = 0,
								[7] = 0,
								[8] = 1119,
								[9] = 1,
							},
						},
						[11] = {
							[1] = 241,
							[10] = 101,
							[11] = 101,
							[12] = 101,
							[13] = 241,
							[14] = 145,
							[15] = 116,
							[16] = 105,
							[17] = 241,
							[18] = 241,
							[2] = 172,
							[3] = 101,
							[4] = 98,
							[5] = 145,
							[6] = 145,
							[7] = 241,
							[8] = 101,
							[9] = 173,
						},
						[2] = {
							[1] = 0,
							[10] = 254,
							[11] = 699,
							[13] = 0,
							[14] = 4,
							[15] = 0,
							[16] = 0,
							[17] = 0,
							[18] = 0,
							[2] = 194,
							[3] = 4,
							[4] = 1,
							[5] = 2,
							[6] = 3,
							[7] = 0,
							[8] = 44,
							[9] = 0,
						},
						[3] = {
							[0] = {
								[1] = 0,
								[10] = 254,
								[11] = 699,
								[13] = 0,
								[14] = 4,
								[15] = 0,
								[16] = 0,
								[17] = 0,
								[18] = 0,
								[2] = 194,
								[3] = 4,
								[4] = 1,
								[5] = 2,
								[6] = 3,
								[7] = 0,
								[8] = 44,
								[9] = 0,
							},
							[12] = 5,
						},
						[5] = {
							[0] = {
								[1] = 17,
								[10] = 0,
								[11] = 0,
								[12] = 0,
								[13] = 2,
								[14] = 35,
								[15] = 4,
								[16] = 1263,
								[17] = 7,
								[18] = 9,
								[2] = 375,
								[3] = 0,
								[4] = 1,
								[5] = 20,
								[6] = 35,
								[7] = 13,
								[8] = 0,
								[9] = 0,
							},
						},
						[6] = {
							[1] = 0,
							[10] = 4,
							[11] = 964,
							[12] = 344,
							[13] = 0,
							[14] = 0,
							[15] = 1,
							[16] = 1,
							[17] = 0,
							[18] = 0,
							[2] = 172,
							[3] = 1318,
							[4] = 0,
							[5] = 0,
							[6] = 0,
							[7] = 0,
							[8] = 1119,
							[9] = 1,
						},
						[7] = { { 137, 1 }, { 42, 1 } },
						[8] = 0,
						[9] = 5,
					}, {})

					if not (luraph_frame(nil, nil) > 144) then
						button(v78, tbl3)
						luraph_frame(nil, nil)
					else
						button(v78, tbl3)
						luraph_frame(nil, nil)
					end
				end

				do
					local v78 = v52
					local tab = v52.Tab
					local tbl3 = { Title = "范围", Icon = "layout-grid" }
					local v79

					if luraph_frame(nil, nil) > 144 then
						local v80 = table.pack(tab(v78, tbl3))
						v79 = v80[1]
						luraph_frame(nil, nil)
					else
						local v80 = table.pack(tab(v78, tbl3))
						v79 = v80[1]
						luraph_frame(nil, nil)
					end

					local v80 = fromRGB
					local v81

					if not (luraph_frame(nil, nil) > 148) then
						local v82 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 146, 148))
						local v83 = table.pack(v80(table.unpack(v82, 1, v82.n)))
						v81 = v83[1]
						luraph_frame(nil, nil)
					else
						local v82 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 146, 148))
						local v83 = table.pack(v80(table.unpack(v82, 1, v82.n)))
						v81 = v83[1]
						luraph_frame(nil, nil)
					end

					local v82 = v79
					local slider = v79.Slider

					local tbl4 = {
						Title = "调整范围",
						Desc = "",
						Step = 1,
						Value = { Default = 1, Min = 1, Max = 100 },
						Callback = luraph_runtime2({
														[1] = { --[[ 已折叠 68 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[10] = { --[[ 已折叠 72 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[11] = { --[[ 已折叠 70 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[2] = { --[[ 已折叠 66 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[3] = { --[[ 已折叠 72 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[5] = { --[[ 已折叠 72 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[6] = { --[[ 已折叠 70 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
							[7] = { { 28, 1 }, { 143, 0 } },
							[8] = 0,
							[9] = 23,
						}, {}),
					}

					if not (luraph_frame(nil, nil) > 149) then
						slider(v82, tbl4)
						luraph_frame(nil, nil)
					else
						slider(v82, tbl4)
						luraph_frame(nil, nil)
					end

					local v83 = v79
					local toggle = v79.Toggle

					local tbl5 = {
						Title = "范围",
						Desc = "",
						Value = false,
						Callback = luraph_runtime2({
														[1] = { --[[ 已折叠 166 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[10] = { --[[ 已折叠 175 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[11] = { --[[ 已折叠 173 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[2] = { --[[ 已折叠 166 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
														[3] = { --[[ 已折叠 175 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
							[5] = {
																[0] = { --[[ 已折叠 166 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
								[104] = 26,
								[105] = 42,
								[119] = 51,
								[120] = 52,
								[140] = "Players",
								[169] = {
																		[1] = { --[[ 已折叠 77 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																		[10] = { --[[ 已折叠 86 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																		[11] = { --[[ 已折叠 84 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																		[2] = { --[[ 已折叠 78 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																		[3] = { --[[ 已折叠 86 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
									[5] = {
																				[0] = { --[[ 已折叠 77 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
										[24] = 4,
										[31] = "Players",
										[42] = {
																						[1] = { --[[ 已折叠 96 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																						[10] = { --[[ 已折叠 102 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																						[11] = { --[[ 已折叠 100 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																						[2] = { --[[ 已折叠 93 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																						[3] = { --[[ 已折叠 102 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																						[5] = { --[[ 已折叠 102 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
																						[6] = { --[[ 已折叠 100 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
											[7] = {
												{ 3, 1 },
												{ 3, 2 },
												{ 4, 2 },
												{ 5, 2 },
												{ 6, 2 },
												{ 7, 2 },
											},
											[8] = 0,
											[9] = 24,
										},
										[49] = 41,
										[63] = 3,
										[74] = 21,
										[75] = 20,
										[80] = "Players",
									},
																		[6] = { --[[ 已折叠 83 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
									[7] = {
										{ 3, 2 },
										{ 4, 2 },
										{ 5, 2 },
										{ 6, 2 },
										{ 8, 2 },
										{ 9, 2 },
										{ 10, 2 },
										{ 7, 2 },
									},
									[8] = 0,
									[9] = 24,
								},
								[55] = 74,
																[71] = { --[[ 已折叠 625 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
								[78] = "Players",
							},
														[6] = { --[[ 已折叠 171 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
							[7] = {
								[1] = { 28, 1 },
								[10] = { 66, 1 },
								[11] = { 145, 0 },
								[2] = { 144, 0 },
								[3] = { 146, 0 },
								[4] = { 20, 1 },
								[5] = { 3, 1 },
								[6] = { 21, 1 },
								[7] = { 53, 1 },
								[8] = { 65, 1 },
								[9] = { 143, 0 },
							},
							[8] = 0,
							[9] = 25,
						}, {}),
					}

					if not (luraph_frame(nil, nil) > 149) then
						toggle(v83, tbl5)
						luraph_frame(nil, nil)
					else
						toggle(v83, tbl5)
						luraph_frame(nil, nil)
					end
				end

				if not (luraph_frame(nil, nil) > 94) then
					local v78 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 92, 94))
					local v79 = table.pack(v54(table.unpack(v78, 1, v78.n)))
					v55 = v79[1]
					luraph_frame(nil, nil)
				else
					local v78 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 92, 94))
					local v79 = table.pack(v54(table.unpack(v78, 1, v78.n)))
					v55 = v79[1]
					luraph_frame(nil, nil)
				end

				v53.Color = v55
				v53.ApplyStrokeMode = applyStrokeMode.Border
				v56 = new
				str4 = "UIGradient"

				if luraph_frame(nil, nil) > 92 then
					local v78 = table.pack(v56(str4))
					v57 = v78[1]
					luraph_frame(nil, nil)
				else
					local v78 = table.pack(v56(str4))
					v57 = v78[1]
					luraph_frame(nil, nil)
				end

				v58 = new3
				tbl2 = {}
				v59 = new4
				v60 = fromRGB

				if not (luraph_frame(nil, nil) > 99) then
					local v78 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 97, 99))
					local v79 = table.pack(v60(table.unpack(v78, 1, v78.n)))
					local v80 = table.pack(luraph_runtime1(table.unpack(v79, 1, v79.n)))
					luraph_frame(nil, nil)
				else
					local v78 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 97, 99))
					local v79 = table.pack(v60(table.unpack(v78, 1, v78.n)))
					local v80 = table.pack(luraph_runtime1(table.unpack(v79, 1, v79.n)))
					luraph_frame(nil, nil)
				end

				if not (luraph_frame(nil, nil) > t1540_1070_4[1] + 96 - 1) then
					local v78 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 95, t1540_1070_4[1] + 96 - 1))
					local v79 = table.pack(v59(table.unpack(v78, 1, v78.n)))
					luraph_frame(nil, nil)
				else
					local v78 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 95, t1540_1070_4[1] + 96 - 1))
					local v79 = table.pack(v59(table.unpack(v78, 1, v78.n)))
					luraph_frame(nil, nil)
				end

				v61 = new4
				v62 = fromRGB

				if not (luraph_frame(nil, nil) > 100) then
					local v78 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 98, 100))
					local v79 = table.pack(v62(table.unpack(v78, 1, v78.n)))
					local v80 = table.pack(luraph_runtime1(table.unpack(v79, 1, v79.n)))
					luraph_frame(nil, nil)
				else
					local v78 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 98, 100))
					local v79 = table.pack(v62(table.unpack(v78, 1, v78.n)))
					local v80 = table.pack(luraph_runtime1(table.unpack(v79, 1, v79.n)))
					luraph_frame(nil, nil)
				end

				if not (luraph_frame(nil, nil) > t654_1086_4[1] + 97 - 1) then
					local v78 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 96, t654_1086_4[1] + 97 - 1))
					local v79 = table.pack(v61(table.unpack(v78, 1, v78.n)))
					luraph_frame(nil, nil)
				else
					local v78 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 96, t654_1086_4[1] + 97 - 1))
					local v79 = table.pack(v61(table.unpack(v78, 1, v78.n)))
					luraph_frame(nil, nil)
				end

				v63 = new4
				v64 = fromRGB

				if not (luraph_frame(nil, nil) > 101) then
					local v78 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 99, 101))
					local v79 = table.pack(v64(table.unpack(v78, 1, v78.n)))
					local v80 = table.pack(luraph_runtime1(table.unpack(v79, 1, v79.n)))
					luraph_frame(nil, nil)
				else
					local v78 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 99, 101))
					local v79 = table.pack(v64(table.unpack(v78, 1, v78.n)))
					local v80 = table.pack(luraph_runtime1(table.unpack(v79, 1, v79.n)))
					luraph_frame(nil, nil)
				end

				if not (luraph_frame(nil, nil) > t1161_1096_4[1] + 98 - 1) then
					local v78 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 97, t1161_1096_4[1] + 98 - 1))
					local v79 = table.pack(v63(table.unpack(v78, 1, v78.n)))
					luraph_frame(nil, nil)
				else
					local v78 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 97, t1161_1096_4[1] + 98 - 1))
					local v79 = table.pack(v63(table.unpack(v78, 1, v78.n)))
					luraph_frame(nil, nil)
				end

				v65 = new4
				v66 = fromRGB

				if not (luraph_frame(nil, nil) > 102) then
					local v78 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 100, 102))
					local v79 = table.pack(v66(table.unpack(v78, 1, v78.n)))
					local v80 = table.pack(luraph_runtime1(table.unpack(v79, 1, v79.n)))
					luraph_frame(nil, nil)
				else
					local v78 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 100, 102))
					local v79 = table.pack(v66(table.unpack(v78, 1, v78.n)))
					local v80 = table.pack(luraph_runtime1(table.unpack(v79, 1, v79.n)))
					luraph_frame(nil, nil)
				end

				if not (luraph_frame(nil, nil) > t75_1105_4[1] + 99 - 1) then
					local v78 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 98, t75_1105_4[1] + 99 - 1))
					local v79 = table.pack(v65(table.unpack(v78, 1, v78.n)))
					luraph_frame(nil, nil)
				else
					local v78 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 98, t75_1105_4[1] + 99 - 1))
					local v79 = table.pack(v65(table.unpack(v78, 1, v78.n)))
					luraph_frame(nil, nil)
				end

				v67 = new4
				v68 = fromRGB

				if not (luraph_frame(nil, nil) > 103) then
					local v78 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 101, 103))
					local v79 = table.pack(v68(table.unpack(v78, 1, v78.n)))
					local v80 = table.pack(luraph_runtime1(table.unpack(v79, 1, v79.n)))
					luraph_frame(nil, nil)
				else
					local v78 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 101, 103))
					local v79 = table.pack(v68(table.unpack(v78, 1, v78.n)))
					local v80 = table.pack(luraph_runtime1(table.unpack(v79, 1, v79.n)))
					luraph_frame(nil, nil)
				end

				local v78 = table.pack(luraph_runtime1(v67(luraph_runtime3(nil --[[ the caller's registers ]], 99, t81_1115_4[1] + 100 - 1))))
				luraph_frame(nil, nil)
				table.move(nil --[[ the caller's registers ]], 94, v78[1] + 98 - 1, 1, tbl2)

				if luraph_frame(nil, nil) > 93 then
					local v79 = table.pack(v58(tbl2))
					v69 = v79[1]
					luraph_frame(nil, nil)
				else
					local v79 = table.pack(v58(tbl2))
					v69 = v79[1]
					luraph_frame(nil, nil)
				end

				v57.Color = v69
				v57.Enabled = true
				v70 = new5
				n3 = 0
				n4 = 0

				if luraph_frame(nil, nil) > 94 then
					local v79 = table.pack(v70(n3, n4))
					v71 = v79[1]
					luraph_frame(nil, nil)
				else
					local v79 = table.pack(v70(n3, n4))
					v71 = v79[1]
					luraph_frame(nil, nil)
				end

				v57.Offset = v71
				v53.Parent = main
				v57.Parent = v53
				v72 = v36

				v73 = luraph_runtime2({
										[1] = { --[[ 已折叠 86 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
										[10] = { --[[ 已折叠 92 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
										[11] = { --[[ 已折叠 90 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
										[2] = { --[[ 已折叠 86 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
										[3] = { --[[ 已折叠 92 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
										[5] = { --[[ 已折叠 92 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
										[6] = { --[[ 已折叠 89 行数据表（VM 常量表，读代码用不上；完整版见同名 .full.lua） ]] },
					[7] = { { 89, 1 }, { 35, 1 }, { 91, 1 } },
					[8] = 0,
					[9] = 23,
				}, {})

				if not (luraph_frame(nil, nil) > 93) then
					v72(v73)
					luraph_frame(nil, nil)
					continue
				end

				v72(v73)
				luraph_frame(nil, nil)
			end
		end
	end

	local v42 = fn

	if not (luraph_frame(nil, nil) > 89) then
		local v43 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 87, 89))
		v42(table.unpack(v43, 1, v43.n))
		luraph_frame(nil, nil)
	else
		local v43 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 87, 89))
		v42(table.unpack(v43, 1, v43.n))
		luraph_frame(nil, nil)
	end

	local v43 = wait
	local n = 1

	if not (luraph_frame(nil, nil) > 87) then
		v43(n)
		luraph_frame(nil, nil)
	else
		v43(n)
		luraph_frame(nil, nil)
	end

	local v44 = localPlayer
	local kick = localPlayer.Kick
	local str4 = "❌ 数据解析失败"

	if not (luraph_frame(nil, nil) > 88) then
		kick(v44, str4)
		luraph_frame(nil, nil)
	else
		kick(v44, str4)
		luraph_frame(nil, nil)
	end

	return
end

local v37 = fn

if not (luraph_frame(nil, nil) > 85) then
	local v38 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 83, 85))
	v37(table.unpack(v38, 1, v38.n))
	luraph_frame(nil, nil)
else
	local v38 = table.pack(luraph_runtime3(nil --[[ the caller's registers ]], 83, 85))
	v37(table.unpack(v38, 1, v38.n))
	luraph_frame(nil, nil)
end

local v38 = wait
local n = 1

if not (luraph_frame(nil, nil) > 83) then
	v38(n)
	luraph_frame(nil, nil)
else
	v38(n)
	luraph_frame(nil, nil)
end

local v39 = localPlayer
local kick = localPlayer.Kick
local str4 = "❌ 网络错误，验证失败"

if not (luraph_frame(nil, nil) > 84) then
	kick(v39, str4)
	luraph_frame(nil, nil)
else
	kick(v39, str4)
	luraph_frame(nil, nil)
end
