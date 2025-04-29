-- HAWKEXECUT+ Painel Completo (Mobile, sem teclas virtuais)

local Players = game:GetService("Players") local LocalPlayer = Players.LocalPlayer local UIS = game:GetService("UserInputService") local RS = game:GetService("RunService")

local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui")) gui.Name = "HAWKEXECUT+" gui.ResetOnSpawn = false

-- Botão da logo local logo = Instance.new("TextButton", gui) logo.Position = UDim2.new(0, 10, 0, 10) logo.Size = UDim2.new(0, 50, 0, 50) logo.Text = "🪴" logo.BackgroundColor3 = Color3.fromRGB(30,30,30) logo.TextColor3 = Color3.fromRGB(255,255,255)

-- Painel principal local frame = Instance.new("Frame", gui) frame.Position = UDim2.new(0.5, -150, 0.5, -200) frame.Size = UDim2.new(0, 300, 0, 400) frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20) frame.Visible = false local corner = Instance.new("UICorner", frame) corner.CornerRadius = UDim.new(0, 10)

-- Arrastar local dragging = false local dragStart, startPos local function update(input) local delta = input.Position - dragStart frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end frame.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true dragStart = input.Position startPos = frame.Position input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end) end end) UIS.InputChanged:Connect(function(input) if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then update(input) end end)

logo.MouseButton1Click:Connect(function() frame.Visible = not frame.Visible end)

-- Criador de botões local y = 10 local function createBtn(txt, yAdd, func) local btn = Instance.new("TextButton", frame) btn.Position = UDim2.new(0, 10, 0, y) btn.Size = UDim2.new(1, -20, 0, 30) btn.Text = "○ "..txt btn.BackgroundColor3 = Color3.fromRGB(40,40,40) btn.TextColor3 = Color3.fromRGB(255,255,255)

local state = false
btn.MouseButton1Click:Connect(function()
    state = not state
    btn.Text = (state and "● " or "○ ")..txt
    func(state)
end)
y = y + yAdd

end

-- Auto Força createBtn("Auto Força", 40, function(s) _G.auto = s task.spawn(function() while _G.auto do local args = {[1] = 9} for i = 1, 4 do pcall(function() LocalPlayer.Character.Dumbell.Event:FireServer(unpack(args)) end) wait(0.6) end wait(1) end end) end)

-- Auto Vida createBtn("Auto Vida", 40, function(s) _G.vida = s task.spawn(function() while _G.vida do pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/hawk/teuscript/main/script.lua"))() end) wait(1) end end) end)

-- Auto Kill createBtn("Auto Kill Bug", 40, function(s) _G.autokill = s task.spawn(function() while _G.autokill do pcall(function() for _,v in pairs(Players:GetPlayers()) do if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-3) end end end) wait(0.1) end end) end)

-- Noclip createBtn("Atravessar Paredes", 40, function(s) _G.noclip = s task.spawn(function() while _G.noclip do pcall(function() for _,v in pairs(LocalPlayer.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end) wait() end end) end)

-- Voar Direcionado Rápido (chão) createBtn("Voar Direcionado (rápido)", 40, function(state) _G.flying = state local speed = 150 task.spawn(function() while _G.flying do local char = LocalPlayer.Character if char and char:FindFirstChild("HumanoidRootPart") then local dir = char.Humanoid.MoveDirection char.HumanoidRootPart.Velocity = dir * speed end wait() end end) end)

-- Fogo createBtn("Pegar Fogo", 40, function(s) if s then local fire = Instance.new("Fire", LocalPlayer.Character:FindFirstChild("HumanoidRootPart") or LocalPlayer.Character:FindFirstChildWhichIsA("BasePart")) fire.Size = 10 fire.Heat = 20 else for _,v in pairs(LocalPlayer.Character:GetDescendants()) do if v:IsA("Fire") then v:Destroy() end end end end)

-- Teleporte com Nome createBtn("/TP Botar nome:", 40, function(s) if s then local name = game:GetService("StarterGui"):PromptTextInput("Digite o nome do jogador para TP") local target = Players:FindFirstChild(name) if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character:MoveTo(target.Character.HumanoidRootPart.Position) end end end)

