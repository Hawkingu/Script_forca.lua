-- Localiza o objeto "Dumbbell" no Workspace
local dumbbell = game.Workspace:WaitForChild("Dumbbell")

-- Função que simula o clique no Dumbbell a cada 1 segundo
while true do
    -- Verifica se o Dumbbell ainda existe no jogo
    if dumbbell and dumbbell:FindFirstChild("ClickDetector") then
        -- Simula o clique usando o ClickDetector
        dumbbell.ClickDetector:MouseClick(game.Players.LocalPlayer.Character.HumanoidRootPart)
    end
    wait(1) -- Espera 1 segundo antes de clicar novamente
end
