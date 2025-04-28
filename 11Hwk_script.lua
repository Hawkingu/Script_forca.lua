-- HawkHub MOBILE Painel Reduzido

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TopBar = Instance.new("TextButton")
local ContentFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")

-- Ativar GUI
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "HawkHubUI"

-- Painel principal
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.5, -120, 0.1, 0)
MainFrame.Size = UDim2.new(0, 240, 0, 40)
MainFrame.ClipsDescendants = true
MainFrame.BorderSizePixel = 0

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Topo
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.Font = Enum.Font.GothamBold
TopBar.Text = "HAWKHUB [🔥🪽] [-]"
TopBar.TextColor3 = Color3.fromRGB(0, 170, 255)
TopBar.TextSize = 20
TopBar.BorderSizePixel = 0

-- Área do Conteúdo
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ContentFrame.Position = UDim2.new(0, 0, 0, 40)
ContentFrame.Size = UDim2.new(1, 0, 0, 200)
ContentFrame.BorderSizePixel = 0

-- Função para criar botões
local function CreateButton(text, posY, callback)
    local button = Instance.new("TextButton")
    button.Parent = ContentFrame
    button.Size = UDim2.new(0.9, 0, 0, 35)
    button.Position = UDim2.new(0.05, 0, 0, posY)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.Font = Enum.Font.Gotham
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 16
    button.BorderSizePixel = 0
    button.MouseButton1Click:Connect(callback)
end

-- Scripts dos botões

-- Fly (voar)
local flying = false
local function FlyScript()
    local plr = game.Players.LocalPlayer
    local torso = plr.Character:WaitForChild("HumanoidRootPart")
    local flyingSpeed = 50

    flying = not flying
    if flying then
        local bodyGyro = Instance.new("BodyGyro", torso)
        local bodyVelocity = Instance.new("BodyVelocity", torso)
        bodyGyro.P = 9e4
        bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyGyro.cframe = torso.CFrame
        bodyVelocity.velocity = Vector3.new(0,0,0)
        bodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)

        task.spawn(function()
            while flying and torso.Parent do
                bodyGyro.cframe = workspace.CurrentCamera.CFrame
                bodyVelocity.velocity = workspace.CurrentCamera.CFrame.LookVector * flyingSpeed
                task.wait()
            end
            bodyGyro:Destroy()
            bodyVelocity:Destroy()
        end)
    end
end

-- Pegar Fogo
local function PegarFogoScript()
    local character = game.Players.LocalPlayer.Character
    if not character then return end

    local fire = Instance.new("Fire")
    fire.Parent = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChildWhichIsA("BasePart")
    fire.Size = 10
    fire.Heat = 5
end

-- Dar bolha de renascimento
local function DarForceField()
    local character = game.Players.LocalPlayer.Character
    if not character then return end

    -- Se já existir, não cria outro
    if not character:FindFirstChildOfClass("ForceField") then
        Instance.new("ForceField", character)
    end
end

-- Remover bolha de renascimento
local function RemoverForceField()
    local character = game.Players.LocalPlayer.Character
    if not character then return end

    local forcefield = character:FindFirstChildOfClass("ForceField")
    if forcefield then
        forcefield:Destroy()
    end
end

-- Criar os botões
CreateButton("Fly (Ativar/Desativar)", 5, FlyScript)
CreateButton("Pegar Fogo", 50, PegarFogoScript)
CreateButton("Ativar Bolha Safe", 95, DarForceField)
CreateButton("Remover Bolha Safe", 140, RemoverForceField)

-- Sistema de minimizar e maximizar
local minimized = false
TopBar.MouseButton1Click:Connect(function()
    if minimized then
        MainFrame:TweenSize(UDim2.new(0, 240, 0, 240), "Out", "Quart", 0.5, true)
        TopBar.Text = "HAWKHUB [🔥🪽] [-]"
        minimized = false
    else
        MainFrame:TweenSize(UDim2.new(0, 180, 0, 40), "Out", "Quart", 0.5, true)
        TopBar.Text = "HAWKHUB [🔥🪽] [+]"
        minimized = true
    end
end)

-- Deixar o painel arrastável
MainFrame.Active = true
MainFrame.Draggable = true
