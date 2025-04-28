-- Criar GUI Principal
local ScreenGui = Instance.new("ScreenGui")
local MainButton = Instance.new("TextButton")
local Panel = Instance.new("Frame")

-- Botões de funções
local functionsList = {
    {Name = "Ficar Invisível", Executing = false},
    {Name = "Atravessar Parede", Executing = false},
    {Name = "Atacar Saco de Pancada", Executing = false},
    {Name = "Ficar Rápido", Executing = false},
    {Name = "Skin Brilhando", Executing = false},
    {Name = "Andar Rápido", Executing = false}
}

local buttons = {}

-- Configurar GUI
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "SuperPanel"

-- Botão 💪🏻 no canto
MainButton.Parent = ScreenGui
MainButton.Size = UDim2.new(0, 50, 0, 50)
MainButton.Position = UDim2.new(0, 10, 0, 10)
MainButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainButton.Text = "💪🏻"
MainButton.TextSize = 30
MainButton.Visible = true

-- Painel (inicialmente fechado)
Panel.Parent = ScreenGui
Panel.Size = UDim2.new(0, 250, 0, 300)
Panel.Position = UDim2.new(0, 70, 0, 10)
Panel.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
Panel.Visible = false
Panel.BorderSizePixel = 2
Panel.BorderColor3 = Color3.fromRGB(0, 0, 0)

-- Função abrir/fechar painel
MainButton.MouseButton1Click:Connect(function()
    Panel.Visible = not Panel.Visible
end)

-- Criar botões dinamicamente
for i, func in ipairs(functionsList) do
    local button = Instance.new("TextButton")
    button.Parent = Panel
    button.Size = UDim2.new(0, 230, 0, 40)
    button.Position = UDim2.new(0, 10, 0, (i - 1) * 45)
    button.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
    button.TextColor3 = Color3.fromRGB(0, 0, 0)
    button.Text = func.Name
    button.TextSize = 20
    
    button.MouseButton1Click:Connect(function()
        func.Executing = not func.Executing
        if func.Executing then
            button.Text = func.Name .. " (Executando...)"
            -- Ativar função específica
            if func.Name == "Ficar Invisível" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Transparency = 1
            elseif func.Name == "Atravessar Parede" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CanCollide = false
            elseif func.Name == "Atacar Saco de Pancada" then
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Hawkingu/Script_forca.lua/refs/heads/main/Atackscdepancada_script.lua"))()
            elseif func.Name == "Ficar Rápido" then
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
            elseif func.Name == "Skin Brilhando" then
                for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Material = Enum.Material.Neon
                        part.Color = Color3.fromRGB(255, 255, 255)
                    end
                end
            elseif func.Name == "Andar Rápido" then
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 60
            end
        else
            button.Text = func.Name
            -- Desativar função específica
            if func.Name == "Ficar Invisível" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Transparency = 0
            elseif func.Name == "Atravessar Parede" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CanCollide = true
            elseif func.Name == "Ficar Rápido" then
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
            elseif func.Name == "Skin Brilhando" then
                for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Material = Enum.Material.Plastic
                        part.Color = Color3.fromRGB(255, 255, 255)
                    end
                end
            elseif func.Name == "Andar Rápido" then
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
            end
        end
    end)

    table.insert(buttons, button)
end
