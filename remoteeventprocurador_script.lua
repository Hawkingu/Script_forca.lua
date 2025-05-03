local bench = game.Workspace:WaitForChild("NomeDoBanco") -- Nome exato do objeto do banco de treino
local remote = game.ReplicatedStorage:WaitForChild("NomeDoRemote") -- Nome do remote correto

while true do
    remote:FireServer() -- Dispara o comando para o banco de treino
    wait(1) -- Espera 1 segundo antes de enviar o comando novamente
end
