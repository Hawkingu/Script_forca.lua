--// Biblioteca Simples para Mobile
local ScreenGui = Instance.new("ScreenGui")
local OpenButton = Instance.new("TextButton")
local MainFrame = Instance.new("Frame")
local FlyButton = Instance.new("TextButton")
local AutoClickButton = Instance.new("TextButton")
local WallHackButton = Instance.new("TextButton")
local AutoDumbellButton = Instance.new("TextButton")
local AutoPushupButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")

--// Configurações
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

OpenButton.Name = "OpenButton"
OpenButton.Parent = ScreenGui
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
OpenButton.Position = UDim2.new(0, 10, 0, 100)
OpenButton.Size = UDim2.new(0, 100, 0, 40)
OpenButton.Font = Enum.Font.SourceSansBold
OpenButton.Text = "Hawk [+]"
OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenButton.TextScaled = true
OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenButton.Visible = false
end)

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0, 10, 0, 50)
MainFrame.Size = UDim2.new(0, 360, 0, 60)
MainFrame.Visible = false

CloseButton.Name = "CloseButton"
CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.Position = UDim2.new(1, -50, 0, 0)
CloseButton.Size = UDim2.new(0, 50, 0, 20)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Text = "Hawk [-]"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextScaled = true
CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenButton.Visible = true
end)

--// Funções

local flying = false
FlyButton.Name = "FlyButton"
FlyButton.Parent = MainFrame
FlyButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
FlyButton.Position = UDim2.new(0, 0, 0, 20)
FlyButton.Size = UDim2.new(0, 60, 0, 40)
FlyButton.Font = Enum.Font.SourceSansBold
FlyButton.Text = "Fly"
FlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyButton.TextScaled = true
FlyButton.MouseButton1Click:Connect(function()
    flying = not flying
    local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if flying and humanoid then
        humanoid.PlatformStand = true
        while flying do
            game.Players.LocalPlayer.Character:TranslateBy(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * 0.5)
            wait()
        end
    else
        humanoid.PlatformStand = false
    end
end)

local autoclicking = false
AutoClickButton.Name = "AutoClickButton"
AutoClickButton.Parent = MainFrame
AutoClickButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
AutoClickButton.Position = UDim2.new(0, 70, 0, 20)
AutoClickButton.Size = UDim2.new(0, 60, 0, 40)
AutoClickButton.Font = Enum.Font.SourceSansBold
AutoClickButton.Text = "AutoClick"
AutoClickButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoClickButton.TextScaled = true
AutoClickButton.MouseButton1Click:Connect(function()
    autoclicking = not autoclicking
    spawn(function()
        while autoclicking do
            mouse1click()
            wait(0.1)
        end
    end)
end)

local wallhack = false
WallHackButton.Name = "WallHackButton"
WallHackButton.Parent = MainFrame
WallHackButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
WallHackButton.Position = UDim2.new(0, 140, 0, 20)
WallHackButton.Size = UDim2.new(0, 60, 0, 40)
WallHackButton.Font = Enum.Font.SourceSansBold
WallHackButton.Text = "WallHack"
WallHackButton.TextColor3 = Color3.fromRGB(255, 255, 255)
WallHackButton.TextScaled = true
WallHackButton.MouseButton1Click:Connect(function()
    wallhack = not wallhack
    for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanCollide = not wallhack
        end
    end
end)

local autodumbell = false
AutoDumbellButton.Name = "AutoDumbellButton"
AutoDumbellButton.Parent = MainFrame
AutoDumbellButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
AutoDumbellButton.Position = UDim2.new(0, 210, 0, 20)
AutoDumbellButton.Size = UDim2.new(0, 60, 0, 40)
AutoDumbellButton.Font = Enum.Font.SourceSansBold
AutoDumbellButton.Text = "Dumbell"
AutoDumbellButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoDumbellButton.TextScaled = true
AutoDumbellButton.MouseButton1Click:Connect(function()
    autodumbell = not autodumbell
    spawn(function()
        while autodumbell do
            local args = {[1] = 1}
            pcall(function()
                game:GetService("Players").LocalPlayer.Character.Dumbell.Event:FireServer(unpack(args))
            end)
            wait(0.5)
        end
    end)
end)

local autopushup = false
AutoPushupButton.Name = "AutoPushupButton"
AutoPushupButton.Parent = MainFrame
AutoPushupButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
AutoPushupButton.Position = UDim2.new(0, 280, 0, 20)
AutoPushupButton.Size = UDim2.new(0, 60, 0, 40)
AutoPushupButton.Font = Enum.Font.SourceSansBold
AutoPushupButton.Text = "Pushup"
AutoPushupButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoPushupButton.TextScaled = true
AutoPushupButton.MouseButton1Click:Connect(function()
    autopushup = not autopushup
    spawn(function()
        while autopushup do
            local args = {[1] = 1}
            pcall(function()
                game:GetService("Players").LocalPlayer.Character.Pushup.Event:FireServer(unpack(args))
            end)
            wait(0.5)
        end
    end)
end)

print("Hawk Hub carregado!")
