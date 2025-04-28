-- Script completo Cobra Kai Painel (Mobile e PC)

local ScreenGui = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
local MainFrame = Instance.new("Frame", ScreenGui)
local UICorner = Instance.new("UICorner", MainFrame)
local LogoButton = Instance.new("ImageButton", ScreenGui)

ScreenGui.Name = "CobraKaiPanel"
MainFrame.Name = "MainFrame"
LogoButton.Name = "LogoButton"

ScreenGui.ResetOnSpawn = false
MainFrame.Visible = false

-- Painel
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 250, 0, 220)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
UICorner.CornerRadius = UDim.new(0, 15)

-- Botão Logo Cobra Kai
LogoButton.Position = UDim2.new(0, 10, 0, 10)
LogoButton.Size = UDim2.new(0, 50, 0, 50)
LogoButton.Image = "rbxassetid://17073223843" -- Logo Cobra Kai

-- Botões no Painel
local FarmButton = Instance.new("TextButton", MainFrame)
local BrincadeiraButton = Instance.new("TextButton", MainFrame)
local StopButton = Instance.new("TextButton", MainFrame)

FarmButton.Size = UDim2.new(0, 200, 0, 40)
FarmButton.Position = UDim2.new(0, 25, 0, 20)
FarmButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
FarmButton.Text = "🔴 Farmar Vida e Força"
FarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)

BrincadeiraButton.Size = UDim2.new(0, 200, 0, 40)
BrincadeiraButton.Position = UDim2.new(0, 25, 0, 80)
BrincadeiraButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
BrincadeiraButton.Text = "🔵 Brincadeiras"
BrincadeiraButton.TextColor3 = Color3.fromRGB(255, 255, 255)

StopButton.Size = UDim2.new(0, 200, 0, 40)
StopButton.Position = UDim2.new(0, 25, 0, 140)
StopButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
StopButton.Text = "🛑 Parar Tudo"
StopButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Variáveis para controle
local farming = false
local brincando = false

-- Função abrir/fechar painel
LogoButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Farmar Vida e Força
FarmButton.MouseButton1Click:Connect(function()
    if not farming then
        farming = true
        spawn(function()
            while farming do
                task.wait(0.1)
                pcall(function()
                    game:GetService("Players").LocalPlayer.Character.Dumbell.Event:FireServer(1)
                    game:GetService("ReplicatedStorage").Remotes.Branco:FireServer()
                end)
            end
        end)
    end
end)

-- Brincadeiras
BrincadeiraButton.MouseButton1Click:Connect(function()
    if not brincando then
        brincando = true
        -- Noclip
        spawn(function()
            while brincando do
                task.wait()
                pcall(function()
                    local Char = game.Players.LocalPlayer.Character
                    for _,v in pairs(Char:GetDescendants()) do
                        if v:IsA("BasePart") then
                            v.CanCollide = false
                        end
                    end
                end)
            end
        end)
        -- Voar
        spawn(function()
            local plr = game.Players.LocalPlayer
            local char = plr.Character or plr.CharacterAdded:Wait()
            local humanoid = char:WaitForChild("Humanoid")
            humanoid.PlatformStand = false
            local body = Instance.new("BodyVelocity", char.HumanoidRootPart)
            body.Velocity = Vector3.new(0, 50, 0)
            body.MaxForce = Vector3.new(999999, 999999, 999999)
            while brincando do
                task.wait()
                body.Velocity = Vector3.new(0, 50, 0)
            end
            body:Destroy()
        end)
        -- Mudar de cor
        spawn(function()
            while brincando do
                task.wait(0.5)
                local Char = game.Players.LocalPlayer.Character
                for _,v in pairs(Char:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.Color = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
                    end
                end
            end
        end)
        -- Esconder vida
        spawn(function()
            while brincando do
                task.wait()
                local char = game.Players.LocalPlayer.Character
                for _,v in pairs(char:GetChildren()) do
                    if v:IsA("BillboardGui") or v:IsA("Humanoid") then
                        pcall(function() v:Destroy() end)
                    end
                end
            end
        end)
        -- Chover Dumbells
        spawn(function()
            for i = 1, 600 do
                if not brincando then break end
                task.wait(0.2)
                local dumbell = game.Players.LocalPlayer.Backpack:FindFirstChild("Dumbell")
                if dumbell then
                    local clone = dumbell:Clone()
                    clone.Parent = workspace
                    clone.Handle.CFrame = CFrame.new(Vector3.new(math.random(-200,200),100,math.random(-200,200)))
                end
            end
        end)
    end
end)

-- Parar Tudo
StopButton.MouseButton1Click:Connect(function()
    farming = false
    brincando = false
end)
