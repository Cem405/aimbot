-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "AnimeHub"
gui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 420, 0, 260)
main.Position = UDim2.new(0.5, -210, 0.5, -130)
main.BackgroundColor3 = Color3.fromRGB(25, 15, 35)
main.Parent = gui
main.Active = true
main.Draggable = true

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 16)

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(255, 120, 200)
stroke.Thickness = 2

local gradient = Instance.new("UIGradient", main)
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 80, 180)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 80, 255))
}

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundTransparency = 1
title.Text = "✨ Anime Hub ✨"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.Parent = main

-- Side Buttons (Tabs)
local function createTabButton(name, pos)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, 110, 0, 35)
    b.Position = pos
    b.BackgroundColor3 = Color3.fromRGB(40, 25, 60)
    b.Text = name
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    b.Parent = main

    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)

    return b
end

local tabMain = createTabButton("Main", UDim2.new(0, 15, 0, 60))
local tabFun  = createTabButton("Fun", UDim2.new(0, 15, 0, 105))

-- Content Frame
local content = Instance.new("Frame")
content.Size = UDim2.new(0, 270, 0, 180)
content.Position = UDim2.new(0, 140, 0, 60)
content.BackgroundColor3 = Color3.fromRGB(30, 20, 50)
content.Parent = main

Instance.new("UICorner", content).CornerRadius = UDim.new(0, 12)

-- Button Creator
local function createButton(text, y, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(255, 90, 180)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = content

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

    btn.MouseButton1Click:Connect(callback)
end

-- Fun Vars
local speedOn = false
local noclip = false

-- MAIN TAB FEATURES
createButton("⚡ Speed Toggle", 10, function()
    local char = player.Character or player.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")

    speedOn = not speedOn
    hum.WalkSpeed = speedOn and 60 or 16
end)

createButton("🦘 Super Jump", 55, function()
    local char = player.Character or player.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")

    hum.JumpPower = 120
end)

-- FUN TAB FEATURES
createButton("👻 Noclip Toggle", 10, function()
    noclip = not noclip

    game:GetService("RunService").Stepped:Connect(function()
        if noclip and player.Character then
            for _,v in pairs(player.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
    end)
end)

createButton("💫 Reset Stats", 55, function()
    local char = player.Character or player.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")

    hum.WalkSpeed = 16
    hum.JumpPower = 50
end)

-- Smooth popup animation
main.Size = UDim2.new(0, 0, 0, 0)

TweenService:Create(
    main,
    TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    {Size = UDim2.new(0, 420, 0, 260)}
):Play()

-- Keybind (Right Shift toggle UI)
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        main.Visible = not main.Visible
    end
end)
