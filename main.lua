local Library = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Library:CreateWindow({
   Name = "PvP Test Tools"
})

local Tab = Window:CreateTab("Movement")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local enabled = false
local SPEED = 56

-- GET TARGET (einfach 1 anderer Spieler)
local function getTarget()
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			return p
		end
	end
	return nil
end

-- TOGGLE CHASE
Tab:CreateToggle({
   Name = "Auto Chase",
   CurrentValue = false,
   Callback = function(v)
      enabled = v
   end,
})

-- LOOP
RunService.RenderStepped:Connect(function()
	if not enabled then return end

	local char = player.Character
	if not char then return end

	local hum = char:FindFirstChildOfClass("Humanoid")
	local root = char:FindFirstChild("HumanoidRootPart")
	if not hum or not root then return end

	local target = getTarget()
	if not target then return end

	local tRoot = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
	if not tRoot then return end

	local direction = (tRoot.Position - root.Position)

	if direction.Magnitude > 2 then
		hum.WalkSpeed = SPEED
		hum:Move(direction.Unit)
	else
		hum:Move(Vector3.zero)
	end
end)
