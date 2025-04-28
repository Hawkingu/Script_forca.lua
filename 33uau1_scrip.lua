local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))

-- Criando um painel para o tema Cobra Kai
local background = Instance.new("ImageButton")
background.Size = UDim2.new(0.2, 0, 0.1, 0)
background.Position = UDim2.new(0, 10, 0, 10)
background.BackgroundTransparency = 1
background.Image = "https://tr.rbxcdn.com/1f3c2c75d9b18e5b7874d9f9c7b0e370/420/420/Image/Png"
background.Parent = screenGui

local title = Instance.new("TextLabel", background)
title.Size = UDim2.new(1, 0, 1, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Cobra Kai"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.Fantasy
title.TextScaled = true

local panel = Instance.new("Frame", screenGui)
panel.Size = UDim2.new(0.7, 0, 0.7, 0)
panel.Position = UDim2.new(0.15, 0, 0.15, 0)
panel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
panel.BackgroundTransparency = 0.5
panel.Visible = false

-- Função para girar o personagem
local function rotateCharacter()
    while true do
        if character and humanoid then
            character:SetPrimaryPartCFrame(character.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(5), 0)) -- Rotaciona o personagem
        end
        wait(0.1) -- Espera um curto intervalo para a próxima rotação
    end
end

-- Função para adicionar a força automática
local function autoStrength()
    while true do
        local args = { [1] = 1 }
        pcall(function()
            player.Character.Dumbell.Event:FireServer(unpack(args)) -- Envia um evento para aumentar a força
        end)
        wait(0.1) -- Intervalo para enviar o evento
    end
end

-- Função para atacar todos na área
local function attackInArea()
    while true do
        for _, enemy in pairs(workspace:GetChildren()) do
            if enemy:IsA("Model") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                -- Verifica se o inimigo está na área e aplica dano
                local distance = (character.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude
                if distance < 20 then
                    local enemyHumanoid = enemy:FindFirstChild("Humanoid")
                    if enemyHumanoid then
                        enemyHumanoid:TakeDamage(10) -- Dano ao inimigo
                    end
                end
            end
        end
        wait(1) -- Verifica a cada segundo se algum inimigo deve receber dano
    end
end

-- Função para colocar o rádio nas costas
local function addRadio()
    local radio = Instance.new("Model", character) -- Cria o modelo do rádio
    radio.Name = "Radio"
    
    local radioPart = Instance.new("Part", radio)
    radioPart.Size = Vector3.new(2, 2, 1)
    radioPart.Position = character.HumanoidRootPart.Position + Vector3.new(0, 2, 0) -- Coloca o rádio nas costas
    radioPart.Anchored = false
    radioPart.CanCollide = false
    radioPart.Color = Color3.fromRGB(255, 255, 0)
    
    local radioMesh = Instance.new("SpecialMesh", radioPart)
    radioMesh.MeshId = "rbxassetid://1234567890" -- Substitua pelo Mesh do rádio que você deseja
    radioMesh.TextureId = "rbxassetid://0987654321" -- Substitua pela textura do rádio se necessário
    
    radio.PrimaryPart = radioPart
    radio:SetPrimaryPartCFrame(character.HumanoidRootPart.CFrame * CFrame.new(0, 2, 0)) -- Ajusta para as costas do personagem
end

-- Iniciar as funções
spawn(rotateCharacter)    -- Começa a rotação do personagem
spawn(autoStrength)      -- Começa a força automática
spawn(attackInArea)      -- Começa a função de ataque na área
addRadio()               -- Coloca o rádio nas costas

-- Mostrar/Ocultar painel
background.MouseButton1Click:Connect(function()
    panel.Visible = not panel.Visible
end)
