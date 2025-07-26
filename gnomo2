-- Função para pegar objetos nil escondidos
function getNil(name, class)
    for _, v in pairs(getnilinstances()) do
        if v.Name == name and v.ClassName == class then
            return v
        end
    end
end

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "HAWKEXECUTPlus"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 300)
frame.Position = UDim2.new(0.1, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.Text = "HAWKEXECUT+"
title.TextSize = 26
title.TextColor3 = Color3.fromRGB(0, 0, 0)

local function criarBotao(texto, posY, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0.8, 0, 0, 40)
    btn.Position = UDim2.new(0.1, 0, posY, 0)
    btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 20
    btn.Text = texto
    btn.MouseButton1Click:Connect(callback)
end

-- Botão que usa o RemoteEvent para ganhar pontos de vida, força e stamina conforme o jogo manda
criarBotao("Ganhar Vida, Força, Stamina", 0.2, function()
    local re = game:GetService("ReplicatedStorage"):FindFirstChild("3b4a39d2-1f07-4686-bdef-5237cc94e17b")
    if re and re:IsA("RemoteEvent") then
        local args = {
            [1] = {
                ["Received"] = 28,
                ["Loader"] = getNil("", "Folder") and getNil("", "Folder").ClientMover or nil,
                ["Mode"] = "Fire",
                ["Sent"] = 99,
                ["Module"] = getNil("Client", "ModuleScript")
            },
            [2] = "'XX\4VFz\12HZ^",
            [3] = {
                ["Received"] = 28,
                ["Sent"] = 98
            },
            [4] = "ec78879b-f6b8-4006-b8a8-ee8aaa705995"
        }
        re:FireServer(unpack(args))
        print("Comando enviado para ganhar pontos!")
    else
        warn("RemoteEvent não encontrado.")
    end
end)

-- Botão para fechar o painel
criarBotao("Fechar Painel", 0.65, function()
    gui:Destroy()
end)
