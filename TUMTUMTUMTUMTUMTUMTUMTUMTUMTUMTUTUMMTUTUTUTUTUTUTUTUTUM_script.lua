-- HAWKEXECUT+ PAINEL
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "HAWKEXECUT"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
Frame.Active = true
Frame.Draggable = true

local closeButton = Instance.new("TextButton", Frame)
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.Text = "X"
closeButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Aba Farm
local Tab1 = Instance.new("TextButton", Frame)
Tab1.Size = UDim2.new(0.5, 0, 0, 30)
Tab1.Text = "Farm"

-- Aba Brincadeira
local Tab2 = Instance.new("TextButton", Frame)
Tab2.Position = UDim2.new(0.5, 0, 0, 0)
Tab2.Size = UDim2.new(0.5, 0, 0, 30)
Tab2.Text = "Brincadeira"

local Container = Instance.new("Frame", Frame)
Container.Position = UDim2.new(0, 0, 0, 35)
Container.Size = UDim2.new(1, 0, 1, -35)
Container.BackgroundTransparency = 1

-- Botões Farm
local autoKill = Instance.new("TextButton", Container)
autoKill.Size = UDim2.new(1, 0, 0, 30)
autoKill.Position = UDim2.new(0, 0, 0, 0)
autoKill.Text = "○ Auto Kill (ao tocar)"
autoKill.MouseButton1Click:Connect(function()
    game:GetService("RunService").Stepped:Connect(function()
        for _, v in pairs(game.Players:GetPlayers()) do
            if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local mag = (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude
                if mag < 10 then
                    v.Character:BreakJoints()
                end
            end
        end
    end)
end)

-- Auto Dumbbell (novo)
local autoDumbbell = Instance.new("TextButton", Container)
autoDumbbell.Size = UDim2.new(1, 0, 0, 30)
autoDumbbell.Position = UDim2.new(0, 0, 0, 35)
autoDumbbell.Text = "○ Auto Dumbbell"
autoDumbbell.MouseButton1Click:Connect(function()
    getgenv().autoDumbbell = true
    while getgenv().autoDumbbell do
        local args = {
            [1] = "Dumbbell"
        }
        game:GetService("ReplicatedStorage").Remotes.Workout:FireServer(unpack(args))
        wait(1)
    end
end)

-- Botões Brincadeira
local flySpeed = 100  -- Mantém velocidade rápida
local flying = false

local fly = Instance.new("TextButton", Container)
fly.Size = UDim2.new(1, 0, 0, 30)
fly.Position = UDim2.new(0, 0, 0, 70)
fly.Text = "○ Ativar Voo"
fly.MouseButton1Click:Connect(function()
    flying = not flying
    if flying then
        local plr = game.Players.LocalPlayer
        local chr = plr.Character
        local hrp = chr:WaitForChild("HumanoidRootPart")

        game:GetService("RunService").Heartbeat:Connect(function()
            if flying then
                hrp.Velocity = hrp.CFrame.LookVector * flySpeed
            end
        end)
    end
end)

-- Invisibilidade / Invencibilidade
local god = Instance.new("TextButton", Container)
god.Size = UDim2.new(1, 0, 0, 30)
god.Position = UDim2.new(0, 0, 0, 105)
god.Text = "○ Modo Invisível/Imortal"
god.MouseButton1Click:Connect(function()
    local char = game.Players.LocalPlayer.Character
    if char:FindFirstChild("Humanoid") then
        char.Humanoid.Name = "1"
        local newHum = char["1"]:Clone()
        newHum.Name = "Humanoid"
        newHum.Parent = char
        wait(0.1)
        char["1"]:Destroy()
        game.Workspace.CurrentCamera.CameraSubject = char
        char.Animate.Disabled = true
        wait(0.1)
        char.Animate.Disabled = false
    end
end)
