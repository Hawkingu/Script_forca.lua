-- SCRIPT COBRA KAI PAINEL FINALIZADO

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Criar tela
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "CobraKaiPanel"
ScreenGui.ResetOnSpawn = false

-- Criar botão da logo
local LogoButton = Instance.new("ImageButton", ScreenGui)
LogoButton.Position = UDim2.new(0, 10, 0, 10)
LogoButton.Size = UDim2.new(0, 50, 0, 50)
LogoButton.Image = "rbxassetid://17073223843" -- Logo Cobra Kai
LogoButton.Name = "LogoButton"

-- Criar painel
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 250, 0, 300)
MainFrame.Position = UDim2.new(0, 0.05, 0, 80)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Visible = false

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 15)

-- Botões principais
local FarmButton = Instance.new("TextButton", MainFrame)
local BrincadeiraButton = Instance.new("TextButton", MainFrame)

FarmButton.Size = UDim2.new(0, 220, 0, 40)
FarmButton.Position = UDim2.new(0, 15, 0, 20)
FarmButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
FarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmButton.Text = "🔴 Farm"

BrincadeiraButton.Size = UDim2.new(0, 220, 0, 40)
BrincadeiraButton.Position = UDim2.new(0, 15, 0, 80)
BrincadeiraButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
BrincadeiraButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BrincadeiraButton.Text = "🔵 Brincadeira"

-- Sub-opções (Vida +5, Força +5)
local VidaButton = Instance.new("TextButton", MainFrame)
local ForcaButton = Instance.new("TextButton", MainFrame)

VidaButton.Size = UDim2.new(0, 220, 0, 40)
VidaButton.Position = UDim2.new(0, 15, 0, 140)
VidaButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
VidaButton.TextColor3 = Color3.fromRGB(255, 255, 255)
VidaButton.Text = "[Vida +5]"
VidaButton.Visible = false

ForcaButton.Size = UDim2.new(0, 220, 0, 40)
ForcaButton.Position = UDim2.new(0, 15, 0, 190)
ForcaButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
ForcaButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ForcaButton.Text = "[Força +5]"
ForcaButton.Visible = false

-- Sub-opções brincadeira
local VoarButton = Instance.new("TextButton", MainFrame)
local NoclipButton = Instance.new("TextButton", MainFrame)
local CorButton = Instance.new("TextButton", MainFrame)
local DumbellButton = Instance.new("TextButton", MainFrame)
local VidaOffButton = Instance.new("TextButton", MainFrame)

local BrincadeiraButtons = {VoarButton, NoclipButton, CorButton, DumbellButton, VidaOffButton}
local yStart = 140

for i,btn in pairs(BrincadeiraButtons) do
    btn.Parent = MainFrame
    btn.Size = UDim2.new(0, 220, 0, 30)
    btn.Position = UDim2.new(0, 15, 0, yStart + (i-1)*35)
    btn.BackgroundColor3 = Color3.fromRGB(80, 80, 200)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Visible = false
end

VoarButton.Text = "[Voar]"
NoclipButton.Text = "[Atravessar Paredes]"
CorButton.Text = "[Mudar Cor]"
DumbellButton.Text = "[Chuva de Dumbell]"
VidaOffButton.Text = "[Esconder Vida]"

-- Funções
local farming = false

LogoButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

FarmButton.MouseButton1Click:Connect(function()
    VidaButton.Visible = not VidaButton.Visible
    ForcaButton.Visible = not ForcaButton.Visible
    for _,b in pairs(BrincadeiraButtons) do b.Visible = false end
end)

BrincadeiraButton.MouseButton1Click:Connect(function()
    VidaButton.Visible = false
    ForcaButton.Visible = false
    for _,b in pairs(BrincadeiraButtons) do b.Visible = not b.Visible end
end)

-- Farmar Vida
VidaButton.MouseButton1Click:Connect(function()
    pcall(function()
        game:GetService("ReplicatedStorage").Remotes.Branco:FireServer()
    end)
end)

-- Farmar Força
ForcaButton.MouseButton1Click:Connect(function()
    pcall(function()
        game:GetService("Players").LocalPlayer.Character.Dumbell.Event:FireServer(1)
    end)
end)

-- Voar
VoarButton.MouseButton1Click:Connect(function()
    spawn(function()
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local body = Instance.new("BodyVelocity", char.HumanoidRootPart)
        body.Velocity = Vector3.new(0, 50, 0)
        body.MaxForce = Vector3.new(999999, 999999, 999999)
        wait(10)
        body:Destroy()
    end)
end)

-- Noclip
NoclipButton.MouseButton1Click:Connect(function()
    spawn(function()
        while true do
            task.wait()
            pcall(function()
                local Char = LocalPlayer.Character
                for _,v in pairs(Char:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end)
        end
    end)
end)

-- Mudar de Cor
CorButton.MouseButton1Click:Connect(function()
    spawn(function()
        while true do
            task.wait(0.5)
            local Char = LocalPlayer.Character
            for _,v in pairs(Char:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Color = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
                end
            end
        end
    end)
end)

-- Chuva de Dumbell
DumbellButton.MouseButton1Click:Connect(function()
    spawn(function()
        for i = 1, 600 do
            task.wait(0.2)
            local dumbell = LocalPlayer.Backpack:FindFirstChild("Dumbell")
            if dumbell then
                local clone = dumbell:Clone()
                clone.Parent = workspace
                clone.Handle.CFrame = CFrame.new(Vector3.new(math.random(-300,300),100,math.random(-300,300)))
            end
        end
    end)
end)

-- Esconder Vida
VidaOffButton.MouseButton1Click:Connect(function()
    spawn(function()
        local char = LocalPlayer.Character
        for _,v in pairs(char:GetChildren()) do
            if v:IsA("BillboardGui") or v:IsA("Humanoid") then
                pcall(function() v:Destroy() end)
            end
        end
    end)
end)
