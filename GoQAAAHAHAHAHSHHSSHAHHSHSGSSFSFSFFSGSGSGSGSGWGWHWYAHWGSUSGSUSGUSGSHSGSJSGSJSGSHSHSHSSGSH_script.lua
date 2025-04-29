local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- GUI principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CobraKaiPainel"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = game:GetService("CoreGui")

-- Botão da Logo
local LogoButton = Instance.new("ImageButton")
LogoButton.Size = UDim2.new(0, 70, 0, 70)
LogoButton.Position = UDim2.new(0, 20, 0, 20)
LogoButton.Image = "rbxassetid://17073223843"
LogoButton.BackgroundTransparency = 1
LogoButton.Parent = ScreenGui

-- Número 15 em cima da logo
local LogoNumber = Instance.new("TextLabel")
LogoNumber.Size = UDim2.new(0, 25, 0, 25)
LogoNumber.Position = UDim2.new(1, -20, 0, -5) -- canto superior direito da logo
LogoNumber.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
LogoNumber.Text = "15"
LogoNumber.TextColor3 = Color3.new(1, 1, 1)
LogoNumber.Font = Enum.Font.GothamBold
LogoNumber.TextSize = 14
LogoNumber.Parent = LogoButton

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0) -- bem arredondado
corner.Parent = LogoNumber

-- Painel Principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 450)
MainFrame.Position = UDim2.new(0, 100, 0, 100)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Abrir / Fechar painel
LogoButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Criador de Botões
local function createButton(name, position, color, text, parent)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 290, 0, 50)
    btn.Position = position
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    return btn
end

-- Botões principais
local FarmButton = createButton("Farm", UDim2.new(0, 15, 0, 20), Color3.fromRGB(200, 0, 0), "🔴 Farm Força", MainFrame)
local BrincadeiraButton = createButton("Brincadeira", UDim2.new(0, 15, 0, 90), Color3.fromRGB(0, 100, 200), "🔵 Brincadeira", MainFrame)

-- Bot de ataque
local function criarBot()
    local bot = LocalPlayer.Character:Clone()
    bot.Name = "Bot"
    for _, v in pairs(bot:GetDescendants()) do
        if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") then
            v:Destroy()
        end
    end

    local shirt = Instance.new("Shirt", bot)
    shirt.ShirtTemplate = "rbxassetid://144076759"

    local pants = Instance.new("Pants", bot)
    pants.PantsTemplate = "rbxassetid://144076760"

    bot.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(5, 0, 0)
    bot.Parent = workspace

    spawn(function()
        while bot and bot:FindFirstChild("Humanoid") and bot.Humanoid.Health > 0 do
            task.wait(1)
            local nearest = nil
            local shortest = math.huge
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (plr.Character.HumanoidRootPart.Position - bot.HumanoidRootPart.Position).Magnitude
                    if dist < shortest then
                        shortest = dist
                        nearest = plr
                    end
                end
            end
            if nearest then
                bot:SetPrimaryPartCFrame(CFrame.new(bot.HumanoidRootPart.Position, nearest.Character.HumanoidRootPart.Position))
                bot.Humanoid:MoveTo(nearest.Character.HumanoidRootPart.Position)
            end
        end
    end)
end

-- Botão escondido
local BotButton = createButton("Bot", UDim2.new(0, 15, 0, 160), Color3.fromRGB(255, 150, 0), "[Spawnar BOT]", MainFrame)
BotButton.Visible = false

-- Mostrar botão para spawnar bot
BrincadeiraButton.MouseButton1Click:Connect(function()
    BotButton.Visible = true
end)

-- Spawnar bot
BotButton.MouseButton1Click:Connect(function()
    criarBot()
end)

-- Farm força automático
FarmButton.MouseButton1Click:Connect(function()
    spawn(function()
        while FarmButton.Visible do
            task.wait(0.5)
            pcall(function()
                local args = {[1] = 1}
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Dumbell") then
                    LocalPlayer.Character.Dumbell.Event:FireServer(unpack(args))
                end
            end)
        end
    end)
end)
