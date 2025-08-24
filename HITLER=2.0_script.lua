-- HITLERZIN+ Painel e funções (HAWKEXECUT)
local uis = game:GetService("UserInputService")
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Remotes
local Lutero = ReplicatedStorage:WaitForChild("Lutero")
local AddStaminaEvent = ReplicatedStorage:WaitForChild("AddStaminaEvent")

-- Criar GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "HAWKEXECUT"
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 550)
frame.Position = UDim2.new(0.1, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.Active = true
frame.Draggable = true

-- Botão Mostrar/Esconder Painel
local toggleBtn = Instance.new("TextButton", gui)
toggleBtn.Text = "HAWKEXECUT+"
toggleBtn.Size = UDim2.new(0, 120, 0, 30)
toggleBtn.Position = UDim2.new(0, 0, 0.05, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
local open = true
toggleBtn.MouseButton1Click:Connect(function()
	open = not open
	frame.Visible = open
end)

-- Função criar botões toggle
local function criarBotaoToggle(texto, y, estado, callbackAtivar, callbackDesativar)
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(0, 280, 0, 30)
	btn.Position = UDim2.new(0, 10, 0, y)
	btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	btn.TextColor3 = Color3.new(1,1,1)

	local ativo = false
	local function atualizarTexto()
		btn.Text = texto .. " " .. (ativo and "[✅]" or "[❎]")
	end
	atualizarTexto()

	btn.MouseButton1Click:Connect(function()
		ativo = not ativo
		atualizarTexto()
		if ativo then
			if callbackAtivar then callbackAtivar() end
		else
			if callbackDesativar then callbackDesativar() end
		end
	end)

	return function() return ativo end
end

-- =============================
-- BOTÕES
-- =============================

-- Auto Kill (toque)
criarBotaoToggle("Auto Kill (toque)", 10, false,
	function()
		spawn(function()
			while true do
				task.wait(0.5)
				for _, v in pairs(game.Players:GetPlayers()) do
					if v ~= plr and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
						v.Character.HumanoidRootPart.CFrame = hrp.CFrame
					end
				end
			end
		end)
	end,
	function() end
)

-- Auto Força (Auto Dumbbell sem precisar segurar)
local autoForca = false
criarBotaoToggle("Auto Força", 50, false,
	function()
		autoForca = true
		spawn(function()
			while autoForca do
				pcall(function()
					if plr.Character then
						local dumbell = plr.Character:FindFirstChild("Dumbell")
						if dumbell and dumbell:FindFirstChild("Event") then
							dumbell.Event:FireServer(9)
						else
							local tempDumb = Instance.new("Part")
							tempDumb.Name = "Dumbell"
							local event = Instance.new("RemoteEvent")
							event.Name = "Event"
							event.Parent = tempDumb
							tempDumb.Parent = plr.Character
							pcall(function() event:FireServer(9) end)
							tempDumb:Destroy()
						end
					end
				end)
				task.wait(0.3)
			end
		end)
	end,
	function() autoForca = false end
)

-- Farm Kill
local farmando = false
criarBotaoToggle("Farm Kill", 90, false,
	function()
		farmando = true
		spawn(function()
			while farmando do
				task.wait(0.5)
				for _, v in pairs(game.Players:GetPlayers()) do
					if v ~= plr and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
						v.Character.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(1, 0, 0)
					end
				end
			end
		end)
	end,
	function() farmando = false end
)

-- Vida Infinita (máxima tentativa de velocidade 60ms)
local vidaAtiva = false
criarBotaoToggle("Vida Infinita", 130, false,
	function()
		vidaAtiva = true
		spawn(function()
			while vidaAtiva do
				local args = {
					[1] = "GiveHealthCuzPro",
					[2] = 1,
					[3] = 1
				}
				pcall(function()
					Lutero:FireServer(unpack(args))
				end)
				task.wait(0.06) -- 60ms
			end
		end)
	end,
	function() vidaAtiva = false end
)

-- Auto Stamina (60ms)
local staminaAtiva = false
criarBotaoToggle("Auto Stamina", 170, false,
	function()
		staminaAtiva = true
		spawn(function()
			while staminaAtiva do
				pcall(function()
					AddStaminaEvent:FireServer()
				end)
				task.wait(0.06) -- 60ms
			end
		end)
	end,
	function() staminaAtiva = false end
)

-- Fly controlado no chão
local flySpeed = 80
local flying = false
criarBotaoToggle("Voo no Chão", 210, false,
	function()
		if flying then return end
		flying = true
		local bv = Instance.new("BodyVelocity", hrp)
		bv.MaxForce = Vector3.new(1e5, 0, 1e5)
		spawn(function()
			while flying do
				bv.Velocity = plr.Character.Humanoid.MoveDirection * flySpeed
				task.wait()
			end
			bv:Destroy()
		end)
	end,
	function() flying = false end
)

-- Noclip
local noclip = false
criarBotaoToggle("Noclip", 250, false,
	function()
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
	end,
	function() noclip = false end
)

-- Teleporte custom
local nomeJogador = Instance.new("TextBox", frame)
nomeJogador.Position = UDim2.new(0, 10, 0, 290)
nomeJogador.Size = UDim2.new(0, 200, 0, 30)
nomeJogador.PlaceholderText = "Nome do jogador"
nomeJogador.TextColor3 = Color3.new(1,1,1)
nomeJogador.BackgroundColor3 = Color3.fromRGB(30,30,30)

local function criarBotao(texto, y, callback)
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(0, 280, 0, 30)
	btn.Position = UDim2.new(0, 10, 0, y)
	btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Text = texto
	btn.MouseButton1Click:Connect(callback)
end

criarBotao("→ /TP", 330, function()
	local alvo = game.Players:FindFirstChild(nomeJogador.Text)
	if alvo and alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart") then
		hrp.CFrame = alvo.Character.HumanoidRootPart.CFrame
	end
end)

criarBotao("← /TP OFF", 370, function()
	-- desligar tp manualmente
end)
