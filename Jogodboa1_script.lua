-- Monitoramento de RemoteEvents com segurança
local replicatedStorage = game:GetService("ReplicatedStorage")

-- Função para capturar RemoteEvents
local function monitorRemoteEvents()
    for _, obj in pairs(replicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            -- Conectar ao evento para capturar quando ele for disparado
            obj.OnClientEvent:Connect(function(...)
                print("RemoteEvent detectado:", obj.Name, ...)
            end)
        end
    end
end

-- Chamar a função para começar a monitorar
monitorRemoteEvents()

print("Monitorando RemoteEvents... Aguarde a interação no jogo.")

-- Aguardar interações com os objetos
while true do
    task.wait(1)  -- Esse intervalo é seguro e evita "spam" de requests.
end
