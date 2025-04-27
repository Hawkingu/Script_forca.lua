-- Script no Servidor
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local katanaEvent = ReplicatedStorage:WaitForChild("KatanaAttackEvent")

-- Função para aplicar dano
local function applyDamage(katana)
    local character = katana.Parent
    local humanoid = character:FindFirstChild("Humanoid")
    
    -- Verifica se o personagem do jogador tem um humanoide
    if humanoid then
        local range = 10  -- Distância do ataque
        local damage = 10  -- Dano causado pela katana
        
        -- Procura inimigos próximos
        for _, v in ipairs(workspace:GetChildren()) do
            if v:IsA("Model") and v:FindFirstChild("Humanoid") and v ~= character then
                local enemy = v
                local enemyHumanoid = enemy:FindFirstChild("Humanoid")
                if enemyHumanoid and (character.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude <= range then
                    -- Aplica dano ao inimigo
                    enemyHumanoid:TakeDamage(damage)
                end
            end
        end
    end
end

-- Escuta o RemoteEvent para quando o cliente disparar
katanaEvent.OnServerEvent:Connect(function(player, katana)
    applyDamage(katana)  -- Aplica dano aos inimigos próximos
end)
