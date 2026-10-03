-- deobf by https://discord.gg/ck3k7nAVS

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
gethwid()
local response = game:HttpGet("https://raw.githubusercontent.com/GKye9178/okokok91787891kkk/refs/heads/main/gk%E8%8E%B7%E5%8F%96%E7%99%BD%E5%90%8D%E5%8D%95.lua")
local result = response:gsub("^﻿", "")
local result2 = result:gsub("%s*%-%-[^\n\r]*", "")
local result3 = result2:gsub(",(%s*[%]%}])", "%1")
HttpService:JSONDecode(result3)
StarterGui:SetCore("SendNotification", { Text = "白名单数据格式错误，请联系管理员", Title = "Bacon head", Duration = 5 })
task.wait(1)
Players.LocalPlayer:Kick("❌ 数据解析失败")
