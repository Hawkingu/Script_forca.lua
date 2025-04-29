-- Script para adicionar +1 de vida ao personagem
local jogador = game.Players.LocalPlayer -- Pega o jogador local
local personagem = jogador.Character or jogador.CharacterAdded:Wait() -- Pega o personagem

-- Espera a 'Humanoid' estar carregada no personagem
local humanoide = personagem:WaitForChild("Humanoid")

-- Função para adicionar +1 de vida
local function adicionarVida()
    humanoide.Health = humanoide.Health + 1 -- Aumenta a vida em 1
end

-- Chama a função para adicionar vida
adicionarVida()
