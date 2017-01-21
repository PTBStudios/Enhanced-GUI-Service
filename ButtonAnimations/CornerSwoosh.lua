local function rgb(r,g,b) return Color3.new(r/255,b/255,g/255) end

local PsuedoLabelPatch = require(script.Parent.Parent.PatchService)

function MouseEnter(Button) 
	if Button then
		PsuedoLabelPatch(Button)
		if not (Button:FindFirstChild"FX") then
			local FX = script.FX:Clone()
				local LogPosition, LogSize = FX.Position, FX.Size
				Button.PsuedoLabel.TextColor3 = rgb(255,255,255)
				FX.Size = UDim2.new(0, 2, 0, 600)
				FX.Position = UDim2.new(.5, -1, 0.5, -300)
				FX.ImageTransparency = 1
				FX.Visible = true
				FX.Parent = Button
				FX:TweenSizeAndPosition(LogSize, LogPosition, "Out", "Quad", 0.2)
				for i = 1, 0.7, -0.05 do
					FX.ImageTransparency = i 
					game:GetService("RunService").RenderStepped:wait()
				end
		end
	end
end

function MouseLeave(Button) 
	if Button then
		local PossibleMatch = Button:FindFirstChild("FX")
		if (PossibleMatch) then
			Button.PsuedoLabel.TextColor3 = rgb(255,255,255)
			PossibleMatch:TweenSizeAndPosition(UDim2.new(0, 2, 0, 600), UDim2.new(.5, -1, 0.5, -300), "Out", "Quad", .3, false)
			local Transparency = PossibleMatch.ImageTransparency
			for i = Transparency, 1, 0.05 do
				PossibleMatch.ImageTransparency = i 
				game:GetService("RunService").RenderStepped:wait()
			end
			PossibleMatch:Destroy()
		end
	end
end

function MouseButton1Down(Button) 
	local PossibleMatch = Button:FindFirstChild("FX")
	if (PossibleMatch) then
		PossibleMatch:TweenSizeAndPosition(UDim2.new(2, 0, 0, 600), UDim2.new(-.5, 0, 0.5, -300), "Out", "Quad", 0.1, false)
		Button.PsuedoLabel.TextColor3 = Button.BackgroundColor3 
		for i = .7, 0, -0.1 do
			PossibleMatch.ImageTransparency = i 
			game:GetService("RunService").RenderStepped:wait()
		end
	end
end

function MouseButton1Up(Button)
	if Button then
		MouseLeave(Button)
	end
end

function MouseButton1Click(Button) end
function MouseButton2Down(Button) end
function MouseButton2Up(Button) end
function MouseButton2Click(Button) end

return {MouseEnter, MouseLeave, MouseButton1Down, MouseButton1Up, MouseButton1Click, MouseButton2Click, MouseButton2Down, MouseButton2Up}
