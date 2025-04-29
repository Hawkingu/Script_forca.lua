local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Criar tela
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "PainelScript"
ScreenGui.ResetOnSpawn = false

-- Logo
local LogoButton = Instance.new("ImageButton", ScreenGui)
LogoButton.Size = UDim2.new(0, 50, 0, 50)
LogoButton.Position = UDim2.new(0, 10, 0, 10)
LogoButton.Image = "rbxassetid://17073223843"
LogoButton.Name = "LogoButton"

-- Painel Principal
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 280, 0, 350)
MainFrame.Position = UDim2.new(0, 80, 0, 80)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Visible = false

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 12)

-- Drag and Drop
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Abrir painel
LogoButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-------------------------------------------------
-- Botões principais
local buttons = {}
local scriptsByButton = {
    ["Farm"] = {
        {Nome = "Farmar Vida", Func = function()
            spawn(function()
                while true do
                    task.wait(0.5)
                    pcall(function()
                        game:GetService("ReplicatedStorage").Remotes.Branco:FireServer()
                    end)
                end
            end)
        end},

        {Nome = "Farmar Força", Func = function()
            spawn(function()
                while true do
                    task.wait(0.5)
                    pcall(function()
                        local dumbell = LocalPlayer.Character:FindFirstChild("Dumbell")
                        if dumbell and dumbell:FindFirstChild("Event") then
                            dumbell.Event:FireServer(1)
                        end
                    end)
                end
            end)
        end},

        {Nome = "Farmar Torneio", Func = function()
            spawn(function()
                while true do
                    task.wait(1)
                    pcall(function()
                        game:GetService("ReplicatedStorage").Remotes.EnterTournament:FireServer()
                        game:GetService("ReplicatedStorage").Remotes.StartTournament:FireServer()
                    end)
                end
            end)
        end}
    },

    ["Brincadeira"] = {
        {Nome = "Voar", Func = function()
            spawn(function()
                local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                local body = Instance.new("BodyVelocity", char.HumanoidRootPart)
                body.Velocity = Vector3.new(0, 50, 0)
                body.MaxForce = Vector3.new(999999, 999999, 999999)
                while true do
                    task.wait()
                end
            end)
        end},

        {Nome = "Atravessar paredes", Func = function()
            spawn(function()
                while true do
                    task.wait(0.5)
                    pcall(function()
                        local char = LocalPlayer.Character
                        for _,v in pairs(char:GetDescendants()) do
                            if v:IsA("BasePart") then
                                v.CanCollide = false
                            end
                        end
                    end)
                end
            end)
        end},

        {Nome = "Mudar Cor", Func = function()
            spawn(function()
                while true do
                    task.wait(0.5)
                    pcall(function()
                        local char = LocalPlayer.Character
                        for _,v in pairs(char:GetDescendants()) do
                            if v:IsA("BasePart") then
                                v.Color = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
                            end
                        end
                    end)
                end
            end)
        end},
    }
}

local function createMainButton(name, position)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0, 250, 0, 40)
    btn.Position = UDim2.new(0, 15, 0, position)
    btn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = name

    btn.MouseButton1Click:Connect(function()
        -- Apagar botões antigos
        for _, v in pairs(MainFrame:GetChildren()) do
            if v:IsA("TextButton") and v ~= btn then
                v:Destroy()
            end
        end
        -- Criar novos botões
        local options = scriptsByButton[name]
        if options then
            for i, info in ipairs(options) do
                local optBtn = Instance.new("TextButton", MainFrame)
                optBtn.Size = UDim2.new(0, 230, 0, 30)
                optBtn.Position = UDim2.new(0, 25, 0, 70 + (i*35))
                optBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
                optBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                optBtn.Text = info.Nome

                optBtn.MouseButton1Click:Connect(info.Func)
            end
        end
    end)

    table.insert(buttons, btn)
end

createMainButton("Farm", 10)
createMainButton("Brincadeira", 60)
