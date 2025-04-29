local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- Tela principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CobraKaiPainel"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Botão da Logo
local LogoButton = Instance.new("ImageButton")
LogoButton.Size = UDim2.new(0, 60, 0, 60)
LogoButton.Position = UDim2.new(0, 10, 0, 10)
LogoButton.Image = "rbxassetid://17073223843"
LogoButton.BackgroundTransparency = 1
LogoButton.Parent = ScreenGui

-- Painel Principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 500)
MainFrame.Position = UDim2.new(0, 80, 0, 80)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Deixar o Painel Arrastável
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Mostrar ou Esconder o Painel
LogoButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Função para criar botões
local function createButton(name, position, color, text, parent)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 270, 0, 40)
    btn.Position = position
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.Parent = parent
    return btn
end

-- Botões
local FarmButton = createButton("Farm", UDim2.new(0, 15, 0, 10), Color3.fromRGB(200, 0, 0), "🔴 Farm", MainFrame)
local BrincadeiraButton = createButton("Brincadeira", UDim2.new(0, 15, 0, 60), Color3.fromRGB(0, 100, 200), "🔵 Brincadeira", MainFrame)

-- Botões escondidos
local VidaButton = createButton("Vida", UDim2.new(0, 15, 0, 120), Color3.fromRGB(50, 150, 50), "[+5 Vida]", MainFrame)
VidaButton.Visible = false

local ForcaButton = createButton("Forca", UDim2.new(0, 15, 0, 170), Color3.fromRGB(50, 150, 50), "[+5 Força]", MainFrame)
ForcaButton.Visible = false

local SpawnBotButton = createButton("Bot", UDim2.new(0, 15, 0, 220), Color3.fromRGB(255, 100, 0), "[Spawnar Bot]", MainFrame)
SpawnBotButton.Visible = false

-- Controladores de Categoria
FarmButton.MouseButton1Click:Connect(function()
    VidaButton.Visible = true
    ForcaButton.Visible = true
    SpawnBotButton.Visible = false
end)

BrincadeiraButton.MouseButton1Click:Connect(function()
    VidaButton.Visible = false
    ForcaButton.Visible = false
    SpawnBotButton.Visible = true
end)

-- Funções dos botões

-- [+5 Vida]
VidaButton.MouseButton1Click:Connect(function()
    while VidaButton.Visible do
        task.wait(0.5)
        pcall(function()
            game:GetService("ReplicatedStorage").Remotes.Branco:FireServer()
        end)
    end
end)

-- [+5 Força]
ForcaButton.MouseButton1Click:Connect(function()
    while ForcaButton.Visible do
        task.wait(0.5)
        pcall(function()
            game:GetService("Players").LocalPlayer.Character.Dumbell.Event:FireServer(1)
        end)
    end
end)

-- [Spawnar Bot]
SpawnBotButton.MouseButton1Click:Connect(function()
    local bot = LocalPlayer.Character:Clone()
    bot.Parent = workspace
    bot.Name = "Bot_" .. LocalPlayer.Name
    -- Mudar cor da camiseta e shorts
    for _, part in pairs(bot:GetDescendants()) do
        if part:IsA("Shirt") then
            part.ShirtTemplate = "rbxassetid://0" -- camiseta grátis padrão
        elseif part:IsA("Pants") then
            part.PantsTemplate = "rbxassetid://0" -- shorts grátis padrão
        end
    end
    -- Careca
    for _, v in pairs(bot:GetDescendants()) do
        if v:IsA("Accessory") then
            v:Destroy()
        end
    end
    -- Atacar jogadores
    spawn(function()
        while bot and bot.Parent do
            task.wait(1)
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
                    if (bot.PrimaryPart.Position - player.Character.PrimaryPart.Position).Magnitude < 20 then
                        player.Character.Humanoid:TakeDamage(10)
                    end
                end
            end
        end
    end)
end)
