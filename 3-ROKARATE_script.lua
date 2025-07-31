-- HAWKEXECUT+ Painel com Botão de Abertura

local plr = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local playerGui = plr:WaitForChild("PlayerGui")

-- GUI Principal
local ScreenGui = Instance.new("ScreenGui", playerGui)
ScreenGui.Name = "HAWKEXECUT"
ScreenGui.ResetOnSpawn = false

-- Botão de Ativar/Desativar Painel
local toggleButton = Instance.new("TextButton", ScreenGui)
toggleButton.Size = UDim2.new(0, 120, 0, 40)
toggleButton.Position = UDim2.new(0, 20, 0, 20)
toggleButton.Text = "[HAWKEXECUT]"
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
toggleButton.TextColor3 = Color3.fromRGB(220, 220, 220)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 18
toggleButton.BorderSizePixel = 2

-- Painel Principal (inicialmente invisível)
local main = Instance.new("Frame", ScreenGui)
main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
main.Size = UDim2.new(0, 200, 0, 200)
main.Position = UDim2.new(0, 20, 0, 70)
main.Active = true
main.Draggable = true
main.Visible = false

local UIStroke = Instance.new("UIStroke", main)
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(255, 255, 255)

-- Função botão do painel
function criarBotao(nome, ordem, callback)
	local btn = Instance.new("TextButton", main)
	btn.Size = UDim2.new(1, 0, 0, 30)
	btn.Position = UDim2.new(0, 0, 0, (ordem - 1) * 35)
	btn.Text = nome
	btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextColor3 = Color3.fromRGB(220, 220, 220)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 16
	btn.MouseButton1Click:Connect(callback)
end

-- Alternar visibilidade do painel
toggleButton.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)

-- Auto Força
local autoPush = false
criarBotao("Auto Força", 1, function()
	autoPush = not autoPush
	task.spawn(function()
		while autoPush do
			rs:WaitForChild("Pushup"):FireServer()
			task.wait(0.01)
		end
	end)
end)

-- Auto Vida
local autoSitup = false
criarBotao("Auto Vida", 2, function()
	autoSitup = not autoSitup
	task.spawn(function()
		while autoSitup do
			rs:WaitForChild("Situp"):FireServer()
			task.wait(0.01)
		end
	end)
end)

-- Voo no chão
local flying = false
local RunService = game:GetService("RunService")

criarBotao("Voar no Chão", 3, function()
	flying = not flying
	local hrp = plr.Character:WaitForChild("HumanoidRootPart")
	if flying then
		local bp = Instance.new("BodyPosition")
		local bv = Instance.new("BodyVelocity")
		bp.MaxForce = Vector3.new(1e5, 0, 1e5)
		bv.MaxForce = Vector3.new(1e5, 0, 1e5)
		bp.Position = hrp.Position
		bv.Velocity = Vector3.zero
		bp.Name = "Fly_BP"
		bv.Name = "Fly_BV"
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
	else
		RunService:UnbindFromRenderStep("chaoFly")
		local bp = hrp:FindFirstChild("Fly_BP")
		local bv = hrp:FindFirstChild("Fly_BV")
		if bp then bp:Destroy() end
		if bv then bv:Destroy() end
	end
end)
