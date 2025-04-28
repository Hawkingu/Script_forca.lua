local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local flying = false
local speed = 50 -- Velocidade do voo
local bodyVelocity = Instance.new("BodyVelocity") -- Usado para controlar a velocidade do movimento

-- Função para iniciar o voo
local function startFlying()
    if not flying then
        flying = true
        humanoid.PlatformStand = true -- Desativa o controle normal do humanoide
        
        -- Cria um BodyVelocity para permitir o movimento livre
        bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000) -- Permite mover em qualquer direção
        bodyVelocity.Velocity = Vector3.new(0, 0, 0) -- Começa sem movimento
        bodyVelocity.Parent = character.HumanoidRootPart
        
        -- Loop de movimento
        while flying do
            local mouse = player:GetMouse()
            local direction = (mouse.Hit.p - character.HumanoidRootPart.Position).unit -- Direção do movimento
            
            -- Ajusta a velocidade de movimento com base na direção
            bodyVelocity.Velocity = direction * speed
            wait(0.1) -- Intervalo entre atualizações
        end
    end
end

-- Função para parar o voo
local function stopFlying()
    flying = false
    humanoid.PlatformStand = false -- Restaura o controle normal do humanoide
    bodyVelocity:Destroy() -- Remove o BodyVelocity para parar o movimento
end

-- Ativando o voo
startFlying()

-- Parando o voo após 10 segundos (como exemplo)
wait(10)
stopFlying()
