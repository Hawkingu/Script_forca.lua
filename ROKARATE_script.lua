local plr = game.Players.LocalPlayer

-- GUI Principal
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "RoKaratePainel"

-- Painel principal (frame)
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 300)
frame.Position = UDim2.new(0, 10, 0, 200)
frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
frame.BorderSizePixel = 2
frame.Name = "PainelPrincipal"

-- Botão de abrir/fechar
local toggleBtn = Instance.new("TextButton", gui)
toggleBtn.Size = UDim2.new(0, 120, 0, 30)
toggleBtn.Position = UDim2.new(0, 10, 0, 170)
toggleBtn.Text = "Fechar Painel"
toggleBtn.BackgroundColor3 = Color3.new(1, 1, 1)
toggleBtn.TextColor3 = Color3.new(0, 0, 0)
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 16

local painelVisivel = true
toggleBtn.MouseButton1Click:Connect(function()
    painelVisivel = not painelVisivel
    frame.Visible = painelVisivel
    toggleBtn.Text = painelVisivel and "Fechar Painel" or "Abrir Painel"
end)

-- Função para criar botões
local function criarBotao(texto, pos, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0, 100, 0, 30)
    btn.Position = pos
    btn.Text = texto
    btn.BackgroundColor3 = Color3.new(1, 1, 1)
    btn.TextColor3 = Color3.new(0, 0, 0)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Função para mover o painel arrastando
local dragging
local dragInput
local dragStart
local startPos

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Movimento
local function mover(direcao)
    local char = plr.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local cf = char.HumanoidRootPart.CFrame
    local v3 = Vector3.new()
    if direcao == "Frente" then
        v3 = cf.LookVector
    elseif direcao == "Trás" then
        v3 = -cf.LookVector
    elseif direcao == "Direita" then
        v3 = cf.RightVector
    elseif direcao == "Esquerda" then
        v3 = -cf.RightVector
    end
    char:TranslateBy(v3 * 5)
end

-- Botões de movimentação
criarBotao("Frente", UDim2.new(0, 75, 0, 10), function() mover("Frente") end)
criarBotao("Trás", UDim2.new(0, 75, 0, 90), function() mover("Trás") end)
criarBotao("Esquerda", UDim2.new(0, 10, 0, 50), function() mover("Esquerda") end)
criarBotao("Direita", UDim2.new(0, 140, 0, 50), function() mover("Direita") end)

-- Controle de farm
local autoSoco = false
local autoPushup = false
local autoSitup = false

-- Auto Soco
criarBotao("Auto Soco", UDim2.new(0, 10, 0, 140), function()
    autoSoco = not autoSoco
    if autoSoco then
        spawn(function()
            while autoSoco do
                wait(0.3)
                game:GetService("ReplicatedStorage").Combat:FireServer("Left Punch")
            end
        end)
    end
end)

-- Auto Pushup (sem travar)
criarBotao("Auto Pushup", UDim2.new(0, 130, 0, 140), function()
    autoPushup = not autoPushup
    if autoPushup then
        spawn(function()
            while autoPushup do
                wait(1)
                local char = plr.Character
                if char and char:FindFirstChild("Humanoid") and char:FindFirstChild("Animator") then
                    char.Humanoid.Animator:Destroy()
                end
                game:GetService("ReplicatedStorage").Pushup:FireServer()
            end
        end)
    end
end)

-- Auto Situp (sem travar)
criarBotao("Auto Situp", UDim2.new(0, 70, 0, 180), function()
    autoSitup = not autoSitup
    if autoSitup then
        spawn(function()
            while autoSitup do
                wait(1)
                local char = plr.Character
                if char and char:FindFirstChild("Humanoid") and char:FindFirstChild("Animator") then
                    char.Humanoid.Animator:Destroy()
                end
                game:GetService("ReplicatedStorage").Situp:FireServer()
            end
        end)
    end
end)
