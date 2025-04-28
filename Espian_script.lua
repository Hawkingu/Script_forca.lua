-- Espião de RemoteEvents/RemoteFunctions (100% funcionando)

local player = game:GetService("Players").LocalPlayer

-- Hook para RemoteEvent:FireServer
local oldFireServer
oldFireServer = hookfunction(Instance.new("RemoteEvent").FireServer, function(self, ...)
    print("---- RemoteEvent Detectado ----")
    print("Nome:", self.Name)
    print("Caminho:", self:GetFullName())
    print("Argumentos:", ...)
    print("-------------------------------")
    return oldFireServer(self, ...)
end)

-- Hook para RemoteFunction:InvokeServer
local oldInvokeServer
oldInvokeServer = hookfunction(Instance.new("RemoteFunction").InvokeServer, function(self, ...)
    print("---- RemoteFunction Detectado ----")
    print("Nome:", self.Name)
    print("Caminho:", self:GetFullName())
    print("Argumentos:", ...)
    print("----------------------------------")
    return oldInvokeServer(self, ...)
end)

print(">> Espião de RemoteEvent/RemoteFunction ativado! Agora ataque com a Katana e veja o Console (F9)!")
