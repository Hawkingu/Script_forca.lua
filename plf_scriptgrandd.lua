local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))

-- Tema com imagem
local background = Instance.new("ImageButton")
background.Size = UDim2.new(0.15, 0, 0.1, 0)
background.Position = UDim2.new(0, 10, 0, 10)
background.BackgroundTransparency = 1
background.Image = "https://tr.rbxcdn.com/47e2ef592e2d57f075444ef98a329565/420/420/Image/Png" -- imagem Cobra Kai
background.Parent = screenGui

local title = Instance.new("TextLabel", background)
title.Size = UDim2.new(1, 0, 1, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Cobra Kai"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.Fantasy
title.TextScaled = true

local panel = Instance.new("Frame", screenGui)
panel.Size = UDim2.new(0.7, 0, 0.7, 0)
panel.Position = UDim2.new(0.15, 0, 0.15, 0)
panel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
panel.BackgroundTransparency = 0.5
panel.Visible = false

local buttonsInfo = {
    {Name = "Invisibilidade", Color = Color3.fromRGB(255,0,0)},
    {Name = "Voo", Color = Color3.fromRGB(0,255,0)},
    {Name = "Vida Instantânea", Color = Color3.fromRGB(255,165,0)},
    {Name = "Bombas", Color = Color3.fromRGB(255,255,0)},
    {Name = "Desviar e Matar", Color = Color3.fromRGB(128,0,128)},
    {Name = "Auto Push-Up e Auto Click", Color = Color3.fromRGB(0,191,255)},
    {Name = "Atravessar Paredes", Color = Color3.fromRGB(255,20,147)},
    {Name = "Auto Força (Dumbell)", Color = Color3.fromRGB(34,139,34)},
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
    table.insert(buttons, btn)
end

-- Funções

local function toggleInvisibility()
    for _, part in ipairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            part.Transparency = (part.Transparency == 1) and 0 or 1
            part.CanCollide = not part.CanCollide
        end
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

game:GetService("RunService").Heartbeat:Connect(function()
    if flying and bodyVelocity then
        bodyVelocity.Velocity = humanoid.MoveDirection * 100
    end
end)

local function heal()
    humanoid.Health = humanoid.MaxHealth
end

local function spawnBombas()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Hawkingu/Script_forca.lua/refs/heads/main/bbBombis_script.lua"))()
end

local debounce = false
local function autoKillOnTouch()
    humanoid.Touched:Connect(function(hit)
        if hit.Parent and game.Players:GetPlayerFromCharacter(hit.Parent) and not debounce then
            debounce = true
            local enemyHumanoid = hit.Parent:FindFirstChild("Humanoid")
            if enemyHumanoid then
                enemyHumanoid.Health = 0
            end
            task.wait(0.5)
            debounce = false
        end
    end)
end

local pushUpActive = false
local function autoPushUp()
    if not pushUpActive then
        pushUpActive = true
        while pushUpActive do
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
            task.wait(0.05)
        end
    else
        pushUpActive = false
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

-- AUTO FORÇA (Dumbell)
local autoStrength = false
local function autoFarmStrength()
    autoStrength = not autoStrength
    while autoStrength do
        local args = {
            [1] = 1
        }
        pcall(function()
            player.Character.Dumbell.Event:FireServer(unpack(args))
        end)
        task.wait(0.1)
    end
end

-- Conectar botões
buttons[1].MouseButton1Click:Connect(toggleInvisibility)
buttons[2].MouseButton1Click:Connect(toggleFlight)
buttons[3].MouseButton1Click:Connect(heal)
buttons[4].MouseButton1Click:Connect(spawnBombas)
buttons[5].MouseButton1Click:Connect(autoKillOnTouch)
buttons[6].MouseButton1Click:Connect(autoPushUp)
buttons[7].MouseButton1Click:Connect(toggleNoClip)
buttons[8].MouseButton1Click:Connect(autoFarmStrength)

-- Mostrar/Ocultar painel
background.MouseButton1Click:Connect(function()
    panel.Visible = not panel.Visible
end)
