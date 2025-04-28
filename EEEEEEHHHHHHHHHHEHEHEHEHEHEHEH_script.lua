local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Variáveis de estado para cada função
local isFlying = false
local noClipEnabled = false
local colorChangeEnabled = false

-- Criar tela
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "CobraKaiPanel"
ScreenGui.ResetOnSpawn = false

-- Criar botão da logo
local LogoButton = Instance.new("ImageButton", ScreenGui)
LogoButton.Position = UDim2.new(0, 10, 0, 10)
LogoButton.Size = UDim2.new(0, 50, 0, 50)
LogoButton.Image = "rbxassetid://17073223843"
LogoButton.Name = "LogoButton"

-- Criar painel
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 300, 0, 350)
MainFrame.Position = UDim2.new(0, 100, 0, 80)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Visible = false

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 15)

-- Drag and drop
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

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Botões principais
local FarmButton = Instance.new("TextButton", MainFrame)
local BrincadeiraButton = Instance.new("TextButton", MainFrame)

FarmButton.Size = UDim2.new(0, 270, 0, 35)
FarmButton.Position = UDim2.new(0, 15, 0, 10)
FarmButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
FarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmButton.Text = "🔴 Farm"

BrincadeiraButton.Size = UDim2.new(0, 270, 0, 35)
BrincadeiraButton.Position = UDim2.new(0, 15, 0, 55)
BrincadeiraButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
BrincadeiraButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BrincadeiraButton.Text = "🔵 Brincadeira"

-- Sub-opções Farm
local VidaButton = Instance.new("TextButton", MainFrame)
local ForcaButton = Instance.new("TextButton", MainFrame)

VidaButton.Size = UDim2.new(0.45, -10, 0, 30)
VidaButton.Position = UDim2.new(0, 15, 0, 100)
VidaButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
VidaButton.TextColor3 = Color3.fromRGB(255, 255, 255)
VidaButton.Text = "[Vida +5]"
VidaButton.Visible = false

ForcaButton.Size = UDim2.new(0.45, -10, 0, 30)
ForcaButton.Position = UDim2.new(0.55, 5, 0, 100)
ForcaButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
ForcaButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ForcaButton.Text = "[Força +5]"
ForcaButton.Visible = false

-- Sub-opções Brincadeira
local OpcoesBrincadeira = {
    {Texto = "[Voar]"},
    {Texto = "[Atravessar Paredes]"},
    {Texto = "[Mudar Cor]"},
    {Texto = "[Chuva de Dumbell]"},
    {Texto = "[Esconder Vida]"},
}

local BrincadeiraButtons = {}

for i, info in ipairs(OpcoesBrincadeira) do
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0.45, -10, 0, 30)

    if i % 2 == 1 then
        btn.Position = UDim2.new(0, 15, 0, 140 + (math.floor(i/2))*40)
    else
        btn.Position = UDim2.new(0.55, 5, 0, 140 + (math.floor((i-1)/2))*40)
    end

    btn.BackgroundColor3 = Color3.fromRGB(80, 80, 200)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = info.Texto
    btn.Visible = false
    table.insert(BrincadeiraButtons, btn)
end

-- Mostrar painel
LogoButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

FarmButton.MouseButton1Click:Connect(function()
    local ativo = not VidaButton.Visible
    VidaButton.Visible = ativo
    ForcaButton.Visible = ativo
    for _, b in ipairs(BrincadeiraButtons) do
        b.Visible = false
    end
end)

BrincadeiraButton.MouseButton1Click:Connect(function()
    local ativo = not BrincadeiraButtons[1].Visible
    VidaButton.Visible = false
    ForcaButton.Visible = false
    for _, b in ipairs(BrincadeiraButtons) do
        b.Visible = ativo
    end
end)

-- Funções dos botões
VidaButton.MouseButton1Click:Connect(function()
    spawn(function()
        while VidaButton.Visible do
            task.wait(0.3)
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.Branco:FireServer()
            end)
        end
    end)
end)

ForcaButton.MouseButton1Click:Connect(function()
    pcall(function()
        game:GetService("Players").LocalPlayer.Character.Dumbell.Event:FireServer(1)
    end)
end)

-- Controle Voar
BrincadeiraButtons[1].MouseButton1Click:Connect(function()
    if not isFlying then
        isFlying = true
        spawn(function()
            local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local body = Instance.new("BodyVelocity", char.HumanoidRootPart)
            body.Velocity = Vector3.new(0, 50, 0)
            body.MaxForce = Vector3.new(999999, 999999, 999999)
            while isFlying do
                task.wait()
            end
            body:Destroy()
        end)
    else
        isFlying = false
    end
end)

-- Controle NoClip
BrincadeiraButtons[2].MouseButton1Click:Connect(function()
    noClipEnabled = not noClipEnabled
    spawn(function()
        while noClipEnabled do
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

-- Controle Mudar Cor
BrincadeiraButtons[3].MouseButton1Click:Connect(function()
    colorChangeEnabled = not colorChangeEnabled
    spawn(function()
        while colorChangeEnabled do
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
BrincadeiraButtons[4].MouseButton1Click:Connect(function()
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
BrincadeiraButtons[5].MouseButton1Click:Connect(function()
    spawn(function()
        local char = LocalPlayer.Character
        for _,v in pairs(char:GetChildren()) do
            if v:IsA("BillboardGui") or v:IsA("Humanoid") then
                pcall(function() v:Destroy() end)
            end
        end
    end)
end)
