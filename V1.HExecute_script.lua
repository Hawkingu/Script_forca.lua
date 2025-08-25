-- Painel HExecute (Vida + Stamina)
-- by Hawkingu

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local plr = Players.LocalPlayer

-- Gui principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HExecuteGUI"
screenGui.Parent = plr:WaitForChild("PlayerGui")

-- Frame principal
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 120)
frame.Position = UDim2.new(0.3, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
frame.Active = true
frame.Draggable = true
frame.Name = "MainFrame"
frame.Parent = screenGui

-- Título
local titulo = Instance.new("TextLabel")
titulo.Size = UDim2.new(1, 0, 0, 30)
titulo.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
titulo.TextColor3 = Color3.fromRGB(255, 255, 255)
titulo.Text = "HExecute"
titulo.Font = Enum.Font.SourceSansBold
titulo.TextSize = 20
titulo.Parent = frame

-- Botão Vida
local vidaBtn = Instance.new("TextButton", frame)
vidaBtn.Size = UDim2.new(1, -10, 0, 30)
vidaBtn.Position = UDim2.new(0, 5, 0, 40)
vidaBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
vidaBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
vidaBtn.Text = "Vida [❎]"
vidaBtn.Font = Enum.Font.SourceSansBold
vidaBtn.TextSize = 18

-- Botão Stamina
local staminaBtn = Instance.new("TextButton", frame)
staminaBtn.Size = UDim2.new(1, -10, 0, 30)
staminaBtn.Position = UDim2.new(0, 5, 0, 75)
staminaBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
staminaBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
staminaBtn.Text = "Stamina [❎]"
staminaBtn.Font = Enum.Font.SourceSansBold
staminaBtn.TextSize = 18

-- Variáveis de controle
local vidaAtiva = false
local staminaAtiva = false

-- Eventos corretos
local luteroEvent = ReplicatedStorage:WaitForChild("Lutero")
local staminaEvent = ReplicatedStorage:WaitForChild("AddStaminaEvent")

-- Botão Vida
vidaBtn.MouseButton1Click:Connect(function()
	vidaAtiva = not vidaAtiva
	vidaBtn.Text = "Vida [" .. (vidaAtiva and "✅" or "❎") .. "]"

	if vidaAtiva then
		task.spawn(function()
			while vidaAtiva do
				task.wait(0.02) -- 20ms
				local args = {
					[1] = "GiveHealthCuzPro",
					[2] = 2,
					[3] = 1
				}
				luteroEvent:FireServer(unpack(args))
			end
		end)
	end
end)

-- Botão Stamina
staminaBtn.MouseButton1Click:Connect(function()
	staminaAtiva = not staminaAtiva
	staminaBtn.Text = "Stamina [" .. (staminaAtiva and "✅" or "❎") .. "]"

	if staminaAtiva then
		task.spawn(function()
			while staminaAtiva do
				task.wait(0.02) -- 20ms
				staminaEvent:FireServer()
			end
		end)
	end
end)
