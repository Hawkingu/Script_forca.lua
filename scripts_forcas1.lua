-- No servidor
game:GetService("Players").PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        -- Encontrando o objeto Dumbell e o RemoteEvent
        local dumbbell = character:WaitForChild("Dumbell")
        local remoteEvent = dumbbell:WaitForChild("Event")

        -- O servidor ouve o evento disparado pelo cliente
        remoteEvent.OnServerEvent:Connect(function(player, value)
            print(player.Name .. " enviou o valor: " .. tostring(value))
            -- Aqui você pode adicionar a lógica para aumentar a força ou outras ações
        end)
    end)
end)
