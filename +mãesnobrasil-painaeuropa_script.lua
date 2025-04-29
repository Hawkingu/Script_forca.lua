-- Variáveis globais
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Remote = game.ReplicatedStorage:WaitForChild("Remote")
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Cama de +5 de Vida
local Bed = game.ReplicatedStorage:WaitForChild("Bed") -- Substitua pelo nome correto da cama no seu jogo
local function spawnBed()
    local cloneBed = Bed:Clone()
    cloneBed.Parent = workspace
    cloneBed:SetPrimaryPartCFrame(HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)) -- Aparece perto de você
end

-- Tubarão de Sapato (Tralalelo_tralalala)
local function spawnSharkShoe()
    local sharkShoe = Instance.new("Part")
    sharkShoe.Size = Vector3.new(5, 5, 5)
    sharkShoe.Position = HumanoidRootPart.Position + Vector3.new(0, 10, 0)
    sharkShoe.Shape = Enum.PartType.Ball
    sharkShoe.Color = Color3.fromRGB(0, 0, 255)
    sharkShoe.Anchored = true
    sharkShoe.Parent = workspace
    -- Fazendo o tubarão pular
    spawn(function()
        while true do
            task.wait(1)
            sharkShoe.Velocity = Vector3.new(0, 50, 0)
        end
    end)
end

-- Controle de Movimentação para Voar (Mobile)
local function moveFlyMobile(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        local touchPos = input.Position
        -- Definir como você quer controlar o movimento aqui, exemplo: 
        -- Pode usar um swipe ou movimento de "arrastar"
        -- Por exemplo, você pode fazer o personagem se mover na direção do toque.
        -- Vou ajustar como você preferir.
    end
end

local flying = false
local function toggleFly()
    flying = not flying
    if flying then
        -- Criar movimento de voo simples
        -- No mobile, você pode ajustar para que o movimento seja mais fácil de controlar com gestos.
    end
end

-- Farmar Força Automático
local function autoFarmStrength()
    while true do
        task.wait(1)
        pcall(function()
            game:GetService("Players").LocalPlayer.Character.Dumbell.Event:FireServer(1)
        end)
    end
end

-- Mostrar painel
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "PainelFarm"

-- Criar o painel
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 300, 0, 350)
MainFrame.Position = UDim2.new(0, 100, 0, 80)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Visible = true

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 15)

-- Botões do painel
local FarmButton = Instance.new("TextButton", MainFrame)
FarmButton.Size = UDim2.new(0, 270, 0, 35)
FarmButton.Position = UDim2.new(0, 15, 0, 10)
FarmButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
FarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmButton.Text = "🔴 Farm"

local BrincadeiraButton = Instance.new("TextButton", MainFrame)
BrincadeiraButton.Size = UDim2.new(0, 270, 0, 35)
BrincadeiraButton.Position = UDim2.new(0, 15, 0, 55)
BrincadeiraButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
BrincadeiraButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BrincadeiraButton.Text = "🔵 Brincadeira"

-- Botões de Brincadeira
local BedButton = Instance.new("TextButton", MainFrame)
BedButton.Size = UDim2.new(0, 270, 0, 35)
BedButton.Position = UDim2.new(0, 15, 0, 100)
BedButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
BedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BedButton.Text = "🛏️ Cama +5 de Vida"

local SharkButton = Instance.new("TextButton", MainFrame)
SharkButton.Size = UDim2.new(0, 270, 0, 35)
SharkButton.Position = UDim2.new(0, 15, 0, 145)
SharkButton.BackgroundColor3 = Color3.fromRGB(100, 150, 250)
SharkButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SharkButton.Text = "🐋 Tralalelo"

local FlyButton = Instance.new("TextButton", MainFrame)
FlyButton.Size = UDim2.new(0, 270, 0, 35)
FlyButton.Position = UDim2.new(0, 15, 0, 190)
FlyButton.BackgroundColor3 = Color3.fromRGB(150, 100, 255)
FlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyButton.Text = "✈️ Voar"

-- Funções dos botões
FarmButton.MouseButton1Click:Connect(function()
    autoFarmStrength()
end)

BedButton.MouseButton1Click:Connect(function()
    spawnBed()
end)

SharkButton.MouseButton1Click:Connect(function()
    spawnSharkShoe()
end)

FlyButton.MouseButton1Click:Connect(function()
    toggleFly()
end)

-- Ajustando entrada de toque para movimentação de voo
game:GetService("UserInputService").InputChanged:Connect(moveFlyMobile)
