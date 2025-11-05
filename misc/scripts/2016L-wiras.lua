-- Infection Virus - Backported and localized to 2016L
-- SultanOfSwing

local Players = game:GetService("Players")
local PatientZero = Players.LocalPlayer -- who to infect

-- Backporting shit
local function fromRGB(r,g,b) return Color3.new(r/255,g/255,b/255) end -- from louknt's fehaxx lol

local function GetDescendants(parent) -- from louknt's backporting utility pack
	local descendants = {}
	local function rec(inst)
		for _, child in ipairs(inst:GetChildren()) do
			table.insert(descendants, child)
			rec(child)
		end
	end
	rec(parent)
	return descendants
end

local function FindFirstAncestorWhichIsA(parent, class) -- louknt's backporting utility pack again lol
	local inst = parent
	while not inst:IsA(class) do
		inst = inst.Parent
		if not inst then return nil end
	end
	return inst
end

local function isColor3(idekbro) -- disgusting fucking hack since no typeof.. 
	local s = pcall(function()
		return idekbro.r, idekbro.g, idekbro.b
	end)
	return s
end

local function isCFrame(idekbro) -- grosss
	local s = pcall(function()
		return idekbro:inverse()
	end)
	return s
end

local TweenInfo = {new=function(n) return n end}
local function TweenCreate(object, time, goalProps) -- my BEAUTIFUL and absurdly lazy tweenservice wrapper
	local startValues = {}
	local deltas = {}
	local cache = {}
	local completed = Instance.new("BindableEvent")

	for prop, goal in pairs(goalProps) do
		local start = object[prop]
		if isColor3(start) and isColor3(goal) then
			cache[prop] = "Color3"
			startValues[prop] = start
			deltas[prop] = Color3.new(
				goal.r - start.r,
				goal.g - start.g,
				goal.b - start.b
			)
		else
			startValues[prop] = start

			if not isCFrame(goal) then
				deltas[prop] = goal - start
			else
				cache[prop] = "CFrame"
				deltas[prop] = goal - start.p
			end
		end
	end

	return {
		Play = function()
			local elapsed = 0
			local connection
			connection = game:GetService("RunService").RenderStepped:connect(function(dt)
				elapsed = elapsed + dt
				local alpha = math.min(elapsed / time, 1) -- THANK GOD this script only uses linear easing..

				for prop, start in pairs(startValues) do
					local delta = deltas[prop]

					if cache[prop] == "Color3" then
						object[prop] = Color3.new(
							start.r + delta.r * alpha,
							start.g + delta.g * alpha,
							start.b + delta.b * alpha
						)
					elseif cache[prop] == "CFrame" then
						object[prop] = start + (delta.p * alpha)
					else
						object[prop] = start + delta * alpha
					end					
				end

				if alpha >= 1 then
					connection:disconnect()
					completed:Fire()
				end
			end)
		end,
		Completed = completed.Event
	}
end

local function fixSizeCFrame(part, cf)
	if not part then return end 

	local c = game:GetService("RunService").RenderStepped:connect(function()
		part.CFrame = cf
	end)

	return c
end

-- Objects
local ketchup = Instance.new("ParticleEmitter")
ketchup.Texture = "http://www.roblox.com/asset/?id=1023974836"
ketchup.Color = ColorSequence.new(fromRGB(85,0,0))
ketchup.Size = NumberSequence.new(1)
ketchup.Lifetime = NumberRange.new(1.5)
ketchup.Rate = 32.97
ketchup.Rotation = NumberRange.new(90)
ketchup.RotSpeed = NumberRange.new(120)
ketchup.Speed = NumberRange.new(7)
ketchup.VelocitySpread = 10 
ketchup.Acceleration = Vector3.new(0, -60, 0)
ketchup.VelocityInheritance = 0.45

-- The scripty shit yo
local timer, randomThing, ragdoll, stankylegg;

local function wiras(char)
	print("hello sar ur compooter has wiras")
	local alpha = math.random(1, 6)
	local info = TweenInfo.new(60, Enum.EasingStyle.Quint, Enum.EasingDirection.In)

	local guy = Instance.new("BrickColorValue", char)
	guy.Name = "Infection"

	local goal = {}
	goal.Color = fromRGB(0, 0, 0)

	local Character, Humanoid, Head;
	local cooldown = false

	Character = GetDescendants(char)

	for i = 1, #Character do
		local c = Character[i]
		if alpha ~= 6 then
			if c:IsA("Part") or c:IsA("MeshPart") then
				local InfTextureTP = Instance.new("Texture")
				InfTextureTP.Texture = "rbxassetid://5079344858"
				InfTextureTP.Face = "Top"
				InfTextureTP.Parent = c
				InfTextureTP.Transparency = 0.7

				local InfTextureBM = Instance.new("Texture")
				InfTextureBM.Texture = "rbxassetid://5079344858"
				InfTextureBM.Face = "Bottom"
				InfTextureBM.Parent = c
				InfTextureBM.Transparency = 0.7

				local InfTextureLT = Instance.new("Texture")
				InfTextureLT.Texture = "rbxassetid://5079344858"
				InfTextureLT.Face = "Left"
				InfTextureLT.Parent = c
				InfTextureLT.Transparency = 0.7

				local InfTextureRT = Instance.new("Texture")
				InfTextureRT.Texture = "rbxassetid://5079344858"
				InfTextureRT.Face = "Right"
				InfTextureRT.Parent = c
				InfTextureRT.Transparency = 0.7

				local InfTextureFT = Instance.new("Texture")
				InfTextureFT.Texture = "rbxassetid://5079344858"
				InfTextureFT.Face = "Front"
				InfTextureFT.Parent = c
				InfTextureFT.Transparency = 0.7

				local InfTextureBK = Instance.new("Texture")
				InfTextureBK.Texture = "rbxassetid://5079344858"
				InfTextureBK.Face = "Back"
				InfTextureBK.Parent = c
				InfTextureBK.Transparency = 0.7

				local smoke = Instance.new("Smoke")
				smoke.Color = fromRGB(255, 255, 255)
				smoke.Size = 0.1
				smoke.Opacity = 0.02
				smoke.Parent = c

				c.Color = fromRGB(255, 255, 255)
				c.Material = Enum.Material.Ice -- ice as a fallback
				pcall(function() c.Material = Enum.Material.Glass end) -- glass was added in 2017L..
				if c.Name == "Head" then
					Head = c
				end

				local tween = TweenCreate(c, info, goal)
				tween:Play()
			elseif c:IsA("Accessory") or c:IsA("Shirt") or c:IsA("Pants") then
				c:Destroy()
			elseif c:IsA("Humanoid") then
				c.WalkSpeed = math.random(10, 32)
				c.MaxHealth = math.random(1, 60)
				Humanoid = c
			end
		elseif alpha == 6 then
			if c:IsA("Part") or c:IsA("MeshPart") then
				local InfTextureTP = Instance.new("Texture")
				InfTextureTP.Texture = "rbxassetid://8054571044"
				InfTextureTP.Face = "Top"
				InfTextureTP.Parent = c
				InfTextureTP.Transparency = 0.8

				local InfTextureBM = Instance.new("Texture")
				InfTextureBM.Texture = "rbxassetid://8054571044"
				InfTextureBM.Face = "Bottom"
				InfTextureBM.Parent = c
				InfTextureBM.Transparency = 0.8

				local InfTextureLT = Instance.new("Texture")
				InfTextureLT.Texture = "rbxassetid://8054571044"
				InfTextureLT.Face = "Left"
				InfTextureLT.Parent = c
				InfTextureLT.Transparency = 0.8

				local InfTextureRT = Instance.new("Texture")
				InfTextureRT.Texture = "rbxassetid://8054571044"
				InfTextureRT.Face = "Right"
				InfTextureRT.Parent = c
				InfTextureRT.Transparency = 0.8

				local InfTextureFT = Instance.new("Texture")
				InfTextureFT.Texture = "rbxassetid://8054571044"
				InfTextureFT.Face = "Front"
				InfTextureFT.Parent = c
				InfTextureFT.Transparency = 0.8

				local InfTextureBK = Instance.new("Texture")
				InfTextureBK.Texture = "rbxassetid://8054571044"
				InfTextureBK.Face = "Back"
				InfTextureBK.Parent = c
				InfTextureBK.Transparency = 0.8

				local smoke = Instance.new("Smoke")
				smoke.Color = fromRGB(144, 110, 255)
				smoke.Size = 0.1
				smoke.Opacity = 0.02
				smoke.Parent = c

				c.Color = fromRGB(226, 234, 255)
				c.Material = Enum.Material.Foil
				if c.Name == "Head" then
					Head = c
				end

				local tween = TweenCreate(c, info, goal)
				tween:Play()
			elseif c:IsA("Accessory") or c:IsA("Shirt") or c:IsA("Pants") then
				c:Destroy()
			elseif c:IsA("Humanoid") then
				c.WalkSpeed = math.random(32, 46)
				c.MaxHealth = math.random(60, 300)
				Humanoid = c
			end
		end
	end

	wait(1)
	Head.Touched:connect(function(part)
		if not cooldown then
			cooldown = true
			local children

			local Model = FindFirstAncestorWhichIsA(part, "Model")
			if Model then
				children = Model:GetChildren()
			end

			local isHuman = false
			local infected = false

			for i = 1, #children do
				local c = children[i]
				if c:IsA("Humanoid") then
					isHuman = true
				elseif c:IsA("BrickColorValue") then
					if c.Name == "Infection" then
						infected = true
					end
				end
			end

			if isHuman and not infected then
				local info = TweenInfo.new(2, "Cubic", Enum.EasingDirection.Out)

				local goal = {}
				goal.Color = fromRGB(76, 148, 255)
				goal.Size = Vector3.new(14, 14, 14)
				goal.Transparency = 1

				coroutine.wrap(function() wiras(FindFirstAncestorWhichIsA(part, "Model")) end)()

				local effect = Instance.new("Part")
				effect.Shape = Enum.PartType.Ball
				effect.Color = fromRGB(255, 255, 255)
				effect.Material = Enum.Material.Ice
				effect.Size = Vector3.new(1, 1, 1)
				effect.Anchored = true
				effect.CanCollide = false
				effect.Parent = workspace

				effect.CFrame = part.CFrame

				local c = fixSizeCFrame(effect, part.CFrame)
				local tween = TweenCreate(effect, info, goal)
				tween:Play()
				tween.Completed:connect(function()
					effect:Destroy()
					c:disconnect()
				end)
			end

			wait(0.2)
			cooldown = false
		end
	end)

	coroutine.wrap(function() timer(char) end)()
	coroutine.wrap(function() randomThing(char) end)()
end

local function aura(effect)	
	local cooldown = false
	effect.Touched:connect(function(part)		
		if not cooldown then
			local children

			local Model = FindFirstAncestorWhichIsA(part,"Model")
			if Model then
				children = Model:GetChildren()
			else
				return -- return if not a model come on dude youre better than this original mr script creator
			end

			local isHuman = false
			local infected = false

			for i = 1, #children do
				local c = children[i]
				if c:IsA("Humanoid") then
					isHuman = true
				elseif c:IsA("BrickColorValue") then
					if c.Name == "Infection" then
						infected = true
					end
				end
			end

			if isHuman and not infected then
				local info = TweenInfo.new(2, "Cubic", Enum.EasingDirection.Out)

				local goal = {}
				goal.Color = fromRGB(76, 148, 255)
				goal.Size = Vector3.new(14, 14, 14)
				goal.Transparency = 1

				coroutine.wrap(function() wiras(FindFirstAncestorWhichIsA(part, "Model")) end)()

				local effect = Instance.new("Part")
				effect.Shape = Enum.PartType.Ball
				effect.Color = fromRGB(255, 255, 255)
				effect.Material = Enum.Material.Ice
				effect.Size = Vector3.new(1, 1, 1)
				effect.Anchored = true
				effect.CanCollide = false
				effect.Parent = workspace

				effect.CFrame = part.CFrame

				local c = fixSizeCFrame(effect, part.CFrame)
				local tween = TweenCreate(effect, info, goal)
				tween:Play()				
				tween.Completed:connect(function()
					effect:Destroy()
					c:disconnect()
				end)
			end

			wait(0.2)
			cooldown = false
		end
	end)
end

function randomThing(char)
	local head = char:FindFirstChild("Head")
	local cooldown = false

	local function cough()
		local cough = Instance.new("Sound")
		cough.SoundId = "rbxassetid://3047432613"

		cough.Name = "cough"
		cough.Parent = head
		cough:Play()

		local info = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

		local goal = {}
		goal.Color = fromRGB(176, 255, 142)
		goal.Size = Vector3.new(28, 28, 28)
		goal.Transparency = 1

		local effect = Instance.new("Part")
		effect.Shape = Enum.PartType.Ball
		effect.Color = fromRGB(255, 255, 255)
		effect.Material = Enum.Material.Ice
		effect.Size = Vector3.new(1, 1, 1)
		effect.Anchored = true
		effect.CanCollide = false
		effect.Parent = head
		effect.Name = "coughaura"

		effect.CFrame = head.CFrame

		local c = fixSizeCFrame(effect, head.CFrame)
		local tween = TweenCreate(effect, info, goal)
		tween:Play()
		coroutine.wrap(function() aura(effect) end)()

		tween.Completed:connect(function()
			effect:Destroy()
			c:disconnect()
		end)
		wait(2)
		effect:Destroy()
	end

	while true do
		wait(math.random(5, 10))
		if not char or not char:FindFirstChild("Humanoid") or char.Humanoid.Health <= 0 then break end
		cough()
	end
end


function timer(yo)

	local Model = FindFirstAncestorWhichIsA(yo, "Model")
	local Character = nil

	if Model then
		Character = GetDescendants(Model)
	end

	local Humanoid = nil

	for i = 1, #Character do
		local c = Character[i]

		if c:IsA("Humanoid") then
			Humanoid = c
		end
	end

	wait(50)
	coroutine.wrap(function() randomThing(Model) end)()

	local cough = Instance.new("Sound")
	cough.SoundId = "rbxassetid://6699572981"
	cough.Parent = Model:FindFirstChild("Head")
	cough:Play()

	local kc = ketchup:Clone()
	kc.Enabled = true
	kc.Parent = Model:FindFirstChild("Head")

	coroutine.wrap(function() ragdoll(Model) end)()

	Humanoid.PlatformStand = true
	wait()

	local stankyHandler = stankylegg(Model)

	wait()
	local doneDid = false
	local finale = function()
		if doneDid then return end; doneDid = true
		stankyHandler:STOPITRIGHTNOWBITCH()
		local info = TweenInfo.new(2, "Cubic", Enum.EasingDirection.Out)

		local goal = {}
		goal.Color = fromRGB(255, 0, 0)
		goal.Size = Vector3.new(24, 24, 24)
		goal.Transparency = 1

		local effect = Instance.new("Part")
		effect.Shape = Enum.PartType.Ball
		effect.Color = fromRGB(85, 0, 0)
		
		effect.Material = Enum.Material.Ice -- ice as a backup as per usual
		pcall(function() effect.Material = Enum.Material.ForceField end) -- forcefield was added in 2019E
		effect.Size = Vector3.new(1, 1, 1)
		effect.Anchored = true
		effect.CanCollide = false
		effect.Parent = workspace

		effect.CFrame = Model.Head.CFrame

		local c= fixSizeCFrame(effect, Model.Head.CFrame)
		local tween = TweenCreate(effect, info, goal)
		tween:Play()

		tween.Completed:connect(function()
			effect:Destroy()
			c:disconnect()
		end)

		Humanoid.Health = 0
		kc:Destroy()

		for _, Part in pairs(Character) do
			if Part:IsA("Part") or Part:IsA("MeshPart") then
				local info = TweenInfo.new(4, "Cubic", Enum.EasingDirection.Out)

				local goal = {}
				goal.Color = fromRGB(109, 0, 1)
				goal.Transparency = 1

				local tween = TweenCreate(Part, info, goal)
				tween:Play()
			elseif Part:IsA("Texture") then
				Part:Destroy()
			end
		end
	end
	cough.Ended:connect(finale)
	wait(20) -- if sound doesnt play, wait songlen+7 (allow up to 7 secs of preloading time) then call finale directly
	if not doneDid then finale() end
end

-- so the old ragdoll script doesnt work with old physics, i think only PGS. so, this is another ragdoll script to compromise..
-- i stole this entire block from sealiosurvival lol
function makegloo(paren, co, ci, parto, parti, nam)
	local gloo = Instance.new("Glue")
	gloo.Name = nam
	gloo.C0 = co
	gloo.C1 = ci
	gloo.Part0 = parto
	gloo.Part1 = parti
	gloo.Parent = paren
end

function maketouchy(parent, limb, cframe)
	local pr = Instance.new("Part")
	pr.Name = "touchy"
	pr.Size = Vector3.new(1, 1, 1)
	pr.Transparency = 1
	pr.CustomPhysicalProperties = PhysicalProperties.new(0.55, 0.3, 0.5)
	pr.CanCollide = true
	pr.Anchored = false
	pr.Parent = parent
	local w = Instance.new("Weld")
	w.Part0 = pr
	w.Part1 = limb
	w.C0 = cframe
	w.Parent = pr
end

function ragdoll(chr)
	local h;
	for i,v in ipairs (chr:GetChildren()) do
		if v:IsA('Humanoid') then h = v end 
	end	

	local RightShoulderC0 = CFrame.new(1.5, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
	local RightShoulderC1 = CFrame.new(0, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
	local LeftShoulderC0 = CFrame.new(-1.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
	local LeftShoulderC1 = CFrame.new(0, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
	local RightHipC0 = CFrame.new(0.5, -1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
	local RightHipC1 = CFrame.new(0, 1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
	local LeftHipC0 = CFrame.new(-0.5, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
	local LeftHipC1 = CFrame.new(0, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
	local RootJointC0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)
	local RootJointC1 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)
	local NeckC0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)
	local NeckC1 = CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)

	local tors = chr:FindFirstChild("Torso") 
	local rarm = chr:FindFirstChild("Right Arm")
	local larm = chr:FindFirstChild("Left Arm")
	local rleg = chr:FindFirstChild("Right Leg")
	local lleg = chr:FindFirstChild("Left Leg")

	local human = h
	human.PlatformStand = true

	for i,v in ipairs (h.Parent:GetChildren()) do
		if v:IsA("BasePart") then v.Anchored = false end
	end

	if rarm then
		tors:FindFirstChild("Right Shoulder"):Destroy()
		makegloo(tors, RightShoulderC0, RightShoulderC1, tors, rarm, "Right Shoulder")
		maketouchy(rarm, rarm, CFrame.new(0, 0.5, 0))
	end

	if larm then
		tors:FindFirstChild("Left Shoulder"):Destroy()
		makegloo(tors, LeftShoulderC0, LeftShoulderC1, tors, larm, "Left Shoulder")
		maketouchy(larm, larm, CFrame.new(0, 0.5, 0))
	end 

	if rleg then
		tors:FindFirstChild("Right Hip"):Destroy()
		makegloo(tors, RightHipC0, RightHipC1, tors, rleg, "Right Hip")
		maketouchy(rleg, rleg, CFrame.new(0, 0.5, 0))
	end 

	if lleg then
		tors:FindFirstChild("Left Hip"):Destroy()
		makegloo(tors, LeftHipC0, LeftHipC1, tors, lleg, "Left Hip")
		maketouchy(lleg, lleg, CFrame.new(0, 0.5, 0))
	end 
end
-- end of sealio stealing

function stankylegg(Model)
	local DebrisService = game:GetService("Debris")

	local Head = Model:FindFirstChild("Head")
	local Character = nil

	if Model then
		Character = GetDescendants(Model)
	end

	local torso = nil
	local HumanoidRoot = nil

	for i = 1, #Character do
		local c = Character[i]
		if c:IsA("Part") or c:IsA("MeshPart") then
			--c.CustomPhysicalProperties = PhysicalProperties.new(0.05,0,0,0,0)
			if c.Name == "Torso" or c.Name == "UpperTorso" then
				torso = c
			elseif c.Name == "HumanoidRootPart" then
				HumanoidRoot = c
			end
		end
	end
	
	local endTheShitBitch = false
	coroutine.wrap(function()
		while wait(.02) do
			if endTheShitBitch then return end
			
			local raindropTheExecutorLmaoo = Instance.new("Part")
			raindropTheExecutorLmaoo.Shape = Enum.PartType.Ball
			raindropTheExecutorLmaoo.Size = Vector3.new(0.3, 0.3, 0.3)
			raindropTheExecutorLmaoo.Color = fromRGB(85, 0, 0)

			raindropTheExecutorLmaoo.Material = Enum.Material.Ice -- ice as a fallback
			pcall(function() raindropTheExecutorLmaoo.Material = Enum.Material.Glass end) -- glass was added in 2017L
			raindropTheExecutorLmaoo.Parent = Head
			raindropTheExecutorLmaoo.CFrame = CFrame.new(Head.Position.X, Head.Position.Y, Head.Position.Z) * CFrame.Angles(0, 0, 0)
			DebrisService:AddItem(raindropTheExecutorLmaoo, 3)

			local Rotation = Instance.new("BodyAngularVelocity")
			Rotation.AngularVelocity = Vector3.new(math.random(-7, 7), math.random(-7, 7), math.random(-7, 7))
			Rotation.P = 1000
			Rotation.MaxTorque = Vector3.new(69420, 69420, 69420)
			Rotation.Parent = HumanoidRoot
			wait(0.1)
			Rotation:Destroy()
		end
	end)()

	return {
		STOPITRIGHTNOWBITCH = function()
			endTheShitBitch = true
		end,
	}
end

wiras(PatientZero.Character)