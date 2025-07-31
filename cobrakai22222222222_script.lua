-- Painel HAWKEXECUT+ Cobra Kai - Força, Vida e Resistência (+100 por 50ms)
local RS = game:GetService("ReplicatedStorage")
local situp = RS:FindFirstChild("Situp")
local pushup = RS:FindFirstChild("Pushup")
local framework = RS:FindFirstChild("FrameworkEvent")

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "HAWKEXECUT_GUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 260)
frame.Position = UDim2.new(0, 5, 0, 5) -- canto superior esquerdo
frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Text = "HAWKEXECUT+"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(0, 0, 0)
title.Font = Enum.Font.FredokaOne
title.TextScaled = true

-- Estados
local farmForca = false
local farmVida = false
local farmResistencia = false

-- Funções
local function loopFarm(tipo)
    return task.spawn(function()
        while _G[tipo] do
            task.wait(0.05)
            if tipo == "farmForca" then
                if situp then situp:FireServer(100) end
                if pushup then pushup:FireServer(100) end
            elseif tipo == "farmVida" then
                if framework then framework:FireServer("Health", 100) end
            elseif tipo == "farmResistencia" then
                if framework then framework:FireServer("Endurance", 100) end
            end
        end
    end)
end

-- Botões criador
local function criarBotao(texto, y, cor, onClick)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -20, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.BackgroundColor3 = cor or Color3.fromRGB(255, 255, 255)
    btn.TextColor3 = Color3.new(0, 0, 0)
    btn.Text = texto
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.BorderSizePixel = 0
    btn.MouseButton1Click:Connect(onClick)
end

-- Botões de força
criarBotao("Farm Força", 40, nil, function()
    if not farmForca then
        _G.farmForca = true
        farmForca = true
        loopFarm("farmForca")
    end
end)

criarBotao("Desativar Farm Força", 75, Color3.fromRGB(200,200,200), function()
    _G.farmForca = false
    farmForca = false
end)

-- Botões de vida
criarBotao("Farm Vida", 110, nil, function()
    if not farmVida then
        _G.farmVida = true
        farmVida = true
        loopFarm("farmVida")
    end
end)

criarBotao("Desativar Farm Vida", 145, Color3.fromRGB(200,200,200), function()
    _G.farmVida = false
    farmVida = false
end)

-- Botões de resistência
criarBotao("Farm Resistência", 180, nil, function()
    if not farmResistencia then
        _G.farmResistencia = true
        farmResistencia = true
        loopFarm("farmResistencia")
    end
end)

criarBotao("Desativar Farm Resistência", 215, Color3.fromRGB(200,200,200), function()
    _G.farmResistencia = false
    farmResistencia = false
end)
