-- Serviços
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = game.Players.LocalPlayer

-- Configuração universal
local LoopsConfig = {
    {
        Name = "Stamina",
        Event = ReplicatedStorage:WaitForChild("AddStaminaEvent"),
        Args = nil, -- sem argumentos
        Interval = 0.5
    },
    {
        Name = "Vida",
        Event = ReplicatedStorage:WaitForChild("Lutero"),
        Args = {
            [1] = "GiveHealthCuzPro",
            [2] = 1,
            [3] = 1
        },
        Interval = 0.5
    }
}

-- Controle
local running = false
local activeLoops = {}

-- Criando GUI
local ScreenGui = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
ScreenGui.Name = "HExecuteGui"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 220, 0, 150)
Frame.Position = UDim2.new(0.1, 0, 0.1, 0)
Frame.BackgroundColor3 = Color3.new(0, 0, 0)
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0.3, 0)
Title.Text = "HExecute"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextScaled = true

local ActivateBtn = Instance.new("TextButton", Frame)
ActivateBtn.Size = UDim2.new(0.5, -5, 0.4, -10)
ActivateBtn.Position = UDim2.new(0, 5, 0.6, 5)
ActivateBtn.BackgroundColor3 = Color3.new(0, 0.5, 0)
ActivateBtn.Text = "✅"
ActivateBtn.TextScaled = true
ActivateBtn.TextColor3 = Color3.new(1,1,1)

local StopBtn = Instance.new("TextButton", Frame)
StopBtn.Size = UDim2.new(0.5, -5, 0.4, -10)
StopBtn.Position = UDim2.new(0.5, 0, 0.6, 5)
StopBtn.BackgroundColor3 = Color3.new(0.5, 0, 0)
StopBtn.Text = "❎"
StopBtn.TextScaled = true
StopBtn.TextColor3 = Color3.new(1,1,1)

-- Função para iniciar loops
local function startLoops()
    if running then return end
    running = true
    
    for _, cfg in ipairs(LoopsConfig) do
        activeLoops[cfg.Name] = task.spawn(function()
            while running do
                if cfg.Args then
                    cfg.Event:FireServer(unpack(cfg.Args))
                else
                    cfg.Event:FireServer()
                end
                task.wait(cfg.Interval)
            end
        end)
    end
end

-- Função para parar loops
local function stopLoops()
    running = false
end

-- Conectando botões
ActivateBtn.MouseButton1Click:Connect(startLoops)
StopBtn.MouseButton1Click:Connect(stopLoops)
