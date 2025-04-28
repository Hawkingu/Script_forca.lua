-- Painel Principal
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TopBar = Instance.new("TextButton")
local ContentFrame = Instance.new("Frame")

-- Configurações do ScreenGui
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "HawkHubUI"

-- Configurações do MainFrame
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.5, -200, 0.1, 0)
MainFrame.Size = UDim2.new(0, 400, 0, 50)
MainFrame.ClipsDescendants = true
MainFrame.BorderSizePixel = 0

-- Configurações da TopBar (Barra superior)
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.Font = Enum.Font.GothamBold
TopBar.Text = "HAWKHUB [-]"
TopBar.TextColor3 = Color3.fromRGB(255, 255, 255)
TopBar.TextSize = 24
TopBar.BorderSizePixel = 0

-- Configurações do ContentFrame (conteúdo que será escondido)
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ContentFrame.Position = UDim2.new(0, 0, 0, 50)
ContentFrame.Size = UDim2.new(1, 0, 0, 400)
ContentFrame.BorderSizePixel = 0

-- Exemplo de botão dentro do painel
local function CreateButton(name, posY)
    local Button = Instance.new("TextButton")
    Button.Name = name
    Button.Parent = ContentFrame
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Button.Position = UDim2.new(0.05, 0, 0, posY)
    Button.Size = UDim2.new(0.9, 0, 0, 40)
    Button.Font = Enum.Font.Gotham
    Button.Text = name
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 20
    Button.BorderSizePixel = 0
    Button.AutoButtonColor = true
    return Button
end

-- Criar alguns botões de exemplo
CreateButton("Reset Por Click", 10)
CreateButton("Auto PushUp", 60)
CreateButton("Auto Stamina", 110)
CreateButton("Auto Stamina2", 160)
CreateButton("Auto Dumbell", 210)

-- Estado do painel
local minimized = false

-- Função de minimizar/maximizar
TopBar.MouseButton1Click:Connect(function()
    if minimized then
        -- Maximizar
        MainFrame:TweenSize(UDim2.new(0, 400, 0, 450), "Out", "Quart", 0.5, true)
        TopBar.Text = "HAWKHUB [-]"
        minimized = false
    else
        -- Minimizar
        MainFrame:TweenSize(UDim2.new(0, 200, 0, 50), "Out", "Quart", 0.5, true)
        TopBar.Text = "HAWKHUB [+]"
        minimized = true
    end
end)
