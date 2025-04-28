-- Painel GUI + Farm Automático de Vida e Força

-- Primeiro, criar o GUI
local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Criar a tela principal
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "PainelVidaForca"

-- Botão de abrir/fechar o painel
local toggleButton = Instance.new("TextButton", screenGui)
toggleButton.Size = UDim2.new(0, 60, 0, 60)
toggleButton.Position = UDim2.new(1, -70, 0, 10)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
toggleButton.Text = "🐍🪽+"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextScaled = true
toggleButton.BackgroundTransparency = 0.3
toggleButton.AnchorPoint = Vector2.new(0, 0)

-- Painel de Vida e Força
local panel = Instance.new("Frame", screenGui)
panel.Size = UDim2.new(0, 200, 0, 100)
panel.Position = UDim2.new(0.5, -100, 0.1, 0)
panel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
panel.BackgroundTransparency = 0.4
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

-- Scripts de Farm de Vida e Força
local replicatedStorage = game:GetService("ReplicatedStorage")

local vidaEvent = replicatedStorage:WaitForChild("Branco")  -- RemoteEvent da Vida
local forcaEvent = player.Character:WaitForChild("Dumbell"):WaitForChild("Event")  -- RemoteEvent da Força

-- Variável de Controle
local farming = false

-- Função para começar/parar o farm
local function toggleFarm()
    farming = not farming
    panel.Visible = farming
    
    if farming then
        task.spawn(function()
            while farming do
                -- Dispara o evento da Vida
                pcall(function()
                    vidaEvent:FireServer()
                end)
                -- Dispara o evento da Força
                pcall(function()
                    forcaEvent:FireServer(1) -- Se precisar mudar o valor, edite aqui
                end)
                task.wait(2) -- Intervalo seguro de 2 segundos
            end
        end)
    end
end

-- Conectar botão para abrir/fechar
toggleButton.MouseButton1Click:Connect(toggleFarm)

print("Painel Vida+5 e Força+5 carregado com sucesso!")
