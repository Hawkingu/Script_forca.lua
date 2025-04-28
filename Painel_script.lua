-- Painel GUI + Botão de Abrir/Fechar Painel (com Pontas Arredondadas)

local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Criar o GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PainelVidaForca"
screenGui.Parent = playerGui

-- Botão de abrir/fechar o painel (Lado Esquerdo)
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 60, 0, 60)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
toggleButton.Text = "🐍🪽+"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextScaled = true
toggleButton.BackgroundTransparency = 0.3
toggleButton.AnchorPoint = Vector2.new(0, 0)
toggleButton.Parent = screenGui

-- Painel
local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 220, 0, 120)
panel.Position = UDim2.new(0.5, -110, 0.1, 0)
panel.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- Preto mais bonito
panel.BackgroundTransparency = 0.2
panel.AnchorPoint = Vector2.new(0.5, 0)
panel.Visible = false
panel.Parent = screenGui

-- Deixar as pontas arredondadas
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15) -- Deixa bem redondinho
corner.Parent = panel

-- Texto Vida+5
local vidaLabel = Instance.new("TextLabel")
vidaLabel.Size = UDim2.new(1, 0, 0.5, 0)
vidaLabel.Position = UDim2.new(0, 0, 0, 0)
vidaLabel.Text = "Vida +5"
vidaLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
vidaLabel.BackgroundTransparency = 1
vidaLabel.TextScaled = true
vidaLabel.Font = Enum.Font.GothamBold -- Fonte bonita
vidaLabel.Parent = panel

-- Texto Força+5
local forcaLabel = Instance.new("TextLabel")
forcaLabel.Size = UDim2.new(1, 0, 0.5, 0)
forcaLabel.Position = UDim2.new(0, 0, 0.5, 0)
forcaLabel.Text = "Força +5"
forcaLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
forcaLabel.BackgroundTransparency = 1
forcaLabel.TextScaled = true
forcaLabel.Font = Enum.Font.GothamBold -- Fonte bonita
forcaLabel.Parent = panel

-- Abrir e Fechar o Painel
toggleButton.MouseButton1Click:Connect(function()
    panel.Visible = not panel.Visible
end)

print("Painel bonitão criado com sucesso!")
