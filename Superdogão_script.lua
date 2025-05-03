-- GUI principal
local ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "HelloGui"
ScreenGui.ResetOnSpawn = false

-- Botão da logo
local logo = Instance.new("TextButton")
logo.Parent = ScreenGui
logo.Size = UDim2.new(0, 120, 0, 40)
logo.Position = UDim2.new(0, 10, 0, 10)
logo.Text = "😄HellO"
logo.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
logo.TextColor3 = Color3.new(1, 1, 1)
logo.Font = Enum.Font.SourceSansBold
logo.TextSize = 20

-- Tema (Frame)
local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 200, 0, 60)
Frame.Position = UDim2.new(0, 10, 0, 60)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.BorderSizePixel = 2
Frame.Visible = false

-- Botão de ataque
local Btn = Instance.new("TextButton")
Btn.Parent = Frame
Btn.Size = UDim2.new(1, -10, 1, -10)
Btn.Position = UDim2.new(0, 5, 0, 5)
Btn.Text = "Atacar o Attack com Hand"
Btn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
Btn.TextColor3 = Color3.new(1, 1, 1)
Btn.Font = Enum.Font.SourceSansBold
Btn.TextSize = 16

-- Lógica do ataque
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
