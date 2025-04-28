local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Tema reduzido pra caber melhor na tela do celular
local background = Instance.new("Frame")
background.Size = UDim2.new(0.15, 0, 0.1, 0)
background.Position = UDim2.new(0, 10, 0, 10) -- Canto superior esquerdo
background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
background.BackgroundTransparency = 0.5
background.Parent = screenGui

local textButton = Instance.new("TextButton")
textButton.Size = UDim2.new(1, 0, 1, 0)
textButton.Position = UDim2.new(0, 0, 0, 0)
textButton.Text = "Cobra Kai"
textButton.Font = Enum.Font.SourceSansBold
textButton.TextSize = 18
textButton.TextColor3 = Color3.fromRGB(0, 0, 0)
textButton.BackgroundTransparency = 1
textButton.Parent = background

local panel = Instance.new("Frame")
panel.Size = UDim2.new(0.7, 0, 0.6, 0)
panel.Position = UDim2.new(0.15, 0, 0.15, 0)
panel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
panel.BackgroundTransparency = 0.7
panel.Visible = false
panel.Parent = screenGui

-- Botões
local buttons = {
    {Name = "Invisibilidade", Color = Color3.fromRGB(255,0,0)},
    {Name = "Voo", Color = Color3.fromRGB(0,255,0)},
    {Name = "Vida Instantânea", Color = Color3.fromRGB(255,165,0)},
    {Name = "Bombas", Color = Color3.fromRGB(255,255,0)},
    {Name = "Desviar e Matar", Color = Color3.fromRGB(128,0,128)},
}

for i, info in ipairs(buttons) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.8, 0, 0.1, 0)
    btn.Position = UDim2.new(0.1, 0, 0.05 + (i-1)*0.15, 0)
    btn.Text = info.Name
    btn.BackgroundColor3 = info.Color
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Parent = panel
    info.Button = btn
end

-- Funções

-- Invisibilidade
local function toggleInvisibility()
    for _, part in ipairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            part.Transparency = (part.Transparency == 1) and 0 or 1
            part.CanCollide = not part.CanCollide
        end
    end
end

-- Voo
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

game:GetService("RunService").Heartbeat:Connect(function()
    if flying and bodyVelocity then
        bodyVelocity.Velocity = humanoid.MoveDirection * 100
    end
end)

-- Vida Instantânea
local function heal()
    humanoid.Health = humanoid.MaxHealth
end

-- Bombas
local function spawnBombas()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Hawkingu/Script_forca.lua/refs/heads/main/bombasboa_script.lua"))()
end

-- Desviar e matar
local debounce = false
local function autoKillOnTouch()
    humanoid.Touched:Connect(function(hit)
        if hit.Parent and game.Players:GetPlayerFromCharacter(hit.Parent) and not debounce then
            debounce = true
            local enemyHumanoid = hit.Parent:FindFirstChild("Humanoid")
            if enemyHumanoid then
                enemyHumanoid.Health = 0
            end
            wait(0.5)
            debounce = false
        end
    end)
end

-- Conectar botões
buttons[1].Button.MouseButton1Click:Connect(toggleInvisibility)
buttons[2].Button.MouseButton1Click:Connect(toggleFlight)
buttons[3].Button.MouseButton1Click:Connect(heal)
buttons[4].Button.MouseButton1Click:Connect(spawnBombas)
buttons[5].Button.MouseButton1Click:Connect(autoKillOnTouch)

-- Mostrar/Ocultar o painel
textButton.MouseButton1Click:Connect(function()
    panel.Visible = not panel.Visible
end)
