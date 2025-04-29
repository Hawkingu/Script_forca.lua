local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- Tela principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CobraKaiPainel"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Botão da Logo
local LogoButton = Instance.new("ImageButton")
LogoButton.Size = UDim2.new(0, 60, 0, 60)
LogoButton.Position = UDim2.new(0, 10, 0, 10)
LogoButton.Image = "rbxassetid://17073223843"
LogoButton.Parent = ScreenGui

-- Painel Principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 460)
MainFrame.Position = UDim2.new(0, 80, 0, 80)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Draggable
local dragging, dragInput, dragStart, startPos

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

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Função de mostrar painel
LogoButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Botões
local function createButton(name, position, color, text, parent)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 270, 0, 40)
    btn.Position = position
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.Parent = parent
    return btn
end

local FarmButton = createButton("Farm", UDim2.new(0, 15, 0, 10), Color3.fromRGB(200, 0, 0), "🔴 Farm", MainFrame)
local BrincadeiraButton = createButton("Brincadeira", UDim2.new(0, 15, 0, 60), Color3.fromRGB(0, 100, 200), "🔵 Brincadeira", MainFrame)

-- Botões ocultos
local VidaButton = createButton("Vida", UDim2.new(0, 15, 0, 120), Color3.fromRGB(50, 150, 50), "[+5 Vida]", MainFrame)
VidaButton.Visible = false

local ForcaButton = createButton("Forca", UDim2.new(0, 15, 0, 170), Color3.fromRGB(50, 150, 50), "[+5 Força]", MainFrame)
ForcaButton.Visible = false

local BrancaButton = createButton("Branca", UDim2.new(0, 15, 0, 220), Color3.fromRGB(150, 75, 0), "[Spawnar BRANCA]", MainFrame)
BrancaButton.Visible = false

local BotButton = createButton("Bot", UDim2.new(0, 15, 0, 270), Color3.fromRGB(255, 100, 100), "[+Spawnar Bot Farmador]", MainFrame)
BotButton.Visible = false

local VoarButton = createButton("Voar", UDim2.new(0, 15, 0, 320), Color3.fromRGB(100, 100, 255), "[Voar]", MainFrame)
VoarButton.Visible = false

local NoClipButton = createButton("NoClip", UDim2.new(0, 15, 0, 370), Color3.fromRGB(255, 150, 0), "[Atravessar Paredes]", MainFrame)
NoClipButton.Visible = false

local TralalaButton = createButton("Tralala", UDim2.new(0, 15, 0, 420), Color3.fromRGB(255, 0, 255), "[Tralalero Tralalala]", MainFrame)
TralalaButton.Visible = false

-- Controladores de botões
FarmButton.MouseButton1Click:Connect(function()
    VidaButton.Visible = true
    ForcaButton.Visible = true
    BrancaButton.Visible = true
    BotButton.Visible = true
    VoarButton.Visible = false
    NoClipButton.Visible = false
    TralalaButton.Visible = false
end)

BrincadeiraButton.MouseButton1Click:Connect(function()
    VidaButton.Visible = false
    ForcaButton.Visible = false
    BrancaButton.Visible = false
    BotButton.Visible = false
    VoarButton.Visible = true
    NoClipButton.Visible = true
    TralalaButton.Visible = true
end)

-- [+5 Vida]
VidaButton.MouseButton1Click:Connect(function()
    while VidaButton.Visible do
        task.wait(0.5)
        pcall(function()
            game:GetService("ReplicatedStorage").Remotes.Branco:FireServer()
        end)
    end
end)

-- [+5 Força] (Farm automático sem clicar)
ForcaButton.MouseButton1Click:Connect(function()
    while ForcaButton.Visible do
        task.wait(0.5)
        pcall(function()
            local args = {[1] = 1}
            game:GetService("Players").LocalPlayer.Character.Dumbell.Event:FireServer(unpack(args))
        end)
    end
end)

-- [Spawnar BRANCA]
BrancaButton.MouseButton1Click:Connect(function()
    pcall(function()
        local branca = LocalPlayer.Backpack:FindFirstChild("Branca")
        if branca then
            local clone = branca:Clone()
            clone.Parent = workspace
            clone.Handle.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(3, 0, 0)
        end
    end)
end)

-- [Spawnar BOT]
local function criarBot()
    local character = LocalPlayer.Character
    if not character then return end

    local bot = character:Clone()
    bot.Parent = workspace
    bot.Name = "FarmBot_"..math.random(1000)

    for _,v in pairs(bot:GetDescendants()) do
        if v:IsA("Accessory") or v:IsA("Hat") then
            v:Destroy()
        end
    end

    local shirt = bot:FindFirstChildOfClass("Shirt")
    if shirt then
        shirt.ShirtTemplate = "rbxassetid://14407676092"
    else
        local newShirt = Instance.new("Shirt", bot)
        newShirt.ShirtTemplate = "rbxassetid://14407676092"
    end

    local pants = bot:FindFirstChildOfClass("Pants")
    if pants then
        pants.PantsTemplate = "rbxassetid://14407678592"
    else
        local newPants = Instance.new("Pants", bot)
        newPants.PantsTemplate = "rbxassetid://14407678592"
    end

    -- Bot atacando jogadores fora da safezone
    task.spawn(function()
        while bot and bot.Parent do
            task.wait(1)
            for _,player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                    if humanoid and humanoid.Health > 0 then
                        local safezone = workspace:FindFirstChild("SafeZone")
                        if safezone and (hrp.Position - safezone.Position).Magnitude > safezone.Size.X/2 then
                            pcall(function()
                                bot:MoveTo(hrp.Position)
                            end)
                        end
                    end
                end
            end
        end
    end)
end

BotButton.MouseButton1Click:Connect(function()
    criarBot()
end)

-- [Voar]
local flying = false
VoarButton.MouseButton1Click:Connect(function()
    flying = not flying
    if flying then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.Parent = hrp
        UserInputService.InputChanged:Connect(function(input)
            if flying and input.UserInputType == Enum.UserInputType.Touch then
                local delta = input.Delta
                bv.Velocity = Vector3.new(delta.X * 5, delta.Y * 5, 0)
            end
        end)
    else
        local hrp = LocalPlayer.Character.HumanoidRootPart
        if hrp:FindFirstChildOfClass("BodyVelocity") then
            hrp:FindFirstChildOfClass("BodyVelocity"):Destroy()
        end
    end
end)

-- [Atravessar paredes]
local noclip = false
NoClipButton.MouseButton1Click:Connect(function()
    noclip = not noclip
    while noclip do
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

-- [Tralala Dumbell]
TralalaButton.MouseButton1Click:Connect(function()
    spawn(function()
        for i = 1, 50 do
            task.wait(0.1)
            local dumbell = LocalPlayer.Backpack:FindFirstChild("Dumbell")
            if dumbell then
                local clone = dumbell:Clone()
                clone.Parent = workspace
                clone.Handle.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(math.random(-10,10), math.random(5,10), math.random(-10,10))
            end
        end
    end)
end)
