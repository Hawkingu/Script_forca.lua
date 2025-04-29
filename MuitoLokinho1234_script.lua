-- Painel Cobra Kai (Mobile-Friendly) com Auto Força, Auto Vida e Voo Direcional

local Players = game:GetService("Players") local LocalPlayer = Players.LocalPlayer local UIS = game:GetService("UserInputService") local RunService = game:GetService("RunService")

-- Estados local isFlying = false local autoForca = false local autoVida = false

-- Criar GUI local gui = Instance.new("ScreenGui") gui.Name = "PainelCobraKai" gui.ResetOnSpawn = false gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Logo local logo = Instance.new("TextButton") logo.Size = UDim2.new(0, 50, 0, 50) logo.Position = UDim2.new(0, 10, 0, 10) logo.Text = "🕴" logo.TextScaled = true logo.BackgroundColor3 = Color3.new(0, 0, 0) logo.TextColor3 = Color3.new(1, 1, 1) logo.Parent = gui

-- Painel local frame = Instance.new("Frame") frame.Size = UDim2.new(0, 260, 0, 320) frame.Position = UDim2.new(0, 70, 0, 60) frame.BackgroundColor3 = Color3.new(0, 0, 0) frame.Visible = false frame.Parent = gui

local UICorner = Instance.new("UICorner", frame) UICorner.CornerRadius = UDim.new(0, 10)

-- Drag local dragging, dragInput, dragStart, startPos local function update(input) local delta = input.Position - dragStart frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end

frame.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true dragStart = input.Position startPos = frame.Position

input.Changed:Connect(function()
		if input.UserInputState == Enum.UserInputState.End then
			dragging = false
		end
	end)
end

end)

frame.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end end)

UIS.InputChanged:Connect(function(input) if input == dragInput and dragging then update(input) end end)

-- Abrir painel logo.MouseButton1Click:Connect(function() frame.Visible = not frame.Visible end)

-- Seções local farmBtn = Instance.new("TextLabel") farmBtn.Text = "Farm" farmBtn.Size = UDim2.new(1, -20, 0, 25) farmBtn.Position = UDim2.new(0, 10, 0, 10) farmBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30) farmBtn.TextColor3 = Color3.new(1,1,1) farmBtn.Parent = frame

-- Auto Força Toggle local forcaBtn = Instance.new("TextButton") forcaBtn.Text = "○ Auto Força" forcaBtn.Size = UDim2.new(1, -20, 0, 30) forcaBtn.Position = UDim2.new(0, 10, 0, 45) forcaBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60) forcaBtn.TextColor3 = Color3.new(1,1,1) forcaBtn.Parent = frame

forcaBtn.MouseButton1Click:Connect(function() autoForca = not autoForca forcaBtn.Text = autoForca and "● Auto Força" or "○ Auto Força"

spawn(function()
	while autoForca do
		local args = {[1] = 9}
		for i = 1, 5 do
			pcall(function()
				game:GetService("Players").LocalPlayer.Character.Dumbell.Event:FireServer(unpack(args))
			end)
			wait(0.6)
		end
		wait(1)
	end
end)

end)

-- Auto Vida Toggle local vidaBtn = Instance.new("TextButton") vidaBtn.Text = "○ Auto Vida" vidaBtn.Size = UDim2.new(1, -20, 0, 30) vidaBtn.Position = UDim2.new(0, 10, 0, 80) vidaBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60) vidaBtn.TextColor3 = Color3.new(1,1,1) vidaBtn.Parent = frame

vidaBtn.MouseButton1Click:Connect(function() autoVida = not autoVida vidaBtn.Text = autoVida and "● Auto Vida" or "○ Auto Vida"

spawn(function()
	while autoVida do
		pcall(function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/hawk/teuscript/main/script.lua"))()
		end)
		wait(2)
	end
end)

end)

-- Seção Brincadeira local brincBtn = Instance.new("TextLabel") brincBtn.Text = "Brincadeira" brincBtn.Size = UDim2.new(1, -20, 0, 25) brincBtn.Position = UDim2.new(0, 10, 0, 125) brincBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30) brincBtn.TextColor3 = Color3.new(1,1,1) brincBtn.Parent = frame

-- Botão Voo Horizontal local vooBtn = Instance.new("TextButton") vooBtn.Text = "□ Voar no chão" vooBtn.Size = UDim2.new(1, -20, 0, 30) vooBtn.Position = UDim2.new(0, 10, 0, 160) vooBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60) vooBtn.TextColor3 = Color3.new(1,1,1) vooBtn.Parent = frame

vooBtn.MouseButton1Click:Connect(function() isFlying = not isFlying vooBtn.Text = isFlying and "■ Voando..." or "□ Voar no chão"

if isFlying then
	local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	local hrp = char:WaitForChild("HumanoidRootPart")
	local bodyVel = Instance.new("BodyVelocity")
	bodyVel.Velocity = Vector3.zero
	bodyVel.MaxForce = Vector3.new(9e9, 9e9, 9e9)
	bodyVel.Parent = hrp

	RunService:BindToRenderStep("Flying", Enum.RenderPriority.Character.Value + 1, function()
		local camCF = workspace.CurrentCamera.CFrame
		local moveVector = Vector3.new(camCF.LookVector.X, 0, camCF.LookVector.Z).Unit
		bodyVel.Velocity = moveVector * 50
	end)
else
	RunService:UnbindFromRenderStep("Flying")
	if LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") then
		LocalPlayer.Character.HumanoidRootPart.BodyVelocity:Destroy()
	end
end

end)

