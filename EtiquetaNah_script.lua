-- Serviços e jogador local Players = game:GetService("Players") local ReplicatedStorage = game:GetService("ReplicatedStorage") local UIS = game:GetService("UserInputService") local RunService = game:GetService("RunService") local LocalPlayer = Players.LocalPlayer

-- Estados local isFlying = false local noClipEnabled = false local colorChangeEnabled = false local vidaFarm = false local forcaFarm = false

-- GUI local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui")) ScreenGui.Name = "PainelCobraKai" ScreenGui.ResetOnSpawn = false

local LogoButton = Instance.new("ImageButton", ScreenGui) LogoButton.Size = UDim2.new(0, 50, 0, 50) LogoButton.Position = UDim2.new(0, 10, 0, 10) LogoButton.Image = "rbxassetid://17073223843"

local MainFrame = Instance.new("Frame", ScreenGui) MainFrame.Size = UDim2.new(0, 300, 0, 400) MainFrame.Position = UDim2.new(0, 100, 0, 80) MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25) MainFrame.Visible = false

local UICorner = Instance.new("UICorner", MainFrame) UICorner.CornerRadius = UDim.new(0, 15)

-- Drag and Drop local dragging, dragInput, dragStart, startPos local function update(input) local delta = input.Position - dragStart MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end

MainFrame.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true dragStart = input.Position startPos = MainFrame.Position input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end) end end)

MainFrame.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)

UIS.InputChanged:Connect(function(input) if input == dragInput and dragging then update(input) end end)

-- Botões principais local FarmButton = Instance.new("TextButton", MainFrame) FarmButton.Size = UDim2.new(0, 270, 0, 35) FarmButton.Position = UDim2.new(0, 15, 0, 10) FarmButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0) FarmButton.Text = "🔴 Farm" FarmButton.TextColor3 = Color3.new(1, 1, 1)

local BrincadeiraButton = Instance.new("TextButton", MainFrame) BrincadeiraButton.Size = UDim2.new(0, 270, 0, 35) BrincadeiraButton.Position = UDim2.new(0, 15, 0, 55) BrincadeiraButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200) BrincadeiraButton.Text = "🔵 Brincadeira" BrincadeiraButton.TextColor3 = Color3.new(1, 1, 1)

-- Botões Farm local VidaButton = Instance.new("TextButton", MainFrame) VidaButton.Size = UDim2.new(0.45, -10, 0, 30) VidaButton.Position = UDim2.new(0, 15, 0, 100) VidaButton.Text = "[Vida +5]" VidaButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50) VidaButton.Visible = false

local ForcaButton = Instance.new("TextButton", MainFrame) ForcaButton.Size = UDim2.new(0.45, -10, 0, 30) ForcaButton.Position = UDim2.new(0.55, 5, 0, 100) ForcaButton.Text = "[Força +5]" ForcaButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50) ForcaButton.Visible = false

-- Botões Brincadeira local nomesBrincadeira = {"[Voar]", "[Atravessar Paredes]", "[Mudar Cor]", "[Chuva de Dumbell]", "[Esconder Vida]", "[Tubarão de Sapato]", "[Parar Tudo]"} local botoesBrincadeira = {} for i, nome in ipairs(nomesBrincadeira) do local btn = Instance.new("TextButton", MainFrame) btn.Size = UDim2.new(0.45, -10, 0, 30) if i%2==1 then btn.Position = UDim2.new(0, 15, 0, 140 + math.floor(i/2)*40) else btn.Position = UDim2.new(0.55, 5, 0, 140 + math.floor((i-1)/2)*40) end btn.Text = nome btn.BackgroundColor3 = Color3.fromRGB(80, 80, 200) btn.Visible = false table.insert(botoesBrincadeira, btn) end

-- Abrir/Fechar Painel LogoButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

FarmButton.MouseButton1Click:Connect(function() VidaButton.Visible = not VidaButton.Visible ForcaButton.Visible = VidaButton.Visible for _, btn in pairs(botoesBrincadeira) do btn.Visible = false end end)

BrincadeiraButton.MouseButton1Click:Connect(function() local ativo = not botoesBrincadeira[1].Visible VidaButton.Visible = false ForcaButton.Visible = false for _, btn in pairs(botoesBrincadeira) do btn.Visible = ativo end end)

-- Funções Farm VidaButton.MouseButton1Click:Connect(function() vidaFarm = not vidaFarm spawn(function() while vidaFarm do task.wait(0.3) pcall(function() ReplicatedStorage.Remotes.Branco:FireServer() end) end end) end)

ForcaButton.MouseButton1Click:Connect(function() forcaFarm = not forcaFarm spawn(function() while forcaFarm do task.wait(1) pcall(function() ReplicatedStorage.Remote:FireServer() end) end end) end)

-- Funções Brincadeira botoesBrincadeira[1].MouseButton1Click:Connect(function() isFlying = not isFlying if isFlying then local humanoid = LocalPlayer.Character:WaitForChild("Humanoid") local root = LocalPlayer.Character:WaitForChild("HumanoidRootPart") local bv = Instance.new("BodyVelocity", root) bv.MaxForce = Vector3.new(1e9,1e9,1e9) bv.Name = "FlyForce"

RunService.Heartbeat:Connect(function()
        if isFlying then
            bv.Velocity = (LocalPlayer.Character.Humanoid.MoveDirection) * 70
        end
    end)
else
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root and root:FindFirstChild("FlyForce") then
        root.FlyForce:Destroy()
    end
end

end)

botoesBrincadeira[2].MouseButton1Click:Connect(function() noClipEnabled = not noClipEnabled spawn(function() while noClipEnabled do task.wait() pcall(function() for _,v in pairs(LocalPlayer.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end) end end) end)

botoesBrincadeira[3].MouseButton1Click:Connect(function() colorChangeEnabled = not colorChangeEnabled spawn(function() while colorChangeEnabled do task.wait(0.5) for _,v in pairs(LocalPlayer.Character:GetDescendants()) do if v:IsA("BasePart") then v.Color = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255)) end end end end) end)

botoesBrincadeira[4].MouseButton1Click:Connect(function() spawn(function() for i=1,300 do task.wait(0.2) local dumbell = LocalPlayer.Backpack:FindFirstChild("Dumbell") if dumbell then local clone = dumbell:Clone() clone.Parent = workspace clone.Handle.CFrame = CFrame.new(Vector3.new(math.random(-300,300),100,math.random(-300,300))) end end end) end)

botoesBrincadeira[5].MouseButton1Click:Connect(function() for _,v in pairs(LocalPlayer.Character:GetChildren()) do if v:IsA("BillboardGui") or v:IsA("Humanoid") then pcall(function() v:Destroy() end) end end end)

botoesBrincadeira[6].MouseButton1Click:Connect(function() for _,v in pairs(LocalPlayer.Character:GetDescendants()) do if v:IsA("BasePart") then v.Color = Color3.fromRGB(0, 100, 255) end end end)

botoesBrincadeira[7].MouseButton1Click:Connect(function() isFlying = false noClipEnabled = false colorChangeEnabled = false vidaFarm = false forcaFarm = false if LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart:FindFirstChild("FlyForce") then LocalPlayer.Character.HumanoidRootPart.FlyForce:Destroy() end end)

