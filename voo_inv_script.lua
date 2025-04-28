local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Criar o fundo da tela para o botão do "executor falso"
local background = Instance.new("Frame")
background.Size = UDim2.new(0.2, 0, 0.2, 0)
background.Position = UDim2.new(0.4, 0, 0.4, 0)
background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
background.BackgroundTransparency = 0.5
background.Parent = screenGui

-- Botão com a imagem do Cobra Kai
local imageButton = Instance.new("ImageButton")
imageButton.Size = UDim2.new(1, 0, 1, 0)
imageButton.Position = UDim2.new(0, 0, 0, 0)
imageButton.Image = "https://www.robloxcatalog.com/thumbs/157459984.png" -- Imagem do Cobra Kai (substitua com a URL correta, se necessário)
imageButton.BackgroundTransparency = 1
imageButton.Parent = background

-- Criar o painel que aparecerá quando clicar no botão
local panel = Instance.new("Frame")
panel.Size = UDim2.new(0.8, 0, 0.6, 0)
panel.Position = UDim2.new(0.1, 0, 0.1, 0)
panel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
panel.BackgroundTransparency = 0.7
panel.Visible = false  -- O painel começa invisível
panel.Parent = screenGui

-- Botão para alternar invisibilidade
local invisibilityButton = Instance.new("TextButton")
invisibilityButton.Size = UDim2.new(0.8, 0, 0.3, 0)
invisibilityButton.Position = UDim2.new(0.1, 0, 0.1, 0)
invisibilityButton.Text = "Alternar Invisibilidade"
invisibilityButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
invisibilityButton.TextColor3 = Color3.fromRGB(255, 255, 255)
invisibilityButton.Parent = panel

-- Botão para ativar/desativar voo
local flightButton = Instance.new("TextButton")
flightButton.Size = UDim2.new(0.8, 0, 0.3, 0)
flightButton.Position = UDim2.new(0.1, 0, 0.5, 0)
flightButton.Text = "Alternar Voo"
flightButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
flightButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flightButton.Parent = panel

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

-- Função para alternar voo
local flying = false
local bodyVelocity = nil
local function startFlying()
    if not flying then
        flying = true
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000) -- Ajusta a força de voo
        bodyVelocity.Velocity = Vector3.new(0, 50, 0) -- Ajusta a direção e velocidade do voo
        bodyVelocity.Parent = character:WaitForChild("HumanoidRootPart")
    end
end

local function stopFlying()
    if flying then
        flying = false
        if bodyVelocity then
            bodyVelocity:Destroy()
            bodyVelocity = nil
        end
    end
end

-- Função para alternar entre invisibilidade
local function toggleInvisibility()
    if character:FindFirstChild("HumanoidRootPart").Transparency == 1 then
        restoreVisibility()
    else
        becomeInvisible()
    end
end

-- Função para alternar entre voo
local function toggleFlight()
    if flying then
        stopFlying()
    else
        startFlying()
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

-- Função para alternar o painel
local function togglePanel()
    panel.Visible = not panel.Visible
end

-- Quando o jogador clicar no botão de imagem do Cobra Kai, o painel aparecerá
imageButton.MouseButton1Click:Connect(function()
    togglePanel()  -- Alterna a visibilidade do painel com as opções
end)
