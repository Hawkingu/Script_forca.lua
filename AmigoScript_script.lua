-- GUI principal
local ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
local logo = Instance.new("TextButton", ScreenGui)
logo.Size = UDim2.new(0, 120, 0, 40)
logo.Position = UDim2.new(0, 10, 0, 10)
logo.Text = "😄HellO"
logo.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
logo.TextColor3 = Color3.new(1, 1, 1)
logo.Font = Enum.Font.SourceSansBold
logo.TextSize = 20
logo.AutoButtonColor = true

-- Tema (frame com botão)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 160, 0, 80)
Frame.Position = UDim2.new(0, 10, 0, 60)
Frame.Visible = false
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 2

local Btn = Instance.new("TextButton", Frame)
Btn.Size = UDim2.new(1, -10, 0, 40)
Btn.Position = UDim2.new(0, 5, 0, 5)
Btn.Text = "Bater no Attack"
Btn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
Btn.TextColor3 = Color3.new(1, 1, 1)
Btn.Font = Enum.Font.SourceSansBold
Btn.TextSize = 16

-- Lógica de ataque
local atacando = false
local rs = game:GetService("ReplicatedStorage")
local Attack = rs:WaitForChild("Remotes"):WaitForChild("Attack")
local HandKick = rs:WaitForChild("Remotes"):WaitForChild("HandKick")

Btn.MouseButton1Click:Connect(function()
    atacando = not atacando
    Btn.Text = atacando and "Parar" or "Bater no Attack"
    
    while atacando do
        -- Executa HandKick e Attack
        HandKick:FireServer()
        Attack:FireServer()
        wait(1)
    end
end)

logo.MouseButton1Click:Connect(function()
    Frame.Visible = not Frame.Visible
end)
