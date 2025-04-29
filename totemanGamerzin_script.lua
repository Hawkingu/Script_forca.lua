-- HAWKEXECUT+ Painel (Mobile)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")

local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.ResetOnSpawn = false
gui.Name = "HAWKEXECUT"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 300, 0, 400)
main.Position = UDim2.new(0, 10, 0, 100)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BorderSizePixel = 0

local UICorner = Instance.new("UICorner", main)
UICorner.CornerRadius = UDim.new(0, 10)

function createBtn(text, y, callback)
    local btn = Instance.new("TextButton", main)
    btn.Size = UDim2.new(0, 280, 0, 35)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.Text = "○ "..text
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.BorderSizePixel = 0

    local enabled = false
    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        btn.Text = (enabled and "● " or "○ ") .. text
        callback(enabled)
    end)
end

-- Auto Força
createBtn("Auto Força (+5)", 10, function(state)
    _G.autoForca = state
    task.spawn(function()
        while _G.autoForca do
            local args = {[1] = 9}
            for i = 1, 4 do
                pcall(function()
                    LocalPlayer.Character.Dumbell.Event:FireServer(unpack(args))
                end)
                wait(0.6)
            end
        end
    end)
end)

-- Auto Kill
createBtn("Auto Kill Toque", 50, function(state)
    _G.autoKill = state
    task.spawn(function()
        while _G.autoKill do
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local mag = (plr.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if mag < 5 then
                        plr.Character:TranslateBy(Vector3.new(100,100,100))
                    end
                end
            end
            wait(0.3)
        end
    end)
end)

-- Voo Direcional
createBtn("Voar Direcionado (chão)", 90, function(state)
    _G.flying = state
    local speed = 50
    task.spawn(function()
        while _G.flying do
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.Velocity = hrp.CFrame.LookVector * speed
            end
            wait()
        end
    end)
end)

-- Atravessar Paredes
createBtn("Atravessar Paredes", 130, function(state)
    _G.noclip = state
    task.spawn(function()
        while _G.noclip do
            pcall(function()
                for _,v in pairs(LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then v.CanCollide = false end
                end
            end)
            wait()
        end
    end)
end)

-- Teleporte
local box = Instance.new("TextBox", main)
box.Size = UDim2.new(0, 200, 0, 30)
box.Position = UDim2.new(0, 10, 0, 180)
box.PlaceholderText = "Nome do jogador"
box.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
box.TextColor3 = Color3.fromRGB(255,255,255)
box.BorderSizePixel = 0

local tpOn = Instance.new("TextButton", main)
tpOn.Size = UDim2.new(0, 30, 0, 30)
tpOn.Position = UDim2.new(0, 220, 0, 180)
tpOn.Text = ">"
tpOn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
tpOn.TextColor3 = Color3.fromRGB(255,255,255)

local tpOff = Instance.new("TextButton", main)
tpOff.Size = UDim2.new(0, 30, 0, 30)
tpOff.Position = UDim2.new(0, 260, 0, 180)
tpOff.Text = "<"
tpOff.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
tpOff.TextColor3 = Color3.fromRGB(255,255,255)

tpOn.MouseButton1Click:Connect(function()
    _G.tpPlayer = true
    task.spawn(function()
        while _G.tpPlayer do
            local target = Players:FindFirstChild(box.Text)
            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(2,0,0)
            end
            wait(1)
        end
    end)
end)

tpOff.MouseButton1Click:Connect(function()
    _G.tpPlayer = false
end)
