local function criarBot()
    local bot = LocalPlayer.Character:Clone()
    bot.Name = "FakeBot_"..tostring(math.random(1000,9999))

    -- Roupas grátis (careca, camiseta, shorts)
    for _, v in pairs(bot:GetDescendants()) do
        if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") then
            v:Destroy()
        end
    end

    local shirt = Instance.new("Shirt", bot)
    shirt.ShirtTemplate = "rbxassetid://144076760" -- camiseta grátis

    local pants = Instance.new("Pants", bot)
    pants.PantsTemplate = "rbxassetid://144076760" -- short grátis

    bot:MoveTo(LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(5,0,0))
    bot.Parent = workspace

    -- Nome visível
    local humanoid = bot:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.DisplayName = "BOT-TORNEIO"
    end

    -- Ataque automático
    task.spawn(function()
        while bot and bot.Parent do
            task.wait(1)
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local target = player.Character.HumanoidRootPart
                    local botHRP = bot:FindFirstChild("HumanoidRootPart")
                    if botHRP and (botHRP.Position - target.Position).Magnitude < 10 then
                        -- Atacar com soco (ou evento do jogo se tiver)
                        game:GetService("ReplicatedStorage").Remotes.Dano:FireServer(target) 
                    end
                end
            end
        end
    end)
end

-- Botão Farm Torneio
local FarmTorneioButton = createButton("FarmTorneio", UDim2.new(0, 15, 0, 420), Color3.fromRGB(100, 0, 150), "[Farm Torneio]", MainFrame)

FarmTorneioButton.MouseButton1Click:Connect(function()
    criarBot()
    warn("Bot de Torneio criado e pronto pra atacar.")
end)
