while _G.autoForca do
    local args = {[1] = 9} -- Agora mandando 9 como valor

    -- +9 de força (fingindo que é permitido)
    game:GetService("Players").LocalPlayer.Character.Dumbell.Event:FireServer(unpack(args))

    wait(0.6) -- Esperar 0.6 segundos (evitar spam)

    -- +3 vezes enviando +9
    for i = 1, 3 do
        game:GetService("Players").LocalPlayer.Character.Dumbell.Event:FireServer(unpack(args))
        wait(0.6)
    end

    -- +1 vez enviando +9
    game:GetService("Players").LocalPlayer.Character.Dumbell.Event:FireServer(unpack(args))
    
    wait(1) -- Depois do ciclo completo, esperar 1 segundo
end
