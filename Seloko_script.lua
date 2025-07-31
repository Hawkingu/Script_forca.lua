local rs = game:GetService("ReplicatedStorage")
for i, v in pairs(rs:GetChildren()) do
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
        Text = tostring(i) .. " - " .. v.Name .. " (" .. v.ClassName .. ")"
    })
    wait(0.1)
end
