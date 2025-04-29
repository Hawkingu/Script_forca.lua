local katana = script.Parent

katana.Touched:Connect(function(hit)
    local humanoid = hit.Parent:FindFirstChild("Humanoid")
    if humanoid then
        -- Código para aplicar o efeito desejado, como aumentar força e velocidade
    end
end)
