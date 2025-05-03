local atacando = false
criarBotao("Atacar o Attack com Hand", 410, function()
	atacando = not atacando
	if atacando then
		spawn(function()
			while atacando do
				pcall(function()
					local rs = game:GetService("ReplicatedStorage")
					local attack = rs:FindFirstChild("Remotes"):FindFirstChild("Attack")
					local handkick = rs:FindFirstChild("Remotes"):FindFirstChild("HandKick")
					if attack and handkick then
						handkick:FireServer()
						attack:FireServer()
					end
				end)
				task.wait(1)
			end
		end)
	else
		warn("Ataque parado.")
	end
end)
