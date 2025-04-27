while true do
    task.wait(1) -- espera 1 segundo (pode diminuir se quiser mais rápido)

    local args = {
        [1] = "TrainStrength"
    }
    game:GetService("ReplicatedStorage").Remotes.Combat:FireServer(unpack(args))
end
