-- HAWKEXECUT+ Painel v2 (por @Hawkingu) - VISUAL ESCURO

-- Variáveis
local plr = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")

-- GUI
local ScreenGui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
ScreenGui.Name = "HAWKEXECUT+"
ScreenGui.ResetOnSpawn = false

local main = Instance.new("Frame", ScreenGui)
main.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- preto
main.Size = UDim2.new(0, 200, 0, 200)
main.Position = UDim2.new(0, 100, 0, 100)
main.Active = true
main.Draggable = true

local UIStroke = Instance.new("UIStroke", main)
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(255, 255, 255)

-- Função botão genérico
function criarBotao(nome, ordem, callback)
	local btn = Instance.new("TextButton", main)
	btn.Size = UDim2.new(1, 0, 0, 30)
	btn.Position = UDim2.new(0, 0, 0, (ordem - 1) * 35)
	btn.Text = nome
	btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- botão branco
	btn.TextColor3 = Color3.fromRGB(220, 220, 220) -- letras cinza claro
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 16
	btn.MouseButton1Click:Connect(callback)
end

-- Auto Pushup (Força)
local autoPush = false
criarBotao("Auto Força", 1, function()
	autoPush = not autoPush
	while autoPush do
		rs.Pushup:FireServer()
		wait(0.05)
	end
end)

-- Auto Situp (Vida)
local autoSitup = false
criarBotao("Auto Vida", 2, function()
	autoSitup = not autoSitup
	while autoSitup do
		rs.Situp:FireServer()
		wait(0.05)
	end
end)

-- Voo no chão
local flying = false
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

criarBotao("Voar no Chão", 3, function()
	flying = not flying
	local hrp = plr.Character:WaitForChild("HumanoidRootPart")
	local bp = Instance.new("BodyPosition")
	local bv = Instance.new("BodyVelocity")
	bp.MaxForce = Vector3.new(1e5, 0, 1e5)
	bv.MaxForce = Vector3.new(1e5, 0, 1e5)
	bp.Position = hrp.Position
	bv.Velocity = Vector3.zero
	bp.Parent = hrp
	bv.Parent = hrp

	local speed = 50
	RunService:BindToRenderStep("chaoFly", Enum.RenderPriority.Input.Value, function()
		if flying then
			local moveDir = plr:GetMouse().Hit.LookVector
			bp.Position = hrp.Position + Vector3.new(moveDir.X, 0, moveDir.Z) * 2
			bv.Velocity = Vector3.new(moveDir.X, 0, moveDir.Z) * speed
		end
	end)

	if not flying then
		RunService:UnbindFromRenderStep("chaoFly")
		bp:Destroy()
		bv:Destroy()
	end
end)

-- Esconder/Mostrar painel
criarBotao("Abrir/Fechar Painel", 4, function()
	main.Visible = not main.Visible
end)
