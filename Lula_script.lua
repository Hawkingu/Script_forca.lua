-- Função auxiliar para pegar objetos nil usados no evento
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

-- UI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoSocoUI"
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 240, 0, 120)
frame.Position = UDim2.new(0.8, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
frame.Visible = false
frame.Parent = screenGui

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 110, 0, 35)
toggleButton.Position = UDim2.new(0.6, 0, 0.75, 0)
toggleButton.Text = "Abrir Painel"
toggleButton.Parent = screenGui
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)

local autoSocoButton = Instance.new("TextButton")
autoSocoButton.Size = UDim2.new(0, 180, 0, 50)
autoSocoButton.Position = UDim2.new(0.1, 0, 0.3, 0)
autoSocoButton.Text = "Auto Soco: Desligado"
autoSocoButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
autoSocoButton.TextColor3 = Color3.fromRGB(0, 0, 0)
autoSocoButton.Parent = frame

local autoSocoAtivo = false

-- Coleção dos sacos de pancada (ajuste o caminho conforme o seu jogo)
local sacosPancada = {}

-- Se os sacos estiverem dentro de um folder no workspace chamado "PunchingBags"
local punchingBagsFolder = workspace:FindFirstChild("PunchingBags")
if punchingBagsFolder then
    for _, v in pairs(punchingBagsFolder:GetChildren()) do
        if v:IsA("BasePart") then
            table.insert(sacosPancada, v)
        end
    end
else
    -- Se não tiver pasta, tenta achar manualmente sacos pelo nome
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("BasePart") and (v.Name:lower():find("saco") or v.Name:lower():find("pancada") or v.Name:lower():find("bag")) then
            table.insert(sacosPancada, v)
        end
    end
end

-- Função para verificar se o player está em cima de algum saco
local function estaEmCimaDoSaco()
    if not humanoidRootPart then return false end
    for _, saco in pairs(sacosPancada) do
        if (humanoidRootPart.Position - saco.Position).Magnitude <= 5 then -- ajuste o alcance se quiser
            -- Verifica se está "em cima" no eixo Y (altura)
            local diffY = humanoidRootPart.Position.Y - saco.Position.Y
            if diffY > 1 and diffY < 5 then
                return true
            end
        end
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
        if autoSocoAtivo and estaEmCimaDoSaco() and remote then
            pcall(function()
                remote:FireServer(unpack(args))
            end)
        end
    end
end)
