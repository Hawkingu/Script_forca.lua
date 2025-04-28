task.spawn(function()
    task.wait(1)

    -- Criar GUI Principal
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "SuperPanel"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local MainButton = Instance.new("TextButton")
    local Panel = Instance.new("Frame")

    -- Funções e status
    local functionsList = {
        {Name = "Farm Dumbell", Executing = false},
        {Name = "Auto Saco de Pancada", Executing = false},
        {Name = "Ficar Rápido", Executing = false},
        {Name = "Super Pulo", Executing = false},
        {Name = "Invisível", Executing = false},
        {Name = "Skin Neon", Executing = false},
        {Name = "Atravessar Paredes", Executing = false},
        {Name = "Modo AFK Farm", Executing = false}
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
    Panel.Size = UDim2.new(0, 250, 0, 380)
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
                if func.Name == "Farm Dumbell" then
                    local args = { [1] = 1 }
                    game:GetService("Players").LocalPlayer.Character.Dumbell.Event:FireServer(unpack(args))
                elseif func.Name == "Auto Saco de Pancada" then
                    -- Script do Saco de Pancada aqui
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/Hawkingu/Script_forca.lua/refs/heads/main/Atackscdepancada_script.lua"))()
                elseif func.Name == "Ficar Rápido" then
                    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
                elseif func.Name == "Super Pulo" then
                    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 150
                elseif func.Name == "Invisível" then
                    local char = game.Players.LocalPlayer.Character
                    for _, part in pairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Transparency = 1
                            part.CanCollide = false
                        end
                    end
                elseif func.Name == "Skin Neon" then
                    local char = game.Players.LocalPlayer.Character
                    for _, part in pairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Material = Enum.Material.Neon
                            part.Color = Color3.fromRGB(0, 255, 255)
                        end
                    end
                elseif func.Name == "Atravessar Paredes" then
                    local char = game.Players.LocalPlayer.Character
                    if char then
                        for _, part in pairs(char:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end
                elseif func.Name == "Modo AFK Farm" then
                    -- Ativar farm AFK (farmando automaticamente)
                    -- Pode usar alguma técnica de mouse mover, por exemplo, ou apertar tecla
                    while func.Executing do
                        local args = { [1] = 1 }
                        game:GetService("Players").LocalPlayer.Character.Dumbell.Event:FireServer(unpack(args))
                        task.wait(1)
                    end
                end
            else
                button.Text = func.Name
                -- Desativar função
                if func.Name == "Farm Dumbell" then
                    -- Não faz nada específico
                elseif func.Name == "Auto Saco de Pancada" then
                    -- Não faz nada específico
                elseif func.Name == "Ficar Rápido" then
                    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
                elseif func.Name == "Super Pulo" then
                    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
                elseif func.Name == "Invisível" then
                    local char = game.Players.LocalPlayer.Character
                    for _, part in pairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Transparency = 0
                            part.CanCollide = true
                        end
                    end
                elseif func.Name == "Skin Neon" then
                    local char = game.Players.LocalPlayer.Character
                    for _, part in pairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Material = Enum.Material.Plastic
                            part.Color = Color3.fromRGB(255, 255, 255)
                        end
                    end
                elseif func.Name == "Atravessar Paredes" then
                    local char = game.Players.LocalPlayer.Character
                    for _, part in pairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = true
                        end
                    end
                elseif func.Name == "Modo AFK Farm" then
                    -- Desativa o farm AFK
                    while func.Executing do
                        task.wait(1)
                    end
                end
            end
        end)

        table.insert(buttons, button)
    end
end)
