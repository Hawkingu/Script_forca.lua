local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Criando o quadro de fundo para os botões (Tema)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.3, 0, 0.3, 0)
frame.Position = UDim2.new(0.35, 0, 0.35, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.5
frame.Parent = screenGui

-- Botão para alternar invisibilidade
local invisibilityButton = Instance.new("TextButton")
invisibilityButton.Size = UDim2.new(0.8, 0, 0.3, 0)
invisibilityButton.Position = UDim2.new(0.1, 0, 0.1, 0)
invisibilityButton.Text = "Alternar Invisibilidade"
invisibilityButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
invisibilityButton.TextColor3 = Color3.fromRGB(255, 255, 255)
invisibilityButton.Parent = frame

-- Botão para teleporte
local teleportButton = Instance.new("TextButton")
teleportButton.Size = UDim2.new(0.8, 0, 0.3, 0)
teleportButton.Position = UDim2.new(0.1, 0, 0.5, 0)
teleportButton.Text = "Teleportar para Jogador"
teleportButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportButton.Parent = frame

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

-- Função para teleportar para outro jogador
local function teleportToPlayer(targetPlayer)
    local targetCharacter = targetPlayer.Character
    if targetCharacter and targetCharacter:FindFirstChild("HumanoidRootPart") then
        player.Character:SetPrimaryPartCFrame(targetCharacter.HumanoidRootPart.CFrame)
    end
end

-- Alternar invisibilidade ao clicar no botão
invisibilityButton.MouseButton1Click:Connect(function()
    if character:FindFirstChild("HumanoidRootPart").Transparency == 1 then
        restoreVisibility()
    else
        becomeInvisible()
    end
end)

-- Teleportar para outro jogador
teleportButton.MouseButton1Click:Connect(function()
    -- Exemplo de nome de jogador. Você pode usar uma caixa de texto ou algo interativo para pegar o nome de um jogador
    local targetPlayer = game.Players:FindFirstChild("Player1") -- Substitua pelo nome de jogador real ou interativo
    if targetPlayer then
        teleportToPlayer(targetPlayer)
    else
        print("Jogador não encontrado!")
    end
end)

-- Função para alternar o tema de fundo
local themeVisible = true
local function toggleTheme()
    themeVisible = not themeVisible
    frame.Visible = themeVisible
end

-- Teclas para mostrar/ocultar o tema
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Equals then
        toggleTheme()  -- Tecla "+" para alternar o tema
    elseif input.KeyCode == Enum.KeyCode.Minus then
        toggleTheme()  -- Tecla "-" para alternar o tema
    end
end)
