-- Painel GUI + Farm Automático de Vida e Força + Animação Suave

local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Criar o GUI
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "PainelVidaForca"

-- Botão de abrir/fechar o painel (Lado Esquerdo)
local toggleButton = Instance.new("TextButton", screenGui)
toggleButton.Size = UDim2.new(0, 60, 0, 60)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
toggleButton.Text = "🐍🪽+"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextScaled = true
toggleButton.BackgroundTransparency = 0.3
toggleButton.AnchorPoint = Vector2.new(0, 0)

-- Painel
local panel = Instance.new("Frame", screenGui)
panel.Size = UDim2.new(0, 200, 0, 100)
panel.Position = UDim2.new(0.5, -100, 0.1, 0)
panel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
panel.BackgroundTransparency = 1 -- Começa invisível
panel.Visible = false
panel.AnchorPoint = Vector2.new(0.5, 0)

-- Texto Vida+5
local vidaLabel = Instance.new("TextLabel", panel)
vidaLabel.Size = UDim2.new(1, 0, 0.5, 0)
vidaLabel.Position = UDim2.new(0, 0, 0, 0)
vidaLabel.Text = "Vida +5"
vidaLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
vidaLabel.BackgroundTransparency = 1
vidaLabel.TextScaled = true

-- Texto Força+5
local forcaLabel = Instance.new("TextLabel", panel)
forcaLabel.Size = UDim2.new(1, 0, 0.5, 0)
forcaLabel.Position = UDim2.new(0, 0, 0.5, 0)
forcaLabel.Text = "Força +5"
forcaLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
forcaLabel.BackgroundTransparency = 1
forcaLabel.TextScaled = true

-- RemoteEvents
local replicatedStorage = game:GetService("ReplicatedStorage")
local vidaEvent = replicatedStorage:WaitForChild("Branco") -- Event da Vida

-- Procurar automaticamente o evento da Força
local function encontrarEventoForca()
    local char = player.Character or player.CharacterAdded:Wait()
    for _, v in pairs(char:GetChildren()) do
        if v:IsA("Tool") and v:FindFirstChild("Event") then
            return v.Event
        end
    end
    return nil
end

-- Função de Animação Suave
local function animarPainel(mostrar)
    panel.Visible = true
    local transparenciaInicial = mostrar and 1 or 0.4
    local transparenciaFinal = mostrar and 0.4 or 1
    local tempo = 0.5 -- Tempo da animação em segundos
    local inicio = tick()

    while tick() - inicio < tempo do
        local porcentagem = (tick() - inicio) / tempo
        local transparencia = transparenciaInicial + (transparenciaFinal - transparenciaInicial) * porcentagem
        panel.BackgroundTransparency = transparencia
        task.wait()
    end

    panel.BackgroundTransparency = transparenciaFinal
    if not mostrar then
        panel.Visible = false
    end
end

-- Variável de controle
local farming = false

-- Função para iniciar/parar farm
local function toggleFarm()
    farming = not farming

    task.spawn(function()
        animarPainel(farming)
    end)

    if farming then
        task.spawn(function()
            local forcaEvent = encontrarEventoForca()
            if not forcaEvent then
                warn("Não encontrei o Event de Força!")
                return
            end
            while farming do
                pcall(function()
                    vidaEvent:FireServer()
                end)
                pcall(function()
                    forcaEvent:FireServer(1)
                end)
                task.wait(2)
            end
        end)
    end
end

-- Conectar botão
toggleButton.MouseButton1Click:Connect(toggleFarm)

print("Painel Vida+5 e Força+5 carregado com animação suave!")
