task.spawn(function()
    task.wait(1)

    -- Criar GUI Principal
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "SuperPanel"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

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
                -- Ativar função
                if func.Name == "Ficar Invisível" then
                    local char = game.Players.LocalPlayer.Character
                    if char then
                        for _, part in pairs(char:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.Transparency = 1
                            end
                        end
                    end
                elseif func.Name == "Atravessar Parede" then
                    local char = game.Players.LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        char.HumanoidRootPart.CanCollide = false
                    end
                elseif func.Name == "Atacar Saco de Pancada" then
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/Hawkingu/Script_forca.lua/refs/heads/main/Atackscdepancada_script.lua"))()
                elseif func.Name == "Ficar Rápido" then
                    local char = game.Players.LocalPlayer.Character
                    if char and char:FindFirstChild("Humanoid") then
                        char.Humanoid.WalkSpeed = 100
                    end
                elseif func.Name == "Skin Brilhando" then
                    local char = game.Players.LocalPlayer.Character
                    if char then
                        for _, part in pairs(char:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.Material = Enum.Material.Neon
                                part.Color = Color3.fromRGB(255, 255, 255)
                            end
                        end
                    end
                elseif func.Name == "Andar Rápido" then
                    local char = game.Players.LocalPlayer.Character
                    if char and char:FindFirstChild("Humanoid") then
                        char.Humanoid.WalkSpeed = 60
                    end
                end
            else
                button.Text = func.Name
                -- Desativar função
                if func.Name == "Ficar Invisível" then
                    local char = game.Players.LocalPlayer.Character
                    if char then
                        for _, part in pairs(char:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.Transparency = 0
                            end
                        end
                    end
                elseif func.Name == "Atravessar Parede" then
                    local char = game.Players.LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        char.HumanoidRootPart.CanCollide = true
                    end
                elseif func.Name == "Ficar Rápido" or func.Name == "Andar Rápido" then
                    local char = game.Players.LocalPlayer.Character
                    if char and char:FindFirstChild("Humanoid") then
                        char.Humanoid.WalkSpeed = 16
                    end
                elseif func.Name == "Skin Brilhando" then
                    local char = game.Players.LocalPlayer.Character
                    if char then
                        for _, part in pairs(char:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.Material = Enum.Material.Plastic
                                part.Color = Color3.fromRGB(255, 255, 255)
                            end
                        end
                    end
                end
            end
        end)

        table.insert(buttons, button)
    end
end)
