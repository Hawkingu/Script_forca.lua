-- Simula múltiplos Dumbbells com intervalo mínimo
-- Aumenta o ganho de força em milissegundos, sem esperar 1s inteiro

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remote = ReplicatedStorage:WaitForChild("Remote") -- Altere se o nome for diferente

local simulacoes = 10 -- Número de halteres "falsos"

while true do
    for i = 1, simulacoes do
        pcall(function()
            remote:FireServer()
        end)
        task.wait(0.1 / simulacoes) -- Exemplo: 0.01s entre cada
    end
end
