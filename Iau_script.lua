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

-- Botão ativar
local botao = Instance.new("TextButton", frame)
botao.Size = UDim2.new(0, 200, 0, 40)
botao.Position = UDim2.new(0, 10, 0, 20)
botao.Text = "Bater no Attack"
botao.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
botao.TextColor3 = Color3.new(1, 1, 1)

-- Variáveis
local ativo = false
local nomeSaco = "Attack"

-- Detectar colisão real
botao.MouseButton1Click:Connect(function()
	if ativo then return end
	ativo = true

	task.spawn(function()
		while ativo do
			for _, obj in pairs(workspace:GetDescendants()) do
				if obj:IsA("BasePart") and obj.Name == nomeSaco then
					if hrp:IsDescendantOf(char) and hrp:IsTouching(obj) then
						-- Simula o chute apertando tecla K
						local vim = game:GetService("VirtualInputManager")
						vim:SendKeyEvent(true, Enum.KeyCode.K, false, game)
						task.wait(0.1)
						vim:SendKeyEvent(false, Enum.KeyCode.K, false, game)
					end
				end
			end
			task.wait(0.8) -- tempo entre chutes
		end
	end)
end)
