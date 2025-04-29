local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- GUI principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CobraKaiPainel"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- LOGO
local LogoButton = Instance.new("TextButton")
LogoButton.Size = UDim2.new(0, 200, 0, 60)
LogoButton.Position = UDim2.new(0, 20, 0, 20)
LogoButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
LogoButton.Text = "15 Melhor do Mundo"
LogoButton.TextColor3 = Color3.new(1, 1, 1)
LogoButton.Font = Enum.Font.GothamBlack
LogoButton.TextSize = 22
LogoButton.Parent = ScreenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = LogoButton

-- Painel Principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 500)
MainFrame.Position = UDim2.new(0, 250, 0, 100)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Função criar botão
local function createButton(name, position, color, text, parent)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 300, 0, 50)
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
local FarmButton = createButton("Farm", UDim2.new(0, 25, 0, 20), Color3.fromRGB(200, 0, 0), "🔴 Farm", MainFrame)
local BrincadeiraButton = createButton("Brincadeira", UDim2.new(0, 25, 0, 90), Color3.fromRGB(0, 100, 200), "🔵 Brincadeira", MainFrame)

-- Botões ocultos
local BotaoVoar = createButton("Voar", UDim2.new(0, 25, 0, 170), Color3.fromRGB(0, 200, 100), "Ativar Voo", MainFrame)
BotaoVoar.Visible = false

local BotaoCriarBot = createButton("CriarBot", UDim2.new(0, 25, 0, 240), Color3.fromRGB(255, 150, 0), "Spawnar Bot", MainFrame)
BotaoCriarBot.Visible = false

local BotaoAtravessarParede = createButton("NoClip", UDim2.new(0, 25, 0, 310), Color3.fromRGB(150, 0, 255), "Atravessar Paredes", MainFrame)
BotaoAtravessarParede.Visible = false

local BotaoFarmarForca = createButton("FarmForca", UDim2.new(0, 25, 0, 380), Color3.fromRGB(255, 255, 0), "Farmar Força Automático", MainFrame)
BotaoFarmarForca.Visible = false

local BotaoFarmTorneio = createButton("FarmTorneio", UDim2.new(0, 25, 0, 170), Color3.fromRGB(200, 0, 200), "Farm Torneio", MainFrame)
BotaoFarmTorneio.Visible = false

local BotaoKill = createButton("KillAll", UDim2.new(0, 25, 0, 240), Color3.fromRGB(255, 0, 100), "Matar todo mundo", MainFrame)
BotaoKill.Visible = false

-- Abrir / Fechar painel
LogoButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Brincadeira mostra botões
BrincadeiraButton.MouseButton1Click:Connect(function()
    BotaoVoar.Visible = true
    BotaoCriarBot.Visible = true
    BotaoAtravessarParede.Visible = true
    BotaoFarmarForca.Visible = true
    BotaoFarmTorneio.Visible = false
    BotaoKill.Visible = false
end)

-- Farm mostra botões
FarmButton.MouseButton1Click:Connect(function()
    BotaoVoar.Visible = false
    BotaoCriarBot.Visible = false
    BotaoAtravessarParede.Visible = false
    BotaoFarmarForca.Visible = true
    BotaoFarmTorneio.Visible = true
    BotaoKill.Visible = true
end)

-- Funcionalidades dos botões:

-- Voar
local flying = false
BotaoVoar.MouseButton1Click:Connect(function()
    flying = not flying
    local hrp = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    spawn(function()
        while flying do
            hrp.Velocity = Vector3.new(0, 50, 0)
            task.wait()
        end
    end)
end)

-- Criar Bot
BotaoCriarBot.MouseButton1Click:Connect(function()
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
end)

-- NoClip (atravessar parede)
local noclip = false
BotaoAtravessarParede.MouseButton1Click:Connect(function()
    noclip = not noclip
    RunService.Stepped:Connect(function()
        if noclip then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end)

-- Farmar força (auto click)
BotaoFarmarForca.MouseButton1Click:Connect(function()
    spawn(function()
        while BotaoFarmarForca.Visible do
            task.wait(0.3)
            pcall(function()
                local args = {[1] = 1}
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Dumbell") then
                    LocalPlayer.Character.Dumbell.Event:FireServer(unpack(args))
                end
            end)
        end
    end)
end)

-- Farm Torneio (teleportar para arena de torneio)
BotaoFarmTorneio.MouseButton1Click:Connect(function()
    local tournamentSpawn = workspace:FindFirstChild("TorneioSpawn")
    if tournamentSpawn then
        LocalPlayer.Character.HumanoidRootPart.CFrame = tournamentSpawn.CFrame
    end
end)

-- Kill todo mundo fora da safe zone
BotaoKill.MouseButton1Click:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                humanoid.Health = 0
            end
        end
    end
end)
