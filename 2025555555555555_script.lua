--// CONFIGURAÇÃO INICIAL
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Criar o GUI principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.Name = "PainelCVUHAWK"

-- Logo (bolinha CVUHAWK)
local LogoButton = Instance.new("ImageButton", ScreenGui)
LogoButton.Size = UDim2.new(0, 50, 0, 50)
LogoButton.Position = UDim2.new(0, 10, 0, 10)
LogoButton.Image = "rbxassetid://17073223843"
LogoButton.Name = "LogoButton"

-- Painel principal
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0, 100, 0, 100)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Visible = false

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 15)

-- Botão de fechar
local CloseButton = Instance.new("TextButton", MainFrame)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.Text = "X"
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseButton.TextColor3 = Color3.fromRGB(255,255,255)

-- Funções abrir/fechar
LogoButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Movimentar o painel
local dragging, dragInput, dragStart, startPos
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

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

-- TÍTULO
local TitleLabel = Instance.new("TextLabel", MainFrame)
TitleLabel.Size = UDim2.new(1, -20, 0, 30)
TitleLabel.Position = UDim2.new(0, 10, 0, 10)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "CVUHAWK FARM"
TitleLabel.TextColor3 = Color3.fromRGB(255,255,255)
TitleLabel.TextScaled = true

-- BOTÕES
local YPosition = 50

local function createButton(name, callback)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, YPosition)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Text = name
    btn.TextScaled = true
    btn.MouseButton1Click:Connect(callback)
    YPosition = YPosition + 50
end

-- SCRIPTES DOS BOTÕES

-- Auto Katana (sem precisar equipar)
createButton("○ Auto Katana", function()
    _G.autoKatana = not _G.autoKatana
    if _G.autoKatana then
        spawn(function()
            while _G.autoKatana do
                local args = {
                    [1] = "Katana"
                }
                -- Simula ataque da Katana
                local remote = LocalPlayer.Character:FindFirstChild("Katana") or ReplicatedStorage:FindFirstChild("Katana")
                if remote and remote:FindFirstChild("Event") then
                    remote.Event:FireServer(unpack(args))
                end
                wait(0.5) -- atacar rápido
            end
        end)
    end
end)

-- Auto Saco de Pancada
createButton("○ Auto Saco de Pancada", function()
    _G.autoSaco = not _G.autoSaco
    if _G.autoSaco then
        spawn(function()
            while _G.autoSaco do
                local args = {
                    [1] = 1
                }
                -- Simula o uso no saco
                if LocalPlayer.Character:FindFirstChild("Dumbell") and LocalPlayer.Character.Dumbell:FindFirstChild("Event") then
                    LocalPlayer.Character.Dumbell.Event:FireServer(unpack(args))
                end
                wait(1) -- 1 segundo cada hit
            end
        end)
    end
end)

-- Auto Vida
createButton("○ Auto Vida", function()
    _G.autoVida = not _G.autoVida
    if _G.autoVida then
        spawn(function()
            while _G.autoVida do
                local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.Health = humanoid.Health + 1
                end
                wait(1) -- 1 segundo cada +1 vida
            end
        end)
    end
end)
