local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TopBar = Instance.new("TextButton")
local ContentFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")

-- Ativar GUI
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "HawkHubUI"

-- Painel principal (MENOR)
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.5, -100, 0.1, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 40)
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
TopBar.Text = "HAWKHUB [+]"
TopBar.TextColor3 = Color3.fromRGB(0, 170, 255)
TopBar.TextSize = 18
TopBar.BorderSizePixel = 0

-- Área do Conteúdo
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ContentFrame.Position = UDim2.new(0, 0, 0, 40)
ContentFrame.Size = UDim2.new(1, 0, 0, 200)
ContentFrame.BorderSizePixel = 0

-- Criar Botão Função
local function CreateButton(text, posY, callback)
    local button = Instance.new("TextButton")
    button.Parent = ContentFrame
    button.Size = UDim2.new(0.9, 0, 0, 30)
    button.Position = UDim2.new(0.05, 0, 0, posY)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.Font = Enum.Font.Gotham
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 14
    button.BorderSizePixel = 0
    button.MouseButton1Click:Connect(callback)
end

-- Scripts dos Botões
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

local function TeleportScript()
    local player = game.Players.LocalPlayer
    local mouse = player:GetMouse()

    mouse.Button1Down:Connect(function()
        if mouse.Target then
            player.Character:MoveTo(mouse.Hit.p)
        end
    end)
end

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

local function PegarFogoScript()
    local character = game.Players.LocalPlayer.Character
    if not character then return end

    local fire = Instance.new("Fire")
    fire.Parent = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChildWhichIsA("BasePart")
    fire.Size = 10
    fire.Heat = 5
end

-- Botões
CreateButton("Fly (Ativar/Desativar)", 5, FlyScript)
CreateButton("Teleportar Click", 40, TeleportScript)
CreateButton("Noclip (Ativar/Desativar)", 75, NoclipScript)
CreateButton("Auto Dumbell", 110, AutoDumbellScript)
CreateButton("Pegar Fogo", 145, PegarFogoScript)

-- Minimizar/Maximizar
local minimized = true
TopBar.MouseButton1Click:Connect(function()
    if minimized then
        MainFrame:TweenSize(UDim2.new(0, 200, 0, 240), "Out", "Quart", 0.5, true)
        TopBar.Text = "HAWKHUB [-]"
        minimized = false
    else
        MainFrame:TweenSize(UDim2.new(0, 200, 0, 40), "Out", "Quart", 0.5, true)
        TopBar.Text = "HAWKHUB [+]"
        minimized = true
    end
end)

-- Mover o Painel
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                   startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TopBar.InputBegan:Connect(function(input)
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

TopBar.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        update(input)
    end
end)
