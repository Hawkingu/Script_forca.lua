-- Painel Auto Vida (movimentável)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Criar ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Criar Frame principal
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 120)
mainFrame.Position = UDim2.new(0.35, 0, 0.25, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true -- Permite arrastar
mainFrame.Parent = screenGui

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
title.Text = "Painel Auto Vida"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Parent = mainFrame

-- Variável para loop de vida
local autoVida = false

-- Função Auto Vida
local function startVida()
	if autoVida then return end
	autoVida = true
	task.spawn(function()
		while autoVida do
			-- Manda o evento de ganhar vida (ajusta se o Remote for diferente)
			ReplicatedStorage.Combat:FireServer("Pushup") 
			task.wait(0.06) -- 60 milissegundos
		end
	end)
end

local function stopVida()
	autoVida = false
end

-- Botão Ativar
local btnOn = Instance.new("TextButton")
btnOn.Size = UDim2.new(0.45, 0, 0.4, 0)
btnOn.Position = UDim2.new(0.05, 0, 0.45, 0)
btnOn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
btnOn.Text = "Ativar Auto Vida"
btnOn.TextScaled = true
btnOn.Parent = mainFrame
btnOn.MouseButton1Click:Connect(startVida)

-- Botão Desativar
local btnOff = Instance.new("TextButton")
btnOff.Size = UDim2.new(0.45, 0, 0.4, 0)
btnOff.Position = UDim2.new(0.5, 0, 0.45, 0)
btnOff.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
btnOff.Text = "Desativar Auto Vida"
btnOff.TextScaled = true
btnOff.Parent = mainFrame
btnOff.MouseButton1Click:Connect(stopVida)
