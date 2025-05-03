-- Painel "10/10" com função bater automaticamente no saco de pancada

local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- Criar GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "AutoAttackPanel"

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

-- Função para detectar e bater no saco
local ativo = false
local intervalo = 1
local nomeSaco = "Attack" -- Nome exato do saco no jogo (pelo print)

local function estaPerto(obj)
	return (obj.Position - hrp.Position).Magnitude < 5
end

-- Botão para ativar ataque automático
local botao = Instance.new("TextButton", frame)
botao.Size = UDim2.new(0, 200, 0, 40)
botao.Position = UDim2.new(0, 10, 0, 20)
botao.Text = "Bater no Attack"
botao.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
botao.TextColor3 = Color3.new(1,1,1)

botao.MouseButton1Click:Connect(function()
	if ativo then return end
	ativo = true

	task.spawn(function()
		while ativo do
			for _, obj in pairs(workspace:GetDescendants()) do
				if obj:IsA("BasePart") and obj.Name == nomeSaco and estaPerto(obj) then
					local hand = char:FindFirstChild("Hand")
					if hand and hand:IsA("RemoteEvent") then
						hand:FireServer()
					end
				end
			end
			task.wait(intervalo)
		end
	end)
end)
