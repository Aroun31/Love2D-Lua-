function love.load()
end

unction love.update(dt)
   -- Permet de déplacer la fenêtre sans répercution sur le jeu selon la vitesse de chaque PC
    if dt > 0.035 then return end
end


function love.draw()
    love.graphics.print("Hello World !\nAroun vous passe le bonjour !\nBon dev ;) ", 15, 15)
end
