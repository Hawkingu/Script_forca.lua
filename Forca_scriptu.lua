local dumbbell = game.Workspace:WaitForChild("Dumbbell") -- Substitua "Dumbbell" pelo nome exato do seu objeto
local remote = game.ReplicatedStorage:WaitForChild("Remote") -- Substitua pelo nome correto do remoto que ativa a ação

while true do
    -- Simula o clique a cada 1 segundo
    remote:FireServer() -- Dispara o comando que ativa a ação do dumbbell
    wait(1) -- Espera 1 segundo antes de clicar novamente
end
