local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Criar tela
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "CobraKaiPanel"
ScreenGui.ResetOnSpawn = false

-- Criar botão da logo
local LogoButton = Instance.new("ImageButton", ScreenGui)
LogoButton.Position = UDim2.new(0, 10, 0, 10)
LogoButton.Size = UDim2.new(0, 40, 0, 40)
LogoButton.Image = "rbxassetid://17073223843"
LogoButton.Name = "LogoButton"

-- Criar painel
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 250, 0, 300)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Visible = false

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 10)

-- Tornar painel arrastável
local dragging, dragInput, dragStart, startPos
local UserInputService = game:GetService("UserInputService")

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                   startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
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
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Botões
local function CreateButton(text, posY)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0, 220, 0, 30)
    btn.Position = UDim2.new(0, 15, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Text = text
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 6)
    return btn
end

local FarmButton = CreateButton("🔴 Farmar e Torneio", 10)
local VoarButton = CreateButton("🛫 Voar", 50)
local NoClipButton = CreateButton("🚪 Atravessar Paredes", 90)
local CorButton = CreateButton("🎨 Mudar Cor", 130)
local DumbellButton = CreateButton("☄️ Chuva de Dumbbell", 170)
local EsconderVidaButton = CreateButton("❌ Esconder Vida", 210)

-- Mostrar painel
LogoButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Farmar Vida + Força + Torneio
FarmButton.MouseButton1Click:Connect(function()
    spawn(function()
        while MainFrame.Visible do
            task.wait(0.5)
            -- Farmar Vida
            pcall(function()
                local remote = game:GetService("ReplicatedStorage").Remotes:FindFirstChild("Branco")
                if remote then
                    remote:FireServer()
                end
            end)
            -- Farmar Força
            pcall(function()
                local dumbell = LocalPlayer.Character:FindFirstChild("Dumbell")
                if dumbell and dumbell:FindFirstChild("Event") then
                    dumbell.Event:FireServer(1)
                end
            end)
            -- Entrar e Vencer Torneio
            pcall(function()
                local remote = game:GetService("ReplicatedStorage").Remotes:FindFirstChild("Torneio")
                if remote then
                    remote:FireServer("Join")
                    task.wait(1)
                    remote:FireServer("Win")
                end
            end)
        end
    end)
end)

-- Voar
VoarButton.MouseButton1Click:Connect(function()
    local humanoidRoot = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bodyVelocity.Parent = humanoidRoot

    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Delta
            bodyVelocity.Velocity = Vector3.new(delta.X * 30, delta.Y * 30, 0)
        end
    end)
end)

-- NoClip
NoClipButton.MouseButton1Click:Connect(function()
    spawn(function()
        while true do
            task.wait(0.1)
            pcall(function()
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end)
        end
    end)
end)

-- Mudar Cor
CorButton.MouseButton1Click:Connect(function()
    spawn(function()
        while true do
            task.wait(0.5)
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Color = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
                end
            end
        end
    end)
end)

-- Chuva de Dumbbell
DumbellButton.MouseButton1Click:Connect(function()
    spawn(function()
        for i = 1, 100 do
            task.wait(0.2)
            local dumbell = LocalPlayer.Backpack:FindFirstChild("Dumbell")
            if dumbell then
                local clone = dumbell:Clone()
                clone.Parent = workspace
                clone.Handle.CFrame = CFrame.new(Vector3.new(math.random(-50,50), 50, math.random(-50,50)))
            end
        end
    end)
end)

-- Esconder Vida
EsconderVidaButton.MouseButton1Click:Connect(function()
    pcall(function()
        local char = LocalPlayer.Character
        for _,v in pairs(char:GetChildren()) do
            if v:IsA("BillboardGui") or v:IsA("Humanoid") then
                v:Destroy()
            end
        end
    end)
end)
