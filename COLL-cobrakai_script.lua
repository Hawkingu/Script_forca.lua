-- Script para tentar reutilizar um código já usado no RoKarate (Cobra Kai)
-- Pode não funcionar dependendo da proteção do servidor

function getNil(name, class)
    for _, v in pairs(getnilinstances()) do
        if v.ClassName == class and v.Name == name then
            return v
        end
    end
end

local args = {
    [1] = {
        ["Received"] = 7,
        ["Loader"] = getNil("ClientMover", "LocalScript"),
        ["Mode"] = "Fire",
        ["Sent"] = 10,
        ["Module"] = getNil("Client", "ModuleScript")
    },
    [2] = "p\\^UVD'^H\7\n", -- Esse provavelmente é o código em formato ofuscado ou encriptado
    [3] = {
        ["Received"] = 7,
        ["Sent"] = 9
    },
    [4] = "e185e03f-e547-41fb-a34e-3f13d2d0d2e7" -- Pode ser ID de código ou autenticação
}

-- Envia o RemoteEvent diretamente, tentando aplicar o efeito do código novamente
game:GetService("ReplicatedStorage"):FindFirstChild("71179dab-efc8-4ed0-96a6-85143f112072"):FireServer(unpack(args))
