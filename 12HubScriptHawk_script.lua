-- HawkHub V3 (Atualizado) local player = game.Players.LocalPlayer local character = player.Character or player.CharacterAdded:Wait() local humanoid = character:WaitForChild("Humanoid") local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui")) screenGui.Name = "HawkHubV3"

-- Fundo do Botão local background = Instance.new("Frame", screenGui) background.Size = UDim2.new(0.2, 0, 0.1, 0) background.Position = UDim2.new(0.4, 0, 0.02, 0) background.BackgroundColor3 = Color3.fromRGB(255, 255, 255) background.BackgroundTransparency = 0.5

-- Botão Cobra Kai local textButton = Instance.new("TextButton", background) textButton.Size = UDim2.new(1, 0, 1, 0) textButton.Text = "Cobra Kai" textButton.Font = Enum.Font.SourceSansBold textButton.TextSize = 24 textButton.TextColor3 = Color3.fromRGB(0, 0, 0) textButton.BackgroundTransparency = 1

-- Painel Principal local panel = Instance.new("Frame", screenGui) panel.Size = UDim2.new(0.7, 0, 0.5, 0) panel.Position = UDim2.new(0.15, 0, 0.15, 0) panel.BackgroundColor3 = Color3.fromRGB(0, 0, 0) panel.BackgroundTransparency = 0.6 panel.Visible = false

-- Botões local function createButton(text, position, color) local btn = Instance.new("TextButton", panel) btn.Size = UDim2.new(0.8, 0, 0.2, 0) btn.Position = position btn.Text = text btn.Font = Enum.Font.GothamBold btn.TextSize = 20 btn.TextColor3 = Color3.fromRGB(255, 255, 255) btn.BackgroundColor3 = color return btn end

local invisibilityButton = createButton("Invisibilidade", UDim2.new(0.1, 0, 0.1, 0), Color3.fromRGB(255, 0, 0)) local flightButton = createButton("Voo", UDim2.new(0.1, 0, 0.35, 0), Color3.fromRGB(0, 255, 0)) local healButton = createButton("Vida Instantanea", UDim2.new(0.1, 0, 0.6, 0), Color3.fromRGB(255, 165, 0))

-- Funções de Script local function becomeInvisible() for _, part in ipairs(character:GetChildren()) do if part:IsA("BasePart") then part.Transparency = 1 part.CanCollide = false end end end

local function restoreVisibility() for _, part in ipairs(character:GetChildren()) do if part:IsA("BasePart") then part.Transparency = 0 part.CanCollide = true end end end

local flying = false local bodyVelocity = nil local flyingDirection = Vector3.new(0, 0, 0)

local function startFlying() if not flying then flying = true bodyVelocity = Instance.new("BodyVelocity", character:WaitForChild("HumanoidRootPart")) bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000) bodyVelocity.Velocity = flyingDirection end end

local function stopFlying() flying = false if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end end

local function toggleFlight() if flying then stopFlying() else startFlying() end end

local function heal() humanoid.Health = humanoid.MaxHealth end

local function toggleInvisibility() if character:FindFirstChild("HumanoidRootPart").Transparency == 1 then restoreVisibility() else becomeInvisible() end end

-- Funções Botões invisibilityButton.MouseButton1Click:Connect(toggleInvisibility) flightButton.MouseButton1Click:Connect(toggleFlight) healButton.MouseButton1Click:Connect(heal)

-- Mostrar Painel textButton.MouseButton1Click:Connect(function() panel.Visible = not panel.Visible end)

-- Voo Direcional Atualizado game:GetService("RunService").Heartbeat:Connect(function() if flying then flyingDirection = workspace.CurrentCamera.CFrame.LookVector * 50 if bodyVelocity then bodyVelocity.Velocity = flyingDirection end end end)

-- Dumbbell Farm Automático pra Sempre spawn(function() while task.wait(0.1) do local tool = player.Character and player.Character:FindFirstChildOfClass("Tool") if tool and tool:FindFirstChild("RemoteEvent") then tool.RemoteEvent:FireServer() end end end)

