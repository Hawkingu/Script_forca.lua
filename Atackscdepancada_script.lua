-- CONFIGURAÇÃO
local tempo = 0.5 -- Tempo entre cada clique (em segundos)

-- PEGA SERVIÇOS
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- FUNÇÃO: PEGAR SACO MAIS PRÓXIMO
local function getClosestBag()
    local bags = workspace:GetChildren()
    local closestBag = nil
    local shortestDistance = math.huge
    for _, obj in ipairs(bags) do
        if obj.Name:lower():find("bag") then
            local distance = (Character.HumanoidRootPart.Position - obj.Position).magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                closestBag = obj
            end
        end
    end
    return closestBag
end

-- FARM AUTOMÁTICO
spawn(function()
    while true do
        local bag = getClosestBag()
        if bag and (Character.HumanoidRootPart.Position - bag.Position).magnitude <= 10 then
            -- Se estiver em cima do saco, bate
            pcall(function()
                local remote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("PunchBag")
                if remote then
                    remote:FireServer()
                end
            end)
        end
        wait(tempo)
    end
end)

print("Auto Click no Saco de Pancadas Ativado!")
