-- Painel com botão de resgatar código 150k
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Criar ScreenGui
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "PainelCodigo"
gui.ResetOnSpawn = false

-- Criar painel principal
local frame = Instance.new("Frame", gui)
frame.Name = "Painel"
frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
frame.Size = UDim2.new(0, 200, 0, 120)
frame.Position = UDim2.new(0, 20, 0, 40)
frame.Active = true
frame.Draggable = true -- painel móvel

-- Botão de aumentar
local mais = Instance.new("TextButton", frame)
mais.Size = UDim2.new(0, 25, 0, 25)
mais.Position = UDim2.new(1, -55, 0, 5)
mais.Text = "+"
mais.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
mais.TextColor3 = Color3.fromRGB(0, 0, 0)

-- Botão de diminuir
local menos = Instance.new("TextButton", frame)
menos.Size = UDim2.new(0, 25, 0, 25)
menos.Position = UDim2.new(1, -25, 0, 5)
menos.Text = "-"
menos.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
menos.TextColor3 = Color3.fromRGB(0, 0, 0)

-- Botão do código
local codigoBtn = Instance.new("TextButton", frame)
codigoBtn.Size = UDim2.new(1, -20, 0, 40)
codigoBtn.Position = UDim2.new(0, 10, 0, 50)
codigoBtn.Text = "[150k]"
codigoBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
codigoBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
codigoBtn.Font = Enum.Font.Gotham
codigoBtn.TextSize = 18

-- Função de mandar código no chat
local function enviarCodigo()
    local code = "/redeem 150k"
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(code, "All")
end

-- Quando clicar no botão
codigoBtn.MouseButton1Click:Connect(function()
    enviarCodigo()
end)

-- Aumentar painel
mais.MouseButton1Click:Connect(function()
    frame.Size = frame.Size + UDim2.new(0, 20, 0, 20)
end)

-- Diminuir painel
menos.MouseButton1Click:Connect(function()
    frame.Size = frame.Size - UDim2.new(0, 20, 0, 20)
end)
