-- Rodado depois que todos os módulos carregam (copiado por patches/apply.py).
-- Tira da tela o que não serve para este servidor 8.60.

local function unloadModule(name)
    local module = g_modules.getModule(name)
    if module and module:isLoaded() then
        module:unload()
    end
end

-- Painel inferior da tela de login (criatura "boosted", agenda de eventos):
-- depende de um webservice que este servidor não tem e só mostra um aviso.
unloadModule('client_bottommenu')

-- O 8.60 não tem loja dentro do jogo.
local function hideStoreButton()
    local button = rootWidget:recursiveGetChildById('Store shop')
    if button then
        button:hide()
    end
end
hideStoreButton()
connect(g_game, { onGameStart = function() addEvent(hideStoreButton) end })

if g_platform.isMobile() then
    -- Janela do bot: ocupa um quarto da tela do celular.
    unloadModule('game_bot')
end

print 'Startup done :]'
