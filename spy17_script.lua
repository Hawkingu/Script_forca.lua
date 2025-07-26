-- 📡 Safe Mobile Remote Spy para KRNL (sem kick)
-- Detecta FireServer sendo usado com print simples

local ReplicatedStorage = game:GetService("ReplicatedStorage")

for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
    if obj:IsA("RemoteEvent") then
        local name = obj.Name
        obj.OnClientEvent:Connect(function(...)
            print("📩 [RECEBIDO] "..name, ...)
        end)
        task.spawn(function()
            local old = obj.FireServer
            obj.FireServer = function(self, ...)
                print("📤 [ENVIADO] "..name, ...)
                return old(self, ...)
            end
        end)
    end
end

print("✅ Spy discreto iniciado! Use saco de pancada ou halter pra capturar o Remote.")
