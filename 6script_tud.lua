-- Painel de Fundo
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Section1 = Instance.new("TextLabel")
local Section2 = Instance.new("TextLabel")
local Button1 = Instance.new("TextButton")
local Button2 = Instance.new("TextButton")
local Button3 = Instance.new("TextButton")
local Button4 = Instance.new("TextButton")
local Button5 = Instance.new("TextButton")

-- Propriedades do ScreenGui
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Propriedades do MainFrame
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.2, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 400, 0, 450)
MainFrame.BackgroundTransparency = 0
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.AnchorPoint = Vector2.new(0.5, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.1, 0)
MainFrame:TweenSize(UDim2.new(0, 400, 0, 450), "Out", "Quart", 0.5, true)

-- Propriedades do Título
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Font = Enum.Font.GothamBold
Title.Text = "HAWKHUB" -- AQUI EU TROQUEI
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 26
Title.BorderSizePixel = 0

-- Primeira seção
Section1.Name = "Section1"
Section1.Parent = MainFrame
Section1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Section1.Position = UDim2.new(0, 0, 0, 60)
Section1.Size = UDim2.new(1, 0, 0, 20)
Section1.Font = Enum.Font.Gotham
Section1.Text = "Menu Exclusivo"
Section1.TextColor3 = Color3.fromRGB(255, 255, 255)
Section1.TextSize = 18
Section1.BorderSizePixel = 0

-- Segunda seção
Section2.Name = "Section2"
Section2.Parent = MainFrame
Section2.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Section2.Position = UDim2.new(0, 0, 0, 90)
Section2.Size = UDim2.new(1, 0, 0, 20)
Section2.Font = Enum.Font.Gotham
Section2.Text = "Auto-Farm"
Section2.TextColor3 = Color3.fromRGB(255, 255, 255)
Section2.TextSize = 18
Section2.BorderSizePixel = 0

-- Função para criar botão
local function CreateButton(name, posY)
    local Button = Instance.new("TextButton")
    Button.Name = name
    Button.Parent = MainFrame
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

-- Criar Botões
CreateButton("Reset Por Click", 130)
CreateButton("Auto PushUp", 180)
CreateButton("Auto Stamina", 230)
CreateButton("Auto Stamina2", 280)
CreateButton("Auto Dumbell", 330)
