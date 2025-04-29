--// CONFIGURAÇÃO INICIAL
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- Criar o GUI principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.Name = "PainelHawk"

-- Logo (bolinha 🕴)
local LogoButton = Instance.new("ImageButton", ScreenGui)
LogoButton.Size = UDim2.new(0, 50, 0, 50)
LogoButton.Position = UDim2.new(0, 10, 0, 10)
LogoButton.Image = "rbxassetid://17073223843" -- Use uma imagem redonda aqui
LogoButton.Name = "LogoButton"

-- Painel principal
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0, 100, 0, 100)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Visible = false

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 15)

-- Botão de fechar
local CloseButton = Instance.new("TextButton", MainFrame)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.Text = "X"
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseButton.TextColor3 = Color3.fromRGB(255,255,255)

-- Funções abrir/fechar
LogoButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Movimentar o painel
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

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

-- TÍTULOS
local FarmLabel = Instance.new("TextLabel", MainFrame)
FarmLabel.Size = UDim2.new(1, -20, 0, 30)
FarmLabel.Position = UDim2.new(0, 10, 0, 10)
FarmLabel.BackgroundTransparency = 1
FarmLabel.Text = "Farm"
FarmLabel.TextColor3 = Color3.fromRGB(255,255,255)
FarmLabel.TextScaled = true

local BrincadeiraLabel = Instance.new("TextLabel", MainFrame)
BrincadeiraLabel.Size = UDim2.new(1, -20, 0, 30)
BrincadeiraLabel.Position = UDim2.new(0, 10, 0, 200)
BrincadeiraLabel.BackgroundTransparency = 1
BrincadeiraLabel.Text = "Brincadeira"
BrincadeiraLabel.TextColor3 = Color3.fromRGB(255,255,255)
BrincadeiraLabel.TextScaled = true

-- BOTÕES FARM
local farmFunctions = {
    {"○ Auto Força", function()
        while _G.autoForca do
            local args = {[1] = 1}
            game:GetService("Players").LocalPlayer.Character.Dumbell.Event:FireServer(unpack(args))
            wait(1)
        end
    end},

    {"○ Auto Vida", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hawk/teuscript/main/script.lua"))()
    end},

    {"○ Auto Dar Reset", function()
        while _G.autoReset do
            game:GetService("Players").LocalPlayer.Character:BreakJoints()
            wait(5)
        end
    end},

    {"○ Auto Stamina", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/crashrlq/stamina/refs/heads/main/README.md"))()
    end},
}

local YFarm = 50
for _,v in ipairs(farmFunctions) do
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(1, -20, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, YFarm)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Text = v[1]
    btn.TextScaled = true
    btn.MouseButton1Click:Connect(function()
        local name = v[1]
        if name == "○ Auto Força" then
            _G.autoForca = not _G.autoForca
            if _G.autoForca then spawn(v[2]) end
        elseif name == "○ Auto Dar Reset" then
            _G.autoReset = not _G.autoReset
            if _G.autoReset then spawn(v[2]) end
        else
            v[2]()
        end
    end)
    YFarm = YFarm + 40
end

-- BOTÕES BRINCADEIRA
local brincadeiraFunctions = {
    {"□ Atravessar parede", function()
        local char = LocalPlayer.Character
        while _G.noclip do
            for _, v in ipairs(char:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
            wait(0.1)
        end
    end},

    {"□ Pegar fogo", function()
        local fire = Instance.new("Fire", LocalPlayer.Character.HumanoidRootPart)
        fire.Size = 5
        fire.Heat = 10
    end},

    {"□ Voar pra todo lado", function()
        local HRP = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
        local bv = Instance.new("BodyVelocity", HRP)
        bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        spawn(function()
            while _G.flying do
                bv.Velocity = Vector3.new(
                    (UserInputService:IsKeyDown(Enum.KeyCode.D) and 50 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.A) and 50 or 0),
                    (UserInputService:IsKeyDown(Enum.KeyCode.Space) and 50 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and 50 or 0),
                    (UserInputService:IsKeyDown(Enum.KeyCode.S) and 50 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.W) and 50 or 0)
                )
                wait()
            end
            bv:Destroy()
        end)
    end},
}

local YBrincadeira = 240
for _,v in ipairs(brincadeiraFunctions) do
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(1, -20, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, YBrincadeira)
    btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Text = v[1]
    btn.TextScaled = true
    btn.MouseButton1Click:Connect(function()
        local name = v[1]
        if name == "□ Atravessar parede" then
            _G.noclip = not _G.noclip
            if _G.noclip then spawn(v[2]) end
        elseif name == "□ Voar pra todo lado" then
            _G.flying = not _G.flying
            if _G.flying then spawn(v[2]) end
        else
            v[2]()
        end
    end)
    YBrincadeira = YBrincadeira + 40
end
