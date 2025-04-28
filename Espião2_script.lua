-- Versão segura do espião de RemoteEvents (sem hookfunction)

local player = game:GetService("Players").LocalPlayer

print(">> Espião Seguro de RemoteEvent ativado!")

-- Observa tudo que for disparado do personagem
for _, v in pairs(player.Character:GetDescendants()) do
    if v:IsA("RemoteEvent") then
        v.OnClientEvent:Connect(function(...)
            print("---- RemoteEvent Recebido (OnClientEvent) ----")
            print("Nome:", v.Name)
            print("Caminho:", v:GetFullName())
            print("Argumentos:", ...)
            print("---------------------------------------------")
        end)
    end
end

-- Observa tudo no ReplicatedStorage (onde ficam Remotes públicos)
local replicatedStorage = game:GetService("ReplicatedStorage")

for _, v in pairs(replicatedStorage:GetDescendants()) do
    if v:IsA("RemoteEvent") then
        v.OnClientEvent:Connect(function(...)
            print("---- RemoteEvent Recebido (ReplicatedStorage) ----")
            print("Nome:", v.Name)
            print("Caminho:", v:GetFullName())
            print("Argumentos:", ...)
            print("-----------------------------------------------")
        end)
    end
end
