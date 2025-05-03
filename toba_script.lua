local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "HelloGui"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.ResetOnSpawn = false

-- Botão de logo
local logo = Instance.new("TextButton")
logo.Parent = gui
logo.Size = UDim2.new(0, 120, 0, 40)
logo.Position = UDim2.new(0, 10, 0, 10)
logo.Text = "😄HellO"
logo.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
logo.TextColor3 = Color3.new(1, 1, 1)
logo.Font = Enum.Font.SourceSansBold
logo.TextSize = 20

-- Menu oculto
local Frame = Instance.new("Frame")
Frame.Parent = gui
Frame.Size = UDim2.new(0, 220, 0, 60)
Frame.Position = UDim2.new(0, 10, 0, 60)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 2
Frame.Visible = false

-- Botão funcional
local Btn = Instance.new("TextButton")
Btn.Parent = Frame
Btn.Size = UDim2.new(1, -10, 1, -10)
Btn.Position = UDim2.new(0, 5, 0, 5)
Btn.Text = "Atacar o Attack com Hand"
Btn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
Btn.TextColor3 = Color3.new(1, 1, 1)
Btn.Font = Enum.Font.SourceSansBold
Btn.TextSize = 16

-- Função de ataque
local atacando = false
local rs = game:GetService("ReplicatedStorage")
local Attack = rs:WaitForChild("Remotes"):WaitForChild("Attack")
local HandKick = rs:WaitForChild("Remotes"):WaitForChild("HandKick")

Btn.MouseButton1Click:Connect(function()
	atacando = not atacando
	Btn.Text = atacando and "Parar ataque" or "Atacar o Attack com Hand"
	
	while atacando do
		HandKick:FireServer()
		Attack:FireServer()
		wait(1)
	end
end)

logo.MouseButton1Click:Connect(function()
	Frame.Visible = not Frame.Visible
end)
