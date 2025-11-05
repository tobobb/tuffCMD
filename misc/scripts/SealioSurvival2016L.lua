-- SealioSurvival backport from SS to client for 2016L
-- This was some of the worst code I've ever had to work with. Holy shit. Thanks to louknt for converting the items via LM->S.
-- SultanOfSwing
-- Version: REL-01, 05/11/2025

local Players = game:GetService("Players")
local Debris = game:GetService("Debris")
local StarterGui = game:GetService("StarterGui")
local RS = game:GetService("RunService")
local player = Players.LocalPlayer

-- Config
local backpek = true
local versionHasWorkingWelds = false -- Keep this false for like 2017 or anything below!

-- Do not touch any of this shit unless you have any clue what you're doing --

-- Backport shit
local LocalRemoteEvent = { -- whipped up a quick local remote interface, this makes things a lot easier..
	new = function()
		local remote = Instance.new("BindableEvent")

		local event = {
			FireServer = function(self, ...)
				return remote:Fire(player, ...)
			end,

			OnServerEvent = remote.Event
		}

		return event
	end,
}

-- Other shit
local _compatFireRemote = LocalRemoteEvent.new()
local doingUQ = false

local hui;
local function gethui() -- thanks louknt, https://github.com/ayyyyyy-lmao/FEHaxx/blob/main/CDN/Release/FEHaxx#L130C1-L133C4
	local hasCore = pcall(function() return game:GetService("CoreGui").Name end)	
	return hasCore and game:GetService("CoreGui") or player.PlayerGui
end

-- Load items (thanks louknt and his LMS converter)
local _ITEMS_FOLDER_;
do
	local t,f=true,false
	local v3,c3,bc,v2,ud,ud2,cf = Vector3.new,Color3.new,BrickColor.new,Vector2.new,UDim.new,UDim2.new,CFrame.new
	local function new(class,par,props) local inst=Instance.new(class,par) 
		
		if class == "Part" then
			inst.CustomPhysicalProperties = PhysicalProperties.new(0.05,0,0,0,0)
		end
		
		if not props then return inst end --[[disgusting hack to fix roblox's collision solving bullshit on .Size, computing cframe as the last property is a hacky way to 'prevent' this.]] local hasCF = props.CFrame for p,v in pairs(props) do inst[p]=v end if hasCF then inst.CFrame = hasCF end return inst end
	
	
	i1=new("Folder",game,{Name="Items"})
	_ITEMS_FOLDER_ = i1
	i2=new("Model",i1,{Name="Glock 17S"})
	i3=new("Part",i2,{Name="Mag",Anchored=t,BrickColor=bc(26),CFrame=cf(-1141.10546875,-21.296510696411133,473.5142822265625,-0.00020528057939372957,-0.0000863395762280561,-1,-0.000215802327147685,1,-0.00008629527292214334,1,0.00021578460291493684,-0.00020529920584522188),Rotation=v3(0.012000000104308128,-90,0),Size=v3(0.21600341796875,0.8493061065673828,0.5209999084472656)})
	new("FileMesh",i3,{MeshId="rbxassetid://481035376"})
	i5=new("Part",i2,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1140.4906005859375,-20.947391510009766,473.514404296875,-0.00020528057939372957,-0.0000863395762280561,-1,-0.000215802327147685,1,-0.00008629527292214334,1,0.00021578460291493684,-0.00020529920584522188),Rotation=v3(0.012000000104308128,-90,0),Size=v3(0.21600341796875,0.44669008255004883,0.9895000457763672)})
	new("FileMesh",i5,{MeshId="rbxassetid://481035315"})
	i7=new("Part",i2,{Name="Bolt",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1140.6883544921875,-20.840456008911133,473.514404296875,-0.00020528057939372957,-0.0000863395762280561,-1,-0.000215802327147685,1,-0.00008629527292214334,1,0.00021578460291493684,-0.00020529920584522188),Rotation=v3(0.012000000104308128,-90,0),Size=v3(0.209991455078125,0.2505002021789551,1.3650007247924805)})
	new("IntValue",i7,{Name="Slot2"})
	new("FileMesh",i7,{MeshId="rbxassetid://481035475"})
	i10=new("Part",i2,{Name="MeshPart",Anchored=t,BrickColor=bc(149),CFrame=cf(-1140.7054443359375,-21.27149200439453,473.514404296875,-0.00020528057939372957,-0.0000863395762280561,-1,-0.000215802327147685,1,-0.00008629527292214334,1,0.00021578460291493684,-0.00020529920584522188),Rotation=v3(0.012000000104308128,-90,0),Size=v3(0.20000000298023224,0.8009422421455383,1.3920001983642578)})
	new("IntValue",i10,{Name="Slot1"})
	new("FileMesh",i10,{MeshId="rbxassetid://481035241"})
	i13=new("Part",i2,{Name="Iron",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1140.6795654296875,-20.713382720947266,473.5174865722656,-0.00020528057939372957,-0.0000863395762280561,-1,-0.000215802327147685,1,-0.00008629527292214334,1,0.00021578460291493684,-0.00020529920584522188),Rotation=v3(0.012000000104308128,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,1.2635993957519531)})
	new("FileMesh",i13,{MeshId="rbxassetid://481035435"})
	new("Part",i2,{Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1142.9749755859375,-20.6894588470459,473.5172119140625,-0.00017456611385568976,-0.00017453292093705386,-1,0,1,-0.00017453292093705386,1,-3.046753249691392e-08,-0.00017456611385568976),FrontSurface=6,Material=1088,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Part",i2,{Name="Trigger",Anchored=t,BottomSurface=0,BrickColor=bc(199),CFrame=cf(-1140.7987060546875,-21.0690975189209,473.5177001953125,-0.0003780003171414137,-0.000043203785025980324,-1,-0.000258953426964581,1,-0.000043105901568196714,0.9999998807907104,0.00025893712881952524,-0.00037801155121997),Material=1088,Rotation=v3(0.014999999664723873,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i17=new("Part",i2,{Name="BoltBack",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1141.0804443359375,-20.840456008911133,473.514404296875,-0.00020528057939372957,-0.0000863395762280561,-1,-0.000215802327147685,1,-0.00008629527292214334,1,0.00021578460291493684,-0.00020529920584522188),Rotation=v3(0.012000000104308128,-90,0),Size=v3(0.209991455078125,0.2505002021789551,1.3650007247924805),Transparency=1})
	new("IntValue",i17,{Name="Slot2"})
	new("FileMesh",i17,{MeshId="rbxassetid://481035475"})
	i20=new("Part",i2,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1138.6585693359375,-20.773807525634766,473.515625,5.493356169949948e-08,-3.335593135034287e-08,-1,-6.623014314754982e-08,1,-3.335593490305655e-08,1,6.623015025297718e-08,5.49335581467858e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i20,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i20,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i20,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i20,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	i25=new("Part",i2,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1141.0794677734375,-21.400882720947266,473.528564453125,6.177397260387352e-09,-6.315859479855135e-08,-1,-1.9952237551024155e-07,1,-6.315859479855135e-08,1,1.9952237551024155e-07,6.177385269978686e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i25,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i25,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i25,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i25,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i25,{Name="Fire",Pitch=7,PlaybackSpeed=7,SoundId="rbxassetid://620600621",Volume=0.30000001192092896})
	i31=new("Folder",i2,{Name="Settings"})
	new("IntValue",i31,{Name="Recoil"})
	new("IntValue",i31,{Name="StoredAmmo",Value=17})
	new("IntValue",i31,{Name="Mag",Value=10})
	new("BoolValue",i31,{Name="Auto",Value=t})
	new("NumberValue",i31,{Name="FireRate",Value=0.05})
	new("IntValue",i31,{Name="FireMode",Value=2})
	new("BoolValue",i31,{Name="CanSelectFire"})
	new("IntValue",i31,{Name="Ammo",Value=17})
	new("IntValue",i31,{Name="AimZoom",Value=35})
	new("IntValue",i31,{Name="Drop",Value=135})
	new("IntValue",i31,{Name="CycleZoom",Value=50})
	new("StringValue",i31,{Name="RifleOrPistol",Value="pistol"})
	new("BoolValue",i31,{Name="IsGun",Value=t})
	new("IntValue",i31,{Name="ShotCount",Value=1})
	new("StringValue",i31,{Name="Rarity",Value="legendary"})
	new("BoolValue",i31,{Name="Dismember"})
	new("StringValue",i31,{Name="AmmoType",Value="pistol"})
	new("Part",i2,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(1003),CFrame=cf(-1139.2950439453125,-20.706180572509766,473.51708984375,1,0,0,0,1,0,0,0,1),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Size=v3(1.4199999570846558,0.05000000074505806,0.14000000059604645),TopSurface=10})
	new("WedgePart",i2,{Anchored=t,BottomSurface=10,BrickColor=bc(1003),CFrame=cf(-1139.2947998046875,-20.707035064697266,473.4225769042969,1,0,0,0,1,0,0,0,1),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Size=v3(1.4199999570846558,0.05000000074505806,0.05000000074505806),TopSurface=10})
	new("Part",i2,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(1003),CFrame=cf(-1139.2950439453125,-20.826295852661133,473.51708984375,1,0,0,0,1,0,0,0,1),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Size=v3(1.42000150680542,0.18999998271465302,0.23999997973442078),TopSurface=10})
	new("WedgePart",i2,{Anchored=t,BottomSurface=10,BrickColor=bc(1003),CFrame=cf(-1139.2947998046875,-20.707035064697266,473.611572265625,-1,0,0,0,1,0,0,0,-1),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(180,0,180),Size=v3(1.4199999570846558,0.05000000074505806,0.05000000074505806),TopSurface=10})
	new("WedgePart",i2,{Anchored=t,BottomSurface=10,BrickColor=bc(1003),CFrame=cf(-1139.2947998046875,-20.9403133392334,473.4225769042969,-1,0,0,0,-1,0,0,0,1),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(0,0,180),Size=v3(1.4199999570846558,0.05000000074505806,0.05000000074505806),TopSurface=10})
	new("Part",i2,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(1003),CFrame=cf(-1139.2950439453125,-20.941164016723633,473.51708984375,1,0,0,0,-1,0,0,0,-1),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(180,0,0),Size=v3(1.4199999570846558,0.05000000074505806,0.14000000059604645),TopSurface=10})
	new("WedgePart",i2,{Anchored=t,BottomSurface=10,BrickColor=bc(1003),CFrame=cf(-1139.2947998046875,-20.9403133392334,473.611572265625,1,0,0,0,-1,0,0,0,-1),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(180,0,0),Size=v3(1.4199999570846558,0.05000000074505806,0.05000000074505806),TopSurface=10})
	new("Part",i2,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1140.7845458984375,-20.786991119384766,473.6004333496094,1,0,0,0,1,0,0,0,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i57=new("Model",i1,{Name="AKM"})
	i58=new("Folder",i57,{Name="Settings"})
	new("IntValue",i58,{Name="Recoil",Value=1})
	new("IntValue",i58,{Name="StoredAmmo",Value=31})
	new("IntValue",i58,{Name="Mag",Value=6})
	new("BoolValue",i58,{Name="Auto",Value=t})
	new("NumberValue",i58,{Name="FireRate",Value=0.1})
	new("IntValue",i58,{Name="FireMode",Value=1})
	new("BoolValue",i58,{Name="CanSelectFire",Value=t})
	new("IntValue",i58,{Name="Ammo",Value=31})
	new("IntValue",i58,{Name="AimZoom",Value=35})
	new("IntValue",i58,{Name="Drop",Value=135})
	new("IntValue",i58,{Name="CycleZoom",Value=50})
	new("StringValue",i58,{Name="RifleOrPistol"})
	new("BoolValue",i58,{Name="IsGun",Value=t})
	new("IntValue",i58,{Name="ShotCount",Value=1})
	new("StringValue",i58,{Name="Rarity",Value="legendary"})
	new("BoolValue",i58,{Name="Dismember"})
	new("StringValue",i58,{Name="AmmoType",Value="rifle"})
	i76=new("Part",i57,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1142.027587890625,-21.0954647064209,467.829833984375,6.177397260387352e-09,-6.315859479855135e-08,-1,-1.9952237551024155e-07,1,-6.315859479855135e-08,1,1.9952237551024155e-07,6.177385269978686e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i76,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i76,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i76,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i76,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i76,{Name="Fire",Pitch=0.800000011920929,PlaybackSpeed=0.800000011920929,SoundId="rbxassetid://620716624",Volume=4})
	i82=new("Part",i57,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1138.5604248046875,-20.3746395111084,467.81689453125,5.493356169949948e-08,-3.335593135034287e-08,-1,-6.623014314754982e-08,1,-3.335593490305655e-08,1,6.623015025297718e-08,5.49335581467858e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i82,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i82,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i82,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i82,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	new("Part",i57,{Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1142.8577880859375,-20.078739166259766,467.762939453125,-0.00003266368730692193,0.00008631723176222295,-1,0.00004316046033636667,1,0.0000863158202264458,1,-0.00004315764090279117,-0.00003266741259722039),Material=272,Rotation=v3(-0.0020000000949949026,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i88=new("Part",i57,{Name="Union",Anchored=t,BrickColor=bc(26),CFrame=cf(-1139.7655029296875,-20.306888580322266,467.76611328125,1,0,0,0,1,0,0,0,1),Size=v3(2.5221219062805176,0.4148099422454834,0.21613676846027374)})
	new("IntValue",i88,{Name="Slot2"})
	new("FileMesh",i88,{MeshId="rbxassetid://449042001"})
	i91=new("Part",i57,{Name="Union",Anchored=t,BrickColor=bc(339),CFrame=cf(-1142.4486083984375,-20.929811477661133,467.76416015625,1,0,0,0,1,0,0,0,1),Size=v3(0.44003403186798096,0.6818369626998901,0.20000000298023224)})
	new("IntValue",i91,{Name="Slot1"})
	new("FileMesh",i91,{MeshId="rbxassetid://449036904"})
	i94=new("Part",i57,{Name="Union",Anchored=t,BrickColor=bc(339),CFrame=cf(-1142.1015625,-20.542848587036133,467.76611328125,1,0,0,0,1,0,0,0,1),Material=1312,Size=v3(4.130189895629883,0.890999972820282,0.26799970865249634)})
	new("IntValue",i94,{Name="Slot1"})
	new("FileMesh",i94,{MeshId="rbxassetid://449036123"})
	i97=new("Part",i57,{Name="Union",Anchored=t,BrickColor=bc(26),CFrame=cf(-1142.5985107421875,-20.563846588134766,467.76611328125,1,0,0,0,1,0,0,0,1),Size=v3(3.1700692176818848,0.8556529879570007,0.2670409083366394)})
	new("IntValue",i97,{Name="Slot2"})
	new("FileMesh",i97,{MeshId="rbxassetid://449030747"})
	i100=new("Part",i57,{Name="Union",Anchored=t,BrickColor=bc(26),CFrame=cf(-1139.9495849609375,-20.272829055786133,467.76611328125,1,0,0,0,1,0,0,0,1),Size=v3(2.5022189617156982,0.43007004261016846,0.20000000298023224)})
	new("FileMesh",i100,{MeshId="rbxassetid://449043388"})
	i102=new("Part",i57,{Name="Union",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1141.0985107421875,-20.4510555267334,467.776123046875,1,0,0,0,1,0,0,0,1),Size=v3(3.034830093383789,0.602889895439148,0.22857391834259033)})
	new("FileMesh",i102,{MeshId="rbxassetid://450793522"})
	new("Part",i57,{Name="Trigger",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1142.0716552734375,-20.619022369384766,467.7631530761719,-0.00003266368730692193,0.00008631723176222295,-1,0.00004316046033636667,1,0.0000863158202264458,1,-0.00004315764090279117,-0.00003266741259722039),Material=272,Rotation=v3(-0.0020000000949949026,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i105=new("Part",i57,{Name="Mag",Anchored=t,BrickColor=bc(26),CFrame=cf(-1141.2615966796875,-21.043827056884766,467.7630615234375,1,0,0,0,1,0,0,0,1),Size=v3(0.9666252136230469,1.352288842201233,0.20000000298023224)})
	new("IntValue",i105,{Name="Slot2"})
	new("FileMesh",i105,{MeshId="rbxassetid://449031661"})
	new("Part",i57,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1141.3870849609375,-20.2921199798584,467.9022216796875,1,0,0,0,1,0,0,0,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i109=new("Model",i1,{Name="Glock 17"})
	i110=new("Part",i109,{Name="Mag",Anchored=t,BrickColor=bc(26),CFrame=cf(-1141.1063232421875,-21.297489166259766,478.0308837890625,-0.00020528057939372957,-0.0000863395762280561,-1,-0.000215802327147685,1,-0.00008629527292214334,1,0.00021578460291493684,-0.00020529920584522188),Rotation=v3(0.012000000104308128,-90,0),Size=v3(0.21600341796875,0.8493061065673828,0.5209999084472656)})
	new("FileMesh",i110,{MeshId="rbxassetid://481035376"})
	i112=new("Part",i109,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1140.4918212890625,-20.9483699798584,478.031005859375,-0.00020528057939372957,-0.0000863395762280561,-1,-0.000215802327147685,1,-0.00008629527292214334,1,0.00021578460291493684,-0.00020529920584522188),Rotation=v3(0.012000000104308128,-90,0),Size=v3(0.21600341796875,0.44669008255004883,0.9895000457763672)})
	new("FileMesh",i112,{MeshId="rbxassetid://481035315"})
	i114=new("Part",i109,{Name="Bolt",Anchored=t,BrickColor=bc(26),CFrame=cf(-1140.6893310546875,-20.841432571411133,478.031005859375,-0.00020528057939372957,-0.0000863395762280561,-1,-0.000215802327147685,1,-0.00008629527292214334,1,0.00021578460291493684,-0.00020529920584522188),Rotation=v3(0.012000000104308128,-90,0),Size=v3(0.209991455078125,0.2505002021789551,1.3650007247924805)})
	new("IntValue",i114,{Name="Slot2"})
	new("FileMesh",i114,{MeshId="rbxassetid://481035475"})
	i117=new("Part",i109,{Name="MeshPart",Anchored=t,BrickColor=bc(356),CFrame=cf(-1140.7064208984375,-21.272462844848633,478.031005859375,-0.00020528057939372957,-0.0000863395762280561,-1,-0.000215802327147685,1,-0.00008629527292214334,1,0.00021578460291493684,-0.00020529920584522188),Rotation=v3(0.012000000104308128,-90,0),Size=v3(0.20000000298023224,0.8009422421455383,1.3920001983642578)})
	new("IntValue",i117,{Name="Slot1"})
	new("FileMesh",i117,{MeshId="rbxassetid://481035241"})
	i120=new("Part",i109,{Name="Iron",Anchored=t,BrickColor=bc(26),CFrame=cf(-1140.6805419921875,-20.71435546875,478.0341796875,-0.00020528057939372957,-0.0000863395762280561,-1,-0.000215802327147685,1,-0.00008629527292214334,1,0.00021578460291493684,-0.00020529920584522188),Rotation=v3(0.012000000104308128,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,1.2635993957519531)})
	new("FileMesh",i120,{MeshId="rbxassetid://481035435"})
	new("Part",i109,{Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1142.9759521484375,-20.690433502197266,478.0338134765625,-0.00017456611385568976,-0.00017453292093705386,-1,0,1,-0.00017453292093705386,1,-3.046753249691392e-08,-0.00017456611385568976),FrontSurface=6,Material=1088,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Part",i109,{Name="Trigger",Anchored=t,BottomSurface=0,BrickColor=bc(199),CFrame=cf(-1140.7998046875,-21.07007598876953,478.0343017578125,-0.0003780003171414137,-0.000043203785025980324,-1,-0.000258953426964581,1,-0.000043105901568196714,0.9999998807907104,0.00025893712881952524,-0.00037801155121997),Material=1088,Rotation=v3(0.014999999664723873,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i124=new("Part",i109,{Name="BoltBack",Anchored=t,BrickColor=bc(26),CFrame=cf(-1141.0809326171875,-20.841432571411133,478.031005859375,-0.00020528057939372957,-0.0000863395762280561,-1,-0.000215802327147685,1,-0.00008629527292214334,1,0.00021578460291493684,-0.00020529920584522188),Rotation=v3(0.012000000104308128,-90,0),Size=v3(0.209991455078125,0.2505002021789551,1.3650007247924805),Transparency=1})
	new("IntValue",i124,{Name="Slot2"})
	new("FileMesh",i124,{MeshId="rbxassetid://481035475"})
	i127=new("Part",i109,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1139.8924560546875,-20.7747859954834,478.0323486328125,5.493356169949948e-08,-3.335593135034287e-08,-1,-6.623014314754982e-08,1,-3.335593490305655e-08,1,6.623015025297718e-08,5.49335581467858e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i127,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i127,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i127,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i127,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	i132=new("Part",i109,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1141.0804443359375,-21.40185546875,478.0452880859375,6.177397260387352e-09,-6.315859479855135e-08,-1,-1.9952237551024155e-07,1,-6.315859479855135e-08,1,1.9952237551024155e-07,6.177385269978686e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i132,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i132,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i132,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i132,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i132,{Name="Fire",SoundId="rbxassetid://620600621",Volume=1})
	i138=new("Folder",i109,{Name="Settings"})
	new("IntValue",i138,{Name="Recoil",Value=1})
	new("IntValue",i138,{Name="StoredAmmo",Value=17})
	new("IntValue",i138,{Name="Mag",Value=10})
	new("BoolValue",i138,{Name="Auto",Value=t})
	new("NumberValue",i138,{Name="FireRate",Value=0.05})
	new("IntValue",i138,{Name="FireMode",Value=2})
	new("BoolValue",i138,{Name="CanSelectFire"})
	new("IntValue",i138,{Name="Ammo",Value=17})
	new("IntValue",i138,{Name="AimZoom",Value=35})
	new("IntValue",i138,{Name="Drop",Value=135})
	new("IntValue",i138,{Name="CycleZoom",Value=50})
	new("StringValue",i138,{Name="RifleOrPistol",Value="pistol"})
	new("BoolValue",i138,{Name="IsGun",Value=t})
	new("IntValue",i138,{Name="ShotCount",Value=1})
	new("StringValue",i138,{Name="Rarity",Value="uncommon"})
	new("BoolValue",i138,{Name="Dismember"})
	new("StringValue",i138,{Name="AmmoType",Value="pistol"})
	new("Part",i109,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1140.7283935546875,-20.849124908447266,478.088623046875,1,0,0,0,1,0,0,0,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i157=new("Model",i1,{Name="AG3"})
	i158=new("Folder",i157,{Name="Settings"})
	new("IntValue",i158,{Name="Recoil",Value=1})
	new("IntValue",i158,{Name="StoredAmmo",Value=21})
	new("IntValue",i158,{Name="Mag",Value=6})
	new("BoolValue",i158,{Name="Dismember",Value=t})
	new("NumberValue",i158,{Name="FireRate",Value=0.12})
	new("IntValue",i158,{Name="FireMode",Value=1})
	new("BoolValue",i158,{Name="CanSelectFire",Value=t})
	new("IntValue",i158,{Name="Ammo",Value=21})
	new("IntValue",i158,{Name="AimZoom",Value=10})
	new("IntValue",i158,{Name="Drop",Value=70})
	new("IntValue",i158,{Name="CycleZoom",Value=50})
	new("StringValue",i158,{Name="RifleOrPistol"})
	new("BoolValue",i158,{Name="IsGun",Value=t})
	new("IntValue",i158,{Name="ShotCount",Value=1})
	new("StringValue",i158,{Name="Rarity",Value="rare"})
	new("BoolValue",i158,{Name="Auto",Value=t})
	new("StringValue",i158,{Name="AmmoType",Value="rifle"})
	i176=new("Part",i157,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1140.3118896484375,-21.337406158447266,474.9638671875,6.177397260387352e-09,-6.315859479855135e-08,-1,-1.9952237551024155e-07,1,-6.315859479855135e-08,1,1.9952237551024155e-07,6.177385269978686e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i176,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i176,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i176,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i176,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i176,{Name="Fire",Pitch=0.8999999761581421,PlaybackSpeed=0.8999999761581421,SoundId="rbxassetid://620716624",Volume=4})
	i182=new("Part",i157,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1135.5828857421875,-20.616455078125,474.849365234375,5.493356169949948e-08,-3.335593135034287e-08,-1,-6.623014314754982e-08,1,-3.335593490305655e-08,1,6.623015025297718e-08,5.49335581467858e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i182,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i182,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i182,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i182,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	i187=new("Part",i157,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1141.7791748046875,-20.8323974609375,474.8814697265625,1,0,0,0,1,0,0,0,1),Size=v3(2.0939979553222656,0.676516056060791,0.23699951171875)})
	new("FileMesh",i187,{MeshId="rbxassetid://513943702"})
	new("IntValue",i187,{Name="Slot2"})
	i190=new("Part",i157,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1138.430908203125,-20.5144100189209,474.8814697265625,1,0,0,0,1,0,0,0,1),Size=v3(5.537994384765625,0.3824899196624756,0.23400115966796875)})
	new("FileMesh",i190,{MeshId="rbxassetid://513942634"})
	new("IntValue",i190,{Name="Slot1"})
	i193=new("Part",i157,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1138.8714599609375,-20.5144100189209,474.8814697265625,1,0,0,0,1,0,0,0,1),Size=v3(3.8426055908203125,0.48904699087142944,0.2971038818359375)})
	new("FileMesh",i193,{MeshId="rbxassetid://513946062"})
	new("IntValue",i193,{Name="Slot1"})
	i196=new("Part",i157,{Name="Iron",Anchored=t,BrickColor=bc(26),CFrame=cf(-1138.9412841796875,-20.252323150634766,474.8804931640625,1,0,0,0,1,0,0,0,1),Size=v3(4.246498107910156,0.2808799743652344,0.20999908447265625)})
	new("FileMesh",i196,{MeshId="rbxassetid://513944430"})
	i198=new("Part",i157,{Name="Bolt",Anchored=t,BrickColor=bc(199),CFrame=cf(-1138.7161865234375,-20.438356399536133,474.8575439453125,1,0,0,0,1,0,0,0,1),Size=v3(2.3819961547851562,0.22051000595092773,0.25830078125)})
	new("FileMesh",i198,{MeshId="rbxassetid://513944140"})
	i200=new("Part",i157,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1139.0032958984375,-21.0394287109375,474.8814697265625,1,0,0,0,1,0,0,0,1),Size=v3(4.035102844238281,1.1894668340682983,0.24599456787109375)})
	new("FileMesh",i200,{MeshId="rbxassetid://513948583"})
	new("IntValue",i200,{Name="Slot2"})
	i203=new("Part",i157,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1140.486083984375,-20.952396392822266,474.8814697265625,1,0,0,0,1,0,0,0,1),Size=v3(1.510498046875,0.46836698055267334,0.207000732421875)})
	new("FileMesh",i203,{MeshId="rbxassetid://513949056"})
	i205=new("Part",i157,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1141.2303466796875,-20.56641387939453,474.8814697265625,1,0,0,0,1,0,0,0,1),Size=v3(0.444000244140625,0.49802500009536743,0.25800323486328125)})
	new("FileMesh",i205,{MeshId="rbxassetid://513940392"})
	new("IntValue",i205,{Name="Slot1"})
	i208=new("Part",i157,{Name="Mag",Anchored=t,BrickColor=bc(26),CFrame=cf(-1139.5863037109375,-21.145383834838867,474.8814697265625,1,0,0,0,1,0,0,0,1),Size=v3(0.5611038208007812,1.1492284536361694,0.20000000298023224)})
	new("FileMesh",i208,{MeshId="rbxassetid://513946408"})
	new("IntValue",i208,{Name="Slot2"})
	new("Part",i157,{Name="SightMark",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1136.8343505859375,-20.2080135345459,474.8802490234375,-0.000032782889320515096,0.00004317675484344363,-1,0.0008631727541796863,0.9999996423721313,0.00004314844045438804,0.9999996423721313,-0.0008631713571958244,-0.00003282014586147852),Material=1088,Rotation=v3(-0.04899999871850014,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Part",i157,{Name="Trigger",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1140.3450927734375,-20.985963821411133,474.8802490234375,-0.000032782889320515096,0.00004317675484344363,-1,0.0008631727541796863,0.9999996423721313,0.00004314844045438804,0.9999996423721313,-0.0008631713571958244,-0.00003282014586147852),Material=1088,Rotation=v3(-0.04899999871850014,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Part",i157,{Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(1031),CFrame=cf(-1141.5223388671875,-20.1650390625,474.878662109375,-0.00003266368730692193,-0.00012947444338351488,-1,-2.7939970337342857e-09,1,-0.00012947444338351488,1,-1.4351155819269934e-09,-0.00003266368730692193),Material=272,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i214=new("Part",i157,{Name="SightMark",Anchored=t,BottomSurface=0,BrickColor=bc(1031),CFrame=cf(-1140.2327880859375,-20.164798736572266,474.878662109375,-0.00003266368730692193,-0.00012947444338351488,-1,-2.7939970337342857e-09,1,-0.00012947444338351488,1,-1.4351155819269934e-09,-0.00003266368730692193),Material=272,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i215=new("SurfaceGui",i214,{Face=2})
	new("ImageLabel",i215,{BackgroundColor3=c3(1,1,1),BackgroundTransparency=1,BorderColor3=c3(1,1,1),Position=ud2(-0.25,0,-0.25,0),Size=ud2(1.5,0,1.5,0),Image="http://www.roblox.com/asset/?id=238761534"})
	i217=new("Part",i157,{Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1140.2313232421875,-20.2104549407959,474.880615234375,-1,0,0,0,1,0,0,0,-1),Rotation=v3(180,0,180),Size=v3(0.5,0.22999998927116394,0.24999988079071045),TopSurface=0})
	new("SpecialMesh",i217,{MeshId="rbxassetid://2025231052",MeshType=5})
	i219=new("Part",i157,{Name="BoltBack",Anchored=t,BrickColor=bc(199),CFrame=cf(-1139.9827880859375,-20.438356399536133,474.8575439453125,1,0,0,0,1,0,0,0,1),Size=v3(2.3819961547851562,0.22051000595092773,0.25830078125),Transparency=1})
	new("FileMesh",i219,{MeshId="rbxassetid://513944140"})
	new("Part",i157,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1139.6419677734375,-20.473390579223633,474.9814453125,1,0,0,0,1,0,0,0,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i222=new("Model",i1,{Name="M200 Intervention"})
	i223=new("Folder",i222,{Name="Settings"})
	new("IntValue",i223,{Name="Recoil",Value=1})
	new("IntValue",i223,{Name="StoredAmmo",Value=10})
	new("IntValue",i223,{Name="Mag",Value=6})
	new("BoolValue",i223,{Name="Auto"})
	new("NumberValue",i223,{Name="FireRate",Value=0.067})
	new("IntValue",i223,{Name="FireMode",Value=4})
	new("BoolValue",i223,{Name="CanSelectFire"})
	new("IntValue",i223,{Name="ShotCount",Value=1})
	new("IntValue",i223,{Name="AimZoom",Value=6})
	new("IntValue",i223,{Name="Drop",Value=135})
	new("IntValue",i223,{Name="CycleZoom",Value=50})
	new("StringValue",i223,{Name="RifleOrPistol"})
	new("BoolValue",i223,{Name="IsGun",Value=t})
	new("IntValue",i223,{Name="Ammo",Value=10})
	new("StringValue",i223,{Name="Rarity",Value="mythical"})
	new("BoolValue",i223,{Name="Dismember",Value=t})
	new("StringValue",i223,{Name="AmmoType",Value="rifle"})
	i241=new("Part",i222,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1140.4539794921875,-21.39234161376953,488.1019287109375,6.177397260387352e-09,-6.315859479855135e-08,-1,-1.9952237551024155e-07,1,-6.315859479855135e-08,1,1.9952237551024155e-07,6.177385269978686e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i241,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i241,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i241,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i241,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i241,{Name="Fire",Pitch=1.2000000476837158,PlaybackSpeed=1.2000000476837158,SoundId="rbxassetid://725750543",Volume=4})
	new("Sound",i241,{Name="M1",SoundId="rbxassetid://873042054"})
	new("Sound",i241,{Name="M2",Pitch=0.699999988079071,PlaybackSpeed=0.699999988079071,SoundId="rbxassetid://873042054"})
	i249=new("Part",i222,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1135.3973388671875,-20.62146759033203,488.0889892578125,5.493356169949948e-08,-3.335593135034287e-08,-1,-6.623014314754982e-08,1,-3.335593490305655e-08,1,6.623015025297718e-08,5.49335581467858e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i249,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i249,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i249,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i249,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	i254=new("Part",i222,{Name="AimPart",Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(307),CFrame=cf(-1140.944580078125,-20.267946243286133,488.141845703125,0,0,-1,0,1,0,1,0,0),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(0,-90,0),Size=v3(0.09173646569252014,0.07488705217838287,0.07894076406955719),TopSurface=10,Transparency=1})
	new("BlockMesh",i254)
	i256=new("Part",i222,{Name="Fade",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1140.889404296875,-20.267459869384766,488.1424560546875,-1,0,0,0,1,0,0,0,-1),Material=288,Rotation=v3(180,0,180),Size=v3(0.05000000074505806,0.21891142427921295,0.21891139447689056),TopSurface=0,Transparency=0.699999988079071,FormFactor=3})
	new("SpecialMesh",i256,{Scale=v3(0.24323450028896332,1,1),MeshType=4})
	new("Decal",i256,{Face=0,Texture="http://www.roblox.com/asset/?id=286537017"})
	new("Decal",i256,{Face=0,Texture="http://www.roblox.com/asset/?id=286537017"})
	new("Decal",i256,{Face=0,Texture="http://www.roblox.com/asset/?id=286537017"})
	i261=new("Part",i222,{Name="Reticle",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1139.5716552734375,-20.268190383911133,488.14208984375,-1,0,0,0,1,0,0,0,-1),Material=288,Rotation=v3(180,0,180),Size=v3(0.05000000074505806,0.21891142427921295,0.21891139447689056),TopSurface=0,Transparency=0.699999988079071,FormFactor=3})
	new("SpecialMesh",i261,{Scale=v3(0.24323450028896332,1,1),MeshType=4})
	new("Decal",i261,{Face=0,Texture="http://www.roblox.com/asset/?id=303556559"})
	new("Decal",i261,{Face=0,Texture="http://www.roblox.com/asset/?id=303556559"})
	new("Decal",i261,{Face=0,Texture="http://www.roblox.com/asset/?id=303556559"})
	new("Decal",i261,{Face=0,Texture="http://www.roblox.com/asset/?id=303556559"})
	new("Decal",i261,{Face=0,Texture="http://www.roblox.com/asset/?id=303556559"})
	new("Decal",i261,{Face=0,Texture="http://www.roblox.com/asset/?id=303556559"})
	new("Decal",i261,{Face=0,Texture="http://www.roblox.com/asset/?id=303556559"})
	new("Decal",i261,{Face=0,Texture="http://www.roblox.com/asset/?id=303556559"})
	new("Decal",i261,{Face=0,Texture="http://www.roblox.com/asset/?id=303556559"})
	new("Decal",i261,{Face=0,Texture="http://www.roblox.com/asset/?id=303556559"})
	new("Part",i222,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(26),CFrame=cf(-1140.4217529296875,-20.419189453125,488.142578125,-1,0,0,0,1,0,0,0,-1),Material=272,Rotation=v3(180,0,180),Size=v3(0.05000000074505806,0.15000000596046448,0.05000000074505806),TopSurface=0})
	new("Part",i222,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(26),CFrame=cf(-1140.0135498046875,-20.419189453125,488.142578125,-1,0,0,0,1,0,0,0,-1),Material=272,Rotation=v3(180,0,180),Size=v3(0.05000000074505806,0.15000000596046448,0.05000000074505806),TopSurface=0})
	i275=new("Part",i222,{Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1140.2283935546875,-20.234256744384766,488.142578125,-1,0,0,0,1,0,0,0,-1),Material=272,Rotation=v3(180,0,180),Size=v3(1.3569999933242798,0.3100000023841858,0.24400000274181366),TopSurface=0})
	new("SpecialMesh",i275,{MeshId="rbxassetid://2029156429",MeshType=5})
	i277=new("Part",i222,{Name="BoltBack",Anchored=t,BrickColor=bc(302),CFrame=cf(-1141.2391357421875,-20.761966705322266,488.2657470703125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.2194023132324219,0.5263880491256714,0.5116958618164062),Transparency=1})
	new("IntValue",i277,{Name="Slot2"})
	new("FileMesh",i277,{MeshId="rbxassetid://476845700"})
	new("Part",i222,{Name="Trigger",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1140.7420654296875,-21.029787063598633,488.140625,-0.00003266368730692193,0.00008631723176222295,-1,0.00004316046033636667,1,0.0000863158202264458,1,-0.00004315764090279117,-0.00003266741259722039),Material=1088,Rotation=v3(-0.0020000000949949026,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i281=new("Part",i222,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1141.4725341796875,-20.9720516204834,488.1378173828125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.7784004211425781,0.9776029586791992,0.39520263671875)})
	new("IntValue",i281,{Name="Slot2"})
	new("FileMesh",i281,{MeshId="rbxassetid://476846701"})
	i284=new("Part",i222,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1140.0716552734375,-21.0090389251709,488.1378173828125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(2.7220993041992188,1.1390290260314941,0.40560150146484375)})
	new("IntValue",i284,{Name="Slot1"})
	new("FileMesh",i284,{MeshId="rbxassetid://476845473"})
	i287=new("Part",i222,{Name="MeshPart",Anchored=t,BrickColor=bc(302),CFrame=cf(-1137.8387451171875,-20.6409969329834,488.1378173828125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(4.080699920654297,0.20000000298023224,0.20000000298023224)})
	new("IntValue",i287,{Name="Slot2"})
	new("FileMesh",i287,{MeshId="rbxassetid://476846898"})
	i290=new("Part",i222,{Name="Bolt",Anchored=t,BrickColor=bc(302),CFrame=cf(-1140.5345458984375,-20.761966705322266,488.2657470703125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.2194023132324219,0.5263880491256714,0.5116958618164062)})
	new("IntValue",i290,{Name="Slot2"})
	new("FileMesh",i290,{MeshId="rbxassetid://476845700"})
	i293=new("Part",i222,{Name="Mag",Anchored=t,BrickColor=bc(302),CFrame=cf(-1140.2684326171875,-21.187015533447266,488.1378173828125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(0.6291999816894531,0.6642233729362488,0.20000000298023224)})
	new("IntValue",i293,{Name="Slot2"})
	new("FileMesh",i293,{MeshId="rbxassetid://476848610"})
	i296=new("Part",i222,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1138.7606201171875,-20.679935455322266,488.1378173828125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.7211990356445312,0.38480204343795776,0.30680084228515625)})
	new("IntValue",i296,{Name="Slot1"})
	new("FileMesh",i296,{MeshId="rbxassetid://476846954"})
	new("Part",i222,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1140.2635498046875,-20.6019287109375,488.2469482421875,1,0,0,0,1,0,0,0,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i300=new("Model",i1,{Name="Glock 18"})
	i301=new("Folder",i300,{Name="Settings"})
	new("IntValue",i301,{Name="Recoil",Value=1})
	new("IntValue",i301,{Name="StoredAmmo",Value=17})
	new("IntValue",i301,{Name="Mag",Value=10})
	new("BoolValue",i301,{Name="Auto",Value=t})
	new("NumberValue",i301,{Name="FireRate",Value=0.05})
	new("IntValue",i301,{Name="FireMode",Value=1})
	new("BoolValue",i301,{Name="CanSelectFire",Value=t})
	new("IntValue",i301,{Name="Ammo",Value=17})
	new("IntValue",i301,{Name="AimZoom",Value=35})
	new("IntValue",i301,{Name="Drop",Value=135})
	new("IntValue",i301,{Name="CycleZoom",Value=50})
	new("StringValue",i301,{Name="RifleOrPistol",Value="pistol"})
	new("BoolValue",i301,{Name="IsGun",Value=t})
	new("IntValue",i301,{Name="ShotCount",Value=1})
	new("StringValue",i301,{Name="Rarity",Value="uncommon"})
	new("BoolValue",i301,{Name="Dismember"})
	new("StringValue",i301,{Name="AmmoType",Value="pistol"})
	new("Part",i300,{Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1144.4232177734375,-20.661378860473633,461.39306640625,-0.00003099999958067201,0.00009300000237999484,-1,-0.000029999999242136255,1,0.00009300093370256945,1,0.000030002882340340875,-0.00003099720925092697),FrontSurface=6,Material=272,Rotation=v3(0.0020000000949949026,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i320=new("Part",i300,{Name="Bolt",Anchored=t,BrickColor=bc(26),CFrame=cf(-1142.1761474609375,-20.828739166259766,461.3902587890625,1,-4.440892098500626e-16,0,-4.440892098500626e-16,1,5.860130631619997e-13,0,5.860130631619997e-13,1),Size=v3(1.376420021057129,0.2527039647102356,0.212005615234375)})
	new("FileMesh",i320,{MeshId="rbxassetid://513916898"})
	new("IntValue",i320,{Name="Slot2"})
	i323=new("Part",i300,{Name="BoltBack",Anchored=t,BrickColor=bc(26),CFrame=cf(-1142.4183349609375,-20.828739166259766,461.3902587890625,1,-4.440892098500626e-16,0,-4.440892098500626e-16,1,5.860130631619997e-13,0,5.860130631619997e-13,1),Size=v3(1.376420021057129,0.2527039647102356,0.212005615234375),Transparency=1})
	new("FileMesh",i323,{MeshId="rbxassetid://513916898"})
	new("IntValue",i323,{Name="Slot2"})
	i326=new("Part",i300,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1141.3714599609375,-20.7734432220459,461.3897705078125,5.493356169949948e-08,-3.335593135034287e-08,-1,-6.623014314754982e-08,1,-3.335593490305655e-08,1,6.623015025297718e-08,5.49335581467858e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i326,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i326,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i326,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i326,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	i331=new("Part",i300,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1142.5589599609375,-21.4005126953125,461.4027099609375,6.177397260387352e-09,-6.315859479855135e-08,-1,-1.9952237551024155e-07,1,-6.315859479855135e-08,1,1.9952237551024155e-07,6.177385269978686e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i331,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i331,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i331,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i331,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i331,{Name="Fire",SoundId="rbxassetid://620600621",Volume=1})
	i337=new("Part",i300,{Name="Mag",Anchored=t,BrickColor=bc(26),CFrame=cf(-1142.5941162109375,-21.291751861572266,461.3902587890625,1,0,0,0,1,0,0,0,1),Size=v3(0.5255098342895508,0.8563991189002991,0.2180023193359375)})
	new("FileMesh",i337,{MeshId="rbxassetid://513913227"})
	i339=new("Part",i300,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1141.9735107421875,-20.9367733001709,461.3902587890625,1,0,0,0,1,0,0,0,1),Size=v3(0.9977502822875977,0.45041704177856445,0.2180023193359375)})
	new("FileMesh",i339,{MeshId="rbxassetid://513912436"})
	i341=new("Part",i300,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1142.1663818359375,-20.701784133911133,461.393310546875,1,-5.4569682106375694e-12,-7.275957614183426e-12,-5.4569682106375694e-12,1,0,-7.275957614183426e-12,0,1),Size=v3(1.2741799354553223,0.20000000298023224,0.20000000298023224)})
	new("FileMesh",i341,{MeshId="rbxassetid://513913625"})
	i343=new("Part",i300,{Name="MeshPart",Anchored=t,BrickColor=bc(363),CFrame=cf(-1142.1922607421875,-21.263795852661133,461.3902587890625,1,0,0,0,1,0,0,0,1),Size=v3(1.4036900997161865,0.8076530694961548,0.20000000298023224)})
	new("FileMesh",i343,{MeshId="rbxassetid://513912863"})
	new("IntValue",i343,{Name="Slot1"})
	i346=new("Part",i300,{Name="MeshPart",Anchored=t,BottomSurface=0,BrickColor=bc(199),CFrame=cf(-1142.3026123046875,-21.0715389251709,461.3931884765625,-0.00003266368730692193,0.0000863153618411161,-1,-0.000043156738684047014,1,0.00008631677337689325,1,0.00004315955811762251,-0.00003265996201662347),Material=272,Rotation=v3(0.0020000000949949026,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("BlockMesh",i346,{Scale=v3(0.25,0.6666666865348816,0.25)})
	new("Part",i300,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1142.2342529296875,-20.8385066986084,461.4888916015625,1,0,0,0,1,0,0,0,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i349=new("Model",i1,{Name="M9"})
	i350=new("Folder",i349,{Name="Settings"})
	new("IntValue",i350,{Name="Recoil",Value=1})
	new("IntValue",i350,{Name="StoredAmmo",Value=17})
	new("IntValue",i350,{Name="Mag",Value=6})
	new("BoolValue",i350,{Name="Auto",Value=t})
	new("NumberValue",i350,{Name="FireRate",Value=0.05})
	new("IntValue",i350,{Name="FireMode",Value=2})
	new("BoolValue",i350,{Name="CanSelectFire"})
	new("IntValue",i350,{Name="Ammo",Value=17})
	new("IntValue",i350,{Name="AimZoom",Value=35})
	new("IntValue",i350,{Name="Drop",Value=135})
	new("IntValue",i350,{Name="CycleZoom",Value=50})
	new("StringValue",i350,{Name="RifleOrPistol",Value="pistol"})
	new("BoolValue",i350,{Name="IsGun",Value=t})
	new("IntValue",i350,{Name="ShotCount",Value=1})
	new("StringValue",i350,{Name="Rarity",Value="uncommon"})
	new("BoolValue",i350,{Name="Dismember"})
	new("StringValue",i350,{Name="AmmoType",Value="pistol"})
	i368=new("Part",i349,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1141.4564208984375,-21.55054473876953,472.190673828125,6.177397260387352e-09,-6.315859479855135e-08,-1,-1.9952237551024155e-07,1,-6.315859479855135e-08,1,1.9952237551024155e-07,6.177385269978686e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i368,{Name="Fire",Pitch=0.800000011920929,PlaybackSpeed=0.800000011920929,SoundId="rbxassetid://896335161",Volume=7})
	new("Sound",i368,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i368,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i368,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i368,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	i374=new("Part",i349,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1139.9144287109375,-20.829713821411133,472.2982177734375,5.493356169949948e-08,-3.335593135034287e-08,-1,-6.623014314754982e-08,1,-3.335593490305655e-08,1,6.623015025297718e-08,5.49335581467858e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i374,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i374,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i374,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i374,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	i379=new("Part",i349,{Name="Bolt",Anchored=t,BrickColor=bc(26),CFrame=cf(-1140.7845458984375,-20.886722564697266,472.214111328125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.4840087890625,0.2873098850250244,0.20000000298023224)})
	new("IntValue",i379,{Name="Slot1"})
	new("FileMesh",i379,{MeshId="rbxassetid://479880743"})
	i382=new("Part",i349,{Name="Mag",Anchored=t,BrickColor=bc(26),CFrame=cf(-1141.347900390625,-21.334718704223633,472.214111328125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(0.4470062255859375,0.7703932523727417,0.20000000298023224)})
	new("FileMesh",i382,{MeshId="rbxassetid://479882360"})
	i384=new("Part",i349,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1140.9202880859375,-21.3158016204834,472.214111328125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.416046142578125,0.7440066337585449,0.20000000298023224)})
	new("IntValue",i384,{Name="Slot1"})
	new("FileMesh",i384,{MeshId="rbxassetid://479882796"})
	i387=new("Part",i349,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1140.7913818359375,-21.0338134765625,472.214111328125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.54998779296875,0.49577000737190247,0.20000000298023224)})
	new("IntValue",i387,{Name="Slot2"})
	new("FileMesh",i387,{MeshId="rbxassetid://479882322"})
	i390=new("Part",i349,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1141.3514404296875,-21.333742141723633,472.214111328125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(0.3820037841796875,0.6870033144950867,0.20399856567382812)})
	new("IntValue",i390,{Name="Slot2"})
	new("FileMesh",i390,{MeshId="rbxassetid://479882341"})
	new("Part",i349,{Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1142.9261474609375,-20.75757598876953,472.214111328125,-0.00003300000025774352,0.00009200000204145908,-1,-0.000029999999242136255,1,0.00009200099157169461,1,0.000030003035135450773,-0.00003299723903182894),FrontSurface=6,Material=1088,Rotation=v3(0.0020000000949949026,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i394=new("Part",i349,{Name="Trigger",Anchored=t,BottomSurface=0,BrickColor=bc(199),CFrame=cf(-1140.9503173828125,-21.158573150634766,472.2142333984375,-0.00003266368730692193,0.0000863153618411161,-1,-0.000043156738684047014,1,0.00008631677337689325,1,0.0000431595544796437,-0.00003265996201662347),Material=1088,Rotation=v3(0.0020000000949949026,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("BlockMesh",i394,{Scale=v3(0.25,0.6666666865348816,0.25)})
	i396=new("Part",i349,{Name="BoltBack",Anchored=t,BrickColor=bc(26),CFrame=cf(-1141.1126708984375,-20.886722564697266,472.214111328125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.4840087890625,0.2873098850250244,0.20000000298023224),Transparency=1})
	new("IntValue",i396,{Name="Slot1"})
	new("FileMesh",i396,{MeshId="rbxassetid://479880743"})
	new("Part",i349,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1141.1024169921875,-20.8455810546875,472.2982177734375,1,0,0,0,1,0,0,0,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i400=new("Model",i1,{Name="SCAR-L"})
	i401=new("Folder",i400,{Name="Settings"})
	new("IntValue",i401,{Name="Recoil",Value=1})
	new("IntValue",i401,{Name="StoredAmmo",Value=30})
	new("IntValue",i401,{Name="Mag",Value=6})
	new("BoolValue",i401,{Name="Auto",Value=t})
	new("NumberValue",i401,{Name="FireRate",Value=0.067})
	new("IntValue",i401,{Name="FireMode",Value=1})
	new("BoolValue",i401,{Name="CanSelectFire",Value=t})
	new("IntValue",i401,{Name="Ammo",Value=31})
	new("IntValue",i401,{Name="AimZoom",Value=35})
	new("IntValue",i401,{Name="Drop",Value=135})
	new("IntValue",i401,{Name="CycleZoom",Value=50})
	new("StringValue",i401,{Name="RifleOrPistol"})
	new("BoolValue",i401,{Name="IsGun",Value=t})
	new("IntValue",i401,{Name="ShotCount",Value=1})
	new("StringValue",i401,{Name="Rarity",Value="rare"})
	new("BoolValue",i401,{Name="Dismember"})
	new("StringValue",i401,{Name="AmmoType",Value="rifle"})
	i419=new("Part",i400,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1139.5574951171875,-21.306888580322266,480.371337890625,6.177397260387352e-09,-6.315859479855135e-08,-1,-1.9952237551024155e-07,1,-6.315859479855135e-08,1,1.9952237551024155e-07,6.177385269978686e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i419,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i419,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i419,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i419,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i419,{Name="Fire",Pitch=0.8999999761581421,PlaybackSpeed=0.8999999761581421,SoundId="rbxassetid://620716624",Volume=4})
	i425=new("Part",i400,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1136.5433349609375,-20.672977447509766,480.3583984375,5.493356169949948e-08,-3.335593135034287e-08,-1,-6.623014314754982e-08,1,-3.335593490305655e-08,1,6.623015025297718e-08,5.49335581467858e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i425,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i425,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i425,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i425,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	i430=new("Part",i400,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1140.0404052734375,-21.2373046875,480.4053955078125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(0.5022010803222656,0.5591049194335938,0.20000000298023224)})
	new("IntValue",i430,{Name="Slot2"})
	new("FileMesh",i430,{MeshId="rbxassetid://476656976"})
	i433=new("Part",i400,{Name="MeshPart",Anchored=t,BrickColor=bc(346),CFrame=cf(-1140.5242919921875,-20.8524227142334,480.4263916015625,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(2.3065032958984375,0.9581630229949951,0.2389984130859375)})
	new("IntValue",i433,{Name="Slot1"})
	new("FileMesh",i433,{MeshId="rbxassetid://476658021"})
	i436=new("Part",i400,{Name="Mag",Anchored=t,BrickColor=bc(26),CFrame=cf(-1139.1810302734375,-21.202396392822266,480.4013671875,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(0.47550201416015625,1.0352600812911987,0.20000000298023224)})
	new("IntValue",i436,{Name="Slot2"})
	new("FileMesh",i436,{MeshId="rbxassetid://476657191"})
	i439=new("Part",i400,{Name="MeshPart",Anchored=t,BrickColor=bc(346),CFrame=cf(-1139.5521240234375,-20.9263973236084,480.37939453125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.2920913696289062,0.43731361627578735,0.22501373291015625)})
	new("IntValue",i439,{Name="Slot1"})
	new("FileMesh",i439,{MeshId="rbxassetid://476656787"})
	i442=new("Part",i400,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1139.7015380859375,-20.742435455322266,480.4423828125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(3.6944007873535156,0.750338077545166,0.3260040283203125)})
	new("FileMesh",i442,{MeshId="rbxassetid://476657765"})
	i444=new("Part",i400,{Name="MeshPart",Anchored=t,BrickColor=bc(346),CFrame=cf(-1139.0252685546875,-20.5373592376709,480.4053955078125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(2.3425979614257812,0.3406100273132324,0.20000000298023224)})
	new("IntValue",i444,{Name="Slot1"})
	new("FileMesh",i444,{MeshId="rbxassetid://476657523"})
	new("Snap",i444,{C0=cf(0,-0.1703050136566162,0,1,0,0,0,0,-1,0,1,0),C1=cf(0.52685546875,0.21871626377105713,0.0260009765625,1,0,0,0,0,-1,0,1,0)})
	i448=new("Part",i400,{Name="Bolt",Anchored=t,BrickColor=bc(26),CFrame=cf(-1139.0662841796875,-20.560426712036133,480.3564453125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(0.9595985412597656,0.24529004096984863,0.26300048828125)})
	new("FileMesh",i448,{MeshId="rbxassetid://476658422"})
	new("Snap",i448,{C0=cf(0,-0.12264502048492432,0,1,0,0,0,0,-1,0,1,0),C1=cf(0.11474609375,0.5193538069725037,-0.04499053955078125,1,0,0,0,0,-1,0,1,0)})
	i451=new("Part",i400,{Name="Iron",Anchored=t,BrickColor=bc(26),CFrame=cf(-1138.9154052734375,-20.2873592376709,480.4053955078125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(2.4299983978271484,0.39250993728637695,0.20000000298023224)})
	new("FileMesh",i451,{MeshId="rbxassetid://476660596"})
	i453=new("Part",i400,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1137.2401123046875,-20.574466705322266,480.4053955078125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.2484989166259766,0.3028099536895752,0.20000000298023224)})
	new("FileMesh",i453,{MeshId="rbxassetid://476658620"})
	new("Part",i400,{Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1140.9510498046875,-20.136232376098633,480.4056396484375,-0.00003266368730692193,0.00008631723176222295,-1,0.00004316046033636667,1,0.0000863158202264458,1,-0.00004315764090279117,-0.00003266741259722039),Material=1088,Rotation=v3(-0.0020000000949949026,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Part",i400,{Name="Trigger",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1139.6214599609375,-21.026493072509766,480.40576171875,-0.00003266368730692193,0.00008631723176222295,-1,0.00004316046033636667,1,0.0000863158202264458,1,-0.00004315764090279117,-0.00003266741259722039),Material=1088,Rotation=v3(-0.0020000000949949026,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i457=new("Part",i400,{Name="BoltBack",Anchored=t,BrickColor=bc(26),CFrame=cf(-1139.8541259765625,-20.5603084564209,480.3563232421875,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(0.9595985412597656,0.24529004096984863,0.26300048828125),Transparency=1})
	new("FileMesh",i457,{MeshId="rbxassetid://476658422"})
	new("Part",i400,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1139.2694091796875,-20.597537994384766,480.4403076171875,1,0,0,0,1,0,0,0,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i460=new("Model",i1,{Name="M16A1"})
	i461=new("Folder",i460,{Name="Settings"})
	new("IntValue",i461,{Name="Recoil",Value=1})
	new("IntValue",i461,{Name="StoredAmmo",Value=30})
	new("IntValue",i461,{Name="Mag",Value=6})
	new("BoolValue",i461,{Name="Auto",Value=t})
	new("NumberValue",i461,{Name="FireRate",Value=0.07})
	new("IntValue",i461,{Name="FireMode",Value=1})
	new("BoolValue",i461,{Name="CanSelectFire",Value=t})
	new("IntValue",i461,{Name="Ammo",Value=31})
	new("IntValue",i461,{Name="AimZoom",Value=35})
	new("IntValue",i461,{Name="Drop",Value=135})
	new("IntValue",i461,{Name="CycleZoom",Value=50})
	new("StringValue",i461,{Name="RifleOrPistol"})
	new("BoolValue",i461,{Name="IsGun",Value=t})
	new("IntValue",i461,{Name="ShotCount",Value=1})
	new("StringValue",i461,{Name="Rarity",Value="rare"})
	new("BoolValue",i461,{Name="Dismember"})
	new("StringValue",i461,{Name="AmmoType",Value="rifle"})
	i479=new("Part",i460,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1140.1639404296875,-21.21936798095703,476.3511962890625,6.177397260387352e-09,-6.315859479855135e-08,-1,-1.9952237551024155e-07,1,-6.315859479855135e-08,1,1.9952237551024155e-07,6.177385269978686e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i479,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i479,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i479,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i479,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i479,{Name="Fire",Pitch=0.8999999761581421,PlaybackSpeed=0.8999999761581421,SoundId="rbxassetid://620716624",Volume=4})
	i485=new("Part",i460,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1136.5291748046875,-20.498537063598633,476.3382568359375,5.493356169949948e-08,-3.335593135034287e-08,-1,-6.623014314754982e-08,1,-3.335593490305655e-08,1,6.623015025297718e-08,5.49335581467858e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i485,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i485,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i485,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i485,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	new("Part",i460,{Name="Trigger",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1140.2196044921875,-20.8139705657959,476.379638671875,-0.00003266368730692193,0.000043158150219824165,-1,9.295133551745494e-10,1,0.000043158150219824165,1,4.801909980756136e-10,-0.00003266368730692193),Material=272,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Part",i460,{Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1141.4285888671875,-20.106327056884766,476.3795166015625,-0.00003266368730692193,0.000043158150219824165,-1,9.295133551745494e-10,1,0.000043158150219824165,1,4.801909980756136e-10,-0.00003266368730692193),Material=272,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i492=new("Part",i460,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1137.9866943359375,-20.353031158447266,476.380615234375,0.00014013804320711643,1.8666073131612393e-09,1,-0.00004315952901379205,1,4.181684332138502e-09,-1,-0.00004315952901379205,0.00014013804320711643),Material=272,Rotation=v3(-0.0020000000949949026,90,0),Size=v3(0.20000000298023224,0.5453969836235046,2.8998520374298096)})
	new("IntValue",i492,{Name="Slot1"})
	new("FileMesh",i492,{MeshId="rbxassetid://455703983"})
	i495=new("Part",i460,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1138.6185302734375,-20.473024368286133,476.379638671875,0.00014013804320711643,1.8666073131612393e-09,1,-0.00004315952901379205,1,4.181684332138502e-09,-1,-0.00004315952901379205,0.00014013804320711643),Material=272,Rotation=v3(-0.0020000000949949026,90,0),Size=v3(0.29053401947021484,0.32334762811660767,1.7146449089050293)})
	new("IntValue",i495,{Name="Slot2"})
	new("FileMesh",i495,{MeshId="rbxassetid://455699837"})
	i498=new("Part",i460,{Name="Iron",Anchored=t,BrickColor=bc(26),CFrame=cf(-1140.0765380859375,-20.2080135345459,476.3916015625,0.00014013804320711643,1.8666073131612393e-09,1,-0.00004315952901379205,1,4.181684332138502e-09,-1,-0.00004315952901379205,0.00014013804320711643),Material=272,Rotation=v3(-0.0020000000949949026,90,0),Size=v3(0.20000000298023224,0.28876006603240967,1.0448017120361328)})
	new("IntValue",i498,{Name="Slot1"})
	new("FileMesh",i498,{MeshId="rbxassetid://455697494"})
	i501=new("Part",i460,{Name="Bolt",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1140.1395263671875,-20.426029205322266,476.379638671875,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Material=272,Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.011212944984436,0.22350001335144043,0.2861981987953186)})
	new("FileMesh",i501,{MeshId="rbxassetid://453276303"})
	i503=new("Part",i460,{Name="MeshPart",Anchored=t,BrickColor=bc(302),CFrame=cf(-1140.8035888671875,-20.772462844848633,476.4225769042969,0.00014013804320711643,1.8666073131612393e-09,1,-0.00004315952901379205,1,4.181684332138502e-09,-1,-0.00004315952901379205,0.00014013804320711643),Material=272,Rotation=v3(-0.0020000000949949026,90,0),Size=v3(0.28959742188453674,0.7975850105285645,2.5056989192962646)})
	new("FileMesh",i503,{MeshId="rbxassetid://455697158"})
	i505=new("Part",i460,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1140.0638427734375,-20.639039993286133,476.398681640625,0.00014013804320711643,1.8666073131612393e-09,1,-0.00004315952901379205,1,4.181684332138502e-09,-1,-0.00004315952901379205,0.00014013804320711643),Material=272,Rotation=v3(-0.0020000000949949026,90,0),Size=v3(0.31658077239990234,0.6536479592323303,1.175929069519043)})
	new("IntValue",i505,{Name="Slot1"})
	new("FileMesh",i505,{MeshId="rbxassetid://455701078"})
	i508=new("Part",i460,{Name="Mag",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1139.7586669921875,-21.0469970703125,476.379638671875,0.00014013804320711643,1.8666073131612393e-09,1,-0.00004315952901379205,1,4.181684332138502e-09,-1,-0.00004315952901379205,0.00014013804320711643),Material=272,Rotation=v3(-0.0020000000949949026,90,0),Size=v3(0.20000000298023224,1.0249028205871582,0.47074592113494873)})
	new("IntValue",i508,{Name="Slot2"})
	new("FileMesh",i508,{MeshId="rbxassetid://453250464"})
	new("Snap",i508,{C0=cf(0,0.5124514102935791,0,-1,0,0,0,0,1,0,1,-0),C1=cf(0.380859375,-0.10853993892669678,-0.00003814697265625,-0.0001096213236451149,1,-0.00003051656312891282,0.00001263813828700222,0.000030517945560859516,1,1,0.00010962093074340373,-0.000012641485227504745)})
	i512=new("Part",i460,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1140.5198974609375,-21.047977447509766,476.379638671875,0.00014013804320711643,1.8666073131612393e-09,1,-0.00004315952901379205,1,4.181684332138502e-09,-1,-0.00004315952901379205,0.00014013804320711643),Material=272,Rotation=v3(-0.0020000000949949026,90,0),Size=v3(0.20000000298023224,0.5527589321136475,0.4568880796432495)})
	new("IntValue",i512,{Name="Slot2"})
	new("FileMesh",i512,{MeshId="rbxassetid://455696649"})
	i515=new("Part",i460,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1141.3323974609375,-20.765506744384766,476.379638671875,0.00014013804320711643,1.8666073131612393e-09,1,-0.00004315952901379205,1,4.181684332138502e-09,-1,-0.00004315952901379205,0.00014013804320711643),Material=272,Rotation=v3(-0.0020000000949949026,90,0),Size=v3(0.20000000298023224,0.7833147644996643,1.3627499341964722)})
	new("IntValue",i515,{Name="Slot2"})
	new("FileMesh",i515,{MeshId="rbxassetid://455702718"})
	i518=new("Part",i460,{Name="BoltBack",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1140.5667724609375,-20.426029205322266,476.379638671875,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Material=272,Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.011212944984436,0.22350001335144043,0.2861981987953186),Transparency=1})
	new("FileMesh",i518,{MeshId="rbxassetid://453276303"})
	new("Part",i460,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1139.8314208984375,-20.5062313079834,476.431884765625,1,0,0,0,1,0,0,0,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i521=new("Model",i1,{Name="M60"})
	i522=new("Folder",i521,{Name="Settings"})
	new("IntValue",i522,{Name="Recoil",Value=1})
	new("IntValue",i522,{Name="StoredAmmo",Value=101})
	new("IntValue",i522,{Name="Mag",Value=6})
	new("BoolValue",i522,{Name="Auto",Value=t})
	new("NumberValue",i522,{Name="FireRate",Value=0.05})
	new("IntValue",i522,{Name="FireMode",Value=1})
	new("BoolValue",i522,{Name="CanSelectFire",Value=t})
	new("IntValue",i522,{Name="Ammo",Value=101})
	new("IntValue",i522,{Name="AimZoom",Value=35})
	new("IntValue",i522,{Name="Drop",Value=135})
	new("IntValue",i522,{Name="CycleZoom",Value=50})
	new("StringValue",i522,{Name="RifleOrPistol"})
	new("BoolValue",i522,{Name="IsGun",Value=t})
	new("IntValue",i522,{Name="ShotCount",Value=1})
	new("StringValue",i522,{Name="Rarity",Value="mythical"})
	new("BoolValue",i522,{Name="Dismember",Value=t})
	new("StringValue",i522,{Name="AmmoType",Value="rifle"})
	i540=new("Part",i521,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1141.8299560546875,-21.55054473876953,470.655517578125,6.177397260387352e-09,-6.315859479855135e-08,-1,-1.9952237551024155e-07,1,-6.315859479855135e-08,1,1.9952237551024155e-07,6.177385269978686e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i540,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i540,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i540,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=1})
	new("Sound",i540,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=1})
	new("Sound",i540,{Name="Fire",Pitch=1.5,PlaybackSpeed=1.5,SoundId="http://roblox.com/asset/?id=10209257",Volume=0.6000000238418579})
	i546=new("Part",i521,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1138.0863037109375,-20.829713821411133,470.642578125,5.493356169949948e-08,-3.335593135034287e-08,-1,-6.623014314754982e-08,1,-3.335593490305655e-08,1,6.623015025297718e-08,5.49335581467858e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i546,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i546,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i546,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i546,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	i551=new("Part",i521,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1141.7781982421875,-21.123170852661133,470.6082763671875,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(4.070625305175781,0.8985109329223633,0.32700109481811523)})
	new("IntValue",i551,{Name="Slot1"})
	new("FileMesh",i551,{MeshId="rbxassetid://480825304"})
	i554=new("Part",i521,{Name="Lid",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1142.2713623046875,-20.668216705322266,470.54833984375,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.8120031356811523,0.23105603456497192,0.378049373626709)})
	new("IntValue",i554,{Name="Slot1"})
	new("FileMesh",i554,{MeshId="rbxassetid://480832783"})
	i557=new("Part",i521,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1141.3533935546875,-21.141117095947266,470.7862548828125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(3.1679000854492188,1.1575514078140259,0.8848199844360352)})
	new("IntValue",i557,{Name="Slot1"})
	new("FileMesh",i557,{MeshId="rbxassetid://480833615"})
	i560=new("Part",i521,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1142.1942138671875,-20.8901424407959,470.5233154296875,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.7864999771118164,0.43500596284866333,0.4459500312805176)})
	new("IntValue",i560,{Name="Slot2"})
	new("FileMesh",i560,{MeshId="rbxassetid://480833094"})
	i563=new("Part",i521,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1140.6424560546875,-20.921146392822266,470.600341796875,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(5.303979873657227,0.5641200542449951,0.28349971771240234)})
	new("IntValue",i563,{Name="Slot2"})
	new("FileMesh",i563,{MeshId="rbxassetid://480824878"})
	i566=new("Part",i521,{Name="Iron",Anchored=t,BrickColor=bc(26),CFrame=cf(-1139.8973388671875,-20.6051082611084,470.5963134765625,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(2.828969955444336,0.5896289944648743,0.21600008010864258)})
	new("FileMesh",i566,{MeshId="rbxassetid://480825237"})
	new("Part",i521,{Name="Bolt",Anchored=t,BrickColor=bc(226),CFrame=cf(-1141.7279052734375,-20.903324127197266,470.626708984375,-0.00011897212971234694,1,2.3392203729599714e-09,-1,-0.00011897212971234694,0.000043158601329196244,0.000043158601329196244,2.7976057026535273e-09,1),Material=272,Rotation=v3(-0.0020000000949949026,0,-90.00700378417969),Size=v3(0.110003761947155,0.1155039444565773,0.110003761947155),FormFactor=3})
	new("Part",i521,{Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1143.32421875,-20.39208984375,470.6085205078125,-0.00003266368730692193,0.0001294763060286641,-1,0.00008631998207420111,1,0.00012947346840519458,1,-0.00008631575474282727,-0.000032674863177817315),Material=1088,Rotation=v3(-0.004999999888241291,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Part",i521,{Name="Trigger",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1141.8607177734375,-21.232545852661133,470.608642578125,-0.00003266368730692193,0.0001294763060286641,-1,0.00008631998207420111,1,0.00012947346840519458,1,-0.00008631575474282727,-0.000032674863177817315),Material=1088,Rotation=v3(-0.004999999888241291,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i571=new("Part",i521,{Name="Mag",Anchored=t,BrickColor=bc(318),CFrame=cf(-1141.6224365234375,-21.0690975189209,470.209716796875,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(0.4411001205444336,0.7854080200195312,0.6420001983642578)})
	new("IntValue",i571,{Name="Slot1"})
	new("FileMesh",i571,{MeshId="rbxassetid://480825070"})
	new("Part",i521,{Name="BoltBack",Anchored=t,BrickColor=bc(226),CFrame=cf(-1141.7279052734375,-20.903324127197266,470.626708984375,-0.00011897212971234694,1,2.3392203729599714e-09,-1,-0.00011897212971234694,0.000043158601329196244,0.000043158601329196244,2.7976057026535273e-09,1),Material=272,Rotation=v3(-0.0020000000949949026,0,-90.00700378417969),Size=v3(0.110003761947155,0.1155039444565773,0.110003761947155),Transparency=1,FormFactor=3})
	new("Part",i521,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1141.5970458984375,-20.813602447509766,470.6961669921875,1,0,0,0,1,0,0,0,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i576=new("Model",i1,{Name="Honey Badger"})
	i577=new("Folder",i576,{Name="Settings"})
	new("IntValue",i577,{Name="Recoil",Value=1})
	new("IntValue",i577,{Name="StoredAmmo",Value=30})
	new("IntValue",i577,{Name="Mag",Value=6})
	new("BoolValue",i577,{Name="Auto",Value=t})
	new("NumberValue",i577,{Name="FireRate",Value=0.07})
	new("IntValue",i577,{Name="FireMode",Value=1})
	new("BoolValue",i577,{Name="CanSelectFire",Value=t})
	new("IntValue",i577,{Name="Ammo",Value=30})
	new("IntValue",i577,{Name="AimZoom",Value=35})
	new("IntValue",i577,{Name="Drop",Value=135})
	new("IntValue",i577,{Name="CycleZoom",Value=50})
	new("StringValue",i577,{Name="RifleOrPistol"})
	new("BoolValue",i577,{Name="IsGun",Value=t})
	new("IntValue",i577,{Name="ShotCount",Value=1})
	new("StringValue",i577,{Name="Rarity",Value="mythical"})
	new("BoolValue",i577,{Name="Dismember"})
	new("StringValue",i577,{Name="AmmoType",Value="rifle"})
	new("Part",i576,{Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1143.1610107421875,-20.2469482421875,464.8140869140625,-0.00003266368730692193,0.000043158150219824165,-1,9.295133551745494e-10,1,0.000043158150219824165,1,4.801909980756136e-10,-0.00003266368730692193),Material=272,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i596=new("Part",i576,{Name="Bolt",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1141.7640380859375,-20.5865478515625,464.814208984375,1,0.000030518036510329694,-0.000030517112463712692,-0.000030517114282702096,1,0.00003051804378628731,0.00003051802923437208,-0.000030517114282702096,1),Material=272,Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.011212944984436,0.22350001335144043,0.2861981987953186)})
	new("FileMesh",i596,{MeshId="rbxassetid://453276303"})
	new("Snap",i596,{C0=cf(0,-0.11175000667572021,0,1,0,0,0,0,-1,0,1,0),C1=cf(-0.0000762939453125,0.5092520117759705,-0.3818359375,0.00010962133819703013,-1,0.000012638136468012817,-0.000030516564947902225,-0.000012641485227504745,-1,1,0.00010962093074340373,-0.0000305179382849019)})
	i600=new("Part",i576,{Name="BoltBack",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1142.17529296875,-20.5865478515625,464.814208984375,1,0.0000305180401483085,-0.000030517112463712692,-0.000030517114282702096,1,0.00003051804378628731,0.000030518036510329694,-0.000030517114282702096,1),Material=272,Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.011212944984436,0.22350001335144043,0.2861981987953186),Transparency=1})
	new("FileMesh",i600,{MeshId="rbxassetid://453276303"})
	i602=new("Part",i576,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1139.4964599609375,-20.603641510009766,464.8189697265625,5.493356169949948e-08,-3.335593135034287e-08,-1,-6.623014314754982e-08,1,-3.335593490305655e-08,1,6.623015025297718e-08,5.49335581467858e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i602,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i602,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i602,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i602,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	i607=new("Part",i576,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1141.8460693359375,-21.230716705322266,464.83203125,6.177397260387352e-09,-6.315859479855135e-08,-1,-1.9952237551024155e-07,1,-6.315859479855135e-08,1,1.9952237551024155e-07,6.177385269978686e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i607,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i607,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i607,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i607,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i607,{Name="Fire",Pitch=7,PlaybackSpeed=7,SoundId="rbxassetid://620716624",Volume=0.4000000059604645})
	i613=new("Part",i576,{Name="Iron",Anchored=t,BrickColor=bc(26),CFrame=cf(-1141.2020263671875,-20.356689453125,464.817138671875,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Material=272,Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.6915669441223145,0.29459989070892334,0.20000000298023224)})
	new("FileMesh",i613,{MeshId="rbxassetid://456403472"})
	i599=new("Part",i576,{Name="Mag",Anchored=t,BrickColor=bc(26),CFrame=cf(-1141.3824462890625,-21.207521438598633,464.814208984375,0.00014013804320711643,1.8666073131612393e-09,1,-0.00004315952901379205,1,4.181684332138502e-09,-1,-0.00004315952901379205,0.00014013804320711643),Material=272,Rotation=v3(-0.0020000000949949026,90,0),Size=v3(0.20000000298023224,1.0249028205871582,0.47074592113494873)})
	new("IntValue",i599,{Name="Slot2"})
	new("FileMesh",i599,{MeshId="rbxassetid://453250464"})
	i618=new("Part",i576,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1141.7288818359375,-20.792482376098633,464.8302001953125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Material=272,Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.0963170528411865,0.653643012046814,0.24541997909545898)})
	new("IntValue",i618,{Name="Slot1"})
	new("FileMesh",i618,{MeshId="rbxassetid://456398137"})
	i621=new("Part",i576,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1141.9578857421875,-20.791996002197266,464.814208984375,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Material=272,Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(3.3706400394439697,0.6528500318527222,0.2781100273132324)})
	new("IntValue",i621,{Name="Slot1"})
	new("FileMesh",i621,{MeshId="rbxassetid://456398493"})
	i624=new("Part",i576,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1141.656005859375,-20.855472564697266,464.815185546875,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Material=272,Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(0.9632569551467896,0.41724294424057007,0.20277103781700134)})
	new("FileMesh",i624,{MeshId="rbxassetid://456394902"})
	i626=new("Part",i576,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1142.1439208984375,-21.208498001098633,464.814208984375,0.00014013804320711643,1.8666073131612393e-09,1,-0.00004315952901379205,1,4.181684332138502e-09,-1,-0.00004315952901379205,0.00014013804320711643),Material=272,Rotation=v3(-0.0020000000949949026,90,0),Size=v3(0.20000000298023224,0.5527589321136475,0.4568880796432495)})
	new("IntValue",i626,{Name="Slot2"})
	new("FileMesh",i626,{MeshId="rbxassetid://455696649"})
	i629=new("Part",i576,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1140.7279052734375,-20.6340389251709,464.814208984375,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Material=272,Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(0.9072520732879639,0.268765926361084,0.26873016357421875)})
	new("IntValue",i629,{Name="Slot1"})
	new("FileMesh",i629,{MeshId="rbxassetid://456397383"})
	new("Snap",i629,{C0=cf(0,0.134382963180542,0,-1,0,0,0,0,1,0,1,-0),C1=cf(0.47412109375,-0.14294660091400146,-0.00302886962890625,-1,0,0,0,0,1,0,1,-0)})
	new("Part",i576,{Name="Trigger",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1141.8431396484375,-20.974491119384766,464.814208984375,-0.00003266368730692193,0.000043158150219824165,-1,9.295133551745494e-10,1,0.000043158150219824165,1,4.801909980756136e-10,-0.00003266368730692193),Material=272,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i634=new("Part",i576,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1141.6121826171875,-20.6555233001709,464.814208984375,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Material=272,Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(3.94307017326355,0.2802830934524536,0.2943098545074463)})
	new("IntValue",i634,{Name="Slot2"})
	new("FileMesh",i634,{MeshId="rbxassetid://456394081"})
	new("Part",i576,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1141.4478759765625,-20.596195220947266,464.8675537109375,1,0,0,0,1,0,0,0,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i638=new("Model",i1,{Name="AWM"})
	i639=new("Folder",i638,{Name="Settings"})
	new("IntValue",i639,{Name="Recoil",Value=1})
	new("IntValue",i639,{Name="StoredAmmo",Value=10})
	new("IntValue",i639,{Name="Mag",Value=6})
	new("BoolValue",i639,{Name="Auto"})
	new("NumberValue",i639,{Name="FireRate",Value=0.067})
	new("IntValue",i639,{Name="FireMode",Value=4})
	new("BoolValue",i639,{Name="CanSelectFire"})
	new("IntValue",i639,{Name="ShotCount",Value=1})
	new("IntValue",i639,{Name="AimZoom",Value=6})
	new("IntValue",i639,{Name="Drop",Value=135})
	new("IntValue",i639,{Name="CycleZoom",Value=50})
	new("StringValue",i639,{Name="RifleOrPistol"})
	new("BoolValue",i639,{Name="IsGun",Value=t})
	new("IntValue",i639,{Name="Ammo",Value=10})
	new("StringValue",i639,{Name="Rarity",Value="mythical"})
	new("BoolValue",i639,{Name="Dismember",Value=t})
	new("StringValue",i639,{Name="AmmoType",Value="rifle"})
	i657=new("Part",i638,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1140.3504638671875,-21.306522369384766,484.9632568359375,6.177397260387352e-09,-6.315859479855135e-08,-1,-1.9952237551024155e-07,1,-6.315859479855135e-08,1,1.9952237551024155e-07,6.177385269978686e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i657,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i657,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i657,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i657,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i657,{Name="Fire",SoundId="rbxassetid://725750543",Volume=4})
	new("Sound",i657,{Name="M1",SoundId="rbxassetid://873042054"})
	new("Sound",i657,{Name="M2",Pitch=0.699999988079071,PlaybackSpeed=0.699999988079071,SoundId="rbxassetid://873042054"})
	i665=new("Part",i638,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1135.3973388671875,-20.62146759033203,484.9503173828125,5.493356169949948e-08,-3.335593135034287e-08,-1,-6.623014314754982e-08,1,-3.335593490305655e-08,1,6.623015025297718e-08,5.49335581467858e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i665,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i665,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i665,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i665,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	new("Part",i638,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(26),CFrame=cf(-1139.9603271484375,-20.479740142822266,484.9771728515625,-1,0,0,0,1,0,0,0,-1),Material=272,Rotation=v3(180,0,180),Size=v3(0.05000000074505806,0.15000000596046448,0.05000000074505806),TopSurface=0})
	new("Part",i638,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(26),CFrame=cf(-1139.5516357421875,-20.479740142822266,484.9771728515625,-1,0,0,0,1,0,0,0,-1),Material=272,Rotation=v3(180,0,180),Size=v3(0.05000000074505806,0.15000000596046448,0.05000000074505806),TopSurface=0})
	i672=new("Part",i638,{Name="Reticle",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1139.0780029296875,-20.328006744384766,484.97705078125,-1,0,0,0,1,0,0,0,-1),Material=288,Rotation=v3(180,0,180),Size=v3(0.05000000074505806,0.21891142427921295,0.21891139447689056),TopSurface=0,Transparency=0.699999988079071,FormFactor=3})
	new("SpecialMesh",i672,{Scale=v3(0.24323450028896332,1,1),MeshType=4})
	new("Decal",i672,{Face=0,Texture="http://www.roblox.com/asset/?id=303556559"})
	new("Decal",i672,{Face=0,Texture="http://www.roblox.com/asset/?id=303556559"})
	new("Decal",i672,{Face=0,Texture="http://www.roblox.com/asset/?id=303556559"})
	new("Decal",i672,{Face=0,Texture="http://www.roblox.com/asset/?id=303556559"})
	new("Decal",i672,{Face=0,Texture="http://www.roblox.com/asset/?id=303556559"})
	new("Decal",i672,{Face=0,Texture="http://www.roblox.com/asset/?id=303556559"})
	new("Decal",i672,{Face=0,Texture="http://www.roblox.com/asset/?id=303556559"})
	new("Decal",i672,{Face=0,Texture="http://www.roblox.com/asset/?id=303556559"})
	new("Decal",i672,{Face=0,Texture="http://www.roblox.com/asset/?id=303556559"})
	new("Decal",i672,{Face=0,Texture="http://www.roblox.com/asset/?id=303556559"})
	i684=new("Part",i638,{Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1139.7667236328125,-20.2948055267334,484.9771728515625,-1,0,0,0,1,0,0,0,-1),Material=272,Rotation=v3(180,0,180),Size=v3(1.3569999933242798,0.3100000023841858,0.24400000274181366),TopSurface=0})
	new("SpecialMesh",i684,{MeshId="rbxassetid://2029156429",MeshType=5})
	i686=new("Part",i638,{Name="Fade",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1140.4281005859375,-20.328006744384766,484.97705078125,-1,0,0,0,1,0,0,0,-1),Material=288,Rotation=v3(180,0,180),Size=v3(0.05000000074505806,0.21891142427921295,0.21891139447689056),TopSurface=0,Transparency=0.699999988079071,FormFactor=3})
	new("SpecialMesh",i686,{Scale=v3(0.24323450028896332,1,1),MeshType=4})
	new("Decal",i686,{Face=0,Texture="http://www.roblox.com/asset/?id=286537017"})
	new("Decal",i686,{Face=0,Texture="http://www.roblox.com/asset/?id=286537017"})
	new("Decal",i686,{Face=0,Texture="http://www.roblox.com/asset/?id=286537017"})
	i691=new("Part",i638,{Name="AimPart",Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(307),CFrame=cf(-1140.4832763671875,-20.3283748626709,484.9765625,0,0,-1,0,1,0,1,0,0),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(0,-90,0),Size=v3(0.09173646569252014,0.07488705217838287,0.07894076406955719),TopSurface=10,Transparency=1})
	new("BlockMesh",i691)
	i693=new("Part",i638,{Name="BoltBack",Anchored=t,BrickColor=bc(302),CFrame=cf(-1141.0833740234375,-20.743656158447266,485.0947265625,-1,0,0,0,1,0,0,0,-1),Rotation=v3(180,0,180),Size=v3(0.20000004768371582,0.20000000298023224,0.20000004768371582),Transparency=1})
	new("SpecialMesh",i693,{MeshId="rbxassetid://2028963092",MeshType=5})
	i695=new("Part",i638,{Name="Bolt",Anchored=t,BrickColor=bc(302),CFrame=cf(-1140.3743896484375,-20.743656158447266,485.0947265625,-1,0,0,0,1,0,0,0,-1),Rotation=v3(180,0,180),Size=v3(0.20000004768371582,0.20000000298023224,0.20000004768371582)})
	new("SpecialMesh",i695,{MeshId="rbxassetid://2028963092",MeshType=5})
	new("Part",i638,{Name="Trigger",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1140.87890625,-21.057743072509766,484.9726867675781,-0.00003266368730692193,0.00004316000922699459,-1,0.0000863181339809671,1,0.00004315718979341909,1,-0.00008631672244518995,-0.00003266741259722039),Material=1088,Rotation=v3(-0.004999999888241291,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i698=new("Part",i638,{Anchored=t,BrickColor=bc(26),CFrame=cf(-1138.1390380859375,-20.667728424072266,484.9726867675781,0,0,1,0,1,-0,-1,0,0),Rotation=v3(0,90,0),Size=v3(0.20000004768371582,0.20000000298023224,0.20000004768371582)})
	new("SpecialMesh",i698,{MeshId="rbxassetid://656177690",MeshType=5})
	i700=new("Part",i638,{Anchored=t,BrickColor=bc(26),CFrame=cf(-1138.4251708984375,-20.645877838134766,484.9716796875,0,0,1,0,1,-0,-1,0,0),Rotation=v3(0,90,0),Size=v3(0.20000004768371582,0.20000000298023224,0.20000004768371582)})
	new("SpecialMesh",i700,{MeshId="rbxassetid://656179802",MeshType=5})
	i702=new("Part",i638,{Name="Mag",Anchored=t,BrickColor=bc(26),CFrame=cf(-1140.1390380859375,-21.049440383911133,484.9726867675781,0,0,1,0,1,-0,-1,0,0),Rotation=v3(0,90,0),Size=v3(0.20000004768371582,0.20000000298023224,0.20000004768371582)})
	new("SpecialMesh",i702,{MeshId="rbxassetid://656178049",MeshType=5})
	new("IntValue",i702,{Name="Slot2"})
	new("Part",i638,{Anchored=t,CFrame=cf(-1140.6810302734375,-20.6212158203125,484.9737548828125,0.000053408595704240724,-0.9999998211860657,0.0006904902402311563,0.9999993443489075,0.000052603914809878916,-0.0011653434485197067,0.0011653067776933312,0.0006905520567670465,0.9999991059303284),Rotation=v3(0.06700000166893005,0.03999999910593033,89.99700164794922),Size=v3(0.20000000298023224,0.20000000298023224,1.0875000953674316),Transparency=1,FormFactor=3})
	i706=new("Part",i638,{Anchored=t,BrickColor=bc(26),CFrame=cf(-1140.4212646484375,-21.0157470703125,484.9726867675781,0,0,1,0,1,-0,-1,0,0),Rotation=v3(0,90,0),Size=v3(0.20000004768371582,0.20000000298023224,0.20000004768371582)})
	new("SpecialMesh",i706,{Scale=v3(1.0099999904632568,1,1),MeshId="rbxassetid://1619203220",MeshType=5})
	i708=new("Part",i638,{Anchored=t,BrickColor=bc(318),CFrame=cf(-1140.3221435546875,-21.1268310546875,484.9736328125,0,0,1,0,1,-0,-1,0,0),Rotation=v3(0,90,0),Size=v3(0.20000004768371582,0.20000000298023224,0.20000004768371582)})
	new("SpecialMesh",i708,{MeshId="rbxassetid://1619215625",MeshType=5})
	new("IntValue",i708,{Name="Slot1"})
	new("Part",i638,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1140.2113037109375,-20.6094970703125,485.0216064453125,1,0,0,0,1,0,0,0,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i712=new("Model",i1,{Name="Saiga-12"})
	i713=new("Folder",i712,{Name="Settings"})
	new("IntValue",i713,{Name="Recoil",Value=1})
	new("IntValue",i713,{Name="StoredAmmo",Value=10})
	new("IntValue",i713,{Name="Mag",Value=6})
	new("BoolValue",i713,{Name="Auto"})
	new("NumberValue",i713,{Name="FireRate",Value=0.067})
	new("IntValue",i713,{Name="FireMode",Value=2})
	new("BoolValue",i713,{Name="CanSelectFire"})
	new("IntValue",i713,{Name="ShotCount",Value=10})
	new("IntValue",i713,{Name="AimZoom",Value=35})
	new("IntValue",i713,{Name="Drop",Value=135})
	new("IntValue",i713,{Name="CycleZoom",Value=50})
	new("StringValue",i713,{Name="RifleOrPistol"})
	new("BoolValue",i713,{Name="IsGun",Value=t})
	new("IntValue",i713,{Name="Ammo",Value=10})
	new("StringValue",i713,{Name="Rarity",Value="legendary"})
	new("BoolValue",i713,{Name="Dismember",Value=t})
	new("StringValue",i713,{Name="AmmoType",Value="shotgun"})
	i731=new("Part",i712,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1139.5574951171875,-21.3067626953125,483.18505859375,6.177397260387352e-09,-6.315859479855135e-08,-1,-1.9952237551024155e-07,1,-6.315859479855135e-08,1,1.9952237551024155e-07,6.177385269978686e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i731,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i731,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i731,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i731,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i731,{Name="Fire",Pitch=0.8999999761581421,PlaybackSpeed=0.8999999761581421,SoundId="rbxassetid://620716624",Volume=3})
	new("Sound",i731,{Name="M1",Playing=t,SoundId="rbxassetid://873042054"})
	new("Sound",i731,{Name="M2",Playing=t,SoundId="rbxassetid://873042054"})
	i739=new("Part",i712,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1135.6751708984375,-20.621706008911133,483.172119140625,5.493356169949948e-08,-3.335593135034287e-08,-1,-6.623014314754982e-08,1,-3.335593490305655e-08,1,6.623015025297718e-08,5.49335581467858e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i739,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i739,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i739,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i739,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	i744=new("Part",i712,{Name="MeshPart2",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1139.4610595703125,-20.7034969329834,483.214111328125,0.000029999999242136255,0.000045000000682193786,1,-0.00015199999324977398,1,-0.00004499543865676969,-1,-0.00015199863992165774,0.000030006838642293587),Material=272,Rotation=v3(-0.008999999612569809,90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i744,{MeshId="rbxassetid://1495085462"})
	new("IntValue",i744,{Name="Slot2"})
	i747=new("Part",i712,{Name="MeshPart1",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1138.0550537109375,-20.6115779876709,483.214111328125,0.000029999999242136255,0.000045000000682193786,1,-0.00015199999324977398,1,-0.00004499543865676969,-1,-0.00015199863992165774,0.000030006838642293587),Material=272,Rotation=v3(-0.008999999612569809,90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i747,{MeshId="rbxassetid://1495249322"})
	new("IntValue",i747,{Name="Slot1"})
	i750=new("Part",i712,{Name="MeshPart2",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1139.5198974609375,-20.479496002197266,483.214111328125,0.000029999999242136255,0.000045000000682193786,1,-0.00015199999324977398,1,-0.00004499543865676969,-1,-0.00015199863992165774,0.000030006838642293587),Material=272,Rotation=v3(-0.008999999612569809,90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i750,{MeshId="rbxassetid://1495098804"})
	new("IntValue",i750,{Name="Slot2"})
	i753=new("Part",i712,{Name="MeshPart1",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1140.0482177734375,-21.12842559814453,483.214111328125,0.000029999999242136255,0.000045000000682193786,1,-0.00015199999324977398,1,-0.00004499543865676969,-1,-0.00015199863992165774,0.000030006838642293587),Material=272,Rotation=v3(-0.008999999612569809,90,0),Size=v3(0.20000000298023224,0.7999999523162842,0.5999999642372131),TopSurface=0})
	new("FileMesh",i753,{MeshId="rbxassetid://1495225504"})
	new("IntValue",i753,{Name="Slot1"})
	i756=new("Part",i712,{Name="Mag",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1138.9422607421875,-21.085575103759766,483.214111328125,0.000029999999242136255,0.000045000000682193786,1,-0.00015199999324977398,1,-0.00004499543865676969,-1,-0.00015199863992165774,0.000030006838642293587),Material=272,Rotation=v3(-0.008999999612569809,90,0),Size=v3(0.20000000298023224,0.8400000929832458,0.5799999237060547),TopSurface=0})
	new("FileMesh",i756,{MeshId="rbxassetid://1495241274"})
	i758=new("Part",i712,{Name="MeshPart1",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1140.4720458984375,-20.737430572509766,483.2310791015625,0.000029999999242136255,0.000045000000682193786,1,-0.00015199999324977398,1,-0.00004499543865676969,-1,-0.00015199863992165774,0.000030006838642293587),Material=272,Rotation=v3(-0.008999999612569809,90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i758,{MeshId="rbxassetid://1495182582"})
	new("IntValue",i758,{Name="Slot1"})
	i761=new("Part",i712,{Name="MeshPart2",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1137.2342529296875,-20.563602447509766,483.214111328125,0.000029999999242136255,0.000045000000682193786,1,-0.00015199999324977398,1,-0.00004499543865676969,-1,-0.00015199863992165774,0.000030006838642293587),Material=272,Rotation=v3(-0.008999999612569809,90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i761,{MeshId="rbxassetid://1495256278"})
	new("IntValue",i761,{Name="Slot2"})
	i764=new("Part",i712,{Name="MeshPart2",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1138.0863037109375,-20.4615478515625,483.214111328125,0.000029999999242136255,0.000045000000682193786,1,-0.00015199999324977398,1,-0.00004499543865676969,-1,-0.00015199863992165774,0.000030006838642293587),Material=272,Rotation=v3(-0.008999999612569809,90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i764,{MeshId="rbxassetid://1495271120"})
	new("IntValue",i764,{Name="Slot2"})
	i767=new("Part",i712,{Name="MeshPart2",Anchored=t,BottomSurface=0,BrickColor=bc(302),CFrame=cf(-1139.5443115234375,-20.8654842376709,483.214111328125,0.000029999999242136255,0.000045000000682193786,1,-0.00015199999324977398,1,-0.00004499543865676969,-1,-0.00015199863992165774,0.000030006838642293587),Material=272,Rotation=v3(-0.008999999612569809,90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i767,{MeshId="rbxassetid://1495233816"})
	new("IntValue",i767,{Name="Slot2"})
	i770=new("Part",i712,{Name="MeshPart1",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1140.9603271484375,-20.757326126098633,483.214111328125,0.000029999999242136255,0.000045000000682193786,1,-0.00015199999324977398,1,-0.00004499543865676969,-1,-0.00015199863992165774,0.000030006838642293587),Material=272,Rotation=v3(-0.008999999612569809,90,0),Size=v3(0.20000000298023224,0.5200000405311584,1.3799998760223389),TopSurface=0})
	new("FileMesh",i770,{MeshId="rbxassetid://1495192276"})
	new("IntValue",i770,{Name="Slot1"})
	new("Part",i712,{Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1140.4813232421875,-20.338138580322266,483.2139892578125,-0.000029999999242136255,0.00016599999798927456,-1,0.00021300000662449747,1,0.00016599359514657408,1,-0.00021299502986948937,-0.000030035354939172976),Material=272,Rotation=v3(-0.012000000104308128,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Part",i712,{Name="Trigger",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1139.6234130859375,-20.918460845947266,483.214111328125,-0.000029999999242136255,0.00016599999798927456,-1,0.00021300000662449747,1,0.00016599359514657408,1,-0.00021299502986948937,-0.000030035354939172976),Material=272,Rotation=v3(-0.012000000104308128,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i775=new("Part",i712,{Name="MeshPart1",Anchored=t,BottomSurface=0,BrickColor=bc(302),CFrame=cf(-1139.4710693359375,-20.6455135345459,483.214111328125,0.000029999999242136255,0.000045000000682193786,1,-0.00015199999324977398,1,-0.00004499543865676969,-1,-0.00015199863992165774,0.000030006838642293587),Material=272,Rotation=v3(-0.008999999612569809,90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i775,{MeshId="rbxassetid://1495217071"})
	new("IntValue",i775,{Name="Slot1"})
	i778=new("Part",i712,{Name="BoltBack",Anchored=t,BottomSurface=0,CFrame=cf(-1139.0491943359375,-20.460575103759766,483.2470703125,0.000029999999242136255,0.000045000000682193786,1,-0.00015199999324977398,1,-0.00004499543865676969,-1,-0.00015199863992165774,0.000030006838642293587),Material=272,Rotation=v3(-0.008999999612569809,90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1})
	new("FileMesh",i778,{MeshId="rbxassetid://1495349708"})
	i780=new("Part",i712,{Name="Bolt",Anchored=t,BottomSurface=0,CFrame=cf(-1138.5208740234375,-20.460575103759766,483.2470703125,0.000029999999242136255,0.000045000000682193786,1,-0.00015199999324977398,1,-0.00004499543865676969,-1,-0.00015199863992165774,0.000030006838642293587),Material=272,Rotation=v3(-0.008999999612569809,90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i780,{MeshId="rbxassetid://1495349708"})
	new("Part",i712,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1138.970947265625,-20.495487213134766,483.239013671875,1,0,0,0,1,0,0,0,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i783=new("Model",i1,{Name="Emergency Rations"})
	new("Part",i783,{Name="Handle",Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(1001),CFrame=cf(-1154.8270263671875,-21.055912017822266,467.7725830078125,1,0,0,0,1,0,0,0,1),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Size=v3(1.1860897541046143,1.3281733989715576,0.9081000089645386),TopSurface=10})
	new("Part",i783,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(1004),CFrame=cf(-1154.8079833984375,-21.05970001220703,467.7691650390625,0,1,0.0000029802006338286446,0,-0.00000298020086120232,1,1,0,0),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(-90,0,-90),Size=v3(0.9599999785423279,0.5,0.10000000149011612),TopSurface=10})
	new("Part",i783,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(1004),CFrame=cf(-1154.8079833984375,-21.05970001220703,467.7691650390625,0,0,-1.000000238418579,0,1,0,1.000000238418579,0,0),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(0,-90,0),Size=v3(0.9599999785423279,0.5,0.10000000149011612),TopSurface=10})
	new("Part",i783,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(1001),CFrame=cf(-1154.8118896484375,-21.0575008392334,467.7691650390625,0,0,-1.000000238418579,0,1,0,1.000000238418579,0,0),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(0,-90,0),Size=v3(0.9399999976158142,1,0.6499999761581421),TopSurface=10,Shape=2})
	new("Part",i783,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(1004),CFrame=cf(-1154.8079833984375,-21.0575008392334,467.7691650390625,0,0,-1.000000238418579,0,1,0,1.000000238418579,0,0),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(0,-90,0),Size=v3(0.9200000166893005,1,0.7699999809265137),TopSurface=10,Shape=2})
	new("Part",i783,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(302),CFrame=cf(-1154.5765380859375,-19.971437454223633,467.7783508300781,1,0,0,0,1,0,0,0,1),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Size=v3(0.05000000074505806,0.414000004529953,0.07500000298023224),TopSurface=10})
	new("Part",i783,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(1001),CFrame=cf(-1154.8270263671875,-19.987674713134766,467.775390625,1,0,0,0,1,0,0,0,1),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Size=v3(1.1860897541046143,0.4138958156108856,0.05000000074505806),TopSurface=10})
	new("Part",i783,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(302),CFrame=cf(-1155.0863037109375,-19.971437454223633,467.7783508300781,1,0,0,0,1,0,0,0,1),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Size=v3(0.05000000074505806,0.414000004529953,0.07500000298023224),TopSurface=10})
	new("WedgePart",i783,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(1001),CFrame=cf(-1154.8270263671875,-20.213138580322266,467.5474853515625,1,0,0,0,1,0,0,0,1),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Size=v3(1.1860897541046143,0.35829800367355347,0.4540500044822693),TopSurface=10})
	new("WedgePart",i783,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(1001),CFrame=cf(-1154.8270263671875,-20.213138580322266,468.0010070800781,-1.000000238418579,0,0,0,1,0,0,0,-1.000000238418579),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(180,0,180),Size=v3(1.1860897541046143,0.3582979440689087,0.4540500044822693),TopSurface=10})
	i794=new("Folder",i783,{Name="Settings"})
	new("BoolValue",i794,{Name="IsGun"})
	new("StringValue",i794,{Name="Rarity",Value="uncommon"})
	new("NumberValue",i794,{Name="Healing",Value=50})
	new("StringValue",i794,{Name="Type",Value="food"})
	i799=new("Model",i1,{Name="Canned Beans"})
	i800=new("Part",i799,{Name="Handle",Anchored=t,BottomSurface=0,CFrame=cf(-1156.7874755859375,-21.170045852661133,468.067138671875,-1,0,0,0,-1,0,0,0,1),Rotation=v3(0,0,180),Size=v3(0.800000011920929,1.100000023841858,0.800000011920929),TopSurface=0,FormFactor=3})
	new("SpecialMesh",i800,{MeshId="http://www.roblox.com/asset/?id=103919751",TextureId="http://www.roblox.com/asset?id=103920391",MeshType=5})
	i802=new("Folder",i799,{Name="Settings"})
	new("BoolValue",i802,{Name="IsGun"})
	new("StringValue",i802,{Name="Rarity",Value="common"})
	new("NumberValue",i802,{Name="Healing",Value=25})
	new("StringValue",i802,{Name="Type",Value="food"})
	i807=new("Model",i1,{Name="MRE"})
	i808=new("Part",i807,{Name="Handle",Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(125),CFrame=cf(-1158.4422607421875,-21.4400634765625,467.4671630859375,-1,0,0,0,1,0,0,0,-1),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(180,0,180),Size=v3(1,0.5500001311302185,2),TopSurface=10,FormFactor=2})
	new("SpecialMesh",i808,{Scale=v3(1.25,0.5,1),MeshType=6})
	new("Decal",i808,{Face=4,Texture="http://www.roblox.com/asset/?id=84387716"})
	new("Decal",i808,{Face=1,Texture="http://www.roblox.com/asset/?id=84387716"})
	i812=new("Folder",i807,{Name="Settings"})
	new("BoolValue",i812,{Name="IsGun"})
	new("StringValue",i812,{Name="Rarity",Value="rare"})
	new("NumberValue",i812,{Name="Healing",Value=75})
	new("StringValue",i812,{Name="Type",Value="food"})
	i817=new("Model",i1,{Name="Kriss Vector"})
	i818=new("Part",i817,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1139.1214599609375,-21.044675827026367,489.832275390625,5.493356169949948e-08,-3.335593135034287e-08,-1,-6.623014314754982e-08,1,-3.335593490305655e-08,1,6.623015025297718e-08,5.49335581467858e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i818,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i818,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i818,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i818,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	i823=new("Part",i817,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1140.739013671875,-21.404420852661133,489.84521484375,6.177397260387352e-09,-6.315859479855135e-08,-1,-1.9952237551024155e-07,1,-6.315859479855135e-08,1,1.9952237551024155e-07,6.177385269978686e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i823,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i823,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i823,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i823,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i823,{Name="Fire",SoundId="rbxassetid://896335161",Volume=1})
	i829=new("Folder",i817,{Name="Settings"})
	new("IntValue",i829,{Name="Recoil",Value=1})
	new("IntValue",i829,{Name="StoredAmmo",Value=31})
	new("IntValue",i829,{Name="Mag",Value=10})
	new("BoolValue",i829,{Name="Auto",Value=t})
	new("NumberValue",i829,{Name="FireRate",Value=0.04})
	new("IntValue",i829,{Name="FireMode",Value=1})
	new("BoolValue",i829,{Name="CanSelectFire",Value=t})
	new("IntValue",i829,{Name="Ammo",Value=31})
	new("IntValue",i829,{Name="AimZoom",Value=35})
	new("IntValue",i829,{Name="Drop",Value=135})
	new("IntValue",i829,{Name="CycleZoom",Value=50})
	new("StringValue",i829,{Name="RifleOrPistol"})
	new("BoolValue",i829,{Name="IsGun",Value=t})
	new("IntValue",i829,{Name="ShotCount",Value=1})
	new("StringValue",i829,{Name="Rarity",Value="legendary"})
	new("BoolValue",i829,{Name="Dismember"})
	new("StringValue",i829,{Name="AmmoType",Value="pistol"})
	i847=new("Part",i817,{Anchored=t,BrickColor=bc(302),CFrame=cf(-1141.9403076171875,-21.23108673095703,489.8489990234375,-0.00002900001527450513,0.0011929995380342007,-0.9999993443489075,-0.003360001603141427,0.999993622303009,0.0011930903419852257,0.9999944567680359,0.0033600335009396076,-0.00002499135007383302),Rotation=v3(-91.19999694824219,-89.93399810791016,-91.39299774169922),Size=v3(0.20000004768371582,0.20000000298023224,0.20000004768371582)})
	new("SpecialMesh",i847,{MeshId="rbxassetid://748647821",MeshType=5})
	new("IntValue",i847,{Name="Slot1"})
	i850=new("Part",i817,{Anchored=t,BrickColor=bc(1003),CFrame=cf(-1141.4281005859375,-21.242557525634766,489.8428649902344,-0.00002900001527450513,0.0011929995380342007,-0.9999993443489075,-0.003360001603141427,0.999993622303009,0.0011930903419852257,0.9999944567680359,0.0033600335009396076,-0.00002499135007383302),Rotation=v3(-91.19999694824219,-89.93399810791016,-91.39299774169922),Size=v3(0.20000004768371582,0.20000000298023224,0.20000004768371582)})
	new("SpecialMesh",i850,{MeshId="rbxassetid://741828925",MeshType=5})
	i852=new("Part",i817,{Name="Mag",Anchored=t,BrickColor=bc(26),CFrame=cf(-1140.1917724609375,-21.7010555267334,489.825439453125,-0.00002900001527450513,0.0011929995380342007,-0.9999993443489075,-0.003360001603141427,0.999993622303009,0.0011930903419852257,0.9999944567680359,0.0033600335009396076,-0.00002499135007383302),Rotation=v3(-91.19999694824219,-89.93399810791016,-91.39299774169922),Size=v3(0.20000004768371582,0.20000000298023224,0.20000004768371582)})
	new("SpecialMesh",i852,{MeshId="rbxassetid://742902404",MeshType=5})
	i854=new("Part",i817,{Anchored=t,BrickColor=bc(26),CFrame=cf(-1141.0863037109375,-21.2028865814209,489.8240966796875,-0.00002900001527450513,0.0011929995380342007,-0.9999993443489075,-0.003360001603141427,0.999993622303009,0.0011930903419852257,0.9999944567680359,0.0033600335009396076,-0.00002499135007383302),Rotation=v3(-91.19999694824219,-89.93399810791016,-91.39299774169922),Size=v3(0.20000004768371582,0.20000000298023224,0.20000004768371582)})
	new("SpecialMesh",i854,{MeshId="rbxassetid://741822587",MeshType=5})
	i856=new("Part",i817,{Anchored=t,BrickColor=bc(1003),CFrame=cf(-1139.6351318359375,-21.162717819213867,489.834228515625,-0.000029000022550462745,0.001192999305203557,-0.999999463558197,-0.003360002301633358,0.9999935626983643,0.0011930905748158693,0.999994695186615,0.003360033268108964,-0.000024991353711811826),Rotation=v3(-91.19999694824219,-89.94100189208984,-91.39299774169922),Size=v3(0.20000004768371582,0.20000000298023224,0.20000004768371582)})
	new("SpecialMesh",i856,{MeshId="rbxassetid://741820510",MeshType=5})
	new("IntValue",i856,{Name="Slot1"})
	i859=new("Part",i817,{Name="Bolt",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1139.8758544921875,-20.961185455322266,489.7908935546875,-0.00002900001527450513,0.0011929995380342007,-0.9999993443489075,-0.003360001603141427,0.999993622303009,0.0011930903419852257,0.9999944567680359,0.0033600335009396076,-0.00002499135007383302),Rotation=v3(-91.19999694824219,-89.93399810791016,-91.39299774169922),Size=v3(0.20000004768371582,0.20000000298023224,0.20000004768371582)})
	new("SpecialMesh",i859,{MeshId="rbxassetid://741833508",MeshType=5})
	i861=new("Part",i817,{Anchored=t,BrickColor=bc(26),CFrame=cf(-1140.3446044921875,-20.7578182220459,489.8355712890625,-0.000029000031645409763,0.0011929991887882352,-0.9999995827674866,-0.0033600032329559326,0.9999935030937195,0.0011930906912311912,0.9999949336051941,0.0033600330352783203,-0.000024991359168780036),Rotation=v3(0.19300000369548798,-90,0),Size=v3(0.20000004768371582,0.20000000298023224,0.20000004768371582)})
	new("SpecialMesh",i861,{MeshId="rbxassetid://741820621",MeshType=5})
	new("IntValue",i861,{Name="Slot2"})
	new("Snap",i861,{C0=cf(0,-0.10000000149011612,0,1,0,0,0,0,-1,0,1,0),C1=cf(0.0440216064453125,0.10298740863800049,-0.014404296875,1.0000007152557373,-5.4569682106375694e-12,0,0,8.005685003809049e-11,-0.9999998211860657,3.637978807091713e-12,1.0000003576278687,-1.965148044291709e-10)})
	i866=new("Part",i817,{Anchored=t,BrickColor=bc(26),CFrame=cf(-1140.3558349609375,-21.205814361572266,489.8441162109375,-0.00002900001527450513,0.0011929995380342007,-0.9999993443489075,-0.003360001603141427,0.999993622303009,0.0011930903419852257,0.9999944567680359,0.0033600335009396076,-0.00002499135007383302),Rotation=v3(-91.19999694824219,-89.93399810791016,-91.39299774169922),Size=v3(0.20000004768371582,0.20000000298023224,0.20000004768371582)})
	new("SpecialMesh",i866,{MeshId="rbxassetid://741820028",MeshType=5})
	new("IntValue",i866,{Name="Slot2"})
	i869=new("Part",i817,{Anchored=t,BrickColor=bc(26),CFrame=cf(-1140.0062255859375,-21.286258697509766,489.831787109375,-0.00002900001527450513,0.0011929995380342007,-0.9999993443489075,-0.003360001603141427,0.999993622303009,0.0011930903419852257,0.9999944567680359,0.0033600335009396076,-0.00002499135007383302),Rotation=v3(-91.19999694824219,-89.93399810791016,-91.39299774169922),Size=v3(0.20000004768371582,0.20000000298023224,0.20000004768371582)})
	new("SpecialMesh",i869,{MeshId="rbxassetid://741820424",MeshType=5})
	new("IntValue",i869,{Name="Slot1"})
	i872=new("Part",i817,{Anchored=t,BrickColor=bc(26),CFrame=cf(-1139.5750732421875,-21.0517635345459,489.8345947265625,-0.00002900001527450513,0.0011929995380342007,-0.9999993443489075,-0.003360001603141427,0.999993622303009,0.0011930903419852257,0.9999944567680359,0.0033600335009396076,-0.00002499135007383302),Rotation=v3(-91.19999694824219,-89.93399810791016,-91.39299774169922),Size=v3(0.20000004768371582,0.20000000298023224,0.20000004768371582)})
	new("SpecialMesh",i872,{MeshId="rbxassetid://741820976",MeshType=5})
	i874=new("Part",i817,{Name="Iron",Anchored=t,BrickColor=bc(26),CFrame=cf(-1140.3343505859375,-20.6118221282959,489.8370361328125,-0.00002900001527450513,0.0011929995380342007,-0.9999993443489075,-0.003360001603141427,0.999993622303009,0.0011930903419852257,0.9999944567680359,0.0033600335009396076,-0.00002499135007383302),Rotation=v3(-91.19999694824219,-89.93399810791016,-91.39299774169922),Size=v3(0.20000004768371582,0.20000000298023224,0.20000004768371582)})
	new("SpecialMesh",i874,{MeshId="rbxassetid://741837372",MeshType=5})
	new("Part",i817,{Name="Trigger",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1140.8387451171875,-21.0642147064209,489.8355712890625,0.002228999277576804,-0.0010670009069144726,-0.9999970197677612,-0.0019549992866814137,0.9999974966049194,-0.0010713593801483512,0.9999956488609314,0.0019573813769966364,0.0022269077599048615),Material=272,Rotation=v3(25.691999435424805,-89.86000061035156,25.579999923706055),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Part",i817,{Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1142.4979248046875,-20.538944244384766,489.843994140625,0.002228999277576804,-0.0010670009069144726,-0.9999970197677612,-0.0019549992866814137,0.9999974966049194,-0.0010713593801483512,0.9999956488609314,0.0019573813769966364,0.0022269077599048615),Material=272,Rotation=v3(25.691999435424805,-89.86000061035156,25.579999923706055),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i865=new("Part",i817,{Name="BoltBack",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1140.3592529296875,-20.960697174072266,489.7908935546875,-0.00002900001527450513,0.0011929995380342007,-0.9999993443489075,-0.003360001603141427,0.999993622303009,0.0011930903419852257,0.9999944567680359,0.0033600335009396076,-0.00002499135007383302),Rotation=v3(-91.19999694824219,-89.93399810791016,-91.39299774169922),Size=v3(0.20000004768371582,0.20000000298023224,0.20000004768371582),Transparency=1})
	new("SpecialMesh",i865,{MeshId="rbxassetid://741833508",MeshType=5})
	new("Part",i817,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1140.0677490234375,-20.89234161376953,489.888427734375,1,0,0,0,1,0,0,0,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i881=new("Model",i1,{Name="MP5"})
	i882=new("Part",i881,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1138.6527099609375,-20.3197078704834,491.9586181640625,5.493356169949948e-08,-3.335593135034287e-08,-1,-6.623014314754982e-08,1,-3.335593490305655e-08,1,6.623015025297718e-08,5.49335581467858e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i882,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i882,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i882,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i882,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	i887=new("Part",i881,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1140.8909912109375,-21.105472564697266,491.9715576171875,6.177397260387352e-09,-6.315859479855135e-08,-1,-1.9952237551024155e-07,1,-6.315859479855135e-08,1,1.9952237551024155e-07,6.177385269978686e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i887,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i887,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i887,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i887,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i887,{Name="Fire",Pitch=0.8999999761581421,PlaybackSpeed=0.8999999761581421,SoundId="rbxassetid://896335161",Volume=1})
	i893=new("Folder",i881,{Name="Settings"})
	new("IntValue",i893,{Name="Recoil",Value=1})
	new("IntValue",i893,{Name="StoredAmmo",Value=31})
	new("IntValue",i893,{Name="Mag",Value=10})
	new("BoolValue",i893,{Name="Auto",Value=t})
	new("NumberValue",i893,{Name="FireRate",Value=0.06})
	new("IntValue",i893,{Name="FireMode",Value=1})
	new("BoolValue",i893,{Name="CanSelectFire",Value=t})
	new("IntValue",i893,{Name="Ammo",Value=31})
	new("IntValue",i893,{Name="AimZoom",Value=35})
	new("IntValue",i893,{Name="Drop",Value=135})
	new("IntValue",i893,{Name="CycleZoom",Value=50})
	new("StringValue",i893,{Name="RifleOrPistol"})
	new("BoolValue",i893,{Name="IsGun",Value=t})
	new("IntValue",i893,{Name="ShotCount",Value=1})
	new("StringValue",i893,{Name="Rarity",Value="legendary"})
	new("BoolValue",i893,{Name="Dismember"})
	new("StringValue",i893,{Name="AmmoType",Value="pistol"})
	i911=new("Part",i881,{Name="Union",Anchored=t,BrickColor=bc(26),CFrame=cf(-1141.1527099609375,-20.687255859375,491.9512939453125,0,0,-1,0,1,0,1,0,0),Material=272,Rotation=v3(0,-90,0),Size=v3(0.26049521565437317,1.261330008506775,3.9759206771850586)})
	new("IntValue",i911,{Name="Slot1"})
	new("FileMesh",i911,{MeshId="rbxassetid://439458633"})
	i914=new("Part",i881,{Name="Bolt",Anchored=t,BrickColor=bc(26),CFrame=cf(-1140.1070556640625,-20.169189453125,491.88916015625,0,0,-1,0,1,0,1,0,0),Material=272,Rotation=v3(0,-90,0),Size=v3(0.31302398443222046,0.2002699375152588,1.0653998851776123)})
	new("FileMesh",i914,{MeshId="rbxassetid://439458926"})
	i916=new("Part",i881,{Name="Iron",Anchored=t,BrickColor=bc(26),CFrame=cf(-1140.2298583984375,-20.001102447509766,491.951171875,0,0,-1,0,1,0,1,0,0),Material=272,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.2621605396270752,2.3814101219177246)})
	new("FileMesh",i916,{MeshId="rbxassetid://439458886"})
	i918=new("Part",i881,{Name="Union",Anchored=t,BrickColor=bc(26),CFrame=cf(-1140.1248779296875,-20.348270416259766,491.9512939453125,0,0,-1,0,1,0,1,0,0),Material=272,Rotation=v3(0,-90,0),Size=v3(0.21841789782047272,0.6244399547576904,2.7523999214172363)})
	new("IntValue",i918,{Name="Slot1"})
	new("FileMesh",i918,{MeshId="rbxassetid://439458842"})
	i921=new("Part",i881,{Name="Mag",Anchored=t,BrickColor=bc(302),CFrame=cf(-1140.2640380859375,-21.0087890625,491.950439453125,0,0,-1,0,1,0,1,0,0),Material=272,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,1.4222599267959595,0.5637202262878418)})
	new("IntValue",i921,{Name="Slot2"})
	new("FileMesh",i921,{MeshId="rbxassetid://439458720"})
	new("Part",i881,{Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1142.5809326171875,-19.9649658203125,491.951416015625,-0.000030000013794051483,0.000030000013794051483,-1,0.0010680004488676786,0.999999463558197,0.00002996795592480339,0.999999463558197,-0.001067999517545104,-0.000030032035283511505),CanCollide=t,Material=1088,Rotation=v3(-0.061000000685453415,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Part",i881,{Name="Trigger",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1140.9925537109375,-20.743167877197266,491.9512939453125,-0.000030000013794051483,0.000030000013794051483,-1,0.0010680004488676786,0.999999463558197,0.00002996795592480339,0.999999463558197,-0.001067999517545104,-0.000030032035283511505),CanCollide=t,Material=1088,Rotation=v3(-0.061000000685453415,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i926=new("Part",i881,{Name="Union",Anchored=t,BrickColor=bc(302),CFrame=cf(-1140.3367919921875,-20.49720001220703,491.9501953125,0,0,-1,0,1,0,1,0,0),Material=272,Rotation=v3(0,-90,0),Size=v3(0.20443961024284363,0.7507498264312744,2.2820000648498535)})
	new("FileMesh",i926,{MeshId="rbxassetid://439460394"})
	i928=new("Part",i881,{Name="BoltBack",Anchored=t,BrickColor=bc(26),CFrame=cf(-1140.4656982421875,-20.169189453125,491.88916015625,0,0,-1,0,1,0,1,0,0),Material=272,Rotation=v3(0,-90,0),Size=v3(0.31302398443222046,0.2002699375152588,1.0653998851776123),Transparency=1})
	new("FileMesh",i928,{MeshId="rbxassetid://439458926"})
	new("Part",i881,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1140.5306396484375,-20.2248592376709,492.05712890625,1,0,0,0,1,0,0,0,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i931=new("Model",i1,{Name="Jon's MK12"})
	i932=new("Folder",i931,{Name="Settings"})
	new("IntValue",i932,{Name="Recoil",Value=1})
	new("IntValue",i932,{Name="StoredAmmo",Value=30})
	new("IntValue",i932,{Name="Mag",Value=6})
	new("BoolValue",i932,{Name="Auto"})
	new("NumberValue",i932,{Name="FireRate",Value=0.07})
	new("IntValue",i932,{Name="FireMode",Value=2})
	new("BoolValue",i932,{Name="CanSelectFire"})
	new("IntValue",i932,{Name="Ammo",Value=31})
	new("IntValue",i932,{Name="AimZoom",Value=10})
	new("IntValue",i932,{Name="Drop",Value=135})
	new("IntValue",i932,{Name="CycleZoom",Value=50})
	new("StringValue",i932,{Name="RifleOrPistol"})
	new("BoolValue",i932,{Name="IsGun",Value=t})
	new("IntValue",i932,{Name="ShotCount",Value=1})
	new("StringValue",i932,{Name="Rarity",Value="legendary"})
	new("BoolValue",i932,{Name="Dismember"})
	new("StringValue",i932,{Name="AmmoType",Value="rifle"})
	i950=new("Part",i931,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1141.0194091796875,-21.380008697509766,494.2911376953125,6.184563972055912e-09,-6.315860900940606e-08,-1,-1.9952072705109458e-07,1,-6.315858058769663e-08,1,1.9952032914716256e-07,6.184563972055912e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i950,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i950,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i950,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i950,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i950,{Name="Fire",Pitch=0.8999999761581421,PlaybackSpeed=0.8999999761581421,SoundId="rbxassetid://620716624",Volume=4})
	i956=new("Part",i931,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1138.0164794921875,-20.7462158203125,494.3359375,5.4933479987084866e-08,-3.3355949113911265e-08,-1,-6.622881443263395e-08,1,-3.3355917139488156e-08,1,6.62289565411811e-08,5.4933479987084866e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i956,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i956,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i956,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i956,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	i961=new("Part",i931,{Name="Bolt",Anchored=t,BottomSurface=0,BrickColor=bc(199),CFrame=cf(-1140.9359130859375,-20.679811477661133,494.330078125,1,0,0,0,1,0,0,0,1),Material=272,Size=v3(0.9200001955032349,0.26999998092651367,0.240000382065773),TopSurface=0})
	new("SpecialMesh",i961,{MeshId="rbxassetid://2035837217",MeshType=5})
	i963=new("Part",i931,{Name="Mag",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1140.6195068359375,-21.207883834838867,494.319091796875,1,0,0,0,1,0,0,0,1),Material=272,Size=v3(0.46000057458877563,1,0.07999998331069946),TopSurface=0})
	new("SpecialMesh",i963,{MeshId="rbxassetid://2035809004",MeshType=5})
	i965=new("Part",i931,{Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1140.3226318359375,-21.0078182220459,494.3350830078125,1,0,0,0,1,0,0,0,1),Size=v3(4,1,2),TopSurface=0})
	new("SpecialMesh",i965,{MeshId="rbxassetid://2035830037",MeshType=5})
	i967=new("Part",i931,{Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1140.7166748046875,-20.893924713134766,494.3541259765625,1,0,0,0,1,0,0,0,1),Size=v3(4,0.6200000047683716,0.16000008583068848),TopSurface=0})
	new("SpecialMesh",i967,{MeshId="rbxassetid://2035820815",MeshType=5})
	i969=new("Part",i931,{Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1140.0096435546875,-21.163087844848633,494.3240966796875,-1,0,0,0,1,0,0,0,-1),Rotation=v3(180,0,180),Size=v3(0.18000000715255737,1,0.09000000357627869),TopSurface=0})
	new("SpecialMesh",i969,{MeshId="rbxassetid://2035846922",MeshType=5})
	i971=new("Part",i931,{Name="BoltBack",Anchored=t,BottomSurface=0,BrickColor=bc(199),CFrame=cf(-1141.2818603515625,-20.679811477661133,494.330078125,1,0,0,0,1,0,0,0,1),Material=272,Size=v3(0.9200001955032349,0.26999998092651367,0.240000382065773),TopSurface=0,Transparency=1})
	new("SpecialMesh",i971,{MeshId="rbxassetid://2035837217",MeshType=5})
	new("Part",i931,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1140.6800537109375,-20.7125301361084,494.36083984375,1,0,0,0,1,0,0,0,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i974=new("Part",i931,{CustomPhysicalProperties=PhysicalProperties.new(7.849999904632568,0.30000001192092896,0,1,1),Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1142.0521240234375,-20.378787994384766,494.332275390625,-0.00014000000373926014,0,-1,-0.000043000000005122274,1,6.0200000540078236e-09,1,0.000043000000005122274,-0.00014000000373926014),CanCollide=t,Material=1088,Rotation=v3(0.0020000000949949026,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("BlockMesh",i974,{Scale=v3(0.47999998927116394,0.47999998927116394,0.47999998927116394)})
	i976=new("Part",i931,{Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1140.9407958984375,-20.4218807220459,494.330078125,1,0,0,0,1,0,0,0,1),Size=v3(0.9700002670288086,0.42999985814094543,0.2400001585483551),TopSurface=0})
	new("SpecialMesh",i976,{MeshId="rbxassetid://2035852320",MeshType=5})
	i978=new("Part",i931,{CustomPhysicalProperties=PhysicalProperties.new(7.849999904632568,0.30000001192092896,0,1,1), Name="Reticle",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1140.4432373046875,-20.378787994384766,494.332275390625,-1,-0.00003100272806477733,0.000029997177989571355,-0.00003099999958067201,1,0.00009100093302549794,-0.000029999999242136255,0.00009100000170292333,-1),CanCollide=t,Material=1088,Rotation=v3(-179.9949951171875,0.0020000000949949026,179.9980010986328),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i979=new("SurfaceGui",i978,{CanvasSize=v2(100,100),Face=0})
	new("ImageLabel",i979,{BackgroundColor3=c3(1,1,1),BackgroundTransparency=1,BorderColor3=c3(1,1,1),BorderSizePixel=0,Size=ud2(1,0,1,0),Image="rbxassetid://657305296"})
	new("BlockMesh",i978,{Scale=v3(0.024000000208616257,0.6000000238418579,0.6000000238418579)})
	i982=new("Model",i1,{Name="MP5SD"})
	i983=new("Part",i982,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1138.001220703125,-20.319826126098633,492.90966796875,5.493356169949948e-08,-3.335593135034287e-08,-1,-6.623014314754982e-08,1,-3.335593490305655e-08,1,6.623015025297718e-08,5.49335581467858e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i983,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i983,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i983,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i983,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	i988=new("Part",i982,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1140.8909912109375,-21.105472564697266,492.8929748535156,6.177397260387352e-09,-6.315859479855135e-08,-1,-1.9952237551024155e-07,1,-6.315859479855135e-08,1,1.9952237551024155e-07,6.177385269978686e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i988,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i988,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i988,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i988,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i988,{Name="Fire",Pitch=3,PlaybackSpeed=3,SoundId="rbxassetid://896335161",Volume=0.30000001192092896})
	i994=new("Folder",i982,{Name="Settings"})
	new("IntValue",i994,{Name="Recoil",Value=1})
	new("IntValue",i994,{Name="StoredAmmo",Value=31})
	new("IntValue",i994,{Name="Mag",Value=10})
	new("BoolValue",i994,{Name="Auto",Value=t})
	new("NumberValue",i994,{Name="FireRate",Value=0.06})
	new("IntValue",i994,{Name="FireMode",Value=1})
	new("BoolValue",i994,{Name="CanSelectFire",Value=t})
	new("IntValue",i994,{Name="Ammo",Value=31})
	new("IntValue",i994,{Name="AimZoom",Value=35})
	new("IntValue",i994,{Name="Drop",Value=135})
	new("IntValue",i994,{Name="CycleZoom",Value=50})
	new("StringValue",i994,{Name="RifleOrPistol"})
	new("BoolValue",i994,{Name="IsGun",Value=t})
	new("IntValue",i994,{Name="ShotCount",Value=1})
	new("StringValue",i994,{Name="Rarity",Value="mythical"})
	new("BoolValue",i994,{Name="Dismember"})
	new("StringValue",i994,{Name="AmmoType",Value="pistol"})
	i1012=new("Part",i982,{Name="Bolt",Anchored=t,BrickColor=bc(149),CFrame=cf(-1140.1070556640625,-20.1956787109375,492.8349609375,0,0,-1,0,1,0,1,0,0),Material=272,Rotation=v3(0,-90,0),Size=v3(0.31302398443222046,0.2002699375152588,1.0653998851776123)})
	new("FileMesh",i1012,{MeshId="rbxassetid://439458926"})
	i1014=new("Part",i982,{Name="BoltBack",Anchored=t,BrickColor=bc(149),CFrame=cf(-1140.4656982421875,-20.1956787109375,492.8349609375,0,0,-1,0,1,0,1,0,0),Material=272,Rotation=v3(0,-90,0),Size=v3(0.31302398443222046,0.2002699375152588,1.0653998851776123),Transparency=1})
	new("FileMesh",i1014,{MeshId="rbxassetid://439458926"})
	i1016=new("Part",i982,{Name="Mag",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1140.2537841796875,-21.0340633392334,492.9000244140625,0,0,-1,0,1,0,1,0,0),Material=272,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,1.4222352504730225,0.5637170076370239)})
	new("FileMesh",i1016,{MeshId="rbxassetid://439450219"})
	new("IntValue",i1016,{Name="Slot2"})
	i1019=new("Part",i982,{Name="Union",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1140.2523193359375,-20.3713436126709,492.8997802734375,0,0,-1,0,1,0,1,0,0),Material=272,Rotation=v3(0,-90,0),Size=v3(0.21841588616371155,0.6241400241851807,2.4756031036376953)})
	new("IntValue",i1019,{Name="Slot1"})
	new("FileMesh",i1019,{MeshId="rbxassetid://439450485"})
	i1022=new("Part",i982,{Name="Union",Anchored=t,BrickColor=bc(26),CFrame=cf(-1140.9613037109375,-20.5223445892334,492.8978271484375,0,0,-1,0,1,0,1,0,0),Material=272,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.7507409453392029,1.0136001110076904)})
	new("FileMesh",i1022,{MeshId="rbxassetid://439450389"})
	i1024=new("Part",i982,{Name="Iron",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1140.2200927734375,-20.0262508392334,492.9005126953125,0,0,-1,0,1,0,1,0,0),Material=272,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.26216042041778564,2.38140606880188)})
	new("FileMesh",i1024,{MeshId="rbxassetid://439450068"})
	i1026=new("Part",i982,{Name="Union",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1140.6024169921875,-20.712406158447266,492.8997802734375,0,0,-1,0,1,0,1,0,0),Material=272,Rotation=v3(0,-90,0),Size=v3(0.285645991563797,1.2613310813903809,5.057310104370117)})
	new("IntValue",i1026,{Name="Slot1"})
	new("FileMesh",i1026,{MeshId="rbxassetid://439450150"})
	new("Part",i982,{Name="Trigger",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1140.9822998046875,-20.768314361572266,492.9007568359375,-0.000030000021070009097,0.000029999988328199834,-1,0.0008850006270222366,0.9999996423721313,0.000029973425625939853,0.9999997019767761,-0.0008849997539073229,-0.000030026556487428024),CanCollide=t,Material=1088,Rotation=v3(-0.050999999046325684,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Part",i982,{Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1142.5799560546875,-19.99024200439453,492.9007568359375,-0.000030000021070009097,0.000029999988328199834,-1,0.0008850006270222366,0.9999996423721313,0.000029973425625939853,0.9999997019767761,-0.0008849997539073229,-0.000030026556487428024),CanCollide=t,Material=1088,Rotation=v3(-0.050999999046325684,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Part",i982,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1140.5306396484375,-20.225587844848633,492.9014892578125,1,0,0,0,1,0,0,0,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i1032=new("Model",i1,{Name="Beef Jerky"})
	i1033=new("Part",i1032,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1002),CFrame=cf(-1165.8270263671875,-20.959962844848633,468.26708984375,1,0,0,0,1,0,0,0,1),Size=v3(1.470000147819519,1.5199995040893555,1),TopSurface=0,FormFactor=2})
	new("SpecialMesh",i1033,{Scale=v3(0.800000011920929,0.800000011920929,0.6000000238418579),MeshId="http://www.roblox.com/asset/?id=19106014",TextureId="http://www.roblox.com/asset/?id=282807070",MeshType=5})
	new("Sound",i1033,{Name="DrinkSound",SoundId="http://www.roblox.com/asset/?id=12544690",Volume=0.30000001192092896})
	i1036=new("Folder",i1032,{Name="Settings"})
	new("BoolValue",i1036,{Name="IsGun"})
	new("StringValue",i1036,{Name="Rarity",Value="uncommon"})
	new("NumberValue",i1036,{Name="Healing",Value=27})
	new("StringValue",i1036,{Name="Type",Value="food"})
	i1041=new("Model",i1,{Name="Candy"})
	new("Part",i1041,{Name="Handle",Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(343),CFrame=cf(-1161.6224365234375,-21.6386775970459,466.0858154296875,-1,0,0,0,1,0,0,0,-1),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(180,0,180),Size=v3(1.4900007247924805,0.16254553198814392,0.4972730278968811),TopSurface=10})
	i1043=new("Folder",i1041,{Name="Settings"})
	new("BoolValue",i1043,{Name="IsGun"})
	new("StringValue",i1043,{Name="Rarity",Value="uncommon"})
	new("NumberValue",i1043,{Name="Healing",Value=20})
	new("StringValue",i1043,{Name="Type",Value="food"})
	i1048=new("Model",i1,{Name="Chocolate"})
	i1049=new("Part",i1048,{Name="Handle",Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(192),CFrame=cf(-1161.3226318359375,-21.6386775970459,468.2757568359375,-1,0,0,0,1,0,0,0,-1),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(180,0,180),Size=v3(1.4900007247924805,0.16254553198814392,0.6772730946540833),TopSurface=10})
	new("Decal",i1049,{Face=1,Texture="http://www.roblox.com/asset/?id=4473691"})
	i1051=new("Folder",i1048,{Name="Settings"})
	new("BoolValue",i1051,{Name="IsGun"})
	new("StringValue",i1051,{Name="Rarity",Value="uncommon"})
	new("NumberValue",i1051,{Name="Healing",Value=20})
	new("StringValue",i1051,{Name="Type",Value="food"})
	i1056=new("Model",i1,{Name="Canned Water"})
	i1057=new("Part",i1056,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(311),CFrame=cf(-1163.7772216796875,-21.1200008392334,466.357177734375,0,0,-1,0,1,0,1,0,0),Rotation=v3(0,-90,0),Size=v3(1,1.2000000476837158,1),TopSurface=0,FormFactor=2})
	new("SpecialMesh",i1057,{MeshId="http://www.roblox.com/asset/?id=28501599",MeshType=5})
	i1059=new("Folder",i1056,{Name="Settings"})
	new("BoolValue",i1059,{Name="IsGun"})
	new("StringValue",i1059,{Name="Rarity",Value="common"})
	new("NumberValue",i1059,{Name="Healing",Value=15})
	new("StringValue",i1059,{Name="Type",Value="drink"})
	i1064=new("Model",i1,{Name="Bloxxy-Cola"})
	i1065=new("Folder",i1064,{Name="Settings"})
	new("BoolValue",i1065,{Name="IsGun"})
	new("StringValue",i1065,{Name="Rarity",Value="common"})
	new("NumberValue",i1065,{Name="Healing",Value=15})
	new("StringValue",i1065,{Name="Type",Value="drink"})
	i1070=new("Part",i1064,{Name="Handle",Anchored=t,BottomSurface=0,CFrame=cf(-1166.4871826171875,-21.219970703125,466.587158203125,-1,0,0,0,1,0,0,0,-1),Rotation=v3(180,0,180),Size=v3(1,1.3199999332427979,1),TopSurface=0})
	new("SpecialMesh",i1070,{Scale=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),MeshId="rbxassetid://1032879482",TextureId="rbxassetid://1032879491",MeshType=5})
	i1072=new("Model",i1,{Name="Edible Gold"})
	new("Part",i1072,{Name="Handle",Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(333),CFrame=cf(-1163.4822998046875,-21.453739166259766,468.40576171875,-1,0,0,0,1,0,0,0,-1),FrontSurface=10,LeftSurface=10,Material=1088,RightSurface=10,Rotation=v3(180,0,180),Size=v3(1.4900007247924805,0.5325457453727722,0.6772730946540833),TopSurface=10})
	i1074=new("Folder",i1072,{Name="Settings"})
	new("BoolValue",i1074,{Name="IsGun"})
	new("StringValue",i1074,{Name="Rarity",Value="mythical"})
	new("NumberValue",i1074,{Name="Healing",Value=10000})
	new("StringValue",i1074,{Name="Type",Value="food"})
	i1079=new("Model",i1,{Name="SKS"})
	i1080=new("Folder",i1079,{Name="Settings"})
	new("IntValue",i1080,{Name="Recoil",Value=1})
	new("IntValue",i1080,{Name="StoredAmmo",Value=31})
	new("IntValue",i1080,{Name="Mag",Value=6})
	new("BoolValue",i1080,{Name="Auto"})
	new("NumberValue",i1080,{Name="FireRate",Value=0.07})
	new("IntValue",i1080,{Name="FireMode",Value=2})
	new("BoolValue",i1080,{Name="CanSelectFire"})
	new("IntValue",i1080,{Name="Ammo",Value=31})
	new("IntValue",i1080,{Name="AimZoom",Value=10})
	new("IntValue",i1080,{Name="Drop",Value=135})
	new("IntValue",i1080,{Name="CycleZoom",Value=50})
	new("StringValue",i1080,{Name="RifleOrPistol"})
	new("BoolValue",i1080,{Name="IsGun",Value=t})
	new("IntValue",i1080,{Name="ShotCount",Value=1})
	new("StringValue",i1080,{Name="Rarity",Value="uncommon"})
	new("BoolValue",i1080,{Name="Dismember"})
	new("StringValue",i1080,{Name="AmmoType",Value="rifle"})
	i1098=new("Part",i1079,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1139.7667236328125,-21.2098445892334,516.456787109375,6.184563972055912e-09,-6.31586019039787e-08,-1,-1.9952072705109458e-07,1,-6.315858769312399e-08,1,1.9952032914716256e-07,6.184563972055912e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i1098,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i1098,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i1098,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i1098,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i1098,{Name="Fire",SoundId="rbxassetid://165432937",Volume=4})
	i1104=new("Part",i1079,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1134.9378662109375,-20.600831985473633,516.420654296875,5.4933479987084866e-08,-3.335594200848391e-08,-1,-6.622881443263395e-08,1,-3.3355924244915514e-08,1,6.62289565411811e-08,5.4933479987084866e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i1104,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i1104,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i1104,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i1104,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	new("Part",i1079,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1139.1268310546875,-20.5151424407959,516.531005859375,1,-1.0658141036401503e-14,0,-1.0658141036401503e-14,1,5.860116536991755e-13,0,5.860130631619997e-13,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i1110=new("Part",i1079,{CustomPhysicalProperties=PhysicalProperties.new(7.849999904632568,0.30000001192092896,0,1,1), Name="Reticle",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1139.3778076171875,-20.232789993286133,516.433349609375,-1,-0.00003100272806477733,0.000029997177989571355,-0.00003099999958067201,1,0.00009100093302549794,-0.000029999999242136255,0.00009100000170292333,-1),CanCollide=t,Material=1088,Rotation=v3(-179.9949951171875,0.0020000000949949026,179.9980010986328),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i1111=new("SurfaceGui",i1110,{CanvasSize=v2(100,100),Face=0})
	new("ImageLabel",i1111,{BackgroundColor3=c3(1,1,1),BackgroundTransparency=1,BorderColor3=c3(1,1,1),BorderSizePixel=0,Size=ud2(1,0,1,0),Image="rbxassetid://657305296"})
	new("BlockMesh",i1110,{Scale=v3(0.024000000208616257,0.6000000238418579,0.6000000238418579)})
	i1114=new("Part",i1079,{Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1139.8753662109375,-20.275882720947266,516.43115234375,1,0,0,0,1,0,0,0,1),Size=v3(0.9700002670288086,0.42999985814094543,0.2400001585483551),TopSurface=0})
	new("SpecialMesh",i1114,{MeshId="rbxassetid://2035852320",MeshType=5})
	i1116=new("Part",i1079,{CustomPhysicalProperties=PhysicalProperties.new(7.849999904632568,0.30000001192092896,0,1,1),Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1141.1229248046875,-20.232789993286133,516.433349609375,-0.00014000000373926014,0,-1,-0.000043000000005122274,1,6.0200000540078236e-09,1,0.000043000000005122274,-0.00014000000373926014),CanCollide=t,Material=1088,Rotation=v3(0.0020000000949949026,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("BlockMesh",i1116,{Scale=v3(0.47999998927116394,0.47999998927116394,0.47999998927116394)})
	i1118=new("Part",i1079,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1140.2347412109375,-21.1844482421875,516.432861328125,1,-0.00009155226871371269,-0.00003051897510886192,0.00009155320003628731,1,0.000030516181141138077,0.000030516181141138077,-0.00003051897510886192,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,0.004999999888241291),Size=v3(0.41400146484375,0.656728982925415,0.20000000298023224)})
	new("IntValue",i1118,{Name="Slot2"})
	new("FileMesh",i1118,{MeshId="rbxassetid://479987974"})
	i1121=new("Part",i1079,{Name="Mag",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1138.8270263671875,-21.14234161376953,516.432861328125,1,-0.00009155226871371269,-0.00003051897510886192,0.00009155320003628731,1,0.000030516181141138077,0.000030516181141138077,-0.00003051897510886192,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,0.004999999888241291),Size=v3(0.7969970703125,1.1881802082061768,0.20000000298023224)})
	new("IntValue",i1121,{Name="Slot2"})
	new("FileMesh",i1121,{MeshId="rbxassetid://479987940"})
	i1124=new("Part",i1079,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1141.4461669921875,-20.960575103759766,516.4327392578125,1,-0.00009155226871371269,-0.00003051897510886192,0.00009155320003628731,1,0.000030516181141138077,0.000030516181141138077,-0.00003051897510886192,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,0.004999999888241291),Size=v3(0.9720306396484375,0.7293070554733276,0.20000000298023224)})
	new("IntValue",i1124,{Name="Slot1"})
	new("FileMesh",i1124,{MeshId="rbxassetid://479994021"})
	i1127=new("Part",i1079,{Name="Bolt",Anchored=t,BrickColor=bc(26),CFrame=cf(-1139.1722412109375,-20.56641387939453,516.501708984375,1,-0.00009155226871371269,-0.00003051897510886192,0.00009155320003628731,1,0.000030516181141138077,0.000030516181141138077,-0.00003051897510886192,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,0.004999999888241291),Size=v3(0.8610076904296875,0.3170797824859619,0.31800079345703125)})
	new("FileMesh",i1127,{MeshId="rbxassetid://479988025"})
	i1129=new("Part",i1079,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1138.8118896484375,-20.5733699798584,516.432861328125,1,-0.00009155226871371269,-0.00003051897510886192,0.00009155320003628731,1,0.000030516181141138077,0.000030516181141138077,-0.00003051897510886192,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,0.004999999888241291),Size=v3(2.949005126953125,0.43017101287841797,0.21300506591796875)})
	new("IntValue",i1129,{Name="Slot2"})
	new("FileMesh",i1129,{MeshId="rbxassetid://479988197"})
	i1132=new("Part",i1079,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1138.1951904296875,-20.706424713134766,516.423583984375,1,-0.00009155226871371269,-0.00003051897510886192,0.00009155320003628731,1,0.000030516181141138077,0.000030516181141138077,-0.00003051897510886192,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,0.004999999888241291),Size=v3(6.465057373046875,0.7975360751152039,0.23302459716796875)})
	new("IntValue",i1132,{Name="Slot2"})
	new("FileMesh",i1132,{MeshId="rbxassetid://479993055"})
	new("Part",i1079,{Name="Trigger",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1139.8572998046875,-20.955690383911133,516.4332275390625,-0.00003266368730692193,-0.000043158150219824165,-1,-9.295133551745494e-10,1,-0.000043158150219824165,1,-4.801909980756136e-10,-0.00003266368730692193),CanCollide=t,Material=272,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i1136=new("Part",i1079,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1139.0081787109375,-20.610353469848633,516.4326171875,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(3.284900665283203,0.5012503862380981,0.2220001220703125)})
	new("IntValue",i1136,{Name="Slot1"})
	new("FileMesh",i1136,{MeshId="rbxassetid://481640404"})
	new("Snap",i1136,{C0=cf(0,-0.2506251931190491,0,1,0,0,0,0,-1,0,1,0),C1=cf(1.2265625,0.32332843542099,-0.00018310546875,1,1.862645149230957e-09,-0.0001220703125,-0.0001220703125,1.862645149230957e-09,-1,-1.862645149230957e-09,1,1.862645149230957e-09)})
	i1140=new("Part",i1079,{Name="BoltBack",Anchored=t,BrickColor=bc(26),CFrame=cf(-1139.5755615234375,-20.56641387939453,516.501708984375,1,-0.00009155226871371269,-0.00003051897510886192,0.00009155320003628731,1,0.000030516181141138077,0.000030516181141138077,-0.00003051897510886192,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,0.004999999888241291),Size=v3(0.8610076904296875,0.3170797824859619,0.31800079345703125),Transparency=1})
	new("FileMesh",i1140,{MeshId="rbxassetid://479988025"})
	i1142=new("Model",i1,{Name="Honey"})
	i1143=new("Part",i1142,{CustomPhysicalProperties=PhysicalProperties.new(0.699999988079071,2,0,1,1),Name="Handle",Anchored=t,BackParamA=-99999,BackParamB=99999,BackSurface=10,BottomParamA=-99999,BottomParamB=99999,BottomSurface=10,BrickColor=bc(1005),CFrame=cf(-1170.8870849609375,-20.8700008392334,468.9671630859375,1,0,0,0,1,0,0,0,1),FrontParamA=-99999,FrontParamB=99999,FrontSurface=10,LeftParamA=-99999,LeftParamB=99999,LeftSurface=10,Material=272,RightParamA=-99999,RightParamB=99999,RightSurface=10,Size=v3(0.800000011920929,1.7000001668930054,0.30000001192092896),TopParamA=-99999,TopParamB=99999,TopSurface=10,FormFactor=3})
	new("SpecialMesh",i1143,{MeshId="http://www.roblox.com/asset/?id=115289510",MeshType=5})
	i1145=new("Part",i1142,{CustomPhysicalProperties=PhysicalProperties.new(0.699999988079071,2,0,1,1), Name="Lid",Anchored=t,BackParamA=-99999,BackParamB=99999,BackSurface=10,BottomParamA=-99999,BottomParamB=99999,BottomSurface=10,BrickColor=bc(26),CFrame=cf(-1170.8870849609375,-20.239992141723633,468.9671630859375,1.0000004768371582,2.980357294291025e-08,-1.490070644649677e-08,2.980357294291025e-08,0.9999996423721313,-8.940696716308594e-08,-1.4900592759659048e-08,-8.940696716308594e-08,0.9999991655349731),CanCollide=t,FrontParamA=-99999,FrontParamB=99999,FrontSurface=10,LeftParamA=-99999,LeftParamB=99999,LeftSurface=10,Material=272,RightParamA=-99999,RightParamB=99999,RightSurface=10,Size=v3(0.800000011920929,0.20000000298023224,0.800000011920929),TopParamA=-99999,TopParamB=99999,TopSurface=10,FormFactor=3})
	new("SpecialMesh",i1145,{MeshId="http://www.roblox.com/asset/?id=115296503",MeshType=5})
	i1147=new("Folder",i1142,{Name="Settings"})
	new("BoolValue",i1147,{Name="IsGun"})
	new("StringValue",i1147,{Name="Rarity",Value="rare"})
	new("NumberValue",i1147,{Name="Healing",Value=40})
	new("StringValue",i1147,{Name="Type",Value="food"})
	i1152=new("Model",i1,{Name="Jar of Pickles"})
	i1153=new("Part",i1152,{CustomPhysicalProperties=PhysicalProperties.new(0.699999988079071,2,0,1,1),Name="Handle",Anchored=t,BackParamA=-99999,BackParamB=99999,BackSurface=10,BottomParamA=-99999,BottomParamB=99999,BottomSurface=10,BrickColor=bc(313),CFrame=cf(-1167.8870849609375,-20.8700008392334,468.4671630859375,1,0,0,0,1,0,0,0,1),FrontParamA=-99999,FrontParamB=99999,FrontSurface=10,LeftParamA=-99999,LeftParamB=99999,LeftSurface=10,Material=272,RightParamA=-99999,RightParamB=99999,RightSurface=10,Size=v3(0.800000011920929,1.7000001668930054,0.800000011920929),TopParamA=-99999,TopParamB=99999,TopSurface=10,FormFactor=3})
	new("SpecialMesh",i1153,{MeshId="http://www.roblox.com/asset/?id=115289510",TextureId="http://www.roblox.com/asset/?id=155917040",MeshType=5})
	i1155=new("Part",i1152,{CustomPhysicalProperties=PhysicalProperties.new(0.699999988079071,2,0,1,1),Name="Lid",Anchored=t,BackParamA=-99999,BackParamB=99999,BackSurface=10,BottomParamA=-99999,BottomParamB=99999,BottomSurface=10,BrickColor=bc(26),CFrame=cf(-1167.8870849609375,-20.239992141723633,468.4671630859375,1.0000004768371582,2.980357294291025e-08,-1.490070644649677e-08,2.980357294291025e-08,0.9999996423721313,-8.940696716308594e-08,-1.4900592759659048e-08,-8.940696716308594e-08,0.9999991655349731),CanCollide=t,FrontParamA=-99999,FrontParamB=99999,FrontSurface=10,LeftParamA=-99999,LeftParamB=99999,LeftSurface=10,Material=272,RightParamA=-99999,RightParamB=99999,RightSurface=10,Size=v3(0.800000011920929,0.20000000298023224,0.800000011920929),TopParamA=-99999,TopParamB=99999,TopSurface=10,FormFactor=3})
	new("SpecialMesh",i1155,{MeshId="http://www.roblox.com/asset/?id=115296503",MeshType=5})
	i1157=new("Folder",i1152,{Name="Settings"})
	new("BoolValue",i1157,{Name="IsGun"})
	new("StringValue",i1157,{Name="Rarity",Value="uncommon"})
	new("NumberValue",i1157,{Name="Healing",Value=27})
	new("StringValue",i1157,{Name="Type",Value="food"})
	i1162=new("Model",i1,{Name="Dr. Pepper"})
	i1163=new("Part",i1162,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(23),CFrame=cf(-1165.2171630859375,-21.1200008392334,466.877197265625,0,0,-1,0,1,0,1,0,0),Rotation=v3(0,-90,0),Size=v3(1,1.2000000476837158,1),TopSurface=0,FormFactor=2})
	new("SpecialMesh",i1163,{MeshId="http://www.roblox.com/asset/?id=28501599",TextureId="http://www.roblox.com/asset/?id=29613198",MeshType=5})
	i1165=new("Folder",i1162,{Name="Settings"})
	new("BoolValue",i1165,{Name="IsGun"})
	new("StringValue",i1165,{Name="Rarity",Value="common"})
	new("NumberValue",i1165,{Name="Healing",Value=15})
	new("StringValue",i1165,{Name="Type",Value="drink"})
	i1170=new("Model",i1,{Name="Protein Powder"})
	i1171=new("Part",i1170,{CustomPhysicalProperties=PhysicalProperties.new(0.699999988079071,2,0,1,1),Name="Handle",Anchored=t,BackParamA=-99999,BackParamB=99999,BackSurface=10,BottomParamA=-99999,BottomParamB=99999,BottomSurface=10,BrickColor=bc(1001),CFrame=cf(-1170.3870849609375,-20.8700008392334,466.4671630859375,1,0,0,0,1,0,0,0,1),FrontParamA=-99999,FrontParamB=99999,FrontSurface=10,LeftParamA=-99999,LeftParamB=99999,LeftSurface=10,Material=272,RightParamA=-99999,RightParamB=99999,RightSurface=10,Size=v3(0.800000011920929,1.7000001668930054,0.800000011920929),TopParamA=-99999,TopParamB=99999,TopSurface=10,FormFactor=3})
	new("SpecialMesh",i1171,{Scale=v3(1.5,1,1.5),MeshId="http://www.roblox.com/asset/?id=115289510",MeshType=5})
	i1173=new("Part",i1170,{CustomPhysicalProperties=PhysicalProperties.new(0.699999988079071,2,0,1,1),Name="Lid",Anchored=t,BackParamA=-99999,BackParamB=99999,BackSurface=10,BottomParamA=-99999,BottomParamB=99999,BottomSurface=10,BrickColor=bc(26),CFrame=cf(-1170.3870849609375,-20.239992141723633,466.4671630859375,1.0000004768371582,2.980357294291025e-08,-1.490070644649677e-08,2.980357294291025e-08,0.9999996423721313,-8.940696716308594e-08,-1.4900592759659048e-08,-8.940696716308594e-08,0.9999991655349731),CanCollide=t,FrontParamA=-99999,FrontParamB=99999,FrontSurface=10,LeftParamA=-99999,LeftParamB=99999,LeftSurface=10,Material=272,RightParamA=-99999,RightParamB=99999,RightSurface=10,Size=v3(0.800000011920929,0.20000000298023224,0.800000011920929),TopParamA=-99999,TopParamB=99999,TopSurface=10,FormFactor=3})
	new("SpecialMesh",i1173,{MeshId="http://www.roblox.com/asset/?id=115296503",MeshType=5})
	i1175=new("Folder",i1170,{Name="Settings"})
	new("BoolValue",i1175,{Name="IsGun"})
	new("StringValue",i1175,{Name="Rarity",Value="uncommon"})
	new("NumberValue",i1175,{Name="Healing",Value=45})
	new("StringValue",i1175,{Name="Type",Value="food"})
	i1180=new("Model",i1,{Name="Jar of Peaches"})
	i1181=new("Part",i1180,{CustomPhysicalProperties=PhysicalProperties.new(0.699999988079071,2,0,1,1),Name="Handle",Anchored=t,BackParamA=-99999,BackParamB=99999,BackSurface=10,BottomParamA=-99999,BottomParamB=99999,BottomSurface=10,BrickColor=bc(1014),CFrame=cf(-1169.3870849609375,-20.8700008392334,468.4671630859375,1,0,0,0,1,0,0,0,1),FrontParamA=-99999,FrontParamB=99999,FrontSurface=10,LeftParamA=-99999,LeftParamB=99999,LeftSurface=10,Material=272,RightParamA=-99999,RightParamB=99999,RightSurface=10,Size=v3(0.800000011920929,1.7000001668930054,0.800000011920929),TopParamA=-99999,TopParamB=99999,TopSurface=10,FormFactor=3})
	new("SpecialMesh",i1181,{MeshId="http://www.roblox.com/asset/?id=115289510",MeshType=5})
	i1183=new("Part",i1180,{CustomPhysicalProperties=PhysicalProperties.new(0.699999988079071,2,0,1,1),Name="Lid",Anchored=t,BackParamA=-99999,BackParamB=99999,BackSurface=10,BottomParamA=-99999,BottomParamB=99999,BottomSurface=10,BrickColor=bc(26),CFrame=cf(-1169.3870849609375,-20.239992141723633,468.4671630859375,1.0000004768371582,2.980357294291025e-08,-1.490070644649677e-08,2.980357294291025e-08,0.9999996423721313,-8.940696716308594e-08,-1.4900592759659048e-08,-8.940696716308594e-08,0.9999991655349731),CanCollide=t,FrontParamA=-99999,FrontParamB=99999,FrontSurface=10,LeftParamA=-99999,LeftParamB=99999,LeftSurface=10,Material=272,RightParamA=-99999,RightParamB=99999,RightSurface=10,Size=v3(0.800000011920929,0.20000000298023224,0.800000011920929),TopParamA=-99999,TopParamB=99999,TopSurface=10,FormFactor=3})
	new("SpecialMesh",i1183,{MeshId="http://www.roblox.com/asset/?id=115296503",MeshType=5})
	i1185=new("Folder",i1180,{Name="Settings"})
	new("BoolValue",i1185,{Name="IsGun"})
	new("StringValue",i1185,{Name="Rarity",Value="uncommon"})
	new("NumberValue",i1185,{Name="Healing",Value=27})
	new("StringValue",i1185,{Name="Type",Value="food"})
	i1190=new("Model",i1,{Name="M4A1-S"})
	i1191=new("Folder",i1190,{Name="Settings"})
	new("IntValue",i1191,{Name="Recoil",Value=1})
	new("IntValue",i1191,{Name="StoredAmmo",Value=30})
	new("IntValue",i1191,{Name="Mag",Value=6})
	new("BoolValue",i1191,{Name="Auto",Value=t})
	new("NumberValue",i1191,{Name="FireRate",Value=0.07})
	new("IntValue",i1191,{Name="FireMode",Value=1})
	new("BoolValue",i1191,{Name="CanSelectFire",Value=t})
	new("IntValue",i1191,{Name="Ammo",Value=31})
	new("IntValue",i1191,{Name="AimZoom",Value=35})
	new("IntValue",i1191,{Name="Drop",Value=135})
	new("IntValue",i1191,{Name="CycleZoom",Value=50})
	new("StringValue",i1191,{Name="RifleOrPistol"})
	new("BoolValue",i1191,{Name="IsGun",Value=t})
	new("IntValue",i1191,{Name="ShotCount",Value=1})
	new("StringValue",i1191,{Name="Rarity",Value="mythical"})
	new("BoolValue",i1191,{Name="Dismember"})
	new("StringValue",i1191,{Name="AmmoType",Value="rifle"})
	i1209=new("Part",i1190,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(28.6134033203125,-21.3836727142334,517.5643310546875,6.184563972055912e-09,-6.31586019039787e-08,-1,-1.9952072705109458e-07,1,-6.315858769312399e-08,1,1.9952032914716256e-07,6.184563972055912e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i1209,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i1209,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i1209,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i1209,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i1209,{Name="Fire",SoundId="rbxassetid://2474486094",Volume=1})
	i1215=new("Part",i1190,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(31.4388427734375,-20.813356399536133,517.578857421875,5.4933479987084866e-08,-3.335594200848391e-08,-1,-6.622881443263395e-08,1,-3.3355924244915514e-08,1,6.62289565411811e-08,5.4933479987084866e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i1215,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i1215,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i1215,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i1215,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	new("Part",i1190,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(28.8603515625,-20.840335845947266,517.638427734375,1,-1.0658141036401503e-14,0,-1.0658141036401503e-14,1,5.860116536991755e-13,0,5.860130631619997e-13,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i1221=new("Part",i1190,{Name="MeshPart",Anchored=t,BrickColor=bc(199),CFrame=cf(30.285888671875,-20.793092727661133,517.5821533203125,1,0,0,0,1,0,0,0,1),CanCollide=t,Size=v3(2.2667720317840576,0.2794489860534668,0.2794508934020996)})
	new("IntValue",i1221,{Name="Slot1"})
	new("FileMesh",i1221,{MeshId="rbxassetid://453268328"})
	i1224=new("Part",i1190,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(29.890869140625,-20.673099517822266,517.5821533203125,1,0,0,0,1,0,0,0,1),CanCollide=t,Size=v3(1.308156967163086,0.5618100762367249,0.2902837097644806)})
	new("IntValue",i1224,{Name="Slot2"})
	new("FileMesh",i1224,{MeshId="rbxassetid://453270448"})
	i1227=new("Part",i1190,{Name="MeshPart",Anchored=t,BrickColor=bc(199),CFrame=cf(28.60888671875,-20.9910945892334,517.627197265625,1,0,0,0,1,0,0,0,1),CanCollide=t,Size=v3(1.1019819974899292,0.4742860198020935,0.2895280122756958)})
	new("FileMesh",i1227,{MeshId="rbxassetid://453276973"})
	i1229=new("Part",i1190,{Name="BoltBack",Anchored=t,BrickColor=bc(1003),CFrame=cf(28.136962890625,-20.746091842651367,517.5821533203125,1,0,0,0,1,0,0,0,1),CanCollide=t,Size=v3(1.011212944984436,0.22350001335144043,0.2861981987953186),Transparency=1})
	new("FileMesh",i1229,{MeshId="rbxassetid://453276303"})
	i1231=new("Part",i1190,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(28.1798095703125,-20.959110260009766,517.6171875,1,0,0,0,1,0,0,0,1),CanCollide=t,Size=v3(1.9507580995559692,0.6538670063018799,0.2845156192779541)})
	new("IntValue",i1231,{Name="Slot1"})
	new("FileMesh",i1231,{MeshId="rbxassetid://453290424"})
	i1234=new("Part",i1190,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(27.52490234375,-21.157106399536133,517.5821533203125,1,0,0,0,1,0,0,0,1),CanCollide=t,Size=v3(1.790144920349121,0.9749099612236023,0.20000000298023224)})
	new("IntValue",i1234,{Name="Slot2"})
	new("FileMesh",i1234,{MeshId="rbxassetid://453285796"})
	i1237=new("Part",i1190,{Name="Mag",Anchored=t,BrickColor=bc(1003),CFrame=cf(28.9498291015625,-21.367557525634766,517.5821533203125,0,0,1,0,1,-0,-1,0,0),CanCollide=t,Rotation=v3(0,90,0),Size=v3(0.20000000298023224,1.0249028205871582,0.47074592113494873)})
	new("IntValue",i1237,{Name="Slot2"})
	new("FileMesh",i1237,{MeshId="rbxassetid://453250464"})
	new("Part",i1190,{Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(27.4356689453125,-20.4268856048584,517.58203125,-0.00003266368730692193,0.000043158150219824165,-1,9.295133551745494e-10,1,0.000043158150219824165,1,4.801909980756136e-10,-0.00003266368730692193),CanCollide=t,Material=272,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Part",i1190,{Name="Trigger",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(28.4888916015625,-21.1345272064209,517.5821533203125,-0.00003266368730692193,0.000043158150219824165,-1,9.295133551745494e-10,1,0.000043158150219824165,1,4.801909980756136e-10,-0.00003266368730692193),CanCollide=t,Material=272,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i1242=new("Part",i1190,{Name="Bolt",Anchored=t,BrickColor=bc(1003),CFrame=cf(28.5728759765625,-20.746091842651367,517.5821533203125,1,0,0,0,1,0,0,0,1),CanCollide=t,Size=v3(1.011212944984436,0.22350001335144043,0.2861981987953186)})
	new("FileMesh",i1242,{MeshId="rbxassetid://453276303"})
	new("Snap",i1242,{C0=cf(0,-0.11175000667572021,0,1,0,0,0,0,-1,0,1,0),C1=cf(0,0.5097121000289917,-0.376953125,0,-1,0,0,0,-1,1,0,0)})
	new("Part",i1190,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(30.86083984375,-20.793092727661133,517.5821533203125,1,0,0,0,1,0,0,0,1),CanCollide=t,Material=272,Size=v3(1.176771879196167,0.2794489860534668,0.2794508934020996),Shape=2})
	i1246=new("Model",i1,{Name="Stone Wall"})
	i1247=new("Folder",i1246,{Name="Settings"})
	new("BoolValue",i1247,{Name="IsGun"})
	new("StringValue",i1247,{Name="Rarity",Value="uncommon"})
	new("BoolValue",i1247,{Name="Structure",Value=t})
	new("Part",i1246,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(320),CFrame=cf(-1165.0882568359375,-16.9649658203125,485.144287109375,1,0,0,0,1,0,0,0,1),Material=816,Size=v3(14.700003623962402,9.510000228881836,2),TopSurface=0})
	i1252=new("Model",i1,{Name="Wood Planks"})
	i1253=new("Folder",i1252,{Name="Settings"})
	new("BoolValue",i1253,{Name="IsGun"})
	new("StringValue",i1253,{Name="Rarity",Value="common"})
	new("BoolValue",i1253,{Name="Structure",Value=t})
	new("Part",i1252,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(365),CFrame=cf(-1161.3582763671875,-19.543949127197266,474.3043212890625,1,0,0,0,1,0,0,0,1),Material=512,Size=v3(14.700003623962402,2.3499999046325684,2),TopSurface=0})
	i1258=new("Model",i1,{Name="Steel Wall"})
	i1259=new("Folder",i1258,{Name="Settings"})
	new("BoolValue",i1259,{Name="IsGun"})
	new("StringValue",i1259,{Name="Rarity",Value="rare"})
	new("BoolValue",i1259,{Name="Structure",Value=t})
	new("Part",i1258,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(302),CFrame=cf(-1161.1683349609375,-18.449953079223633,480.3143310546875,1,0,0,0,1,0,0,0,1),Material=1088,Size=v3(21.6200008392334,6.539999961853027,2),TopSurface=0})
	i1264=new("Model",i1,{Name="SCAR-HAMR"})
	i1265=new("Folder",i1264,{Name="Settings"})
	new("IntValue",i1265,{Name="Recoil",Value=1})
	new("IntValue",i1265,{Name="StoredAmmo",Value=76})
	new("IntValue",i1265,{Name="Mag",Value=6})
	new("BoolValue",i1265,{Name="Auto",Value=t})
	new("NumberValue",i1265,{Name="FireRate",Value=0.04000000000000004})
	new("IntValue",i1265,{Name="FireMode",Value=1})
	new("BoolValue",i1265,{Name="CanSelectFire",Value=t})
	new("IntValue",i1265,{Name="Ammo",Value=76})
	new("IntValue",i1265,{Name="AimZoom",Value=35})
	new("IntValue",i1265,{Name="Drop",Value=135})
	new("IntValue",i1265,{Name="CycleZoom",Value=50})
	new("StringValue",i1265,{Name="RifleOrPistol"})
	new("BoolValue",i1265,{Name="IsGun",Value=t})
	new("IntValue",i1265,{Name="ShotCount",Value=1})
	new("StringValue",i1265,{Name="Rarity",Value="mythical"})
	new("BoolValue",i1265,{Name="Dismember",Value=t})
	new("StringValue",i1265,{Name="AmmoType",Value="rifle"})
	i1283=new("Part",i1264,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1140.0472412109375,-21.3269100189209,496.021240234375,6.177288014441729e-09,-6.315776346355051e-08,-1,-1.995213096961379e-07,1,-6.315875822338057e-08,1,1.995213096961379e-07,6.1791070038452744e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i1283,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i1283,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i1283,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i1283,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i1283,{Name="Fire",Pitch=0.8999999761581421,PlaybackSpeed=0.8999999761581421,SoundId="rbxassetid://620716624",Volume=4})
	i1289=new("Part",i1264,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1137.0335693359375,-20.650394439697266,496.00830078125,5.4933479987084866e-08,-3.335501119750006e-08,-1,-6.622940418310463e-08,1,-3.335495080136752e-08,1,6.622940418310463e-08,5.493529897648841e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i1289,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i1289,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i1289,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i1289,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	i1294=new("Part",i1264,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1140.0579833984375,-20.93396759033203,496.03515625,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.2920913696289062,0.43731361627578735,0.22501373291015625)})
	new("FileMesh",i1294,{MeshId="rbxassetid://476656787"})
	new("IntValue",i1294,{Name="Slot1"})
	i1297=new("Part",i1264,{Name="Mag",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1139.708740234375,-21.204959869384766,496.066162109375,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(0.5149993896484375,1.0300546884536743,0.5720062255859375)})
	new("IntValue",i1297,{Name="Slot2"})
	new("FileMesh",i1297,{MeshId="rbxassetid://476669644"})
	new("Snap",i1297,{C0=cf(0,0.5150273442268372,0,-1,0,0,0,0,1,0,1,-0),C1=cf(-0.13720703125,-0.12195634841918945,0.0489959716796875,-1,0,0,0,0,1,0,1,-0)})
	i1302=new("Part",i1264,{Name="Iron",Anchored=t,BrickColor=bc(26),CFrame=cf(-1139.4219970703125,-20.2948055267334,496.066162109375,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(2.4300003051757812,0.39250993728637695,0.20000000298023224)})
	new("FileMesh",i1302,{MeshId="rbxassetid://476671423"})
	i1301=new("Part",i1264,{Name="Bolt",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1139.5716552734375,-20.567995071411133,496.0172119140625,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(0.9571018218994141,0.24544000625610352,0.26300048828125)})
	new("FileMesh",i1301,{MeshId="rbxassetid://476668604"})
	i1306=new("Part",i1264,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1139.7918701171875,-20.786991119384766,496.063232421875,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.643899917602539,0.2998690605163574,0.2350006103515625)})
	new("FileMesh",i1306,{MeshId="rbxassetid://476670364"})
	i1308=new("Part",i1264,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1141.4779052734375,-20.853031158447266,496.0882568359375,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.424713134765625,0.9517359733581543,0.23801422119140625)})
	new("IntValue",i1308,{Name="Slot1"})
	new("FileMesh",i1308,{MeshId="rbxassetid://476672817"})
	i1311=new("Part",i1264,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1140.2117919921875,-20.563846588134766,496.0491943359375,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(3.7017993927001953,0.37945300340652466,0.2129974365234375)})
	new("IntValue",i1311,{Name="Slot1"})
	new("FileMesh",i1311,{MeshId="rbxassetid://476670771"})
	i1314=new("Part",i1264,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1140.1927490234375,-20.749879837036133,496.1011962890625,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(3.6672000885009766,0.7503399848937988,0.32599639892578125)})
	new("FileMesh",i1314,{MeshId="rbxassetid://476670579"})
	i1316=new("Part",i1264,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1140.546875,-21.244022369384766,496.066162109375,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(0.5022010803222656,0.5591049194335938,0.20000000298023224)})
	new("IntValue",i1316,{Name="Slot1"})
	new("FileMesh",i1316,{MeshId="rbxassetid://476656976"})
	i1319=new("Part",i1264,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1137.6881103515625,-20.592533111572266,496.066162109375,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.391000747680664,0.31998491287231445,0.20000000298023224)})
	new("FileMesh",i1319,{MeshId="rbxassetid://476671064"})
	new("Part",i1264,{Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1141.3939208984375,-20.141603469848633,496.06591796875,-0.00003266368730692193,0.00008631723176222295,-1,0.00004316046033636667,1,0.0000863158202264458,1,-0.00004315764090279117,-0.00003266741259722039),CanCollide=t,Material=1088,Rotation=v3(-0.0020000000949949026,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Part",i1264,{Name="Trigger",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1140.1312255859375,-21.0317440032959,496.066162109375,-0.00003266368730692193,0.00008631723176222295,-1,0.00004316046033636667,1,0.0000863158202264458,1,-0.00004315764090279117,-0.00003266741259722039),CanCollide=t,Material=1088,Rotation=v3(-0.0020000000949949026,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i1323=new("Part",i1264,{Name="BoltBack",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1140.3690185546875,-20.567874908447266,496.0172119140625,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(0.9571018218994141,0.24544000625610352,0.26300048828125),Transparency=1})
	new("FileMesh",i1323,{MeshId="rbxassetid://476668604"})
	new("Part",i1264,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1139.7073974609375,-20.656620025634766,496.0906066894531,1,0,0,0,1,0,0,0,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i1326=new("Model",i1,{Name="Machete"})
	i1327=new("Part",i1326,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(1003),CFrame=cf(-1179.3939208984375,-21.219970703125,468.7379150390625,1,0,0,0,0,-1,0,1,0),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(90,0,0),Size=v3(1,1,1),TopSurface=10,FormFactor=0})
	new("CylinderMesh",i1327,{Scale=v3(0.3333333432674408,0.8333333134651184,0.3333333432674408)})
	i1329=new("Part",i1326,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(1003),CFrame=cf(-1179.3939208984375,-21.219970703125,469.182373046875,1,0,0,0,0,-1,0,1,0),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(90,0,0),Size=v3(1,1,1),TopSurface=10,FormFactor=0})
	new("CylinderMesh",i1329,{Scale=v3(0.4444444477558136,0.0555555559694767,0.4444444477558136)})
	i1331=new("Part",i1326,{Anchored=t,BackSurface=10,BottomSurface=10,CFrame=cf(-1179.17138671875,-21.219970703125,470.210205078125,0,1,-0,-1,0,0,0,0,1),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(0,0,-90),Size=v3(1,1,2),TopSurface=10,FormFactor=0})
	new("SpecialMesh",i1331,{Scale=v3(0.1111111119389534,0.1666666716337204,1),MeshType=2})
	i1333=new("Part",i1326,{Anchored=t,BackSurface=10,BottomSurface=10,CFrame=cf(-1179.3382568359375,-21.219970703125,471.3212890625,1,0,0,0,0,-1,0,1,0),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(90,0,0),Size=v3(1,1,1),TopSurface=10,FormFactor=0})
	new("BlockMesh",i1333,{Scale=v3(0.2777777910232544,0.2222222238779068,0.1111111119389534)})
	i1335=new("Part",i1326,{Anchored=t,BackSurface=10,BottomSurface=10,CFrame=cf(-1179.3660888671875,-21.219970703125,470.210205078125,1,0,0,0,0,-1,0,1,0),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(90,0,0),Size=v3(1,2,1),TopSurface=10,FormFactor=0})
	new("BlockMesh",i1335,{Scale=v3(0.2222222238779068,1,0.1111111119389534)})
	i1337=new("Part",i1326,{Anchored=t,BackSurface=10,BottomSurface=10,CFrame=cf(-1179.3382568359375,-21.219970703125,471.4879150390625,0,1,0,1,0,0,0,0,-1),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(180,0,-90),Size=v3(1,1,1),TopSurface=10,FormFactor=0})
	new("SpecialMesh",i1337,{Scale=v3(0.1111111119389534,0.2777777910232544,0.1111111119389534),MeshType=2})
	i1339=new("Part",i1326,{Anchored=t,BackSurface=10,BottomSurface=10,CFrame=cf(-1179.5052490234375,-21.219970703125,471.1268310546875,0,-1,0,1,0,-0,0,0,1),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(0,0,90),Size=v3(1,1,1),TopSurface=10,FormFactor=0})
	new("SpecialMesh",i1339,{Scale=v3(0.1111111119389534,0.0555555559694767,0.6111111044883728),MeshType=2})
	i1341=new("Part",i1326,{Anchored=t,BackSurface=10,BottomSurface=10,CFrame=cf(-1179.1439208984375,-21.219970703125,471.3212890625,0,1,0,1,0,0,0,0,-1),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(180,0,-90),Size=v3(1,1,1),TopSurface=10,FormFactor=0})
	new("SpecialMesh",i1341,{Scale=v3(0.1111111119389534,0.1111111119389534,0.2222222238779068),MeshType=2})
	i1343=new("Part",i1326,{Anchored=t,BackSurface=10,BottomSurface=10,CFrame=cf(-1179.5052490234375,-21.219970703125,470.0157470703125,0,-1,-0,-1,0,-0,0,0,-1),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(180,0,90),Size=v3(1,1,2),TopSurface=10,FormFactor=0})
	new("SpecialMesh",i1343,{Scale=v3(0.1111111119389534,0.0555555559694767,0.8055555820465088),MeshType=2})
	i1345=new("Part",i1326,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(1003),CFrame=cf(-1179.3939208984375,-21.219970703125,468.29345703125,1,0,0,0,0,-1,0,1,0),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(90,0,0),Size=v3(1,1,1),TopSurface=10,FormFactor=0})
	new("CylinderMesh",i1345,{Scale=v3(0.3888888955116272,0.0555555559694767,0.3888888955116272)})
	i1347=new("Part",i1326,{Anchored=t,BackSurface=10,BottomSurface=10,CFrame=cf(-1179.5052490234375,-21.219970703125,471.4879150390625,0,-1,-0,-1,0,-0,0,0,-1),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(180,0,90),Size=v3(1,1,1),TopSurface=10,FormFactor=0})
	new("SpecialMesh",i1347,{Scale=v3(0.1111111119389534,0.0555555559694767,0.1111111119389534),MeshType=2})
	new("Part",i1326,{Name="CHOPPART",Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(26),CFrame=cf(-1179.3148193359375,-21.1895809173584,470.4619140625,1,0,0,0,1,0,0,0,1),FrontSurface=10,LeftSurface=10,Material=1088,RightSurface=10,Size=v3(0.5971577763557434,0.20000000298023224,2.4030017852783203),TopSurface=10,Transparency=1})
	i1350=new("Folder",i1326,{Name="Settings"})
	new("BoolValue",i1350,{Name="IsGun"})
	new("StringValue",i1350,{Name="Rarity",Value="rare"})
	new("BoolValue",i1350,{Name="Melee",Value=t})
	new("BoolValue",i1350,{Name="Dismember",Value=t})
	new("NumberValue",i1350,{Name="Damage",Value=75})
	new("BoolValue",i1350,{Name="IsKnife"})
	i1357=new("Part",i1326,{Name="Handle",Anchored=t,BackSurface=10,BottomSurface=10,CFrame=cf(-1179.3939208984375,-21.2231502532959,468.7244873046875,1.910685465164705e-15,-4.371138828673793e-08,-1,-1,-4.371138828673793e-08,0,-4.371138828673793e-08,1,-4.371138828673793e-08),FrontSurface=10,LeftSurface=10,RightSurface=10,Rotation=v3(90,-90,0),Size=v3(0.20000000298023224,1,0.20000000298023224),TopSurface=10,Transparency=1})
	new("Sound",i1357,{Name="SlashSound",SoundId="rbxassetid://101164100",Volume=1})
	new("Sound",i1357,{Name="Hit",SoundId="rbxassetid://214755079",Volume=1})
	i1360=new("Model",i1,{Name="M9 Bayonet"})
	i1361=new("Part",i1360,{Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1177.6610107421875,-21.6192626953125,467.8245849609375,1,0,0,0,0,-1,0,1,0),Rotation=v3(90,0,0),Size=v3(0.2505323588848114,0.5446357131004333,0.20151519775390625),TopSurface=0})
	new("SpecialMesh",i1361,{Scale=v3(0.005990992765873671,0.0054463548585772514,0.005990992765873671),MeshId="rbxassetid://1192364939",MeshType=5})
	i1363=new("Part",i1360,{Name="CHOPPART",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1177.6331787109375,-21.6192626953125,469.15234375,0,0,1,1,0,0,0,1,0),Rotation=v3(90,90,0),Size=v3(0.08169535547494888,1.7755123376846313,0.35945960879325867),TopSurface=0})
	new("SpecialMesh",i1363,{Scale=v3(0.0054463548585772514,0.0054463548585772514,0.0054463548585772514),MeshId="rbxassetid://1192361835",MeshType=5})
	i1365=new("Part",i1360,{Name="Handle",Anchored=t,BackSurface=10,BottomSurface=10,CFrame=cf(-1177.6600341796875,-21.580936431884766,467.7864990234375,0,0,1,1,0,0,0,1,0),FrontSurface=10,LeftSurface=10,RightSurface=10,Rotation=v3(90,90,0),Size=v3(0.20000000298023224,0.7600001692771912,0.20000000298023224),TopSurface=10,Transparency=1})
	new("Sound",i1365,{Name="SlashSound",SoundId="rbxassetid://101164100",Volume=1})
	new("Sound",i1365,{Name="Hit",SoundId="rbxassetid://214755079",Volume=1})
	i1368=new("Folder",i1360,{Name="Settings"})
	new("BoolValue",i1368,{Name="IsGun"})
	new("StringValue",i1368,{Name="Rarity",Value="legendary"})
	new("BoolValue",i1368,{Name="Melee",Value=t})
	new("BoolValue",i1368,{Name="Dismember",Value=t})
	new("NumberValue",i1368,{Name="Damage",Value=100})
	new("BoolValue",i1368,{Name="IsKnife",Value=t})
	i1375=new("Model",i1,{Name="Fireaxe"})
	new("Part",i1375,{Name="CHOPPART",Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(26),CFrame=cf(-1175.3895263671875,-21.139896392822266,470.2669677734375,0.9961944818496704,0.08715490251779556,0,-0.08715496957302094,0.9961944818496704,0,-0,0,1),FrontSurface=10,LeftSurface=10,Material=1088,RightSurface=10,Rotation=v3(0,0,-5),Size=v3(1.8771578073501587,0.20000000298023224,0.693002462387085),TopSurface=10,Transparency=1})
	i1377=new("Part",i1375,{Name="Handle",Anchored=t,BackSurface=10,BottomSurface=10,CFrame=cf(-1175.3441162109375,-21.208621978759766,468.7019348144531,-0.08715596795082092,-0.08682297170162201,-0.992404043674469,-0.9961946606636047,0.007596046198159456,0.08682432770729065,0,0.9961947798728943,-0.08715462684631348),FrontSurface=10,LeftSurface=10,RightSurface=10,Rotation=v3(-135.10899353027344,-82.93299865722656,135.11000061035156),Size=v3(0.20000000298023224,1,0.20000000298023224),TopSurface=10,Transparency=1})
	new("Sound",i1377,{Name="SlashSound",SoundId="rbxassetid://101164100",Volume=1})
	new("Sound",i1377,{Name="Hit",SoundId="rbxassetid://214755079",Volume=1})
	new("Part",i1375,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(26),CFrame=cf(-1175.3153076171875,-21.196903228759766,468.2828369140625,0,-0.9961944818496704,0.08715490251779556,0,0.08715496957302094,0.9961944818496704,-1,0,0),FrontSurface=10,LeftSurface=10,Material=1088,RightSurface=10,Rotation=v3(-90,5,90),Size=v3(0.09945080429315567,0.25857213139533997,0.12133003026247025),TopSurface=10})
	i1381=new("Part",i1375,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(332),CFrame=cf(-1175.3050537109375,-21.2005672454834,467.152587890625,-0.990079402923584,0.08715490251779556,0.11020995676517487,0.08661997318267822,0.9961944818496704,-0.009642037563025951,-0.11063095927238464,0,-0.9938616156578064),FrontSurface=10,LeftSurface=10,Material=1088,RightSurface=10,Rotation=v3(179.44400024414062,6.327000141143799,-174.968994140625),Size=v3(0.3973831236362457,0.39738309383392334,0.39738309383392334),TopSurface=10})
	new("BlockMesh",i1381,{Scale=v3(0.5714285969734192,0.2857142984867096,0.4285714328289032)})
	i1383=new("Part",i1375,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(332),CFrame=cf(-1175.3118896484375,-21.200077056884766,468.3619384765625,-0.9961944818496704,0.08715490251779556,0,0.08715496957302094,0.9961944818496704,0,0,0,-1),FrontSurface=10,LeftSurface=10,Material=1088,RightSurface=10,Rotation=v3(180,0,-175),Size=v3(0.39738306403160095,0.39738303422927856,2.384298324584961),TopSurface=10})
	new("BlockMesh",i1383,{Scale=v3(0.5714285969734192,0.2857142984867096,1)})
	new("Part",i1375,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(26),CFrame=cf(-1175.1971435546875,-21.187255859375,470.322021484375,0.9961944818496704,0.08715490251779556,0,-0.08715496957302094,0.9961944818496704,0,-0,0,1),FrontSurface=10,LeftSurface=10,Material=1088,RightSurface=10,Rotation=v3(0,0,-5),Size=v3(0.8771578073501587,0.1392313838005066,0.5430024862289429),TopSurface=10})
	i1386=new("Part",i1375,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(332),CFrame=cf(-1175.2757568359375,-21.2032470703125,467.0013427734375,-0.9732738733291626,0.08715426176786423,0.21246539056301117,0.08514902740716934,0.99619460105896,-0.018588151782751083,-0.21327702701091766,-1.4142429449748306e-07,-0.9769917726516724),FrontSurface=10,LeftSurface=10,Material=1088,RightSurface=10,Rotation=v3(178.91000366210938,12.267000198364258,-174.88299560546875),Size=v3(0.3973831236362457,0.39738309383392334,0.39738309383392334),TopSurface=10})
	new("BlockMesh",i1386,{Scale=v3(0.5714285969734192,0.2857142984867096,0.4285714328289032)})
	new("Part",i1375,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(26),CFrame=cf(-1175.3143310546875,-21.1970272064209,468.1812744140625,-0.14843298494815826,-0.9850742220878601,0.08715483546257019,0.012985854409635067,0.08618205040693283,0.9961944222450256,-0.9888372421264648,0.14899998903274536,-2.3039561369841977e-07),FrontSurface=10,LeftSurface=10,Material=1088,RightSurface=10,Rotation=v3(-90,5,98.56900024414062),Size=v3(0.09945080429315567,0.2665281891822815,0.1253080666065216),TopSurface=10})
	i1389=new("Part",i1375,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(332),CFrame=cf(-1175.3402099609375,-21.197507858276367,469.8095703125,-0.9961944818496704,0.08715490251779556,0,0.08715496957302094,0.9961944818496704,0,0,0,-1),FrontSurface=10,LeftSurface=10,Material=1088,RightSurface=10,Rotation=v3(180,0,-175),Size=v3(0.3973836600780487,0.3973836302757263,0.3973836302757263),TopSurface=10})
	new("BlockMesh",i1389,{Scale=v3(0.7142857313156128,0.2857142984867096,1.2857142686843872)})
	new("Part",i1375,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(26),CFrame=cf(-1175.3197021484375,-21.199222564697266,468.067138671875,0.22970984876155853,-0.9693487286567688,0.08715464174747467,-0.020096762105822563,0.08480603247880936,0.9961946606636047,-0.9730516672134399,-0.23058736324310303,8.837195863975467e-09),FrontSurface=10,LeftSurface=10,Material=1088,RightSurface=10,Rotation=v3(-90,5,76.66799926757812),Size=v3(0.09945080429315567,0.2665281891822815,0.11934101581573486),TopSurface=10})
	i1392=new("Part",i1375,{Name="Wedge",Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(332),CFrame=cf(-1175.4530029296875,-21.187623977661133,469.4405517578125,-0.08715490251779556,0,0.9961944818496704,-0.9961944818496704,0,-0.08715496957302094,0,-1,-0),FrontSurface=10,LeftSurface=10,Material=1088,RightSurface=10,Rotation=v3(90,85,180),Size=v3(0.3973836600780487,0.3973836302757263,0.3973836302757263),TopSurface=10})
	new("SpecialMesh",i1392,{Scale=v3(0.2857142984867096,0.5714285969734192,0.1428571492433548),MeshType=2})
	new("WedgePart",i1375,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(1002),CFrame=cf(-1174.6116943359375,-21.2034969329834,470.3302001953125,0,0.08715490251779556,-0.9961944818496704,0,0.9961944818496704,0.08715496957302094,1,0,0),FrontSurface=10,LeftSurface=10,Material=1088,RightSurface=10,Rotation=v3(-90,-85,-90),Size=v3(0.5265414714813232,0.06961569935083389,0.29238593578338623),TopSurface=10})
	new("WedgePart",i1375,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(332),CFrame=cf(-1175.9569091796875,-21.085819244384766,470.5238037109375,0,0.08715490251779556,0.9961944818496704,0,0.9961944818496704,-0.08715496957302094,-1,0,-0),FrontSurface=10,LeftSurface=10,Material=1088,RightSurface=10,Rotation=v3(90,85,-90),Size=v3(0.13923132419586182,0.06961566209793091,0.6543871760368347),TopSurface=10})
	i1396=new("Folder",i1375,{Name="Settings"})
	new("BoolValue",i1396,{Name="IsGun"})
	new("StringValue",i1396,{Name="Rarity",Value="rare"})
	new("BoolValue",i1396,{Name="Melee",Value=t})
	new("BoolValue",i1396,{Name="Dismember",Value=t})
	new("NumberValue",i1396,{Name="Damage",Value=75})
	new("BoolValue",i1396,{Name="IsKnife"})
	i1403=new("Model",i1,{Name="Baseball Bat"})
	new("Part",i1403,{Name="CHOPPART",Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(26),CFrame=cf(-1176.8992919921875,-20.9219970703125,470.971923828125,0.9961944818496704,0.08715490251779556,0,-0.08715496957302094,0.9961944818496704,0,-0,0,1),FrontSurface=10,LeftSurface=10,Material=1088,RightSurface=10,Rotation=v3(0,0,-5),Size=v3(0.43715813755989075,0.40000009536743164,2.1030023097991943),TopSurface=10,Transparency=1})
	i1405=new("Part",i1403,{Name="Handle",Anchored=t,BackSurface=10,BottomSurface=10,CFrame=cf(-1176.9158935546875,-20.9317626953125,467.53515625,1.910685465164705e-15,-4.371138828673793e-08,-1,-1,-4.371138828673793e-08,0,-4.371138828673793e-08,1,-4.371138828673793e-08),FrontSurface=10,LeftSurface=10,RightSurface=10,Rotation=v3(90,-90,0),Size=v3(0.20000000298023224,1,0.20000000298023224),TopSurface=10,Transparency=1})
	new("Sound",i1405,{Name="SlashSound",SoundId="rbxassetid://101164100",Volume=1})
	new("Sound",i1405,{Name="Hit",SoundId="rbxassetid://214755079",Volume=1})
	i1408=new("Folder",i1403,{Name="Settings"})
	new("BoolValue",i1408,{Name="IsGun"})
	new("StringValue",i1408,{Name="Rarity",Value="uncommon"})
	new("BoolValue",i1408,{Name="Melee",Value=t})
	new("BoolValue",i1408,{Name="Dismember"})
	new("NumberValue",i1408,{Name="Damage",Value=10})
	new("BoolValue",i1408,{Name="IsKnife"})
	i1415=new("Part",i1403,{Anchored=t,BottomSurface=0,BrickColor=bc(199),CFrame=cf(-1176.9066162109375,-20.916019439697266,469.256103515625,-4.371138828673793e-08,1,0,-1,-4.371138828673793e-08,0,0,0,1),Reflectance=0.4000000059604645,Rotation=v3(0,0,-90),Size=v3(1,0.800000011920929,4),TopSurface=0,FormFactor=2})
	new("SpecialMesh",i1415,{Scale=v3(2,2,2),MeshId="http://www.roblox.com/asset/?id=54983181 ",TextureId="http://www.roblox.com/asset/?id=54983107",MeshType=5})
	i1417=new("Model",i1,{Name="M9S"})
	new("Part",i1417,{Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1142.8406982421875,-20.6882381439209,472.8509521484375,-0.00017456646310165524,-0.0001745329354889691,-1,-3.455740138491592e-10,1,-0.00017453292093705386,1.0000014305114746,-3.078983823456838e-08,-0.00017456607019994408),FrontSurface=6,Material=1088,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i1419=new("Part",i1417,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1138.3865966796875,-20.777835845947266,472.8494567871094,5.458423402160406e-08,-3.3352989703416824e-08,-1,-6.659270468389877e-08,1,-3.334571374580264e-08,1.0000014305114746,6.590545353901689e-08,5.52245182916522e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i1419,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i1419,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i1419,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i1419,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	i1424=new("Part",i1417,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1141.1614990234375,-21.399662017822266,472.8624267578125,5.820766091346741e-09,-6.315531209111214e-08,-1,-1.9987790267350647e-07,1,-6.315531209111214e-08,1.0000014305114746,1.9920943827855808e-07,6.475602276623249e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i1424,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i1424,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i1424,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i1424,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i1424,{Name="Fire",Pitch=9,PlaybackSpeed=9,SoundId="rbxassetid://620600621",Volume=0.20000000298023224})
	new("Part",i1417,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(1003),CFrame=cf(-1139.0233154296875,-20.6694393157959,472.8509521484375,1,0,-3.4924596548080444e-10,0,1,-3.5712766077722335e-10,-2.9103830456733704e-10,-3.134719150921228e-10,1.0000014305114746),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Size=v3(1.4199999570846558,0.05000000074505806,0.14000000059604645),TopSurface=10})
	new("WedgePart",i1417,{Anchored=t,BottomSurface=10,BrickColor=bc(1003),CFrame=cf(-1139.0228271484375,-20.670289993286133,472.75634765625,1,0,-3.4924596548080444e-10,0,1,-3.5712766077722335e-10,-2.9103830456733704e-10,-3.134719150921228e-10,1.0000014305114746),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Size=v3(1.4199999570846558,0.05000000074505806,0.05000000074505806),TopSurface=10})
	new("Part",i1417,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(1003),CFrame=cf(-1139.0233154296875,-20.7894287109375,472.8509521484375,1,0,-3.4924596548080444e-10,0,1,-3.5712766077722335e-10,-2.9103830456733704e-10,-3.134719150921228e-10,1.0000014305114746),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Size=v3(1.42000150680542,0.18999998271465302,0.23999997973442078),TopSurface=10})
	new("WedgePart",i1417,{Anchored=t,BottomSurface=10,BrickColor=bc(1003),CFrame=cf(-1139.0228271484375,-20.670289993286133,472.9454345703125,-1,0,3.4924596548080444e-10,0,1,3.5712766077722335e-10,2.9103830456733704e-10,-3.134719150921228e-10,-1.0000014305114746),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(180,0,180),Size=v3(1.4199999570846558,0.05000000074505806,0.05000000074505806),TopSurface=10})
	new("WedgePart",i1417,{Anchored=t,BottomSurface=10,BrickColor=bc(1003),CFrame=cf(-1139.0228271484375,-20.903566360473633,472.75634765625,-1,0,-3.4924596548080444e-10,0,-1,-3.5712766077722335e-10,2.9103830456733704e-10,3.134719150921228e-10,1.0000014305114746),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(0,0,180),Size=v3(1.4199999570846558,0.05000000074505806,0.05000000074505806),TopSurface=10})
	new("Part",i1417,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(1003),CFrame=cf(-1139.0233154296875,-20.904420852661133,472.850830078125,1,0,3.4924596548080444e-10,0,-1,3.5712766077722335e-10,-2.9103830456733704e-10,3.134719150921228e-10,-1.0000014305114746),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(180,0,0),Size=v3(1.4199999570846558,0.05000000074505806,0.14000000059604645),TopSurface=10})
	new("WedgePart",i1417,{Anchored=t,BottomSurface=10,BrickColor=bc(1003),CFrame=cf(-1139.0228271484375,-20.903566360473633,472.9454345703125,1,0,3.4924596548080444e-10,0,-1,3.5712766077722335e-10,-2.9103830456733704e-10,3.134719150921228e-10,-1.0000014305114746),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(180,0,0),Size=v3(1.4199999570846558,0.05000000074505806,0.05000000074505806),TopSurface=10})
	i1437=new("Part",i1417,{Name="BoltBack",Anchored=t,BrickColor=bc(149),CFrame=cf(-1140.8314208984375,-20.788944244384766,472.8504638671875,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.4840087890625,0.2873098850250244,0.20000000298023224),Transparency=1})
	new("IntValue",i1437,{Name="Slot1"})
	new("FileMesh",i1437,{MeshId="rbxassetid://479880743"})
	i1440=new("Folder",i1417,{Name="Settings"})
	new("IntValue",i1440,{Name="Recoil",Value=1})
	new("IntValue",i1440,{Name="StoredAmmo",Value=17})
	new("IntValue",i1440,{Name="Mag",Value=6})
	new("BoolValue",i1440,{Name="Auto",Value=t})
	new("NumberValue",i1440,{Name="FireRate",Value=0.05})
	new("IntValue",i1440,{Name="FireMode",Value=2})
	new("BoolValue",i1440,{Name="CanSelectFire"})
	new("IntValue",i1440,{Name="Ammo",Value=17})
	new("IntValue",i1440,{Name="AimZoom",Value=35})
	new("IntValue",i1440,{Name="Drop",Value=135})
	new("IntValue",i1440,{Name="CycleZoom",Value=50})
	new("StringValue",i1440,{Name="RifleOrPistol",Value="pistol"})
	new("BoolValue",i1440,{Name="IsGun",Value=t})
	new("IntValue",i1440,{Name="ShotCount",Value=1})
	new("StringValue",i1440,{Name="Rarity",Value="legendary"})
	new("BoolValue",i1440,{Name="Dismember"})
	new("StringValue",i1440,{Name="AmmoType",Value="pistol"})
	i1458=new("Part",i1417,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1141.1751708984375,-21.452760696411133,472.8270263671875,6.177397260387352e-09,-6.315859479855135e-08,-1,-1.9952237551024155e-07,1,-6.315859479855135e-08,1,1.9952237551024155e-07,6.177385269978686e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i1458,{Name="Fire",Pitch=0.800000011920929,PlaybackSpeed=0.800000011920929,SoundId="rbxassetid://896335161",Volume=7})
	new("Sound",i1458,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i1458,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i1458,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i1458,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	i1464=new("Part",i1417,{Name="Bolt",Anchored=t,BrickColor=bc(149),CFrame=cf(-1140.5028076171875,-20.788944244384766,472.8504638671875,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.4840087890625,0.2873098850250244,0.20000000298023224)})
	new("IntValue",i1464,{Name="Slot1"})
	new("FileMesh",i1464,{MeshId="rbxassetid://479880743"})
	i1467=new("Part",i1417,{Name="Mag",Anchored=t,BrickColor=bc(26),CFrame=cf(-1141.0667724609375,-21.236940383911133,472.8504638671875,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(0.4470062255859375,0.7703932523727417,0.20000000298023224)})
	new("FileMesh",i1467,{MeshId="rbxassetid://479882360"})
	i1469=new("Part",i1417,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1140.638916015625,-21.2179012298584,472.8504638671875,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.416046142578125,0.7440066337585449,0.20000000298023224)})
	new("IntValue",i1469,{Name="Slot1"})
	new("FileMesh",i1469,{MeshId="rbxassetid://479882796"})
	i1472=new("Part",i1417,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1140.5101318359375,-20.9359130859375,472.8504638671875,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.54998779296875,0.49577000737190247,0.20000000298023224)})
	new("IntValue",i1472,{Name="Slot2"})
	new("FileMesh",i1472,{MeshId="rbxassetid://479882322"})
	i1475=new("Part",i1417,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1141.0697021484375,-21.235963821411133,472.8504638671875,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(0.3820037841796875,0.6870033144950867,0.20399856567382812)})
	new("IntValue",i1475,{Name="Slot2"})
	new("FileMesh",i1475,{MeshId="rbxassetid://479882341"})
	new("Part",i1417,{Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1142.6448974609375,-20.65967559814453,472.8504638671875,-0.00003300000025774352,0.00009200000204145908,-1,-0.000029999999242136255,1,0.00009200099157169461,1,0.000030003035135450773,-0.00003299723903182894),FrontSurface=6,Material=1088,Rotation=v3(0.0020000000949949026,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i1479=new("Part",i1417,{Name="Trigger",Anchored=t,BottomSurface=0,BrickColor=bc(199),CFrame=cf(-1140.6688232421875,-21.0607967376709,472.8505859375,-0.00003266368730692193,0.0000863153618411161,-1,-0.000043156738684047014,1,0.00008631677337689325,1,0.0000431595544796437,-0.00003265996201662347),Material=1088,Rotation=v3(0.0020000000949949026,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("BlockMesh",i1479,{Scale=v3(0.25,0.6666666865348816,0.25)})
	new("Part",i1417,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1140.8861083984375,-20.692140579223633,472.9060974121094,1,0,0,0,1,0,0,0,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i1482=new("Model",i1,{Name="M1911S"})
	i1483=new("Part",i1482,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1138.8802490234375,-20.7725887298584,499.36865234375,5.4467818699777126e-08,-3.3352989703416824e-08,-1,-6.670912000572571e-08,1,-3.334571374580264e-08,1.0000019073486328,6.580359013241832e-08,5.532638169825077e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i1483,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i1483,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i1483,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i1483,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	i1488=new("Part",i1482,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1141.8392333984375,-21.399662017822266,499.381591796875,5.704350769519806e-09,-6.315531209111214e-08,-1,-1.999943179953334e-07,1,-6.315531209111214e-08,1.0000019073486328,1.9910757487195951e-07,6.577465683221817e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i1488,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i1488,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i1488,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i1488,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i1488,{Name="Fire",Pitch=7,PlaybackSpeed=7,SoundId="rbxassetid://600251621"})
	i1494=new("Folder",i1482,{Name="Settings"})
	new("IntValue",i1494,{Name="Recoil",Value=2})
	new("IntValue",i1494,{Name="StoredAmmo",Value=7})
	new("IntValue",i1494,{Name="Mag",Value=10})
	new("BoolValue",i1494,{Name="Auto",Value=t})
	new("NumberValue",i1494,{Name="FireRate",Value=0.05})
	new("IntValue",i1494,{Name="FireMode",Value=2})
	new("BoolValue",i1494,{Name="CanSelectFire"})
	new("IntValue",i1494,{Name="Ammo",Value=7})
	new("IntValue",i1494,{Name="AimZoom",Value=35})
	new("IntValue",i1494,{Name="Drop",Value=135})
	new("IntValue",i1494,{Name="CycleZoom",Value=50})
	new("StringValue",i1494,{Name="RifleOrPistol",Value="pistol"})
	new("BoolValue",i1494,{Name="IsGun",Value=t})
	new("IntValue",i1494,{Name="ShotCount",Value=1})
	new("StringValue",i1494,{Name="Rarity",Value="legendary"})
	new("BoolValue",i1494,{Name="Dismember",Value=t})
	new("StringValue",i1494,{Name="AmmoType",Value="pistol"})
	i1512=new("Part",i1482,{Name="Iron",Anchored=t,BrickColor=bc(26),CFrame=cf(-1141.1673583984375,-20.783937454223633,499.3673095703125,0,0,1,0,1,-0,-1,0,0),Rotation=v3(0,90,0),Size=v3(0.20000000298023224,0.225000262260437,1.4969940185546875)})
	new("FileMesh",i1512,{MeshId="rbxassetid://494263051"})
	new("Part",i1482,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(1003),CFrame=cf(-1139.7015380859375,-20.949953079223633,499.3731689453125,1,0,3.4924596548080444e-10,0,-1,3.5712766077722335e-10,-2.9103830456733704e-10,3.134719150921228e-10,-1.0000014305114746),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(180,0,0),Size=v3(1.4199999570846558,0.05000000074505806,0.14000000059604645),TopSurface=10})
	new("WedgePart",i1482,{Anchored=t,BottomSurface=10,BrickColor=bc(1003),CFrame=cf(-1139.7012939453125,-20.71595001220703,499.2786865234375,1,0,-3.4924596548080444e-10,0,1,-3.5712766077722335e-10,-2.9103830456733704e-10,-3.134719150921228e-10,1.0000014305114746),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Size=v3(1.4199999570846558,0.05000000074505806,0.05000000074505806),TopSurface=10})
	new("WedgePart",i1482,{Anchored=t,BottomSurface=10,BrickColor=bc(1003),CFrame=cf(-1139.7012939453125,-20.71595001220703,499.4677734375,-1,0,3.4924596548080444e-10,0,1,3.5712766077722335e-10,2.9103830456733704e-10,-3.134719150921228e-10,-1.0000014305114746),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(180,0,180),Size=v3(1.4199999570846558,0.05000000074505806,0.05000000074505806),TopSurface=10})
	new("WedgePart",i1482,{Anchored=t,BottomSurface=10,BrickColor=bc(1003),CFrame=cf(-1139.7012939453125,-20.949098587036133,499.4677734375,1,0,3.4924596548080444e-10,0,-1,3.5712766077722335e-10,-2.9103830456733704e-10,3.134719150921228e-10,-1.0000014305114746),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(180,0,0),Size=v3(1.4199999570846558,0.05000000074505806,0.05000000074505806),TopSurface=10})
	new("WedgePart",i1482,{Anchored=t,BottomSurface=10,BrickColor=bc(1003),CFrame=cf(-1139.7012939453125,-20.949098587036133,499.2786865234375,-1,0,-3.4924596548080444e-10,0,-1,-3.5712766077722335e-10,2.9103830456733704e-10,3.134719150921228e-10,1.0000014305114746),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(0,0,180),Size=v3(1.4199999570846558,0.05000000074505806,0.05000000074505806),TopSurface=10})
	new("Part",i1482,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(1003),CFrame=cf(-1139.7015380859375,-20.7150936126709,499.373291015625,1,0,-3.4924596548080444e-10,0,1,-3.5712766077722335e-10,-2.9103830456733704e-10,-3.134719150921228e-10,1.0000014305114746),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Size=v3(1.4199999570846558,0.05000000074505806,0.14000000059604645),TopSurface=10})
	new("Part",i1482,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(1003),CFrame=cf(-1139.7015380859375,-20.8350887298584,499.373291015625,1,0,-3.4924596548080444e-10,0,1,-3.5712766077722335e-10,-2.9103830456733704e-10,-3.134719150921228e-10,1.0000014305114746),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Size=v3(1.42000150680542,0.18999998271465302,0.23999997973442078),TopSurface=10})
	i1521=new("Part",i1482,{Name="MeshPart",Anchored=t,BrickColor=bc(302),CFrame=cf(-1141.7366943359375,-21.328861236572266,499.369384765625,0,0,1,0,1,-0,-1,0,0),Rotation=v3(0,90,0),Size=v3(0.20000000298023224,0.8144999146461487,0.863006591796875)})
	new("FileMesh",i1521,{MeshId="rbxassetid://494271409"})
	i1523=new("Part",i1482,{Name="BoltBack",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1141.6072998046875,-20.8359432220459,499.3673095703125,0,0,1,0,1,-0,-1,0,0),Rotation=v3(0,90,0),Size=v3(0.20000000298023224,0.2895071506500244,1.6109161376953125),Transparency=1})
	new("IntValue",i1523,{Name="Slot2"})
	new("FileMesh",i1523,{MeshId="rbxassetid://494294114"})
	i1526=new("Part",i1482,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1141.8807373046875,-21.3519287109375,499.3673095703125,0,0,1,0,1,-0,-1,0,0),Rotation=v3(0,90,0),Size=v3(0.20098876953125,0.8433530330657959,0.52899169921875)})
	new("FileMesh",i1526,{MeshId="rbxassetid://494257835"})
	new("IntValue",i1526,{Name="Slot1"})
	i1529=new("Part",i1482,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1141.3304443359375,-21.216920852661133,499.3623046875,0,0,1,0,1,-0,-1,0,0),Rotation=v3(0,90,0),Size=v3(0.2079925537109375,1.0214998722076416,1.8579864501953125)})
	new("FileMesh",i1529,{MeshId="rbxassetid://536518033"})
	i1531=new("Part",i1482,{Name="Mag",Anchored=t,BrickColor=bc(302),CFrame=cf(-1141.848388671875,-21.328006744384766,499.3673095703125,0,0,1,0,1,-0,-1,0,0),Rotation=v3(0,90,0),Size=v3(0.20000000298023224,0.9324100613594055,0.5649871826171875)})
	new("FileMesh",i1531,{MeshId="rbxassetid://494262861"})
	i1533=new("Part",i1482,{Name="Bolt",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1141.2283935546875,-20.8359432220459,499.3673095703125,0,0,1,0,1,-0,-1,0,0),Rotation=v3(0,90,0),Size=v3(0.20000000298023224,0.2895071506500244,1.6109161376953125)})
	new("IntValue",i1533,{Name="Slot2"})
	new("FileMesh",i1533,{MeshId="rbxassetid://494294114"})
	i1536=new("Part",i1482,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1141.5013427734375,-21.3169002532959,499.3673095703125,0,0,1,0,1,-0,-1,0,0),Rotation=v3(0,90,0),Size=v3(0.20000000298023224,0.9450469017028809,1.4120330810546875)})
	new("IntValue",i1536,{Name="Slot1"})
	new("FileMesh",i1536,{MeshId="rbxassetid://494259106"})
	new("Part",i1482,{Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1143.8519287109375,-20.672853469848633,499.3665771484375,-0.00021600000036414713,-0.00008599999273428693,-1,-0.00022600000374950469,1,-0.00008595117833465338,1,0.00022598142095375806,-0.000216019427170977),CanCollide=t,Material=1088,Rotation=v3(0.013000000268220901,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Part",i1482,{Name="Trigger",Anchored=t,BottomSurface=0,BrickColor=bc(199),CFrame=cf(-1141.4774169921875,-21.1021785736084,499.3673095703125,-0.0002739999908953905,-0.000030999995942693204,-1,-0.00021399999968707561,1,-0.000030941362638259307,1,0.00021399150136858225,-0.00027400662656873465),CanCollide=t,Material=1088,Rotation=v3(0.012000000104308128,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Part",i1482,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1141.3270263671875,-20.830814361572266,499.37109375,1,0,0,0,1,0,0,0,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i1542=new("Model",i1,{Name="M1911"})
	i1543=new("Part",i1542,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1140.34130859375,-20.7725887298584,497.49462890625,5.4467818699777126e-08,-3.3352989703416824e-08,-1,-6.670912000572571e-08,1,-3.334571374580264e-08,1.0000019073486328,6.580359013241832e-08,5.532638169825077e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i1543,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i1543,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i1543,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i1543,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	i1548=new("Part",i1542,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1141.8392333984375,-21.399662017822266,497.5075988769531,5.704350769519806e-09,-6.315531209111214e-08,-1,-1.999943179953334e-07,1,-6.315531209111214e-08,1.0000019073486328,1.9910757487195951e-07,6.577465683221817e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i1548,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i1548,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i1548,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i1548,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i1548,{Name="Fire",Pitch=0.8999999761581421,PlaybackSpeed=0.8999999761581421,SoundId="rbxassetid://600251621",Volume=3})
	i1554=new("Folder",i1542,{Name="Settings"})
	new("IntValue",i1554,{Name="Recoil",Value=2})
	new("IntValue",i1554,{Name="StoredAmmo",Value=7})
	new("IntValue",i1554,{Name="Mag",Value=10})
	new("BoolValue",i1554,{Name="Auto",Value=t})
	new("NumberValue",i1554,{Name="FireRate",Value=0.05})
	new("IntValue",i1554,{Name="FireMode",Value=2})
	new("BoolValue",i1554,{Name="CanSelectFire"})
	new("IntValue",i1554,{Name="Ammo",Value=7})
	new("IntValue",i1554,{Name="AimZoom",Value=35})
	new("IntValue",i1554,{Name="Drop",Value=135})
	new("IntValue",i1554,{Name="CycleZoom",Value=50})
	new("StringValue",i1554,{Name="RifleOrPistol",Value="pistol"})
	new("BoolValue",i1554,{Name="IsGun",Value=t})
	new("IntValue",i1554,{Name="ShotCount",Value=1})
	new("StringValue",i1554,{Name="Rarity",Value="uncommon"})
	new("BoolValue",i1554,{Name="Dismember",Value=t})
	new("StringValue",i1554,{Name="AmmoType",Value="pistol"})
	i1572=new("Part",i1542,{Name="MeshPart",Anchored=t,BrickColor=bc(302),CFrame=cf(-1141.7366943359375,-21.328861236572266,497.4952392578125,0,0,1,0,1,-0,-1,0,0),Rotation=v3(0,90,0),Size=v3(0.20000000298023224,0.8144999146461487,0.863006591796875)})
	new("FileMesh",i1572,{MeshId="rbxassetid://494271409"})
	i1574=new("Part",i1542,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1141.5013427734375,-21.3169002532959,497.4932861328125,0,0,1,0,1,-0,-1,0,0),Rotation=v3(0,90,0),Size=v3(0.20000000298023224,0.9450469017028809,1.4120330810546875)})
	new("IntValue",i1574,{Name="Slot1"})
	new("FileMesh",i1574,{MeshId="rbxassetid://494259106"})
	i1577=new("Part",i1542,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1141.8807373046875,-21.3519287109375,497.4932861328125,0,0,1,0,1,-0,-1,0,0),Rotation=v3(0,90,0),Size=v3(0.20098876953125,0.8433530330657959,0.52899169921875)})
	new("FileMesh",i1577,{MeshId="rbxassetid://494257835"})
	new("IntValue",i1577,{Name="Slot1"})
	i1580=new("Part",i1542,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1141.3304443359375,-21.216920852661133,497.4881591796875,0,0,1,0,1,-0,-1,0,0),Rotation=v3(0,90,0),Size=v3(0.2079925537109375,1.0214998722076416,1.8579864501953125)})
	new("FileMesh",i1580,{MeshId="rbxassetid://536518033"})
	i1582=new("Part",i1542,{Name="Mag",Anchored=t,BrickColor=bc(302),CFrame=cf(-1141.848388671875,-21.328006744384766,497.4932861328125,0,0,1,0,1,-0,-1,0,0),Rotation=v3(0,90,0),Size=v3(0.20000000298023224,0.9324100613594055,0.5649871826171875)})
	new("FileMesh",i1582,{MeshId="rbxassetid://494262861"})
	i1584=new("Part",i1542,{Name="Bolt",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1141.2283935546875,-20.8359432220459,497.4932861328125,0,0,1,0,1,-0,-1,0,0),Rotation=v3(0,90,0),Size=v3(0.20000000298023224,0.2895071506500244,1.6109161376953125)})
	new("IntValue",i1584,{Name="Slot2"})
	new("FileMesh",i1584,{MeshId="rbxassetid://494294114"})
	new("Part",i1542,{Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1143.8519287109375,-20.672853469848633,497.4925537109375,-0.00021600000036414713,-0.00008599999273428693,-1,-0.00022600000374950469,1,-0.00008595117833465338,1,0.00022598142095375806,-0.000216019427170977),CanCollide=t,Material=1088,Rotation=v3(0.013000000268220901,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Part",i1542,{Name="Trigger",Anchored=t,BottomSurface=0,BrickColor=bc(199),CFrame=cf(-1141.4774169921875,-21.1021785736084,497.4932861328125,-0.0002739999908953905,-0.000030999995942693204,-1,-0.00021399999968707561,1,-0.000030941362638259307,1,0.00021399150136858225,-0.00027400662656873465),CanCollide=t,Material=1088,Rotation=v3(0.012000000104308128,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i1589=new("Part",i1542,{Name="BoltBack",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1141.6072998046875,-20.8359432220459,497.4932861328125,0,0,1,0,1,-0,-1,0,0),Rotation=v3(0,90,0),Size=v3(0.20000000298023224,0.2895071506500244,1.6109161376953125),Transparency=1})
	new("IntValue",i1589,{Name="Slot2"})
	new("FileMesh",i1589,{MeshId="rbxassetid://494294114"})
	i1592=new("Part",i1542,{Name="Iron",Anchored=t,BrickColor=bc(26),CFrame=cf(-1141.1673583984375,-20.783937454223633,497.4932861328125,0,0,1,0,1,-0,-1,0,0),Rotation=v3(0,90,0),Size=v3(0.20000000298023224,0.225000262260437,1.4969940185546875)})
	new("FileMesh",i1592,{MeshId="rbxassetid://494263051"})
	new("Part",i1542,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1141.3270263671875,-20.857175827026367,497.5098876953125,1,0,0,0,1,0,0,0,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i1595=new("Model",i1,{Name="AWS"})
	i1596=new("Folder",i1595,{Name="Settings"})
	new("IntValue",i1596,{Name="Recoil",Value=1})
	new("IntValue",i1596,{Name="StoredAmmo",Value=13})
	new("IntValue",i1596,{Name="Mag",Value=6})
	new("BoolValue",i1596,{Name="Auto"})
	new("NumberValue",i1596,{Name="FireRate",Value=0.067})
	new("IntValue",i1596,{Name="FireMode",Value=4})
	new("BoolValue",i1596,{Name="CanSelectFire"})
	new("IntValue",i1596,{Name="ShotCount",Value=1})
	new("IntValue",i1596,{Name="AimZoom",Value=4})
	new("IntValue",i1596,{Name="Drop",Value=135})
	new("IntValue",i1596,{Name="CycleZoom",Value=50})
	new("StringValue",i1596,{Name="RifleOrPistol"})
	new("BoolValue",i1596,{Name="IsGun",Value=t})
	new("IntValue",i1596,{Name="Ammo",Value=13})
	new("StringValue",i1596,{Name="Rarity",Value="mythical"})
	new("BoolValue",i1596,{Name="Dismember",Value=t})
	new("StringValue",i1596,{Name="AmmoType",Value="rifle"})
	i1614=new("Part",i1595,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1140.3504638671875,-21.306522369384766,500.281982421875,6.177397260387352e-09,-6.315859479855135e-08,-1,-1.9952237551024155e-07,1,-6.315859479855135e-08,1,1.9952237551024155e-07,6.177385269978686e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i1614,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i1614,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i1614,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i1614,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i1614,{Name="Fire",SoundId="rbxassetid://725750543",Volume=4})
	new("Sound",i1614,{Name="M1",SoundId="rbxassetid://873042054"})
	new("Sound",i1614,{Name="M2",Pitch=0.699999988079071,PlaybackSpeed=0.699999988079071,SoundId="rbxassetid://873042054"})
	i1622=new("Part",i1595,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1135.2220458984375,-20.62146759033203,500.26904296875,5.493356169949948e-08,-3.335593135034287e-08,-1,-6.623014314754982e-08,1,-3.335593490305655e-08,1,6.623015025297718e-08,5.49335581467858e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i1622,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i1622,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i1622,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i1622,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	new("Part",i1595,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(26),CFrame=cf(-1140.3934326171875,-20.479740142822266,500.2958984375,-1,0,0,0,1,0,0,0,-1),Material=272,Rotation=v3(180,0,180),Size=v3(0.05000000074505806,0.15000000596046448,0.05000000074505806),TopSurface=0})
	new("Part",i1595,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(26),CFrame=cf(-1139.9852294921875,-20.479740142822266,500.2958984375,-1,0,0,0,1,0,0,0,-1),Material=272,Rotation=v3(180,0,180),Size=v3(0.05000000074505806,0.15000000596046448,0.05000000074505806),TopSurface=0})
	i1629=new("Part",i1595,{Name="Reticle",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1139.5111083984375,-20.328006744384766,500.2957763671875,-1,0,0,0,1,0,0,0,-1),Material=288,Rotation=v3(180,0,180),Size=v3(0.05000000074505806,0.21891142427921295,0.21891139447689056),TopSurface=0,Transparency=0.699999988079071,FormFactor=3})
	new("SpecialMesh",i1629,{Scale=v3(0.24323450028896332,1,1),MeshType=4})
	new("Decal",i1629,{Face=0,Texture="http://www.roblox.com/asset/?id=303556559"})
	new("Decal",i1629,{Face=0,Texture="http://www.roblox.com/asset/?id=303556559"})
	new("Decal",i1629,{Face=0,Texture="http://www.roblox.com/asset/?id=303556559"})
	new("Decal",i1629,{Face=0,Texture="http://www.roblox.com/asset/?id=303556559"})
	new("Decal",i1629,{Face=0,Texture="http://www.roblox.com/asset/?id=303556559"})
	new("Decal",i1629,{Face=0,Texture="http://www.roblox.com/asset/?id=303556559"})
	new("Decal",i1629,{Face=0,Texture="http://www.roblox.com/asset/?id=303556559"})
	new("Decal",i1629,{Face=0,Texture="http://www.roblox.com/asset/?id=303556559"})
	new("Decal",i1629,{Face=0,Texture="http://www.roblox.com/asset/?id=303556559"})
	new("Decal",i1629,{Face=0,Texture="http://www.roblox.com/asset/?id=303556559"})
	i1641=new("Part",i1595,{Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1140.2000732421875,-20.2948055267334,500.2958984375,-1,0,0,0,1,0,0,0,-1),Material=272,Rotation=v3(180,0,180),Size=v3(1.3569999933242798,0.3100000023841858,0.24400000274181366),TopSurface=0})
	new("SpecialMesh",i1641,{MeshId="rbxassetid://2029156429",MeshType=5})
	i1643=new("Part",i1595,{Name="Fade",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1140.8612060546875,-20.328006744384766,500.2957763671875,-1,0,0,0,1,0,0,0,-1),Material=288,Rotation=v3(180,0,180),Size=v3(0.05000000074505806,0.21891142427921295,0.21891139447689056),TopSurface=0,Transparency=0.699999988079071,FormFactor=3})
	new("SpecialMesh",i1643,{Scale=v3(0.24323450028896332,1,1),MeshType=4})
	new("Decal",i1643,{Face=0,Texture="http://www.roblox.com/asset/?id=286537017"})
	new("Decal",i1643,{Face=0,Texture="http://www.roblox.com/asset/?id=286537017"})
	new("Decal",i1643,{Face=0,Texture="http://www.roblox.com/asset/?id=286537017"})
	i1648=new("Part",i1595,{Name="AimPart",Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(307),CFrame=cf(-1140.4832763671875,-20.3283748626709,500.2952880859375,0,0,-1,0,1,0,1,0,0),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(0,-90,0),Size=v3(0.09173646569252014,0.07488705217838287,0.07894076406955719),TopSurface=10,Transparency=1})
	new("BlockMesh",i1648)
	i1650=new("Part",i1595,{Name="BoltBack",Anchored=t,BrickColor=bc(302),CFrame=cf(-1141.0833740234375,-20.743656158447266,500.4134521484375,-1,0,0,0,1,0,0,0,-1),Rotation=v3(180,0,180),Size=v3(0.20000004768371582,0.20000000298023224,0.20000004768371582),Transparency=1})
	new("SpecialMesh",i1650,{MeshId="rbxassetid://2028963092",MeshType=5})
	i1652=new("Part",i1595,{Name="Bolt",Anchored=t,BrickColor=bc(302),CFrame=cf(-1140.3743896484375,-20.743656158447266,500.4134521484375,-1,0,0,0,1,0,0,0,-1),Rotation=v3(180,0,180),Size=v3(0.20000004768371582,0.20000000298023224,0.20000004768371582)})
	new("SpecialMesh",i1652,{MeshId="rbxassetid://2028963092",MeshType=5})
	i1654=new("Part",i1595,{Anchored=t,BrickColor=bc(26),CFrame=cf(-1138.1453857421875,-20.663944244384766,500.287841796875,0,0,1,0,1,-0,-1,0,0),Rotation=v3(0,90,0),Size=v3(0.20000004768371582,0.20000000298023224,0.20000004768371582)})
	new("SpecialMesh",i1654,{MeshId="rbxassetid://668820328",MeshType=5})
	i1656=new("Part",i1595,{Anchored=t,BrickColor=bc(1003),CFrame=cf(-1140.3177490234375,-21.1200008392334,500.291748046875,0,0,1,0,1,-0,-1,0,0),Rotation=v3(0,90,0),Size=v3(0.20000004768371582,0.20000000298023224,0.20000004768371582)})
	new("SpecialMesh",i1656,{MeshId="rbxassetid://656176764",MeshType=5})
	new("IntValue",i1656,{Name="Slot1"})
	i1659=new("Part",i1595,{Name="Mag",Anchored=t,BrickColor=bc(26),CFrame=cf(-1140.1346435546875,-21.042972564697266,500.290771484375,0,0,1,0,1,-0,-1,0,0),Rotation=v3(0,90,0),Size=v3(0.20000004768371582,0.20000000298023224,0.20000004768371582)})
	new("SpecialMesh",i1659,{MeshId="rbxassetid://656178049",MeshType=5})
	new("IntValue",i1659,{Name="Slot2"})
	i1662=new("Part",i1595,{Anchored=t,BrickColor=bc(26),CFrame=cf(-1140.4163818359375,-21.0089168548584,500.290771484375,0,0,1,0,1,-0,-1,0,0),Rotation=v3(0,90,0),Size=v3(0.20000004768371582,0.20000000298023224,0.20000004768371582)})
	new("SpecialMesh",i1662,{Scale=v3(1.0099999904632568,1,1),MeshId="rbxassetid://656178187",MeshType=5})
	new("Part",i1595,{Name="Trigger",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1140.8743896484375,-21.0299129486084,500.2938232421875,-0.00003266368730692193,0.00004316000922699459,-1,0.0000863181339809671,1,0.00004315718979341909,1,-0.00008631672244518995,-0.00003266741259722039),CanCollide=t,Material=1088,Rotation=v3(-0.004999999888241291,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Part",i1595,{Anchored=t,CFrame=cf(-1140.6766357421875,-20.6143856048584,500.2918701171875,0.000053408595704240724,-0.9999998211860657,0.0006904902402311563,0.9999993443489075,0.000052603914809878916,-0.0011653434485197067,0.0011653067776933312,0.0006905520567670465,0.9999991059303284),Rotation=v3(0.06700000166893005,0.03999999910593033,89.99700164794922),Size=v3(0.20000000298023224,0.20000000298023224,1.0875000953674316),Transparency=1,FormFactor=3})
	new("Part",i1595,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1140.2044677734375,-20.597782135009766,500.3614501953125,1,0,0,0,1,0,0,0,1),Size=v3(0.5300000905990601,0.08999998867511749,0.1900007277727127),TopSurface=0,Transparency=1})
	i1667=new("Model",i1,{Name="Ghillie Suit"})
	i1668=new("Folder",i1667,{Name="Settings"})
	new("IntValue",i1668,{Name="Ghillie",Value=4})
	new("StringValue",i1668,{Name="Rarity",Value="mythical"})
	i1671=new("Part",i1667,{Name="Handle",Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(141),CFrame=cf(-1147.1116943359375,-21.2156982421875,497.4656982421875,8.120520647025842e-07,-0.0000013135932022123598,1,2.875480049624457e-07,1,0.0000013135929748386843,-1,2.8754692493748735e-07,8.120525194499351e-07),FrontSurface=10,LeftSurface=10,Material=1280,RightSurface=10,Rotation=v3(0,90,0),Size=v3(2.417165994644165,1.0085840225219727,1.628583550453186),TopSurface=10,FormFactor=3})
	new("SpecialMesh",i1671,{Scale=v3(1.25,1.25,1.25),MeshType=1})
	i1673=new("Model",i1,{Name="UMP45"})
	i1674=new("Part",i1673,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1139.9031982421875,-20.492921829223633,501.51220703125,5.487891030497849e-08,-3.725290298461914e-08,-1.0000011920928955,-7.598421092325225e-08,0.9999993443489075,-3.026798367500305e-08,1.0000026226043701,5.516481493827996e-08,5.4973497753962874e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i1674,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i1674,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i1674,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i1674,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	i1679=new("Part",i1673,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1141.4803466796875,-20.973270416259766,501.5252685546875,6.122718332335353e-09,-6.705522537231445e-08,-1.0000011920928955,-2.0933740074724483e-07,0.9999993443489075,-6.007030606269836e-08,1.0000026226043701,1.8857943473449268e-07,6.213667802512646e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i1679,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i1679,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i1679,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i1679,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i1679,{Name="Fire",Pitch=1.2000000476837158,PlaybackSpeed=1.2000000476837158,SoundId="rbxassetid://132455970",Volume=3})
	i1685=new("Folder",i1673,{Name="Settings"})
	new("IntValue",i1685,{Name="Recoil",Value=1})
	new("IntValue",i1685,{Name="StoredAmmo",Value=31})
	new("IntValue",i1685,{Name="Mag",Value=10})
	new("BoolValue",i1685,{Name="Auto",Value=t})
	new("NumberValue",i1685,{Name="FireRate",Value=0.07})
	new("IntValue",i1685,{Name="FireMode",Value=1})
	new("BoolValue",i1685,{Name="CanSelectFire",Value=t})
	new("IntValue",i1685,{Name="Ammo",Value=31})
	new("IntValue",i1685,{Name="AimZoom",Value=35})
	new("IntValue",i1685,{Name="Drop",Value=135})
	new("IntValue",i1685,{Name="CycleZoom",Value=50})
	new("StringValue",i1685,{Name="RifleOrPistol"})
	new("BoolValue",i1685,{Name="IsGun",Value=t})
	new("IntValue",i1685,{Name="ShotCount",Value=1})
	new("StringValue",i1685,{Name="Rarity",Value="rare"})
	new("BoolValue",i1685,{Name="Dismember"})
	new("StringValue",i1685,{Name="AmmoType",Value="pistol"})
	i1703=new("Part",i1673,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1141.0819091796875,-20.5304012298584,501.5181884765625,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517108825733885,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.842010498046875,0.30299997329711914,0.20000000298023224)})
	new("IntValue",i1703,{Name="Slot1"})
	new("FileMesh",i1703,{MeshId="rbxassetid://479026606"})
	i1706=new("Part",i1673,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1141.5115966796875,-20.688356399536133,501.5382080078125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517108825733885,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.157989501953125,0.8931169509887695,0.2190093994140625)})
	new("IntValue",i1706,{Name="Slot1"})
	new("FileMesh",i1706,{MeshId="rbxassetid://479028971"})
	i1709=new("Part",i1673,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1142.6156005859375,-20.590335845947266,501.503173828125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517108825733885,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.3379974365234375,0.6960040330886841,0.266998291015625)})
	new("IntValue",i1709,{Name="Slot1"})
	new("FileMesh",i1709,{MeshId="rbxassetid://479028128"})
	i1712=new("Part",i1673,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1141.1268310546875,-20.244388580322266,501.5181884765625,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517108825733885,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.9290313720703125,0.3569999933242798,0.20000000298023224)})
	new("IntValue",i1712,{Name="Slot1"})
	new("FileMesh",i1712,{MeshId="rbxassetid://479026526"})
	i1715=new("Part",i1673,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1140.4056396484375,-20.458377838134766,501.5181884765625,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517108825733885,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(0.816009521484375,0.20000000298023224,0.20000000298023224)})
	new("FileMesh",i1715,{MeshId="rbxassetid://479023944"})
	new("IntValue",i1715,{Name="Slot2"})
	i1718=new("Part",i1673,{Name="Bolt",Anchored=t,BrickColor=bc(26),CFrame=cf(-1140.8548583984375,-20.395383834838867,501.4771728515625,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517108825733885,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.0500030517578125,0.26399993896484375,0.246002197265625)})
	new("FileMesh",i1718,{MeshId="rbxassetid://479030559"})
	i1720=new("Part",i1673,{Name="Mag",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1141.0306396484375,-21.1246395111084,501.5181884765625,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517108825733885,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(0.423004150390625,1.1906101703643799,0.20000000298023224)})
	new("IntValue",i1720,{Name="Slot2"})
	new("FileMesh",i1720,{MeshId="rbxassetid://481513901"})
	new("Snap",i1720,{C0=cf(0,0.5953050851821899,0,-1,0,0,0,0,1,0,1,-0),C1=cf(-0.17578125,-0.13400661945343018,0.040985107421875,-1,0,3.637978807091713e-12,-3.637978807091713e-12,0,1,0,1,0)})
	new("Part",i1673,{Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1142.8739013671875,-20.150148391723633,501.5172119140625,-0.00003266368730692193,0.00008631723176222295,-1,0.00004316046033636667,1,0.0000863158202264458,1,-0.00004315764090279117,-0.00003266741259722039),CanCollide=t,Material=272,Rotation=v3(-0.0020000000949949026,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Part",i1673,{Name="Trigger",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1141.4617919921875,-20.750370025634766,501.517333984375,-0.00003266368730692193,0.00008631723176222295,-1,0.00004316046033636667,1,0.0000863158202264458,1,-0.00004315764090279117,-0.00003266741259722039),CanCollide=t,Material=272,Rotation=v3(-0.0020000000949949026,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i1726=new("Part",i1673,{Name="BoltBack",Anchored=t,BrickColor=bc(26),CFrame=cf(-1141.2513427734375,-20.395383834838867,501.4771728515625,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517108825733885,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.0500030517578125,0.26399993896484375,0.246002197265625),Transparency=1})
	new("FileMesh",i1726,{MeshId="rbxassetid://479030559"})
	new("Snap",i1726,{C0=cf(0,-0.13199996948242188,0,1,0,0,0,0,-1,0,1,0),C1=cf(-0.220703125,0.5973114967346191,-0.04097747802734375,1,0,-3.637978807091713e-12,3.637978807091713e-12,0,-1,0,1,0)})
	new("Part",i1673,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1141.223876953125,-20.4165096282959,501.611083984375,1,0,0,0,1,0,0,0,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i1730=new("Model",i1,{Name="TEC-9"})
	i1731=new("Part",i1730,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1140.1824951171875,-20.161624908447266,502.253662109375,5.487891030497849e-08,-3.725458697090289e-08,-1.0000011920928955,-7.598282536491752e-08,0.9999993443489075,-3.026630679414666e-08,1.0000026226043701,5.5162672651931643e-08,5.497167876455933e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i1731,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i1731,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i1731,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i1731,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	i1736=new("Part",i1730,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1141.595458984375,-20.8350887298584,502.266845703125,6.122718332335353e-09,-6.705370481085993e-08,-1.0000011920928955,-2.0933657651767135e-07,0.9999993443489075,-6.007011421615971e-08,1.0000026226043701,1.8857826944440603e-07,6.2154867919161916e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i1736,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i1736,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i1736,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i1736,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i1736,{Name="Fire",Pitch=1.899999976158142,PlaybackSpeed=1.899999976158142,SoundId="rbxassetid://617413497",Volume=3})
	i1742=new("Folder",i1730,{Name="Settings"})
	new("IntValue",i1742,{Name="Recoil",Value=1})
	new("IntValue",i1742,{Name="StoredAmmo",Value=21})
	new("IntValue",i1742,{Name="Mag",Value=10})
	new("BoolValue",i1742,{Name="Auto",Value=t})
	new("NumberValue",i1742,{Name="FireRate",Value=0.02})
	new("IntValue",i1742,{Name="FireMode",Value=1})
	new("BoolValue",i1742,{Name="CanSelectFire",Value=t})
	new("IntValue",i1742,{Name="Ammo",Value=21})
	new("IntValue",i1742,{Name="AimZoom",Value=35})
	new("IntValue",i1742,{Name="Drop",Value=135})
	new("IntValue",i1742,{Name="CycleZoom",Value=50})
	new("StringValue",i1742,{Name="RifleOrPistol"})
	new("BoolValue",i1742,{Name="IsGun",Value=t})
	new("IntValue",i1742,{Name="ShotCount",Value=1})
	new("StringValue",i1742,{Name="Rarity",Value="mythical"})
	new("BoolValue",i1742,{Name="Dismember"})
	new("StringValue",i1742,{Name="AmmoType",Value="pistol"})
	i1760=new("Part",i1730,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1141.6331787109375,-20.5502986907959,502.2593994140625,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.3440093994140625,0.9317739605903625,0.23709869384765625)})
	new("IntValue",i1760,{Name="Slot1"})
	new("FileMesh",i1760,{MeshId="rbxassetid://479905524"})
	i1763=new("Part",i1730,{Name="Mag",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1141.2113037109375,-20.9713134765625,502.2593994140625,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(0.248992919921875,1.497354507446289,0.20000000298023224)})
	new("IntValue",i1763,{Name="Slot2"})
	new("FileMesh",i1763,{MeshId="rbxassetid://479905337"})
	i1766=new("Part",i1730,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1141.1883544921875,-20.13733673095703,502.2593994140625,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.8239898681640625,0.24564993381500244,0.20000000298023224)})
	new("IntValue",i1766,{Name="Slot2"})
	new("FileMesh",i1766,{MeshId="rbxassetid://479905413"})
	i1769=new("Part",i1730,{Name="Bolt",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1141.3641357421875,-20.138309478759766,502.234375,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(0.5970001220703125,0.24988996982574463,0.249603271484375)})
	new("FileMesh",i1769,{MeshId="rbxassetid://479905449"})
	i1771=new("Part",i1730,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1141.3040771484375,-20.1652889251709,502.2593994140625,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.7350006103515625,0.2430800199508667,0.24300003051757812)})
	new("IntValue",i1771,{Name="Slot1"})
	new("FileMesh",i1771,{MeshId="rbxassetid://479905476"})
	new("Part",i1730,{Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1143.0150146484375,-20.013919830322266,502.2603759765625,0.000060999998822808266,0.0016789993969723582,-0.9999986290931702,-0.000060999998822808266,0.9999986290931702,0.0016789956716820598,1,0.00006089749513193965,0.00006110234244260937),CanCollide=t,FrontSurface=6,Material=1088,Rotation=v3(-87.91600036621094,-89.90499877929688,-87.91899871826172),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i1775=new("Part",i1730,{Name="BoltBack",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1141.7230224609375,-20.138309478759766,502.234375,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(0.5970001220703125,0.24988996982574463,0.249603271484375),Transparency=1})
	new("FileMesh",i1775,{MeshId="rbxassetid://479905449"})
	new("Part",i1730,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1141.3709716796875,-20.10584259033203,502.355712890625,1,0,0,0,1,0,0,0,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i1778=new("Model",i1,{Name="Remington 870"})
	i1779=new("Folder",i1778,{Name="Settings"})
	new("IntValue",i1779,{Name="Recoil",Value=3})
	new("IntValue",i1779,{Name="StoredAmmo",Value=9})
	new("IntValue",i1779,{Name="Mag",Value=6})
	new("BoolValue",i1779,{Name="Auto"})
	new("NumberValue",i1779,{Name="FireRate",Value=0.067})
	new("IntValue",i1779,{Name="FireMode",Value=5})
	new("BoolValue",i1779,{Name="CanSelectFire"})
	new("IntValue",i1779,{Name="ShotCount",Value=14})
	new("IntValue",i1779,{Name="AimZoom",Value=35})
	new("IntValue",i1779,{Name="Drop",Value=135})
	new("IntValue",i1779,{Name="CycleZoom",Value=50})
	new("StringValue",i1779,{Name="RifleOrPistol"})
	new("BoolValue",i1779,{Name="IsGun",Value=t})
	new("IntValue",i1779,{Name="Ammo",Value=9})
	new("StringValue",i1779,{Name="Rarity",Value="uncommon"})
	new("BoolValue",i1779,{Name="Dismember",Value=t})
	new("StringValue",i1779,{Name="AmmoType",Value="shotgun"})
	i1797=new("Part",i1778,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1140.3572998046875,-21.581180572509766,503.9296875,6.177397260387352e-09,-6.315859479855135e-08,-1,-1.9952237551024155e-07,1,-6.315859479855135e-08,1,1.9952237551024155e-07,6.177385269978686e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i1797,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i1797,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i1797,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i1797,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i1797,{Name="Fire",Pitch=1.2000000476837158,PlaybackSpeed=1.2000000476837158,SoundId="rbxassetid://631924917",Volume=4})
	new("Sound",i1797,{Name="M1",SoundId="rbxassetid://873042054"})
	new("Sound",i1797,{Name="M2",Pitch=0.699999988079071,PlaybackSpeed=0.699999988079071,SoundId="rbxassetid://873042054"})
	new("Sound",i1797,{Name="Fire",Pitch=0.800000011920929,PlaybackSpeed=0.800000011920929,SoundId="rbxassetid://631924917",Volume=4})
	i1806=new("Part",i1778,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1137.4964599609375,-20.881837844848633,504.0135498046875,5.493356169949948e-08,-3.335593135034287e-08,-1,-6.623014314754982e-08,1,-3.335593490305655e-08,1,6.623015025297718e-08,5.49335581467858e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i1806,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i1806,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i1806,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i1806,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	new("Part",i1778,{Name="Mag",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1141.1033935546875,-21.03125762939453,503.9599609375,6.177397260387352e-09,-6.315859479855135e-08,-1,-1.9952237551024155e-07,1,-6.315859479855135e-08,1,1.9952237551024155e-07,6.177385269978686e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.05000000074505806,0.05000000074505806,0.05000000074505806),TopSurface=0,Transparency=1,FormFactor=3})
	i1812=new("Part",i1778,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1141.8040771484375,-21.266239166259766,504.0001220703125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(2.686004638671875,0.907428503036499,0.21310043334960938)})
	new("IntValue",i1812,{Name="Slot2"})
	new("FileMesh",i1812,{MeshId="rbxassetid://479895657"})
	i1815=new("Part",i1778,{Name="Iron",Anchored=t,BrickColor=bc(26),CFrame=cf(-1139.4564208984375,-20.806156158447266,504.0001220703125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(3.561004638671875,0.20000000298023224,0.20000000298023224)})
	new("FileMesh",i1815,{MeshId="rbxassetid://479895614"})
	i1817=new("Part",i1778,{Name="Bolt",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1139.75634765625,-21.052248001098633,504.0001220703125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(2.4210052490234375,0.41860106587409973,0.22499847412109375)})
	new("IntValue",i1817,{Name="Slot1"})
	new("FileMesh",i1817,{MeshId="rbxassetid://479895538"})
	i1820=new("Part",i1778,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1142.2083740234375,-21.3042049407959,504.0001220703125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.5,0.7997921109199524,0.21310043334960938)})
	new("IntValue",i1820,{Name="Slot1"})
	new("FileMesh",i1820,{MeshId="rbxassetid://479895684"})
	i1823=new("Part",i1778,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1139.5604248046875,-21.019168853759766,504.0001220703125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(3.9010009765625,0.3645020127296448,0.20000000298023224)})
	new("IntValue",i1823,{Name="Slot2"})
	new("FileMesh",i1823,{MeshId="rbxassetid://479895733"})
	new("Part",i1778,{Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1142.4495849609375,-20.772829055786133,503.9991455078125,-0.00003266368730692193,0.00004316000922699459,-1,0.0000863181339809671,1,0.00004315718979341909,1,-0.00008631672244518995,-0.00003266741259722039),CanCollide=t,Material=1088,Rotation=v3(-0.004999999888241291,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Part",i1778,{Name="Trigger",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1141.2269287109375,-21.272705078125,503.999267578125,-0.00003266368730692193,0.00004316000922699459,-1,0.0000863181339809671,1,0.00004315718979341909,1,-0.00008631672244518995,-0.00003266741259722039),CanCollide=t,Material=1088,Rotation=v3(-0.004999999888241291,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i1828=new("Part",i1778,{Name="BoltBack",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1140.3421630859375,-21.052127838134766,504.0001220703125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(2.4210052490234375,0.41860106587409973,0.22499847412109375),Transparency=1})
	new("IntValue",i1828,{Name="Slot1"})
	new("FileMesh",i1828,{MeshId="rbxassetid://479895538"})
	new("Part",i1778,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1140.8109130859375,-20.960819244384766,504.0828857421875,1,0,0,0,1,0,0,0,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i1832=new("Model",i1,{Name="G36"})
	i1833=new("Folder",i1832,{Name="Settings"})
	new("IntValue",i1833,{Name="Recoil",Value=1})
	new("IntValue",i1833,{Name="StoredAmmo",Value=30})
	new("IntValue",i1833,{Name="Mag",Value=6})
	new("BoolValue",i1833,{Name="Auto",Value=t})
	new("NumberValue",i1833,{Name="FireRate",Value=0.07})
	new("IntValue",i1833,{Name="FireMode",Value=1})
	new("BoolValue",i1833,{Name="CanSelectFire",Value=t})
	new("IntValue",i1833,{Name="Ammo",Value=31})
	new("IntValue",i1833,{Name="AimZoom",Value=10})
	new("IntValue",i1833,{Name="Drop",Value=70})
	new("IntValue",i1833,{Name="CycleZoom",Value=50})
	new("StringValue",i1833,{Name="RifleOrPistol"})
	new("BoolValue",i1833,{Name="IsGun",Value=t})
	new("IntValue",i1833,{Name="ShotCount",Value=1})
	new("StringValue",i1833,{Name="Rarity",Value="legendary"})
	new("BoolValue",i1833,{Name="Dismember"})
	new("StringValue",i1833,{Name="AmmoType",Value="rifle"})
	i1851=new("Part",i1832,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1139.9764404296875,-21.380008697509766,505.880126953125,6.184563972055912e-09,-6.31586019039787e-08,-1,-1.9952072705109458e-07,1,-6.315859479855135e-08,1,1.9952032914716256e-07,6.184563972055912e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i1851,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i1851,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i1851,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i1851,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i1851,{Name="Fire",Pitch=0.8999999761581421,PlaybackSpeed=0.8999999761581421,SoundId="rbxassetid://620716624",Volume=4})
	i1857=new("Part",i1832,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1136.3416748046875,-20.713382720947266,505.8671875,5.4933479987084866e-08,-3.335593845577023e-08,-1,-6.622881443263395e-08,1,-3.335592779762919e-08,1,6.62289565411811e-08,5.4933479987084866e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i1857,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i1857,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i1857,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i1857,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	new("Part",i1832,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1139.5423583984375,-20.666751861572266,505.9607849121094,1,-5.329070518200751e-15,0,-5.329070518200751e-15,1,5.860123584305876e-13,0,5.860130631619997e-13,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i1863=new("Part",i1832,{Name="Scoper",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1140.001220703125,-20.391361236572266,505.932861328125,-0.00029169561457820237,0.00008622314635431394,-1,-0.0007336691487580538,0.9999998211860657,0.00008643712499178946,0.9999997615814209,0.0007336943526752293,-0.00029163225553929806),CanCollide=t,Material=272,Rotation=v3(0.041999999433755875,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i1864=new("SurfaceGui",i1863,{Face=2})
	i1865=new("ImageLabel",i1864,{Name="Border",BackgroundColor3=c3(1,1,1),BackgroundTransparency=1,BorderColor3=c3(1,1,1),ClipsDescendants=t,Size=ud2(1,0,1,0),ZIndex=2,Image="rbxassetid://1805072489",ImageTransparency=0.5})
	new("ImageLabel",i1865,{Name="Scope",BackgroundColor3=c3(1,1,1),BackgroundTransparency=1,BorderColor3=c3(1,1,1),Position=ud2(0.20000000298023224,0,0.20000000298023224,0),Size=ud2(0.6000000238418579,0,0.6000000238418579,0),Image="rbxassetid://172951869"})
	i1867=new("Part",i1832,{Name="BoltBack",Anchored=t,CFrame=cf(-1140.1038818359375,-20.625980377197266,505.933837890625,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(0.936004638671875,0.20000000298023224,0.20000000298023224),Transparency=1})
	new("FileMesh",i1867,{MeshId="rbxassetid://479043878"})
	new("Part",i1832,{Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1141.5360107421875,-20.391239166259766,505.932373046875,-0.00029169561457820237,0.00008622314635431394,-1,-0.0007336691487580538,0.9999998211860657,0.00008643712499178946,0.9999997615814209,0.0007336943526752293,-0.00029163225553929806),CanCollide=t,Material=272,Rotation=v3(0.041999999433755875,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i1870=new("Part",i1832,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1139.6595458984375,-20.492921829223633,505.931884765625,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(2.0099945068359375,0.47407007217407227,0.2100067138671875)})
	new("IntValue",i1870,{Name="Slot1"})
	new("FileMesh",i1870,{MeshId="rbxassetid://479051785"})
	new("Part",i1832,{Name="Trigger",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1140.0804443359375,-20.9863338470459,505.932373046875,-0.00029169561457820237,0.00008622314635431394,-1,-0.0007336691487580538,0.9999998211860657,0.00008643712499178946,0.9999997615814209,0.0007336943526752293,-0.00029163225553929806),CanCollide=t,Material=272,Rotation=v3(0.041999999433755875,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i1874=new("Part",i1832,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1139.7152099609375,-20.993898391723633,505.935791015625,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.3119964599609375,0.365526020526886,0.248992919921875)})
	new("FileMesh",i1874,{MeshId="rbxassetid://479044149"})
	i1876=new("Part",i1832,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1139.6531982421875,-20.992921829223633,505.9607849121094,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(2.022003173828125,0.9996939897537231,0.2710113525390625)})
	new("IntValue",i1876,{Name="Slot2"})
	new("FileMesh",i1876,{MeshId="rbxassetid://479045169"})
	i1879=new("Part",i1832,{Name="Bolt",Anchored=t,CFrame=cf(-1139.4324951171875,-20.625980377197266,505.933837890625,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(0.936004638671875,0.20000000298023224,0.20000000298023224)})
	new("FileMesh",i1879,{MeshId="rbxassetid://479043878"})
	i1881=new("Part",i1832,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1137.7196044921875,-20.677003860473633,505.931884765625,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(2.774993896484375,0.2196369767189026,0.20000000298023224)})
	new("IntValue",i1881,{Name="Slot2"})
	new("FileMesh",i1881,{MeshId="rbxassetid://479043991"})
	i1884=new("Part",i1832,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1138.2523193359375,-20.7109432220459,505.932861328125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.75799560546875,0.4236339330673218,0.2140045166015625)})
	new("IntValue",i1884,{Name="Slot1"})
	new("FileMesh",i1884,{MeshId="rbxassetid://479044048"})
	i1887=new("Part",i1832,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1141.1824951171875,-20.887939453125,505.9158935546875,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.3379974365234375,0.6960040330886841,0.266998291015625)})
	new("IntValue",i1887,{Name="Slot1"})
	new("FileMesh",i1887,{MeshId="rbxassetid://479028128"})
	i1890=new("Part",i1832,{Name="Mag",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1139.5013427734375,-21.2249813079834,505.9388427734375,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(0.4910125732421875,1.0690251588821411,0.20000000298023224)})
	new("IntValue",i1890,{Name="Slot1"})
	new("FileMesh",i1890,{MeshId="rbxassetid://479044798"})
	i1893=new("Model",i1,{Name="Thompson"})
	i1894=new("Part",i1893,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1137.9195556640625,-20.817140579223633,505.00537109375,5.478582210116656e-08,-4.470345515983354e-08,-1,-8.077037705334078e-08,1,-4.470345515983354e-08,1,8.077037705334078e-08,5.478581854845288e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i1894,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i1894,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i1894,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i1894,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	i1899=new("Part",i1893,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1140.5247802734375,-21.5794734954834,504.9952392578125,6.02946004235605e-09,-7.450576333667414e-08,-1,-2.1415166884253267e-07,1,-7.450576333667414e-08,1,2.1415166884253267e-07,6.029444055144495e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i1899,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i1899,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i1899,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i1899,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i1899,{Name="Fire",Pitch=1.2000000476837158,PlaybackSpeed=1.2000000476837158,SoundId="rbxassetid://132455970",Volume=3})
	i1905=new("Folder",i1893,{Name="Settings"})
	new("IntValue",i1905,{Name="Recoil",Value=1})
	new("IntValue",i1905,{Name="StoredAmmo",Value=31})
	new("IntValue",i1905,{Name="Mag",Value=10})
	new("BoolValue",i1905,{Name="Auto",Value=t})
	new("NumberValue",i1905,{Name="FireRate",Value=0.045})
	new("IntValue",i1905,{Name="FireMode",Value=1})
	new("BoolValue",i1905,{Name="CanSelectFire",Value=t})
	new("IntValue",i1905,{Name="Ammo",Value=31})
	new("IntValue",i1905,{Name="AimZoom",Value=35})
	new("IntValue",i1905,{Name="Drop",Value=135})
	new("IntValue",i1905,{Name="CycleZoom",Value=50})
	new("StringValue",i1905,{Name="RifleOrPistol"})
	new("BoolValue",i1905,{Name="IsGun",Value=t})
	new("IntValue",i1905,{Name="ShotCount",Value=1})
	new("StringValue",i1905,{Name="Rarity",Value="rare"})
	new("BoolValue",i1905,{Name="Dismember"})
	new("StringValue",i1905,{Name="AmmoType",Value="pistol"})
	i1923=new("Part",i1893,{Name="Bolt",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1140.1070556640625,-20.8615779876709,505.066162109375,0,0,-1,0,1,0,1,0,0),Rotation=v3(0,-90,0),Size=v3(0.1300000101327896,0.40000006556510925,0.4400007426738739),TopSurface=0})
	new("SpecialMesh",i1923,{MeshId="rbxassetid://2057494196",MeshType=5})
	i1925=new("Part",i1893,{Name="Union",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1139.5941162109375,-20.9069881439209,505.01611328125,0,0,-1,0,1,0,1,0,0),Rotation=v3(0,-90,0),Size=v3(0.05000000074505806,0.21000000834465027,2),TopSurface=0})
	new("SpecialMesh",i1925,{MeshId="rbxassetid://2057435047",MeshType=5})
	i1927=new("Part",i1893,{Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1140.4891357421875,-20.9935359954834,505.003173828125,0,0,-1,0,1,0,1,0,0),Rotation=v3(0,-90,0),Size=v3(0.1300000101327896,0.40000006556510925,0.4400007426738739),TopSurface=0})
	new("SpecialMesh",i1927,{MeshId="rbxassetid://2057466025",MeshType=5})
	i1929=new("Part",i1893,{Name="BoltBack",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1140.5321044921875,-20.8615779876709,505.066162109375,0,0,-1,0,1,0,1,0,0),Rotation=v3(0,-90,0),Size=v3(0.1300000101327896,0.40000006556510925,0.4400007426738739),TopSurface=0,Transparency=1})
	new("SpecialMesh",i1929,{MeshId="rbxassetid://2057494196",MeshType=5})
	i1931=new("Part",i1893,{Name="Union",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1139.6688232421875,-20.965579986572266,505.003173828125,0,0,1,0,1,-0,-1,0,0),Rotation=v3(0,90,0),Size=v3(0.1900000125169754,0.23000000417232513,2),TopSurface=0})
	new("SpecialMesh",i1931,{MeshId="rbxassetid://2057443317",MeshType=5})
	i1933=new("Part",i1893,{Name="Union",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1140.3758544921875,-21.256467819213867,505.0145263671875,0,0,-1,0,1,0,1,0,0),Rotation=v3(0,-90,0),Size=v3(0.05000000074505806,0.6199999451637268,3.8199987411499023),TopSurface=0})
	new("SpecialMesh",i1933,{MeshId="rbxassetid://2057458888",MeshType=5})
	i1935=new("Part",i1893,{Name="Mag",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1139.9998779296875,-21.442508697509766,504.985107421875,0,0,-1,0,1,0,1,0,0),Rotation=v3(0,-90,0),Size=v3(0.1300000101327896,0.40000006556510925,0.4400007426738739),TopSurface=0})
	new("SpecialMesh",i1935,{MeshId="rbxassetid://2057503725",MeshType=5})
	new("Part",i1893,{Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1141.6707763671875,-20.756961822509766,505.006103515625,0,0,-1,0,1,0,1,0,0),Rotation=v3(0,-90,0),Size=v3(0.05000000074505806,0.05000000074505806,0.05000000074505806),TopSurface=0,Transparency=1})
	new("Part",i1893,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1139.9818115234375,-20.8615779876709,505.066162109375,1,0,0,0,1,0,0,0,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i1939=new("Model",i1,{Name="MAC-10"})
	i1940=new("Part",i1939,{Name="MeshPart",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1141.4749755859375,-20.719606399536133,503.168212890625,0,0.0006139997858554125,-0.9999998807907104,-0.0032339992467314005,0.9999946355819702,0.0006139966426417232,0.9999947547912598,0.003233998781070113,0.000001985674998650211),CanCollide=t,Material=272,Rotation=v3(0.1850000023841858,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i1940,{MeshId="rbxassetid://752938561"})
	i1942=new("Part",i1939,{Name="MeshPart",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1140.0306396484375,-20.76929473876953,503.16796875,0,0.0006139997858554125,-0.9999998807907104,-0.0032339992467314005,0.9999946355819702,0.0006139966426417232,0.9999947547912598,0.003233998781070113,0.000001985674998650211),CanCollide=t,Material=272,Rotation=v3(0.1850000023841858,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i1942,{MeshId="rbxassetid://752942071"})
	i1944=new("Part",i1939,{Name="MeshPart",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1141.0111083984375,-20.9581356048584,503.1673583984375,0,0.0006139997858554125,-0.9999998807907104,-0.0032339992467314005,0.9999946355819702,0.0006139966426417232,0.9999947547912598,0.003233998781070113,0.000001985674998650211),CanCollide=t,Material=272,Rotation=v3(0.1850000023841858,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i1944,{MeshId="rbxassetid://752939223"})
	i1946=new("Part",i1939,{Name="MeshPart",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1141.2176513671875,-21.2165584564209,503.166015625,0,0.0006139997858554125,-0.9999998807907104,-0.0032339992467314005,0.9999946355819702,0.0006139966426417232,0.9999947547912598,0.003233998781070113,0.000001985674998650211),CanCollide=t,Material=272,Rotation=v3(0.1850000023841858,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i1946,{MeshId="rbxassetid://752940169"})
	i1948=new("Part",i1939,{Name="MeshPart",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1141.0208740234375,-21.216676712036133,503.16650390625,0,0.0006139997858554125,-0.9999998807907104,-0.0032339992467314005,0.9999946355819702,0.0006139966426417232,0.9999947547912598,0.003233998781070113,0.000001985674998650211),CanCollide=t,Material=272,Rotation=v3(0.1850000023841858,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i1948,{MeshId="rbxassetid://752939955"})
	new("IntValue",i1948,{Name="Slot1"})
	i1951=new("Part",i1939,{Name="Bolt",Anchored=t,BottomSurface=0,BrickColor=bc(302),CFrame=cf(-1140.8153076171875,-20.5906982421875,503.1685791015625,0,0.0006139997858554125,-0.9999998807907104,-0.0032339992467314005,0.9999946355819702,0.0006139966426417232,0.9999947547912598,0.003233998781070113,0.000001985674998650211),CanCollide=t,Material=272,Rotation=v3(0.1850000023841858,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i1951,{MeshId="rbxassetid://752940986"})
	i1953=new("Part",i1939,{Name="MeshPart",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1140.8992919921875,-20.4649658203125,503.1689453125,0,0.0006139997858554125,-0.9999998807907104,-0.0032339992467314005,0.9999946355819702,0.0006139966426417232,0.9999947547912598,0.003233998781070113,0.000001985674998650211),CanCollide=t,Material=272,Rotation=v3(0.1850000023841858,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i1953,{MeshId="rbxassetid://752941537"})
	i1955=new("Part",i1939,{Name="Mag",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1141.0185546875,-21.6167049407959,503.1646728515625,0,0.0006139997858554125,-0.9999998807907104,-0.0032339992467314005,0.9999946355819702,0.0006139966426417232,0.9999947547912598,0.003233998781070113,0.000001985674998650211),CanCollide=t,Material=272,Rotation=v3(0.1850000023841858,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i1955,{MeshId="rbxassetid://752942482"})
	new("IntValue",i1955,{Name="Slot2"})
	i1958=new("Part",i1939,{Name="MeshPart",Anchored=t,BottomSurface=0,BrickColor=bc(302),CFrame=cf(-1140.8323974609375,-21.066774368286133,503.1640625,0,0.0006139997858554125,-0.9999998807907104,-0.0032339992467314005,0.9999946355819702,0.0006139966426417232,0.9999947547912598,0.003233998781070113,0.000001985674998650211),CanCollide=t,Material=272,Rotation=v3(0.1850000023841858,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i1958,{MeshId="rbxassetid://752940475"})
	i1960=new("Part",i1939,{Name="MeshPart",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1140.8123779296875,-20.6345272064209,503.1629638671875,0,0.0006139997858554125,-0.9999998807907104,-0.0032339992467314005,0.9999946355819702,0.0006139966426417232,0.9999947547912598,0.003233998781070113,0.000001985674998650211),CanCollide=t,Material=272,Rotation=v3(0.1850000023841858,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i1960,{MeshId="rbxassetid://752938318"})
	new("IntValue",i1960,{Name="Slot1"})
	i1963=new("Part",i1939,{Name="MeshPart",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1140.8978271484375,-20.6953182220459,503.168212890625,0,0.0006139997858554125,-0.9999998807907104,-0.0032339992467314005,0.9999946355819702,0.0006139966426417232,0.9999947547912598,0.003233998781070113,0.000001985674998650211),CanCollide=t,Material=272,Rotation=v3(0.1850000023841858,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i1963,{MeshId="rbxassetid://752937902"})
	new("IntValue",i1963,{Name="Slot1"})
	new("Part",i1939,{Name="Trigger",Anchored=t,BottomSurface=0,BrickColor=bc(199),CFrame=cf(-1140.7537841796875,-21.00757598876953,503.1712646484375,-0.00027299998328089714,0.0005829998408444226,-0.9999997615814209,-0.003508999478071928,0.9999937415122986,0.0005839542136527598,0.9999938607215881,0.0035091582685709,-0.00027095249970443547),CanCollide=t,Material=1088,Rotation=v3(0.20100000500679016,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Part",i1939,{Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1142.6273193359375,-20.4064998626709,503.172607421875,-0.00021499989088624716,0.0006140002515166998,-0.9999998807907104,-0.003611998399719596,0.9999933838844299,0.0006147728418000042,0.9999935030937195,0.003612130181863904,-0.00021278069471009076),CanCollide=t,Material=1088,Rotation=v3(0.2070000022649765,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i1968=new("Part",i1939,{Name="BoltBack",Anchored=t,BottomSurface=0,BrickColor=bc(302),CFrame=cf(-1141.2967529296875,-20.590456008911133,503.1685791015625,0,0.0006139997858554125,-0.9999998807907104,-0.0032339992467314005,0.9999946355819702,0.0006139966426417232,0.9999947547912598,0.003233998781070113,0.000001985674998650211),CanCollide=t,Material=272,Rotation=v3(0.1850000023841858,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1})
	new("FileMesh",i1968,{MeshId="rbxassetid://752940986"})
	i1970=new("Part",i1939,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1139.8382568359375,-20.683475494384766,503.1734619140625,5.478212017351325e-08,-4.435431222304942e-08,-1,-9.297919234541041e-08,1,-4.435431932847678e-08,1,9.297919234541041e-08,5.478211306808589e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i1970,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i1970,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i1970,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i1970,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	i1975=new("Part",i1939,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1141.0545654296875,-21.32288360595703,503.13525390625,6.026269705472487e-09,-7.415669500687727e-08,-1,-2.2633223295542848e-07,1,-7.415669500687727e-08,1,2.2633223295542848e-07,6.0262528300825124e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i1975,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i1975,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i1975,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i1975,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i1975,{Name="Fire",SoundId="rbxassetid://896335161",Volume=1})
	i1981=new("Folder",i1939,{Name="Settings"})
	new("IntValue",i1981,{Name="Recoil",Value=1})
	new("IntValue",i1981,{Name="StoredAmmo",Value=21})
	new("IntValue",i1981,{Name="Mag",Value=10})
	new("BoolValue",i1981,{Name="Auto",Value=t})
	new("NumberValue",i1981,{Name="FireRate",Value=0.045})
	new("IntValue",i1981,{Name="FireMode",Value=1})
	new("BoolValue",i1981,{Name="CanSelectFire",Value=t})
	new("IntValue",i1981,{Name="Ammo",Value=21})
	new("IntValue",i1981,{Name="AimZoom",Value=35})
	new("IntValue",i1981,{Name="Drop",Value=135})
	new("IntValue",i1981,{Name="CycleZoom",Value=50})
	new("StringValue",i1981,{Name="RifleOrPistol",Value="pistol"})
	new("BoolValue",i1981,{Name="IsGun",Value=t})
	new("IntValue",i1981,{Name="ShotCount",Value=1})
	new("StringValue",i1981,{Name="Rarity",Value="uncommon"})
	new("BoolValue",i1981,{Name="Dismember"})
	new("StringValue",i1981,{Name="AmmoType",Value="pistol"})
	new("Part",i1939,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1141.0032958984375,-20.6315975189209,503.2274169921875,1,0,0,0,1,0,0,0,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i2000=new("Model",i1,{Name="M240 Bravo"})
	i2001=new("Folder",i2000,{Name="Settings"})
	new("IntValue",i2001,{Name="Recoil",Value=1})
	new("IntValue",i2001,{Name="StoredAmmo",Value=151})
	new("IntValue",i2001,{Name="Mag",Value=6})
	new("BoolValue",i2001,{Name="Auto",Value=t})
	new("NumberValue",i2001,{Name="FireRate",Value=0.08})
	new("IntValue",i2001,{Name="FireMode",Value=1})
	new("BoolValue",i2001,{Name="CanSelectFire",Value=t})
	new("IntValue",i2001,{Name="Ammo",Value=151})
	new("IntValue",i2001,{Name="AimZoom",Value=35})
	new("IntValue",i2001,{Name="Drop",Value=135})
	new("IntValue",i2001,{Name="CycleZoom",Value=50})
	new("StringValue",i2001,{Name="RifleOrPistol"})
	new("BoolValue",i2001,{Name="IsGun",Value=t})
	new("IntValue",i2001,{Name="ShotCount",Value=1})
	new("StringValue",i2001,{Name="Rarity",Value="godly"})
	new("BoolValue",i2001,{Name="Dismember",Value=t})
	new("StringValue",i2001,{Name="AmmoType",Value="rifle"})
	i2019=new("Part",i2000,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1140.0531005859375,-21.6200008392334,507.74267578125,6.177397260387352e-09,-6.315859479855135e-08,-1,-1.9952237551024155e-07,1,-6.315859479855135e-08,1,1.9952237551024155e-07,6.177385269978686e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i2019,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i2019,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i2019,{Name="MagIn",Pitch=0.800000011920929,PlaybackSpeed=0.800000011920929,SoundId="rbxassetid://896337875",Volume=1})
	new("Sound",i2019,{Name="MagOut",Pitch=0.699999988079071,PlaybackSpeed=0.699999988079071,SoundId="rbxassetid://896337931",Volume=1})
	new("Sound",i2019,{Name="Fire",SoundId="rbxassetid://2058020514",Volume=3})
	i2025=new("Part",i2000,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1135.6566162109375,-21.0263729095459,507.708740234375,5.493356169949948e-08,-3.335593135034287e-08,-1,-6.623014314754982e-08,1,-3.335593490305655e-08,1,6.623015025297718e-08,5.49335581467858e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i2025,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i2025,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i2025,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i2025,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	new("Part",i2000,{Name="Bolt",Anchored=t,BrickColor=bc(226),CFrame=cf(-1140.6292724609375,-20.972782135009766,507.707763671875,-0.00011897212971234694,1,2.3392203729599714e-09,-1,-0.00011897212971234694,0.000043158601329196244,0.000043158601329196244,2.7976057026535273e-09,1),Material=272,Rotation=v3(-0.0020000000949949026,0,-90.00700378417969),Size=v3(0.05000000074505806,0.05249999836087227,0.05000000074505806),FormFactor=3})
	new("Part",i2000,{Name="BoltBack",Anchored=t,BrickColor=bc(226),CFrame=cf(-1140.6292724609375,-20.972782135009766,507.707763671875,-0.00011897212971234694,1,2.3392203729599714e-09,-1,-0.00011897212971234694,0.000043158601329196244,0.000043158601329196244,2.7976057026535273e-09,1),Material=272,Rotation=v3(-0.0020000000949949026,0,-90.00700378417969),Size=v3(0.05000000074505806,0.05249999836087227,0.05000000074505806),Transparency=1,FormFactor=3})
	new("Part",i2000,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1139.2313232421875,-20.930667877197266,507.783203125,0.9991779923439026,0,-0.040539998561143875,0,1,0,0.040539998561143875,0,0.9991779923439026),Rotation=v3(0,-2.322999954223633,0),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i2033=new("Part",i2000,{Name="Union",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1138.9344482421875,-21.3984432220459,507.702880859375,-1,0,0,0,1,0,0,0,-1),Rotation=v3(180,0,180),Size=v3(1.7000001668930054,0.18000005185604095,0.11999987065792084),TopSurface=0})
	new("SpecialMesh",i2033,{MeshId="rbxassetid://2057960956",MeshType=5})
	i2035=new("Part",i2000,{Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1139.3934326171875,-21.221437454223633,507.698974609375,-1,0,0,0,1,0,0,0,-1),Rotation=v3(180,0,180),Size=v3(1.7000001668930054,0.18000005185604095,0.11999987065792084),TopSurface=0})
	new("SpecialMesh",i2035,{MeshId="rbxassetid://2057956160",MeshType=5})
	i2037=new("Part",i2000,{Name="Union",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1139.7523193359375,-20.834354400634766,507.657958984375,-1,0,0,0,1,0,0,0,-1),Rotation=v3(180,0,180),Size=v3(1.7000001668930054,0.18000005185604095,0.11999987065792084),TopSurface=0})
	new("SpecialMesh",i2037,{MeshId="rbxassetid://2057925243",MeshType=5})
	i2039=new("Part",i2000,{Name="AimPart",Anchored=t,BackSurface=10,BottomSurface=10,CFrame=cf(-1141.2230224609375,-20.693967819213867,507.714111328125,5.973306159597069e-13,-3.554786189852166e-07,-0.9999959468841553,-1.7902345916809281e-07,0.9999959468841553,-3.554786189852166e-07,1,1.790241839216833e-07,5.336935862861047e-13),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(90,-89.83699798583984,90),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=10,Transparency=1})
	new("BlockMesh",i2039,{Scale=v3(0.02569444477558136,0.030833333730697632,0.05138888955116272)})
	i2041=new("Part",i2000,{Name="Mag1",Anchored=t,BottomSurface=0,BrickColor=bc(328),CFrame=cf(-1139.2205810546875,-21.4753475189209,507.69091796875,-1,0,0,0,1,0,0,0,-1),Rotation=v3(180,0,180),Size=v3(0.3000004291534424,0.18000005185604095,0.11999987065792084),TopSurface=0})
	new("SpecialMesh",i2041,{MeshId="rbxassetid://2057941881",MeshType=5})
	i2043=new("Part",i2000,{Name="Mag",Anchored=t,BottomSurface=0,BrickColor=bc(24),CFrame=cf(-1139.2244873046875,-21.113407135009766,507.5389404296875,-1,0,0,0,1,0,0,0,-1),Rotation=v3(180,0,180),Size=v3(0.3000004291534424,0.18000005185604095,0.11999987065792084),TopSurface=0})
	new("SpecialMesh",i2043,{MeshId="rbxassetid://2057935141",MeshType=5})
	i2045=new("Model",i1,{Name="Pistol Ammo"})
	new("Part",i2045,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(311),CFrame=cf(-1158.0213623046875,-21.50415802001953,489.4453125,-1,0,0,0,1,0,0,0,-1),Material=272,Rotation=v3(180,0,180),Size=v3(1.1433336734771729,0.4316668212413788,0.7166668772697449),TopSurface=0})
	new("Part",i2045,{Anchored=t,BottomSurface=0,BrickColor=bc(1001),CFrame=cf(-1158.2054443359375,-21.4844970703125,489.7802734375,-1,0,0,0,1,0,0,0,-1),Material=272,Rotation=v3(180,0,180),Size=v3(0.6750003099441528,0.32499992847442627,0.05000000074505806),TopSurface=0})
	i2048=new("Folder",i2045,{Name="Settings"})
	new("StringValue",i2048,{Name="AmmoType",Value="pistol"})
	new("IntValue",i2048,{Name="Ammunition",Value=30})
	new("StringValue",i2048,{Name="Rarity",Value="uncommon"})
	i2052=new("Model",i1,{Name="Shotgun Shells"})
	i2053=new("Folder",i2052,{Name="Settings"})
	new("StringValue",i2053,{Name="AmmoType",Value="shotgun"})
	new("IntValue",i2053,{Name="Ammunition",Value=10})
	new("StringValue",i2053,{Name="Rarity",Value="uncommon"})
	new("Part",i2052,{Anchored=t,BottomSurface=0,BrickColor=bc(332),CFrame=cf(-1160.0623779296875,-21.559206008911133,489.4052734375,-1,0,0,0,1,0,0,0,-1),Material=272,Rotation=v3(180,0,180),Size=v3(0.8233335614204407,0.3216668367385864,0.7166668772697449),TopSurface=0})
	new("Part",i2052,{Anchored=t,BottomSurface=0,BrickColor=bc(1005),CFrame=cf(-1159.7962646484375,-21.50415802001953,489.6201171875,-1,0,0,0,1,0,0,0,-1),Material=272,Rotation=v3(180,0,180),Size=v3(0.19300000369548798,0.36000001430511475,0.19699999690055847),TopSurface=0})
	new("Part",i2052,{Anchored=t,BottomSurface=0,BrickColor=bc(1005),CFrame=cf(-1159.7962646484375,-21.50415802001953,489.1851806640625,-1,0,0,0,1,0,0,0,-1),Material=272,Rotation=v3(180,0,180),Size=v3(0.19300000369548798,0.36000001430511475,0.19699999690055847),TopSurface=0})
	new("Part",i2052,{Anchored=t,BottomSurface=0,BrickColor=bc(1005),CFrame=cf(-1159.7962646484375,-21.50415802001953,489.400390625,-1,0,0,0,1,0,0,0,-1),Material=272,Rotation=v3(180,0,180),Size=v3(0.19300000369548798,0.36000001430511475,0.19699999690055847),TopSurface=0})
	new("Part",i2052,{Anchored=t,BottomSurface=0,BrickColor=bc(332),CFrame=cf(-1159.6473388671875,-21.50415802001953,489.4052734375,-1,0,0,0,1,0,0,0,-1),Material=272,Rotation=v3(180,0,180),Size=v3(0.05000000074505806,0.4316668212413788,0.7166668772697449),TopSurface=0})
	new("Part",i2052,{Anchored=t,BottomSurface=0,BrickColor=bc(1005),CFrame=cf(-1160.0238037109375,-21.50415802001953,489.6201171875,-1,0,0,0,1,0,0,0,-1),Material=272,Rotation=v3(180,0,180),Size=v3(0.19300000369548798,0.36000001430511475,0.19699999690055847),TopSurface=0})
	new("Part",i2052,{Anchored=t,BottomSurface=0,BrickColor=bc(1005),CFrame=cf(-1160.0238037109375,-21.50415802001953,489.1851806640625,-1,0,0,0,1,0,0,0,-1),Material=272,Rotation=v3(180,0,180),Size=v3(0.19300000369548798,0.36000001430511475,0.19699999690055847),TopSurface=0})
	new("Part",i2052,{Anchored=t,BottomSurface=0,BrickColor=bc(1005),CFrame=cf(-1160.0238037109375,-21.50415802001953,489.400390625,-1,0,0,0,1,0,0,0,-1),Material=272,Rotation=v3(180,0,180),Size=v3(0.19300000369548798,0.36000001430511475,0.19699999690055847),TopSurface=0})
	new("Part",i2052,{Anchored=t,BottomSurface=0,BrickColor=bc(1005),CFrame=cf(-1160.2601318359375,-21.50415802001953,489.6201171875,-1,0,0,0,1,0,0,0,-1),Material=272,Rotation=v3(180,0,180),Size=v3(0.19300000369548798,0.36000001430511475,0.19699999690055847),TopSurface=0})
	new("Part",i2052,{Anchored=t,BottomSurface=0,BrickColor=bc(1005),CFrame=cf(-1160.2601318359375,-21.50415802001953,489.1851806640625,-1,0,0,0,1,0,0,0,-1),Material=272,Rotation=v3(180,0,180),Size=v3(0.19300000369548798,0.36000001430511475,0.19699999690055847),TopSurface=0})
	new("Part",i2052,{Anchored=t,BottomSurface=0,BrickColor=bc(1005),CFrame=cf(-1160.2601318359375,-21.50415802001953,489.400390625,-1,0,0,0,1,0,0,0,-1),Material=272,Rotation=v3(180,0,180),Size=v3(0.19300000369548798,0.36000001430511475,0.19699999690055847),TopSurface=0})
	new("Part",i2052,{Anchored=t,BottomSurface=0,BrickColor=bc(332),CFrame=cf(-1160.1072998046875,-21.35413360595703,489.4052734375,-1,0,0,0,1,0,0,0,-1),Material=272,Rotation=v3(180,0,180),Size=v3(0.6699997782707214,0.13166680932044983,0.6766669154167175),TopSurface=0})
	i2069=new("Model",i1,{Name="Rifle Ammo"})
	new("Part",i2069,{Anchored=t,BottomSurface=0,BrickColor=bc(141),CFrame=cf(-1155.7064208984375,-20.8323974609375,489.8453369140625,-1,0,0,0,1,0,0,0,-1),Material=272,Rotation=v3(180,0,180),Size=v3(0.8833337426185608,0.09166675060987473,0.48333361744880676),TopSurface=0})
	new("Part",i2069,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(141),CFrame=cf(-1155.7064208984375,-21.2990779876709,489.8453369140625,-1,0,0,0,1,0,0,0,-1),Material=272,Rotation=v3(180,0,180),Size=v3(1.4333337545394897,0.8416667580604553,0.7166668772697449),TopSurface=0})
	new("Part",i2069,{Anchored=t,BottomSurface=0,BrickColor=bc(1001),CFrame=cf(-1156.03564453125,-21.099124908447266,490.1802978515625,-1,0,0,0,1,0,0,0,-1),Material=272,Rotation=v3(180,0,180),Size=v3(0.6750003099441528,0.32499992847442627,0.05000000074505806),TopSurface=0})
	i2073=new("Folder",i2069,{Name="Settings"})
	new("StringValue",i2073,{Name="AmmoType",Value="rifle"})
	new("IntValue",i2073,{Name="Ammunition",Value=30})
	new("StringValue",i2073,{Name="Rarity",Value="uncommon"})
	i2077=new("Model",i1,{Name="M249 SAW"})
	i2078=new("Folder",i2077,{Name="Settings"})
	new("IntValue",i2078,{Name="Recoil",Value=1})
	new("IntValue",i2078,{Name="StoredAmmo",Value=201})
	new("IntValue",i2078,{Name="Mag",Value=6})
	new("BoolValue",i2078,{Name="Auto",Value=t})
	new("NumberValue",i2078,{Name="FireRate",Value=0.06})
	new("IntValue",i2078,{Name="FireMode",Value=1})
	new("BoolValue",i2078,{Name="CanSelectFire",Value=t})
	new("IntValue",i2078,{Name="Ammo",Value=201})
	new("IntValue",i2078,{Name="AimZoom",Value=35})
	new("IntValue",i2078,{Name="Drop",Value=135})
	new("IntValue",i2078,{Name="CycleZoom",Value=50})
	new("StringValue",i2078,{Name="RifleOrPistol"})
	new("BoolValue",i2078,{Name="IsGun",Value=t})
	new("IntValue",i2078,{Name="ShotCount",Value=1})
	new("StringValue",i2078,{Name="Rarity",Value="godly"})
	new("BoolValue",i2078,{Name="Dismember",Value=t})
	new("StringValue",i2078,{Name="AmmoType",Value="rifle"})
	i2096=new("Part",i2077,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1136.4583740234375,-20.526493072509766,512.748291015625,5.493356169949948e-08,-3.335593135034287e-08,-1,-6.623014314754982e-08,1,-3.335593490305655e-08,1,6.623015025297718e-08,5.49335581467858e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i2096,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i2096,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i2096,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i2096,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	new("Part",i2077,{Name="Bolt",Anchored=t,BrickColor=bc(226),CFrame=cf(-1140.6292724609375,-20.4835262298584,512.75537109375,-0.00011897212971234694,1,2.3392203729599714e-09,-1,-0.00011897212971234694,0.000043158601329196244,0.000043158601329196244,2.7976057026535273e-09,1),Material=272,Rotation=v3(-0.0020000000949949026,0,-90.00700378417969),Size=v3(0.05000000074505806,0.05249999836087227,0.05000000074505806),FormFactor=3})
	new("Part",i2077,{Name="BoltBack",Anchored=t,BrickColor=bc(226),CFrame=cf(-1140.6292724609375,-20.4835262298584,512.75537109375,-0.00011897212971234694,1,2.3392203729599714e-09,-1,-0.00011897212971234694,0.000043158601329196244,0.000043158601329196244,2.7976057026535273e-09,1),Material=272,Rotation=v3(-0.0020000000949949026,0,-90.00700378417969),Size=v3(0.05000000074505806,0.05249999836087227,0.05000000074505806),Transparency=1,FormFactor=3})
	new("Part",i2077,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1139.6068115234375,-20.516849517822266,512.8076171875,0.9991779923439026,0,-0.040539998561143875,0,1,0,0.040539998561143875,0,0.9991779923439026),Rotation=v3(0,-2.322999954223633,0),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i2104=new("Part",i2077,{Name="Mag",Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(29),CFrame=cf(-1139.5950927734375,-21.0939998626709,512.7294921875,0,0,-1,0,1,0,1,0,0),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(0,-90,0),Size=v3(0.9000000357627869,1.0600001811981201,0.2900000214576721),TopSurface=10})
	new("SpecialMesh",i2104,{Scale=v3(1,1.399999976158142,1),MeshId="rbxassetid://2074823368",MeshType=5})
	i2106=new("Part",i2077,{Name="Mag1",Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(333),CFrame=cf(-1139.6151123046875,-20.673709869384766,512.548583984375,0,0,-1,0,1,0,1,0,0),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(0,-90,0),Size=v3(0.30000007152557373,0.440000057220459,4.500000953674316),TopSurface=10})
	new("SpecialMesh",i2106,{MeshId="rbxassetid://2074826156",MeshType=5})
	i2108=new("Part",i2077,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(1003),CFrame=cf(-1138.5570068359375,-20.425661087036133,512.737548828125,0,0,-1,0,1,0,1,0,0),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(0,-90,0),Size=v3(0.30000007152557373,0.440000057220459,4.500000953674316),TopSurface=10})
	new("SpecialMesh",i2108,{MeshId="rbxassetid://2074820580",MeshType=5})
	i2110=new("Part",i2077,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(26),CFrame=cf(-1138.7113037109375,-20.3897762298584,512.864501953125,0,0,-1,0,1,0,1,0,0),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(0,-90,0),Size=v3(0.30000007152557373,0.440000057220459,4.500000953674316),TopSurface=10})
	new("SpecialMesh",i2110,{MeshId="rbxassetid://2074804343",MeshType=5})
	i2112=new("Part",i2077,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(26),CFrame=cf(-1139.9910888671875,-20.377687454223633,512.6845703125,0,0,-1,0,1,0,1,0,0),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(0,-90,0),Size=v3(0.30000007152557373,0.440000057220459,4.500000953674316),TopSurface=10})
	new("SpecialMesh",i2112,{MeshId="rbxassetid://2074817499",MeshType=5})
	i2114=new("Part",i2077,{Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(1003),CFrame=cf(-1139.8592529296875,-20.9227352142334,512.738525390625,0,0,-1,0,1,0,1,0,0),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(0,-90,0),Size=v3(0.30000007152557373,0.440000057220459,4.500000953674316),TopSurface=10})
	new("SpecialMesh",i2114,{MeshId="rbxassetid://2074811883",MeshType=5})
	i2116=new("Part",i2077,{Name="AimPart",Anchored=t,BackSurface=10,BottomSurface=10,CFrame=cf(-1141.1541748046875,-20.2659969329834,512.744140625,-4.371138828673793e-08,0,-1,0,1,0,1,0,-4.371138828673793e-08),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=10,Transparency=1})
	new("BlockMesh",i2116,{Scale=v3(0.02936507947742939,0.03523809462785721,0.05873015895485878)})
	i2118=new("Part",i2077,{Name="Handle",Anchored=t,BackSurface=10,BottomSurface=10,CFrame=cf(-1140.0838623046875,-21.154176712036133,512.75439453125,-0.00011940237891394645,-0.014834274537861347,-0.9998899698257446,0.008044995367527008,0.9998576045036316,-0.014834755100309849,0.999967634677887,-0.008045881986618042,-4.370657791241683e-08),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(90,-89.1500015258789,90.46099853515625),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=10,Transparency=1})
	new("Sound",i2118,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i2118,{Name="Fire",SoundId="rbxassetid://2058020514",Volume=3})
	new("Sound",i2118,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i2118,{Name="MagIn",Pitch=0.800000011920929,PlaybackSpeed=0.800000011920929,SoundId="rbxassetid://896337875",Volume=1})
	new("Sound",i2118,{Name="MagOut",Pitch=0.699999988079071,PlaybackSpeed=0.699999988079071,SoundId="rbxassetid://896337931",Volume=1})
	i2124=new("Model",i1,{Name="M4A1"})
	i2125=new("Folder",i2124,{Name="Settings"})
	new("IntValue",i2125,{Name="Recoil",Value=1})
	new("IntValue",i2125,{Name="StoredAmmo",Value=30})
	new("IntValue",i2125,{Name="Mag",Value=6})
	new("BoolValue",i2125,{Name="Auto",Value=t})
	new("NumberValue",i2125,{Name="FireRate",Value=0.07})
	new("IntValue",i2125,{Name="FireMode",Value=1})
	new("BoolValue",i2125,{Name="CanSelectFire",Value=t})
	new("IntValue",i2125,{Name="Ammo",Value=31})
	new("IntValue",i2125,{Name="AimZoom",Value=35})
	new("IntValue",i2125,{Name="Drop",Value=135})
	new("IntValue",i2125,{Name="CycleZoom",Value=50})
	new("StringValue",i2125,{Name="RifleOrPistol"})
	new("BoolValue",i2125,{Name="IsGun",Value=t})
	new("IntValue",i2125,{Name="ShotCount",Value=1})
	new("StringValue",i2125,{Name="Rarity",Value="rare"})
	new("BoolValue",i2125,{Name="Dismember"})
	new("StringValue",i2125,{Name="AmmoType",Value="rifle"})
	i2143=new("Part",i2124,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1139.7667236328125,-21.2100887298584,509.8143310546875,6.184563972055912e-09,-6.31586019039787e-08,-1,-1.9952072705109458e-07,1,-6.315858769312399e-08,1,1.9952032914716256e-07,6.184563972055912e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i2143,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i2143,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i2143,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i2143,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i2143,{Name="Fire",SoundId="rbxassetid://494641952",Volume=4})
	i2149=new("Part",i2124,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1136.9412841796875,-20.6397762298584,509.828857421875,5.4933479987084866e-08,-3.335594200848391e-08,-1,-6.622881443263395e-08,1,-3.3355924244915514e-08,1,6.62289565411811e-08,5.4933479987084866e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i2149,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i2149,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i2149,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i2149,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	new("Part",i2124,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1139.5198974609375,-20.666751861572266,509.888427734375,1,-1.0658141036401503e-14,0,-1.0658141036401503e-14,1,5.860116536991755e-13,0,5.860130631619997e-13,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i2155=new("Part",i2124,{Name="MeshPart",Anchored=t,BrickColor=bc(199),CFrame=cf(-1138.0941162109375,-20.619388580322266,509.8321533203125,1,0,0,0,1,0,0,0,1),CanCollide=t,Size=v3(2.2667720317840576,0.2794489860534668,0.2794508934020996)})
	new("IntValue",i2155,{Name="Slot1"})
	new("FileMesh",i2155,{MeshId="rbxassetid://453268328"})
	i2158=new("Part",i2124,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1138.4896240234375,-20.499393463134766,509.8321533203125,1,0,0,0,1,0,0,0,1),CanCollide=t,Size=v3(1.308156967163086,0.5618100762367249,0.2902837097644806)})
	new("IntValue",i2158,{Name="Slot2"})
	new("FileMesh",i2158,{MeshId="rbxassetid://453270448"})
	i2161=new("Part",i2124,{Name="MeshPart",Anchored=t,BrickColor=bc(199),CFrame=cf(-1139.7713623046875,-20.817384719848633,509.877197265625,1,0,0,0,1,0,0,0,1),CanCollide=t,Size=v3(1.1019819974899292,0.4742860198020935,0.2895280122756958)})
	new("FileMesh",i2161,{MeshId="rbxassetid://453276973"})
	i2163=new("Part",i2124,{Name="BoltBack",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1140.2430419921875,-20.572507858276367,509.8321533203125,1,0,0,0,1,0,0,0,1),CanCollide=t,Size=v3(1.011212944984436,0.22350001335144043,0.2861981987953186),Transparency=1})
	new("FileMesh",i2163,{MeshId="rbxassetid://453276303"})
	i2165=new("Part",i2124,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1140.2005615234375,-20.78540802001953,509.8671875,1,0,0,0,1,0,0,0,1),CanCollide=t,Size=v3(1.9507580995559692,0.6538670063018799,0.2845156192779541)})
	new("IntValue",i2165,{Name="Slot1"})
	new("FileMesh",i2165,{MeshId="rbxassetid://453290424"})
	i2168=new("Part",i2124,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1140.8553466796875,-20.983402252197266,509.8321533203125,1,0,0,0,1,0,0,0,1),CanCollide=t,Size=v3(1.790144920349121,0.9749099612236023,0.20000000298023224)})
	new("IntValue",i2168,{Name="Slot2"})
	new("FileMesh",i2168,{MeshId="rbxassetid://453285796"})
	new("Snap",i2168,{C0=cf(0,0.48745498061180115,0,-1,0,0,0,0,1,0,1,-0),C1=cf(0.0154876708984375,-0.1396191120147705,-1.10986328125,0,-1,0,0,0,1,-1,0,0)})
	i2173=new("Part",i2124,{Name="Mag",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1139.4305419921875,-21.193967819213867,509.8321533203125,0,0,1,0,1,-0,-1,0,0),CanCollide=t,Rotation=v3(0,90,0),Size=v3(0.20000000298023224,1.0249028205871582,0.47074592113494873)})
	new("IntValue",i2173,{Name="Slot2"})
	new("FileMesh",i2173,{MeshId="rbxassetid://453250464"})
	new("Part",i2124,{Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1140.944580078125,-20.2533016204834,509.83203125,-0.00003266368730692193,0.000043158150219824165,-1,9.295133551745494e-10,1,0.000043158150219824165,1,4.801909980756136e-10,-0.00003266368730692193),CanCollide=t,Material=272,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Part",i2124,{Name="Trigger",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1139.8914794921875,-20.960819244384766,509.8321533203125,-0.00003266368730692193,0.000043158150219824165,-1,9.295133551745494e-10,1,0.000043158150219824165,1,4.801909980756136e-10,-0.00003266368730692193),CanCollide=t,Material=272,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i2172=new("Part",i2124,{Name="Iron",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1139.7454833984375,-20.356327056884766,509.84765625,0,0,1,0,1,-0,-1,0,0),CanCollide=t,Rotation=v3(0,90,0),Size=v3(0.20000000298023224,0.28876006603240967,1.0448017120361328)})
	new("IntValue",i2172,{Name="Slot2"})
	new("FileMesh",i2172,{MeshId="rbxassetid://455704535"})
	i2181=new("Part",i2124,{Name="Bolt",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1139.8074951171875,-20.572507858276367,509.8321533203125,1,0,0,0,1,0,0,0,1),CanCollide=t,Size=v3(1.011212944984436,0.22350001335144043,0.2861981987953186)})
	new("FileMesh",i2181,{MeshId="rbxassetid://453276303"})
	new("Snap",i2181,{C0=cf(0,-0.11175000667572021,0,1,0,0,0,0,-1,0,1,0),C1=cf(0,0.5097099542617798,-0.376953125,0,-1,0,0,0,-1,1,0,0)})
	i2184=new("Model",i1,{Name="MK11"})
	i2185=new("Folder",i2184,{Name="Settings"})
	new("IntValue",i2185,{Name="Recoil",Value=1})
	new("IntValue",i2185,{Name="StoredAmmo",Value=21})
	new("IntValue",i2185,{Name="Mag",Value=6})
	new("BoolValue",i2185,{Name="Auto"})
	new("NumberValue",i2185,{Name="FireRate",Value=0.07})
	new("IntValue",i2185,{Name="FireMode",Value=2})
	new("BoolValue",i2185,{Name="CanSelectFire"})
	new("IntValue",i2185,{Name="Ammo",Value=21})
	new("IntValue",i2185,{Name="AimZoom",Value=10})
	new("IntValue",i2185,{Name="Drop",Value=135})
	new("IntValue",i2185,{Name="CycleZoom",Value=50})
	new("StringValue",i2185,{Name="RifleOrPistol"})
	new("BoolValue",i2185,{Name="IsGun",Value=t})
	new("IntValue",i2185,{Name="ShotCount",Value=1})
	new("StringValue",i2185,{Name="Rarity",Value="legendary"})
	new("BoolValue",i2185,{Name="Dismember"})
	new("StringValue",i2185,{Name="AmmoType",Value="rifle"})
	i2203=new("Part",i2184,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1139.7667236328125,-21.2100887298584,510.67431640625,6.184563972055912e-09,-6.31586019039787e-08,-1,-1.9952072705109458e-07,1,-6.315858769312399e-08,1,1.9952032914716256e-07,6.184563972055912e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i2203,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i2203,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i2203,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i2203,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i2203,{Name="Fire",SoundId="rbxassetid://494641952",Volume=4})
	i2209=new("Part",i2184,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(-1136.1761474609375,-20.6397762298584,510.6827392578125,5.4933479987084866e-08,-3.335594200848391e-08,-1,-6.622881443263395e-08,1,-3.3355924244915514e-08,1,6.62289565411811e-08,5.4933479987084866e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i2209,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i2209,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i2209,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i2209,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	new("Part",i2184,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1139.3035888671875,-20.666751861572266,510.74853515625,1,-1.0658141036401503e-14,0,-1.0658141036401503e-14,1,5.860116536991755e-13,0,5.860130631619997e-13,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i2215=new("Part",i2184,{Name="Mag",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1139.2835693359375,-21.2781982421875,510.688232421875,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(0.4289989471435547,0.8298550844192505,0.20000000298023224)})
	new("IntValue",i2215,{Name="Slot2"})
	new("FileMesh",i2215,{MeshId="rbxassetid://476808524"})
	i2218=new("Part",i2184,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(-1139.6986083984375,-21.0468807220459,510.693115234375,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(3.7784996032714844,1.0201759338378906,0.34200286865234375)})
	new("IntValue",i2218,{Name="Slot1"})
	new("FileMesh",i2218,{MeshId="rbxassetid://476802995"})
	i2221=new("Part",i2184,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1138.2371826171875,-20.7988338470459,510.688232421875,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(4.107000350952148,0.6740990281105042,0.30899810791015625)})
	new("IntValue",i2221,{Name="Slot2"})
	new("FileMesh",i2221,{MeshId="rbxassetid://476802377"})
	i2224=new("Part",i2184,{Name="Bolt",Anchored=t,BrickColor=bc(302),CFrame=cf(-1139.640380859375,-20.5778865814209,510.688232421875,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.1684989929199219,0.22800004482269287,0.25350189208984375)})
	new("FileMesh",i2224,{MeshId="rbxassetid://476813827"})
	i2226=new("Part",i2184,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1138.0135498046875,-20.6048641204834,510.688232421875,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.733999252319336,0.2738999128341675,0.25499725341796875)})
	new("IntValue",i2226,{Name="Slot2"})
	new("FileMesh",i2226,{MeshId="rbxassetid://476807542"})
	i2229=new("Part",i2184,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1138.6865234375,-20.6208553314209,510.690185546875,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(3.0495052337646484,0.35302650928497314,0.29901123046875)})
	new("IntValue",i2229,{Name="Slot2"})
	new("FileMesh",i2229,{MeshId="rbxassetid://476807128"})
	i2232=new("Part",i2184,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(-1139.6331787109375,-20.8169002532959,510.710205078125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.3199996948242188,0.6834930181503296,0.2332000732421875)})
	new("IntValue",i2232,{Name="Slot2"})
	new("FileMesh",i2232,{MeshId="rbxassetid://476803692"})
	new("Part",i2184,{Name="Trigger",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(-1139.7381591796875,-21.017946243286133,510.688232421875,-0.00003266368730692193,0.00008631723176222295,-1,0.00004316046033636667,1,0.0000863158202264458,1,-0.00004315764090279117,-0.00003266741259722039),CanCollide=t,Material=1088,Rotation=v3(-0.0020000000949949026,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i2236=new("Part",i2184,{Name="BoltBack",Anchored=t,BrickColor=bc(302),CFrame=cf(-1140.1317138671875,-20.577760696411133,510.688232421875,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.1684989929199219,0.22800004482269287,0.25350189208984375),Transparency=1})
	new("FileMesh",i2236,{MeshId="rbxassetid://476813827"})
	i2238=new("Part",i2184,{CustomPhysicalProperties=PhysicalProperties.new(0.699999988079071,2,0,1,1),Name="Reticle",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1139.1290283203125,-20.233034133911133,510.6854248046875,-1,-0.00003100272806477733,0.000029997177989571355,-0.00003099999958067201,1,0.00009100093302549794,-0.000029999999242136255,0.00009100000170292333,-1),CanCollide=t,Material=1088,Rotation=v3(-179.9949951171875,0.0020000000949949026,179.9980010986328),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i2239=new("SurfaceGui",i2238,{CanvasSize=v2(100,100),Face=0})
	new("ImageLabel",i2239,{BackgroundColor3=c3(1,1,1),BackgroundTransparency=1,BorderColor3=c3(1,1,1),BorderSizePixel=0,Size=ud2(1,0,1,0),Image="rbxassetid://657305296"})
	new("BlockMesh",i2238,{Scale=v3(0.024000000208616257,0.6000000238418579,0.6000000238418579)})
	i2242=new("Part",i2184,{Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(-1139.6263427734375,-20.276126861572266,510.683349609375,1,0,0,0,1,0,0,0,1),Size=v3(0.9700002670288086,0.42999985814094543,0.2400001585483551),TopSurface=0})
	new("SpecialMesh",i2242,{MeshId="rbxassetid://2035852320",MeshType=5})
	i2244=new("Part",i2184,{CustomPhysicalProperties=PhysicalProperties.new(7.849999904632568,0.30000001192092896,0,1,1),Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(-1140.8743896484375,-20.233034133911133,510.6854248046875,-0.00014000000373926014,0,-1,-0.000043000000005122274,1,6.0200000540078236e-09,1,0.000043000000005122274,-0.00014000000373926014),CanCollide=t,Material=1088,Rotation=v3(0.0020000000949949026,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("BlockMesh",i2244,{Scale=v3(0.47999998927116394,0.47999998927116394,0.47999998927116394)})
	i2246=new("Model",i1,{Name="M16A2 MOD1"})
	i2248=new("Folder",i2246,{Name="Settings"})
	new("IntValue",i2248,{Name="Recoil",Value=1})
	new("IntValue",i2248,{Name="StoredAmmo",Value=30})
	new("IntValue",i2248,{Name="Mag",Value=6})
	new("BoolValue",i2248,{Name="Auto"})
	new("NumberValue",i2248,{Name="FireRate",Value=0.07})
	new("IntValue",i2248,{Name="FireMode",Value=2})
	new("BoolValue",i2248,{Name="CanSelectFire",Value=t})
	new("IntValue",i2248,{Name="Ammo",Value=31})
	new("IntValue",i2248,{Name="Drop",Value=135})
	new("IntValue",i2248,{Name="CycleZoom",Value=50})
	new("StringValue",i2248,{Name="RifleOrPistol"})
	new("BoolValue",i2248,{Name="IsGun",Value=t})
	new("IntValue",i2248,{Name="ShotCount",Value=1})
	new("StringValue",i2248,{Name="Rarity",Value="rare"})
	new("BoolValue",i2248,{Name="Dismember"})
	new("StringValue",i2248,{Name="AmmoType",Value="rifle"})
	new("IntValue",i2248,{Name="AimZoom",Value=10})
	i2266=new("Part",i2246,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(420.3482666015625,3.1168150901794434,-129.9334716796875,0.000057999990531243384,0.00014200000441633165,1,1,0.00009799176041269675,-0.00005801391671411693,-0.000097999996796716,1,-0.00014199431461747736),Material=272,Reflectance=0.30000001192092896,Rotation=v3(89.99400329589844,90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i2266,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i2266,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i2266,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i2266,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i2266,{Name="Fire",Pitch=0.8999999761581421,PlaybackSpeed=0.8999999761581421,SoundId="rbxassetid://620716624",Volume=4})
	i2272=new("Part",i2246,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(416.713623046875,3.104119062423706,-129.2120361328125,0.000057999990531243384,0.00014200000441633165,1,1,0.00009699176007416099,-0.00005801377119496465,-0.00009699999645818025,1,-0.00014199437282513827),Material=272,Reflectance=0.30000001192092896,Rotation=v3(89.99400329589844,90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i2272,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i2272,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i2272,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i2272,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	i2247=new("Part",i2246,{Name="Trigger",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(420.4039306640625,3.145256996154785,-129.528076171875,0.00009899998985929415,0.00010000000474974513,1,1,0.00009699009387986735,-0.00009900970326270908,-0.00009699999645818025,1,-0.00009999040048569441),Material=272,Rotation=v3(89.99400329589844,90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Part",i2246,{Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(421.613037109375,3.1451361179351807,-128.8206787109375,0.00009899998985929415,0.00010000000474974513,1,1,0.00009699009387986735,-0.00009900970326270908,-0.00009699999645818025,1,-0.00009999040048569441),Material=272,Rotation=v3(89.99400329589844,90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i2279=new("Part",i2246,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(418.171142578125,3.1464788913726807,-129.0667724609375,-0.00019799999427050352,0.00014200000441633165,-1,-1,0.00005497188612935133,0.00019800780864898115,0.00005500000042957254,1,0.00014198911958374083),Material=272,Rotation=v3(89.99700164794922,-90,0),Size=v3(0.20000000298023224,0.5453969836235046,2.8998520374298096)})
	new("IntValue",i2279,{Name="Slot1"})
	new("FileMesh",i2279,{MeshId="rbxassetid://455703983"})
	i2282=new("Part",i2246,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(418.802978515625,3.145379066467285,-129.1868896484375,-0.00019799999427050352,0.00014200000441633165,-1,-1,0.00005497188612935133,0.00019800780864898115,0.00005500000042957254,1,0.00014198911958374083),Material=272,Rotation=v3(89.99700164794922,-90,0),Size=v3(0.29053401947021484,0.32334762811660767,1.7146449089050293)})
	new("IntValue",i2282,{Name="Slot2"})
	new("FileMesh",i2282,{MeshId="rbxassetid://455699837"})
	i2285=new("Part",i2246,{Name="Bolt",Anchored=t,BrickColor=bc(1003),CFrame=cf(420.323974609375,3.145379066467285,-129.14013671875,-1,0.00012000613787677139,0.00008899171371012926,0.00008900000830180943,0.00006900000880705193,1,0.00011999999696854502,1,-0.00006901068263687193),Material=272,Rotation=v3(-90.00399780273438,0.004999999888241291,-179.9929962158203),Size=v3(1.011212944984436,0.22350001335144043,0.2861981987953186)})
	new("FileMesh",i2285,{MeshId="rbxassetid://453276303"})
	i2287=new("Part",i2246,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(420.9879150390625,3.188347101211548,-129.4866943359375,-0.00019799999427050352,0.00014200000441633165,-1,-1,0.00005497188612935133,0.00019800780864898115,0.00005500000042957254,1,0.00014198911958374083),Material=272,Rotation=v3(89.99700164794922,-90,0),Size=v3(0.28959742188453674,0.7975850105285645,2.5056989192962646)})
	new("FileMesh",i2287,{MeshId="rbxassetid://455697158"})
	i2289=new("Part",i2246,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(420.2481689453125,3.1643009185791016,-129.3531494140625,-0.00019799999427050352,0.00014200000441633165,-1,-1,0.00005497188612935133,0.00019800780864898115,0.00005500000042957254,1,0.00014198911958374083),Material=272,Rotation=v3(89.99700164794922,-90,0),Size=v3(0.31658077239990234,0.6536479592323303,1.175929069519043)})
	new("IntValue",i2289,{Name="Slot1"})
	new("FileMesh",i2289,{MeshId="rbxassetid://455701078"})
	i2292=new("Part",i2246,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(420.7042236328125,3.1451361179351807,-129.7620849609375,-0.00019799999427050352,0.00014200000441633165,-1,-1,0.00005497188612935133,0.00019800780864898115,0.00005500000042957254,1,0.00014198911958374083),Material=272,Rotation=v3(89.99700164794922,-90,0),Size=v3(0.20000000298023224,0.5527589321136475,0.4568880796432495)})
	new("IntValue",i2292,{Name="Slot2"})
	new("FileMesh",i2292,{MeshId="rbxassetid://455696649"})
	i2295=new("Part",i2246,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(421.5167236328125,3.145256996154785,-129.4798583984375,-0.00019799999427050352,0.00014200000441633165,-1,-1,0.00005497188612935133,0.00019800780864898115,0.00005500000042957254,1,0.00014198911958374083),Material=272,Rotation=v3(89.99700164794922,-90,0),Size=v3(0.20000000298023224,0.7833147644996643,1.3627499341964722)})
	new("IntValue",i2295,{Name="Slot2"})
	new("FileMesh",i2295,{MeshId="rbxassetid://455702718"})
	i2298=new("Part",i2246,{Name="BoltBack",Anchored=t,BrickColor=bc(1003),CFrame=cf(420.751220703125,3.145379066467285,-129.14013671875,-1,0.00012000613787677139,0.00008899171371012926,0.00008900000830180943,0.00006900000880705193,1,0.00011999999696854502,1,-0.00006901068263687193),Material=272,Rotation=v3(-90.00399780273438,0.004999999888241291,-179.9929962158203),Size=v3(1.011212944984436,0.22350001335144043,0.2861981987953186),Transparency=1})
	new("FileMesh",i2298,{MeshId="rbxassetid://453276303"})
	new("Part",i2246,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(420.015869140625,3.1976261138916016,-129.2203369140625,-1,0.00014200559235177934,0.000056986071285791695,0.00005699999746866524,0.000097999996796716,1,0.00014200000441633165,1,-0.00009800808766158298),Rotation=v3(-90.00599670410156,0.003000000026077032,-179.99200439453125),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i2301=new("Part",i2246,{Name="Mag",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(419.942626953125,3.1447699069976807,-129.7353515625,-1,0.00014200559235177934,0.000056986071285791695,0.00005699999746866524,0.000097999996796716,1,0.00014200000441633165,1,-0.00009800808766158298),Material=272,Rotation=v3(-90.00599670410156,0.003000000026077032,-179.99200439453125),Size=v3(0.46000057458877563,1,0.07999998331069946),TopSurface=0})
	new("SpecialMesh",i2301,{Scale=v3(1.2000000476837158,1.2000000476837158,1.2000000476837158),MeshId="rbxassetid://2035809004",MeshType=5})
	i2303=new("Part",i2246,{Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(420.3436279296875,3.137078046798706,-128.8782958984375,-1,0.00014200559235177934,0.000056986071285791695,0.00005699999746866524,0.000097999996796716,1,0.00014200000441633165,1,-0.00009800808766158298),Rotation=v3(-90.00599670410156,0.003000000026077032,-179.99200439453125),Size=v3(0.9700002670288086,0.42999985814094543,0.2400001585483551),TopSurface=0})
	new("SpecialMesh",i2303,{MeshId="rbxassetid://2035852320",MeshType=5})
	i2305=new("Part",i2246,{Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(419.0928955078125,3.139885902404785,-129.6103515625,1,0.00014200559235177934,-0.000056986071285791695,-0.00005699999746866524,0.000097999996796716,-1,-0.00014200000441633165,1,0.00009800808766158298),Rotation=v3(89.99400329589844,-0.003000000026077032,-0.00800000037997961),Size=v3(0.18000000715255737,1,0.09000000357627869),TopSurface=0})
	new("SpecialMesh",i2305,{MeshId="rbxassetid://2035846922",MeshType=5})
	i2307=new("Part",i2246,{Name="Reticle",Anchored=t,BottomSurface=0,BrickColor=bc(1020),CFrame=cf(420.3446044921875,3.145256996154785,-128.820556640625,-1,0.00010000969632528722,0.0000999902913463302,0.00010000000474974513,0.00009700000373413786,1,0.00010000000474974513,1,-0.00009701000089989975),Material=288,Rotation=v3(-90.00599670410156,0.006000000052154064,-179.99400329589844),Size=v3(0.05000000074505806,0.05000000074505806,0.05000000074505806),TopSurface=0,FormFactor=3})
	new("SpecialMesh",i2307,{Scale=v3(0.30000001192092896,0.30000001192092896,0.30000001192092896),MeshType=4})
	i2309=new("Part",i2246,{Name="Reticle",Anchored=t,BottomSurface=0,BrickColor=bc(1020),CFrame=cf(420.4552001953125,3.145256996154785,-128.8355712890625,1,0.00012001039431197569,-0.000098987395176664,-0.00009899999713525176,0.0001049999991664663,-1,-0.00011999999696854502,1,0.00010501188080525026),Material=288,Rotation=v3(89.99400329589844,-0.006000000052154064,-0.007000000216066837),Size=v3(0.05000000074505806,0.17000000178813934,0.17999999225139618),TopSurface=0,Transparency=0.6000000238418579,FormFactor=3})
	new("SpecialMesh",i2309,{MeshType=4})
	i2311=new("Part",i2246,{Name="Reticle",Anchored=t,BottomSurface=0,BrickColor=bc(1020),CFrame=cf(420.3446044921875,3.145256996154785,-128.8817138671875,-1,0.00010000969632528722,0.0000999902913463302,0.00010000000474974513,0.00009700000373413786,1,0.00010000000474974513,1,-0.00009701000089989975),Material=288,Rotation=v3(-90.00599670410156,0.006000000052154064,-179.99400329589844),Size=v3(0.05000000074505806,0.05000000074505806,0.05000000074505806),TopSurface=0,FormFactor=3})
	new("SpecialMesh",i2311,{Scale=v3(0.30000001192092896,1.2000000476837158,0.10000000149011612),MeshType=6})
	i2313=new("Model",i1,{Name="MG42"})
	i2314=new("Folder",i2313,{Name="Settings"})
	new("IntValue",i2314,{Name="Recoil",Value=1})
	new("IntValue",i2314,{Name="StoredAmmo",Value=100})
	new("IntValue",i2314,{Name="Mag",Value=6})
	new("BoolValue",i2314,{Name="Auto",Value=t})
	new("NumberValue",i2314,{Name="FireRate",Value=0.06})
	new("IntValue",i2314,{Name="FireMode",Value=1})
	new("BoolValue",i2314,{Name="CanSelectFire",Value=t})
	new("IntValue",i2314,{Name="Ammo",Value=100})
	new("IntValue",i2314,{Name="AimZoom",Value=35})
	new("IntValue",i2314,{Name="Drop",Value=135})
	new("IntValue",i2314,{Name="CycleZoom",Value=50})
	new("StringValue",i2314,{Name="RifleOrPistol"})
	new("BoolValue",i2314,{Name="IsGun",Value=t})
	new("IntValue",i2314,{Name="ShotCount",Value=1})
	new("StringValue",i2314,{Name="Rarity",Value="mythical"})
	new("BoolValue",i2314,{Name="Dismember",Value=t})
	new("StringValue",i2314,{Name="AmmoType",Value="rifle"})
	i2332=new("Part",i2313,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(415.4832763671875,0.7230179905891418,-132.7078857421875,-5.497531674336642e-08,3.3352989703416824e-08,1,-6.638675387193871e-08,1,-3.3352989703416824e-08,-1,-6.607509561717961e-08,-5.489164323080331e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i2332,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i2332,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i2332,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i2332,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	new("Part",i2313,{Name="BoltBack",Anchored=t,BrickColor=bc(226),CFrame=cf(420.8787841796875,0.6892049908638,-132.71484375,0.00011897212971234694,-1,-2.381057129241526e-09,-1,-0.00011897212971234694,0.00004315844489610754,-0.00004315875776228495,-2.839460444548081e-09,-1),Material=272,Rotation=v3(-179.9980010986328,0,89.99299621582031),Size=v3(0.05000000074505806,0.05249999836087227,0.05000000074505806),Transparency=1,FormFactor=3})
	new("Part",i2313,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(419.8214111328125,0.7703819870948792,-132.76708984375,-0.9991779923439026,3.1403766552733645e-21,0.040539998561143875,-2.0637993050631742e-11,1,-1.5818729659500264e-10,-0.040540002286434174,1.5694912036678943e-10,-0.9991779923439026),Rotation=v3(180,2.322999954223633,180),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i2339=new("Part",i2313,{Name="Mag1",Anchored=t,BackSurface=10,BottomSurface=10,BrickColor=bc(333),CFrame=cf(419.741455078125,0.5880079865455627,-132.44287109375,-4.18367562815547e-11,3.1403766552733645e-21,1,-1.5694912036678943e-10,1,3.1403766552733645e-21,-1,1.5694912036678943e-10,4.18367562815547e-11),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(0,90,0),Size=v3(0.30000007152557373,0.440000057220459,4.500000953674316),TopSurface=10})
	new("SpecialMesh",i2339,{Scale=v3(1,1,1.399999976158142),MeshId="rbxassetid://2074826156",MeshType=5})
	i2341=new("Part",i2313,{Name="Handle",Anchored=t,BackSurface=10,BottomSurface=10,CFrame=cf(420.193603515625,0.10229100286960602,-132.713134765625,0.00011940234253415838,0.014834274537861347,0.9998900294303894,0.008044996298849583,0.9998576641082764,-0.014834755100309849,-0.999967634677887,0.008045881986618042,4.374810202989465e-08),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(90,89.1500015258789,-89.53900146484375),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=10,Transparency=1})
	new("Sound",i2341,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i2341,{Name="Fire",Pitch=1.2000000476837158,PlaybackSpeed=1.2000000476837158,SoundId="rbxassetid://2058020514",Volume=3})
	new("Sound",i2341,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i2341,{Name="MagIn",Pitch=0.800000011920929,PlaybackSpeed=0.800000011920929,SoundId="rbxassetid://896337875",Volume=1})
	new("Sound",i2341,{Name="MagOut",Pitch=0.699999988079071,PlaybackSpeed=0.699999988079071,SoundId="rbxassetid://896337931",Volume=1})
	i2347=new("Part",i2313,{Name="Part 8",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(422.0032958984375,0.5925260186195374,-132.7081298828125,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2347,{MeshId="rbxassetid://1563848810"})
	new("IntValue",i2347,{Name="Slot1"})
	new("Part",i2313,{Name="Bolt",Anchored=t,BrickColor=bc(226),CFrame=cf(420.4078369140625,0.6892049908638,-132.71484375,0.00011897212971234694,-1,-2.381057129241526e-09,-1,-0.00011897212971234694,0.00004315844489610754,-0.00004315875776228495,-2.839460444548081e-09,-1),Material=272,Rotation=v3(-179.9980010986328,0,89.99299621582031),Size=v3(0.05000000074505806,0.05249999836087227,0.05000000074505806),FormFactor=3})
	i2351=new("Part",i2313,{Name="Part 1",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(417.733154296875,0.7054399847984314,-132.708984375,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2351,{MeshId="rbxassetid://1563828590"})
	new("IntValue",i2351,{Name="Slot1"})
	i2354=new("Part",i2313,{Name="Mag",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(419.7537841796875,0.32677799463272095,-132.3515625,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2354,{MeshId="rbxassetid://1563774942"})
	new("IntValue",i2354,{Name="Slot2"})
	new("Part",i2313,{Name="Trigger",Anchored=t,BottomSurface=0,BrickColor=bc(1031),CFrame=cf(420.2108154296875,0.3404510021209717,-132.70947265625,0.000029999959224369377,0.00009899999713525176,1.0000001192092896,0.00009899984434014186,1.0000001192092896,-0.00009900296572595835,-1,0.00009900312579702586,0.00002999024036398623),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i2358=new("Part",i2313,{Name="Part 15",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(420.8033752441406,0.6772419810295105,-132.7083740234375,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2358,{MeshId="rbxassetid://1563867077"})
	new("IntValue",i2358,{Name="Slot1"})
	i2361=new("Part",i2313,{Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(420.73583984375,0.6646689772605896,-132.7108154296875,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2361,{Scale=v3(0.04800000041723251,0.04800000041723251,0.04800000041723251),MeshId="rbxassetid://1464258680"})
	i2363=new("Part",i2313,{Name="AimPart",Anchored=t,BackSurface=10,BottomSurface=10,CFrame=cf(420.5972900390625,1.0865440368652344,-132.708740234375,-4.375140605361594e-08,2.8673004243800285e-21,1,-1.5012524556823337e-10,1,-6.55931561005767e-18,-1,1.5012524556823337e-10,-4.367137051985992e-08),FrontSurface=10,LeftSurface=10,Material=272,RightSurface=10,Rotation=v3(0,90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=10,Transparency=1})
	new("BlockMesh",i2363,{Scale=v3(0.02936507947742939,0.03523809462785721,0.05873015895485878)})
	i2365=new("Part",i2313,{Name="Iron",Anchored=t,BottomSurface=0,BrickColor=bc(302),CFrame=cf(418.900146484375,0.964352011680603,-132.708740234375,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2365,{MeshId="rbxassetid://1563695538"})
	i2367=new("Part",i2313,{Name="Part 25",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(419.41162109375,0.7224079966545105,-132.708740234375,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2367,{MeshId="rbxassetid://1563916310"})
	new("IntValue",i2367,{Name="Slot1"})
	i2370=new("Part",i2313,{Name="Part 2 3",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(420.4766845703125,0.18664200603961945,-132.70849609375,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2370,{MeshId="rbxassetid://1563938634"})
	new("IntValue",i2370,{Name="Slot2"})
	i2373=new("Part",i2313,{Name="Part 26",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(417.38134765625,0.6849319934844971,-132.7139892578125,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2373,{MeshId="rbxassetid://1563917063"})
	new("IntValue",i2373,{Name="Slot1"})
	i2376=new("Part",i2313,{Name="Part 24",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(419.3321533203125,0.8104209899902344,-132.708740234375,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2376,{MeshId="rbxassetid://1563910950"})
	new("IntValue",i2376,{Name="Slot1"})
	i2379=new("Part",i2313,{Name="Iron",Anchored=t,BottomSurface=0,BrickColor=bc(302),CFrame=cf(416.5220947265625,0.9542199969291687,-132.709228515625,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2379,{Scale=v3(0.04800000041723251,0.04800000041723251,0.04800000041723251),MeshId="rbxassetid://1464419042"})
	i2381=new("Part",i2313,{Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(417.746337890625,0.7054399847984314,-132.708984375,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2381,{Scale=v3(0.04800000041723251,0.04800000041723251,0.04800000041723251),MeshId="rbxassetid://1464404780"})
	i2383=new("Part",i2313,{Name="Part 3",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(419.1932373046875,0.7055609822273254,-132.894287109375,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2383,{MeshId="rbxassetid://1563830532"})
	new("IntValue",i2383,{Name="Slot1"})
	i2386=new("Part",i2313,{Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(421.8843688964844,0.6419640183448792,-132.7081298828125,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2386,{Scale=v3(0.04800000041723251,0.04800000041723251,0.04800000041723251),MeshId="rbxassetid://1464153110"})
	i2388=new("Part",i2313,{Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(422.2877197265625,0.8817099928855896,-132.7078857421875,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2388,{Scale=v3(0.04800000041723251,0.04800000041723251,0.04800000041723251),MeshId="rbxassetid://1464158041"})
	i2390=new("Part",i2313,{Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(420.6871337890625,0.27477699518203735,-132.7083740234375,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2390,{Scale=v3(0.04800000041723251,0.04800000041723251,0.04800000041723251),MeshId="rbxassetid://1464234906"})
	i2392=new("Part",i2313,{Name="Part 2 1",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(417.429443359375,0.7054399847984314,-132.7091064453125,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2392,{MeshId="rbxassetid://1563937376"})
	new("IntValue",i2392,{Name="Slot2"})
	i2395=new("Part",i2313,{Name="Part 14",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(416.272705078125,0.8343459963798523,-132.709228515625,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2395,{MeshId="rbxassetid://1563866485"})
	new("IntValue",i2395,{Name="Slot1"})
	i2398=new("Part",i2313,{Name="Part 22",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(419.0357666015625,0.7055609822273254,-132.869873046875,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2398,{MeshId="rbxassetid://1563909267"})
	new("IntValue",i2398,{Name="Slot1"})
	i2401=new("Part",i2313,{Name="Part 16",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(417.737060546875,0.832027018070221,-132.7054443359375,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2401,{MeshId="rbxassetid://1563888894"})
	new("IntValue",i2401,{Name="Slot1"})
	i2404=new("Part",i2313,{Name="Part 7",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(418.51513671875,0.4776560068130493,-132.56787109375,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2404,{MeshId="rbxassetid://1563848176"})
	new("IntValue",i2404,{Name="Slot1"})
	i2407=new("Part",i2313,{Name="Lid",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(420.419921875,0.8199430108070374,-132.6868896484375,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2407,{MeshId="rbxassetid://1563773005"})
	new("IntValue",i2407,{Name="Slot1"})
	i2410=new("Part",i2313,{Name="Part 5",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(420.4637451171875,0.6790720224380493,-132.7095947265625,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2410,{MeshId="rbxassetid://1563832444"})
	new("IntValue",i2410,{Name="Slot1"})
	i2413=new("Part",i2313,{Name="Part 6",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(419.7598571777344,0.6555129885673523,-132.6683349609375,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2413,{MeshId="rbxassetid://1563833166"})
	new("IntValue",i2413,{Name="Slot1"})
	i2416=new("Part",i2313,{Name="Part 21",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(421.9945068359375,0.8558319807052612,-132.7080078125,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2416,{MeshId="rbxassetid://1563908410"})
	new("IntValue",i2416,{Name="Slot1"})
	i2419=new("Part",i2313,{Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(420.2208251953125,0.6135209798812866,-132.8323974609375,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2419,{MeshId="rbxassetid://1563894533"})
	new("IntValue",i2419,{Name="Slot1"})
	i2422=new("Part",i2313,{Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(419.2730407714844,0.7055609822273254,-132.5926513671875,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2422,{Scale=v3(0.04800000041723251,0.04800000041723251,0.04800000041723251),MeshId="rbxassetid://1464334580"})
	i2424=new("Part",i2313,{Name="Part 12",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(422.123779296875,0.523311972618103,-132.7080078125,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2424,{MeshId="rbxassetid://1563865003"})
	new("IntValue",i2424,{Name="Slot1"})
	i2427=new("Part",i2313,{Name="Part 2",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(420.4478759765625,0.20580600202083588,-132.70849609375,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2427,{MeshId="rbxassetid://1563829628"})
	new("IntValue",i2427,{Name="Slot1"})
	i2430=new("Part",i2313,{Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(420.682861328125,0.6585649847984314,-132.7108154296875,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2430,{Scale=v3(0.04800000041723251,0.04800000041723251,0.04800000041723251),MeshId="rbxassetid://1464262216"})
	i2432=new("Part",i2313,{Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(422.37158203125,0.5925260186195374,-132.7078857421875,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2432,{Scale=v3(0.04800000041723251,0.04800000041723251,0.04800000041723251),MeshId="rbxassetid://1464131756"})
	i2434=new("Part",i2313,{Name="Part 19",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(421.388427734375,0.7471870183944702,-132.70947265625,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2434,{MeshId="rbxassetid://1563893590"})
	new("IntValue",i2434,{Name="Slot1"})
	i2437=new("Part",i2313,{Name="Part 23",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(420.9263916015625,0.6152290105819702,-132.8052978515625,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2437,{MeshId="rbxassetid://1563910198"})
	new("IntValue",i2437,{Name="Slot1"})
	i2440=new("Part",i2313,{Name="Part 10",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(419.1168212890625,0.7055609822273254,-132.7978515625,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2440,{MeshId="rbxassetid://1563851469"})
	new("IntValue",i2440,{Name="Slot1"})
	i2443=new("Part",i2313,{Name="Part 17",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(418.9241943359375,0.6198689937591553,-132.61474609375,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2443,{MeshId="rbxassetid://1563891791"})
	new("IntValue",i2443,{Name="Slot1"})
	i2446=new("Part",i2313,{Name="Part 13",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(418.9754638671875,0.7053179740905762,-132.80810546875,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2446,{MeshId="rbxassetid://1563865809"})
	new("IntValue",i2446,{Name="Slot1"})
	i2449=new("Part",i2313,{Name="Part 9",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(421.8155517578125,0.8019980192184448,-132.7080078125,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2449,{MeshId="rbxassetid://1563849461"})
	new("IntValue",i2449,{Name="Slot1"})
	i2452=new("Part",i2313,{Name="Lid1",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(419.73095703125,0.8336129784584045,-132.669189453125,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2452,{Scale=v3(0.04800000041723251,0.04800000041723251,0.04800000041723251),MeshId="rbxassetid://1464473972"})
	i2454=new("Part",i2313,{Name="Part 2 2",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(421.9791259765625,0.6997029781341553,-132.7081298828125,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2454,{MeshId="rbxassetid://1563938042"})
	new("IntValue",i2454,{Name="Slot2"})
	i2457=new("Part",i2313,{Name="Flame",Anchored=t,BottomSurface=0,BrickColor=bc(1031),CFrame=cf(415.5299072265625,0.7060499787330627,-132.70947265625,0.000029999959224369377,0.00009899999713525176,1.0000001192092896,0.00009899984434014186,1.0000001192092896,-0.00009900296572595835,-1,0.00009900312579702586,0.00002999024036398623),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i2457,{Name="Fire"})
	i2459=new("Part",i2313,{Name="Part 18",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(418.8507080078125,0.6422079801559448,-132.685791015625,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2459,{MeshId="rbxassetid://1563892658"})
	new("IntValue",i2459,{Name="Slot1"})
	i2462=new("Part",i2313,{Name="Part 4",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(420.9744873046875,0.5333210229873657,-132.7083740234375,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2462,{MeshId="rbxassetid://1563831589"})
	new("IntValue",i2462,{Name="Slot1"})
	i2465=new("Part",i2313,{Name="Lid2",Anchored=t,BottomSurface=0,BrickColor=bc(26),CFrame=cf(420.51953125,0.7895470261573792,-132.7127685546875,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2465,{Scale=v3(0.04800000041723251,0.04800000041723251,0.04800000041723251),MeshId="rbxassetid://1464471497"})
	i2467=new("Part",i2313,{Name="Part 11",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(418.8946533203125,0.847652018070221,-132.708740234375,-0.000029999959224369377,-0.00020599999697878957,-1,-0.00009899984434014186,1,-0.00020599702838808298,1,0.00009899397264234722,-0.00003002043376909569),CanCollide=t,Material=272,Rotation=v3(0.006000000052154064,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0})
	new("FileMesh",i2467,{MeshId="rbxassetid://1563863413"})
	new("IntValue",i2467,{Name="Slot1"})
	i2470=new("Model",i1,{Name="L85A2"})
	i2471=new("Folder",i2470,{Name="Settings"})
	new("IntValue",i2471,{Name="Recoil",Value=1})
	new("IntValue",i2471,{Name="StoredAmmo",Value=30})
	new("IntValue",i2471,{Name="Mag",Value=6})
	new("BoolValue",i2471,{Name="Auto",Value=t})
	new("NumberValue",i2471,{Name="FireRate",Value=0.060000000000000005})
	new("IntValue",i2471,{Name="FireMode",Value=1})
	new("BoolValue",i2471,{Name="CanSelectFire",Value=t})
	new("IntValue",i2471,{Name="Ammo",Value=31})
	new("IntValue",i2471,{Name="AimZoom",Value=35})
	new("IntValue",i2471,{Name="Drop",Value=135})
	new("IntValue",i2471,{Name="CycleZoom",Value=50})
	new("StringValue",i2471,{Name="RifleOrPistol"})
	new("BoolValue",i2471,{Name="IsGun",Value=t})
	new("IntValue",i2471,{Name="ShotCount",Value=1})
	new("StringValue",i2471,{Name="Rarity",Value="rare"})
	new("BoolValue",i2471,{Name="Dismember"})
	new("StringValue",i2471,{Name="AmmoType",Value="rifle"})
	i2489=new("Part",i2470,{Name="Handle",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(1177.414306640625,-20.276615142822266,-518.185546875,6.184563972055912e-09,-6.315776346355051e-08,-1,-1.995213096961379e-07,1,-6.315875822338057e-08,1,1.995213096961379e-07,6.186382961459458e-09),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Sound",i2489,{Name="Click",SoundId="http://www.roblox.com/asset/?id=265275510",Volume=1})
	new("Sound",i2489,{Name="M3",SoundId="http://www.roblox.com/asset/?id=166238161"})
	new("Sound",i2489,{Name="MagIn",SoundId="http://roblox.com/asset/?id=166238223",Volume=0.20000000298023224})
	new("Sound",i2489,{Name="MagOut",SoundId="http://roblox.com/asset/?id=166238177",Volume=0.20000000298023224})
	new("Sound",i2489,{Name="Fire",SoundId="rbxassetid://494641952",Volume=4})
	i2495=new("Part",i2470,{Name="FirePart",Anchored=t,BottomSurface=0,BrickColor=bc(1004),CFrame=cf(1180.5589599609375,-19.633548736572266,-518.171142578125,5.4933479987084866e-08,-3.335501119750006e-08,-1,-6.622576620429754e-08,1,-3.335495080136752e-08,1,6.622940418310463e-08,5.493529897648841e-08),Material=272,Reflectance=0.30000001192092896,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("ParticleEmitter",i2495,{Name="1FlashFX2",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(100,100),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.625, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("ParticleEmitter",i2495,{Name="FlashFX[Flash]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(1.000, 1.000, 0.498)), ColorSequenceKeypoint.new(1.000, Color3.new(1.000, 1.000, 0.498))}),EmissionDirection=5,Enabled=f,Lifetime=NumberRange.new(0.05000000074505806,0.07500000298023224),LightEmission=1,Rate=1000,Rotation=NumberRange.new(0,90),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.15000000596046448), NumberSequenceKeypoint.new(1, 0, 0)}),Speed=NumberRange.new(50,50),Texture="http://www.roblox.com/asset/?id=257430870",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1, 0)})})
	new("PointLight",i2495,{Name="MuzzleLight",Brightness=6,Color=c3(1,0.9568628072738647,0.7411764860153198),Enabled=f})
	new("ParticleEmitter",i2495,{Name="FlashFX[Smoke]",Color=ColorSequence.new({ColorSequenceKeypoint.new(0.000, Color3.new(0.275, 0.275, 0.275)), ColorSequenceKeypoint.new(1.000, Color3.new(0.275, 0.275, 0.275))}),Enabled=f,Lifetime=NumberRange.new(1.25,1.5),LightEmission=0.10000000149011612,Rate=100,RotSpeed=NumberRange.new(10,10),Rotation=NumberRange.new(0,360),Size=NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 3, 0)}),Speed=NumberRange.new(5,7),Texture="http://www.roblox.com/asset/?id=244514423",Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6000000238418579, 0), NumberSequenceKeypoint.new(1, 1, 0)}),VelocitySpread=15})
	new("Part",i2470,{Name="Bullet",Anchored=t,BottomSurface=0,BrickColor=bc(1003),CFrame=cf(1177.173828125,-19.73328399658203,-518.111572265625,1,0,0,0,1,0,0,0,1),Size=v3(0.1300000101327896,0.40000006556510925,0.1900007277727127),TopSurface=0,Transparency=1})
	i2501=new("Part",i2470,{Name="Iron",Anchored=t,BrickColor=bc(26),CFrame=cf(1178.3851318359375,-19.3184814453125,-518.169189453125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(2.061351776123047,0.40181005001068115,0.20000000298023224)})
	new("IntValue",i2501,{Name="Slot2"})
	new("FileMesh",i2501,{MeshId="rbxassetid://478508334"})
	i2504=new("Part",i2470,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(1178.9620361328125,-19.570438385009766,-518.17431640625,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(2.9595985412597656,0.25297999382019043,0.20000000298023224)})
	new("IntValue",i2504,{Name="Slot2"})
	new("FileMesh",i2504,{MeshId="rbxassetid://478508060"})
	i2507=new("Part",i2470,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(1177.494140625,-19.8013973236084,-518.17919921875,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(2.2709999084472656,0.6617819666862488,0.20000000298023224)})
	new("IntValue",i2507,{Name="Slot2"})
	new("FileMesh",i2507,{MeshId="rbxassetid://478447349"})
	i2510=new("Part",i2470,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(1177.3111572265625,-20.0714168548584,-518.15625,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(2.1110992431640625,1.1712950468063354,0.2360076904296875)})
	new("IntValue",i2510,{Name="Slot1"})
	new("FileMesh",i2510,{MeshId="rbxassetid://478508251"})
	i2513=new("Part",i2470,{Name="Mag",Anchored=t,BrickColor=bc(26),CFrame=cf(1177.2562255859375,-20.362430572509766,-518.173095703125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(0.47550201416015625,1.0352600812911987,0.20000000298023224)})
	new("IntValue",i2513,{Name="Slot1"})
	new("FileMesh",i2513,{MeshId="rbxassetid://476657191"})
	i2516=new("Part",i2470,{Name="MeshPart",Anchored=t,BrickColor=bc(26),CFrame=cf(1177.5350341796875,-19.802371978759766,-518.158203125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(2.3540992736816406,0.6744660139083862,0.2649993896484375)})
	new("IntValue",i2516,{Name="Slot2"})
	new("FileMesh",i2516,{MeshId="rbxassetid://478511238"})
	i2519=new("Part",i2470,{Name="MeshPart",Anchored=t,BrickColor=bc(1003),CFrame=cf(1179.1280517578125,-19.668460845947266,-518.17626953125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(1.3159027099609375,0.4249000549316406,0.26800537109375)})
	new("IntValue",i2519,{Name="Slot1"})
	new("FileMesh",i2519,{MeshId="rbxassetid://478508165"})
	i2522=new("Part",i2470,{Name="Bolt",Anchored=t,CFrame=cf(1177.2271728515625,-19.564945220947266,-518.118408203125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(0.4798011779785156,0.20000000298023224,0.20000000298023224)})
	new("FileMesh",i2522,{MeshId="rbxassetid://478507048"})
	new("Part",i2470,{Name="AimPart",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(1176.8099365234375,-19.167972564697266,-518.168701171875,-4.371138828673793e-08,0,-1,0,1,0,1,0,-4.371138828673793e-08),CanCollide=t,Material=272,Rotation=v3(0,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	new("Part",i2470,{Name="Trigger",Anchored=t,BottomSurface=0,BrickColor=bc(1009),CFrame=cf(1178.48583984375,-19.9476318359375,-518.1689453125,0.0003986227384302765,-0.0004748616192955524,-0.9999998807907104,0.0005179943982511759,0.9999997615814209,-0.00047465518582612276,0.9999997615814209,-0.0005178051069378853,0.0003988686657976359),CanCollide=t,Material=272,Rotation=v3(-0.029999999329447746,-90,0),Size=v3(0.20000000298023224,0.20000000298023224,0.20000000298023224),TopSurface=0,Transparency=1,FormFactor=3})
	i2526=new("Part",i2470,{Name="BoltBack",Anchored=t,CFrame=cf(1176.8363037109375,-19.564945220947266,-518.118408203125,1,0.00003051804378628731,-0.000030517112463712692,-0.000030517112463712692,1,0.00003051804378628731,0.00003051804378628731,-0.000030517112463712692,1),Rotation=v3(-0.0020000000949949026,-0.0020000000949949026,-0.0020000000949949026),Size=v3(0.4798011779785156,0.20000000298023224,0.20000000298023224),Transparency=1})
	new("FileMesh",i2526,{MeshId="rbxassetid://478507048"})

	-- LM->S converter - converted 2522 objects.
end

------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------

-- Server shit
items = _ITEMS_FOLDER_
items.Parent = game
map = Instance.new("Model")
---how im updating from now on rococks studio is so gay smh
AmmoGui = Instance.new("ScreenGui")
o2 = Instance.new("Frame")
o3 = Instance.new("TextLabel")
o4 = Instance.new("TextLabel")
AmmoGui.Name = "AmmoGui"
AmmoGui.Enabled = false
o2.Parent = AmmoGui
o2.Size = UDim2.new(0.14601421356201,0,0.044642858207226,0)
o2.BackgroundColor3 = Color3.new(0.133333, 0.133333, 0.133333)
o2.BackgroundTransparency = 0.40000000596046
o2.BorderColor3 = Color3.new(0.054902, 0.0901961, 0.113725)
o2.BorderSizePixel = 3
o2.Position = UDim2.new(0.849, 0,0.01, 0)
o3.Name = "AmmoText"
o3.Parent = o2
o3.Size = UDim2.new(0.20499999821186,0,0.89999997615814,0)
o3.Text = "30"
o3.BackgroundColor3 = Color3.new(1, 1, 1)
o3.BackgroundTransparency = 1
o3.Font = Enum.Font.SourceSansBold
o3.FontSize = Enum.FontSize.Size14
o3.TextColor3 = Color3.new(1, 1, 1)
o3.TextScaled = true
o3.TextWrapped = true
o3.Position = UDim2.new(0.566, 0,0, 0)
o4.Name = "FireModeText"
o4.Parent = o2
o4.Size = UDim2.new(0.48500001430511,0,0.89999997615814,0)
o4.Text = "[ AUTO ]"
o4.BackgroundColor3 = Color3.new(1, 1, 1)
o4.BackgroundTransparency = 1
o4.Font = Enum.Font.SourceSansBold
o4.FontSize = Enum.FontSize.Size14
o4.TextColor3 = Color3.new(1, 1, 1)
o4.TextScaled = true
o4.TextWrapped = true
o4.Position = UDim2.new(0.01, 0,0, 0)
o1 = Instance.new("ScreenGui")
Frame = Instance.new("Frame")
o3 = Instance.new("TextButton")
o4 = Instance.new("TextBox")
o5 = Instance.new("TextButton")
o6 = Instance.new("ScrollingFrame")
o7 = Instance.new("TextButton")
o1.Name = "Inventory"
for i,v in ipairs( gethui():GetChildren()) do
	if v.Name == "Inventory" then
		v:Destroy()
	end
end
o1.Parent = gethui()
Frame.Name = "Inventory"
Frame.Parent = o1
Frame.Size = UDim2.new(0,775,0,400)
Frame.Visible = false
Frame.BackgroundColor3 = Color3.new(0.298039, 0.298039, 0.298039)
Frame.Position = UDim2.new(0.499, -387,0.5, -200)
o3.Name = "Slot1"
o3.Parent = Frame
o3.Size = UDim2.new(0,50,0,50)
o3.Text = "Empty"
o3.BackgroundColor3 = Color3.new(0.211765, 0.211765, 0.211765)
o3.Font = Enum.Font.SourceSansBold
o3.FontSize = Enum.FontSize.Size14
o3.TextColor3 = Color3.new(0, 0, 0)
o3.TextScaled = true
o3.TextStrokeColor3 = Color3.new(1, 1, 1)
o3.TextWrapped = true
o3.Position = UDim2.new(0, 25,0, 25)
o4.Name = "Item"
o4.Parent = o1
o4.Size = UDim2.new(0,150,0,30)
o4.Text = ""
o4.BackgroundColor3 = Color3.new(0, 0, 0)
o4.Font = Enum.Font.SourceSansBold
o4.FontSize = Enum.FontSize.Size14
o4.TextColor3 = Color3.new(1, 1, 1)
o4.TextScaled = true
o4.TextWrapped = true
o4.Position = UDim2.new(0, 0,1, -30)
o5.Name = "SWITCH"
o5.Size = UDim2.new(0,50,0,50)
o5.BackgroundColor3 = Color3.new(0.211765, 0.211765, 0.211765)
o5.Font = Enum.Font.SourceSansBold
o5.FontSize = Enum.FontSize.Size14
o5.TextColor3 = Color3.new(1, 1, 1)
o5.TextScaled = true
o5.TextWrapped = true
o5.Position = UDim2.new(1, -50,1, -50)
backpackswitch = o5:Clone()
backpackswitch.Parent = o1
backpackswitch.Text = "Switch Backpacks"
backpackswitch.MouseButton1Down:Connect(function ()

	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, not backpackon)
	backpackon = not backpackon
	player.Character.Humanoid:UnequipTools()
end)
ghillie = false --i hid it here so u dont change it
o6.Name = "ItemSpawn"
o6.Parent = o1
o6.Size = UDim2.new(0,100,0,100)
o6.BackgroundColor3 = Color3.new(0.298039, 0.298039, 0.298039)
o6.Position = UDim2.new(0, 0,0.5, -50)
o7.Name = "Item1"
o7.Parent = o6
o7.Size = UDim2.new(0,88,0,30)
o7.Text = ""
o7.BackgroundColor3 = Color3.new(0, 0, 0)
o7.Font = Enum.Font.SourceSansBold
o7.FontSize = Enum.FontSize.Size14
o7.TextColor3 = Color3.new(1, 1, 1)
o7.TextScaled = true
o7.TextWrapped = true
rround = Instance.new("TextButton")
pround = Instance.new("TextButton")
sround = Instance.new("TextButton")
rround.Name = "AB2"
rround.Parent = Frame.Parent
rround.Position = UDim2.new(0,0,0.60326892137527,0)
rround.Size = UDim2.new(0,100,0,19)
rround.Text = "Add Rifle Rounds (100)"
rround.Position = UDim2.new(0,0,0.60326892137527,0)
rround.Position = UDim2.new(0,0,0.60326892137527,0)
rround.BackgroundColor3 = Color3.new(0, 0, 0)
rround.Font = Enum.Font.SourceSansBold
rround.FontSize = Enum.FontSize.Size14
rround.TextColor3 = Color3.new(1, 1, 1)
rround.TextScaled = true
rround.TextWrapped = true
pround.Name = "AB1"
pround.Parent = Frame.Parent
pround.Position = UDim2.new(0,0,0.57503712177277,0)
pround.Size = UDim2.new(0,100,0,19)
pround.Text = "Add Pistol Rounds (100)"
pround.Position = UDim2.new(0,0,0.57503712177277,0)
pround.Position = UDim2.new(0,0,0.57503712177277,0)
pround.BackgroundColor3 = Color3.new(0, 0, 0)
pround.Font = Enum.Font.SourceSansBold
pround.FontSize = Enum.FontSize.Size14
pround.TextColor3 = Color3.new(1, 1, 1)
pround.TextScaled = true
pround.TextWrapped = true
sround.Name = "AB3"
sround.Parent = Frame.Parent
sround.Position = UDim2.new(0,0,0.63447248935699,0)
sround.Size = UDim2.new(0,100,0,19)
sround.Text = "Add Shotgun Shells (100)"
sround.Position = UDim2.new(0,0,0.63447248935699,0)
sround.Position = UDim2.new(0,0,0.63447248935699,0)
sround.BackgroundColor3 = Color3.new(0, 0, 0)
sround.Font = Enum.Font.SourceSansBold
sround.FontSize = Enum.FontSize.Size14
sround.TextColor3 = Color3.new(1, 1, 1)
sround.TextScaled = true
sround.TextWrapped = true
sroundds = Instance.new("TextButton")
rroundds = Instance.new("TextButton")
proundds = Instance.new("TextButton")
sroundds.Name = "AB3"
sroundds.Parent = Frame
sroundds.Position = UDim2.new(0,725,0,0)
sroundds.Size = UDim2.new(0,50,0,15)
sroundds.Text = "0"
sroundds.Position = UDim2.new(0,725,0,0)
sroundds.Position = UDim2.new(0,725,0,0)
sroundds.BackgroundColor3 = Color3.new(0.211765, 0.211765, 0.211765)
sroundds.Font = Enum.Font.SourceSansBold
sroundds.FontSize = Enum.FontSize.Size14
sroundds.TextColor3 = Color3.new(1, 1, 1)
sroundds.TextScaled = true
sroundds.TextStrokeColor3 = Color3.new(1, 1, 1)
sroundds.TextWrapped = true
rroundds.Name = "AB2"
rroundds.Parent = Frame
rroundds.Position = UDim2.new(0,675,0,0)
rroundds.Size = UDim2.new(0,50,0,15)
rroundds.Text = "0"
rroundds.Position = UDim2.new(0,675,0,0)
rroundds.Position = UDim2.new(0,675,0,0)
rroundds.BackgroundColor3 = Color3.new(0.211765, 0.211765, 0.211765)
rroundds.Font = Enum.Font.SourceSansBold
rroundds.FontSize = Enum.FontSize.Size14
rroundds.TextColor3 = Color3.new(1, 1, 1)
rroundds.TextScaled = true
rroundds.TextStrokeColor3 = Color3.new(1, 1, 1)
rroundds.TextWrapped = true
proundds.Name = "AB1"
proundds.Parent = Frame
proundds.Position = UDim2.new(0,625,0,0)
proundds.Size = UDim2.new(0,50,0,15)
proundds.Text = "0"
proundds.Position = UDim2.new(0,625,0,0)
proundds.Position = UDim2.new(0,625,0,0)
proundds.BackgroundColor3 = Color3.new(0.211765, 0.211765, 0.211765)
proundds.Font = Enum.Font.SourceSansBold
proundds.FontSize = Enum.FontSize.Size14
proundds.TextColor3 = Color3.new(1, 1, 1)
proundds.TextScaled = true
proundds.TextStrokeColor3 = Color3.new(1, 1, 1)
proundds.TextWrapped = true
PistolRounds = 0
RifleRounds = 0
ShotgunRounds = 0
function AddPistolRounds (num) PistolRounds=PistolRounds+num proundds.Text = PistolRounds end
function AddRifleRounds (num) RifleRounds=RifleRounds+num rroundds.Text = RifleRounds end
function AddShotgunRounds (num) ShotgunRounds=ShotgunRounds+num sroundds.Text = ShotgunRounds end
pround.MouseButton1Down:connect(function () AddPistolRounds(100) end)
rround.MouseButton1Down:connect(function () AddRifleRounds(100) end)
sround.MouseButton1Down:connect(function () AddShotgunRounds(100) end)
Frame.Slot1.Text = ""	
function meleeequip ()
	anim1 = Instance.new("Animation")
	anim2 = Instance.new("Animation")
	anim3 = Instance.new("Animation")
	anim1.Name = "Chop"
	anim1.Parent = wepin
	if wepin.Settings.IsKnife.Value == false then
		anim1.AnimationId = "rbxassetid://32659699"
	else
		anim1.AnimationId = "rbxassetid://30704030"
	end
	anim2.Name = "Slice"
	anim2.Parent = wepin
	anim2.AnimationId = "rbxassetid://28090109"
	if wepin.Settings.IsKnife.Value == true then
		anim2.AnimationId = "rbxassetid://30704030"
	end
	anim3.Name = "Whack"
	anim3.Parent = wepin
	anim3.AnimationId = "http://www.roblox.com/Asset?ID=94161088"
	sound1 = Instance.new("Sound")
	sound2 = Instance.new("Sound")
	sound1.Name = "Hit"
	sound1.Parent = wepin.Handle
	sound1.SoundId = "rbxassetid://214755079"
	sound1.Volume = 1
	sound2.Name = "SlashSound"
	sound2.Parent = wepin.Handle
	sound2.SoundId = "rbxassetid://101164100"
	sound2.Volume = 1
	InsertService = game:GetService("InsertService")



	ReloadTime = .4
	local enabled3d = true
	function Blow(Hit)
		pcall(function () Hit.Parent.Humanoid.Health =  Hit.Parent.Humanoid.Health-wepin.Settings.Damage.Value end)
		if wepin.Settings.Dismember.Value then
			if Hit.Name == "Head" then
				Hit.Anchored= false Hit.Size = Vector3.new(2, 0.2, 1)
				Hit.BrickColor = BrickColor.new("Maroon")
				o1 = Instance.new("Sound")
				o1.Parent = Hit
				o1.SoundId = "rbxassetid://429400881"
				o1:Play()
			end
			if Hit.Name == "Right Arm" then
				o11.Name = "GOREPART"
				o11.Parent = workspace
				o11.BrickColor = BrickColor.new("Maroon")
				o11.Position = Hit.Position
				o11.Rotation = Vector3.new(-180, 1.29089606, 180)
				o11.FormFactor = Enum.FormFactor.Symmetric
				o11.Size = Vector3.new(1, 2, 1)
				o11.BackSurface = Enum.SurfaceType.SmoothNoOutlines
				o11.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
				o11.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
				o11.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
				o11.RightSurface = Enum.SurfaceType.SmoothNoOutlines
				o11.TopSurface = Enum.SurfaceType.SmoothNoOutlines
				o11.Color = Color3.new(0.458824, 0, 0)
				Hit:Destroy()
				o1 = Instance.new("Sound")
				o1.Parent = o11
				o1.SoundId = "rbxassetid://429400881"
				o1:Play()
			end
			if Hit.Name == "Left Arm" then
				o11 = Instance.new("Part")
				o11.Name = "GOREPART"
				o11.Parent = workspace
				o11.BrickColor = BrickColor.new("Maroon")
				o11.Position = Hit.Position
				o11.Rotation = Vector3.new(-180, 1.29089606, 180)
				o11.FormFactor = Enum.FormFactor.Symmetric
				o11.Size = Vector3.new(1, 2, 1)
				o11.BackSurface = Enum.SurfaceType.SmoothNoOutlines
				o11.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
				o11.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
				o11.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
				o11.RightSurface = Enum.SurfaceType.SmoothNoOutlines
				o11.TopSurface = Enum.SurfaceType.SmoothNoOutlines
				o11.Color = Color3.new(0.458824, 0, 0)
				Hit:Destroy()
				o1 = Instance.new("Sound")
				o1.Parent = o11
				o1.SoundId = "rbxassetid://429400881"
				o1:Play()
			end
			if Hit.Name == "Right Leg" then
				Hit:Destroy()
				o1 = Instance.new("Sound")
				o1.Parent = o11
				o1.SoundId = "rbxassetid://429400881"
				o1:Play()
			end
			if Hit.Name == "Left Arm" then
				o11 = Instance.new("Part")
				o11.Name = "GOREPART"
				o11.Parent = workspace
				o11.BrickColor = BrickColor.new("Maroon")
				o11.Position = Hit.Position
				o11.Rotation = Vector3.new(-180, 1.29089606, 180)
				o11.FormFactor = Enum.FormFactor.Symmetric
				o11.Size = Vector3.new(1, 2, 1)
				o11.BackSurface = Enum.SurfaceType.SmoothNoOutlines
				o11.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
				o11.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
				o11.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
				o11.RightSurface = Enum.SurfaceType.SmoothNoOutlines
				o11.TopSurface = Enum.SurfaceType.SmoothNoOutlines
				o11.Color = Color3.new(0.458824, 0, 0)
				Hit:Destroy()
				o1 = Instance.new("Sound")
				o1.Parent = o11
				o1.SoundId = "rbxassetid://429400881"
				o1:Play()

			end

			if Hit.Name == "Left Leg" then
				Hit:Destroy()
				o1 = Instance.new("Sound")
				o1.Parent = o11
				o1.SoundId = "rbxassetid://429400881"
				o1:Play()

			end
			if Hit.Name == "Left Arm" then
				o11 = Instance.new("Part")
				o11.Name = "GOREPART"
				o11.Parent = workspace
				o11.BrickColor = BrickColor.new("Maroon")
				o11.Position = Hit.Position
				o11.Rotation = Vector3.new(-180, 1.29089606, 180)
				o11.FormFactor = Enum.FormFactor.Symmetric
				o11.Size = Vector3.new(1, 2, 1)
				o11.BackSurface = Enum.SurfaceType.SmoothNoOutlines
				o11.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
				o11.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
				o11.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
				o11.RightSurface = Enum.SurfaceType.SmoothNoOutlines
				o11.TopSurface = Enum.SurfaceType.SmoothNoOutlines
				o11.Color = Color3.new(0.458824, 0, 0)
				Hit:Destroy()
				o1 = Instance.new("Sound")
				o1.Parent = o11
				o1.SoundId = "rbxassetid://429400881"
				o1:Play()

			end
			if Hit.Name == "Torso" then
				o11 = Instance.new("Part")
				o2 = Instance.new("Part")
				o2.Name = "GOREPART"
				o2.Parent = workspace
				o2.BrickColor = BrickColor.new("Maroon")
				o2.Position = Hit.Position
				o2.Rotation = Vector3.new(-180, 1.29089832, 180)
				o2.CanCollide = true
				o2.BackSurface = Enum.SurfaceType.SmoothNoOutlines
				o2.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
				o2.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
				o2.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
				o2.RightSurface = Enum.SurfaceType.SmoothNoOutlines
				o2.TopSurface = Enum.SurfaceType.SmoothNoOutlines
				o2.Size = Vector3.new(2, 1, 1)
				o2.LeftSurface = Enum.SurfaceType.Weld
				o2.RightSurface = Enum.SurfaceType.Weld
				o2.Color = Color3.new(0.105882, 0.164706, 0.207843)
				o1 = Instance.new("Part")
				o1.Name = "GOREPART"
				o1.Parent = workspace
				o1.BrickColor = BrickColor.new("Maroon")
				o1.Position = Hit.Position
				o1.Rotation = Vector3.new(-180, 1.29089832, 180)
				o1.CanCollide = true
				o1.BackSurface = Enum.SurfaceType.SmoothNoOutlines
				o1.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
				o1.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
				o1.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
				o1.RightSurface = Enum.SurfaceType.SmoothNoOutlines
				o1.TopSurface = Enum.SurfaceType.SmoothNoOutlines
				o1.Size = Vector3.new(2, 1, 1)
				o1.LeftSurface = Enum.SurfaceType.Weld
				o1.RightSurface = Enum.SurfaceType.Weld
				o1.Color = Color3.new(0.105882, 0.164706, 0.207843)
				Hit:Destroy()
				o1 = Instance.new("Sound")
				o1.Parent = o11
				o1.SoundId = "rbxassetid://429400881"
				o1:Play()
			end
		end
	end

	function MeleeActivated() --when you swing
		if enabled3d then
			wepin.Enabled = false 
			Whack = Humanoid:LoadAnimation(WhackAnim)
			if Whack then
				Whack:Play()
				SlashSound:Play()
			end
			wait(ReloadTime)
			wepin.Enabled = true
		end
	end

	function MeleeEquipped(mouse) --get everything settled up
		Handle = wepin:WaitForChild("Handle")
		WhackAnim = wepin:WaitForChild("Whack")
		ChopAnim = wepin:WaitForChild("Chop")
		SliceAnim = wepin:WaitForChild("Slice")
		SlashSound = Handle:WaitForChild("SlashSound")
		HitSound = Handle:WaitForChild("Hit")
		Character = wepin.Parent
		Player = Players:GetPlayerFromCharacter(Character)
		Humanoid = Character:FindFirstChild("Humanoid")
		Torso = Character:FindFirstChild("Torso")
		if not Humanoid or not Torso then
			return 	
		end

		if not wepin.Enabled then
			wait(ReloadTime)
			wepin.Enabled = true
		end
	end

	function UnMeleeEquipped()

		enabled3d = false
		if Whack then
			Whack:Stop()
		end
		wait()

	end


	Mouse_Icon = "rbxasset://textures/GunCursor.png"
	Reloading_Icon = "rbxasset://textures/GunWaitCursor.png"


	Mouse = nil

	function OnMeleeEquipped(wepinMouse)
		Mouse = wepinMouse
		UpdateIcon()
	end

	function OnChanged(Property)
		if Property == "Enabled" then
			UpdateIcon()
		end
	end

	wepin.Equipped:connect(OnMeleeEquipped)
	wepin.Changed:connect(OnChanged)

	wepin.Activated:connect(MeleeActivated)
	wepin.Equipped:connect(MeleeEquipped)
	wepin.Unequipped:connect(function() wepin:Destroy() UnMeleeEquipped() end)

	wepin.CHOPPART.Touched:connect(Blow)
end
OrgAmmoGui = AmmoGui:Clone()
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
backpackon = false
player.Backpack:ClearAllChildren()
WhatIS = Frame.Parent.Item

currentequippeditem = 0

listoitemstospawn = items:GetChildren()
POS = 0
lol = false
ecksdee = 1
val = UDim2.new(0,0,0,POS)
function ItemSpawnInit()
	for i,v in ipairs (listoitemstospawn) do
		if lol == false then
			jk = ecksdee
			lol = true
			Frame.Parent.ItemSpawn.Item1.Text = v.Name
			POS = POS + 30
			ecksdee = ecksdee+1
			val = UDim2.new(0,0,0,POS)
			Frame.Parent.ItemSpawn.CanvasSize = UDim2.new(0,0,0,POS)
			Frame.Parent.ItemSpawn.Item1.MouseButton1Down:connect(function()
				Pickup(listoitemstospawn[1]:Clone())
			end)
		elseif lol == true then
			jk = ecksdee
			k = Frame.Parent.ItemSpawn.Item1:Clone()
			k.Parent = Frame.Parent.ItemSpawn
			k.Text = v.Name
			k.Name = "Item" .. ecksdee
			k.Position = val + UDim2.new(0,0,0,0)
			POS = POS + 30		
			val = UDim2.new(0,0,0,POS)
			Frame.Parent.ItemSpawn.CanvasSize = UDim2.new(0,0,0,POS)
			Frame.Parent.ItemSpawn["Item" .. ecksdee].MouseButton1Down:connect(function()
				Pickup(listoitemstospawn[i]:Clone())
			end)
			ecksdee = ecksdee+1
		end
	end
end

ItemSpawnInit()
Inventory = {
	[1] = 0;
}
function checkfortools ()
	local yaornah = false
	for i,v in ipairs (player.Character:GetChildren()) do
		if v:IsA("Tool") then
			yaornah = true
		end
	end
	return yaornah
end
angle = 0
xd=_compatFireRemote
xd.Name = "EVENTDONOTOTUCH"
xd.OnServerEvent:connect(function(plr,Key,target,bonusthing,xddd3)   ------// Plr is Player and the Pos is the recieved value from localscript.
	wait() -- [BACKPORT]: fixes a race condition
	angle = bonusthing

	if Equipped then
		if Key == "r" and not Reloading and not Sprinting and not Aiming and not PatrolMode and wepin.Settings.StoredAmmo.Value > 0 then
			if Shooting then
				Shooting = false
			end
			Reloading = true
			ReloadAnim()
			UpdateGui()
			Reloading = false
		end
	end
	if Key == "fireoff" then
		if true then
			if Equipped then
				if not Equipped then return end
				if Equipped and not PatrolMode then
					if Shooting then
						Shooting = false
					end
				end
			end
		end
	end
	if Key == "firegun" then
		if true then
			if Equipped then
				if Equipped then
					if not Shooting and not Reloading and not Sprinting and not PatrolMode then
						if firemode == 1  then
							if wepin.Settings.Ammo.Value > 0 then
								Shooting = true
							elseif wepin.Settings.Ammo.Value == 0 then
								Shooting = false
							end
							while Shooting and wepin.Settings.Ammo.Value > 0 do
								spawn(function ()Shoot() end)
								--wepin.Settings.Ammo.Value = wepin.Settings.Ammo.Value - 1
								wait(wepin.Settings.FireRate.Value)
							end
						end	
						if firemode == 2 then
							if wepin.Settings.Ammo.Value > 0 then
								Shooting = true
							elseif wepin.Settings.Ammo.Value == 0 then
								Shooting = false
							end
							while Shooting and wepin.Settings.Ammo.Value > 0 do
								if wepin.Settings.Ammo.Value == 0 then
									Shooting = false
								end
								spawn(function ()Shoot() end)
								--wepin.Settings.Ammo.Value = wepin.Settings.Ammo.Value - 1
								wait(wepin.Settings.FireRate.Value)
								Shooting = false
							end
						end
						if firemode == 4 then
							if wepin.Settings.Ammo.Value > 0 then
								Shooting = true
							elseif wepin.Settings.Ammo.Value == 0 then
								Shooting = false
							end
							while Shooting and wepin.Settings.Ammo.Value > 0 do
								if wepin.Settings.Ammo.Value == 0 then
									Shooting = false
								end
								spawn(function ()Shoot() end)

								wait(wepin.Settings.FireRate.Value)
								Shooting = false
							end
						end
						if firemode == 5 then
							if wepin.Settings.Ammo.Value > 0 then
								Shooting = true
							elseif wepin.Settings.Ammo.Value == 0 then
								Shooting = false
							end
							while Shooting and wepin.Settings.Ammo.Value > 0 do
								if wepin.Settings.Ammo.Value == 0 then
									Shooting = false
								end
								spawn(function ()Shoot() end)
								--wepin.Settings.Ammo.Value = wepin.Settings.Ammo.Value - 1
								wait(wepin.Settings.FireRate.Value)
								Shooting = false
							end
						end
						if firemode == 3 then
							for i=1,3 do
								if wepin.Settings.Ammo.Value > 0 then
									Shooting = true
								elseif wepin.Settings.Ammo.Value == 0 then
									Shooting = false
								end
								while Shooting and wepin.Settings.Ammo.Value > 0 do
									if wepin.Settings.Ammo.Value == 0 then
										Shooting = false
									end
									spawn(function ()Shoot() end)
									--wepin.Settings.Ammo.Value = wepin.Settings.Ammo.Value - 1
									wait(wepin.Settings.FireRate.Value)
									Shooting = false
								end
							end
						end
					end
				end
			end
		end
	end
	if Key == "1" then
		if checkfortools() then
			local amiequipped = false
			if currentequippeditem == 1 then
				amiequipped = true
			end
			player.Character.Humanoid:UnequipTools()
			if amiequipped == false then
				UseItem(1)
			end
		else
			UseItem(1)
		end
	end if Key == "2" then
		if checkfortools() then
			local amiequipped = false
			if currentequippeditem == 2 then
				amiequipped = true
			end
			player.Character.Humanoid:UnequipTools()
			wait()
			if amiequipped == false then
				UseItem(2)
			end
		elseif not checkfortools() then
			UseItem(2)
		end
	end if Key == "3" then
		if checkfortools() then
			local amiequipped = false
			if currentequippeditem == 3 then
				amiequipped = true
			end
			player.Character.Humanoid:UnequipTools()
			wait()
			if amiequipped == false then
				UseItem(3)
			end
		elseif not checkfortools() then
			UseItem(3)
		end
	elseif Key == "pickup" then
		pcall(Pickup, target)
	end
	if string.lower(Key) == "v" and wepin.Settings.CanSelectFire.Value == true then
		print"SELECTED FIRE"
		if firemode == 1 then
			if Shooting then
				Shooting = false
			end
			gethui().AmmoGui.Frame.FireModeText.Text = " [ SEMI ] "
			firemode = 2
		elseif firemode == 2 then
			if Shooting then
				Shooting = false
			end
			gethui().AmmoGui.Frame.FireModeText.Text = " [ BURST ] "
			firemode = 3
		elseif firemode == 3 then
			if Shooting then
				Shooting = false
			end
			gethui().AmmoGui.Frame.FireModeText.Text = " [ AUTO ] "
			firemode = 1
		end
	end

	if Key == "p" and not Reloading and not Sprinting and not Aiming then
		if not PatrolMode then
			PatrolAnim()
			PatrolMode = true
		else
			IdleAnim()
			PatrolMode = false		
		end

	end

	if Key == "z" and Equipped and not Zoomed then
		----tweenFoV(25, 60)
		Zoomed = true
	elseif Key == "z" and Equipped and Zoomed then
		----tweenFoV(70, 60)
		Zoomed = false
	end
	if Key =="aim" then
		if Equipped then
			if Equipped and canfire and not Aiming and not Reloading and not Sprinting and not PatrolMode then
				char.Humanoid.WalkSpeed = 10
				if not SightsCycled then		
					--tweenFoV(GunSettings.AimZoom, 60)
				else
					--tweenFoV(GunSettings.CycleZoom, 60)
				end	
				AimAnim()
				Aiming = true
			end
		end
	elseif Key == "unaim" then
		if Equipped then
			if not Equipped then return end
			if Equipped and Aiming and not PatrolMode then
				char.Humanoid.WalkSpeed = 16
				----tweenFoV(70, 60)
				IdleAnim()
				Aiming = false
			end
		end
	end


	if eenabled == true then
		if dragger ~= nil then
			if Key == 'T' or Key == 't'  then
				dragger:AxisRotate(Enum.Axis.Y)
			elseif Key == 'R' or Key == 'r' then
				dragger:AxisRotate(Enum.Axis.Z)
			end
		end
		if Key == "q" then
			ChangeMode()
		end
	end
	return Equipped
end)
spawn(function () while wait() do
		if Equipped then
			if Equipped then
				local HRPCF =  char:WaitForChild("HumanoidRootPart").CFrame * CFrame.new(0, 1.5, 0)* CFrame.new(Humanoid.CameraOffset)
				Neck.C0 =  Torso.CFrame:toObjectSpace(HRPCF)
				Neck.C1 =  angle
			end	
		end
	end end)
function Get(A,H)
	local C = A:GetChildren()
	for i=1, #C do
		pcall(function ()
			local W = Instance.new("Weld")
			W.Part0 = H
			W.Part1 = C[i]
			local CJ = CFrame.new(H.Position)
			local C0 = H.CFrame:inverse()*CJ
			local C1 = C[i].CFrame:inverse()*CJ
			W.C0 = C0
			W.C1 = C1
			W.Parent = H
			C[i].Anchored = false
			C[i].CanCollide = true
		end)
	end
end
--[[
	local W = Instance.new("Weld")
	W.Part0 = H
	W.Part1 = C
	local CJ = CFrame.new(H.Position)
	local C0 = H.CFrame:inverse()*CJ
	local C1 = C.CFrame:inverse()*CJ
	W.C0 = C0
	W.C1 = C1
	W.Parent = H
	C.Anchored = false
	C.CanCollide = true
--]]
function SetColor (inventoryslot, item)
	if item.Settings.Rarity then
		if item.Settings.Rarity.Value == string.lower("common") then
			inventoryslot.TextColor3 = Color3.new(255,255,255)
		end
		if item.Settings.Rarity.Value == string.lower("uncommon") then
			inventoryslot.TextColor3 = Color3.new(20/255,230/255,69/255)
		end
		if item.Settings.Rarity.Value == string.lower("rare") then
			inventoryslot.TextColor3 = Color3.new(80/255,44/255,340/255)
		end
		if item.Settings.Rarity.Value == string.lower("legendary") then
			inventoryslot.TextColor3 = Color3.new(165/255,44/255,173/255)
		end
		if item.Settings.Rarity.Value == string.lower("mythical") then
			inventoryslot.TextColor3 = Color3.new(255/255,6/255,10/255)
		end
		if item.Settings.Rarity.Value == string.lower("godly") then
			inventoryslot.TextColor3 = Color3.new(14/255, 255/255, 247/255)
		end
	else
		inventoryslot.TextColor3 = Color3.new(1,1,1)
	end
end
function _G.Pickup(item) 
	Pickup(item)
end
function Pickup (item) 
	if backpackon == false then
		local pickedup = false
		if item:FindFirstChild("Settings") then
			if item.Settings:FindFirstChild("Ghillie") then
				if ghillie == true then
				else
					item:Destroy()
					ghillie = true
					ghilliesoot()
					pcall(function ()
						for i,v in ipairs (backpack:GetChildren()) do
							pcall(function () v.Material = "Grass" v.BrickColor = BrickColor.new("Earth green") end)
						end end)
				end
			elseif item.Settings:FindFirstChild("Ammunition") then
				if item.Settings.AmmoType.Value == "pistol" then
					AddPistolRounds((item.Settings.Ammunition.Value))
					item:Destroy()
				elseif item.Settings.AmmoType.Value == "rifle" then
					AddRifleRounds((item.Settings.Ammunition.Value))
					item:Destroy()
				elseif item.Settings.AmmoType.Value == "shotgun" then
					AddShotgunRounds((item.Settings.Ammunition.Value))
					item:Destroy()
				end	
			else
				for index,value in ipairs (Inventory) do
					donotset = false
					if (index == 1 or index == 2) then
						pcall(function()			if item.Settings:FindFirstChild("Structure") ~= nil or item.Settings:FindFirstChild("Healing") ~= nil or item.Settings:FindFirstChild("Melee") ~= nil or item.Settings:FindFirstChild("Entrencher") ~= nil then
								donotset = true
							end end)
					end
					if value ~= 0 then else 
						if not donotset then
							if not pickedup then
								if index == 1 then 
									Holster(item)
								end
								if index == 2 then 
									Holster2(item)
								end
								Inventory[index] = item:Clone()
								Frame["Slot"..index].Text = Inventory[index].Name
								SetColor(Frame["Slot"..index],Inventory[index])
								item:Destroy()
								pickedup = true
							end
						end
					end
				end
			end
		end
	end
end
function UseItem(item)
	if doingUQ then -- [BACKPORT]: fixes a race condition
		doingUQ = false
		return
	end
	
	if Equipped == true then else
		Frame.Visible = false
		if Inventory[item] ~= 0 then
			if item == 1 then
				UnHolster ()
			end
			if item == 2 then
				UnHolster2 ()
			end
			wepin = Instance.new("Tool")
			for i,v in ipairs (Inventory[item]:GetChildren()) do
				v:Clone().Parent = wepin
			end
			Get(wepin,wepin.Handle)
			wepin.Name = Inventory[item].Name
			wepin.Parent = player.Character
			wepin = wepin
			
			if wepin.Settings:FindFirstChild("IsGun") then
				if wepin.Settings.IsGun.Value == true then
					function SetSettings ()
						SettingsFolder = wepin.Settings
						GunSettings = {

							Ammo = SettingsFolder.Ammo.Value;
							StoredAmmo = SettingsFolder.StoredAmmo.Value;
							MagCount = SettingsFolder.Mag.Value;

							Automatic = SettingsFolder.Auto.Value;

							Firerate = SettingsFolder.FireRate.Value;
							FireMode = SettingsFolder.FireMode.Value;

							CanSelectFire = SettingsFolder.CanSelectFire.Value;

							Recoil = SettingsFolder.Recoil.Value;

							Drop = SettingsFolder.Drop.Value;

							AimZoom = SettingsFolder.AimZoom.Value;
							CycleZoom = SettingsFolder.CycleZoom.Value;

						}

						if SettingsFolder.RifleOrPistol.Value ~= string.lower("pistol") then
							GunSettings.RightPos = CFrame.new(-0.543740213, 0.246546745, -1.1437645, 0.99999994, 0, 0, 0, -4.37113883e-008, 1, 0, -1, -4.37113883e-008);
							GunSettings.LeftPos = CFrame.new(0.870444, 0.618862808, -1.52524424, 0.821777642, -2.49071093e-008, 0.569808245, -0.55740881, -0.207479686, 0.803895235, 0.118223615, -0.978239357, -0.170502216);
							GunSettings.SecondaryLeftAimPos = CFrame.new(1.28459036, 0.187916204, -1.31596696, 0.821777642, -2.49071093e-008, 0.569808245, -0.55740881, -0.207479686, 0.803895235, 0.118223615, -0.978239357, -0.170502216);
							GunSettings.LeftAimPos = CFrame.new(1.19443822, 0.116214231, -1.13636398, 0.821777642, -2.49071093e-008, 0.569808245, -0.55740881, -0.207479686, 0.803895235, 0.118223615, -0.978239357, -0.170502216);
							GunSettings.RightSprintPos = CFrame.new(-0.543740213, 0.246546745, -1.1437645, 0.868195355, 2.16905711e-008, -0.496222436, 0.466779947, 0.339331359, 0.816682696, 0.168383837, -0.940666854, 0.294605911);	
							GunSettings.LeftSprintPos = CFrame.new(0.870444059, 0.659437597, -1.52524424, 0.98510921, 0.171723664, -0.00840575993, -0.0107716024, 0.110439532, 0.993824482, 0.171591491, -0.978935182, 0.110644706);
						else
							GunSettings.RightPos = CFrame.new(-0.543740213, 0.246546745, -1.1437645, 0.99999994, 0, 0, 0, -4.37113883e-008, 1, 0, -1, -4.37113883e-008);
							GunSettings.LeftPos = CFrame.new(0, 0.618862808, -1.52524424, 2, -2.49071093e-008, 0.569808245, -0.55740881, -0.207479686, 0.803895235, 0.118223615, -0.978239357, -0.170502216);
							GunSettings.SecondaryLeftAimPos = CFrame.new(1.28459036, 0.187916204, -1.31596696, 0.821777642, -2.49071093e-008, 0.569808245, -0.55740881, -0.207479686, 0.803895235, 0.118223615, -0.978239357, -0.170502216);
							GunSettings.LeftAimPos = CFrame.new(1.19443822, 0.116214231, -1.13636398, 0.821777642, -2.49071093e-008, 0.569808245, -0.55740881, -0.207479686, 0.803895235, 0.118223615, -0.978239357, -0.170502216);
							GunSettings.RightSprintPos = CFrame.new(-0.543740213, 0.246546745, -1.1437645, 0.868195355, 2.16905711e-008, -0.496222436, 0.466779947, 0.339331359, 0.816682696, 0.168383837, -0.940666854, 0.294605911);	
							GunSettings.LeftSprintPos = CFrame.new(0, 0.659437597, -1.52524424, 2, 0.171723664, -0.00840575993, -0.0107716024, 0.110439532, 0.993824482, 0.171591491, -0.978935182, 0.110644706);
						end
					end
					pcall(SetSettings)
					Equip(item)
					-- [BACKPORT]: fixes a race condition
					wepin.Unequipped:Connect(function () doingUQ = true; Inventory[item].Settings.Ammo.Value = wepin.Settings.Ammo.Value UnEquipped() wait() wepin:Destroy() if item == 1 then Holster(Inventory[item]) end if item == 2 then Holster2(Inventory[item]) end end)
				end
				if wepin.Settings:FindFirstChild("Entrencher") then
					Entrencher()
					wepin.Unequipped:Connect(function ()wait() wait() wepin:Destroy() end)
				end
				if wepin.Settings:FindFirstChild("Melee") then
					meleeequip()
					wepin.Unequipped:Connect(function ()wait() wait() wepin:Destroy() if item == 1 then Holster(Inventory[item]) end if item == 2 then Holster2(Inventory[item]) end end)
				end
				if wepin.Settings:FindFirstChild("Healing") then
					if foodon == true then wepin:Destroy() else
						foodon = true
						EquipFood(item)
						healval = Inventory[item].Settings.Healing.Value
						wepin.Unequipped:Connect(function () UnEquipped() wait() wepin:Destroy() end)
					end
				end
				if wepin.Settings:FindFirstChild("Structure") then
					for i=1,3 do
						for i,v in ipairs (Inventory[item]:GetChildren()) do
							if v.Name ~="Settings" then
								v:Clone().Parent = workspace
								v.Position = player.Character["Left Leg"].Position + Vector3.new(5,0,5)
								v.Anchored =  true
							end
						end
						wepin:Destroy()
						--k.Parent = workspace
						--k.Position = player.Character["Left Leg"].Position + Vector3.new(5,0,5)
						Frame["Slot"..item].Text = ""
						if item == 1 then UnHolster(Inventory[item]) end 
						if item == 2 then UnHolster2(Inventory[item]) end 
					end
					Inventory[item] = 0
				end
			end
		end
	end
end
function Anchor (obj)
	for i,v in ipairs (obj:GetChildren()) do
		pcall(function ()v.Anchored = true end)
	end
end
function Entrencher ()
	local o3 = Instance.new("ScreenGui")
	local o4 = Instance.new("TextLabel")
	local o5 = Instance.new("TextLabel")
	o3.Name = "EntrencherGUI"
	o3.Parent = wepin
	o4.Name = "Mode"
	o4.Parent = o3
	o4.Position = UDim2.new(0.5,-150,1,-152)
	o4.Size = UDim2.new(0,300,0,20)
	o4.Text = "You are building in \"Basic\" mode."
	o4.Position = UDim2.new(0.5,-150,1,-152)
	o4.Visible = false
	o4.BackgroundColor3 = Color3.new(1, 1, 1)
	o4.BackgroundTransparency = 1
	o4.BorderColor3 = Color3.new(0, 0, 0)
	o4.Font = Enum.Font.SourceSansLight
	o4.FontSize = Enum.FontSize.Size18
	o4.TextColor3 = Color3.new(1, 1, 1)
	o4.TextStrokeTransparency = 0.5
	o5.Name = "Press"
	o5.Parent = o4
	o5.Position = UDim2.new(0.5,-150,1,0)
	o5.Size = UDim2.new(0,300,0,20)
	o5.Text = "Press \"Q\" to change modes."
	o5.Position = UDim2.new(0.5,-150,1,0)
	o5.BackgroundColor3 = Color3.new(1, 1, 1)
	o5.BackgroundTransparency = 1
	o5.BorderColor3 = Color3.new(0, 0, 0)
	o5.Font = Enum.Font.SourceSansLight
	o5.FontSize = Enum.FontSize.Size18
	o5.TextColor3 = Color3.new(1, 1, 1)
	o5.TextStrokeTransparency = 0.5
	local wepin = wepin
	local torso = player.Character.Torso

	local eenabled = true
	local origTexture = wepin.TextureId
	game:GetService("ContentProvider"):Preload("rbxasset://icons/freemove_sel.png")

	local selectionBox
	local currentSelection
	local currentSelectionColors = {}
	local selectionLasso
	local inGui = false
	local inPalette = false
	local lockTime = 0

	local mode = 0
	local current = nil
	local over = nil

	local ldist = 0
	local lang = 0

	local curanch = false
	local curcan = true

	local handles = Instance.new("Handles")
	local arcs = Instance.new("ArcHandles")
	local box = Instance.new("SelectionBox")
	handles.Style = "Movement"
	arcs.Visible = false
	handles.Visible = false

	local gui = wepin.EntrencherGUI:clone()
	handles.Parent, arcs.Parent, box.Parent = gethui(), gethui(), gethui()

	function canSelectObject(part)
		return part and (part.Position - wepin.Parent.Head.Position).Magnitude < 20
	end

	function findModel(part)
		while part ~= nil do
			if part.className == "Model" then
				return part
			end
			part = part.Parent
		end

		return nil
	end

	function startDrag(mousePart, hitPoint, collection)
		dragger = Instance.new("Dragger")
		pcall(function() dragger:MouseDown(mousePart, hitPoint, collection) end)
	end

	function collectBaseParts(object, collection)
		if object:IsA("BasePart") then
			collection[#collection+1] = object
		end
		for index,child in ipairs(object:GetChildren()) do
			collectBaseParts(child, collection)
		end
	end


	function ResetCurrent()
		handles.Adornee = nil
		arcs.Adornee = nil
		if current and current.Parent and current.Parent.className ~= "Model" then
			current.Transparency = 0
		end
		current = nil
		SetGUI()
	end

	function SetCurrent(targ)
		current = targ
		curanch = targ.Anchored
		curcan = targ.CanCollide
		current.AncestryChanged:connect(function()
			ResetCurrent()
		end)
		if current.Parent.className == "Model" then
			handles.Adornee = current
			if mode == 2 then
				ChangeMode()
			end
		else
			handles.Adornee = current
		end
		arcs.Adornee = current
		SetGUI()
	end

	function ResetOver()
		box.Adornee = nil
		over = nil
	end

	function SetOver(targ)
		if targ.Parent.className == "Model" then
			over = targ.Parent
		else
			over = targ
		end
		box.Adornee = over
	end

	function HandlesXD(face, dist)
		current.Anchored = true
		local modi = CFrame.new(0,0,0)
		local sdist = dist - ldist
		ldist = dist
		if face == Enum.NormalId.Top then
			modi = CFrame.new(0,sdist,0)
		elseif face == Enum.NormalId.Bottom then
			modi = CFrame.new(0,-sdist,0)
		elseif face == Enum.NormalId.Back then
			modi = CFrame.new(0,0,sdist)
		elseif face == Enum.NormalId.Front then
			modi = CFrame.new(0,0,-sdist)
		elseif face == Enum.NormalId.Right then
			modi = CFrame.new(sdist,0,0)
		elseif face == Enum.NormalId.Left then
			modi = CFrame.new(-sdist,0,0)
		end
		if (current.CFrame * modi).p.y > 0.5 and ((current.CFrame * modi).p - torso.Position).magnitude < 20 then
			if current.Parent.className == "Model" then
				local head = current
				local disp = (head.CFrame * modi).p - head.CFrame.p
				for _,obj in ipairs(head.Parent:GetChildren()) do
					pcall(function ()obj.CFrame = obj.CFrame + disp end)
				end
			else
				current.CFrame = current.CFrame * modi
				current.Transparency = 0.4
				current.CanCollide = false
			end
		end
		--print("", face, " for ", dist, "studs")
	end

	function Arcs(axis, angle, delta)
		current.Anchored = true
		local modi = CFrame.Angles(0,0,0)
		local sangle = angle - lang
		lang = angle
		if axis == Enum.Axis.X then
			modi = CFrame.Angles(sangle,0,0)
		elseif axis == Enum.Axis.Y then
			modi = CFrame.Angles(0,sangle,0)
		elseif axis == Enum.Axis.Z then
			modi = CFrame.Angles(0,0,sangle)
		end
		if (current.CFrame.p - torso.Position).magnitude < 20 then
			current.CFrame = current.CFrame * modi
		end
		--print("", axis, " axis at ", angle, " degrees for ", delta, " studs")
	end

	function ChangeMode()
		clearSelection()
		if mode == 0 then
			mode = 1
			handles.Visible = true
			arcs.Visible = false
		elseif mode == 1 and current and current.Parent and current.Parent.className ~= "Model" then
			mode = 2
			handles.Visible = false
			arcs.Visible = true
		elseif mode == 1 and not current then
			mode = 2
			handles.Visible = false
			arcs.Visible = true
		else
			mode = 0
			handles.Visible = false
			arcs.Visible = false
		end
		SetGUI()
	end

	function trySelection(part)
		if canSelectObject(part) then
			local model = findModel(part)
			if model then 		
				return setSelection(model)
			else
				return setSelection(part)
			end
		else
			clearSelection()
			return false
		end
	end

	function ResetDist()
		ldist = 0
		lang = 0
		if current and current.Parent then
			current.Anchored = curanch
			if current.Parent.className ~= "Model" then
				current.CanCollide = true
				current.Transparency = 0
			else
				current.CanCollide = curcan
			end
		end
	end

	local alreadyMoving



	function saveSelectionColor(instance)
		local children = instance:GetChildren() 
		if children then
			for pos, child in ipairs(children) do
				saveSelectionColor(child)
			end
		end
	end

	function setSelection(partOrModel)
		if partOrModel ~= currentSelection then
			clearSelection()
			lockTime = time()
			currentSelection = partOrModel
			saveSelectionColor(currentSelection)
			selectionBox.Adornee = currentSelection
			return true
		else
			if currentSelection ~= nil then
				if time() - lockTime > 2 then
				else
					return true
				end
			end
		end

		return false
	end

	function clearSelection()
		if currentSelection ~= nil then
			selectionBox.Adornee = nil
			if currentSelection:IsA("BasePart") then
				currentSelection.Transparency = 0
			end
		end
		currentSelectionColors = {}
		currentSelection = nil
		selectionBox.Adornee = nil
	end

	function Weld(x,y)
		local W = Instance.new("Weld")
		W.Part0 = x
		W.Part1 = y
		local CJ = CFrame.new(x.Position)
		local C0 = x.CFrame:inverse()*CJ
		local C1 = y.CFrame:inverse()*CJ
		W.C0 = C0
		W.C1 = C1
		W.Parent = x
	end

	function Get(A)
		if A.className == "Part" then
			Weld(wepin.Handle, A)
			A.Anchored = false
		else
			local C = A:GetChildren()
			for i=1, #C do
				Get(C[i])
			end
		end
	end

	function Finale()
		Get(wepin)
	end

	function SetGUI()
		if mode == 0 then
			gui.Mode.Text = [[You are building in "Basic" mode.]]
		elseif mode == 1 then
			gui.Mode.Text = [[You are building in "Positional" mode.]]
		else
			gui.Mode.Text = [[You are building in "Rotational" mode.]]
		end
		gui.Mode.Visible = true
	end

	wepin.Equipped:connect(onEquippedLocalXD)
	wepin.Unequipped:connect(onUnequippedLocalXD)
	Finale()
end
function DropItem(item)
	UnEquipped() wait() pcall(function ()wepin:Destroy()end)
	local xd = Inventory[item]
	Get(xd,xd.Handle)
	xd.Parent = workspace
	xd:MoveTo(player.Character.Torso.Position)
	--Get(xd,xd.Handle)
	Inventory[item] = 0	
	Frame["Slot"..item].Text = ""
	if item == 1 then UnHolster(Inventory[item]) end 
	if item == 2 then UnHolster2(Inventory[item]) end 
end
SlotTemp = Frame.Slot1:Clone()
SlotTemp.Parent = nil
Frame.Slot1.MouseButton1Down:connect(function () UseItem(1) end)
Frame.Slot1.MouseButton2Down:connect(function () DropItem(1) Frame.Slot1.Text = "" end)
Frame.Visible = false;
for i=2,10 do
	SlotNew = SlotTemp:Clone()
	SlotNew.Name = "Slot" .. (i)
	SlotNew.Parent = Frame
	SlotNew.Position = UDim2.new(0,25 +(75*(i-1)),0,25)
	Inventory[i] = 0
	SlotNew.MouseButton1Down:connect(function () UseItem(i) end)
	SlotNew.MouseButton2Down:connect(function () DropItem(i) Frame["Slot"..i].Text = "" end)
end

for i=11,20 do
	SlotNew = SlotTemp:Clone()
	SlotNew.Name = "Slot" .. (i)
	SlotNew.Parent = Frame
	SlotNew.Position = UDim2.new(0,25 +(75*(i-11)),0,100)
	Inventory[i] = 0
	SlotNew.MouseButton1Down:connect(function () UseItem(i) end)
	SlotNew.MouseButton2Down:connect(function () DropItem(i) Frame["Slot"..i].Text = "" end)
end
for i=21,30 do
	SlotNew = SlotTemp:Clone()
	SlotNew.Name = "Slot" .. (i)
	SlotNew.Parent = Frame
	SlotNew.Position = UDim2.new(0,25 +(75*(i-21)),0,175)
	Inventory[i] = 0
	SlotNew.MouseButton1Down:connect(function () UseItem(i) end)
	SlotNew.MouseButton2Down:connect(function () DropItem(i) Frame["Slot"..i].Text = "" end)
end
for i=31,40 do
	SlotNew = SlotTemp:Clone()
	SlotNew.Name = "Slot" .. (i)
	SlotNew.Parent = Frame
	SlotNew.Position = UDim2.new(0,25 +(75*(i-31)),0,250)
	Inventory[i] = 0
	SlotNew.MouseButton1Down:connect(function () UseItem(i) end)
	SlotNew.MouseButton2Down:connect(function () DropItem(i) Frame["Slot"..i].Text = "" end)
end
for i=41,50 do
	SlotNew = SlotTemp:Clone()
	SlotNew.Name = "Slot" .. (i)
	SlotNew.Parent = Frame
	SlotNew.Position = UDim2.new(0,25 +(75*(i-41)),0,325)
	Inventory[i] = 0
	SlotNew.MouseButton1Down:connect(function () UseItem(i) end)
	SlotNew.MouseButton2Down:connect(function () DropItem(i) Frame["Slot"..i].Text = "" end)
end
Frame.Visible = false;

foodon = false
function EquipFood (id)
	foodon = true
	local notclicked=false
	local equippfood = true
	function UnEquipFood ()
		foodon = false
		Eating = false equippfood = false
		mainweld:Destroy()
		headweld:Destroy()
	end
	spawn(function ()
		wait(.4)
		wepin.Activated:connect(function ()if equippfood == true then if notclicked == false then Eat(id) end end end)
		wepin.Unequipped:connect(function () equippedlmao = false end)
	end)
	equippedlmao = true
	TORSO = player.Character.Torso
	LEFTARM = player.Character["Left Arm"]
	LEFTARM = player.Character["Left Leg"]
	RIGHTARM = player.Character["Right Arm"]
	RIGHTLEG = player.Character["Right Leg"]
	HEAD = player.Character.Head
	HUMANOID = player.Character.Humanoid
	HUMANOIDROOTPART = player.Character.HumanoidRootPart
	if string.lower(wepin.Settings.Type.Value) == "food" then
		PenileDisorder = Instance.new("Sound",wepin.Handle)
		PenileDisorder.SoundId = "rbxassetid://618667795"
	end
	if string.lower(wepin.Settings.Type.Value) == "drink" then
		PenileDisorder = Instance.new("Sound",wepin.Handle)
		PenileDisorder.SoundId = "http://www.roblox.com/asset/?id=10722059"
	end
	Eating = false
	mainweld = Instance.new("Weld", wepin)
	mainweld.Part0 = HUMANOIDROOTPART
	mainweld.Part1 = RIGHTARM
	mainweld.C0 = CFrame.new(1.5,.5,-.5) * CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))
	headweld = Instance.new("Weld", wepin)
	headweld.Part0 = HUMANOIDROOTPART
	headweld.Part1 = HEAD
	headweld.C0 = CFrame.new(0,1.5,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
end
function Eat(id)
	if Eating == false then
		Eating=true
		hedmain = 0
		mainweldy = 0
		mainweldx = 0
		mainweldpos = 0
		for i=1,20 do
			if equippedlmao then
				wait(1/60)
				hedmain = -i/2
				mainweld.C0 = CFrame.new(1.5-(i*.03),.5,-.5) * CFrame.Angles(math.rad(90),math.rad(-i*.5),math.rad(-i*3))
				headweld.C0 = CFrame.new(0,1.5,0) * CFrame.Angles(math.rad(-i/2),math.rad(0),math.rad(0))
				mainweldy = -i*.5
				mainweldx = -i*3
				mainweldpos = i*.03
			end
		end	
		PenileDisorder:Play()
		for o=1,2 do
			for i=1,20 do
				if equippedlmao then
					wait(1/60)
					mainweldx = mainweldx+i/8
					hedmain = hedmain+i/16
					mainweld.C0 = CFrame.new(1.5-(mainweldpos),.5,-.5) * CFrame.Angles(math.rad(90),math.rad(mainweldy),math.rad(mainweldx))
					headweld.C0 = CFrame.new(0,1.5,0) * CFrame.Angles(math.rad(hedmain),math.rad(0),math.rad(0))
				end
			end
			for i=1,20 do
				wait(1/60)
				if equippedlmao then
					mainweldx = mainweldx-i/8
					hedmain = hedmain-i/16
					mainweld.C0 = CFrame.new(1.5-(mainweldpos),.5,-.5) * CFrame.Angles(math.rad(90),math.rad(mainweldy),math.rad(mainweldx))
					headweld.C0 = CFrame.new(0,1.5,0) * CFrame.Angles(math.rad(hedmain),math.rad(0),math.rad(0))
				end
			end PenileDisorder:Play() end
		for i=1,20 do
			if equippedlmao then
				wait(1/60)
				mainweldx = mainweldx+i/8
				hedmain = hedmain+i/16
				mainweld.C0 = CFrame.new(1.5-(mainweldpos),.5,-.5) * CFrame.Angles(math.rad(90),math.rad(mainweldy),math.rad(mainweldx))
				headweld.C0 = CFrame.new(0,1.5,0) * CFrame.Angles(math.rad(hedmain),math.rad(0),math.rad(0))
			end
		end
		pcall(function()
			headweld:Destroy()
			mainweld:Destroy()
		end)
		if equippedlmao then
			Inventory[id]:Destroy()
			Inventory[id] = 0
			Frame["Slot"..id].Text = ""
			HUMANOID.Health = HUMANOID.Health + healval
		end
		Eating = false
		foodon = false
		if equippedlmao then
			wepin:Destroy()
		end
		player.Character.Humanoid:UnequipTools()
	end
end

function ghilliesoot()

	gmodl1 = Instance.new("Model")
	o2 = Instance.new("Model")
	o3 = Instance.new("Part")
	o4 = Instance.new("Humanoid")
	o5 = Instance.new("Model")
	o6 = Instance.new("Part")
	o7 = Instance.new("Model")
	o8 = Instance.new("Part")
	o9 = Instance.new("Model")
	gmodl10 = Instance.new("Part")
	gmodl11 = Instance.new("Model")
	gmodl12 = Instance.new("Part")
	gmodl13 = Instance.new("Model")
	gmodl14 = Instance.new("Part")
	gmodl15 = Instance.new("SpecialMesh")
	gmodl1.Name = ""
	o2.Name = "Arm2"
	o2.Parent = gmodl1
	o3.Name = "Middle"
	o3.Parent = o2
	o3.Material = Enum.Material.Grass
	o3.BrickColor = BrickColor.new("Earth green")
	o3.Position = Vector3.new(37.3759346, 3.54812789, 84.682457)
	o3.Rotation = Vector3.new(-0.0399999991, -90, 0)
	o3.Anchored = true
	o3.FormFactor = Enum.FormFactor.Custom
	o3.Size = Vector3.new(0.998000026, 1.99600005, 0.998000026)*1.2
	o3.CFrame = CFrame.new(37.3759346, 3.54812789, 84.682457, -3.50637856e-05, -4.49078434e-05, -1, 0.000690124114, 0.999999762, -4.49320069e-05, 0.999999762, -0.000690125627, -3.50327973e-05)
	o3.BackSurface = Enum.SurfaceType.SmoothNoOutlines
	o3.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
	o3.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
	o3.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
	o3.RightSurface = Enum.SurfaceType.SmoothNoOutlines
	o3.TopSurface = Enum.SurfaceType.SmoothNoOutlines
	o3.Color = Color3.new(0.152941, 0.27451, 0.176471)
	o3.Position = Vector3.new(37.3759346, 3.54812789, 84.682457)
	o4.Parent = gmodl1
	o4.Health = 0
	o4.MaxHealth = 0
	o5.Name = "Arm1"
	o5.Parent = gmodl1
	o6.Name = "Middle"
	o6.Parent = o5
	o6.Material = Enum.Material.Grass
	o6.BrickColor = BrickColor.new("Earth green")
	o6.Position = Vector3.new(37.3760605, 3.55011511, 87.6166687)
	o6.Rotation = Vector3.new(-0.0399999991, -90, 0)
	o6.Anchored = true
	o6.FormFactor = Enum.FormFactor.Custom
	o6.Size = Vector3.new(0.998112798, 1.99622655, 0.998112798)*1.2
	o6.CFrame = CFrame.new(37.3760605, 3.55011511, 87.6166687, -3.50637856e-05, -4.49078434e-05, -1, 0.000690124114, 0.999999762, -4.49320069e-05, 0.999999762, -0.000690125627, -3.50327973e-05)
	o6.BackSurface = Enum.SurfaceType.SmoothNoOutlines
	o6.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
	o6.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
	o6.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
	o6.RightSurface = Enum.SurfaceType.SmoothNoOutlines
	o6.TopSurface = Enum.SurfaceType.SmoothNoOutlines
	o6.Color = Color3.new(0.152941, 0.27451, 0.176471)
	o6.Position = Vector3.new(37.3760605, 3.55011511, 87.6166687)
	o7.Name = "Chest"
	o7.Parent = gmodl1
	o8.Name = "Middle"
	o8.Parent = o7
	o8.Material = Enum.Material.Grass
	o8.BrickColor = BrickColor.new("Earth green")
	o8.Position = Vector3.new(37.3760071, 3.54912996, 86.149559)
	o8.Rotation = Vector3.new(-0.0399999991, -90, 0)
	o8.Anchored = true
	o8.FormFactor = Enum.FormFactor.Custom
	o8.Size = Vector3.new(2.0962255, 2.09622669, 1.04811275)*1.2
	o8.CFrame = CFrame.new(37.3760071, 3.54912996, 86.149559, -3.50637856e-05, -4.49078434e-05, -1, 0.000690124114, 0.999999762, -4.49320069e-05, 0.999999762, -0.000690125627, -3.50327973e-05)
	o8.BackSurface = Enum.SurfaceType.SmoothNoOutlines
	o8.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
	o8.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
	o8.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
	o8.RightSurface = Enum.SurfaceType.SmoothNoOutlines
	o8.TopSurface = Enum.SurfaceType.SmoothNoOutlines
	o8.Color = Color3.new(0.152941, 0.27451, 0.176471)
	o8.Position = Vector3.new(37.3760071, 3.54912996, 86.149559)
	o9.Name = "Leg1"
	o9.Parent = gmodl1
	gmodl10.Name = "Middle"
	gmodl10.Parent = o9
	gmodl10.Material = Enum.Material.Grass
	gmodl10.BrickColor = BrickColor.new("Earth green")
	gmodl10.Position = Vector3.new(37.3762856, 1.59325194, 86.6399231)
	gmodl10.Rotation = Vector3.new(-0.0399999991, -90, 0)
	gmodl10.Anchored = true
	gmodl10.FormFactor = Enum.FormFactor.Custom
	gmodl10.Size = Vector3.new(0.998000026, 1.99600005, 0.998000026)*1.2
	gmodl10.CFrame = CFrame.new(37.3762856, 1.59325194, 86.6399231, -3.50637856e-05, -4.49078434e-05, -1, 0.000690124114, 0.999999762, -4.49320069e-05, 0.999999762, -0.000690125627, -3.50327973e-05)
	gmodl10.BackSurface = Enum.SurfaceType.SmoothNoOutlines
	gmodl10.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
	gmodl10.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
	gmodl10.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
	gmodl10.RightSurface = Enum.SurfaceType.SmoothNoOutlines
	gmodl10.TopSurface = Enum.SurfaceType.SmoothNoOutlines
	gmodl10.Color = Color3.new(0.152941, 0.27451, 0.176471)
	gmodl10.Position = Vector3.new(37.3762856, 1.59325194, 86.6399231)
	gmodl11.Name = "Leg2"
	gmodl11.Parent = gmodl1
	gmodl12.Name = "Middle"
	gmodl12.Parent = gmodl11
	gmodl12.Material = Enum.Material.Grass
	gmodl12.BrickColor = BrickColor.new("Earth green")
	gmodl12.Position = Vector3.new(37.3762398, 1.59257996, 85.6618729)
	gmodl12.Rotation = Vector3.new(-0.0399999991, -90, 0)
	gmodl12.Anchored = true
	gmodl12.FormFactor = Enum.FormFactor.Custom
	gmodl12.Size = Vector3.new(0.998000026, 1.99600005, 0.998000026)*1.2
	gmodl12.CFrame = CFrame.new(37.3762398, 1.59257996, 85.6618729, -3.50637856e-05, -4.49078434e-05, -1, 0.000690124114, 0.999999762, -4.49320069e-05, 0.999999762, -0.000690125627, -3.50327973e-05)
	gmodl12.BackSurface = Enum.SurfaceType.SmoothNoOutlines
	gmodl12.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
	gmodl12.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
	gmodl12.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
	gmodl12.RightSurface = Enum.SurfaceType.SmoothNoOutlines
	gmodl12.TopSurface = Enum.SurfaceType.SmoothNoOutlines
	gmodl12.Color = Color3.new(0.152941, 0.27451, 0.176471)
	gmodl12.Position = Vector3.new(37.3762398, 1.59257996, 85.6618729)
	gmodl13.Name = "Face"
	gmodl13.Parent = gmodl1
	gmodl14.Name = "Middle"
	gmodl14.Parent = gmodl13
	gmodl14.Material = Enum.Material.Grass
	gmodl14.BrickColor = BrickColor.new("Earth green")
	gmodl14.Position = Vector3.new(37.2820053, 5.10392523, 86.21035)
	gmodl14.Rotation = Vector3.new(-58.2999992, 89.9799957, 58.2799988)
	gmodl14.Anchored = true
	gmodl14.FormFactor = Enum.FormFactor.Custom
	gmodl14.Size = Vector3.new(1.37716627, 1.00858402, 1.00858355)*1.2
	gmodl14.CFrame = CFrame.new(37.2820053, 5.10392523, 86.21035, 8.12045982e-07, -1.31358331e-06, 0.99999994, 2.87545845e-07, 0.99999249, 1.37971995e-06, -0.99999249, 3.01923137e-07, 8.52220182e-07)
	gmodl14.BackSurface = Enum.SurfaceType.SmoothNoOutlines
	gmodl14.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
	gmodl14.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
	gmodl14.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
	gmodl14.RightSurface = Enum.SurfaceType.SmoothNoOutlines
	gmodl14.TopSurface = Enum.SurfaceType.SmoothNoOutlines
	gmodl14.Color = Color3.new(0.152941, 0.27451, 0.176471)
	gmodl14.Position = Vector3.new(37.2820053, 5.10392523, 86.21035)
	gmodl15.Parent = gmodl14
	gmodl15.Scale = Vector3.new(1.25, 1.25, 1.25)
	gmodl15.MeshType = Enum.MeshType.Torso
	function onTouchedArm1(hit)
		if hit.Parent:findFirstChild("Humanoid") ~= nil and hit.Parent:findFirstChild("Arm1") == nil then
			local g =gmodl1.Arm1:clone()
			g.Parent = hit.Parent
			local C = g:GetChildren()
			for i=1, #C do
				if C[i].className == "Part" or C[i].className == "UnionOperation" or C[i].className == "WedgePart"  then
					local W = Instance.new("Weld")
					W.Part0 = g.Middle
					W.Part1 = C[i]
					local CJ = CFrame.new(g.Middle.Position)
					local C0 = g.Middle.CFrame:inverse()*CJ
					local C1 = C[i].CFrame:inverse()*CJ
					W.C0 = C0
					W.C1 = C1
					W.Parent = g.Middle
				end
				local Y = Instance.new("Weld")
				Y.Part0 = hit.Parent["Left Arm"]
				Y.Part1 = g.Middle
				Y.C0 = CFrame.new(0, 0, 0)
				Y.Parent = Y.Part0
			end

			local h = g:GetChildren()
			for i = 1, # h do
				if h[i].className == "Part" or h[i].className == "UnionOperation" or h[i].className == "WedgePart"  then
					h[i].Anchored = false
					h[i].CanCollide = false
				end
			end

		end

	end
	function onTouchedArm2(hit)
		if hit.Parent:findFirstChild("Humanoid") ~= nil and hit.Parent:findFirstChild("Arm2") == nil then
			local g =gmodl1.Arm2:clone()
			g.Parent = hit.Parent
			local C = g:GetChildren()
			for i=1, #C do
				if C[i].className == "Part" or C[i].className == "UnionOperation" or C[i].className == "WedgePart"  then
					local W = Instance.new("Weld")
					W.Part0 = g.Middle
					W.Part1 = C[i]
					local CJ = CFrame.new(g.Middle.Position)
					local C0 = g.Middle.CFrame:inverse()*CJ
					local C1 = C[i].CFrame:inverse()*CJ
					W.C0 = C0
					W.C1 = C1
					W.Parent = g.Middle
				end
				local Y = Instance.new("Weld")
				Y.Part0 = hit.Parent["Right Arm"]
				Y.Part1 = g.Middle
				Y.C0 = CFrame.new(0, 0, 0)
				Y.Parent = Y.Part0
			end

			local h = g:GetChildren()
			for i = 1, # h do
				if h[i].className == "Part" or h[i].className == "UnionOperation" or h[i].className == "WedgePart"  then
					h[i].Anchored = false
					h[i].CanCollide = false
				end
			end

		end

	end
	function onTouchedHead(hit)
		if hit.Parent:findFirstChild("Humanoid") ~= nil and hit.Parent:findFirstChild("Face") == nil then
			local g =gmodl1.Face:clone()
			g.Parent = hit.Parent
			local C = g:GetChildren()
			for i=1, #C do
				if C[i].className == "Part" or C[i].className == "UnionOperation" or C[i].className == "WedgePart"  then
					local W = Instance.new("Weld")
					W.Part0 = g.Middle
					W.Part1 = C[i]
					local CJ = CFrame.new(g.Middle.Position)
					local C0 = g.Middle.CFrame:inverse()*CJ
					local C1 = C[i].CFrame:inverse()*CJ
					W.C0 = C0
					W.C1 = C1
					W.Parent = g.Middle
				end
				local Y = Instance.new("Weld")
				Y.Part0 = hit.Parent.Head
				Y.Part1 = g.Middle
				Y.C0 = CFrame.new(0, 0, 0)
				Y.Parent = Y.Part0
			end

			local h = g:GetChildren()
			for i = 1, # h do
				if h[i].className == "Part" or C[i].className == "UnionOperation" or C[i].className == "WedgePart"  then
					h[i].Anchored = false
					h[i].CanCollide = false
				end
			end

		end
	end
	function onTouchedLeg1(hit)
		if hit.Parent:findFirstChild("Humanoid") ~= nil and hit.Parent:findFirstChild("Leg1") == nil then
			local g =gmodl1.Leg1:clone()
			g.Parent = hit.Parent
			local C = g:GetChildren()
			for i=1, #C do
				if C[i].className == "Part" or C[i].className == "UnionOperation" or C[i].className == "WedgePart"  then
					local W = Instance.new("Weld")
					W.Part0 = g.Middle
					W.Part1 = C[i]
					local CJ = CFrame.new(g.Middle.Position)
					local C0 = g.Middle.CFrame:inverse()*CJ
					local C1 = C[i].CFrame:inverse()*CJ
					W.C0 = C0
					W.C1 = C1
					W.Parent = g.Middle
				end
				local Y = Instance.new("Weld")
				Y.Part0 = hit.Parent["Left Leg"]
				Y.Part1 = g.Middle
				Y.C0 = CFrame.new(0, 0, 0)
				Y.Parent = Y.Part0
			end

			local h = g:GetChildren()
			for i = 1, # h do
				if h[i].className == "Part" or h[i].className == "UnionOperation" or h[i].className == "WedgePart"  then
					h[i].Anchored = false
					h[i].CanCollide = false
				end
			end

		end

	end
	function onTouchedLeg2(hit)
		if hit.Parent:findFirstChild("Humanoid") ~= nil and hit.Parent:findFirstChild("Leg2") == nil then
			local g =gmodl1.Leg2:clone()
			g.Parent = hit.Parent
			local C = g:GetChildren()
			for i=1, #C do
				if C[i].className == "Part" or C[i].className == "UnionOperation" or C[i].className == "WedgePart"  then
					local W = Instance.new("Weld")
					W.Part0 = g.Middle
					W.Part1 = C[i]
					local CJ = CFrame.new(g.Middle.Position)
					local C0 = g.Middle.CFrame:inverse()*CJ
					local C1 = C[i].CFrame:inverse()*CJ
					W.C0 = C0
					W.C1 = C1
					W.Parent = g.Middle
				end
				local Y = Instance.new("Weld")
				Y.Part0 = hit.Parent["Right Leg"]
				Y.Part1 = g.Middle
				Y.C0 = CFrame.new(0, 0, 0)
				Y.Parent = Y.Part0
			end

			local h = g:GetChildren()
			for i = 1, # h do
				if h[i].className == "Part" or h[i].className == "UnionOperation" or h[i].className == "WedgePart"  then
					h[i].Anchored = false
					h[i].CanCollide = false
				end
			end

		end

	end
	function onTouchedTorso(hit)
		if hit.Parent:findFirstChild("Humanoid") ~= nil then
			local g =gmodl1.Chest:clone()
			g.Parent = hit.Parent
			local C = g:GetChildren()
			for i=1, #C do
				if C[i].className == "Part" or C[i].className == "UnionOperation" then
					local W = Instance.new("Weld")
					W.Part0 = g.Middle
					W.Part1 = C[i]
					local CJ = CFrame.new(g.Middle.Position)
					local C0 = g.Middle.CFrame:inverse()*CJ
					local C1 = C[i].CFrame:inverse()*CJ
					W.C0 = C0
					W.C1 = C1
					W.Parent = g.Middle
				end
				local Y = Instance.new("Weld")
				Y.Part0 = hit.Parent.Torso
				Y.Part1 = g.Middle
				Y.C0 = CFrame.new(0, 0, 0)
				Y.Parent = Y.Part0
			end
			for i,v in ipairs (hit.Parent:GetChildren()) do
				if v:IsA("Hat") or v:IsA("Accessory") then
					v:Destroy()
				end
			end

			local h = g:GetChildren()
			for i = 1, # h do
				if h[i].className == "Part" or h[i].className == "UnionOperation" then
					h[i].Anchored = false
					h[i].CanCollide = false
				end
			end

		end
	end

	onTouchedTorso(player.Character.Head)
	onTouchedLeg2(player.Character.Head)
	onTouchedLeg1(player.Character.Head)
	onTouchedHead(player.Character.Head)
	onTouchedArm2(player.Character.Head)
	onTouchedArm1(player.Character.Head)
end
function ENABLEXDD()

	pcall(function () Torso = char.Torso
		Neck = char.Torso["Neck"]

		Humanoid = char.Humanoid

	end)
	--RIFLE HOLSTER BY DMS
	o1 = Instance.new("Model")
	o2 = Instance.new("Part")
	o3 = Instance.new("SpecialMesh")
	o4 = Instance.new("Part")
	o5 = Instance.new("Part")
	o1.Name = "Chest"
	o2.Name = "Middle"
	o2.Parent = o1
	o2.BrickColor = BrickColor.new("Brown")
	o2.Transparency = 1
	o2.Position = Vector3.new(16.3999977, 3.00001407, -9.29999828)
	o2.Rotation = Vector3.new(0, 90, 0)
	o2.Anchored = true
	o2.FormFactor = Enum.FormFactor.Symmetric
	o2.Size = Vector3.new(2, 2, 1)
	o2.CFrame = CFrame.new(16.3999977, 3.00001407, -9.29999828, -0, 0, 1, -0, 1, 0, -1, 0, 0)
	o2.BottomSurface = Enum.SurfaceType.Smooth
	o2.FrontSurface = Enum.SurfaceType.Weld
	o2.TopSurface = Enum.SurfaceType.Smooth
	o2.Color = Color3.new(0.486275, 0.360784, 0.27451)
	o3.Parent = o2
	o3.MeshType = Enum.MeshType.Brick
	o4.Name = "GUNPART"
	o4.Parent = o1
	o4.Material = Enum.Material.Metal
	o4.BrickColor = BrickColor.new("Black")
	o4.Transparency = 1
	o4.Position = Vector3.new(17.0842819, 2.94457984, -9.7966404)
	o4.Rotation = Vector3.new(-90.1299973, 86.9100037, 45.1300011)
	o4.Anchored = true
	o4.CanCollide = false
	o4.FormFactor = Enum.FormFactor.Custom
	o4.Size = Vector3.new(0.200000003, 0.262021214, 0.200000003)
	o4.CFrame = CFrame.new(17.51931, 2.61149931, -8.57078457, 0, -1, -0.000174999994, -1, 0, 0, 0, 0.000174999994, -1)
	o4.BottomSurface = Enum.SurfaceType.Smooth
	o4.TopSurface = Enum.SurfaceType.SmoothNoOutlines
	o4.Color = Color3.new(0.105882, 0.164706, 0.207843)

	o5.Name = "GUNPART2"
	o5.Parent = o1
	o5.Material = Enum.Material.Metal
	o5.BrickColor = BrickColor.new("Black")
	o5.Transparency = 1
	o5.Position = Vector3.new(17.0842819, 2.94457984, -9.7966404)
	o5.Rotation = Vector3.new(-90.1299973, 86.9100037, 45.1300011)
	o5.Anchored = true
	o5.CanCollide = false
	o5.FormFactor = Enum.FormFactor.Custom
	o5.Size = Vector3.new(0.200000003, 0.262021214, 0.200000003)
	o5.CFrame = CFrame.new(17.5190487, 2.61149931, -10.0687799, 0, -1, -0.000174999994, -1, 0, 0, 0, 0.000174999994, -1)
	o5.BottomSurface = Enum.SurfaceType.Smooth
	o5.TopSurface = Enum.SurfaceType.SmoothNoOutlines
	o5.Color = Color3.new(0.105882, 0.164706, 0.207843)
	function NoHolst ()
		for i,k in ipairs (player.Character.Chest:GetChildren()) do
			if k.Name == "WEAPHOLS" then
				k:Destroy()
			end
		end
		player.Character.Chest.GUNPART:ClearAllChildren()
	end
	function Holster(tool)
		pcall(function ()
			for i,k in ipairs (player.Character.Chest:GetChildren()) do
				if k.Name == "WEAPHOLS" then
					k:Destroy()
				end
			end
		end)
		player.Character.Chest.GUNPART:ClearAllChildren()
		local Model = Instance.new("Model")
		for i,k in ipairs (tool:GetChildren()) do
			pcall(function ()k.CanCollide = false end)
			local xd = k:Clone()
			if xd.Name == "Settings" then xd:Destroy() else xd.Parent = Model end
		end
		function Weld(x,y)
			local W = Instance.new("Weld")
			W.Part0 = x
			W.Part1 = y
			local CJ = CFrame.new(x.Position)
			local C0 = x.CFrame:inverse()*CJ
			local C1 = y.CFrame:inverse()*CJ
			W.C0 = C0
			W.C1 = C1
			W.Parent = x
		end
		local function Get(A)
			if A.className == "Part" or  A.className == "WedgePart"  then
				Weld(Model.Handle, A)
				A.Anchored = false
			else
				local C = A:GetChildren()
				for i=1, #C do
					Get(C[i])
				end
			end
		end
		Get(Model)
		Model.Name = "WEAPHOLS"
		Model.Handle.CFrame = player.Character.Chest.GUNPART.CFrame
		Model.Parent = player.Character.Chest
		local kys = Instance.new("Weld")
		kys.Parent = player.Character.Chest.GUNPART
		kys.C0 = CFrame.new(-.5,0,0) * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))
		kys.Part0 = player.Character.Chest.GUNPART
		kys.Part1 = Model.Handle
		local ded = false
		function UnHolster ()
			Model:Destroy()
		end
	end
	function NoHolst2 ()
		for i,k in ipairs (player.Character.Chest:GetChildren()) do
			if k.Name == "WEAPHOLS" then
				k:Destroy()
			end
		end
		player.Character.Chest.GUNPART2:ClearAllChildren()
	end
	function Holster2(tool)
		pcall(function()
			for i,k in ipairs (player.Character.Chest:GetChildren()) do
				if k.Name == "WEAPHOLS2" then
					k:Destroy()
				end
			end
		end)
		player.Character.Chest.GUNPART2:ClearAllChildren()
		local Model = Instance.new("Model")
		for i,k in ipairs (tool:GetChildren()) do
			pcall(function ()k.CanCollide = false end)
			local xd = k:Clone()
			if xd.Name == "Settings" then xd:Destroy() else xd.Parent = Model end
		end
		function UnHolster2 ()
			Model:Destroy()
		end
		Get(Model,Model.Handle)
		Model.Name = "WEAPHOLS2"
		Model.Handle.CFrame = player.Character.Chest.GUNPART2.CFrame
		Model.Parent = player.Character.Chest
		local kys = Instance.new("Weld")
		kys.Parent = player.Character.Chest.GUNPART2
		kys.C0 = CFrame.new(-.5,0,0) * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))
		kys.Part0 = player.Character.Chest.GUNPART2
		kys.Part1 = Model.Handle
		local ded = false
	end
	function onTouched(hit)
		if hit.Parent:findFirstChild("Humanoid") ~= nil then
			local g = o1:clone()
			g.Parent = hit.Parent
			local C = g:GetChildren()
			for i=1, #C do
				if C[i].className == "Part" then
					local W = Instance.new("Weld")
					W.Part0 = g.Middle
					W.Part1 = C[i]
					local CJ = CFrame.new(g.Middle.Position)
					local C0 = g.Middle.CFrame:inverse()*CJ
					local C1 = C[i].CFrame:inverse()*CJ
					W.C0 = C0
					W.C1 = C1
					W.Parent = g.Middle
				end
				local Y = Instance.new("Weld")
				Y.Part0 = hit.Parent.Torso
				Y.Part1 = g.Middle
				Y.C0 = CFrame.new(0, 0, 0)
				Y.Parent = Y.Part0
			end

			local h = g:GetChildren()
			for i = 1, # h do
				if h[i].className == "Part" then
					h[i].Anchored = false
					h[i].CanCollide = false
				end
			end

		end
	end
	onTouched(player.Character.Head)



	--//f423f


	if backpek == true then
		--Dark BackPack by DMS i copy pasted this script and made it darker so smart
		backpack = Instance.new("Model")
		backpack.Name = "Vest"
		o2 = Instance.new("Part")
		o2.Name = "Middle"
		o2.Parent = backpack
		o2.BrickColor = BrickColor.new("Brick yellow")
		o2.Transparency = 1
		o2.Position = Vector3.new(-13.46, 3.00000095, -3.81999493)
		o2.Rotation = Vector3.new(-180, 0, -180)
		o2.Anchored = true
		o2.CFrame = CFrame.new(-13.46, 3.00000095, -3.81999493, -1, 0, 0, 0, 1, 0, 0, 0, -1)
		o2.CanCollide = false
		o2.FormFactor = Enum.FormFactor.Symmetric
		o2.Size = Vector3.new(2, 2, 1)
		o2.BackSurface = Enum.SurfaceType.SmoothNoOutlines
		o2.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
		o2.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
		o2.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
		o2.RightSurface = Enum.SurfaceType.SmoothNoOutlines
		o2.TopSurface = Enum.SurfaceType.SmoothNoOutlines
		o2.Color = Color3.new(0.843137, 0.772549, 0.603922)
		o3 = Instance.new("Part")
		o3.Name = "Pack"
		o3.Parent = backpack
		o3.BrickColor = BrickColor.new("Black")
		o3.Position = Vector3.new(-13.46, 3.01200294, -4.6249938)
		o3.Rotation = Vector3.new(-0, 0, 1.70754777e-006)
		o3.Anchored = true
		o3.CFrame = CFrame.new(-13.46, 3.01200294, -4.6249938, 0.999999821, -2.98023224e-008, 0, 2.98023224e-008, 0.999999821, 0, 0, 0, 1)
		o3.CanCollide = false
		o3.FormFactor = Enum.FormFactor.Custom
		o3.Size = Vector3.new(1.65999985, 1.80000019, 0.630000472)
		o3.BackSurface = Enum.SurfaceType.SmoothNoOutlines
		o3.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
		o3.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
		o3.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
		o3.RightSurface = Enum.SurfaceType.SmoothNoOutlines
		o3.TopSurface = Enum.SurfaceType.SmoothNoOutlines
		o3.Color = Color3.new(0.105882, 0.164706, 0.207843)
		o4 = Instance.new("Part")
		o4.Name = "Strap"
		o4.Parent = backpack
		o4.BrickColor = BrickColor.new("Really black")
		o4.Position = Vector3.new(-13.9900017, 2.99700594, -3.81499791)
		o4.Rotation = Vector3.new(-180, 0, 180)
		o4.Anchored = true
		o4.CFrame = CFrame.new(-13.9900017, 2.99700594, -3.81499791, -0.999999821, -2.98023224e-008, 0, -2.98023224e-008, 0.999999821, 0, 0, -0, -1)
		o4.CanCollide = false
		o4.FormFactor = Enum.FormFactor.Custom
		o4.Size = Vector3.new(0.259999752, 2.11000037, 1.15000045)
		o4.BackSurface = Enum.SurfaceType.SmoothNoOutlines
		o4.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
		o4.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
		o4.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
		o4.RightSurface = Enum.SurfaceType.SmoothNoOutlines
		o4.TopSurface = Enum.SurfaceType.SmoothNoOutlines
		o4.Color = Color3.new(0.0666667, 0.0666667, 0.0666667)
		o5 = Instance.new("Part")
		o5.Name = "Flap"
		o5.Parent = backpack
		o5.BrickColor = BrickColor.new("Really black")
		o5.Position = Vector3.new(-13.46, 3.79200602, -4.63999414)
		o5.Rotation = Vector3.new(-180, 0, 180)
		o5.Anchored = true
		o5.CFrame = CFrame.new(-13.46, 3.79200602, -4.63999414, -0.999999821, -2.98023224e-008, 0, -2.98023224e-008, 0.999999821, 0, -0, 0, -1)
		o5.CanCollide = false
		o5.FormFactor = Enum.FormFactor.Custom
		o5.Size = Vector3.new(1.71999979, 0.400000006, 0.639999866)
		o5.BackSurface = Enum.SurfaceType.SmoothNoOutlines
		o5.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
		o5.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
		o5.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
		o5.RightSurface = Enum.SurfaceType.SmoothNoOutlines
		o5.TopSurface = Enum.SurfaceType.SmoothNoOutlines
		o5.Color = Color3.new(0.0666667, 0.0666667, 0.0666667)
		o6 = Instance.new("Part")
		o6.Name = "Pocket"
		o6.Parent = backpack
		o6.BrickColor = BrickColor.new("Really black")
		o6.Position = Vector3.new(-13.4700136, 2.80200195, -4.88999414)
		o6.Rotation = Vector3.new(-180, 0, 90)
		o6.Anchored = true
		o6.CFrame = CFrame.new(-13.4700136, 2.80200195, -4.88999414, 2.98023224e-008, -0.999999821, 0, -0.999999821, -2.98023224e-008, 0, 0, -0, -1)
		o6.CanCollide = false
		o6.FormFactor = Enum.FormFactor.Custom
		o6.Size = Vector3.new(0.600000024, 0.800000131, 0.200000003)
		o6.BackSurface = Enum.SurfaceType.SmoothNoOutlines
		o6.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
		o6.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
		o6.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
		o6.RightSurface = Enum.SurfaceType.SmoothNoOutlines
		o6.TopSurface = Enum.SurfaceType.SmoothNoOutlines
		o6.Color = Color3.new(0.0666667, 0.0666667, 0.0666667)
		o7 = Instance.new("Part")
		o7.Name = "Pocket"
		o7.Parent = backpack
		o7.BrickColor = BrickColor.new("Really black")
		o7.Position = Vector3.new(-13.46, 3.04200602, -4.61999798)
		o7.Rotation = Vector3.new(90, -89.9657364, -0)
		o7.Anchored = true
		o7.CFrame = CFrame.new(-13.46, 3.04200602, -4.61999798, 2.98023224e-008, 0, -0.999999821, -0.999999821, -0, -2.98023224e-008, 0, 1, 0)
		o7.CanCollide = false
		o7.FormFactor = Enum.FormFactor.Custom
		o7.Size = Vector3.new(0.600000024, 0.400000155, 1.70000005)
		o7.BackSurface = Enum.SurfaceType.SmoothNoOutlines
		o7.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
		o7.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
		o7.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
		o7.RightSurface = Enum.SurfaceType.SmoothNoOutlines
		o7.TopSurface = Enum.SurfaceType.SmoothNoOutlines
		o7.Color = Color3.new(0.0666667, 0.0666667, 0.0666667)
		o8 = Instance.new("Part")
		o8.Name = "Strap"
		o8.Parent = backpack
		o8.BrickColor = BrickColor.new("Really black")
		o8.Position = Vector3.new(-12.9500103, 2.99700594, -3.81499791)
		o8.Rotation = Vector3.new(-180, 0, 180)
		o8.Anchored = true
		o8.CFrame = CFrame.new(-12.9500103, 2.99700594, -3.81499791, -0.999999821, -2.98023224e-008, 0, -2.98023224e-008, 0.999999821, 0, 0, -0, -1)
		o8.CanCollide = false
		o8.FormFactor = Enum.FormFactor.Custom
		o8.Size = Vector3.new(0.259999752, 2.11000037, 1.15000045)
		o8.BackSurface = Enum.SurfaceType.SmoothNoOutlines
		o8.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
		o8.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
		o8.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
		o8.RightSurface = Enum.SurfaceType.SmoothNoOutlines
		o8.TopSurface = Enum.SurfaceType.SmoothNoOutlines
		o8.Color = Color3.new(0.0666667, 0.0666667, 0.0666667)
		backpack = backpack:clone()
		backpack.Parent = player.Character
		local C = backpack:GetChildren()
		for i=1, #C do
			if C[i].className == "Part" then
				local W = Instance.new("Weld")
				W.Part0 = backpack.Middle
				W.Part1 = C[i]
				local CJ = CFrame.new(backpack.Middle.Position)
				local C0 = backpack.Middle.CFrame:inverse()*CJ
				local C1 = C[i].CFrame:inverse()*CJ
				W.C0 = C0
				W.C1 = C1
				W.Parent = backpack.Middle
			end
			local Y = Instance.new("Weld")
			Y.Part0 = player.Character.Torso
			Y.Part1 = backpack.Middle
			Y.C0 = CFrame.new(0, 0, 0)
			Y.Parent = Y.Part0
		end

		local h = backpack:GetChildren()
		for i = 1, # h do
			h[i].Anchored = false
			h[i].CanCollide = false
		end
		pcall(function ()
			if ghillie == true then
				ghilliesoot()
				pcall(function ()
					for i,v in ipairs (backpack:GetChildren()) do
						pcall(function () v.Material = "Grass" v.BrickColor = BrickColor.new("Earth green") end)
					end
				end)
			end
		end)
	end

end




player.CharacterAppearanceLoaded:connect(function()
	ENABLEXDD()

end)
ENABLEXDD()
function tweenJoint(Joint, newC0, newC1, Alpha, Duration)
	if Equipped then
		spawn(function()
			local newCode = math.random(-1e9, 1e9) --This creates a random code between -1000000000 and 1000000000
			local tweenIndicator = nil
			if (not Joint:findFirstChild("tweenCode")) then --If the joint isn't being tweened, then
				tweenIndicator = Instance.new("IntValue")
				tweenIndicator.Name = "tweenCode"
				tweenIndicator.Value = newCode
				tweenIndicator.Parent = Joint
			else
				tweenIndicator = Joint.tweenCode
				tweenIndicator.Value = newCode --If the joint is already being tweened, this will change the code, and the tween loop will stop
			end
			if Duration <= 0 then --If the duration is less than or equal to 0 then there's no need for a tweening loop
				if newC0 then Joint.C0 = newC0 end
				if newC1 then Joint.C1 = newC1 end
			else
				local Increment = 1.5 / Duration --Calculate the increment here so it doesn't need to be calculated in the loop
				local startC0 = Joint.C0
				local startC1 = Joint.C1
				local X = 0
				while true do
					wait() --This makes the for loop step every 1/60th of a second
					local newX = X + Increment*2
					X = (newX > 90 and 90 or newX) --Makes sure the X never goes above 90
					if tweenIndicator.Value ~= newCode then break end --This makes sure that another tween wasn't called on the same joint
					if newC0 then Joint.C0 = startC0:lerp(newC0, Alpha(X)) end
					if newC1 then Joint.C1 = startC1:lerp(newC1, Alpha(X)) end
					if X == 90 then break end --If the tweening is done...
				end
			end
			if tweenIndicator.Value == newCode then --If this tween functions was the last one called on a joint then it will remove the code
				tweenIndicator:Destroy()
			end
		end)
	end
end

---------------- [ Tween Module ] --------------------------------------------------------

--[[
	
	tweenJoint Function Parameters:
	
	Object Joint - This has to be a weld with a C0 and C1 property
	
	CFrame newC0 - This is what the new C0 of the weld will be. You can put nil if you don't want to effect the C0
	
	CFrame newC1 - This is what the new C1 of the weld will be. You can put nil if you don't want to effect the C1
	
	function Alpha - This is an alpha function that takes an input parameter of a number between 0 and 90 and returns a number between 0 and 1.
		For example, function(X) return math.sin(math.rad(X)) end
		
	float Duration - This is how long the tweening takes to complete
	
--]]


---------------------- [ Presets ] -------------------------------------------------------------


function Rand(Min, Max, Accuracy)
	if Equipped then
		local Inverse = 1 / (Accuracy or 1)
		return (math.random(Min * Inverse, Max * Inverse) / Inverse)
	end
end


---------------------- [ Functions ] -------------------------------------------------------------
function UpdateGui()
	if Equipped then
		AmmoGui.Enabled = true
		if AmmoGui and UpdateGui then
			AmmoGui.Frame.AmmoText.Text = wepin.Settings.Ammo.Value
			if firemode == 1 then
				AmmoGui.Frame.FireModeText.Text = " [ AUTO ] "	
			end
			if firemode == 2 then
				AmmoGui.Frame.FireModeText.Text = " [ SEMI ] "	
			end
			if firemode == 3 then
				AmmoGui.Frame.FireModeText.Text = " [ BURST ] "	
			end
			if firemode == 4 then
				AmmoGui.Frame.FireModeText.Text = " [ BOLT ] "	
			end
			if firemode == 4 then
				AmmoGui.Frame.FireModeText.Text = " [ PUMP ] "	
			end
		end
	end
end

if firemode == 1 then
	GunSettings.Automatic = true
elseif firemode == 2 then	
	GunSettings.Automatic = false
end

function GetHitSurfaceCFrame(HitPos,Obj)
	if Equipped then
		local SurfaceCF = {
			{"Back",Obj.CFrame * CFrame.new(0,0,Obj.Size.z)};
			{"Bottom",Obj.CFrame * CFrame.new(0,-Obj.Size.y,0)};
			{"Front",Obj.CFrame * CFrame.new(0,0,-Obj.Size.z)};
			{"Left",Obj.CFrame * CFrame.new(-Obj.Size.x,0,0)};
			{"Right",Obj.CFrame * CFrame.new(Obj.Size.x,0,0)};
			{"Top",Obj.CFrame * CFrame.new(0,Obj.Size.y,0)}
		}
		local ClosestDist = math.huge
		local ClosestSurface = nil
		for _,v in ipairs(SurfaceCF) do
			local SurfaceDist = (HitPos - v[2].p).magnitude
			if SurfaceDist < ClosestDist then
				ClosestDist = SurfaceDist
				ClosestSurface = v
			end
		end
		return ClosestSurface[2]
	end
end


function CreateBulletImpact(HitPos, HitObj, HumanoidFound)
	if Equipped then
		local SurfaceCF = GetHitSurfaceCFrame(HitPos, HitObj)
		local SurfaceDir = CFrame.new(HitObj.CFrame.p, SurfaceCF.p)
		local SurfaceDist = SurfaceDir.lookVector * (HitObj.CFrame.p - SurfaceCF.p).magnitude / 2
		local SurfaceOffset = HitPos - SurfaceCF.p + SurfaceDist
		local SurfaceCFrame = SurfaceDir + SurfaceDist + SurfaceOffset
	end
end


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
	pr.Size = Vector3.new(1 * nscale.Value, 1 * nscale.Value, 1 * nscale.Value)
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
function RagDoll(part,direction)
	pcall(function ()
		local h = nil
		for i,v in ipairs (part.Parent:GetChildren()) do
			if v:IsA('Humanoid') then h = v chr = part.Parent end 
		end		pcall(function ()
			nscale = Instance.new("NumberValue")
			nscale.Value = 1
			nscale.Parent = nil
			RightShoulderC0 = CFrame.new(1.5 * nscale.Value, 0.5 * nscale.Value, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
			RightShoulderC1 = CFrame.new(0, 0.5 * nscale.Value, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
			LeftShoulderC0 = CFrame.new(-1.5 * nscale.Value, 0.5 * nscale.Value, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
			LeftShoulderC1 = CFrame.new(0, 0.5 * nscale.Value, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
			RightHipC0 = CFrame.new(0.5 * nscale.Value, -1 * nscale.Value, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
			RightHipC1 = CFrame.new(0, 1 * nscale.Value, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
			LeftHipC0 = CFrame.new(-0.5 * nscale.Value, -1 * nscale.Value, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
			LeftHipC1 = CFrame.new(0 * nscale.Value, 1 * nscale.Value, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
			RootJointC0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)
			RootJointC1 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)
		end)
		pcall(function ()
			NeckC0 = CFrame.new(0, 1 * nscale.Value, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)
			NeckC1 = CFrame.new(0, -0.5 * nscale.Value, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)end)
		tors = chr.Torso 
		pcall(function() rarm = chr["Right Arm"] end)
		pcall(function() larm = chr["Left Arm"] end)
		pcall(function() rleg = chr["Right Leg"] end)
		pcall(function() lleg = chr["Left Leg"] end)
		local human = h
		human.PlatformStand = true
		for i,v in ipairs (h.Parent:GetChildren()) do
			pcall(function() v.Anchored = false end)
		end
		pcall(function ()
			if rarm  then
				tors:FindFirstChild("Right Shoulder"):Destroy()
				makegloo(tors, RightShoulderC0, RightShoulderC1, tors, rarm, "Right Shoulder")
				maketouchy(rarm, rarm, CFrame.new(0, 0.5, 0))
			end end)
		pcall(function ()
			if larm  then
				tors:FindFirstChild("Left Shoulder"):Destroy()
				makegloo(tors, LeftShoulderC0, LeftShoulderC1, tors, larm, "Left Shoulder")
				maketouchy(larm, larm, CFrame.new(0, 0.5, 0))
			end end)
		pcall(function ()
			if rleg then
				tors:FindFirstChild("Right Hip"):Destroy()
				makegloo(tors, RightHipC0, RightHipC1, tors, rleg, "Right Hip")
				maketouchy(rleg, rleg, CFrame.new(0, 0.5, 0))
			end end)
		pcall(function ()
			if lleg then
				tors:FindFirstChild("Left Hip"):Destroy()
				makegloo(tors, LeftHipC0, LeftHipC1, tors, lleg, "Left Hip")
				maketouchy(lleg, lleg, CFrame.new(0, 0.5, 0))
			end end)
		local i = Instance.new("BodyForce")
		i.Force = direction * 3000
		i.Parent = part
		funchson(h.Parent)
		pcall(function ()
			if human then
				if wepin.Settings.Dismember.Value or wepin.Setin.Dismember.Value then
					for i,v in ipairs (part.Parent:GetChildren()) do
						pcall(function() v.BrickColor=BrickColor.new("Maroon")end) end
				end
			end end)
		spawn(function () wait() i:Destroy() end)

	end)
end
funchson = function (p)
	for i,v in ipairs (p:GetChildren()) do
		if v:IsA("Script") or v:IsA("LocalScript") or v:IsA("ModuleScript") then
			v:Destroy()
		end
		funchson(v)
	end
end
-- Create Bullet
function CreateBullet()
	shotgunspread = 25
	gunspred = 1
	if Equipped then
		if wepin.Settings.ShotCount.Value > 1 then
			Spread = CFrame.Angles(math.rad(math.random(-shotgunspread, shotgunspread)/10), math.rad(math.random(-shotgunspread, shotgunspread)/10), math.rad(math.random(-shotgunspread, shotgunspread)/10))
		else
			Spread = CFrame.Angles(math.rad(math.random(-gunspred, gunspred)/10), math.rad(math.random(-gunspred, gunspred)/10), math.rad(math.random(-gunspred, gunspred)/10))
		end
		local Origin = wepin.FirePart.Position
		local Direction = (wepin.FirePart.CFrame*Spread).lookVector
		local BulletCF = CFrame.new(Origin, Origin + Direction)	
		local Bullet = Instance.new("Part", workspace)
		Debris:AddItem(Bullet, 3)
		Bullet.Shape = Enum.PartType.Ball
		Bullet.Size = Vector3.new(0.2, 0.2, 0.2)
		Bullet.TopSurface = "Smooth"
		Bullet.BottomSurface = "Smooth"
		Bullet.BrickColor = BrickColor.new("Bright yellow")
		Bullet.Material = "Neon"
		Bullet.CanCollide = false
		Bullet.CFrame = wepin.FirePart.CFrame + (wepin.Handle.CFrame.p - wepin.Handle.CFrame.p)
		Bullet.CFrame = CFrame.new(wepin.FirePart.CFrame.p, wepin.FirePart.CFrame.p + wepin.Handle.CFrame.lookVector)
		local BM = Instance.new("SpecialMesh", Bullet)
		BM.MeshType = "Brick"
		BM.Scale = Vector3.new(0.5,0.5,15)
		local BulletMass = Bullet.Size.X * Bullet.Size.Y * Bullet.Size.Z
		local BF = Instance.new("BodyForce")
		BF.force = Vector3.new(0, BulletMass * (196.2 - wepin.Settings.Drop.Value), 0)
		BF.Parent = Bullet
		Bullet.Velocity = Direction * 4000
		Bullet.CFrame = BulletCF + Direction
		return Bullet
	end
end


local IsGlass = Hit and (Hit.Name == "Glass" or Hit.Name == "Window")
local list = {}
local storage = {}
local fragmentable = workspace
local fillup = 1000 --it constantly generates new parts until it reaches this number(hacky way to prevent lagspikes if there is a large explosion),change it to 0 if you don´t want it to generate (useless) parts.
local maximumstorage = 2000 --it will recycle parts if the number of parts in the storage doesnt exceed this number
local storage_Position = Vector3.new(0,0,500000) --place them somewhere off the map
local stored_partsize = Vector3.new(1,1,1) --make them small
local parts_created_per_frame = 5 --number of parts being created per frame to fill up the storage
local minimumsize = Vector3.new(0.7,0.7,0.7) --Minimumsize for a part to get divided,higher numbers = less detailed and bigger/less bricks
local surface_between_splitted_parts = 'SmoothNoOutlines' --the surface between splitted parts
local function fragmentate(cframe,size,color,explosion_Position,explosion_blastradius,backsurface,bottomsurface,frontsurface,leftsurface,rightsurface,topsurface,transparency,reflectance)
	local xi = size.X >= minimumsize.X*(1+explosion_blastradius/16) and 2 or 1 --to reduce the lagg in large explosions we increase minimumsize based on the explosionradius...
	local yi = size.Y >= minimumsize.Y*(1+explosion_blastradius/16) and 2 or 1
	local zi = size.Z >= minimumsize.Z*(1+explosion_blastradius/16) and 2 or 1
	if xi == 1 and yi == 1 and zi == 1 or (cframe.p-explosion_Position).magnitude > size.magnitude/2 + explosion_blastradius then --don´t fragmentate parts, that are too small to fragmentate or too far away from the explosion
		if xi == 1 and yi == 1 and zi == 1 then return end --optional
		if #storage > 0 then
			local p = storage[1]
			p.BrickColor = color
			p.Size = size
			p.BackSurface = backsurface
			p.BottomSurface = bottomsurface
			p.FrontSurface = frontsurface
			p.LeftSurface = leftsurface
			p.RightSurface = rightsurface
			p.TopSurface = topsurface
			p.Transparency = transparency
			p.CFrame = cframe
			p.Reflectance = reflectance
			table.remove(storage,1)
		else
			local p = Instance.new("Part",fragmentable)
			p.BrickColor = color
			p.FormFactor = "Custom"
			p.Size = size
			p.BackSurface = backsurface
			p.BottomSurface = bottomsurface
			p.FrontSurface = frontsurface
			p.LeftSurface = leftsurface
			p.RightSurface = rightsurface
			p.TopSurface = topsurface
			p.Transparency = transparency
			if p.Transparency>0.285 then
				p.Anchored = false
			else
				p.Anchored=true
			end
			p.CFrame = cframe
			p.Reflectance = reflectance
		end
		--p:MakeJoints()
		--		m.Text = m.Text+1
		return --stop the function
	end
	local mody = math.random(-125,125)/1000 --some randomization
	for y = 1,yi do
		if math.random()> 0.5 then
			local modx = math.random(-125,125)/1000
			for x = 1,xi do
				local modz = math.random(-125,125)/1000
				for z = 1,zi do --offset = x/xi-0.75+modx)
					fragmentate(cframe*CFrame.new(size.X*(xi==1 and 0 or x/xi-0.75+modx),size.Y*(yi==1 and 0 or y/yi-0.75+mody),size.Z*(zi==1 and 0 or z/zi-0.75+modz)),Vector3.new(xi == 2 and size.X*(1-2*math.abs(x/xi-0.75+modx)) or size.X,yi == 2 and size.Y*(1-2*math.abs(y/yi-0.75+mody)) or size.Y,zi == 2 and size.Z*(1-2*math.abs(z/zi-0.75+modz)) or size.Z or agent767_was_here),color,explosion_Position,explosion_blastradius,z~=zi and surface_between_splitted_parts or backsurface,y==2 and surface_between_splitted_parts or bottomsurface,z==2 and surface_between_splitted_parts or frontsurface,x==2 and surface_between_splitted_parts or leftsurface,x~=xi and surface_between_splitted_parts or rightsurface,y~=yi and surface_between_splitted_parts or topsurface,transparency,reflectance) 
				end
			end
		else
			local modz = math.random(-125,125)/1000
			for z = 1,zi do
				local modx = math.random(-125,125)/1000
				for x = 1,xi do
					fragmentate(cframe*CFrame.new(size.X*(xi==1 and 0 or x/xi-0.75+modx),size.Y*(yi==1 and 0 or y/yi-0.75+mody),size.Z*(zi==1 and 0 or z/zi-0.75+modz)),Vector3.new(xi == 2 and size.X*(1-2*math.abs(x/xi-0.75+modx)) or size.X,yi == 2 and size.Y*(1-2*math.abs(y/yi-0.75+mody)) or size.Y,zi == 2 and size.Z*(1-2*math.abs(z/zi-0.75+modz)) or size.Z),color,explosion_Position,explosion_blastradius,z~=zi and surface_between_splitted_parts or backsurface,y==2 and surface_between_splitted_parts or bottomsurface,z==2 and surface_between_splitted_parts or frontsurface,x==2 and surface_between_splitted_parts or leftsurface,x~=xi and surface_between_splitted_parts or rightsurface,y~=yi and surface_between_splitted_parts or topsurface,transparency,reflectance)
				end
			end
		end
	end				
end

local function start_fragmentation_anchor(Position,radius)
	local search = Region3.new(Position-Vector3.new(radius,radius,radius)*1.1,Position+Vector3.new(radius,radius,radius)*1.1)
	repeat
		local finish = false
		local parts = workspace:FindPartsInRegion3WithIgnoreList(search,list,100) --maximum number of parts that FindPartsInRegion3 can find is 100, so we have to do this to find them all
		for i = 1,#parts do
			table.insert(list,1,parts[i])
		end
		finish = true
	until #parts < 100 and finish
	print(#list)
	local t = tick()
	for i = 1,#list do
		local p = list[i]
		if p:IsDescendantOf(fragmentable) and p:GetMass()<3000 and p.Transparency>0.285 and p.Name~='Base' then
			fragmentate(p.CFrame,p.Size,p.BrickColor,Position,radius,p.BackSurface,p.BottomSurface,p.FrontSurface,p.LeftSurface,p.RightSurface,p.TopSurface,p.Transparency,p.Reflectance)
			if #storage < maximumstorage then --recycle them
				p.FormFactor = "Custom"
				p.Size = stored_partsize
				p.Position = storage_Position
				table.insert(storage,1,p)
			else --storage is full
				p:Destroy()
			end
			--			m.Text = m.Text-1
		end
		if p:IsDescendantOf(fragmentable) and p:GetMass()<53000 and p.Transparency<0.05 and p.Name~='Base' then
			fragmentate(p.CFrame,p.Size,p.BrickColor,Position,radius,p.BackSurface,p.BottomSurface,p.FrontSurface,p.LeftSurface,p.RightSurface,p.TopSurface,p.Transparency,p.Reflectance)
			if #storage < maximumstorage then --recycle them
				p.Anchored = true
				p.FormFactor = "Custom"
				p.Size = stored_partsize
				p.Position = storage_Position
				table.insert(storage,1,p)
			else --storage is full
				p:Destroy()
			end
			--			m.Text = m.Text-1
		end
	end	
	list = {}
	--	print(tick()-t)
end
local function start_fragmentation(Position,radius)
	local search = Region3.new(Position-Vector3.new(radius,radius,radius)*1.1,Position+Vector3.new(radius,radius,radius)*1.1)
	repeat
		local finish = false
		local parts = workspace:FindPartsInRegion3WithIgnoreList(search,list,100) --maximum number of parts that FindPartsInRegion3 can find is 100, so we have to do this to find them all
		for i = 1,#parts do
			table.insert(list,1,parts[i])
		end
		finish = true
	until #parts < 100 and finish
	print(#list)
	local t = tick()
	for i = 1,#list do
		local p = list[i]
		if p:IsDescendantOf(fragmentable) and p:GetMass()<3000 and p.Transparency>0.285 and p.Name~='Base' then
			fragmentate(p.CFrame,p.Size,p.BrickColor,Position,radius,p.BackSurface,p.BottomSurface,p.FrontSurface,p.LeftSurface,p.RightSurface,p.TopSurface,p.Transparency,p.Reflectance)
			if #storage < maximumstorage and p.Shape == "Block" then --recycle them
				p.Anchored = false
				p.FormFactor = "Custom"
				p.Size = stored_partsize
				p.Position = storage_Position
				table.insert(storage,1,p)
			else --storage is full
				p:Destroy()
			end
			--			m.Text = m.Text-1
		end
		if p:IsDescendantOf(fragmentable) and p:GetMass()<53000 and p.Transparency<0.05 and p.Name~='Base' then
			fragmentate(p.CFrame,p.Size,p.BrickColor,Position,radius,p.BackSurface,p.BottomSurface,p.FrontSurface,p.LeftSurface,p.RightSurface,p.TopSurface,p.Transparency,p.Reflectance)
			if #storage < maximumstorage and p.Shape == "Block" then --recycle them
				p.Anchored = true
				p.FormFactor = "Custom"
				p.Size = stored_partsize
				p.Position = storage_Position
				table.insert(storage,1,p)
			else --storage is full
				p:Destroy()
			end
			--			m.Text = m.Text-1
		end
	end	
	list = {}
	--	print(tick()-t)
end

function Blow(Hit)
	if Hit.Name == "Head" then
		Hit.BrickColor = BrickColor.new("Maroon")
		o1 = Instance.new("Sound")
		o1.Parent = Hit
		o1.SoundId = "rbxassetid://429400881"
		o1:Play()
	end
	if Hit.Name == "Right Arm" then
		for i=1,4 do
			o11.Name = "GOREPART"
			o11.Parent = workspace
			o11.BrickColor = BrickColor.new("Maroon")
			o11.Position = Hit.Position
			o11.Rotation = Vector3.new(-180, 1.29089606, 180)
			o11.FormFactor = Enum.FormFactor.Symmetric
			o11.Size = Vector3.new(.5, .5, .5)
			o11.BackSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.RightSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.TopSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.Color = Color3.new(0.458824, 0, 0)
		end
		Hit:Destroy()
		o1 = Instance.new("Sound")
		o1.Parent = o11
		o1.SoundId = "rbxassetid://429400881"
		o1:Play()

	end
	if Hit.Name == "Left Arm" then
		for i=1,4 do
			o11 = Instance.new("Part")
			o11.Name = "GOREPART"
			o11.Parent = workspace
			o11.BrickColor = BrickColor.new("Maroon")
			o11.Position = Hit.Position
			o11.Rotation = Vector3.new(-180, 1.29089606, 180)
			o11.FormFactor = Enum.FormFactor.Symmetric
			o11.Size = Vector3.new(.5,.5,.5)
			o11.BackSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.RightSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.TopSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.Color = Color3.new(0.458824, 0, 0)
			Hit:Destroy()
		end
		o1 = Instance.new("Sound")
		o1.Parent = o11
		o1.SoundId = "rbxassetid://429400881"
		o1:Play()

	end
	if Hit.Name == "Right Leg" then
		for i=1,4 do
			o11 = Instance.new("Part")
			o11.Name = "GOREPART"
			o11.Parent = workspace
			o11.BrickColor = BrickColor.new("Maroon")
			o11.Position = Hit.Position
			o11.Rotation = Vector3.new(-180, 1.29089606, 180)
			o11.FormFactor = Enum.FormFactor.Symmetric
			o11.Size = Vector3.new(.5,.5,.5)
			o11.BackSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.RightSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.TopSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.Color = Color3.new(0.458824, 0, 0)
		end
		Hit:Destroy()
		o1 = Instance.new("Sound")
		o1.Parent = o11
		o1.SoundId = "rbxassetid://429400881"
		o1:Play()

	end
	if Hit.Name == "Left Arm" then
		for i=1,4 do
			o11 = Instance.new("Part")
			o11 = Instance.new("Part")
			o11.Name = "GOREPART"
			o11.Parent = workspace
			o11.BrickColor = BrickColor.new("Maroon")
			o11.Position = Hit.Position
			o11.Rotation = Vector3.new(-180, 1.29089606, 180)
			o11.FormFactor = Enum.FormFactor.Symmetric
			o11.Size = Vector3.new(.5,.5,.5)
			o11.BackSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.RightSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.TopSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.Color = Color3.new(0.458824, 0, 0)
		end
		Hit:Destroy()
		o1 = Instance.new("Sound")
		o1.Parent = o11
		o1.SoundId = "rbxassetid://429400881"
		o1:Play()

	end

	if Hit.Name == "Left Leg" then
		for i=1,4 do
			o11 = Instance.new("Part")
			o11 = Instance.new("Part")
			o11.Name = "GOREPART"
			o11.Parent = workspace
			o11.BrickColor = BrickColor.new("Maroon")
			o11.Position = Hit.Position
			o11.Rotation = Vector3.new(-180, 1.29089606, 180)
			o11.FormFactor = Enum.FormFactor.Symmetric
			o11.Size = Vector3.new(.5,.5,.5)
			o11.BackSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.RightSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.TopSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.Color = Color3.new(0.458824, 0, 0)
		end
		Hit:Destroy()
		o1 = Instance.new("Sound")
		o1.Parent = o11
		o1.SoundId = "rbxassetid://429400881"
		o1:Play()

	end
	if Hit.Name == "Left Arm" then
		for i=1,4 do
			o11 = Instance.new("Part")
			o11 = Instance.new("Part")
			o11.Name = "GOREPART"
			o11.Parent = workspace
			o11.BrickColor = BrickColor.new("Maroon")
			o11.Position = Hit.Position
			o11.Rotation = Vector3.new(-180, 1.29089606, 180)
			o11.FormFactor = Enum.FormFactor.Symmetric
			o11.Size = Vector3.new(.5,.5,.5)
			o11.BackSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.RightSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.TopSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.Color = Color3.new(0.458824, 0, 0)
		end
		Hit:Destroy()
		o1 = Instance.new("Sound")
		o1.Parent = o11
		o1.SoundId = "rbxassetid://429400881"
		o1:Play()

	end
	if Hit.Name == "Torso" then
		for i=1,8 do
			o11 = Instance.new("Part")
			o11 = Instance.new("Part")
			o11.Name = "GOREPART"
			o11.Parent = workspace
			o11.BrickColor = BrickColor.new("Maroon")
			o11.Position = Hit.Position
			o11.Rotation = Vector3.new(-180, 1.29089606, 180)
			o11.FormFactor = Enum.FormFactor.Symmetric
			o11.Size = Vector3.new(.5,.5,.5)
			o11.BackSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.RightSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.TopSurface = Enum.SurfaceType.SmoothNoOutlines
			o11.Color = Color3.new(0.458824, 0, 0)
		end

		Hit:Destroy()
		o1 = Instance.new("Sound")
		o1.Parent = o11
		o1.SoundId = "rbxassetid://429400881"
		o1:Play()

	end
end
canfire = true

local function start_fragmentation_person(Position,radius)
	Hit.BrickColor = BrickColor.new("Maroon")
	o1 = Instance.new("Sound")
	o1.Parent = Hit.Parent
	o1.SoundId = "rbxassetid://429400881"
	o1:Play()
	Hit.Anchored = false
	local search = Region3.new(Position-Vector3.new(radius,radius,radius)*1.1,Position+Vector3.new(radius,radius,radius)*1.1)
	repeat
		local finish = false
		local parts = workspace:FindPartsInRegion3WithIgnoreList(search,list,100) --maximum number of parts that FindPartsInRegion3 can find is 100, so we have to do this to find them all
		for i = 1,#parts do
			table.insert(list,1,parts[i])
		end
		finish = true
	until #parts < 100 and finish
	print(#list)
	local t = tick()
	for i = 1,#list do
		local p = list[i]
		if p:IsDescendantOf(fragmentable) and p:GetMass()<3000 and p.Transparency>0.285 and p.Name~='Base' then
			fragmentate(p.CFrame,p.Size,BrickColor.new("Maroon"),Position,radius,p.BackSurface,p.BottomSurface,p.FrontSurface,p.LeftSurface,p.RightSurface,p.TopSurface,p.Transparency,p.Reflectance)
			if #storage < maximumstorage and p.Shape == "Block" then --recycle them
				p.FormFactor = "Custom"
				p.Anchored = false
				p.BrickColor = BrickColor.new("Maroon")
				p.Size = stored_partsize
				p.Position = storage_Position
				table.insert(storage,1,p)
			else --storage is full
				p:Destroy()
			end
			--			m.Text = m.Text-1
		end
		if p:IsDescendantOf(fragmentable) and p:GetMass()<53000 and p.Transparency<0.05 and p.Name~='Base' then
			fragmentate(p.CFrame,p.Size,BrickColor.new("Maroon"),Position,radius,p.BackSurface,p.BottomSurface,p.FrontSurface,p.LeftSurface,p.RightSurface,p.TopSurface,p.Transparency,p.Reflectance)
			if #storage < maximumstorage and p.Shape == "Block" then --recycle them
				p.Anchored = true
				p.Anchored = false
				p.BrickColor = BrickColor.new("Maroon")
				p.FormFactor = "Custom"
				p.Size = stored_partsize
				p.Position = storage_Position
				table.insert(storage,1,p)
			else --storage is full
				p:Destroy()
			end
			--			m.Text = m.Text-1
		end
	end	
	list = {}
	--	print(tick()-t)
end
function Shoot()
	Ammo = GunSettings.Ammo
	StorageAmmo = GunSettings.StoredAmmo


	Handle = wepin:WaitForChild("Handle")
	Mag = wepin:WaitForChild("Mag")
	FirePart = wepin:WaitForChild("FirePart")
	if canfire == true then
		if workspace:FindFirstChild("BulletRemains") ~= nil then else
			kekes = Instance.new("Model")
			kekes.Name = "BulletRemains"
			kekes.Parent = workspace
		end
		if Equipped then
			wepin.Settings.Ammo.Value = wepin.Settings.Ammo.Value - 1
			local xd = wepin.Handle.Fire:Clone()
			xd.Parent = wepin.Handle
			xd:Play()
			pcall(function ()
				local xd = wepin.Handle.Fire2:Clone()
				xd.Parent = wepin.Handle
				xd:Play()
			end)pcall(function ()
				local xd = wepin.Handle.Fire1:Clone()
				xd.Parent = wepin.Handle
				xd:Play()
			end)
			if firemode ~= 4 and firemode ~= 5 then
				spawn(function () pcall(function () wepin.BoltBack.Transparency = 0 wepin.Bolt.Transparency = 1 wait(.01) wepin.BoltBack.Transparency = 1 wepin.Bolt.Transparency = 0 end) end)
				spawn(function () wait()local shell = Instance.new("Part")
					shell.CFrame =  wepin.Bullet.CFrame * CFrame.fromEulerAnglesXYZ(2.5,1,1.25)
					shell.Size = Vector3.new(1,1,1)
					shell.Reflectance = 0
					shell.CanCollide = false
					shell.BottomSurface = 0
					shell.TopSurface = 0
					shell.Name = "Shell"
					shell.Velocity = (wepin.Bullet.CFrame*CFrame.Angles(math.rad(0),math.rad(180),math.rad(0))).lookVector * 30 + Vector3.new(math.random(0,0),10,math.random(0,0))
					shell.RotVelocity = Vector3.new(-10,40,30)
					local shellmesh = Instance.new("CylinderMesh")
					if wepin.Settings.RifleOrPistol.Value ~= "pistol" and wepin.Settings.ShotCount.Value == 1 then
						shellmesh.Scale = Vector3.new(.05,.2,.05)
						shell.BrickColor = BrickColor.new(24)
					elseif wepin.Settings.ShotCount.Value > 1  then
						shellmesh.Scale = Vector3.new(.15,.35,.15)
						shell.BrickColor = BrickColor.new("Really red")
					else
						shellmesh.Scale = Vector3.new(.05,.15,.05)
						shell.BrickColor = BrickColor.new(24)
					end
					shellmesh.Parent = shell
					shell.Parent = wepin
					game:GetService("Debris"):addItem(shell,0.25)
				end)			
			elseif firemode == 5 then
				spawn(function ()
					pcall(function()
						canfire = false 	
						wait(.3)	
						tweenJoint(LAW,  nil , GunSettings.LeftPos-Vector3.new(0,1,0), function(X) return math.sin(math.rad(X)) end, 0.25)
						wepin.BoltBack.Transparency = 0 wepin.Bolt.Transparency = 1
						wepin.Handle.M1:Play()	
						spawn(function () wait()local shell = Instance.new("Part")
							shell.CFrame =  wepin.Bullet.CFrame * CFrame.fromEulerAnglesXYZ(2.5,1,1.25)
							shell.Size = Vector3.new(1,1,1)
							shell.Reflectance = 0
							shell.CanCollide = false
							shell.BottomSurface = 0
							shell.TopSurface = 0
							shell.Name = "Shell"
							shell.Velocity = (wepin.Bullet.CFrame*CFrame.Angles(math.rad(0),math.rad(180),math.rad(0))).lookVector * 30 + Vector3.new(math.random(0,0),10,math.random(0,0))
							shell.RotVelocity = Vector3.new(-10,40,30)
							local shellmesh = Instance.new("CylinderMesh")
							if wepin.Settings.RifleOrPistol.Value ~= "pistol" and wepin.Settings.ShotCount.Value == 1 then
								shellmesh.Scale = Vector3.new(.05,.2,.05)
								shell.BrickColor = BrickColor.new(24)
							elseif wepin.Settings.ShotCount.Value > 1  then
								shellmesh.Scale = Vector3.new(.15,.35,.15)
								shell.BrickColor = BrickColor.new("Really red")
							else
								shellmesh.Scale = Vector3.new(.05,.15,.05)
								shell.BrickColor = BrickColor.new(24)
							end
							shellmesh.Parent = shell
							shell.Parent = wepin
							game:GetService("Debris"):addItem(shell,0.25)
						end)	
						wait(.2)			
						tweenJoint(LAW,  nil , GunSettings.LeftPos, function(X) return math.sin(math.rad(X)) end, 0.25)
						wepin.BoltBack.Transparency = 1 wepin.Bolt.Transparency = 0
						wepin.Handle.M2:Play()		
						wait(.2)	
						canfire = true				
						--[[PLAY STUFF]] end)	end)
			elseif firemode == 4 then
				spawn(function ()
					pcall(function()
						Aiming = false	
						----tweenFoV(70, 60)
						canfire = false 
						tweenJoint(LAW,  nil, CFrame.new(0, 0, 0, 0.56116122, -0.730850101, 0.388530731, -0.649711668, -0.0981186926, 0.75382185, -0.512808681, -0.675448656, -0.529902339), function(X) return math.sin(math.rad(X)) end, 0.3)
						wait(.2)
						wepin.BoltBack.Transparency = 0 wepin.Bolt.Transparency = 1
						wepin.Handle.M1:Play()					
						tweenJoint(LAW,  nil, CFrame.new(0, -1, 0, 0.56116122, -0.730850101, 0.388530731, -0.649711668, -0.0981186926, 0.75382185, -0.512808681, -0.675448656, -0.529902339), function(X) return math.sin(math.rad(X)) end, 0.3)
						spawn(function () wait()local shell = Instance.new("Part")
							shell.CFrame =  wepin.Bullet.CFrame * CFrame.fromEulerAnglesXYZ(2.5,1,1.25)
							shell.Size = Vector3.new(1,1,1)
							shell.Reflectance = 0
							shell.CanCollide = false
							shell.BottomSurface = 0
							shell.TopSurface = 0
							shell.Name = "Shell"
							shell.Velocity = (wepin.Bullet.CFrame*CFrame.Angles(math.rad(0),math.rad(180),math.rad(0))).lookVector * 30 + Vector3.new(math.random(0,0),10,math.random(0,0))
							shell.RotVelocity = Vector3.new(-10,40,30)
							local shellmesh = Instance.new("CylinderMesh")
							shellmesh.Scale = Vector3.new(.2,.6,.2)
							shell.BrickColor = BrickColor.new(24)
							shellmesh.Parent = shell
							shell.Parent = wepin
							game:GetService("Debris"):addItem(shell,0.25)
						end)						
						wait(.2)
						wepin.BoltBack.Transparency = 1 wepin.Bolt.Transparency = 0
						wepin.Handle.M2:Play()					
						tweenJoint(LAW,  nil, CFrame.new(0, 0, 0, 0.56116122, -0.730850101, 0.388530731, -0.649711668, -0.0981186926, 0.75382185, -0.512808681, -0.675448656, -0.529902339), function(X) return math.sin(math.rad(X)) end, 0.3)
						wait(.2)	
						canfire = true		
						Aiming = false	
						----tweenFoV(70, 60)		
						IdleAnim()	
						--[[PLAY STUFF]] end)	
				end)

			end
			spawn(function ()
				if Aiming then
					tweenJoint(LAW,  nil , GunSettings.LeftAimPos-Vector3.new(0,.3*wepin.Settings.Recoil.Value,0), function(X) return math.sin(math.rad(X)) end, 0)
					tweenJoint(RAW,  nil, RAW.C1 *  CFrame.new(-wepin.AimPart.CFrame:toObjectSpace(char.Head.CFrame).p)-Vector3.new(0,.3*wepin.Settings.Recoil.Value,0), function(X) return math.sin(math.rad(X)) end, 0)
				else
					tweenJoint(LAW,  nil , GunSettings.LeftPos-Vector3.new(0,.3*wepin.Settings.Recoil.Value,0), function(X) return math.sin(math.rad(X)) end, 0) 
					tweenJoint(RAW,  nil , GunSettings.RightPos-Vector3.new(0,.3*wepin.Settings.Recoil.Value,0), function(X) return math.sin(math.rad(X)) end, 0)
				end	
				if Aiming then
					tweenJoint(LAW,  nil , GunSettings.LeftAimPos, function(X) return math.sin(math.rad(X)) end, 0.1/(wepin.Settings.Recoil.Value))
					tweenJoint(RAW,  nil, RAW.C1 *  CFrame.new(-wepin.AimPart.CFrame:toObjectSpace(char.Head.CFrame).p), function(X) return math.sin(math.rad(X)) end, 0.1/(wepin.Settings.Recoil.Value))
				else
					tweenJoint(LAW,  nil , GunSettings.LeftPos, function(X) return math.sin(math.rad(X)) end, 0.1/(wepin.Settings.Recoil.Value)) 
					tweenJoint(RAW,  nil , GunSettings.RightPos, function(X) return math.sin(math.rad(X)) end, 0.1/(wepin.Settings.Recoil.Value))
				end
			end)
		end


		for i=1,wepin.Settings.ShotCount.Value do spawn(function()
				----PASTE THIS




				Hit, Pos = workspace:FindPartOnRay(Ray.new(wepin.AimPart.Position, wepin.AimPart.CFrame.lookVector * 1100),char)
				if wepin.Settings.ShotCount.Value > 1 then
					local XEF = 1
					local diven = 1
					Hit, Pos = workspace:FindPartOnRay(Ray.new(wepin.FirePart.Position+Vector3.new(math.random(-XEF,XEF)/diven,math.random(-XEF,XEF)/diven,math.random(-XEF,XEF)/diven), wepin.FirePart.CFrame.lookVector * 1100),char)
				end




				spawn(function()

					CreateBullet()
				end)		
				-- Hit Handling
				spawn(function ()
					makeglasssound = false
					pcall(function()if Hit.Transparency>0.285 and Hit.Transparency<0.9 and Hit:GetMass()<3000 then
							start_fragmentation(Pos,.25) 
							makeglasssound = true
						end end)
				end)
				if Hit then
					pcall(function ()
						if Hit.Parent:IsA("Hat") or Hit.Parent:IsA("Accessory") then
							Hit = Hit.Parent.Parent.Head
						end
						if Hit.Parent:FindFirstChild("Humanoid") then
							Hit.BrickColor = BrickColor.new("Maroon")
						end
						local Crack= Instance.new("Part", workspace.BulletRemains)
						Crack.FormFactor = "Custom"
						Crack.TopSurface = 0
						Crack.BottomSurface = 0
						Crack.Transparency = 1
						Crack.Anchored = true
						Crack.CanCollide = false
						Crack.Size = Vector3.new()
						Crack.CFrame = CFrame.new(Pos) * CFrame.Angles(math.random(math.rad(360)),math.random(math.rad(360)),math.random(math.rad(360)))
						Crack.BrickColor = BrickColor.new("Really black")
						Crack.Material = "SmoothPlastic"	

						local Cur = Instance.new("SpecialMesh")
						Cur.MeshType = "Sphere"
						Cur.Parent = Crack
						Cur.Scale = Vector3.new(0.5,0.5,0.5)
						Instance.new("Smoke", Crack).Opacity = 15
						local g = Instance.new("PointLight", Crack)
						g.Color = Color3.new(0, 0, 0)
						g.Range = 0
						g.Shadows = true
						local PE = Instance.new("ParticleEmitter")
						PE.Parent = Crack
						PE.Size = NumberSequence.new(0.75)
						PE.LightEmission = 0
						PE.Lifetime = NumberRange.new(5)
						PE.ZOffset = 0.5
						PE.Texture = "http://www.roblox.com/asset/?id=33065999"
						PE.Rate = 50
						PE.Speed = NumberRange.new(2.5)
						PE.VelocitySpread = NumberSequence.new(-0.05)
						PE.Transparency = NumberSequence.new(-1)
						ecksdee = Instance.new("Part")
						ecksdee.Size = Vector3.new(.2,.2,.2)
						ecksdee.CFrame = CFrame.new(Pos)
						ecksdee.BrickColor = BrickColor.new("Really black")
						ecksdee.BackSurface = Enum.SurfaceType.SmoothNoOutlines
						ecksdee.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
						ecksdee.TopSurface = Enum.SurfaceType.SmoothNoOutlines
						ecksdee.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
						ecksdee.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
						ecksdee.RightSurface = Enum.SurfaceType.SmoothNoOutlines
						ecksdee.Anchored = Hit.Anchored
						ecksdee.Parent = workspace
						Debris:AddItem(Crack, 0.35)
						Debris:AddItem(PE, 0.15)
						local Meta = Instance.new("Sound")
						Meta.Name = "Crack"
						Meta.Volume = math.random(0.9,1)
						Meta.Pitch = math.random(0.6,0.6)
						Meta.Parent = ecksdee
						pcall(function()
							pcall(function  ()spawn(function ()
									local W = Instance.new("Weld")
									W.Part0 = Hit
									W.Part1 = ecksdee
									local CJ = CFrame.new(Hit.Position)
									local C0 = Hit.CFrame:inverse()*CJ
									local C1 = ecksdee.CFrame:inverse()*CJ
									W.C0 = C0
									W.C1 = C1
									W.Parent = Hit
									spawn(function()
											if Hit and Hit.Parent and Hit.Parent:FindFirstChild("Humanoid") then
												local CJ = CFrame.new(Hit.Position)
												local C0 = Hit.CFrame:inverse()*CJ
												local C1 = ecksdee.CFrame:inverse()*CJ
												local function reweld ()
													local W = Instance.new("Weld")
													W.Part0 = Hit
													W.Part1 = ecksdee
													W.C0 = C0
													W.C1 = C1
													W.Parent = Hit
												end
												for i=1,100 do
													wait()reweld()
													wait()reweld()
													wait()reweld()
													wait()reweld()
												end
											end
										end)
									end)
								end)
						end)
						Meta.Volume = 2
						spawn(function ()
							if Hit.Material == Enum.Material.Metal then
								local methdotrendem = math.random(0,2)
								if methdotrendem == 0 then
									Meta.SoundId = "rbxassetid://871704297"
								elseif methdotrendem == 1 then
									Meta.SoundId = "rbxassetid://871704259"
								elseif methdotrendem == 2 then
									Meta.SoundId = "rbxassetid://871704182"
								end
								Meta:play()
							elseif Hit.Material == Enum.Material.Concrete then
								Meta.Volume = 4
								local methdotrendem = math.random(0,2)
								if methdotrendem == 0 then
									Meta.SoundId = "rbxassetid://871709708"
									Meta.TimePosition =.2
								elseif methdotrendem == 1 then
									Meta.SoundId = "rbxassetid://871709643"
									Meta.TimePosition =.1
								elseif methdotrendem == 2 then
									Meta.SoundId = "rbxassetid://871701134"
								end
								Meta.Playing = true
							elseif Hit.Material == Enum.Material.Wood or  Hit.Material == Enum.Material.WoodPlanks then
								local methdotrendem = math.random(0,2)
								if methdotrendem == 0 then
									Meta.SoundId = "rbxassetid://871705237"
									Meta.TimePosition =.05
								elseif methdotrendem == 1 then
									Meta.SoundId = "rbxassetid://871705174"
									Meta.TimePosition =.2
								elseif methdotrendem == 2 then
									Meta.SoundId = "rbxassetid://871705264"
									Meta.TimePosition =.1
								end
								Meta.Playing = true

								--rbxassetid://871705237
							elseif makeglasssound then
								Meta.SoundId = "rbxassetid://516789356"
								Meta:play()
							elseif Hit.Parent ~= nil then
								if Hit.Parent:FindFirstChild("Humanoid") ~= nil then
									local picc = math.random(8,12)
									Meta.PlaybackSpeed = picc/10
									Meta.SoundId = "rbxassetid://871709832"
									Meta.Playing = true
									Meta.TimePosition =.1
								end
							else
								Meta.Playing = true
								Meta.TimePosition =.6
								Meta.SoundId = "rbxassetid://178711774"
								--rbxassetid://
							end
						end)
						Debris:AddItem(ecksdee,5)
					end)
				end



				pcall(function()
					if Hit and ((Hit.Name ~= "Head" and Hit.Transparency >= .9) or Hit.CanCollide == false or Hit.Name == "Ignore" or Hit.Name == "Foliage" or (Hit.Parent and Hit.Parent:IsA("Tool") and not Hit:FindFirstChild("Bulletproof")) or (Hit.Parent and Hit.Parent:IsA("Hat")) or IsGlass) then
						if IsGlass then
							Debris:AddItem(Hit, 0.1)
						end
					end
				end)

				pcall(function()RagDoll(Hit,wepin.AimPart.CFrame.lookVector)end)
				if wepin.Settings.Dismember.Value then
					pcall(function ()	
						if Hit.Parent:FindFirstChild("Humanoid") then
							ex = Instance.new("Explosion")
							ex.Position = Pos
							ex.Parent = workspace
							ex.BlastRadius = Hit.Size.Magnitude/2
							ex.BlastPressure = 100000
							ex.Visible = false
							ex.Hit:Connect(function(Part)
								Part.Anchored = false
								Part:BreakJoints()
							end)
						end
					end)
				end

				pcall(function ()if Hit.Parent:FindFirstChild("Humanoid") and wepin.Settings.Dismember.Value == true then
						Hit.BrickColor = BrickColor.new("Maroon")
						for i,v in ipairs (Hit.Parent:GetChildren()) do
							pcall(function ()v.BrickColor= BrickColor.new("Maroon")end)
						end
						start_fragmentation_person(Pos,.1) 
					else
					end end)
			end)
		end
		for _, v in ipairs(wepin.FirePart:GetChildren()) do
			if v.Name:sub(1, 7) == "FlashFX" then
				v.Enabled = true
			end
		end
	end
	delay(1 / 30, function()
		for _, v in ipairs(wepin.FirePart:GetChildren()) do
			if v.Name:sub(1, 7) == "FlashFX" then
				v.Enabled = false
			end
		end
	end)
	delay(0,function()
		Recoil = math.rad(GunSettings.Recoil * Rand(1, 1.5, 0.1))--(GunSettings.Recoil*math.random(1,4))
		Recoilup = Recoil
		--cam.CoordinateFrame = CFrame.new(cam.Focus.p) * (cam.CoordinateFrame - cam.CoordinateFrame.p) * CFrame.Angles(Recoil,  Recoil*math.random(-1,1), 0) * CFrame.new(0, 0, (cam.Focus.p - cam.CoordinateFrame.p).magnitude)


		for i = Recoil, Recoil*Recoil do
			Recoilup = Recoilup * Recoil * math.random(-i,i)

		end
	end)

	delay(0, function()
		Recoilup = 0
	end)
	UpdateGui()


end
currentequippeditem = num
player = player
char = player.Character


Torso = char:WaitForChild("Torso")
Neck = char.Torso["Neck"]

Humanoid = char:WaitForChild("Humanoid")

Equipped = false
equipnum = 0
---------------------- [ Equip Function ] -------------------------------------------------------------
-- Equip
function Equip(num)
	if versionHasWorkingWelds then
		spawn(function () wait()wait()wait()wait()
			l = Instance.new("Weld")
			l.Parent = player.Character["Right Arm"]
			l.Part0 = player.Character["Right Arm"]
			l.Part1 = wepin.Handle
			l.C0 = CFrame.new(0, -1, 0, 1, 0, -0, 0, 0, 1, 0, -1, -0)
			l.C1 = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
		end)
	end
	
	if wepin:FindFirstChild("Laser") then wepin.Laser.Transparency = 0 end
	Ammo = GunSettings.Ammo
	StorageAmmo = GunSettings.StoredAmmo


	Handle = wepin:WaitForChild("Handle")
	Mag = wepin:WaitForChild("Mag")
	FirePart = wepin:WaitForChild("FirePart")

	currentequippeditem = num
	player = player
	char = player.Character


	Torso = char:WaitForChild("Torso")
	Neck = char.Torso["Neck"]

	Humanoid = char:WaitForChild("Humanoid")


	firemode = GunSettings.FireMode

	equipnum = equipnum+1
	Equipped = true
	Sprinting = false
	Shooting = false
	Aiming = false
	Reloading = false
	PatrolMode = false
	Zoomed = false
	SightsCycled = false
	Drop = GunSettings.Drop
	Stances = 0
	Recoil = 0
	Recoilup = 0

	RootPart = char.HumanoidRootPart
	RootJoint = RootPart.RootJoint
	RootJoint.C0 = CFrame.new()
	RootJoint.C1 = CFrame.new()




	LeftAimPos = GunSettings.LeftAimPos

	GunSettings.StoredAmmo = GunSettings.StoredAmmo * GunSettings.MagCount

	AmmoGui = AmmoGui:clone()
	AmmoGui.Parent = gethui()
	AmmoGui.Enabled = true
	if firemode == 2 then
		AmmoGui.Frame.FireModeText.Text = " [ SEMI ] "
	end
	if firemode == 4 then
		AmmoGui.Frame.FireModeText.Text = " [ BOLT ] "	
	end
	if firemode == 5 then
		AmmoGui.Frame.FireModeText.Text = " [ PUMP ] "	
	end

	UpdateGui()


	RAW = Instance.new("Weld")
	RAW.Name= "RightWeld"
	RAW.Part0 = char:WaitForChild("Head")
	RAW.Part1 = char:WaitForChild("Right Arm")
	RAW.Parent = char:WaitForChild("Right Arm")
	RAW.C1 = GunSettings.RightPos	
	Torso:WaitForChild("Right Shoulder").Part1 = nil

	LAW = Instance.new("Weld")
	LAW.Name= "LeftWeld"
	LAW.Part0 = char:WaitForChild("Head")
	LAW.Part1 = char:WaitForChild("Left Arm")
	LAW.Parent = char:WaitForChild("Left Arm")
	LAW.C1 = GunSettings.LeftPos
	Torso:WaitForChild("Left Shoulder").Part1 = nil
end
-- Reset
char.Humanoid.Died:connect(function()
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
	backpackon = true
	if Equipped then
		if char.Humanoid.Health == 0 then
			RAW:Destroy()
			LAW:Destroy()
			
			if Shooting then
				Shooting = false
			end
			if Aiming then
				Aiming = false
			end
			if Reloading then
				Reloading = false
			end 
			Stances = 0
		end
		----tweenFoV(70,60)
		Equipped = false
	end
end)



-- Unequip
function UnEquipped ()
	Equipped = false
	currentequippeditem = 0


	if Shooting then
		Shooting = false
	end
	if Aiming then
		Aiming = false
	end
	if Reloading then
		Reloading = false
	end

	Stances = 0

	pcall(function ()
		AmmoGui:Destroy()
		AmmoGui = OrgAmmoGui:Clone()
		Torso:WaitForChild("Right Shoulder").Part1 = char["Right Arm"]
		Torso:WaitForChild("Left Shoulder").Part1 = char["Left Arm"]

		RAW:Destroy()
		LAW:Destroy()
		
		char.Torso.Neck.C0 = CFrame.new(0, 1, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)
		char.Torso.Neck.C1 = CFrame.new(0, -0.5, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)
	end)
end

-- Sprint


-- Reload
---------------------- [ Animations Function ] -------------------------------------------------------------

function IdleAnim()
	if Equipped then
		tweenJoint(RAW,  nil , GunSettings.RightPos, function(X) return math.sin(math.rad(X)) end, 0.25)
		tweenJoint(LAW,  nil , GunSettings.LeftPos, function(X) return math.sin(math.rad(X)) end, 0.25) 
	end
end

function AimAnim()
	if Equipped then
		tweenJoint(RAW,  nil, RAW.C1 *  CFrame.new(-wepin.AimPart.CFrame:toObjectSpace(char.Head.CFrame).p), function(X) return math.sin(math.rad(X)) end, 0.25)
		tweenJoint(LAW,  nil , GunSettings.LeftAimPos, function(X) return math.sin(math.rad(X)) end, 0.25)
	end
end

function SprintAnim()
	char = player.Character
	char.Humanoid.WalkSpeed = 24
	if Equipped then	
		tweenJoint(RAW,  nil , GunSettings.RightSprintPos, function(X) return math.sin(math.rad(X)) end, 0.25)
		tweenJoint(LAW,  nil , GunSettings.LeftSprintPos, function(X) return math.sin(math.rad(X)) end, 0.25)
	end
end

function ReloadAnim()
	print("STEP 1")
	emmo = 0
	if wepin.Settings.AmmoType.Value == "pistol" then
		emmo = PistolRounds
	elseif wepin.Settings.AmmoType.Value == "rifle" then
		emmo = RifleRounds
	elseif wepin.Settings.AmmoType.Value == "shotgun" then
		emmo = ShotgunRounds
	end
	if (emmo > wepin.Settings.StoredAmmo.Value-wepin.Settings.Ammo.Value) then
		canfire = false
		if firemode ~= 5 then
			tweenJoint(RAW,  nil, CFrame.new(-1.12839627, 0.0917494744, -0.692307293, 0.811488032, -0.567044735, -0.141235247, -0.105751149, -0.380196542, 0.91884023, -0.574720562, -0.730692148, -0.368490577), function(X) return math.sin(math.rad(X)) end, 0.3)
			tweenJoint(LAW,  nil, CFrame.new(0.165562272, 0.680525303, -1.37036359, 0.56116122, -0.730850101, 0.388530731, -0.649711668, -0.0981186926, 0.75382185, -0.512808681, -0.675448656, -0.529902339), function(X) return math.sin(math.rad(X)) end, 0.3)
			wait(0.15)
			wepin.Handle.MagOut:Play()
			tweenJoint(LAW,  nil, CFrame.new(0.165562272, 0.680525303, -1.37036359, 0.56116122, -0.730850101, 0.388530731, -0.444904625, 0.12949273, 0.886166751, -0.697966933, -0.670141637, -0.252492398), function(X) return math.sin(math.rad(X)) end, 0.3)
			local ekeke = wepin.Mag:Clone() ekeke.CFrame = wepin.Mag.CFrame ekeke.Anchored = false ekeke.Parent = workspace Debris:AddItem(ekeke,5)	
			wepin.Mag.Transparency = 1 pcall(function()wepin.Mag1.Transparency = 1 end)
			wait(0.15)
			tweenJoint(LAW,  nil, CFrame.new(0.165562272, 1.1805253, -1.37036359, 0.467822284, -0.409327269, 0.783321977, -0.312030375, 0.752724469, 0.579692006, -0.826909423, -0.515613258, 0.224418715), function(X) return math.sin(math.rad(X)) end, 0.3)
			--tweenJoint(MagW,  nil, nil, function(X) return math.sin(math.rad(X)) end, 0.5)
			wait(0.6)
			tweenJoint(LAW,  nil, CFrame.new(0.165562272, 0.680525303, -1.37036359, 0.56116122, -0.730850101, 0.388530731, -0.444904625, 0.12949273, 0.886166751, -0.697966933, -0.670141637, -0.252492398), function(X) return math.sin(math.rad(X)) end, 0.3)
			--tweenJoint(MagW,  nil, nil, function(X) return math.sin(math.rad(X)) end, 0.5)
			wait(0.14)
			wepin.Handle.MagIn:Play()
			wepin.Mag.Transparency = 0 pcall(function()wepin.Mag1.Transparency = 0 end)
			tweenJoint(LAW,  nil, CFrame.new(0.165562272, 0.680525303, -1.37036359, 0.56116122, -0.730850101, 0.388530731, -0.649711668, -0.0981186926, 0.75382185, -0.512808681, -0.675448656, -0.529902339), function(X) return math.sin(math.rad(X)) end, 0.3)
			--tweenJoint(MagW,  nil, nil, function(X) return math.sin(math.rad(X)) end, 0.5)
			Reloading= false
			if firemode ~= 5 then
				if wepin.Settings.AmmoType.Value == "pistol" then
					AddPistolRounds(-(wepin.Settings.StoredAmmo.Value-wepin.Settings.Ammo.Value))
				elseif wepin.Settings.AmmoType.Value == "rifle" then
					AddRifleRounds(-(wepin.Settings.StoredAmmo.Value-wepin.Settings.Ammo.Value))
				elseif wepin.Settings.AmmoType.Value == "shotgun" then
					AddShotgunRounds(-(wepin.Settings.StoredAmmo.Value-wepin.Settings.Ammo.Value))
				end	
				wepin.Settings.Ammo.Value = wepin.Settings.StoredAmmo.Value
			end
		end
		UpdateGui()
		wait(0.52)
		if firemode == 4 then
			tweenJoint(LAW,  nil, CFrame.new(0, 0, 0, 0.56116122, -0.730850101, 0.388530731, -0.649711668, -0.0981186926, 0.75382185, -0.512808681, -0.675448656, -0.529902339), function(X) return math.sin(math.rad(X)) end, 0.3)
			wait(.2)
			wepin.BoltBack.Transparency = 0 wepin.Bolt.Transparency = 1
			wepin.Handle.M1:Play()					
			tweenJoint(LAW,  nil, CFrame.new(0, -1, 0, 0.56116122, -0.730850101, 0.388530731, -0.649711668, -0.0981186926, 0.75382185, -0.512808681, -0.675448656, -0.529902339), function(X) return math.sin(math.rad(X)) end, 0.3)
			spawn(function () wait()local shell = Instance.new("Part")
				shell.CFrame =  wepin.Bullet.CFrame * CFrame.fromEulerAnglesXYZ(2.5,1,1.25)
				shell.Size = Vector3.new(1,1,1)
				shell.Reflectance = 0
				shell.CanCollide = false
				shell.BottomSurface = 0
				shell.TopSurface = 0
				shell.Name = "Shell"
				shell.Velocity = (wepin.Bullet.CFrame*CFrame.Angles(math.rad(0),math.rad(180),math.rad(0))).lookVector * 30 + Vector3.new(math.random(0,0),10,math.random(0,0))
				shell.RotVelocity = Vector3.new(-10,40,30)
				local shellmesh = Instance.new("CylinderMesh")
				shellmesh.Scale = Vector3.new(.2,.6,.2)
				shell.BrickColor = BrickColor.new(24)
				shellmesh.Parent = shell
				shell.Parent = wepin
				game:GetService("Debris"):addItem(shell,0.25)
			end)					
			wait(.2)
			wepin.BoltBack.Transparency = 1 wepin.Bolt.Transparency = 0
			wepin.Handle.M2:Play()					
			tweenJoint(LAW,  nil, CFrame.new(0, 0, 0, 0.56116122, -0.730850101, 0.388530731, -0.649711668, -0.0981186926, 0.75382185, -0.512808681, -0.675448656, -0.529902339), function(X) return math.sin(math.rad(X)) end, 0.3)
			wait(.2)
		end
		print("STEP 3")
		if firemode == 5 then
			print("STEP 4")
			for i=1,(wepin.Settings.StoredAmmo.Value-wepin.Settings.Ammo.Value) do
				AddShotgunRounds(-1)
				tweenJoint(RAW,  nil, CFrame.new(-1.12839627, 0.0917494744, -0.692307293, 0.811488032, -0.567044735, -0.141235247, -0.105751149, -0.380196542, 0.91884023, -0.574720562, -0.730692148, -0.368490577), function(X) return math.sin(math.rad(X)) end, 0.3)
				tweenJoint(LAW,  nil, CFrame.new(0.165562272, 0.680525303, -1.37036359, 0.56116122, -0.730850101, 0.388530731, -0.649711668, -0.0981186926, 0.75382185, -0.512808681, -0.675448656, -0.529902339), function(X) return math.sin(math.rad(X)) end, 0.3)
				wait(0.15)
				wepin.Handle.MagIn:Play()
				wepin.Settings.Ammo.Value = wepin.Settings.Ammo.Value+1;
				UpdateGui()
				tweenJoint(LAW,  nil, CFrame.new(0.165562272, 0.680525303, -1.37036359, 0.56116122, -0.730850101, 0.388530731, -0.444904625, 0.12949273, 0.886166751, -0.697966933, -0.670141637, -0.252492398), function(X) return math.sin(math.rad(X)) end, 0.3)
				wepin.Mag.Transparency = 1  pcall(function()wepin.Mag1.Transparency =1 end)
				wait(0.15)
				tweenJoint(LAW,  nil, CFrame.new(0.165562272, 1.1805253, -1.37036359, 0.467822284, -0.409327269, 0.783321977, -0.312030375, 0.752724469, 0.579692006, -0.826909423, -0.515613258, 0.224418715), function(X) return math.sin(math.rad(X)) end, 0.3)
				--tweenJoint(MagW,  nil, nil, function(X) return math.sin(math.rad(X)) end, 0.5)
				--wait(0.6)
				tweenJoint(LAW,  nil, CFrame.new(0.165562272, 0.680525303, -1.37036359, 0.56116122, -0.730850101, 0.388530731, -0.444904625, 0.12949273, 0.886166751, -0.697966933, -0.670141637, -0.252492398), function(X) return math.sin(math.rad(X)) end, 0.3)
				--tweenJoint(MagW,  nil, nil, function(X) return math.sin(math.rad(X)) end, 0.5)
			end	
			wait(.3)

			wepin.Settings.Ammo.Value = wepin.Settings.StoredAmmo.Value
			UpdateGui()
			tweenJoint(LAW,  nil , GunSettings.LeftPos-Vector3.new(0,1,0), function(X) return math.sin(math.rad(X)) end, 0.25)
			wepin.BoltBack.Transparency = 0 wepin.Bolt.Transparency = 1
			wepin.Handle.M1:Play()	
			spawn(function () wait()local shell = Instance.new("Part")
				shell.CFrame =  wepin.Bullet.CFrame * CFrame.fromEulerAnglesXYZ(2.5,1,1.25)
				shell.Size = Vector3.new(1,1,1)
				shell.Reflectance = 0
				shell.CanCollide = false
				shell.BottomSurface = 0
				shell.TopSurface = 0
				shell.Name = "Shell"
				shell.Velocity = (wepin.Bullet.CFrame*CFrame.Angles(math.rad(0),math.rad(180),math.rad(0))).lookVector * 30 + Vector3.new(math.random(0,0),10,math.random(0,0))
				shell.RotVelocity = Vector3.new(-10,40,30)
				local shellmesh = Instance.new("CylinderMesh")
				if wepin.Settings.RifleOrPistol.Value ~= "pistol" and wepin.Settings.ShotCount.Value == 1 then
					shellmesh.Scale = Vector3.new(.05,.2,.05)
					shell.BrickColor = BrickColor.new(24)
				elseif wepin.Settings.ShotCount.Value > 1  then
					shellmesh.Scale = Vector3.new(.15,.35,.15)
					shell.BrickColor = BrickColor.new("Really red")
				else
					shellmesh.Scale = Vector3.new(.05,.15,.05)
					shell.BrickColor = BrickColor.new(24)
				end
				shellmesh.Parent = shell
				shell.Parent = wepin
				game:GetService("Debris"):addItem(shell,0.25)
			end)
			wait(.2)			
			tweenJoint(LAW,  nil , GunSettings.LeftPos, function(X) return math.sin(math.rad(X)) end, 0.25)
			wepin.BoltBack.Transparency = 1 wepin.Bolt.Transparency = 0
			wepin.Handle.M2:Play()		
			wait(.2)
		end
		print("STEP 5")
		Reloading= false	
		canfire = true	
		IdleAnim()
	end
end

function PatrolAnim()
	if Equipped then
		tweenJoint(RAW,  nil, CFrame.new(-0.543740213, 0.246546745, -1.1437645, 0.868195355, 2.16905711e-008, -0.496222436, 0.466779947, 0.339331359, 0.816682696, 0.168383837, -0.940666854, 0.294605911), function(X) return math.sin(math.rad(X)) end, 0.3)
		tweenJoint(LAW,  nil, CFrame.new(0.870444059, 0.659437597, -1.52524424, 0.98510921, 0.171723664, -0.00840575993, -0.0107716024, 0.110439532, 0.993824482, 0.171591491, -0.978935182, 0.110644706), function(X) return math.sin(math.rad(X)) end, 0.3)
		wait(0.2)
	end
end

function CycleSights()
	if Equipped then
		tweenJoint(RAW,  nil, RAW.C1 *  CFrame.new(-wepin.AimPart.CFrame:toObjectSpace(char.Head.CFrame).p), function(X) return math.sin(math.rad(X)) end, 0.25)
		tweenJoint(LAW,  nil, GunSettings.LeftAimPos, function(X) return math.sin(math.rad(X)) end, 0.25)
	end
end

local character = (player.Character or player.CharacterAdded:wait())

---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------

-- Client shit
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, not backpackon)
rs = RS.RenderStepped

function tweenFoV(goal, frames)
	coroutine.resume(coroutine.create(function()
		SFn = SFn and SFn + 1 or 0 
		local SFn_S = SFn
		for i = 1, frames do
			if SFn ~= SFn_S then break end
			cam.FieldOfView = cam.FieldOfView + (goal - cam.FieldOfView) * (i / frames)
			RS.RenderStepped:wait()
		end
	end))
end

cam = workspace.CurrentCamera
function tweenCameraOffset(CO, t)
	coroutine.resume(coroutine.create(function()
		COn = COn and COn + 1 or 0 local COn_S = COn
		for i = 1, t do
			if COn ~= COn_S then break end
			char.Humanoid.CameraOffset = char.Humanoid.CameraOffset + (CO - char.Humanoid.CameraOffset) * (i / t)
			RS.RenderStepped:wait()
		end
	end))

end
backpackon = false
local PositionEvent = _compatFireRemote
Frame = gethui().Inventory.Inventory
Mouse=player:GetMouse()
Mouse.keyDown:connect(function(Key)
	wait()
	if backpackon == false then
		if (string.lower(Key)) == "g" then
			Frame.Visible = not Frame.Visible;
		end
		if (string.lower(Key)) == "f" then
			print("PRESSED F")
			lEquipped=PositionEvent:FireServer("pickup",targetobject,MOUSEANGLES,XD )
		end
		if string.lower(Key) == "1" then
			lEquipped=PositionEvent:FireServer("1",Mouse.Target,MOUSEANGLES,XD  )
		end
		if string.lower(Key) == "2" then
			print("PRESSED 2")
			lEquipped=PositionEvent:FireServer("2",Mouse.Target,MOUSEANGLES,XD )
		end
		if string.lower(Key) == "3" then
			lEquipped=PositionEvent:FireServer("3",Mouse.Target,MOUSEANGLES,XD )
		end
		if string.lower(Key) == "r" then
			lEquipped=PositionEvent:FireServer("r",Mouse.Target,MOUSEANGLES,XD )
		end

		if string.lower(Key) == "z" then
			lEquipped=PositionEvent:FireServer("z",Mouse.Target,MOUSEANGLES,XD )
		end
		if string.lower(Key) == "p" then
			lEquipped=PositionEvent:FireServer("p",Mouse.Target,MOUSEANGLES,XD )
		end
		if string.lower(Key) == "v" then
			lEquipped=PositionEvent:FireServer("v",Mouse.Target,MOUSEANGLES,XD )
		end
	end
end)
Mouse.Button1Down:connect(function()
	lEquipped=PositionEvent:FireServer("firegun",Mouse.Target,MOUSEANGLES,XD )
end)

-- Shoot
Mouse.Button1Up:connect(function()
	lEquipped=PositionEvent:FireServer("fireoff",Mouse.Target,MOUSEANGLES,XD )
end)

-- Aim
function findtool()
	for i,v in ipairs(player.Character:GetChildren()) do
		if v:IsA("Tool") then
			return v;
		end
	end
	return 0;
end
if findtool() ~= 0 then
	currentfov = findtool().Settings.AimZoom.Value
else
	currentfov = 70
end
Mouse.Button2Down:connect(function()
	if findtool() ~= 0 then
		currentfov = findtool().Settings.AimZoom.Value
	else
		currentfov = 70
	end
	Aiming = true
	lEquipped=PositionEvent:FireServer("aim",Mouse.Target,MOUSEANGLES,XD )
	tweenFoV(currentfov, 70)
end)

--Aim
Mouse.Button2Up:connect(function()
	tweenFoV(70,currentfov)
	Aiming = false
	lEquipped=PositionEvent:FireServer("unaim",Mouse.Target,MOUSEANGLES,XD )
end)
spawn(function () while wait() do

		lEquipped=PositionEvent:FireServer("",Mouse.Target,MOUSEANGLES,XD )
	end
end)
char = player.Character
XD = CFrame.new(0,0,0)

rs:connect(function()
	pcall(function()XD=Torso.CFrame:toObjectSpace(XD)end)
	pcall(function()MOUSEANGLES,XD = CFrame.Angles(-math.asin((Mouse.Hit.p - Mouse.Origin.p).unit.y), 0, 0)end)
	pcall(function () Torso = char.Torso
		Neck = char.Torso["Neck"]
		Humanoid = char.Humanoid
	end)
	if Equipped then
		if Equipped then
			Mouse.TargetFilter = workspace
			local HRPCF =  char:WaitForChild("HumanoidRootPart").CFrame * CFrame.new(0, 1.5, 0)* CFrame.new(Humanoid.CameraOffset)
			Neck.C0 =  Torso.CFrame:toObjectSpace(HRPCF)
			Neck.C1 =  MOUSEANGLES,XD 

		end	else Mouse.TargetFilter = nil
	end
end)

game:GetService("UserInputService").InputBegan:connect(function(key)
	if key.KeyCode == Enum.KeyCode.LeftShift and not Aiming then
		char.Humanoid.WalkSpeed = 30
		tweenFoV(75, 60)		
		Sprinting = true
	end
end)

game:GetService("UserInputService").InputEnded:connect(function(key)
	if key.KeyCode == Enum.KeyCode.LeftShift and not Aiming then
		char.Humanoid.WalkSpeed = 16
		tweenFoV(70, 60)
		Sprinting = false
	end
end)

WhatIS = gethui().Inventory.Item
gethui().Inventory.SWITCH.MouseButton1Down:Connect(function ()
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, not backpackon)
	backpackon = not backpackon
	player.Character.Humanoid:UnequipTools()
end)

Mouse.Move:connect(function()
	if (Mouse.Target and Mouse.Target:IsA('Part') or Mouse.Target and Mouse.Target:IsA('Decal') and Mouse.Target.Parent and (Mouse.Target.Parent:findFirstChild'Humanoid') or Mouse.Target and Mouse.Target.Parent and Mouse.Target.Parent:findFirstChild'Settings') 
	then
		local target;

		if Mouse.Target:IsA('Decal') then
			target = Mouse.Target.Parent
		else
			target = Mouse.Target
		end
		if target.Parent:IsA'Model' then
			WhatIS.Text = target.Parent.Name
		elseif target.Parent:IsA'Hat' then
			WhatIS.Text = target.Parent.Parent.Name
		end
		targetobject = target.Parent
	else
		WhatIS.Text = ""
	end
end)

RS.RenderStepped:connect(function()
	if (player.Character:FindFirstChild("Right Arm") and player.Character:FindFirstChild("Left Arm")) then
		player.Character:FindFirstChild("Right Arm").LocalTransparencyModifier = 0
		player.Character:FindFirstChild("Left Arm").LocalTransparencyModifier = 0
	elseif (player.Character:FindFirstChild("Right Arm") or player.Character:FindFirstChild("Left Arm")) then
		(player.Character:FindFirstChild("Right Arm") or player.Character:FindFirstChild("Left Arm")).LocalTransparencyModifier = 0
	end
end)
