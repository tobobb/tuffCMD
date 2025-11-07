--[[
	Bark Gun V1
		Made by: tobob
		Original Grab Gun made by: vlad20020
	
	Credits:
		tobob: doing most of the work frfr
		sultanofswing: helping me with roblox's weird 2016 welds and the gun model
]]


local plr = game.Players.LocalPlayer
local plrg = plr.PlayerGui
local char = plr.Character
script.Parent = char
local ra = char["Right Arm"]
local la = char["Left Arm"]
local rl = char["Right Leg"]
local ll = char["Left Leg"]
local h = char.Head
local t = char.Torso
local anim = "idle"
local mode = "shoot"
local killmode = "kill"
local rad = math.rad
local mouse = plr:GetMouse()

function info(text,timebeforefade)
	coroutine.resume(coroutine.create(function()
		local pos = {.001,.002,.003,.004,.005}
		local mpos = {-.001,-.002,-.003,-.004,-.005}
		local sc = Instance.new("ScreenGui",plrg)
		local tex = Instance.new("TextLabel",sc) tex.Rotation = math.random(-5,5) tex.Position = UDim2.new(.5,0,.05,0) tex.Size = UDim2.new(0,0,.15,0) tex.TextScaled = true tex.BackgroundTransparency = 1 tex.TextTransparency = 1 tex.BackgroundColor3 = Color3.fromRGB(40,40,40) tex.BorderSizePixel = 0 tex.TextColor3 = Color3.fromRGB(255,255,255) tex.Text = text
		for i = 1,20 do
			tex.Size = tex.Size + UDim2.new(.025,0,0,0)
			tex.Rotation = math.random(-5,5)
			tex.TextColor3 = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
			tex.Position = tex.Position - UDim2.new(.0125,0,0,0)
			tex.Position = tex.Position +- UDim2.new(0,math.random(-10,10),0,math.random(-10,10))
			tex.BackgroundColor3 = Color3.fromRGB(math.random(0,60),math.random(0,60),math.random(0,60))
			tex.BackgroundTransparency = tex.BackgroundTransparency -.05
			swait()
		end
		for i = 1,10 do
			tex.Rotation = math.random(-5,5)
			tex.TextColor3 = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
			tex.Position = tex.Position +- UDim2.new(0,math.random(-10,10),0,math.random(-10,10))
			tex.BackgroundColor3 = Color3.fromRGB(math.random(0,60),math.random(0,60),math.random(0,60))
			tex.TextTransparency = tex.TextTransparency -.1
			swait()
		end
		tex.BackgroundColor3 = Color3.fromRGB(40,40,40)
		tex.TextColor3 = Color3.fromRGB(255,255,255)
		wait(timebeforefade)
		for i = 1,10 do
			tex.Rotation = math.random(-5,5)
			tex.TextColor3 = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
			tex.Position = tex.Position +- UDim2.new(0,math.random(-10,10),0,math.random(-10,10))
			tex.BackgroundColor3 = Color3.fromRGB(math.random(0,60),math.random(0,60),math.random(0,60))
			tex.TextTransparency = tex.TextTransparency +.1
			swait()
		end
		for i = 1,20 do
			tex.Size = tex.Size - UDim2.new(.025,0,0,0)
			tex.Rotation = math.random(-5,5)
			tex.TextColor3 = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
			tex.Position = tex.Position +- UDim2.new(0,math.random(-10,10),0,math.random(-10,10))
			tex.BackgroundColor3 = Color3.fromRGB(math.random(0,30),math.random(0,60),math.random(0,60))
			tex.Position = tex.Position + UDim2.new(.0125,0,0,0)
			tex.BackgroundTransparency = tex.BackgroundTransparency +.05
			swait()
		end
		tex:Destroy()
	end))
end

print("Made by vlad20020, Ported by tobob.")

coroutine.resume(coroutine.create(function()
	wait(2)
	info("Original Grab Gun made by vlag20020",1)
	wait(2)
	info("Grab Gun backported by tobob",1)
	wait(2)
	info("bark gun",1)
	wait(2)
	info("Press Z to equip the gun.",1)
	wait(2)
	info("Press X to unequip the gun.",1)
	wait(2)
	info("Press M for control list",1)
end))

ArtificialHB = Instance.new("BindableEvent", script)
ArtificialHB.Name = "Heartbeat"

script:WaitForChild("Heartbeat")

frame = 1 / 60
tf = 0
allowframeloss = false
tossremainder = false
lastframe = tick()
script.Heartbeat:Fire()

game:GetService("RunService").Heartbeat:connect(function(s, p)
	tf = tf + s
	if tf >= frame then
		if allowframeloss then
			script.Heartbeat:Fire()
			lastframe = tick()
		else
			for i = 1, math.floor(tf / frame) do
				script.Heartbeat:Fire()
			end
			lastframe = tick()
		end
		if tossremainder then
			tf = 0
		else
			tf = tf - frame * math.floor(tf / frame)
		end
	end
end)

function swait(num)
	if num == 0 or num == nil then
		ArtificialHB.Event:wait()
	else
		for i = 0, num do
			ArtificialHB.Event:wait()
		end
	end
end

local rs = t["Right Shoulder"]
local ls = t["Left Shoulder"]
local rh = t["Right Hip"]
local lh = t["Left Hip"]
local nec = t.Neck
local rut = char.HumanoidRootPart
local rutj = rut.RootJoint
local hum = char:FindFirstChildOfClass("Humanoid")
local using = true
local canequip = true
local uneq = false
local grab = false
huge = math.huge
local ammo = 7
char.Animate.idle.Animation2:Destroy()

--arm joint parts_
local tpr = Instance.new("Part",t) tpr.Size = Vector3.new(.1,.1,.1) tpr.CanCollide = false tpr.Transparency = 1
local tpl = Instance.new("Part",t) tpl.Size = Vector3.new(.1,.1,.1) tpl.CanCollide = false tpl.Transparency = 1
local tprw = Instance.new("Weld",t) tprw.Part0 = t tprw.Part1 = tpr tprw.C0 = CFrame.new(1,.5,0)
local tplw = Instance.new("Weld",t) tplw.Part0 = t tplw.Part1 = tpl tplw.C0 = CFrame.new(-1,.5,0)
--
local rapr = Instance.new("Part",ra) rapr.Size = Vector3.new(.1,.1,.1) rapr.CanCollide = false rapr.Transparency = 1 --Right Arm
local lapl = Instance.new("Part",la) lapl.Size = Vector3.new(.1,.1,.1) lapl.CanCollide = false lapl.Transparency = 1 --Left Arm
local raprw = Instance.new("Weld",ra) raprw.Part0 = ra raprw.Part1 = rapr raprw.C0 = CFrame.new(-.5,.5,0)
local laplw = Instance.new("Weld",la) laplw.Part0 = la laplw.Part1 = lapl laplw.C0 = CFrame.new(.5,.5,0)
--joint welds
local rsw = Instance.new("Weld",ra) rsw.Part0 = tpr rsw.Part1 = nil --Right Shoulder
local lsw = Instance.new("Weld",la) lsw.Part0 = tpl lsw.Part1 = nil --Left Shoulder
--gun model--
local function creategun()
	--// shitty barkgun v1 gun model that does NOT need fixing anymore
	-- LM->S converter v0.23
	local t,f=true,false
	local v3,c3,bc,v2,ud,ud2,cf = Vector3.new,Color3.new,BrickColor.new,Vector2.new,UDim.new,UDim2.new,CFrame.new
	local function new(class,par,props) local inst=Instance.new(class,par) if not props then return inst end --[[disgusting hack to fix roblox's collision solving bullshit on .Size, computing cframe as the last property is a hacky way to 'prevent' this.]] local hasCF = props.CFrame for p,v in pairs(props) do inst[p]=v end if hasCF then inst.CFrame = hasCF end return inst end
	Model0=new("Model",nil,{Name="gun"})
	local handle = new("Part",Model0,{Name="Handle",BottomSurface=0,BrickColor=bc(26),CFrame=cf(264.70648193359375,-0.030786514282226562,-336.4213562011719,0.8039448261260986,-0.005051419138908386,-0.5946823954582214,0.0008859040681272745,0.9999731183052063,-0.00729640107601881,0.5947033166885376,0.005339093506336212,0.803927481174469),CanCollide=f,Material=1088,Rotation=v3(0.5199999809265137,-36.4900016784668,0.36000001430511475),Size=v3(0.2715872526168823,1.357937216758728,0.27158743143081665),TopSurface=0,Transparency=1})
	Part1 = new("Part",Model0,{BottomSurface=0,BrickColor=bc(26),CFrame=cf(264.43072509765625,0.06536674499511719,-336.6543273925781,0.8038418889045715,-0.0049104648642241955,-0.5948226451873779,0.0008139302954077721,0.9999743103981018,-0.007155165076255798,0.5948424935340881,0.005267499480396509,0.803824782371521),CanCollide=f,Material=1088,Rotation=v3(0.5099999904632568,-36.5,0.3499999940395355),Size=v3(0.33948463201522827,0.10863497853279114,0.09505560249090195),TopSurface=0})
	Part2 = new("Part",Model0,{BottomSurface=0,BrickColor=bc(26),CFrame=cf(264.2452697753906,0.20988845825195312,-336.77667236328125,0.004910421557724476,0.8038417100906372,-0.5948227047920227,-0.9999741315841675,0.0008138761622831225,-0.007155171129852533,-0.005267546512186527,0.5948424339294434,0.8038248419761658),CanCollide=f,Material=1088,Rotation=v3(0.5099999904632568,-36.5,-89.6500015258789),Size=v3(0.39380210638046265,0.10863497853279114,0.09505560249090195),TopSurface=0})
	Part3 = new("Part",Model0,{BottomSurface=0,BrickColor=bc(26),CFrame=cf(264.37109375,0.40378761291503906,-336.67724609375,0.8040485978126526,-0.005052052903920412,-0.5945421457290649,0.0008871727623045444,0.9999729990959167,-0.007297356612980366,0.5945629477500916,0.005339968018233776,0.8040313124656677),CanCollide=f,Material=1088,Rotation=v3(0.5199999809265137,-36.47999954223633,0.36000001430511475),Size=v3(1.6974211931228638,0.2036905288696289,0.27158746123313904),TopSurface=0})
	Part5 = new("Part",Model0,{BottomSurface=0,BrickColor=bc(311),CFrame=cf(264.69647216796875,-0.13422775268554688,-336.441162109375,0.7908791899681091,-0.1444402039051056,-0.5946823358535767,0.17434410750865936,0.9846579432487488,-0.007296400610357523,0.5866126418113708,-0.09790879487991333,0.8039274215698242),CanCollide=f,Material=800,Rotation=v3(0.5199999809265137,-36.4900016784668,10.350000381469727),Size=v3(0.4073810577392578,0.6789685487747192,0.27158746123313904),TopSurface=0})
	Part8 = new("Part",Model0,{BottomSurface=0,BrickColor=bc(26),CFrame=cf(263.59210205078125,0.5560798645019531,-337.2470703125,0.8039448261260986,-0.005051400978118181,-0.5946824550628662,0.0008858996443450451,0.9999729990959167,-0.007296415511518717,0.5947032570838928,0.0053390865214169025,0.8039275407791138),CanCollide=f,Material=272,Rotation=v3(0.5199999809265137,-36.4900016784668,0.36000001430511475),Size=v3(0.06789686530828476,0.20369037985801697,0.1765316277742386),TopSurface=0,Shape=2})
	Part12 = new("Part",Model0,{BottomSurface=0,BrickColor=bc(26),CFrame=cf(264.77044677734375,-0.5681039094924927,-336.4061279296875,0.7908022403717041,-0.14428356289863586,-0.5948227047920227,0.17427343130111694,0.9846716523170471,-0.007155172992497683,0.586737334728241,-0.09800346940755844,0.8038247227668762),CanCollide=f,Material=1088,Rotation=v3(0.5099999904632568,-36.5,10.34000015258789),Size=v3(0.4073810577392578,0.2036905437707901,0.27158746123313904),TopSurface=0})
	Part13 = new("Part",Model0,{BottomSurface=0,BrickColor=bc(1003),CFrame=cf(263.5852355957031,0.5560741424560547,-337.24981689453125,0.8039448261260986,-0.005051400978118181,-0.5946824550628662,0.0008858996443450451,0.9999729990959167,-0.007296415511518717,0.5947032570838928,0.0053390865214169025,0.8039275407791138),CanCollide=f,Material=272,Rotation=v3(0.5199999809265137,-36.4900016784668,0.36000001430511475),Size=v3(0.06789686530828476,0.20369037985801697,0.1357935070991516),TopSurface=0,Shape=2})
	Part15 = new("Part",Model0,{BottomSurface=0,BrickColor=bc(26),CFrame=cf(264.28643798828125,0.5732536315917969,-336.7355041503906,0.8040485978126526,-0.005052052903920412,-0.5945421457290649,0.0008871727623045444,0.9999729990959167,-0.007297356612980366,0.5945629477500916,0.005339968018233776,0.8040313124656677),CanCollide=f,Material=1088,Rotation=v3(0.5199999809265137,-36.47999954223633,0.36000001430511475),Size=v3(1.7653180360794067,0.27158740162849426,0.27158746123313904),TopSurface=0})
	Part16 = new("Part",Model0,{BottomSurface=0,BrickColor=bc(26),CFrame=cf(263.63525390625,0.4028434753417969,-337.2252197265625,0.8039448261260986,-0.005051400978118181,-0.5946824550628662,0.0008858996443450451,0.9999729990959167,-0.007296415511518717,0.5947032570838928,0.0053390865214169025,0.8039275407791138),CanCollide=f,Material=1088,Rotation=v3(0.5199999809265137,-36.4900016784668,0.36000001430511475),Size=v3(0.13579343259334564,0.06789686530828476,0.27158746123313904),TopSurface=0})
	Part19 = new("Part",Model0,{BottomSurface=0,BrickColor=bc(26),CFrame=cf(264.7296447753906,-0.6409683227539062,-336.44366455078125,0.8038419485092163,-0.004910508636385202,-0.5948227047920227,0.0008138722623698413,0.9999746680259705,-0.007155169732868671,0.5948424339294434,0.005267457105219364,0.8038244843482971),CanCollide=f,Material=1088,Rotation=v3(0.5099999904632568,-36.5,0.3499999940395355),Size=v3(0.5431748032569885,0.13579368591308594,0.27158746123313904),TopSurface=0})
	Part20 = new("Part",Model0,{BottomSurface=0,BrickColor=bc(26),CFrame=cf(264.6278076171875,0.2997417449951172,-336.48193359375,0.7909812331199646,-0.1444588303565979,-0.5945421457290649,0.17434534430503845,0.9846575856208801,-0.007297356612980366,0.586474597454071,-0.09788356721401215,0.8040313124656677),CanCollide=f,Material=1088,Rotation=v3(0.5199999809265137,-36.47999954223633,10.350000381469727),Size=v3(0.4073810577392578,0.2036905288696289,0.27158746123313904),TopSurface=0})

	for _,v in ipairs(handle.Parent:children()) do
		if v:IsA("BasePart") and v~=handle then
			local w = Instance.new("Weld", handle)
			w.C0 = handle.CFrame:inverse()
			w.C1 = v.CFrame:inverse()
			w.Part0 = handle
			w.Part1 = v
		end
	end

	Model0.Parent = char
end
creategun()
--gun model end--
local shot = Instance.new("Part",Model0) shot.Size = Vector3.new(.2,.2,.2) shot.Transparency = 1 shot.Anchored = true shot.CanCollide = false shot.CFrame = ra.CFrame * CFrame.new(0,-2,0)
coroutine.resume(coroutine.create(function()
	while true do
		shot.CFrame = ra.CFrame * CFrame.new(0,-2.6,-.4) * CFrame.Angles(rad(-90),rad(0),rad(0))
		swait()
	end
end))
local gunweld = Instance.new("Weld",ra) gunweld.Part0 = t gunweld.Part1 = Part1 gunweld.C0 = CFrame.new(1.1,-.7,0) * CFrame.Angles(rad(-120),rad(-90),rad(0))
function turnto(position)
	rut.CFrame = CFrame.new(rut.CFrame.p, Vector3.new(position.X, rut.Position.Y, position.Z)) * CFrame.new(0, 0, 0)
end
function fireto(position)
	shot.CFrame = CFrame.new(shot.CFrame.p, Vector3.new(position.X, position.Y, position.Z)) * CFrame.new(0, 0, 0)
end

function sound(parent,id,vol,pit)
	local sound = Instance.new("Sound",parent)
	sound.Volume = vol
	sound.SoundId = "rbxassetid://"..id
	sound.Pitch = pit
	sound:Play()
	coroutine.resume(coroutine.create(function()

		repeat
			swait()
		until sound.Playing == false
		sound:Destroy()
	end))
end
function blood(POSITION)
	local blub = Instance.new("Part",workspace)
	blub.Material = "SmoothPlastic"
	blub.BrickColor = BrickColor.new("Maroon")
	blub.Size = Vector3.new(.3,.3,.3)
	blub.Shape = "Ball"
	blub.CFrame = POSITION.CFrame * CFrame.new(math.random(-1,1),math.random(-1,1),math.random(-1,1)) blub.Transparency = 0
	blub.CanCollide = true blub.Anchored = false blub.Name = "Blood"
	coroutine.resume(coroutine.create(function(PART)
		wait(.5)
		blub.CanCollide = false blub.Anchored = true
		blub.Shape = "Cylinder"
		for i = 0,10 do
			blub.Orientation = Vector3.new(0,0,90)
			blub.Size = blub.Size + Vector3.new(0,.05,.05)
			blub.Size = blub.Size - Vector3.new(.035,0,0)
			wait(.1)
		end
		for i = 0,10 do

			blub.Orientation = Vector3.new(0,0,90)
			blub.Size = blub.Size + Vector3.new(0,.05,.05)
			blub.Size = blub.Size - Vector3.new(.035,0,0)
			wait(.1)
		end
		coroutine.resume(coroutine.create(function()
			for i = 0,1,.01 do
				blub.Color = blub.Color:lerp(Color3.fromRGB(40,0,0),i)
				swait()
			end
		end))
		for i = 0,10 do
			blub.Size = blub.Size + Vector3.new(0,.025,.025)
			blub.Size = blub.Size - Vector3.new(.035,0,0)
			blub.Transparency = blub.Transparency + .1
			wait(.1)
		end
		if blub.Transparency >= .99 then
			blub:Destroy()
		end
	end))
end
function nubblud(pos)
	local sizes = {.1,.2,.3,.4,.5,.6}
	local poses = {.1,.2,.3,.4,.5}
	local mposes = {-.1,-.2,-.3,-.4,-.5}
	coroutine.resume(coroutine.create(function()
		local blod = Instance.new("Part",workspace) blod.Size = Vector3.new(sizes[math.random(1,6)],sizes[math.random(1,6)],sizes[math.random(1,6)]) blod.BrickColor = BrickColor.new("Maroon") blod.Material = "SmoothPlastic" 
		blod.CFrame = pos.CFrame * CFrame.new(math.random(mposes[math.random(1,5)],poses[math.random(1,5)]),math.random(mposes[math.random(1,5)],poses[math.random(1,5)]),math.random(mposes[math.random(1,5)],poses[math.random(1,5)]))
		wait(5)
		blod:Destroy()
	end))
end
function bullet()
	local bulet = Instance.new("Part",workspace)
	bulet.Size = Vector3.new(.15,.15,2)
	bulet.BrickColor = BrickColor.new("Daisy orange")
	bulet.Material = "Neon" bulet.CanCollide = false
	bulet.CFrame = shot.CFrame * CFrame.new(0,0,-2.2) bulet.Name = "Bullet"
	local mes = Instance.new("SpecialMesh",bulet) mes.MeshType = "Sphere"
	local direc = Instance.new("BodyGyro",bulet) direc.MaxTorque = Vector3.new(huge,huge,huge) direc.CFrame = CFrame.new(bulet.Position,mouse.Hit.p)
	local vel = Instance.new("BodyVelocity",bulet) vel.MaxForce = Vector3.new(huge,huge,huge) vel.Velocity = direc.CFrame.lookVector * 400
	local a = false
	local function ow(hit)
		if hit ~= nil then
			local nub = hit.Parent:FindFirstChildOfClass("Humanoid")
			if nub ~= nil then
				if hit.Parent == char then

				else
					a = true
					nub.MaxHealth = 100
					nub.Health = nub.Health -0
					nub:TakeDamage(math.random(11,23))
					nub.WalkSpeed = nub.WalkSpeed -1.2
					nub.JumpPower = nub.JumpPower -10
					if hit.Name == "Head" or hit.Name == "Handle" then
						function expl(pos)
							local p = Instance.new("Part",workspace)
							p.Size = Vector3.new(.1,.1,.1) p.BrickColor = BrickColor.new("Maroon")
							p.Material = "Neon" p.Shape = "Ball" p.CanCollide = false p.Anchored = true
							p.CFrame = pos.CFrame
							coroutine.resume(coroutine.create(function()
								for i = 0,2,.1 do
									p.Size = p.Size:lerp(Vector3.new(4,4,4),i)
									p.Transparency = p.Transparency +.07
									swait()
									if p.Transparency >.99 then
										p:Destroy()
									end
								end
							end))
						end
						nub.Parent:BreakJoints()
						hit.Parent.Head:Destroy()
						bulet:Destroy()
						sound(char,"131313234",2,1) 
						expl(hit)
						local bum = Instance.new("Explosion",workspace) bum.Visible = false bum.BlastPressure = 20000 bum.BlastRadius = .5 bum.Position = hit.Position
						for i = 1,math.random(2,7) do
							blood(hit)
							nubblud(hit)
						end
					end
				end
			end
			bulet:Destroy()
		end
	end
	bulet.Touched:connect(ow)
	coroutine.resume(coroutine.create(function()
		wait(2)
		bulet:Destroy()
	end))
end

function mag()
	local mag = Instance.new("Part",workspace) mag.Size = Vector3.new(.35,1,.2) mag.BrickColor = BrickColor.new("Black") mag.Material = "Metal" mag.CFrame = Part1.CFrame * CFrame.new(0,-1,0)
	coroutine.resume(coroutine.create(function()
		wait(3)
		mag:Destroy()
	end))
end

function effect()
	local ef = Instance.new("Part",Model0) ef.Material = "Neon" ef.Name = "Effect" ef.Size = Vector3.new(.4,.4,.4) ef.Anchored = true ef.CanCollide = false ef.BrickColor = BrickColor.new("Daisy orange") ef.Transparency = 0 ef.CFrame = Part15.CFrame
	coroutine.resume(coroutine.create(function()
		for i = 1,10 do
			ef.Size = ef.Size +Vector3.new(.05,.05,.05)
			ef.Transparency = ef.Transparency +.1
			ef.CFrame = ef.CFrame * CFrame.Angles(rad(math.random(-180,180)),rad(math.random(-180,180)),rad(math.random(-180,180)))
			if ef.Transparency > .99 then
				ef:Destroy()
			end
			swait()
		end
	end))
end

local grabda = false
local keyhold = false
local lukin = false
function fire()
	if not using and mode == "shoot" or using and grabda and mode == "grab" and killmode == "shoot1" then
		using = true
		rsw.Part1 = rapr
		lukin = true
		coroutine.resume(coroutine.create(function()
			while lukin do
				turnto(mouse.Hit.p)
				swait()
			end
		end))
		keyhold = true
		for i = 0,1,.07 do
			rsw.C0 = rsw.C0:lerp(CFrame.Angles(rad(90),rad(0),rad(53)),i)
			rutj.C0 = rutj.C0:lerp(CFrame.Angles(rad(-90),rad(0),rad(233)),i)
			nec.C0 = nec.C0:lerp(CFrame.new(0,1,0) * CFrame.Angles(rad(-90),rad(0),rad(127)),i)
			swait()
		end
		repeat
			if ammo >0 then
				fireto(mouse.Hit.p)
				sound(char,"131070686",4,1)
				ammo = ammo -1
				effect()
				bullet()
				for i = 0,1,.3 do
					rsw.C0 = rsw.C0:lerp(CFrame.new(0,0,.3) * CFrame.Angles(rad(90),rad(0),rad(53)) * CFrame.Angles(rad(40),rad(0),rad(0)),i)
					swait()
				end
				for i = 0,1,.2 do
					rsw.C0 = rsw.C0:lerp(CFrame.Angles(rad(90),rad(0),rad(53)),i)
					swait()
				end
				wait(.35)
			else
				sound(char,"537744814",10,1)
				keyhold = false
				swait()
			end
		until keyhold == false
		wait(.2)
		lukin = false
		for i = 0,1,.07 do
			rsw.C0 = rsw.C0:lerp(CFrame.Angles(rad(0),rad(0),rad(0)),i)
			rutj.C0 = rutj.C0:lerp(CFrame.Angles(rad(-90),rad(0),rad(180)),i)
			nec.C0 = nec.C0:lerp(CFrame.new(0,1,0) * CFrame.Angles(rad(-90),rad(0),rad(180)),i)
			swait()
		end
		rsw.Part1 = nil
		if killmode ~= "shoot1" then
			using = false
		end
	end
end
function keyup()
	keyhold = false
end

function reload()
	if ammo >6 then
	else
		using = true
		rsw.Part1 = rapr lsw.Part1 = lapl
		sound(char,"198915489",2,1.3)
		info("Reloading...",2.2)
		for i = 0,1,.05 do
			rsw.C0 = rsw.C0:lerp(CFrame.new(0,0,0) * CFrame.Angles(rad(80),rad(-45),rad(-40)),i)
			lsw.C0 = lsw.C0:lerp(CFrame.new(0,0,0) * CFrame.Angles(rad(60),rad(0),rad(50)),i)
			nec.C0 = nec.C0:lerp(CFrame.new(0,1,0) * CFrame.Angles(rad(-90),rad(0),rad(180)),i)
			swait()
		end
		mag()
		for i = 0,1,.1 do
			rsw.C0 = rsw.C0:lerp(CFrame.new(0,0,0) * CFrame.Angles(rad(60),rad(-45),rad(-40)),i)
			lsw.C0 = lsw.C0:lerp(CFrame.new(0,0,0) * CFrame.Angles(rad(-10),rad(0),rad(0)),i)
			nec.C0 = nec.C0:lerp(CFrame.new(0,1,0) * CFrame.Angles(rad(-90),rad(0),rad(180)),i)
			swait()
		end
		for i = 0,1,.05 do
			rsw.C0 = rsw.C0:lerp(CFrame.new(0,0,0) * CFrame.Angles(rad(60),rad(-45),rad(-40)),i)
			lsw.C0 = lsw.C0:lerp(CFrame.new(0,0,0) * CFrame.Angles(rad(-10),rad(0),rad(50)),i)
			nec.C0 = nec.C0:lerp(CFrame.new(0,1,0) * CFrame.Angles(rad(-90),rad(0),rad(180)),i)
			swait()
		end
		local mag = Instance.new("Part",workspace) mag.Size = Vector3.new(.35,1,.2) mag.BrickColor = BrickColor.new("Black") mag.CanCollide = false mag.Material = "Metal"
		local magw = Instance.new("Weld",mag) magw.Part0 = la magw.Part1 = mag magw.C0 = CFrame.new(.3,-1,.1) * CFrame.Angles(rad(90),rad(-40),rad(-90))
		for i = 0,1,.05 do
			rsw.C0 = rsw.C0:lerp(CFrame.new(0,0,0) * CFrame.Angles(rad(80),rad(-45),rad(-40)),i)
			lsw.C0 = lsw.C0:lerp(CFrame.new(.4,0,0) * CFrame.Angles(rad(50),rad(45),rad(50)),i)
			nec.C0 = nec.C0:lerp(CFrame.new(0,1,0) * CFrame.Angles(rad(-90),rad(0),rad(180)),i)
			swait()
		end
		mag:Destroy()
		for i = 0,1,.05 do
			rsw.C0 = rsw.C0:lerp(CFrame.new(-.5,-.7,0) * CFrame.Angles(rad(110),rad(0),rad(-47)),i)
			lsw.C0 = lsw.C0:lerp(CFrame.new(.3,-.5,0) * CFrame.Angles(rad(160),rad(-77),rad(40)),i)
			nec.C0 = nec.C0:lerp(CFrame.new(0,1,0) * CFrame.Angles(rad(-90),rad(0),rad(180)),i)
			swait()
		end
		for i = 0,1,.05 do
			rsw.C0 = rsw.C0:lerp(CFrame.new(-.5,-.7,0) * CFrame.Angles(rad(110),rad(0),rad(-47)),i)
			lsw.C0 = lsw.C0:lerp(CFrame.new(.5,-.5,.3) * CFrame.Angles(rad(150),rad(-50),rad(40)),i)
			nec.C0 = nec.C0:lerp(CFrame.new(0,1,0) * CFrame.Angles(rad(-90),rad(0),rad(180)),i)
			swait()
		end
		for i = 0,1,.05 do
			rsw.C0 = rsw.C0:lerp(CFrame.new(-.5,-.7,0) * CFrame.Angles(rad(110),rad(0),rad(-47)),i)
			lsw.C0 = lsw.C0:lerp(CFrame.new(.3,-.5,0) * CFrame.Angles(rad(160),rad(-77),rad(40)),i)
			nec.C0 = nec.C0:lerp(CFrame.new(0,1,0) * CFrame.Angles(rad(-90),rad(0),rad(180)),i)
			swait()
		end
		for i = 0,.6,.05 do
			rsw.C0 = rsw.C0:lerp(CFrame.new(0,0,0) * CFrame.Angles(rad(0),rad(0),rad(0)),i)
			lsw.C0 = lsw.C0:lerp(CFrame.new(0,0,0) * CFrame.Angles(rad(0),rad(0),rad(0)),i)
			nec.C0 = nec.C0:lerp(CFrame.new(0,1,0) * CFrame.Angles(rad(-90),rad(0),rad(180)),i)
			swait()
		end
		ammo = 7
		rsw.Part1 = nil lsw.Part1 = nil
		using = false
	end
end

function greb()
	local hbox = Instance.new("Part",char) hbox.Size = Vector3.new(2,5,.5) hbox.CanCollide = false hbox.Transparency = 1
	local hwb = Instance.new("Weld",hbox) hwb.Part0 = t hwb.Part1 = hbox hwb.C0 = CFrame.new(0,0,-1)
	local aa = false
	function grabd(hit)
		if hit ~= nil and not grab and not aa then
			local aaa = hit.Parent:FindFirstChildOfClass("Humanoid") or hit.Parent.Parent:FindFirstChildOfClass("Humanoid") or hit.Parent.Parent.Parent:FindFirstChildOfClass("Humanoid")
			if aaa ~= nil and not grab then
				grab = true aa = true
				hbox:Destroy()
				if aaa.Parent.Name == "ded" then
					info("Press Q to Release",1)
				else
					--// ti
					info("Press E to Kill or Q to Release",1)
				end
				local tos = aaa.Parent:FindFirstChild("Torso") or aaa.Parent:FindFirstChild("UpperTorso")
				aaa.PlatformStand = true
				local w = Instance.new("Weld",t) w.Name = "grabweld" w.Part0 = t w.Part1 = tos
				coroutine.resume(coroutine.create(function()
					for i = 0,.5,.1 do
						w.C0 = w.C0:lerp(CFrame.new(-.9,0,-.8),i)	
						swait()
					end
				end))
				if aaa.Parent.Name ~= "ded" then
					for i = 0,1,.05 do
						rsw.C0 = rsw.C0:lerp(CFrame.new(.7,0,-.15) * CFrame.Angles(rad(110),rad(0),rad(-80)) * CFrame.Angles(rad(10),rad(0),rad(0)),i)
						lsw.C0 = lsw.C0:lerp(CFrame.new(-.2,-.2,-.4) * CFrame.Angles(rad(130),rad(10),rad(50)),i)
						swait()
					end
					function kill()
						aaa.Parent.Archivable = true
						grab = false
						if ammo >0 then
							ammo = ammo -1
							sound(char,"131070686",5,1)
							coroutine.resume(coroutine.create(function()
								for i = 0,1,.5 do
									rsw.C0 = rsw.C0:lerp(CFrame.new(1,0,.45) * CFrame.Angles(rad(110),rad(0),rad(-80)) * CFrame.Angles(rad(10),rad(0),rad(15)),i)
									swait()
								end
								for i = 0,1,.05 do
									rsw.C0 = rsw.C0:lerp(CFrame.new(.7,0,-.15) * CFrame.Angles(rad(110),rad(0),rad(-80)),i)
									swait()
								end
							end))
							coroutine.resume(coroutine.create(function()
								aaa.Health = .1
								for i,v in pairs(aaa.Parent:GetChildren()) do
									if v:IsA("Script") then
										v:Destroy()
									end
								end
							end))
							wait(.5)
							coroutine.resume(coroutine.create(function()
								for i,v in pairs(tos.Parent:GetChildren()) do
									if v:IsA("BasePart") then
										v.Anchored = false
									end
								end
								for i,v in pairs(t:GetChildren()) do
									if v.Name == "grabweld" then
										v:Destroy()
									end
								end
							end))
							coroutine.resume(coroutine.create(function()
								for i = 0,.5,.1 do
									rsw.C0 = rsw.C0:lerp(CFrame.Angles(rad(-15),rad(0),rad(20)),i)
									lsw.C0 = lsw.C0:lerp(CFrame.Angles(rad(110),rad(20),rad(-30)),i)
									rutj.C0 = rutj.C0:lerp(CFrame.Angles(rad(-90),rad(0),rad(150)),i)
									swait()
								end
							end))
							aaa.DisplayDistanceType = "None"
							if tos.Name == "Torso" then
								coroutine.resume(coroutine.create(function()
									aaa.PlatformStand = true
									local disshit = aaa.Parent
									local h1 = disshit.Head
									local t1 = disshit.Torso
									local ra1 = disshit["Right Arm"]
									local la1 = disshit["Left Arm"]
									local rl1 = disshit["Right Leg"]
									local ll1 = disshit["Left Leg"]
									t1:BreakJoints()
									at2 = Instance.new("Attachment",t1) at2.Position = Vector3.new(1,.7,0) at2.Position = Vector3.new(1,.5,0)
									at = Instance.new("Attachment",ra1) at.Name = "oof" at.Position = Vector3.new(-.5,.7,0)
									balls = Instance.new("BallSocketConstraint",ra1) balls.Attachment0 = at2 balls.Attachment1 = at
									at21 = Instance.new("Attachment",t1) at21.Position = Vector3.new(-1,.7,0) at21.Position = Vector3.new(-1,.5,0) at21.Orientation = Vector3.new(0,180,0)
									at1 = Instance.new("Attachment",la1) at.Name = "oof" at1.Position = Vector3.new(.5,.7,0)
									balls1 = Instance.new("BallSocketConstraint",la1) balls1.Attachment0 = at21 balls1.Attachment1 = at1
									nek = Instance.new("Attachment",h1) nek2 = Instance.new("Attachment",t1) nek2.Position = Vector3.new(0,1,0) nek.Position = Vector3.new(0,-.5,0) nball = Instance.new("BallSocketConstraint",h1) nball.Attachment0 = nek nball.Attachment1 = nek2
									owihatedis = Instance.new("Attachment",t1) owihatedis.Position = Vector3.new(.5,-1,0) oihd = Instance.new("Attachment",rl1) oihd.Position = Vector3.new(0,1,0) oww = Instance.new("BallSocketConstraint",rl1) oww.Attachment0 = owihatedis oww.Attachment1 = oihd
									owihatedis2 = Instance.new("Attachment",t1) owihatedis2.Position = Vector3.new(-.5,-1,0) oihd2 = Instance.new("Attachment",ll1) oihd2.Position = Vector3.new(0,1,0) oww2 = Instance.new("BallSocketConstraint",ll1) oww2.Attachment0 = owihatedis2 oww2.Attachment1 = oihd2
									box = Instance.new("Part",t1) box.Size = Vector3.new(1,1.3,1) box.Transparency = 1
									box1 = Instance.new("Part",t1) box1.Size = Vector3.new(1,1.3,1) box1.Transparency = 1
									box2 = Instance.new("Part",t1) box2.Size = Vector3.new(1,1.3,1) box2.Transparency = 1
									box3 = Instance.new("Part",t1) box3.Size = Vector3.new(1,1.3,1) box3.Transparency = 1
									box4 = Instance.new("Part",t1) box4.Size = h.Size - Vector3.new(0,.7,0) box4.Transparency = 1
									bw = Instance.new("Weld",box) bw.Part0 = box bw.Part1 = ra1 bw.C0 = bw.C0 * CFrame.new(0,.45,0)
									bw1 = Instance.new("Weld",box1) bw1.Part0 = box1 bw1.Part1 = la1 bw1.C0 = bw1.C0 * CFrame.new(0,.45,0)
									bw2 = Instance.new("Weld",box2) bw2.Part0 = box2 bw2.Part1 = rl1 bw2.C0 = bw2.C0 * CFrame.new(0,.45,0)
									bw3 = Instance.new("Weld",box3) bw3.Part0 = box3 bw3.Part1 = ll1 bw3.C0 = bw3.C0 * CFrame.new(0,.45,0)
									bw4 = Instance.new("Weld",box4) bw4.Part0 = box4 bw4.Part1 = h1  bw4.C0 = bw4.C0 * CFrame.new(0,0,0)
									local rt = disshit:FindFirstChild("HumanoidRootPart")
									if rt ~= nil then
										rt:Destroy()
									end
									wait()
									local ded = disshit:Clone()
									local as = ded:FindFirstChildOfClass("Humanoid")
									as.Died:connect(function()
										for i,v in pairs(ded.Torso:GetChildren()) do
											if v:IsA("Part") then
												v:Destroy()
											end
										end
									end)
									coroutine.resume(coroutine.create(function()
										for i = 1,math.random(4,9) do
											nubblud(ded.Head)
											wait(.05)
										end
									end))
									as.PlatformStand = true
									ded.Parent = workspace disshit:Destroy()
									ded.Torso.CFrame = ded.Torso.CFrame * CFrame.new(0,4,-6)
									ded.Torso.Orientation = Vector3.new(math.random(-70,70),math.random(-70,70),math.random(-70,70))
									ded.Name = "ded"
									local yes = Instance.new("Part",char) yes.Size = t.Size yes.Anchored = true yes.CanCollide = false yes.Transparency = 1 yes.CFrame = rut.CFrame * CFrame.Angles(rad(50),rad(0),rad(0))
									local furs = Instance.new("BodyVelocity",ded.Torso) furs.MaxForce = Vector3.new(huge,huge,huge)
									furs.Velocity = yes.CFrame.lookVector * 35

									coroutine.resume(coroutine.create(function()
										wait(.1)
										furs:Destroy()
										yes:Destroy()
									end))
								end))
							end
							wait(.4)
							for i = 0,1,.05 do
								rsw.C0 = rsw.C0:lerp(CFrame.Angles(rad(0),rad(0),rad(0)),i)
								lsw.C0 = lsw.C0:lerp(CFrame.Angles(rad(0),rad(0),rad(0)),i)
								nec.C0 = nec.C0:lerp(CFrame.new(0,1,0) * CFrame.Angles(rad(-90),rad(0),rad(180)),i)
								rutj.C0 = rutj.C0:lerp(CFrame.Angles(rad(-90),rad(0),rad(180)),i)
								swait()
							end
							if aaa.Parent ~= nil then
								aaa.Parent:BreakJoints()
							end
							using = false
							rsw.Part1 = nil lsw.Part1 = nil
						else
							aaa.PlatformStand = true
							sound(char,"537744814",10,1)
							wait(.5)
							local furs = Instance.new("BodyVelocity",tos) furs.MaxForce = Vector3.new(huge,huge,huge)
							furs.Velocity = rut.CFrame.lookVector * 30
							w:Destroy()
							for i = 0,.5,.05 do
								rsw.C0 = rsw.C0:lerp(CFrame.Angles(rad(-15),rad(0),rad(-20)),i)
								lsw.C0 = lsw.C0:lerp(CFrame.Angles(rad(90),rad(20),rad(10)),i)
								swait()
							end
							furs:Destroy()
							for i = 0,1,.1 do
								rsw.C0 = rsw.C0:lerp(CFrame.Angles(rad(0),rad(0),rad(0)),i)
								lsw.C0 = lsw.C0:lerp(CFrame.Angles(rad(0),rad(0),rad(0)),i)
								nec.C0 = nec.C0:lerp(CFrame.new(0,1,0) * CFrame.Angles(rad(-90),rad(0),rad(180)),i)
								swait()
							end
							coroutine.resume(coroutine.create(function()
								wait(2)
								if aaa.Parent.Name == "ded" then
								else
									aaa.PlatformStand = false
								end
							end))
							grab = false
							using = false
							rsw.Part1 = nil lsw.Part1 = nil
						end
					end		
					function drop()
						aaa.PlatformStand = true
						w:Destroy()
						local furs = Instance.new("BodyVelocity",tos) furs.MaxForce = Vector3.new(huge,huge,huge)
						furs.Velocity = rut.CFrame.lookVector * 30
						for i = 0,.5,.05 do
							rsw.C0 = rsw.C0:lerp(CFrame.Angles(rad(-15),rad(0),rad(-20)),i)
							lsw.C0 = lsw.C0:lerp(CFrame.Angles(rad(90),rad(20),rad(10)),i)
							swait()
						end
						furs:Destroy()
						for i = 0,1,.05 do
							rsw.C0 = rsw.C0:lerp(CFrame.Angles(rad(0),rad(0),rad(0)),i)
							lsw.C0 = lsw.C0:lerp(CFrame.Angles(rad(0),rad(0),rad(0)),i)
							nec.C0 = nec.C0:lerp(CFrame.new(0,1,0) * CFrame.Angles(rad(-90),rad(0),rad(180)),i)
							swait()
						end
						coroutine.resume(coroutine.create(function()
							wait(2)
							if aaa.Parent.Name == "ded" then
							else
								aaa.PlatformStand = false
							end
						end))
						using = false
						rsw.Part1 = nil lsw.Part1 = nil
						grab = false	
					end
				else
					oldmode = killmode
					killmode = "release1"
					hum.JumpPower = 0
					hum.WalkSpeed = 8
					coroutine.resume(coroutine.create(function()
						for i = 0,1,.05 do
							rsw.C0 = rsw.C0:lerp(CFrame.new(0,0,0),i)
							lsw.C0 = lsw.C0:lerp(CFrame.new(0,0,0) * CFrame.Angles(rad(-33),rad(0),rad(-30)),i)
							swait()
						end
					end))
					grabda = true
					w:Destroy()
					local ata = Instance.new("Attachment",la) ata.Position = Vector3.new(0,-.8,0)
					local ata1 = Instance.new("Attachment",aaa.Parent["Right Leg"]) ata1.Position = Vector3.new(0,-.8,0)
					local ba = Instance.new("BallSocketConstraint",ata) ba.Attachment0 = ata ba.Attachment1 = ata1
					rsw.Part1 = nil
					function drop1()
						using = true
						grabda = false
						killmode = oldmode
						ba.Attachment1 = nil
						ata:Destroy()
						ata1:Destroy()
						ba:Destroy()
						hum.JumpPower = 50
						hum.WalkSpeed = 16
						for i = 0,1,.05 do
							lsw.C0 = lsw.C0:lerp(CFrame.new(0,0,0),i)
							swait()
						end
						lsw.Part1 = nil
						using = false
						grab = false
					end
				end
			end
		end
	end
	local tcon = hbox.Touched:connect(grabd)
	using = true
	coroutine.resume(coroutine.create(function()
		for i = 0,.5,.1 do
			rutj.C0 = rutj.C0:lerp(CFrame.Angles(rad(-90),rad(0),rad(180)),i)
			rh.C0 = rh.C0:lerp(CFrame.new(1,-1,0) * CFrame.Angles(rad(0),rad(90),rad(0)),i)
			lh.C0 = lh.C0:lerp(CFrame.new(-1,-1,0) * CFrame.Angles(rad(0),rad(-90),rad(0)),i)
			swait()
		end
	end))
	rsw.Part1 = rapr lsw.Part1 = lapl
	for i = 0,.7,.05 do
		rsw.C0 = rsw.C0:lerp(CFrame.new(.2,0,-.3) * CFrame.Angles(rad(90),rad(0),rad(70)),i)
		lsw.C0 = lsw.C0:lerp(CFrame.new(-.2,0,-.5) * CFrame.Angles(rad(90),rad(0),rad(-70)),i)
		swait()
	end
	wait(.25)
	hbox:Destroy()
	tcon:disconnect()
	if grab == false then
		for i = 0,1,.05 do
			rsw.C0 = rsw.C0:lerp(CFrame.Angles(rad(0),rad(0),rad(0)),i)
			lsw.C0 = lsw.C0:lerp(CFrame.Angles(rad(0),rad(0),rad(0)),i)
			swait()
		end
		using = false
		rsw.Part1 = nil lsw.Part1 = nil
	end
end

function dumi()
	local dog = Instance.new("Model",workspace) dog.Name = "dumi" 
	local head = Instance.new("Part",dog) head.Name = "Head" head.Size = Vector3.new(2,1,1)
	local la1 = Instance.new("Part",dog) la1.Name = "Left Arm" la1.Size = Vector3.new(1,2,1) local t1 = Instance.new("Part",dog) t1.Name = "Torso" t1.Size = Vector3.new(2,2,1) local ra1 = Instance.new("Part",dog) ra1.Name = "Right Arm" ra1.Size = Vector3.new(1,2,1)
	local ll1 = Instance.new("Part",dog) ll1.Name = "Left Leg" ll1.Size = Vector3.new(1,2,1) local rl1 = Instance.new("Part",dog) rl1.Name = "Right Leg" rl1.Size = Vector3.new(1,2,1)
	local dhum = Instance.new("Humanoid",dog) local hmesh = Instance.new("SpecialMesh",head) hmesh.Scale = Vector3.new(1.25,1.25,1.25)
	dhum.MaxHealth = "inf" dhum.Health = "inf" dhum.AutoJumpEnabled = true
	head.BrickColor = BrickColor.new("Institutional white") t1.BrickColor = BrickColor.new("Really black") ra1.BrickColor = BrickColor.new("Institutional white") la1.BrickColor = BrickColor.new("Institutional white") rl1.BrickColor = BrickColor.new("Dark stone grey") ll1.BrickColor = BrickColor.new("Dark stone grey")
	local fais = Instance.new("Decal",head) fais.Texture = "http://www.roblox.com/asset/?id=1077397727"
	local nec = Instance.new("Motor6D",t1) nec.Part0 = t1 nec.Part1 = head nec.C0 = nec.C0 * CFrame.new(0,1.5,0)
	local ris = Instance.new("Motor6D",t1) ris.Part0 = t1 ris.Part1 = ra1 ris.C0 = ris.C0 * CFrame.new(1.5,0,0)
	local lis = Instance.new("Motor6D",t1) lis.Part0 = t1 lis.Part1 = la1 lis.C0 = lis.C0 * CFrame.new(-1.5,0,0)
	local rih = Instance.new("Motor6D",t1) rih.Part0 = t1 rih.Part1 = rl1 rih.C0 = rih.C0 * CFrame.new(.5,-2,0)
	local lih = Instance.new("Motor6D",t1) lih.Part0 = t1 lih.Part1 = ll1 lih.C0 = lih.C0 * CFrame.new(-.5,-2,0)
	head.CFrame = h.CFrame * CFrame.new(4,0,0)
	t1.CFrame = t.CFrame * CFrame.new(4,0,0)
	ra1.CFrame = ra.CFrame * CFrame.new(4,0,0)
	la1.CFrame = la.CFrame * CFrame.new(4,0,0)
	rl1.CFrame = rl.CFrame * CFrame.new(4,0,0)
	ll1.CFrame = ll.CFrame * CFrame.new(4,0,0)
end

function equip()
	rsw.Part1 = rapr
	using = true
	info("Equipped, press F or G to change the mode.",1)
	for i = 0,1,.03 do
		rsw.C0 = rsw.C0:lerp(CFrame.new(0,.3,0) * CFrame.Angles(rad(0),rad(0),rad(-20)),i)
		swait()
	end
	gunweld.Part0 = ra gunweld.C0 = CFrame.new(0,-.9,0) * CFrame.Angles(rad(-90),rad(-90),rad(0))
	for i = 0,1,.05 do
		rsw.C0 = rsw.C0:lerp(CFrame.new(0,0,0) * CFrame.Angles(rad(0),rad(0),rad(0)),i)
		swait()
	end
	uneq = true
	rsw.Part1 = nil
	canequip = false
	using = false
end

function unequip()
	rsw.Part1 = rapr
	using = true
	info("Unequipped.",1)
	for i = 0,1,.05 do
		rsw.C0 = rsw.C0:lerp(CFrame.new(0,.3,0) * CFrame.Angles(rad(0),rad(0),rad(-20)),i)
		swait()
	end
	gunweld.Part0 = t gunweld.C0 = CFrame.new(1.1,-.7,0) * CFrame.Angles(rad(-120),rad(-90),rad(0))
	for i = 0,.5,.1 do
		rutj.C0 = rutj.C0:lerp(CFrame.Angles(rad(-90),rad(0),rad(180)),i)
		rs.C0 = rs.C0:lerp(CFrame.new(1,.5,0) * CFrame.Angles(rad(0),rad(90),rad(0)),i)
		ls.C0 = ls.C0:lerp(CFrame.new(-1,.5,0) * CFrame.Angles(rad(0),rad(-90),rad(0)),i)
		rh.C0 = rh.C0:lerp(CFrame.new(1,-1,0) * CFrame.Angles(rad(0),rad(90),rad(0)),i)
		lh.C0 = lh.C0:lerp(CFrame.new(-1,-1,0) * CFrame.Angles(rad(0),rad(-90),rad(0)),i)
		nec.C0 = nec.C0:lerp(CFrame.new(0,1,0) * CFrame.Angles(rad(-90),rad(0),rad(180)),i)
		swait()
	end
	for i = 0,1,.03 do
		rsw.C0 = rsw.C0:lerp(CFrame.new(0,0,0) * CFrame.Angles(rad(0),rad(0),rad(0)),i)
		swait()
	end
	uneq = false
	canequip = true
	rsw.Part1 = nil
end

mouse.KeyDown:connect(function(key)
	key = string.lower(key)
	if string.byte(key) == 48 and not grabda then
		hum.WalkSpeed = 30
	end
end)
mouse.KeyUp:connect(function(key)
	key = string.lower(key)
	if string.byte(key) == 48 and not grabda then
		hum.WalkSpeed = 16
	end
end)

local conts = false
function controls()
	conts = true
	coroutine.resume(coroutine.create(function()
		info("F - Shoot.",1)
		wait(1)
		info("R - Reload.",1)
		wait(1)
		info("G - Grab.",1)
		wait(1)
		info("C - Spawn a dummy.",1)
		wait(1)
		info("V - Destroy all dead victims.",1)
		wait(1)
		info("N - Dance.",1)
		conts = false
	end))
end

function cleardumi()
	for i,v in pairs(workspace:GetChildren()) do
		if v.Name == "ded" then
			local exp = Instance.new("Explosion",workspace) exp.Position = v.Torso.Position exp.BlastRadius = 0
			v:Destroy()
		end
	end
end

hum.Running:connect(function(spd)
	if spd > 0 then
		anim = "walk"
	else
		anim = "idle"
	end
end)

local dancing = false
local mus = Instance.new("Sound",char) mus.Looped = true mus.SoundId = "rbxassetid://1563991094" mus.Volume = 5
local musica = Instance.new("Sound",char) musica.Volume = 1 musica.Looped = true musica.SoundId = "rbxassetid://1080089636"
local visonlyvlad = false

mouse.KeyDown:connect(function(key)
	if key == "e" and grab and not grabda then
		kill()
	end
	if key == "q" and grab and not grabda then
		drop()
	end
	if grabda and key == "q" then
		drop1()
	end
	if grabda and key == "e" then
		fire()
	end
	if key == "r" and not using and not grab then
		reload()
	end
	if key == "c" then
		dumi()
	end
	if key == "z"and canequip == true then
		equip()
	end
	if key == "x" and canequip == false and uneq == true then
		unequip()
	end
	if key == "v" then
		cleardumi()
	end
	if key == "m" and not conts then
		controls()
	end
	if key == "g" and not using then
		greb()
	end
	if key == "f" and not using then
		fire()
	end
	key = key:lower()
	if key == "n" then
		if not dancing then
			dancing = true
			using = true
			char.Animate.Disabled = true
			for i,v in pairs(Model0:GetChildren()) do
				if v:IsA("Part") then
					v.Transparency = 1
				end
			end
			mus:Play()
			while dancing do
				if dancing then
					coroutine.resume(coroutine.create(function()
						for i = 0,.3,.035 do
							rutj.C0 = rutj.C0:lerp(CFrame.Angles(rad(-90),rad(5),rad(180)) * CFrame.new(0,0,-.1),i)
							rs.C0 = rs.C0:lerp(CFrame.new(.3,.7,-1.3) * CFrame.Angles(rad(0),rad(114),rad(190)) * CFrame.Angles(rad(43),rad(0),rad(0)),i)
							ls.C0 = ls.C0:lerp(CFrame.new(-1.3,.5,-.3) * CFrame.Angles(rad(0),rad(-166),rad(-40)) * CFrame.Angles(rad(23),rad(0),rad(0)),i)
							rh.C0 = rh.C0:lerp(CFrame.new(1,-.9,-.05) * CFrame.Angles(rad(0),rad(60),rad(-10)),i)
							lh.C0 = lh.C0:lerp(CFrame.new(-1,-.8,-.15) * CFrame.Angles(rad(0),rad(-45),rad(-31.5)),i)
							nec.C0 = nec.C0:lerp(CFrame.new(0,1,0) * CFrame.Angles(rad(-90),rad(0),rad(180)),i)
							swait()
						end
					end))
				end
				wait(.07)
				if dancing then
					for i = 0,.7,.035 do
						rutj.C0 = rutj.C0:lerp(CFrame.Angles(rad(-90),rad(5),rad(180)) * CFrame.new(0,0,-.2),i)
						rs.C0 = rs.C0:lerp(CFrame.new(.3,.7,-1.3) * CFrame.Angles(rad(0),rad(114),rad(190)) * CFrame.Angles(rad(43),rad(0),rad(0)),i)
						ls.C0 = ls.C0:lerp(CFrame.new(-1.3,.5,-.3) * CFrame.Angles(rad(0),rad(-166),rad(-40)) * CFrame.Angles(rad(23),rad(0),rad(0)),i)
						rh.C0 = rh.C0:lerp(CFrame.new(1,-.8,-.05) * CFrame.Angles(rad(0),rad(60),rad(-20)),i)
						lh.C0 = lh.C0:lerp(CFrame.new(-1,-.8,-.15) * CFrame.Angles(rad(0),rad(-45),rad(-63)),i)
						nec.C0 = nec.C0:lerp(CFrame.new(0,1,0) * CFrame.Angles(rad(-90),rad(0),rad(180)),i)
						swait()
					end
				end
				if dancing then
					coroutine.resume(coroutine.create(function()
						for i = 0,.3,.035 do
							rutj.C0 = rutj.C0:lerp(CFrame.Angles(rad(-90),rad(-5),rad(180)) * CFrame.new(0,0,-.1),i)
							rs.C0 = rs.C0:lerp(CFrame.new(.3,.7,-1.3) * CFrame.Angles(rad(0),rad(114),rad(190)) * CFrame.Angles(rad(43),rad(0),rad(0)),i)
							ls.C0 = ls.C0:lerp(CFrame.new(-1.3,.5,-.3) * CFrame.Angles(rad(0),rad(-166),rad(-40)) * CFrame.Angles(rad(23),rad(0),rad(0)),i)
							rh.C0 = rh.C0:lerp(CFrame.new(1,-.8,-.15) * CFrame.Angles(rad(0),rad(45),rad(31.5)),i)
							lh.C0 = lh.C0:lerp(CFrame.new(-1,-.9,-.05) * CFrame.Angles(rad(0),rad(-60),rad(20)),i)
							nec.C0 = nec.C0:lerp(CFrame.new(0,1,0) * CFrame.Angles(rad(-90),rad(0),rad(180)),i)
							swait()
						end
					end))
				end
				wait(.07)
				if dancing then
					for i = 0,.7,.035 do
						rutj.C0 = rutj.C0:lerp(CFrame.Angles(rad(-90),rad(-5),rad(180)) * CFrame.new(0,0,-.2),i)
						rs.C0 = rs.C0:lerp(CFrame.new(.3,.7,-1.3) * CFrame.Angles(rad(0),rad(114),rad(190)) * CFrame.Angles(rad(43),rad(0),rad(0)),i)
						ls.C0 = ls.C0:lerp(CFrame.new(-1.3,.5,-.3) * CFrame.Angles(rad(0),rad(-166),rad(-40)) * CFrame.Angles(rad(23),rad(0),rad(0)),i)
						rh.C0 = rh.C0:lerp(CFrame.new(1,-.8,-.15) * CFrame.Angles(rad(0),rad(45),rad(63)),i)
						lh.C0 = lh.C0:lerp(CFrame.new(-1,-.8,-.05) * CFrame.Angles(rad(0),rad(-60),rad(20)),i)
						nec.C0 = nec.C0:lerp(CFrame.new(0,1,0) * CFrame.Angles(rad(-90),rad(0),rad(180)),i)
						swait()
					end
				end
				swait()
			end
		else
			mus:Stop()
			char.Animate.Disabled = false
			dancing = false
			for i,v in pairs(Model0:GetChildren()) do
				if v:IsA("Part") then
					v.Transparency = 0
				end
			end
			shot.Transparency = 1
			if not canequip then
				using = false
			else
				for i,v in pairs(Model0:GetChildren()) do
					if v:IsA("Part") then
						v.Transparency = 0
					end
				end
				shot.Transparency = 1
				using = true
				wait(.3)
				for i = 0,1,.1 do
					rutj.C0 = rutj.C0:lerp(CFrame.Angles(rad(-90),rad(0),rad(180)),i)
					rs.C0 = rs.C0:lerp(CFrame.new(1,.5,0) * CFrame.Angles(rad(0),rad(90),rad(0)),i)
					ls.C0 = ls.C0:lerp(CFrame.new(-1,.5,0) * CFrame.Angles(rad(0),rad(-90),rad(0)),i)
					rh.C0 = rh.C0:lerp(CFrame.new(1,-1,0) * CFrame.Angles(rad(0),rad(90),rad(0)),i)
					lh.C0 = lh.C0:lerp(CFrame.new(-1,-1,0) * CFrame.Angles(rad(0),rad(-90),rad(0)),i)
					nec.C0 = nec.C0:lerp(CFrame.new(0,1,0) * CFrame.Angles(rad(-90),rad(0),rad(180)),i)
					swait()
				end
			end
		end
	end
	key = key:lower()
	if key == "u" and plr.Name == plr.Name then
		if not visonlyvlad then

			musica:Play()
			visonlyvlad = true
			info("Visualiser mode:On",.3)
		else
			info("Visualiser mode:Off",.3)
			visonlyvlad = false
			musica:Stop()
		end
	end
end)
mouse.KeyUp:connect(function(key)
	if key == "f" then
		keyhold = false
	end
end)
coroutine.resume(coroutine.create(function()
	while false do
		if visonlyvlad == true then
			for i = 0,1,.0001 do
				vispart.CFrame = vispart.CFrame:lerp(rut.CFrame * CFrame.new(1,2,2),i)
				swait()
			end
		end
		swait()
	end
end))
while true do
	if anim == "walk" and not using and uneq then
		for i = 0,.5,.1 do
			rutj.C0 = rutj.C0:lerp(CFrame.Angles(rad(-90),rad(0),rad(180)),i)
			rs.C0 = rs.C0:lerp(CFrame.new(1,.5,0) * CFrame.Angles(rad(0),rad(90),rad(0)),i)
			ls.C0 = ls.C0:lerp(CFrame.new(-1,.5,0) * CFrame.Angles(rad(0),rad(-90),rad(0)),i)
			rh.C0 = rh.C0:lerp(CFrame.new(1,-1,0) * CFrame.Angles(rad(0),rad(90),rad(0)),i)
			lh.C0 = lh.C0:lerp(CFrame.new(-1,-1,0) * CFrame.Angles(rad(0),rad(-90),rad(0)),i)
			nec.C0 = nec.C0:lerp(CFrame.new(0,1,0) * CFrame.Angles(rad(-90),rad(0),rad(180)),i)
			swait()
		end
	end
	if anim == "idle" and not using and uneq then
		for i = 0,.5,.06 do
			rutj.C0 = rutj.C0:lerp(CFrame.Angles(rad(-90),rad(0),rad(160)),i)
			rs.C0 = rs.C0:lerp(CFrame.new(1,.5,0) * CFrame.Angles(rad(0),rad(74),rad(-20)),i)
			ls.C0 = ls.C0:lerp(CFrame.new(-1,.5,0) * CFrame.Angles(rad(0),rad(-110),rad(-20)),i)
			rh.C0 = rh.C0:lerp(CFrame.new(1,-1.1,0) * CFrame.Angles(rad(7),rad(80),rad(0)),i)
			lh.C0 = lh.C0:lerp(CFrame.new(-1,-1,0) * CFrame.Angles(rad(-7),rad(-80),rad(0)),i)
			nec.C0 = nec.C0:lerp(CFrame.new(0,1,0) * CFrame.Angles(rad(-90),rad(0),rad(200)),i)
			swait()
		end
	end
	swait()
end
function inf(text)
	local ch = coroutine.wrap(function()
		local sc = Instance.new("ScreenGui",plrg)
		local tex = Instance.new("TextLabel",sc) tex.Rotation = math.random(-5,5) tex.Position = UDim2.new(-.5,0,-.5,0) tex.Size = UDim2.new(2,0,2,0) tex.TextScaled = true tex.BackgroundColor3 = Color3.fromRGB(40,40,40) tex.BorderSizePixel = 0 tex.TextColor3 = Color3.fromRGB(255,255,255) tex.Text = ""
		for i = 1, string.len(text) do
			tex.Text = string.sub(text, 1, i)
			wait()
		end
		wait(2)
		sc:Destroy()
		tex:Destroy()
	end)
	ch()
end