-- Função auxiliar para pegar o remote event e os args (mesmo que você já tenha)
function getNil(name,class) 
    for _,v in pairs(getnilinstances()) do 
        if v.ClassName == class and v.Name == name then 
            return v
        end 
    end 
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local remote = ReplicatedStorage:FindFirstChild("ea9d9631-eacc-4314-a813-ffaa837ee5c0")

local args = {
    [1] = {
        ["Received"] = 7,
        ["Loader"] = getNil("", "Folder").ClientMover,
        ["Mode"] = "Fire",
        ["Sent"] = 11,
        ["Module"] = getNil("Client", "ModuleScript")
    },
    [2] = "qTZR]\21z\11HT\n",
    [3] = {
        ["Received"] = 7,
        ["Sent"] = 10
    },
    [4] = "3fb73910-d2e7-4489-963f-c57392963371"
}

-- Criar UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoSocoUI"
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 100)
frame.Position = UDim2.new(0.8, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
frame.Visible = false
frame.Parent = screenGui

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 100, 0, 30)
toggleButton.Position = UDim2.new(0.6, 0, 0.7, 0)
toggleButton.Text = "Abrir Painel"
toggleButton.Parent = screenGui
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)

local autoSocoButton = Instance.new("TextButton")
autoSocoButton.Size = UDim2.new(0, 150, 0, 40)
autoSocoButton.Position = UDim2.new(0.1, 0, 0.2, 0)
autoSocoButton.Text = "Auto Soco: Desligado"
autoSocoButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
autoSocoButton.TextColor3 = Color3.fromRGB(0, 0, 0)
autoSocoButton.Parent = frame

local autoSocoAtivo = false

-- Função que verifica se está em cima do saco (distância <= 5)
local function estaNoSaco()
    local saco = workspace:FindFirstChild("PunchingBag") or workspace:FindFirstChild("SacoDePancada") -- ajustar se necessário
    if saco and humanoidRootPart then
        local distancia = (humanoidRootPart.Position - saco.Position).Magnitude
        return distancia <= 5
    end
    return false
end

-- Toggle painel
toggleButton.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
    toggleButton.Text = frame.Visible and "Fechar Painel" or "Abrir Painel"
end)

-- Toggle auto soco
autoSocoButton.MouseButton1Click:Connect(function()
    autoSocoAtivo = not autoSocoAtivo
    autoSocoButton.Text = autoSocoAtivo and "Auto Soco: Ligado" or "Auto Soco: Desligado"
end)

-- Loop principal do auto soco
spawn(function()
    while true do
        task.wait(0.1)
        if autoSocoAtivo and estaNoSaco() and remote then
            pcall(function()
                remote:FireServer(unpack(args))
            end)
        end
    end
end)
