-- Script para ganhar vida automaticamente usando o RemoteEvent "Branco"
local player = game:GetService("Players").LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")

-- Encontrar o RemoteEvent "Branco"
local brancoEvent = replicatedStorage:WaitForChild("Branco")  -- Substitua "Branco" se necessário, pelo nome correto

local intervalo = 2  -- Intervalo seguro entre cada uso do evento (2 segundos é um bom tempo para evitar banimento)

-- Função para farmar vida
task.spawn(function()
    while true do
        pcall(function()
            brancoEvent:FireServer()  -- Dispara o evento "Branco" para ganhar vida
            print("Vida aumentada!")
        end)
        task.wait(intervalo)  -- Espera o intervalo antes de repetir
    end
end)

print("Farm de vida ativado com sucesso!")
