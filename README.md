# Enhanced-GUI-Service
This is a service that allows for more flexbility and adds more functionality to ROBLOX's GUI engine. The source itself is currently closed-source but we (PTBStudios) plan on opening the source to everyone shortly.

## Current Features
Currently the only feature available is a bootstrapper that automates button animations and makes it easy to create your own animations.
### Easy-Peasy Button Animations
This feature will make animating your buttons A LOT easier and way more efficient. First make sure to Install (see below) the script, then you can use this API:

-------------------------
```lua
module:ImportAnimation(AnimationModule)
```
**AnimationModule [userdata]:** The module that holds animation data, [you can get the template here](https://github.com/PTBStudios/Enhanced-GUI-Service/blob/master/ButtonAnimations/Template.lua)

-------------------------

```lua
module:HookButtonAnimation(Button, AnimationName)
```
**Button [userdata]:** The TextButton object

**AnimationName [string]:** The name of the animation you want to load

-------------------------


## Installation 
Installing this is super easy, but due to ROBLOX limitations it has some weird quirks. Before installing this you'll need to make sure of:
- You're doing this from a server script
- It won't run in Studio, so expect it to return nil 

With that in mind, let's show you an example of installing it. You can do this many different ways, but copying and pasting this will work: 

**FROM A SERVER SCRIPT!!**
```lua
local BetterGuiService = require(616387491) -- Download our module from the repository 

local Replicator = BetterGuiService:Setup() -- Run the setup function. This is neccesary! 
Repliactor.Name = "GuiService" -- The name, this is important. 
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
local GuiModule = require(Player:WaitForChild("GuiService")) -- Or if you changed the name, use that instead
```

More features coming soon. Follow us on Twitter: [@PTBStudios](https://twitter.com/PTBStudios)
