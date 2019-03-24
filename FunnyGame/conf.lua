
function love.conf(t)
    t.window.width = 640
    t.window.height = 360
    t.window.display = 2
    t.window.title = "MCF Stud'Games"      
    t.window.width = 800                
    t.window.height = 500  
    t.window.borderless = false         -- Remove all border visuals from the window (boolean)
    t.window.resizable = false          -- Let the window be user-resizable (boolean)
    t.window.minwidth = 1               -- Minimum window width if the window is resizable (number)
    t.window.minheight = 1              -- Minimum window height if the window is resizable (number)
    t.window.fullscreen = false         -- Enable fullscreen (boolean)
    t.window.fullscreentype = "desktop"     t.window.icon = nil                 -- Filepath to an image to use as the window's icon (string)    
end