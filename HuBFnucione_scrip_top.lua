-- Este script cria um painel com botões para ativar/desativar várias funções

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local ButtonInvisible = Instance.new("TextButton")
local ButtonWallHack = Instance.new("TextButton")
local ButtonDumbbell = Instance.new("TextButton")
local ButtonPunchBag = Instance.new("TextButton")

-- Configuração da GUI
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "CustomPanel"

Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 200, 0, 400)
Frame.Position = UDim2.new(0, 20, 0, 20)
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BackgroundTransparency = 0.5

-- Botão de invisibilidade
ButtonInvisible.Parent = Frame
ButtonInvisible.Size = UDim2.new(0, 180, 0, 40)
ButtonInvisible.Position = UDim2.new(0, 10, 0, 10)
ButtonInvisible.Text = "Ficar Invisível ◀️▶️"
ButtonInvisible.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ButtonInvisible.TextColor3 = Color3.fromRGB(255, 255, 255)

local isInvisible = false
ButtonInvisible.MouseButton1Click:Connect(function()
    isInvisible = not isInvisible
    if isInvisible then
        game.Players.LocalPlayer.Character.HumanoidRootPart.Transparency = 1
        game.Players.LocalPlayer.Character.HumanoidRootPart.CanCollide = false
    else
        game.Players.LocalPlayer.Character.HumanoidRootPart.Transparency = 0
        game.Players.LocalPlayer.Character.HumanoidRootPart.CanCollide = true
    end
end)

-- Botão de atravessar paredes
ButtonWallHack.Parent = Frame
ButtonWallHack.Size = UDim2.new(0, 180, 0, 40)
ButtonWallHack.Position = UDim2.new(0, 10, 0, 60)
ButtonWallHack.Text = "Atravessar Parede ◀️▶️"
ButtonWallHack.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ButtonWallHack.TextColor3 = Color3.fromRGB(255, 255, 255)

local isWallHackEnabled = false
ButtonWallHack.MouseButton1Click:Connect(function()
    isWallHackEnabled = not isWallHackEnabled
    if isWallHackEnabled then
        -- Habilitar atravessar paredes (Exemplo de teleporte, você pode adaptar conforme necessário)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CanCollide = false
    else
        game.Players.LocalPlayer.Character.HumanoidRootPart.CanCollide = true
    end
end)

-- Botão de Dumbbell (Simulando uma melhoria física)
ButtonDumbbell.Parent = Frame
ButtonDumbbell.Size = UDim2.new(0, 180, 0, 40)
ButtonDumbbell.Position = UDim2.new(0, 10, 0, 110)
ButtonDumbbell.Text = "Dumbell ◀️▶️"
ButtonDumbbell.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ButtonDumbbell.TextColor3 = Color3.fromRGB(255, 255, 255)

local isDumbbellEnabled = false
ButtonDumbbell.MouseButton1Click:Connect(function()
    isDumbbellEnabled = not isDumbbellEnabled
    if isDumbbellEnabled then
        -- Ativar função de Dumbbell (Ajuste conforme sua necessidade)
        -- Exemplo de aumento de força ou velocidade
    else
        -- Desativar função de Dumbbell
    end
end)

-- Botão para o Saco de Pancada
ButtonPunchBag.Parent = Frame
ButtonPunchBag.Size = UDim2.new(0, 180, 0, 40)
ButtonPunchBag.Position = UDim2.new(0, 10, 0, 160)
ButtonPunchBag.Text = "Saco de Pancada ◀️▶️"
ButtonPunchBag.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ButtonPunchBag.TextColor3 = Color3.fromRGB(255, 255, 255)

ButtonPunchBag.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Hawkingu/Script_forca.lua/refs/heads/main/Atackscdepancada_script.lua"))()
end)
