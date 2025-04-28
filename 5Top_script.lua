local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))

-- Criando o fundo do painel com tema Cobra Kai
local background = Instance.new("ImageButton")
background.Size = UDim2.new(0.2, 0, 0.1, 0)
background.Position = UDim2.new(0, 10, 0, 10)
background.BackgroundTransparency = 1
background.Image = "https://tr.rbxcdn.com/1f3c2c75d9b18e5b7874d9f9c7b0e370/420/420/Image/Png"
background.Parent = screenGui

local title = Instance.new("TextLabel", background)
title.Size = UDim2.new(1, 0, 1, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Cobra Kai"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.Fantasy
title.TextScaled = true

-- Tela preta do painel
local panel = Instance.new("Frame", screenGui)
panel.Size = UDim2.new(0.7, 0, 0.7, 0)
panel.Position = UDim2.new(0.15, 0, 0.15, 0)
panel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
panel.BackgroundTransparency = 0.5
panel.Visible = false

-- Texto explicativo para os botões
local textPanel = Instance.new("Frame", panel)
textPanel.Size = UDim2.new(1, 0, 0.1, 0)
textPanel.Position = UDim2.new(0, 0, 0, 0)
textPanel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
textPanel.BackgroundTransparency = 0.8

-- Função para adicionar emoji com texto
local function addTextWithEmoji(emoji, text, position)
    local label = Instance.new("TextLabel", textPanel)
    label.Size = UDim2.new(1, 0, 0.1, 0)
    label.Position = position
    label.BackgroundTransparency = 1
    label.Text = emoji .. " " .. text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.SourceSans
    label.TextScaled = true
end

-- Adicionando os textos explicativos
addTextWithEmoji("🏋‍♂️", "Push up", UDim2.new(0, 0, 0, 0))
addTextWithEmoji("🏃‍➡️", "Voo", UDim2.new(0, 0, 0.1, 0))
addTextWithEmoji("🙅‍♂️", "Titã", UDim2.new(0, 0, 0.2, 0))
addTextWithEmoji("🕴🤺", "Ataque na zona segura", UDim2.new(0, 0, 0.3, 0))
addTextWithEmoji("🧑‍🦲", "Atravessar parede", UDim2.new(0, 0, 0.4, 0))
addTextWithEmoji("💪🏻", "Apertar o dumbell", UDim2.new(0, 0, 0.5, 0))

-- Botões do painel
local buttonsInfo = {
    {Name = "Push up", Color = Color3.fromRGB(255, 0, 0), Action = function() autoPushUp() end},
    {Name = "Voo", Color = Color3.fromRGB(0, 255, 0), Action = function() toggleFlight() end},
    {Name = "Titã", Color = Color3.fromRGB(255, 165, 0), Action = function() becomeTitan() end},
    {Name = "Ataque na zona segura", Color = Color3.fromRGB(255, 255, 0), Action = function() attackInSafeZone() end},
    {Name = "Atravessar paredes", Color = Color3.fromRGB(128, 0, 128), Action = function() toggleNoClip() end},
    {Name = "Apertar o Dumbell", Color = Color3.fromRGB(34, 139, 34), Action = function() autoFarmStrength() end}
}

local buttons = {}

for i, info in ipairs(buttonsInfo) do
    local btn = Instance.new("TextButton", panel)
    btn.Size = UDim2.new(0.8, 0, 0.08, 0)
    btn.Position = UDim2.new(0.1, 0, 0.05 + (i-1)*0.1, 0)
    btn.Text = info.Name
    btn.BackgroundColor3 = info.Color
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextScaled = true
    btn.MouseButton1Click:Connect(info.Action)
    table.insert(buttons, btn)
end

-- Funções

local function autoPushUp()
    -- Automático, não precisa clicar
    while true do
        local remote = nil
        for _, v in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
            if v:IsA("RemoteEvent") and (string.find(string.lower(v.Name), "push") or string.find(string.lower(v.Name), "workout")) then
                remote = v
                break
            end
        end
        if remote then
            remote:FireServer()
        end
        wait(0.05)
    end
end

local flying = false
local bodyVelocity = nil

local function toggleFlight()
    if not flying then
        flying = true
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = character:WaitForChild("HumanoidRootPart")
    else
        flying = false
        if bodyVelocity then
            bodyVelocity:Destroy()
            bodyVelocity = nil
        end
    end
end

local function becomeTitan()
    local bodyScale = character:WaitForChild("Humanoid").BodyScale
    bodyScale.HeadScale.Value = 2  -- Aumenta o tamanho do Titã
    bodyScale.BodyWidthScale.Value = 2
    bodyScale.BodyHeightScale.Value = 2
end

local attackInSafeZoneActive = false
local function attackInSafeZone()
    while attackInSafeZoneActive do
        for _, enemy in pairs(workspace:GetChildren()) do
            if enemy:IsA("Model") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                local distance = (character.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude
                if distance < 20 then  -- Verifica se está dentro de 20 studs
                    local enemyHumanoid = enemy:FindFirstChild("Humanoid")
                    if enemyHumanoid and game.Players:GetPlayerFromCharacter(enemy) then
                        enemyHumanoid:TakeDamage(10)
                    end
                end
            end
        end
        wait(1)
    end
end

local noclip = false
local function toggleNoClip()
    noclip = not noclip
end

game:GetService("RunService").Stepped:Connect(function()
    if noclip then
        for _, v in ipairs(character:GetChildren()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)

local autoStrength = false
local function autoFarmStrength()
    autoStrength = not autoStrength
    while autoStrength do
        local args = { [1] = 1 }
        pcall(function()
            player.Character.Dumbell.Event:FireServer(unpack(args))
        end)
        wait(0.1)
    end
end

-- Mostrar/Ocultar painel
background.MouseButton1Click:Connect(function()
    panel.Visible = not panel.Visible
end)
