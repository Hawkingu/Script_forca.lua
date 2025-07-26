-- Função para pegar nil instances usadas no evento
function getNil(name,class) 
    for _,v in pairs(getnilinstances()) do 
        if v.ClassName == class and v.Name == name then 
            return v
        end 
    end 
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
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

-- UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HAWKEXECUTplus"
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Painel vermelho
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 230, 0, 110)
frame.Position = UDim2.new(0.78, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- vermelho
frame.Visible = false
frame.Parent = screenGui

-- Botão abrir/fechar painel
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 110, 0, 35)
toggleBtn.Position = UDim2.new(0.6, 0, 0.75, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- branco
toggleBtn.TextColor3 = Color3.fromRGB(0, 0, 0) -- preto
toggleBtn.Text = "Abrir Painel"
toggleBtn.Parent = screenGui

-- Botão ligar/desligar auto soco
local autoSocoBtn = Instance.new("TextButton")
autoSocoBtn.Size = UDim2.new(0, 180, 0, 50)
autoSocoBtn.Position = UDim2.new(0.1, 0, 0.25, 0)
autoSocoBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- branco
autoSocoBtn.TextColor3 = Color3.fromRGB(0, 0, 0) -- preto
autoSocoBtn.Text = "Auto Soco: Desligado"
autoSocoBtn.Parent = frame

local autoSocoAtivo = false

-- Função para detectar se está em cima do saco
local sacosPancada = {}

local punchingBagsFolder = workspace:FindFirstChild("PunchingBags")
if punchingBagsFolder then
    for _, v in pairs(punchingBagsFolder:GetChildren()) do
        if v:IsA("BasePart") then
            table.insert(sacosPancada, v)
        end
    end
else
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("BasePart") and (v.Name:lower():find("saco") or v.Name:lower():find("pancada") or v.Name:lower():find("bag")) then
            table.insert(sacosPancada, v)
        end
    end
end

local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local function estaEmCimaDoSaco()
    if not humanoidRootPart then return false end
    for _, saco in pairs(sacosPancada) do
        local dist = (humanoidRootPart.Position - saco.Position).Magnitude
        if dist <= 5 then
            local diffY = humanoidRootPart.Position.Y - saco.Position.Y
            if diffY > 1 and diffY < 5 then
                return true
            end
        end
    end
    return false
end

toggleBtn.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
    toggleBtn.Text = frame.Visible and "Fechar Painel" or "Abrir Painel"
end)

autoSocoBtn.MouseButton1Click:Connect(function()
    autoSocoAtivo = not autoSocoAtivo
    autoSocoBtn.Text = autoSocoAtivo and "Auto Soco: Ligado" or "Auto Soco: Desligado"
end)

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
