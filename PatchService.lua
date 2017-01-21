function PsuedoLabelPatch(ObjectWithText) -- Fixes the label issue w/ ROBLOX
	if not (ObjectWithText:FindFirstChild("PsuedoLabel")) then
		local ObjectWithTextZIndex = ObjectWithText.ZIndex + 1 -- To make sure it doesn't break the layering
		local PsuedoLabel = Instance.new("TextLabel")
		
		local Properties = {
			"Font"; "TextColor3"; "Text"; "FontSize"; "TextScaled"; "TextSize"; "TextStrokeColor3"; "TextStrokeTransparency"; "TextTransparency"; "TextWrapped";
		}
		
		for _,v in ipairs(Properties) do -- Let's setup all the properties
			PsuedoLabel[v] = ObjectWithText[v]
		end
		
		PsuedoLabel.BackgroundTransparency = 1 
		PsuedoLabel.Name = "PsuedoLabel"
		PsuedoLabel.Parent = ObjectWithText 
		PsuedoLabel.ZIndex = ObjectWithTextZIndex
		PsuedoLabel.Size = UDim2.new(1,0,1,0)
		
		ObjectWithText.Text = ""
		
		return PsuedoLabel
	end
end

return PsuedoLabelPatch
