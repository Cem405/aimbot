local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local enabled = false
local minimized = false

-- =====================
-- UI
-- =====================
local gui = Instance.new("ScreenGui")
gui.Name = "MiniJumpUI"
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 180, 0, 90)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Parent = gui

-- TITLE
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0.3, 0)
title.Text = "Infinite Jump"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Parent = frame

-- TOGGLE BUTTON
local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(1, 0, 0.4, 0)
toggle.Position = UDim2.new(0, 0, 0.3, 0)
toggle.Text = "OFF"
toggle.BackgroundColor3 = Color3.fromRGB(80,80,80)
toggle.TextColor3 = Color3.new(1,1,1)
toggle.Parent = frame

toggle.MouseButton1Click:Connect(function()
	enabled = not enabled
	toggle.Text = enabled and "ON" or "OFF"
	toggle.BackgroundColor3 = enabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(80,80,80)
end)

-- MINIMIZE BUTTON
local miniBtn = Instance.new("TextButton")
miniBtn.Size = UDim2.new(0, 25, 0, 25)
miniBtn.Position = UDim2.new(1, -55, 0, 5)
miniBtn.Text = "-"
miniBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
miniBtn.TextColor3 = Color3.new(1,1,1)
miniBtn.Parent = frame

miniBtn.MouseButton1Click:Connect(function()
	minimized = not minimized

	if minimized then
		frame.Size = UDim2.new(0, 180, 0, 30)
		toggle.Visible = false
		title.Text = "Jump UI"
	else
		frame.Size = UDim2.new(0, 180, 0, 90)
		toggle.Visible = true
		title.Text = "Infinite Jump"
	end
end)

-- =====================
-- INFINITE JUMP
-- =====================
UserInputService.JumpRequest:Connect(function()
	if not enabled then return end

	local char = player.Character
	if not char then return end

	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return end

	hum:ChangeState(Enum.HumanoidStateType.Jumping)
end)
