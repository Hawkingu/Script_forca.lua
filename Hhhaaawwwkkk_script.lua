local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Variáveis de estado para cada função
local isFlying = false
local noClipEnabled = false
local colorChangeEnabled = false

-- Criar tela
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "CobraKaiPanel"
ScreenGui.ResetOnSpawn = false

-- Criar botão da logo
local LogoButton = Instance.new("ImageButton", ScreenGui)
LogoButton.Position = UDim2.new(0, 10, 0, 10)
LogoButton.Size = UDim2.new(0, 50, 0, 50)
LogoButton.Image = "rbxassetid://17073223843" -- Certifique-se que o ID da logo está correto
LogoButton.Name = "LogoButton"
LogoButton.BackgroundTransparency = 1 -- Torna o fundo do botão transparente

-- Criar painel
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 300, 0, 350)
MainFrame.Position = UDim2.new(0, 100, 0, 80)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Visible = false -- Começa invisível

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 15)

-- Botões principais
local FarmButton = Instance.new("TextButton", MainFrame)
local BrincadeiraButton = Instance.new("TextButton", MainFrame)

FarmButton.Size = UDim2.new(0, 270, 0, 35)
FarmButton.Position = UDim2.new(0, 15, 0, 10)
FarmButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
FarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmButton.Text = "🔴 Farm"

BrincadeiraButton.Size = UDim2.new(0, 270, 0, 35)
BrincadeiraButton.Position = UDim2.new(0, 15, 0, 55)
BrincadeiraButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
BrincadeiraButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BrincadeiraButton.Text = "🔵 Brincadeira"

-- Função para criar a cama de +5 de vida
local function criarCama()
    local cama = Instance.new("Part", workspace)
    cama.Size = Vector3.new(5, 1, 5)
    cama.Position = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 0)
    cama.Color = Color3.fromRGB(0, 255, 0) -- Cor verde para a cama
    cama.Anchored = true
    cama.Name = "CamaDeVida"
    
    local touchDetector = Instance.new("TouchTransmitter", cama)
    touchDetector.Touched:Connect(function(hit)
        if hit.Parent == LocalPlayer.Character then
            -- Aumenta a vida aqui
            LocalPlayer.Character.Humanoid.Health = LocalPlayer.Character.Humanoid.Health + 5
            cama:Destroy() -- Após o toque, destrói a cama
        end
    end)
end

FarmButton.MouseButton1Click:Connect(function()
    criarCama() -- Cria a cama de +5 de vida
end)

-- Função de controle de voar
BrincadeiraButton.MouseButton1Click:Connect(function()
    if not isFlying then
        isFlying = true
        spawn(function()
            local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local body = Instance.new("BodyVelocity", char.HumanoidRootPart)
            body.Velocity = Vector3.new(0, 50, 0)
            body.MaxForce = Vector3.new(999999, 999999, 999999)
            while isFlying do
                task.wait()
            end
            body:Destroy()
        end)
    else
        isFlying = false
    end
end)

-- Mostrar painel ao clicar na logo
LogoButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible -- Alterna a visibilidade do painel
end)

-- Função para exibir a logo no painel
LogoButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
