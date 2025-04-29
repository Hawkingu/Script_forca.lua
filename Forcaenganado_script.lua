while _G.autoForca do
    local args = {
        [1] = 1
    }

    -- Primeiro, o +5 normal
    game:GetService("Players").LocalPlayer.Character.Dumbell.Event:FireServer(unpack(args))

    wait(0.05) -- 0,05 segundos depois

    -- Agora, mandar +3 (3 vezes rapidinho)
    for i = 1, 3 do
        game:GetService("Players").LocalPlayer.Character.Dumbell.Event:FireServer(unpack(args))
        wait(0.02) -- intervalo pequeno entre os 3 cliques
    end

    wait(0.05) -- mais 0,05 segundos depois

    -- Finalmente, mandar +1
    game:GetService("Players").LocalPlayer.Character.Dumbell.Event:FireServer(unpack(args))

    wait(1) -- esperar 1 segundo para o próximo ciclo
end
