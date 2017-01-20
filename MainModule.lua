local module = {}
local HasSetup = false
local Host = script
	local ButtonAnimations = script:WaitForChild("ButtonAnimations")
	local Version = script.Version.Value
	local PatchFcn = require(script:WaitForChild("PatchService"))

local function RealPrint(...)
	local str = ""
	for _,v in ipairs({...}) do
		str = str.. tostring(v)
	end
	warn("[PTB Gui Service]: "..str)
end

local function Setup()
	if not (HasSetup) then -- That way we won't run multiple times!!
		local function isLocalEnv()
		    local r = ({pcall(function() return not not game.Players.LocalPlayer end)})
		    return r[1] and r[2]
		end

		if isLocalEnv() then
			HasSetup = true 
		else
		    Host.Parent = game.ReplicatedStorage
			Host.Name = "GuiService"
			RealPrint("Finished setting up v"..Version..".")
			HasSetup = true
			
			local MeMyselfAndI = Host:Clone()
			return MeMyselfAndI
		end
	end

end

function module:Setup()
	RealPrint("NOTE: As of v2017/01/19/01, calling this function is no longer neccesary. It will automatically setup when you first interact with it.")
	 return Setup()
end

function module:ImportAnimation(mod)
	Setup()
	if mod then
		mod:Clone().Parent = script.ButtonAnimations
		RealPrint("Successfully added the new animation: "..mod.Name..".")
		return true
	else
		return false
	end
end

function module:HookButtonAnimation(buttonobject, animationtype)
	Setup()
	if HasSetup and buttonobject and animationtype then
		local PossibleMatch = ButtonAnimations:FindFirstChild(tostring(animationtype))
		if PossibleMatch and buttonobject:IsA'TextButton' then 
			local MouseEnter, MouseLeave, MouseButton1Down, MouseButton1Up, MouseButton1Click, MouseButton2Click, MouseButton2Down, MouseButton2Up = unpack(require(PossibleMatch))
			
			-- if you can think of a more efficient way of doing this please do a pull request and i'll update it and give you credit
			buttonobject.MouseLeave:connect		 	(function() MouseLeave(buttonobject) 			end)
			buttonobject.MouseEnter:connect		 	(function() MouseEnter(buttonobject) 			end)
			
			buttonobject.MouseButton1Down:connect	(function() MouseButton1Down(buttonobject)  	end)
			buttonobject.MouseButton1Up:connect	 	(function() MouseButton1Up(buttonobject) 		end)
			buttonobject.MouseButton1Click:connect  (function() MouseButton1Click(buttonobject) 	end)
			
			buttonobject.MouseButton2Down:connect   (function() MouseButton2Down(buttonobject) 		end)
			buttonobject.MouseButton2Up:connect     (function() MouseButton2Up(buttonobject)		end)
			buttonobject.MouseButton2Click:connect  (function() MouseButton2Click(buttonobject)     end)
			
		else
			RealPrint("The -animationtype- you tried submitting was not found. :L")
		end
	elseif (HasSetup == false) then 
		RealPrint("Tried running module:HookButtonAnimation() before setting up. Run module:Setup()!!!!")
	end	
end

function module:GetAllButtionAnimations()
	Setup()
	local Anims = {}
	for _,v in ipairs(ButtonAnimations:GetChildren()) do
		table.insert(Anims, v.Name)
	end
	return Anims
end

return module
