-- [Farm automático de força + Anti-AFK para MOBILE]

-- Variáveis iniciais
local player = game:GetService("Players").LocalPlayer
local dumbell = player.Character:WaitForChild("Dumbell"):WaitForChild("Event")
local intervalo = 0.5 -- 0.5 segundos entre cada treino (seguro para não ser kickado)

-- Função de farm
task.spawn(function()
    while task.wait(intervalo) do
        pcall(function()
            dumbell:FireServer(1)
        end)
    end
end)

-- Função Anti-AFK
pcall(function()
    local vu = game:GetService("VirtualUser")
    player.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        print("[ANTI-AFK] Você não será desconectado por inatividade.")
    end)
end)

print("Farm de força iniciado + Anti-AFK ativado!")
