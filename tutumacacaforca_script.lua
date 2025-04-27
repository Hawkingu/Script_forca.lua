-- Definir o jogador
local player = game.Players.LocalPlayer

-- Localizar o objeto "Dumbbell" dentro da personagem do jogador
local dumbbell = player.Character:WaitForChild("Dumbell")  -- Ajuste para o nome correto do objeto

-- Verificar se o RemoteEvent para o Dumbbell está presente
local event = dumbbell:FindFirstChild("Event")  -- Ajuste para o nome correto do RemoteEvent

-- Simular cliques no Dumbbell a cada 1 segundo
while true do
    task.wait(1)  -- Espera 1 segundo entre os "cliques"
    
    if event then
        -- Envia o evento para aumentar a força
        local args = { [1] = 1 }  -- Passa os argumentos necessários para aumentar a força
        event:FireServer(unpack(args))  -- Dispara o RemoteEvent para aumentar a força
    else
        warn("RemoteEvent não encontrado.")
    end
end
