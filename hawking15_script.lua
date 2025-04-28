-- Criando a Interface
local ScreenGui = Instance.new("ScreenGui")
local OpenButton = Instance.new("TextButton")
local Panel = Instance.new("Frame")
local CloseButton = Instance.new("TextButton")

-- Botões de funções
local FlyButton = Instance.new("TextButton")
local NoclipButton = Instance.new("TextButton")
local BubbleOnButton = Instance.new("TextButton")
local BubbleOffButton = Instance.new("TextButton")
local TouchKillButton = Instance.new("TextButton")

-- Configurações da GUI
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "HawkPanel"

-- Botão Hawk[+]
OpenButton.Parent = ScreenGui
OpenButton.Position = UDim2.new(0, 10, 0, 10)
OpenButton.Size = UDim2.new(0, 100, 0, 40)
OpenButton.Text = "Hawk[+]"
OpenButton.BackgroundColor3 = Color3.new(0,0,0)
OpenButton.TextColor3 = Color3.new(1,1,1)
OpenButton.BorderSizePixel = 0

-- Painel
Panel.Parent = ScreenGui
Panel.Position = UDim2.new(0, 10, 0, 60)
Panel.Size = UDim2.new(0, 200, 0, 300)
Panel.BackgroundColor3 = Color3.new(0,0,0)
Panel.BorderSizePixel = 0
Panel.Visible = false

-- Botão Hawk[-]
CloseButton.Parent = Panel
CloseButton.Position = UDim2.new(0, 150, 0, 0)
CloseButton.Size = UDim2.new(0, 50, 0, 30)
CloseButton.Text = "Hawk[-]"
CloseButton.BackgroundColor3 = Color3.new(1,0,0)
CloseButton.TextColor3 = Color3.new(1,1,1)
CloseButton.BorderSizePixel = 0

-- Botão Voo
FlyButton.Parent = Panel
FlyButton.Position = UDim2.new(0, 10, 0, 40)
FlyButton.Size = UDim2.new(0, 180, 0, 40)
FlyButton.Text = "Ativar Voo"
FlyButton.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
FlyButton.TextColor3 = Color3.new(1,1,1)
FlyButton.BorderSizePixel = 0

-- Botão Atravessar Paredes
NoclipButton.Parent = Panel
NoclipButton.Position = UDim2.new(0, 10, 0, 90)
NoclipButton.Size = UDim2.new(0, 180, 0, 40)
NoclipButton.Text = "Atravessar Paredes"
NoclipButton.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
NoclipButton.TextColor3 = Color3.new(1,1,1)
NoclipButton.BorderSizePixel = 0

-- Botão Ativar Bolha
BubbleOnButton.Parent = Panel
BubbleOnButton.Position = UDim2.new(0, 10, 0, 140)
BubbleOnButton.Size = UDim2.new(0, 180, 0, 40)
BubbleOnButton.Text = "Ativar Bolha"
BubbleOnButton.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
BubbleOnButton.TextColor3 = Color3.new(1,1,1)
BubbleOnButton.BorderSizePixel = 0

-- Botão Desativar Bolha
BubbleOffButton.Parent = Panel
BubbleOffButton.Position = UDim2.new(0, 10, 0, 190)
BubbleOffButton.Size = UDim2.new(0, 180, 0, 40)
BubbleOffButton.Text = "Desativar Bolha"
BubbleOffButton.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
BubbleOffButton.TextColor3 = Color3.new(1,1,1)
BubbleOffButton.BorderSizePixel = 0

-- Botão Tocar e Matar
TouchKillButton.Parent = Panel
TouchKillButton.Position = UDim2.new(0, 10, 0, 240)
TouchKillButton.Size = UDim2.new(0, 180, 0, 40)
TouchKillButton.Text = "Matar no Toque"
TouchKillButton.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
TouchKillButton.TextColor3 = Color3.new(1,1,1)
TouchKillButton.BorderSizePixel = 0

-- Funções dos Botões
OpenButton.MouseButton1Click:Connect(function()
	Panel.Visible = true
end)

CloseButton.MouseButton1Click:Connect(function()
	Panel.Visible = false
end)

FlyButton.MouseButton1Click:Connect(function()
	local flying = false
	local player = game.Players.LocalPlayer
	local character = player.Character
	local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
	
	local bodyVelocity = Instance.new("BodyVelocity", humanoidRootPart)
	bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
	
	flying = true
	
	while flying do
		local moveDirection = player:GetMouse().Hit.LookVector
		bodyVelocity.Velocity = moveDirection * 50
		wait()
	end
end)

NoclipButton.MouseButton1Click:Connect(function()
	local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	
	game:GetService('RunService').Stepped:Connect(function()
		for _, part in pairs(character:GetDescendants()) do
			if part:IsA('BasePart') then
				part.CanCollide = false
			end
		end
	end)
end)

BubbleOnButton.MouseButton1Click:Connect(function()
	local character = game.Players.LocalPlayer.Character
	if character then
		local forceField = Instance.new("ForceField", character)
		forceField.Name = "BubbleShield"
	end
end)

BubbleOffButton.MouseButton1Click:Connect(function()
	local character = game.Players.LocalPlayer.Character
	if character then
		local shield = character:FindFirstChild("BubbleShield")
		if shield then
			shield:Destroy()
		end
	end
end)

TouchKillButton.MouseButton1Click:Connect(function()
	local character = game.Players.LocalPlayer.Character
	local hrp = character:WaitForChild("HumanoidRootPart")
	
	hrp.Touched:Connect(function(hit)
		local enemy = hit.Parent:FindFirstChild("Humanoid")
		if enemy and hit.Parent ~= character then
			enemy.Health = 0
			hit.Parent:MoveTo(Vector3.new(9999,9999,9999)) -- Joga pra longe
		end
	end)
end)
