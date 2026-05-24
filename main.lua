local Players = game:GetService("Players")
local player = Players.LocalPlayer

local enabled = false
local minimized = false

-- =====================
-- UI
-- =====================
local gui = Instance.new("ScreenGui")
gui.Name = "NoKnockbackUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 120)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Parent = gui

-- TITLE
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0.3, 0)
title.Text = "No Knockback"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Parent = frame

-- TOGGLE
local button = Instance.new("TextButton")
button.Size = UDim2.new(1, 0, 0.35, 0)
button.Position = UDim2.new(0, 0, 0.3, 0)
button.Text = "OFF"
button.BackgroundColor3 = Color3.fromRGB(80,80,80)
button.TextColor3 = Color3.new(1,1,1)
button.Parent = frame

button.MouseButton1Click:Connect(function()
	enabled = not enabled

	player:SetAttribute("NoKnockback", enabled)

	button.Text = enabled and "ON" or "OFF"
	button.BackgroundColor3 = enabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(80,80,80)
end)

-- MINIMIZE
local mini = Instance.new("TextButton")
mini.Size = UDim2.new(0, 25, 0, 25)
mini.Position = UDim2.new(1, -30, 0, 5)
mini.Text = "-"
mini.BackgroundColor3 = Color3.fromRGB(60,60,60)
mini.TextColor3 = Color3.new(1,1,1)
mini.Parent = frame

local icon = Instance.new("TextButton")
icon.Size = UDim2.new(0, 60, 0, 40)
icon.Position = UDim2.new(0, 10, 0.8, 0)
icon.Text = "NK"
icon.Visible = false
icon.BackgroundColor3 = Color3.fromRGB(40,40,40)
icon.TextColor3 = Color3.new(1,1,1)
icon.Parent = gui

mini.MouseButton1Click:Connect(function()
	minimized = not minimized

	frame.Visible = not minimized
	icon.Visible = minimized
end)

icon.MouseButton1Click:Connect(function()
	minimized = false
	frame.Visible = true
	icon.Visible = false
end)
