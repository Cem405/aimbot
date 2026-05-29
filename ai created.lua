-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "AnimeHubV3"
gui.Parent = player:WaitForChild("PlayerGui")

-- MAIN FRAME
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 460, 0, 280)
main.Position = UDim2.new(0.5, -230, 0.5, -140)
main.BackgroundColor3 = Color3.fromRGB(25, 15, 40)
main.Parent = gui

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 16)

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(255, 90, 200)
stroke.Thickness = 2

-- TITLE
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -80, 0, 40)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🌸 Anime Hub V3"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

-- CONTENT
local content = Instance.new("Frame")
content.Size = UDim2.new(0, 300, 0, 220)
content.Position = UDim2.new(0, 140, 0, 50)
content.BackgroundColor3 = Color3.fromRGB(35, 20, 60)
content.Parent = main

Instance.new("UICorner", content).CornerRadius = UDim.new(0, 12)

-- STATE
local minimized = false
local fullSize = main.Size

-- MINIMIZE BUTTON
local miniBtn = Instance.new("TextButton")
miniBtn.Size = UDim2.new(0, 30, 0, 30)
miniBtn.Position = UDim2.new(1, -70, 0, 5)
miniBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 150)
miniBtn.Text = "-"
miniBtn.TextColor3 = Color3.fromRGB(255,255,255)
miniBtn.Font = Enum.Font.GothamBold
miniBtn.TextSize = 18
miniBtn.Parent = main

Instance.new("UICorner", miniBtn).CornerRadius = UDim.new(1, 0)

-- CLOSE / OPEN ANIMATION
local function minimize()
	minimized = true

	TweenService:Create(main, TweenInfo.new(0.25), {
		Size = UDim2.new(0, 180, 0, 40)
	}):Play()

	content.Visible = false
	title.Text = "🌸 Hub"
end

local function restore()
	minimized = false

	TweenService:Create(main, TweenInfo.new(0.25), {
		Size = fullSize
	}):Play()

	task.wait(0.2)
	content.Visible = true
	title.Text = "🌸 Anime Hub V3"
end

miniBtn.MouseButton1Click:Connect(function()
	if minimized then
		restore()
	else
		minimize()
	end
end)

-- DRAGGABLE (CLEAN VERSION)
local dragging = false
local dragStart
local startPos

main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
	end
end)

main.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

-- BUTTON HELPER
local function button(text, y, callback)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0.9, 0, 0, 35)
	b.Position = UDim2.new(0.05, 0, 0, y)
	b.BackgroundColor3 = Color3.fromRGB(255, 80, 180)
	b.Text = text
	b.TextColor3 = Color3.fromRGB(255,255,255)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.Parent = content

	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)

	b.MouseButton1Click:Connect(callback)
end

-- SIMPLE TEST FEATURES
button("⚡ Speed", 10, function()
	local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if hum then hum.WalkSpeed = 60 end
end)

button("🦘 Jump", 55, function()
	local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if hum then hum.JumpPower = 120 end
end)

-- OPEN ANIMATION
main.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(main, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
	Size = fullSize
}):Play()

-- TOGGLE UI
UserInputService.InputBegan:Connect(function(i)
	if i.KeyCode == Enum.KeyCode.RightShift then
		main.Visible = not main.Visible
	end
end)
