local remote = game:GetService("ReplicatedStorage"):FindFirstChild("3b4a39d2-1f07-4686-bdef-5237cc94e17b")

local function getNil(name,class)
    for _,v in pairs(getnilinstances()) do
        if v.ClassName==class and v.Name==name then
            return v
        end
    end
end

-- Loop infinito que ativa o Dumbbell automaticamente
while true do
    local args = {
        [1] = {
            ["Received"] = 28,
            ["Loader"] = getNil("", "Folder").ClientMover,
            ["Mode"] = "Fire",
            ["Sent"] = 99,
            ["Module"] = getNil("Client", "ModuleScript")
        },
        [2] = "'XX\4VFz\12HZ^",
        [3] = {
            ["Received"] = 28,
            ["Sent"] = 98
        },
        [4] = "ec78879b-f6b8-4006-b8a8-ee8aaa705995"
    }

    remote:FireServer(unpack(args))
    task.wait(0.1) -- o mais rápido que o servidor costuma aceitar
end
