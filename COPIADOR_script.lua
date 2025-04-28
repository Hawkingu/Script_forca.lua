-- Script de Copiar Status de Outro Jogador
-- Feito para Exploits que suportam getconnections, firetouchinterest, etc.

local targetName = "NomeDoPlayer" -- << Troque pelo nome do jogador que você quer copiar!

-- Função principal
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function copiarStatus()
    local target = Players:FindFirstChild(targetName)
    if not target then
        warn("Jogador alvo não encontrado!")
        return
    end

    -- Achar valores
    local myStats = LocalPlayer:FindFirstChild("leaderstats") or LocalPlayer:FindFirstChild("Stats")
    local targetStats = target:FindFirstChild("leaderstats") or target:FindFirstChild("Stats")

    if not (myStats and targetStats) then
        warn("Não foi possível encontrar stats!")
        return
    end

    -- Copiar todos os valores
    for _, stat in ipairs(targetStats:GetChildren()) do
        local myStat = myStats:FindFirstChild(stat.Name)
        if myStat and myStat:IsA("NumberValue") then
            myStat.Value = stat.Value
        end
    end

    print("Status copiado com sucesso de", targetName)
end

-- Rodar
copiarStatus()
