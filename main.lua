local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- =====================
-- UI
-- =====================
local gui = Instance.new("ScreenGui")
gui.Name = "NoDamageUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Parent = gui

local button = Instance.new("TextButton")
button.Size = UDim2.new(1, 0, 1, 0)
button.Text = "No Damage: OFF"
button.BackgroundColor3 = Color3.fromRGB(80,80,80)
button.TextColor3 = Color3.new(1,1,1)
button.Parent = frame

-- =====================
-- TOGGLE STATE
-- =====================
local noDamage = false

button.MouseButton1Click:Connect(function()
	noDamage = not noDamage

	button.Text = noDamage and "No Damage: ON" or "No Damage: OFF"
	button.BackgroundColor3 = noDamage and Color3.fromRGB(0,170,0) or Color3.fromRGB(80,80,80)
end)

-- =====================
-- DAMAGE BLOCKER
-- =====================
local function setupCharacter(char)
	local hum = char:WaitForChild("Humanoid")

	hum.HealthChanged:Connect(function()
		if noDamage then
			if hum.Health < hum.MaxHealth then
				hum.Health = hum.MaxHealth
			end
		end
	end)
end

player.CharacterAdded:Connect(setupCharacter)

if player.Character then
	setupCharacter(player.Character)
end
