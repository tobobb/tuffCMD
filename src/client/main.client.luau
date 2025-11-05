-- // TuffCMD main

--------------------------------------------------
HTTP_REQUESTS_SUPPORTED = false;
LOADSTRING_SUPPORTED = false;
HTTPGET = nil;
--------------------------------------------------

local RunService = game:GetService('RunService');

local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Mouse = Player:GetMouse()

function gethui()
	local hasCore = pcall(function() return game:GetService("CoreGui").Name end)	
	if (hasCore == "CoreGui") then
		return game:GetService("CoreGui");
	end
	return Player.PlayerGui;
end

function fromRGB(r,g,b) 
	return Color3.new(r/255,g/255,b/255) 
end

local screenGui = Instance.new("ScreenGui");
screenGui.Parent = gethui();
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

local cmdsframe = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local cmdContentFrame = Instance.new("ScrollingFrame")
local TestCmdLabel = Instance.new("TextLabel")
local CloseCmdsFrame = Instance.new("TextButton")

cmdsframe.Name = "cmdsframe"
cmdsframe.Parent = screenGui
cmdsframe.AnchorPoint = Vector2.new(0.5, 0.5)
cmdsframe.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
cmdsframe.BorderColor3 = Color3.fromRGB(0, 0, 0)
cmdsframe.BorderSizePixel = 0
cmdsframe.Position = UDim2.new(0.499662161, 0, 0.499999911, 0)
cmdsframe.Size = UDim2.new(0, 313, 0, 392)
cmdsframe.Visible = false

TextLabel.Parent = cmdsframe
TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.498402566, 0, 0.0433673486, 0)
TextLabel.Size = UDim2.new(0, 200, 0, 34)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "TuffCMD | Commands"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 15.000

cmdContentFrame.Name = "cmdContentFrame"
cmdContentFrame.Parent = cmdsframe
cmdContentFrame.Active = true
cmdContentFrame.AnchorPoint = Vector2.new(0.5, 0.5)
cmdContentFrame.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
cmdContentFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
cmdContentFrame.BorderSizePixel = 0
cmdContentFrame.Position = UDim2.new(0.504792333, 0, 0.536989808, 0)
cmdContentFrame.Size = UDim2.new(0, 284, 0, 335)
cmdContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

TestCmdLabel.Name = "TestCmdLabel"
TestCmdLabel.Parent = cmdContentFrame
TestCmdLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TestCmdLabel.BackgroundTransparency = 1.000
TestCmdLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TestCmdLabel.BorderSizePixel = 0
TestCmdLabel.Size = UDim2.new(0, 284, 0, 34)
TestCmdLabel.Visible = false
TestCmdLabel.Font = Enum.Font.SourceSans
TestCmdLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TestCmdLabel.TextSize = 14.000

CloseCmdsFrame.Name = "CloseCmdsFrame"
CloseCmdsFrame.Parent = cmdsframe
CloseCmdsFrame.AnchorPoint = Vector2.new(0.5, 0.5)
CloseCmdsFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CloseCmdsFrame.BackgroundTransparency = 1.000
CloseCmdsFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
CloseCmdsFrame.BorderSizePixel = 0
CloseCmdsFrame.Position = UDim2.new(0.940894544, 0, 0.0408163257, 0)
CloseCmdsFrame.Size = UDim2.new(0, 23, 0, 22)
CloseCmdsFrame.Font = Enum.Font.SourceSans
CloseCmdsFrame.Text = "X"
CloseCmdsFrame.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseCmdsFrame.TextSize = 14.000

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
		Frame:TweenPosition(endPos, Enum.EasingDirection.In, Enum.EasingStyle.Sine, 2, false)
		wait(duration)
		Frame:TweenPosition(startPos, Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 2, false)
		wait(2)
		sGui:Destroy()
	end)
	coroutine.resume(nthread)
end

-- // oh my god tobob you couldnt have done this more efficiently? 😭😭😭
-- // shut UP buddy!!!!!!!! - tobob
-- // I'll organise this more tmr
--// loadstrings

function checkLoadstringSupport()
	local result = false;

	local test = [[
local r, c, x;

r = 5;
c = 10;
x = 15;

local calculation = r + c + x;

if (calculation ~= 30) then
	error('Loadstring is not supported!');
	return nil;
end
return calculation
]];

	xpcall(
		function ()
			local res = loadstring(test)();
			if (res and res == 30) then
				result = true;
			end
		end,
		function (e) 
			result = false;
		end
	);

	return result;
end

function checkHttpSupport()
	local success = false;
	local httpget = nil;
	local testUrl = "https://postman-echo.com/get";
	pcall(function() 
		local r = game:HttpGet(testUrl, true);
		if (r and string.match(r, "^%s*$") ~= nil) then
			success = true;
			httpget = function (...) return game:HttpGet(...) end;
		end
		local r2 = game:HttpGetAsync(testUrl, true);
		if (r2 and string.match(r2, "^%s*$") ~= nil) then
			success = true;
			httpget = function (...) return game:HttpGetAsync(...) end;
		end
	end)

	return success, httpget;
end

--// command register func
local function addCmd(name, func)
	Commands[name] = func
end

local function addLsCmd(name, loadstringurl)
	Commands[name] = function ()
		if (not HTTP_REQUESTS_SUPPORTED) then Notify("Your executor does not support HTTP requests!"); return end;
		if (not LOADSTRING_SUPPORTED) then Notify("Your executor does not support loadstring!"); return end;

		xpcall(
			function ()
				local data = HTTPGET(loadstringurl);
				coroutine.resume(coroutine.create(function()
					loadstring(data)()
				end))
			end,
			function (e)
				Notify("An error occured while trying to run this script!");
				Notify(e);
			end
		)
	end
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

addLsCmd("johndoe", "https://raw.githubusercontent.com/tobobb/tuffCMD/refs/heads/main/misc/scripts/JohnDoe.lua");
addLsCmd("dogearmy", "https://raw.githubusercontent.com/tobobb/tuffCMD/refs/heads/main/misc/scripts/DogeArmy.lua")
addLsCmd("holywrench", "https://raw.githubusercontent.com/tobobb/tuffCMD/refs/heads/main/misc/scripts/HolyWrench.lua")
addLsCmd("dex", "http://github.com/tobobb/tuffCMD/raw/refs/heads/main/misc/scripts/Dex.lua");
addLsCmd("sealiosurvival", "https://raw.githubusercontent.com/tobobb/tuffCMD/refs/heads/main/misc/scripts/SealioSurvival2016L.lua");
addLsCmd("wiras", "https://raw.githubusercontent.com/tobobb/tuffCMD/refs/heads/main/misc/scripts/2016L-wiras.lua");

--------------------------------------------------------------------------
local __idx = 0;
addCmd("cmds", function ()
	__idx = 0;

	TestCmdLabel.Parent = nil;
	cmdContentFrame:ClearAllChildren();
	TestCmdLabel.Parent = cmdContentFrame;

	for name, func in pairs(Commands) do
		__idx = __idx + 1;
		local n = TestCmdLabel:Clone();

		n.Parent = cmdContentFrame;
		n.Name = name;
		n.Visible = true;
		n.Text = name;

		if (__idx > 1) then
			n.Position = TestCmdLabel.Position + UDim2.new(0, 0, __idx * 0.05, 0);
			cmdContentFrame.CanvasSize = cmdContentFrame.CanvasSize + UDim2.new(0, 0, 0.05, 0);
		end
	end

	cmdsframe.Visible = true;
end)
--------------------------------------------------------------------------

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

CloseCmdsFrame.MouseButton1Click:Connect(function()
	cmdsframe.Visible = false;
end)

local athread = coroutine.create(function()
	Notify("Welcome, "..game:GetService("Players").LocalPlayer.Name.."!", 3)
	wait(4.5)
	if workspace.FilteringEnabled then
		Notify("Filtering is ENABLED.", 3)
	else
		Notify("Filtering is DISABLED.", 3)
	end
	task.wait(3.5);
	local cres, variant = checkHttpSupport();
	local lres = checkLoadstringSupport();

	HTTP_REQUESTS_SUPPORTED = cres;
	HTTPGET = variant;

	LOADSTRING_SUPPORTED = lres;

	if (not HTTP_REQUESTS_SUPPORTED) then
		Notify("Your executor does not support HTTP requests.");
	end
	task.wait(3);
	if (not LOADSTRING_SUPPORTED) then
		Notify("Your executor does not support loadstring!");
	end
end)
coroutine.resume(athread)
