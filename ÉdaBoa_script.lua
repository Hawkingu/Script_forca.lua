-- Painel GUI + Botão de Abrir/Fechar Painel + Vida+5 e Força+5 Automático

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
panel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
panel.BackgroundTransparency = 0.2
panel.AnchorPoint = Vector2.new(0.5, 0)
panel.Visible = false
panel.Parent = screenGui

-- Deixar o painel com pontas arredondadas
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = panel

-- Texto Vida+5
local vidaLabel = Instance.new("TextLabel")
vidaLabel.Size = UDim2.new(1, 0, 0.5, 0)
vidaLabel.Position = UDim2.new(0, 0, 0, 0)
vidaLabel.Text = "Vida +5"
vidaLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
vidaLabel.BackgroundTransparency = 1
vidaLabel.TextScaled = true
vidaLabel.Font = Enum.Font.GothamBold
vidaLabel.Parent = panel

-- Texto Força+5
local forcaLabel = Instance.new("TextLabel")
forcaLabel.Size = UDim2.new(1, 0, 0.5, 0)
forcaLabel.Position = UDim2.new(0, 0, 0.5, 0)
forcaLabel.Text = "Força +5"
forcaLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
forcaLabel.BackgroundTransparency = 1
forcaLabel.TextScaled = true
forcaLabel.Font = Enum.Font.GothamBold
forcaLabel.Parent = panel

-- Procurar os eventos (Branco = Vida e Dumbell = Força)
local replicatedStorage = game:GetService("ReplicatedStorage")
local vidaEvent = replicatedStorage:FindFirstChild("Branco")
local forcaEvent = nil

local function encontrarEventoForca()
    local char = player.Character or player.CharacterAdded:Wait()
    for _, v in ipairs(char:GetChildren()) do
        if v:IsA("Tool") and v:FindFirstChild("Event") then
            return v.Event
        end
    end
    return nil
end

-- Farmar Vida e Força
local farming = false

local function iniciarFarm()
    farming = true
    forcaEvent = encontrarEventoForca()
    if not vidaEvent then
        warn("Evento de Vida (Branco) não encontrado!")
    end
    if not forcaEvent then
        warn("Evento de Força não encontrado!")
    end

    while farming do
        if vidaEvent then
            pcall(function()
                vidaEvent:FireServer()
            end)
        end
        if forcaEvent then
            pcall(function()
                forcaEvent:FireServer(1)
            end)
        end
        task.wait(2) -- Espera 2 segundos para cada execução
    end
end

local function pararFarm()
    farming = false
end

-- Botão para abrir/fechar painel e iniciar/parar farm
toggleButton.MouseButton1Click:Connect(function()
    panel.Visible = not panel.Visible

    if panel.Visible then
        iniciarFarm()
    else
        pararFarm()
    end
end)

print("Painel bonito + farm automático pronto!")
