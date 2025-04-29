-- Painel HAWKEXECUT+ local Players = game:GetService("Players") local LocalPlayer = Players.LocalPlayer local UIS = game:GetService("UserInputService") local RS = game:GetService("RunService")

local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui")) ScreenGui.Name = "HAWKEXECUT+" ScreenGui.ResetOnSpawn = false

local LogoButton = Instance.new("TextButton", ScreenGui) LogoButton.Position = UDim2.new(0, 10, 0, 10) LogoButton.Size = UDim2.new(0, 50, 0, 50) LogoButton.Text = "🕴" LogoButton.Name = "HAWKEXECUT+" LogoButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30) LogoButton.TextColor3 = Color3.fromRGB(255, 255, 255)

local MainFrame = Instance.new("Frame", ScreenGui) MainFrame.Size = UDim2.new(0, 300, 0, 350) MainFrame.Position = UDim2.new(0, 100, 0, 80) MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) MainFrame.Visible = false local UICorner = Instance.new("UICorner", MainFrame) UICorner.CornerRadius = UDim.new(0, 10)

-- Dragging local dragging, dragInput, dragStart, startPos local function update(input) local delta = input.Position - dragStart MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end MainFrame.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true dragStart = input.Position startPos = MainFrame.Position input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end) end end) MainFrame.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end) UIS.InputChanged:Connect(function(input) if input == dragInput and dragging then update(input) end end)

-- Toggle painel LogoButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- Gui Toggle Buttons local Tabs = {"Farm", "Brincadeira"} local ActiveTab = nil local TabButtons = {} local TabScripts = {}

for i, name in ipairs(Tabs) do local tab = Instance.new("TextButton", MainFrame) tab.Size = UDim2.new(0.5, -10, 0, 30) tab.Position = UDim2.new((i-1)*0.5, 10, 0, 10) tab.Text = name tab.BackgroundColor3 = Color3.fromRGB(40, 40, 40) tab.TextColor3 = Color3.fromRGB(255, 255, 255) TabButtons[name] = tab

local frame = Instance.new("Frame", MainFrame)
frame.Position = UDim2.new(0, 10, 0, 50)
frame.Size = UDim2.new(1, -20, 1, -60)
frame.BackgroundTransparency = 1
frame.Visible = false
TabScripts[name] = frame

tab.MouseButton1Click:Connect(function()
    for _, fr in pairs(TabScripts) do fr.Visible = false end
    frame.Visible = true
    ActiveTab = name
end)

end

-- Função para criar switches local function createToggle(text, parent, callback) local btn = Instance.new("TextButton", parent) btn.Size = UDim2.new(1, 0, 0, 30) btn.Text = "○ "..text btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60) btn.TextColor3 = Color3.fromRGB(255, 255, 255)

local enabled = false
btn.MouseButton1Click:Connect(function()
    enabled = not enabled
    btn.Text = (enabled and "● " or "○ ") .. text
    callback(enabled)
end)

end

-- FARM createToggle("Auto Força (+5)", TabScripts.Farm, function(state) _G.autoForca = state spawn(function() while _G.autoForca do local args = {[1] = 9} for i = 1, 4 do game:GetService("Players").LocalPlayer.Character.Dumbell.Event:FireServer(unpack(args)) wait(0.6) end wait(1) end end) end)

createToggle("Auto Vida (+1)", TabScripts.Farm, function(state) _G.autoVida = state spawn(function() while _G.autoVida do loadstring(game:HttpGet("https://raw.githubusercontent.com/hawk/teuscript/main/script.lua"))() wait(1) end end) end)

createToggle("Auto Stamina", TabScripts.Farm, function(state) if state then loadstring(game:HttpGet("https://raw.githubusercontent.com/crashrlq/stamina/refs/heads/main/README.md"))() end end)

-- BRINCADEIRA createToggle("Atravessar Parede", TabScripts.Brincadeira, function(state) _G.noclip = state spawn(function() while _G.noclip do wait() pcall(function() local char = LocalPlayer.Character for _,v in pairs(char:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end) end end) end)

createToggle("Voar no Chão", TabScripts.Brincadeira, function(state) _G.flyMove = state local flying = false local speed = 50 local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait() local hrp = char:WaitForChild("HumanoidRootPart") RS:BindToRenderStep("HawkFly", Enum.RenderPriority.Character.Value, function() if _G.flyMove then flying = true local moveDir = UIS:GetFocusedTextBox() == nil and LocalPlayer:GetMouse().Hit.lookVector or Vector3.new() hrp.Velocity = moveDir * speed elseif flying then RS:UnbindFromRenderStep("HawkFly") flying = false end end) end)

createToggle("Pegar Fogo", TabScripts.Brincadeira, function(state) if state then local char = LocalPlayer.Character local fire = Instance.new("Fire", char:FindFirstChild("HumanoidRootPart") or char:FindFirstChildWhichIsA("BasePart")) fire.Size = 10 fire.Heat = 20 else local char = LocalPlayer.Character for _,v in pairs(char:GetDescendants()) do if v:IsA("Fire") then v:Destroy() end end end end)

