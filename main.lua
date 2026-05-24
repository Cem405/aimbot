local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

local noclip = false
local nodamage = false
local infjump = false

-- UI
local gui = Instance.new("ScreenGui")
gui.Name = "DevToolUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 260)
frame.Position = UDim2.new(0.05, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Dev Tool"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Parent = frame

-- WALKSPEED
local wsBox = Instance.new("TextBox")
wsBox.Size = UDim2.new(1, -10, 0, 30)
wsBox.Position = UDim2.new(0, 5, 0, 40)
wsBox.PlaceholderText = "WalkSpeed"
wsBox.Text = ""
wsBox.Parent = frame

-- INFINITE JUMP BUTTON
local infBtn = Instance.new("TextButton")
infBtn.Size = UDim2.new(1, -10, 0, 30)
infBtn.Position = UDim2.new(0, 5, 0, 80)
infBtn.Text = "Infinite Jump: OFF"
infBtn.Parent = frame

-- NOCLIP BUTTON
local noclipBtn = Instance.new("TextButton")
noclipBtn.Size = UDim2.new(1, -10, 0, 30)
noclipBtn.Position = UDim2.new(0, 5, 0, 120)
noclipBtn.Text = "NoClip: OFF"
noclipBtn.Parent = frame

-- NODAMAGE BUTTON
local ndBtn = Instance.new("TextButton")
ndBtn.Size = UDim2.new(1, -10, 0, 30)
ndBtn.Position = UDim2.new(0, 5, 0, 160)
ndBtn.Text = "NoDamage: OFF"
ndBtn.Parent = frame

-- MINIMIZE BUTTON
local miniBtn = Instance.new("TextButton")
miniBtn.Size = UDim2.new(1, -10, 0, 30)
miniBtn.Position = UDim2.new(0, 5, 0, 200)
miniBtn.Text = "Minimize"
miniBtn.Parent = frame

local icon = Instance.new("TextButton")
icon.Size = UDim2.new(0, 60, 0, 40)
icon.Position = UDim2.new(0, 10, 0.8, 0)
icon.Text = "DEV"
icon.Visible = false
icon.Parent = gui

local function getChar()
	local char = player.Character
	if not char then return nil end
	return char
end

-- WALKSPEED
wsBox.FocusLost:Connect(function()
	local char = getChar()
	if not char then return end

	local hum = char:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.WalkSpeed = tonumber(wsBox.Text) or hum.WalkSpeed
	end
end)

-- INFINITE JUMP
infBtn.MouseButton1Click:Connect(function()
	infjump = not infjump
	infBtn.Text = infjump and "Infinite Jump: ON" or "Infinite Jump: OFF"
end)

UserInputService.JumpRequest:Connect(function()
	if infjump then
		local char = getChar()
		if not char then return end

		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then
			hum:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end
end)

-- NOCLIP
noclipBtn.MouseButton1Click:Connect(function()
	noclip = not noclip
	noclipBtn.Text = noclip and "NoClip: ON" or "NoClip: OFF"
end)

RunService.Stepped:Connect(function()
	if noclip then
		local char = getChar()
		if char then
			for _, v in pairs(char:GetDescendants()) do
				if v:IsA("BasePart") then
					v.CanCollide = false
				end
			end
		end
	end
end)

-- NODAMAGE
ndBtn.MouseButton1Click:Connect(function()
	nodamage = not nodamage
	ndBtn.Text = nodamage and "NoDamage: ON" or "NoDamage: OFF"

	local char = getChar()
	if char then
		local hum = char:FindFirstChildOfClass("Humanoid")

		if hum then
			hum.HealthChanged:Connect(function()
				if nodamage then
					hum.Health = hum.MaxHealth
				end
			end)
		end
	end
end)

-- MINIMIZE
local minimized = false

miniBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	frame.Visible = not minimized
	icon.Visible = minimized
end)

icon.MouseButton1Click:Connect(function()
	minimized = false
	frame.Visible = true
	icon.Visible = false
end)
