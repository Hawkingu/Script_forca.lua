local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Variáveis
local isFlying = false
local noClipEnabled = false
local colorChangeEnabled = false
local isFarmingStrength = false

-- Criar GUI
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "CobraKaiPanel"
ScreenGui.ResetOnSpawn = false

local LogoButton = Instance.new("ImageButton", ScreenGui)
LogoButton.Position = UDim2.new(0, 10, 0, 10)
LogoButton.Size = UDim2.new(0, 50, 0, 50)
LogoButton.Image = "rbxassetid://17073223843"
LogoButton.Name = "LogoButton"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 300, 0, 350)
MainFrame.Position = UDim2.new(0, 100, 0, 80)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Visible = false
local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 15)

-- Drag & Drop
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
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
    if input.UserInputType == Enum.UserInputType.MouseMovement then
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

-- Funções Botões
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
    isFarmingStrength = not isFarmingStrength
    spawn(function()
        while isFarmingStrength do
            task.wait(0.3)
            pcall(function()
                local dumbell = LocalPlayer.Backpack:FindFirstChild("Dumbell") or LocalPlayer.Character:FindFirstChild("Dumbell")
                if dumbell and dumbell:FindFirstChild("Event") then
                    dumbell.Event:FireServer(1)
                end
            end)
        end
    end)
end)

-- Controle Voar Atualizado
BrincadeiraButtons[1].MouseButton1Click:Connect(function()
    isFlying = not isFlying
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")

    local BodyGyro = Instance.new("BodyGyro")
    local BodyVelocity = Instance.new("BodyVelocity")
    BodyGyro.P = 9e4
    BodyGyro.Parent = hrp
    BodyVelocity.Velocity = Vector3.new(0,0,0)
    BodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    BodyVelocity.Parent = hrp

    local UIS = game:GetService("UserInputService")
    local speed = 100
    local control = {F = 0, B = 0, L = 0, R = 0, U = 0, D = 0}

    local function onInput(input, gpe)
        if gpe then return end
        if input.UserInputType == Enum.UserInputType.Keyboard then
            if input.KeyCode == Enum.KeyCode.W then control.F = 1 end
            if input.KeyCode == Enum.KeyCode.S then control.B = -1 end
            if input.KeyCode == Enum.KeyCode.A then control.L = -1 end
            if input.KeyCode == Enum.KeyCode.D then control.R = 1 end
            if input.KeyCode == Enum.KeyCode.Space then control.U = 1 end
            if input.KeyCode == Enum.KeyCode.LeftShift then control.D = -1 end
        end
    end

    local function onRelease(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            if input.KeyCode == Enum.KeyCode.W then control.F = 0 end
            if input.KeyCode == Enum.KeyCode.S then control.B = 0 end
            if input.KeyCode == Enum.KeyCode.A then control.L = 0 end
            if input.KeyCode == Enum.KeyCode.D then control.R = 0 end
            if input.KeyCode == Enum.KeyCode.Space then control.U = 0 end
            if input.KeyCode == Enum.KeyCode.LeftShift then control.D = 0 end
        end
    end

    UIS.InputBegan:Connect(onInput)
    UIS.InputEnded:Connect(onRelease)

    spawn(function()
        while isFlying do
            task.wait()
            local moveVector = Vector3.new(control.L + control.R, control.U + control.D, control.F + control.B)
            BodyVelocity.Velocity = (hrp.CFrame:VectorToWorldSpace(moveVector)) * speed
            BodyGyro.CFrame = hrp.CFrame
        end
        BodyGyro:Destroy()
        BodyVelocity:Destroy()
    end)
end)

-- NoClip
BrincadeiraButtons[2].MouseButton1Click:Connect(function()
    noClipEnabled = not noClipEnabled
    spawn(function()
        while noClipEnabled do
            task.wait()
            pcall(function()
                for _,v in pairs(LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end)
        end
    end)
end)

-- Mudar Cor
BrincadeiraButtons[3].MouseButton1Click:Connect(function()
    colorChangeEnabled = not colorChangeEnabled
    spawn(function()
        while colorChangeEnabled do
            task.wait(0.5)
            for _,v in pairs(LocalPlayer.Character:GetDescendants()) do
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
        for _,v in pairs(LocalPlayer.Character:GetChildren()) do
            if v:IsA("BillboardGui") or v:IsA("Humanoid") then
                pcall(function() v:Destroy() end)
            end
        end
    end)
end)
