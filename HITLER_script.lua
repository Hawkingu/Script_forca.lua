-- HAWKEXECUT+ Painel e funções
local uis = game:GetService("UserInputService")
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- Criar GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "HAWKEXECUT"
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 350)
frame.Position = UDim2.new(0.1, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Active = true
frame.Draggable = true
frame.Visible = true

-- Botão Mostrar/Esconder Painel
local toggleBtn = Instance.new("TextButton", gui)
toggleBtn.Text = "HAWKEXECUT+"
toggleBtn.Size = UDim2.new(0, 120, 0, 30)
toggleBtn.Position = UDim2.new(0, 0, 0.05, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
local open = true
toggleBtn.MouseButton1Click:Connect(function()
	open = not open
	frame.Visible = open
end)

-- Criar botão
local function criarBotao(texto, y, callback)
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(0, 280, 0, 30)
	btn.Position = UDim2.new(0, 10, 0, y)
	btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Text = texto
	btn.MouseButton1Click:Connect(callback)
end

-- Auto Kill (toque)
criarBotao("Auto Kill (toque)", 10, function()
	for _, v in pairs(game.Players:GetPlayers()) do
		if v ~= plr and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
			v.Character.HumanoidRootPart.CFrame = hrp.CFrame
		end
	end
end)

-- Auto Dumbbell (automático sem clicar)
spawn(function()
	while task.wait(0.6) do
		local args = {[1] = 9}
		pcall(function()
			if plr.Character and plr.Character:FindFirstChild("Dumbell") then
				plr.Character.Dumbell.Event:FireServer(unpack(args))
			end
		end)
	end
end)

-- Farm Kill (não jogar inimigo longe)
criarBotao("Farm Kill", 50, function()
	while task.wait(0.5) do
		for _, v in pairs(game.Players:GetPlayers()) do
			if v ~= plr and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
				v.Character.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(1, 0, 0)
			end
		end
	end
end)

-- Voo controlado no chão (RÁPIDO)
local flySpeed = 100
local flying = false
criarBotao("Ativar Voo no Chão", 90, function()
	if flying then return end
	flying = true
	local bv = Instance.new("BodyVelocity", hrp)
	bv.MaxForce = Vector3.new(1e5, 0, 1e5)
	while flying do
		bv.Velocity = plr.Character.Humanoid.MoveDirection * flySpeed
		task.wait()
	end
	bv:Destroy()
end)

criarBotao("Parar Voo", 130, function()
	flying = false
end)

-- Noclip (atravessar todas paredes)
local noclip = false
criarBotao("Ativar Noclip", 170, function()
	noclip = true
	game:GetService("RunService").Stepped:Connect(function()
		if noclip and char then
			for _, v in pairs(char:GetDescendants()) do
				if v:IsA("BasePart") then
					v.CanCollide = false
				end
			end
		end
	end)
end)

-- Invencibilidade (nunca morrer, nunca ser atingido)
criarBotao("Invencível", 210, function()
	plr.CharacterAdded:Connect(function(char)
		repeat task.wait() until char:FindFirstChild("Humanoid")
		char.Humanoid.Name = "1"
		local newHum = char:FindFirstChild("1"):Clone()
		newHum.Name = "Humanoid"
		newHum.Parent = char
		wait(0.1)
		char:FindFirstChild("1"):Destroy()
	end)
end)

-- Teleporte custom
local nomeJogador = Instance.new("TextBox", frame)
nomeJogador.Position = UDim2.new(0, 10, 0, 250)
nomeJogador.Size = UDim2.new(0, 200, 0, 30)
nomeJogador.PlaceholderText = "Nome do jogador"
nomeJogador.TextColor3 = Color3.new(1,1,1)
nomeJogador.BackgroundColor3 = Color3.fromRGB(30,30,30)

criarBotao("→ /TP", 290, function()
	local alvo = game.Players:FindFirstChild(nomeJogador.Text)
	if alvo and alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart") then
		hrp.CFrame = alvo.Character.HumanoidRootPart.CFrame
	end
end)

criarBotao("← /TP OFF", 330, function()
	-- Nenhuma ação, só simboliza desligar
end)
