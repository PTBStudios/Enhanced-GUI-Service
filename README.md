# Enhanced-GUI-Service

Link to our model: https://www.roblox.com/library/616387491/PTBs-GUI-Enhancer?rbxp=64061898


Feeling grateful? Donate [50 robux](www.roblox.com/Donation-item?id=619904376) or [100 robux](https://www.roblox.com/catalog/411518691/Donation) to PTBStudios. 

This is a service that allows for more flexbility and adds more functionality to ROBLOX's GUI engine. 

## Current Features
Currently the only feature available is a bootstrapper that automates button animations and makes it easy to create your own animations. We plan on adding more as time goes on. 

### Easy-Peasy Button Animations
This feature will make animating your buttons A LOT easier and way more efficient. First make sure to Install (see below) the script, then you can use this API:

-------------------------
```lua
module:ImportAnimation(AnimationModule)
```
**AnimationModule [userdata]:** The module that holds animation data, [you can get the template here](https://github.com/PTBStudios/Enhanced-GUI-Service/blob/master/ButtonAnimations/Template.lua)

This will let you import a custom animation into the service.

-------------------------

```lua
module:HookButtonAnimation(Button, AnimationName)
```
**Button [userdata]:** The TextButton object

**AnimationName [string] or [userdata]:** The name or modulescript object of the animation you want to load

This function will setup the animations for your button of choice.

-------------------------

```lua
module:GetAllButtionAnimations()
```
Returns a table full of animation names (strings).

-------------------------



## Installation 
Installing this is super easy, but due to ROBLOX limitations it has some weird quirks. Before installing this you'll need to make sure of:
- You're doing this from a server script
- It won't run in Studio, so expect it to return nil 

With that in mind, let's show you an example of installing it. You can do this many different ways, but copying and pasting this will work: 

**FROM A SERVER SCRIPT!!**
```lua
local BetterGuiService = workspace.GuiModuleHere -- Having it saved in the server will prevent everything  from breaking if ROBLOX's insertservice acts up (which is a lot). All versions are reversable with previous plugins
local AutoUpdate = true  -- Set to false to turn off autoupdating

if not (game:GetService("RunService"):IsStudio()) and (AutoUpdate) then 
	BetterGuiService = require(616387491) -- this will download the latest version
end

local Replicator = BetterGuiService:Setup() -- This isn't exactly neccesary (running any function will have it load up now), but it returns a cloned version of it so we can replicate it. Whatever is your cup of tea, I suppose. 

Replicator.Name = "GuiService" -- The name, this is important. 

for _,v in ipairs(game.Players:GetPlayers()) do -- Loop through all current players
	if not (v:FindFirstChild("GuiService")) then -- If they DON'T have it
		Replicator:Clone().Parent = v -- Clone it
	end
end

game.Players.PlayerAdded:connect(function(player) -- Now we need to make sure that new players get it too
	if not (player:FindFirstChild("GuiService")) then --If they DON'T ahve it 
		Replicator:Clone().Parent = player -- Clone it to the player 
	end
end)
```

Great! Now it's installed to the server. How fun.  

Now from a client (localscript) all you need to do is:

```lua
local Player = game.Players.LocalPlayer -- Grab the local player
local GuiModule = require(Player:WaitForChild("GuiService", 15)) -- Or if you changed the name, use that instead
if GuiModule then -- We always want to have a backup plan if it doesn't load.
	-- etc
end
```



More features coming soon. Follow us on Twitter: [@PTBStudios](https://twitter.com/PTBStudios)
