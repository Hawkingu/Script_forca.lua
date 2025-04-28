-- HawkHub MOBILE Painel com Botões e Minimizar

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
MainFrame.Position = UDim2.new(0.5, -150, 0.1, 0)
MainFrame.Size = UDim2.new(0, 300, 0, 50)
MainFrame.ClipsDescendants = true
MainFrame.BorderSizePixel = 0

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Topo
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.Font = Enum.Font.GothamBold
TopBar.Text = "HAWKHUB [🔥🪽] [-]"
TopBar.TextColor3 = Color3.fromRGB(0, 170, 255)
TopBar.TextSize = 22
TopBar.BorderSizePixel = 0

-- Área do Conteúdo
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ContentFrame.Position = UDim2.new(0, 0, 0, 50)
ContentFrame.Size = UDim2.new(1, 0, 0, 250)
ContentFrame.BorderSizePixel = 0

-- Função para criar botões
local function CreateButton(text, posY, callback)
    local button = Instance.new("TextButton")
    button.Parent = ContentFrame
    button.Size = UDim2.new(0.9, 0, 0, 40)
    button.Position = UDim2.new(0.05, 0, 0, posY)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.Font = Enum.Font.Gotham
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 18
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

        torso.Anchored = false

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

-- Teleportar para onde clicar
local function TeleportScript()
    local player = game.Players.LocalPlayer
    local mouse = player:GetMouse()

    mouse.Button1Down:Connect(function()
        if mouse.Target then
            player.Character:MoveTo(mouse.Hit.p)
        end
    end)
end

-- Noclip (atravessar paredes)
local noclip = false
local function NoclipScript()
    local plr = game.Players.LocalPlayer

    noclip = not noclip
    if noclip then
        game:GetService('RunService').Stepped:Connect(function()
            if noclip and plr.Character then
                for _, v in pairs(plr.Character:GetDescendants()) do
                    if v:IsA("BasePart") and v.CanCollide == true then
                        v.CanCollide = false
                    end
                end
            end
        end)
    end
end

-- Auto Dumbell (Farm automático)
local function AutoDumbellScript()
    local player = game.Players.LocalPlayer
    local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")
    if tool and tool:FindFirstChild("RemoteEvent") then
        while task.wait(0.1) do
            tool.RemoteEvent:FireServer()
        end
    else
        warn("Segure o Dumbell primeiro!")
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

-- Criar os botões e ligar scripts
CreateButton("Fly (Ativar/Desativar)", 10, FlyScript)
CreateButton("Teleportar Click", 60, TeleportScript)
CreateButton("Noclip (Ativar/Desativar)", 110, NoclipScript)
CreateButton("Auto Dumbell", 160, AutoDumbellScript)
CreateButton("Pegar Fogo", 210, PegarFogoScript)

-- Sistema de minimizar e maximizar
local minimized = false
TopBar.MouseButton1Click:Connect(function()
    if minimized then
        MainFrame:TweenSize(UDim2.new(0, 300, 0, 300), "Out", "Quart", 0.5, true)
        TopBar.Text = "HAWKHUB [🔥🪽] [-]"
        minimized = false
    else
        MainFrame:TweenSize(UDim2.new(0, 200, 0, 50), "Out", "Quart", 0.5, true)
        TopBar.Text = "HAWKHUB [🔥🪽] [+]"
        minimized = true
    end
end)
