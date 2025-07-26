-- Painel UI com Dumbbell Turbo - por Hawkingu

-- Proteção contra duplicação
if game.CoreGui:FindFirstChild("DumbbellTurboUI") then
    game.CoreGui.DumbbellTurboUI:Destroy()
end

-- Criar o painel
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "DumbbellTurboUI"
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Fundo vermelho
Frame.Position = UDim2.new(0, 20, 0, 100)
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Active = true
Frame.Draggable = true

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 12)

local Button = Instance.new("TextButton", Frame)
Button.Size = UDim2.new(1, -20, 0, 40)
Button.Position = UDim2.new(0, 10, 0, 30)
Button.Text = "Ativar Dumbbell Turbo"
Button.TextColor3 = Color3.fromRGB(0, 0, 0) -- Letras pretas
Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- Botão branco
Button.Font = Enum.Font.SourceSansBold
Button.TextSize = 16

local UICorner2 = Instance.new("UICorner", Button)
UICorner2.CornerRadius = UDim.new(0, 8)

-- Função que ativa o Dumbbell Turbo
local ativado = false
local simulacoes = 10
local loopAtivo

Button.MouseButton1Click:Connect(function()
    ativado = not ativado
    Button.Text = ativado and "Desativar Turbo" or "Ativar Dumbbell Turbo"
    
    if ativado then
        loopAtivo = task.spawn(function()
            local remote = game:GetService("ReplicatedStorage"):WaitForChild("Remote")
            while ativado do
                for i = 1, simulacoes do
                    pcall(function()
                        remote:FireServer()
                    end)
                    task.wait(0.1 / simulacoes)
                end
            end
        end)
    else
        if loopAtivo then
            task.cancel(loopAtivo)
        end
    end
end)
