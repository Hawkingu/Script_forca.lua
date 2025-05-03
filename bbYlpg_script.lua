local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()

-- Criar GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "AutoBenchPanel"

-- Botão logo
local logo = Instance.new("TextButton", gui)
logo.Text = "10/10"
logo.Size = UDim2.new(0, 100, 0, 30)
logo.Position = UDim2.new(0, 10, 0, 50)
logo.BackgroundColor3 = Color3.fromRGB(50, 50, 200)
logo.TextColor3 = Color3.new(1, 1, 1)

-- Painel
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 220, 0, 100)
frame.Position = UDim2.new(0, 10, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Visible = false
frame.Active = true
frame.Draggable = true

logo.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

-- Botão para simular bench
local botao = Instance.new("TextButton", frame)
botao.Size = UDim2.new(0, 200, 0, 40)
botao.Position = UDim2.new(0, 10, 0, 20)
botao.Text = "Usar Bench"
botao.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
botao.TextColor3 = Color3.new(0, 0, 0)

-- Nome do RemoteEvent (precisa trocar se não funcionar)
local remotePath = game.ReplicatedStorage:FindFirstChild("BenchHeal") -- nome fictício

botao.MouseButton1Click:Connect(function()
	if remotePath and remotePath:IsA("RemoteEvent") then
		while true do
			task.wait(1)
			remotePath:FireServer()
		end
	else
		warn("RemoteEvent 'BenchHeal' não encontrado. Use Remote Spy para descobrir o nome certo.")
	end
end)
