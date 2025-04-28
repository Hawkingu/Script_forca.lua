local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local flying = false
local bodyVelocity = nil

-- Função para ativar voo
local function startFlying()
    if not flying then
        flying = true
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000) -- Ajusta a força de voo
        bodyVelocity.Velocity = Vector3.new(0, 50, 0) -- Ajusta a direção e velocidade do voo
        bodyVelocity.Parent = character:WaitForChild("HumanoidRootPart")
    end
end

-- Função para parar o voo
local function stopFlying()
    if flying then
        flying = false
        if bodyVelocity then
            bodyVelocity:Destroy()
            bodyVelocity = nil
        end
    end
end

-- Toggle de voo
local function toggleFlight()
    if flying then
        stopFlying()
    else
        startFlying()
    end
end

-- Ativa o voo com a tecla "F"
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F then
        toggleFlight() -- Troca entre voar ou parar de voar quando a tecla "F" for pressionada
    end
end)
