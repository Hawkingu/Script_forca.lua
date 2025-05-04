local targetName = "NomeDoJogador"

local target = game.Players:FindFirstChild(targetName)
local localPlayer = game.Players.LocalPlayer

if target then
    -- Clona a aparência
    localPlayer.CharacterAppearanceId = target.UserId
    localPlayer:LoadCharacter()

    -- Exemplo de copiar stats (visual, se forem armazenados localmente)
    local function copyStats()
        for _, stat in pairs(target:WaitForChild("leaderstats"):GetChildren()) do
            local myStat = localPlayer:WaitForChild("leaderstats"):FindFirstChild(stat.Name)
            if myStat then
                myStat.Value = stat.Value
            end
        end
    end

    copyStats()
else
    warn("Jogador alvo não encontrado.")
end
