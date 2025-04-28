-- // Fly + Farm + Drag & Drop (MOBILE)

-- Criar GUI
local ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
ScreenGui.Name = "FlyFarmGui"
ScreenGui.ResetOnSpawn = false

-- Função pra criar botão fácil
local function createButton(name, text, pos)
    local btn = Instance.new("TextButton", ScreenGui)
    btn.Size = UDim2.new(0, 120, 0, 50)
    btn.Position = pos
    btn.Text = text
    btn.Name = name
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextScaled = true
    btn.Draggable = true -- Drag & Drop ativado
    btn.Active = true
    return btn
end

-- Criar botões
local flyButton = createButton("FlyButton", "Fly (OFF)", UDim2.new(0, 50, 0, 100))
local farmButton = createButton("FarmButton", "Farm (OFF)", UDim2.new(0, 50, 0, 200))

-- Variáveis
local flying = false
local farming = false

-- FLY SCRIPT
local FlySpeed = 50 -- Velocidade do voo

function Fly()
    local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    local bodyGyro = Instance.new("BodyGyro", root)
    local bodyVelocity = Instance.new("BodyVelocity", root)

    bodyGyro.P = 9e4
    bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bodyGyro.CFrame = root.CFrame

    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)

    -- Controla o movimento no mobile
    local UIS = game:GetService("UserInputService")

    local flyingConnection
    flyingConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not flying then
            bodyGyro:Destroy()
            bodyVelocity:Destroy()
            flyingConnection:Disconnect()
            return
        end

        local moveDirection = Vector3.new(0, 0, 0)

        -- Mobile usa TouchGui pra pular e andar
        moveDirection = game.Players.LocalPlayer.Character.Humanoid.MoveDirection

        bodyGyro.CFrame = workspace.CurrentCamera.CFrame
        bodyVelocity.Velocity = (workspace.CurrentCamera.CFrame.lookVector * moveDirection.Z + workspace.CurrentCamera.CFrame.rightVector * moveDirection.X) * FlySpeed
        bodyVelocity.Velocity = Vector3.new(bodyVelocity.Velocity.X, moveDirection.Y * FlySpeed, bodyVelocity.Velocity.Z)
    end)
end

-- FARM SCRIPT
function Farm()
    while farming do
        local args = {
            [1] = "Weight"
        }
        game:GetService("ReplicatedStorage").Events.ToolRemote:FireServer(unpack(args))
        wait(0.2) -- Ajuste o tempo se quiser farmar mais rápido ou mais lento
    end
end

-- BOTÕES
flyButton.MouseButton1Click:Connect(function()
    flying = not flying
    if flying then
        Fly()
        flyButton.Text = "Fly (ON)"
    else
        flyButton.Text = "Fly (OFF)"
    end
end)

farmButton.MouseButton1Click:Connect(function()
    farming = not farming
    if farming then
        farmButton.Text = "Farm (ON)"
        spawn(Farm)
    else
        farmButton.Text = "Farm (OFF)"
    end
end)
