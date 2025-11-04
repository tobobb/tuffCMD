-- // TuffCMD main
-- // TODO:
	-- 1. Organise ur loadstrings (they're horrendous)

function fromRGB(r,g,b) 
	return Color3.new(r/255,g/255,b/255) 
end

local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Mouse = Player:GetMouse()

local screenGui = Instance.new("ScreenGui", PlayerGui)
screenGui.Name = "TuffCMD"
screenGui.ResetOnSpawn = false

local TextBox = Instance.new("TextBox", screenGui)
TextBox.Visible = true
TextBox.BackgroundColor3 = fromRGB(36, 36, 37)
TextBox.BorderSizePixel = 0
TextBox.TextColor3 = Color3.new(1, 1, 1)
TextBox.TextStrokeTransparency = 1
TextBox.Size = UDim2.new(0, 250, 0, 20)
TextBox.Position = UDim2.new(1, -250, 1, -20)
TextBox.TextWrapped = true
TextBox.Text = "TuffCMD | Command bar"

local Commands = {}

local function Split(str)
	local words = {}
	for word in string.gmatch(str, "%S+") do
		table.insert(words, word)
	end
	return words
end

local function GetPlayers(target)
	target = string.lower(target or "")

	if target == "all" then
		return game.Players:GetPlayers()
	elseif target == "others" then
		local plrs = {}
		for _, p in ipairs(game.Players:GetPlayers()) do
			if p ~= Player then
				table.insert(plrs, p)
			end
		end
		return plrs
	elseif target == "me" then
		return {Player}
	else
		for _, p in ipairs(game.Players:GetPlayers()) do
			if string.sub(string.lower(p.Name), 1, #target) == target then
				return {p}
			end
		end
	end
	return {}
end

local function Notify(Text, duration)
	local nthread = coroutine.create(function()
		duration = duration or 3

		local sGui = Instance.new("ScreenGui", screenGui)
		local Frame = Instance.new("Frame", sGui)
		local Label = Instance.new("TextLabel", Frame)

		Frame.Size = UDim2.new(0, 250, 0, 30)
		Frame.Position = UDim2.new(0, -260, 0, 450)
		Frame.BorderSizePixel = 0
		Frame.BackgroundColor3 = fromRGB(36, 36, 37)
		Frame.BackgroundTransparency = 0

		Label.Size = UDim2.new(1, 0, 1, 0)
		Label.Text = tostring(Text)
		Label.BackgroundTransparency = 1
		Label.TextColor3 = fromRGB(255, 255, 255)

		local startPos = Frame.Position
		local endPos = UDim2.new(0, 10, 0, 450)
		Frame:TweenPosition(endPos, Enum.EasingDirection.In, Enum.EasingStyle.Quad, 2, false)
		wait(duration)
		Frame:TweenPosition(startPos, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 2, false)
		wait(2)
		sGui:Destroy()
	end)
	coroutine.resume(nthread)
end

-- // oh my god tobob you couldnt have done this more efficiently? 😭😭😭
-- // I'll organise this more tmr
--// loadstrings

function checkHttpSupport(): boolean
	local success = false;
	local testUrl = "https://www.google.com"
	pcall(function() 
		
	end)

	return success;
end

function loadfromurl(url: string): any
	
end

function run_DogeArmy()
	local s, r = pcall(function()
		loadstring(game:HttpGetAsync("http://github.com/tobobb/tuffCMD/raw/refs/heads/main/misc/scripts/DogeArmy.lua"))()
	end)
	if not s then
		Notify("Your exploit does NOT have HttpGet / HttpGetAsync!", 3.5)
	end
end

function run_Dex()
	local s, r = pcall(function()
		loadstring(game:HttpGetAsync("http://github.com/tobobb/tuffCMD/raw/refs/heads/main/misc/scripts/Dex.lua"))()
	end)
	if not s then
		Notify("Your exploit does NOT have HttpGet / HttpGetAsync!", 3.5)
	end
end

function run_HolyWrench()
	local s, r = pcall(function()
		loadstring(game:HttpGetAsync("http://github.com/tobobb/tuffCMD/raw/refs/heads/main/misc/scripts/HolyWrench.lua"))()
	end)
	if not s then
		Notify("Your exploit does NOT have HttpGet / HttpGetAsync!", 3.5)
	end
end

function run_JohnDoe()
	local s, r = pcall(function()
		loadstring(game:HttpGetAsync("http://raw.githubusercontent.com/tobobb/tuffCMD/refs/heads/main/misc/scripts/JohnDoe.lua"))()
	end)
	if not s then
		Notify("Your exploit does NOT have HttpGet / HttpGetAsync!", 3.5)
	end
end

--// command register func
local function addCmd(name, func)
	Commands[name] = func
end

--// commands
addCmd("kill", function(targetName)
	for _, plr in ipairs(GetPlayers(targetName)) do
		local char = plr.Character
		char:BreakJoints()
	end
end)

addCmd("speed", function(targetName, value)
	for _, plr in ipairs(GetPlayers(targetName)) do
		local hum = plr.Character and plr.Character:FindFirstChild("Humanoid")
		if hum then
			hum.WalkSpeed = tonumber(value) or 16
		end
	end
end)

addCmd("jumppower", function(targetName, value)
	for _, plr in ipairs(GetPlayers(targetName)) do
		local hum = plr.Character and plr.Character:FindFirstChild("Humanoid")
		if hum then
			hum.JumpPower = tonumber(value) or 50
		end
	end
end)

addCmd("explode", function(targetName)
	for _, plr in ipairs(GetPlayers(targetName)) do
		local torso = plr.Character and plr.Character:FindFirstChild("Torso")
		if torso then
			local exp = Instance.new("Explosion")
			exp.BlastPressure = math.huge
			exp.Position = torso.Position
			exp.Parent = workspace
		end
	end
end)

addCmd("god", function(targetName)
	for _, plr in ipairs(GetPlayers(targetName)) do
		local hum = plr.Character and plr.Character:FindFirstChild("Humanoid")
		if hum then
			hum.MaxHealth = math.huge
			hum.Health = hum.MaxHealth
		end
	end
end)

addCmd("duck", function(targetName)
	for _, plr in ipairs(GetPlayers(targetName)) do
		local char = plr.Character
		if char then
			for _, v in ipairs(char:GetChildren()) do
				if v:IsA("Accessory") or v:IsA("Hat") or v:IsA("Decal") or v:IsA("Pants") or v:IsA("Shirt") then
					v:Destroy()
				end
			end
			local torso = char:FindFirstChild("Torso")
			if torso then
				local duck = Instance.new("SpecialMesh", torso)
				duck.MeshType = "FileMesh"
				duck.MeshId = "http://www.roblox.com/asset/?id=9419831"
				duck.TextureId = "http://www.roblox.com/asset/?id=9419827"
				duck.Scale = Vector3.new(5,5,5)
			end
			for _, partName in ipairs({"Left Arm","Right Arm","Left Leg","Right Leg","Head"}) do
				local part = char:FindFirstChild(partName)
				if part then part.Transparency = 1 end
			end
			local face = char:FindFirstChild("Head") and char.Head:FindFirstChild("face")
			if face then face.Transparency = 1 end
		end
	end
end)

addCmd("btools", function(targetName)
	for _, plr in ipairs(GetPlayers(targetName)) do
		local backpack = plr:FindFirstChild("Backpack")
		if backpack then
			local drag = Instance.new("HopperBin")
			drag.BinType = "Grab"
			drag.Parent = backpack

			local hammer = Instance.new("HopperBin")
			hammer.BinType = "Hammer"
			hammer.Parent = backpack

			local clone = Instance.new("HopperBin")
			clone.BinType = "Clone"
			clone.Parent = backpack
		end
	end
end)

addCmd("johndoe", function()
	run_JohnDoe()
end)

addCmd("dogearmy", function()
	run_DogeArmy()
end)

addCmd("holywrench", function()
	run_HolyWrench()
end)

addCmd("dex", function()
	run_Dex()
end)

--// input check :p
TextBox.FocusLost:connect(function(enterPressed)
	if enterPressed then
		local contents = TextBox.Text
		local split = Split(contents)
		local cmd = string.lower(split[1] or "")
		table.remove(split, 1)
		if Commands[cmd] then
			Commands[cmd](unpack(split))
		else
			print("Unknown command:", cmd)
		end
		TextBox.Text = "TuffCMD | Command bar"
	else
		TextBox.Text = "TuffCMD | Command bar"
	end
end)

Mouse.KeyDown:connect(function(key)
	key = string.lower(key)
	if key == ";" then
		TextBox.Visible = true
		TextBox.Text = ""
		TextBox:CaptureFocus()
	end
end)

local athread = coroutine.create(function()
	Notify("Welcome, "..game:GetService("Players").LocalPlayer.Name.."!", 3)
	wait(4.5)
	if workspace.FilteringEnabled then
		Notify("Filtering is ENABLED.", 3)
	else
		Notify("Filtering is DISABLED.", 3)
	end
end)
coroutine.resume(athread)
