local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Criar o fundo da tela para o botão do "executor falso"
local background = Instance.new("Frame")
background.Size = UDim2.new(0.2, 0, 0.2, 0)
background.Position = UDim2.new(0.4, 0, 0, 0)  -- Colocado no canto superior
background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  -- Quadrado branco
background.BackgroundTransparency = 0.5
background.Parent = screenGui

-- Botão com o texto "Cobra Kai"
local textButton = Instance.new("TextButton")
textButton.Size = UDim2.new(1, 0, 1, 0)
textButton.Position = UDim2.new(0, 0, 0, 0)
textButton.Text = "Cobra Kai"
textButton.Font = Enum.Font.SourceSansBold
textButton.TextSize = 24
textButton.TextColor3 = Color3.fromRGB(0, 0, 0)  -- Texto preto
textButton.BackgroundTransparency = 1  -- Sem fundo
textButton.Parent = background

-- Criar o painel que aparecerá quando clicar no botão
local panel = Instance.new("Frame")
panel.Size = UDim2.new(0.8, 0, 0.6, 0)
panel.Position = UDim2.new(0.1, 0, 0.1, 0)
panel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
panel.BackgroundTransparency = 0.7
panel.Visible = false  -- O painel começa invisível
panel.Parent = screenGui

-- Botões para funcionalidades
local invisibilityButton = Instance.new("TextButton")
invisibilityButton.Size = UDim2.new(0.8, 0, 0.3, 0)
invisibilityButton.Position = UDim2.new(0.1, 0, 0.1, 0)
invisibilityButton.Text = "Alternar Invisibilidade"
invisibilityButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
invisibilityButton.TextColor3 = Color3.fromRGB(255, 255, 255)
invisibilityButton.Parent = panel

local flightButton = Instance.new("TextButton")
flightButton.Size = UDim2.new(0.8, 0, 0.3, 0)
flightButton.Position = UDim2.new(0.1, 0, 0.5, 0)
flightButton.Text = "Alternar Voo"
flightButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
flightButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flightButton.Parent = panel

local speedButton = Instance.new("TextButton")
speedButton.Size = UDim2.new(0.8, 0, 0.3, 0)
speedButton.Position = UDim2.new(0.1, 0, 0.9, 0)
speedButton.Text = "Correr Rápido"
speedButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
speedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
speedButton.Parent = panel

local healButton = Instance.new("TextButton")
healButton.Size = UDim2.new(0.8, 0, 0.3, 0)
healButton.Position = UDim2.new(0.1, 0, 1.3, 0)
healButton.Text = "Vida Instantânea"
healButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
healButton.TextColor3 = Color3.fromRGB(255, 255, 255)
healButton.Parent = panel

-- Função para tornar o jogador invisível
local function becomeInvisible()
    for _, part in ipairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            part.Transparency = 1
            part.CanCollide = false
        end
    end
end

-- Função para restaurar visibilidade
local function restoreVisibility()
    for _, part in ipairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            part.Transparency = 0
            part.CanCollide = true
        end
    end
end

-- Função para ativar voo
local flying = false
local bodyVelocity = nil
local flyingDirection = Vector3.new(0, 0, 0)

local function startFlying()
    if not flying then
        flying = true
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)  -- Ajusta a força do voo
        bodyVelocity.Velocity = flyingDirection  -- Inicializa a direção do voo
        bodyVelocity.Parent = character:WaitForChild("HumanoidRootPart")
    end
end

-- Função para parar voo
local function stopFlying()
    if flying then
        flying = false
        if bodyVelocity then
            bodyVelocity:Destroy()
            bodyVelocity = nil
        end
    end
end

-- Função para alternar voo
local function toggleFlight()
    if flying then
        stopFlying()
    else
        startFlying()
    end
end

-- Função para correr rápido
local function enableSpeed()
    humanoid.WalkSpeed = 100  -- Ajuste para velocidade de corrida (padrão é 16)
end

-- Função para voltar à velocidade normal
local function disableSpeed()
    humanoid.WalkSpeed = 16  -- Velocidade padrão
end

-- Função para restaurar vida
local function heal()
    humanoid.Health = humanoid.MaxHealth  -- Cura instantânea
end

-- Função para alternar entre invisibilidade
local function toggleInvisibility()
    if character:FindFirstChild("HumanoidRootPart").Transparency == 1 then
        restoreVisibility()
    else
        becomeInvisible()
    end
end

-- Ação do botão de invisibilidade
invisibilityButton.MouseButton1Click:Connect(function()
    toggleInvisibility()
end)

-- Ação do botão de voo
flightButton.MouseButton1Click:Connect(function()
    toggleFlight()
end)

-- Ação do botão de corrida
speedButton.MouseButton1Click:Connect(function()
    if humanoid.WalkSpeed == 16 then
        enableSpeed()
    else
        disableSpeed()
    end
end)

-- Ação do botão de vida instantânea
healButton.MouseButton1Click:Connect(function()
    heal()
end)

-- Função para alternar o painel
local function togglePanel()
    panel.Visible = not panel.Visible
end

-- Quando o jogador clicar no botão de texto "Cobra Kai", o painel aparecerá
textButton.MouseButton1Click:Connect(function()
    togglePanel()  -- Alterna a visibilidade do painel com as opções
end)

-- Atualizar a direção do voo constantemente
game:GetService("RunService").Heartbeat:Connect(function()
    if flying then
        flyingDirection = Vector3.new(0, humanoid.MoveDirection.Y, humanoid.MoveDirection.Z) * 50  -- Ajuste a multiplicação para a velocidade do voo
        if bodyVelocity then
            bodyVelocity.Velocity = flyingDirection
        end
    end
end)
