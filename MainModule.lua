--[[
	Read documentation:
	github.com/PTBStudios/Enhanced-GUI-Service/
	
			              ,----,.             
		        ,--,    ,'   ,' |             
		      ,--.'|  ,'   .'   |  .--.--.    
		   ,--,  | :,----.'    .' /  /    '.  
		,---.'|  : '|    |   .'  |  :  /`. /  
		|   | : _' |:    :  |--, ;  |  |--`   
		:   : |.'  |:    |  ;.' \|  :  ;_     
		|   ' '  ; :|    |      | \  \    `.  
		'   |  .'. |`----'.'\   ;  `----.   \ 
		|   | :  | '  __  \  .  |  __ \  \  | 
		'   : |  : ;/   /\/  /  : /  /`--'  / 
		|   | '  ,// ,,/  ',-   .'--'.     /  
		;   : ;--' \ ''\       ;   `--'---'   
		|   ,/      \   \    .'               
		'---'        `--`-,-'                 
		(and ptb)
--]]


local module = {}
local HasSetup = false
local Host = script
	local ButtonAnimations = script:WaitForChild("ButtonAnimations")
	local Version = script.Version.Value
	local PatchFcn = require(script:WaitForChild("PatchService"))

-- Configuration
local AllowPrinting = true -- Setting this to false will hide all the debug spam 

-- More in-depth print function that shows the script name
local function RealPrint(...)
	if AllowPrinting then
		local str = ""
		for _,v in ipairs({...}) do
			str = str.. tostring(v)
		end
		warn("[PTB Gui Service]: "..str)
	end
end

-- Function that will run when the module needs to install itself. Without this nothing will replicate properly. 
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
	if HasSetup then

		-- First we're going to see if animationtype is a string or an object
		if type(animationtype) == "string" then
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
		
		elseif type(animationtype) == "userdata"  then-- Now to see if it's a object
			if animationtype:IsA("ModuleScript") then
				local NameFind = animationtype.Name
				local ImportStatus = module:ImportAnimation(animationtype:Clone())
				if ImportStatus then 
					module:HookButtonAnimation(buttonobject, NameFind)
				else
					RealPrint("Sorry, HookButtonAnimation() ran into an issue while importing the animation. It seems to have deleted itself whilst importing.")
				end
			else
				RealPrint("Sorry, HookButtonAnimation() only supports strings or modulescripts.")
			end
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
