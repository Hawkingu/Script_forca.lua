local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.ResetOnSpawn = false

-- Fundo Preto
local background = Instance.new("Frame", screenGui)
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
background.BackgroundTransparency = 0.5

-- Painel Horizontal
local panel = Instance.new("Frame", background)
panel.Size = UDim2.new(0.9, 0, 0.1, 0)
panel.Position = UDim2.new(0.05, 0, 0.05, 0)
panel.BackgroundTransparency = 1
panel.LayoutOrder = 1

local layout = Instance.new("UIListLayout", panel)
layout.FillDirection = Enum.FillDirection.Horizontal
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 10)

-- Funções
local noclip = false
local function toggleNoClip()
    noclip = not noclip
end

game:GetService("RunService").Stepped:Connect(function()
    if noclip then
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

local bubbleActive = false
local function toggleBubble()
    bubbleActive = not bubbleActive
    if bubbleActive then
        local bubble = Instance.new("BillboardGui", character.Head)
        bubble.Name = "ResetBubble"
        bubble.Size = UDim2.new(5, 0, 5, 0)
        bubble.AlwaysOnTop = true

        local text = Instance.new("TextLabel", bubble)
        text.Size = UDim2.new(1, 0, 1, 0)
        text.BackgroundTransparency = 1
        text.Text = "Resetting..."
        text.TextColor3 = Color3.new(1, 1, 1)
        text.TextScaled = true
    else
        local bubble = character.Head:FindFirstChild("ResetBubble")
        if bubble then
            bubble:Destroy()
        end
    end
end

local function becomeTop1()
    -- Simular que você é Top 1
    for _, stat in pairs(player.leaderstats:GetChildren()) do
        if stat:IsA("IntValue") then
            stat.Value = 9999999
        end
    end
end

local attackActive = false
local function toggleTouchKill()
    attackActive = not attackActive
end

humanoid.Touched:Connect(function(hit)
    if attackActive then
        local enemy = hit.Parent:FindFirstChild("Humanoid")
        if enemy and enemy ~= humanoid then
            enemy.Health = 0
        end
    end
end)

-- Criar Botões
local buttonsInfo = {
    {Name = "🧑‍🦲 Noclip", Function = toggleNoClip},
    {Name = "🗨️ Bolha Reset", Function = toggleBubble},
    {Name = "🏆 Top 1 Leaderboard", Function = becomeTop1},
    {Name = "⚔️ Matar no Toque", Function = toggleTouchKill},
}

for _, info in ipairs(buttonsInfo) do
    local button = Instance.new("TextButton", panel)
    button.Size = UDim2.new(0, 150, 0, 50)
    button.Text = info.Name
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextScaled = true
    button.MouseButton1Click:Connect(info.Function)
end
