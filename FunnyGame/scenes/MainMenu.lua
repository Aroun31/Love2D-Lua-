local Scene = require("lib.Scene")
local Button = require("lib.ui.Button")
local Label = require("lib.ui.Label")
local U = require("lib.Utils")
local TextField = require("lib.ui.TextField")
local Slider = require("lib.ui.Slider")
local Checkbox = require("lib.ui.Checkbox")
local Bar = require("lib.ui.Bar")
local infoEdit = "pwd"
local MM = Scene:derive("MainMenu")
local menutxt

function MM:new(scene_mgr)
    MM.super.new(self, scene_mgr)

    local sw = love.graphics.getWidth()
    local sh = love.graphics.getHeight()
    
    local mcf_button = Button(sw / 2, sh / 1.5 - 95, 140, 40, "MCF")
    local start_button = Button(sw / 2, sh / 1.5 - 30, 140, 40, "Start")
    local exit_button = Button(sw / 2, sh / 1.5 + 30, 140, 40, "Exit")
    start_button:colors({0, 0.8, 0, 255}, {0.8, 0.3, 0, 255}, {0, 0.5, 0.6, 255})
    exit_button:colors({0.9, 0, 0, 255}, {0.9, 0.1, 64, 255}, {0, 0.5, 0.6, 255})
    mcf_button:colors({0.8, 0.2, 0, 255}, {0.8, 0.6, 0, 255}, {0, 0.5, 0.6, 255})

    menutxt = Label(love.graphics.getWidth() + 20,sh / 6 - 20, love.graphics.getWidth(), 40, "Menu\nprincipal")


    self.tf = TextField(love.graphics.getWidth() / 2- 50,  sh / 1.5 - 150, 100, 40, infoEdit, U.gray(196), "left")

    copyRight = Label(love.graphics.getWidth() + 20,sh -40, love.graphics.getWidth(), 25, "by\nAroun Le BriCodeur") -- by\nAroun Le Bricodeur
    --self.slider = Slider(love.graphics.getWidth() / 2 - 100 , 125, 200, 40, "volume")
    --self.vslider = Slider(20, 40 , 40, 200, "test", true)
    --self.label = Label(425, 105, 250, 40, "0", U.gray(255), "left");
    --self.vlabel = Label(12, 20, 60, 40, "0", U.gray(255), "center");
    --self.cb = Checkbox(love.graphics.getWidth() / 2 - 100, 250, 200, 40, "Enable Music")

    --self.bar = Bar("health", love.graphics.getWidth() / 2, love.graphics.getHeight() - 40, 200, 40, "0%")

    self.em:add(mcf_button)
    self.em:add(start_button)
    self.em:add(exit_button)
    self.em:add(menutxt)
    self.em:add(copyRight)
    self.em:add(self.tf)
    --self.em:add(self.slider)
    --self.em:add(self.vslider)
    --self.em:add(self.label)
    --self.em:add(self.vlabel)
    --self.em:add(self.cb)
    --self.em:add(self.bar)

    self.click = function(btn) self:on_click(btn) end
    self.slider_changed = function(slider) self:on_slider_changed(slider) end
    self.checkbox_changed = function(checkbox, value) self:on_checkbox_changed(checkbox, value) end
    self.bar_changed = function(bar, value) self:on_bar_changed(bar, value) end
end

local entered = false
function MM:enter()
    Tween.create(menutxt.pos, "x", 0, 1, Tween.cubic_out)
    Tween.create(copyRight.pos, "x", 0, 1.8, Tween.cubic_out)
    MM.super.enter(self)   
    _G.events:hook("onBtnClick", self.click)
    _G.events:hook("onSliderChanged", self.slider_changed)
    _G.events:hook("onCheckboxClicked", self.checkbox_changed)
    _G.events:hook("onBarChanged", self.bar_changed)
end

function MM:exit()
    MM.super.exit(self)
    _G.events:unhook("onBtnClick", self.click)
    _G.events:unhook("onSliderChanged", self.slider_changed)
    _G.events:unhook("onCheckboxClicked", self.checkbox_changed)
    _G.events:unhook("onBarChanged", self.bar_changed)
end

function MM:on_checkbox_changed(checkbox, value)
    -- if checkbox.text == "Enable Music" then
        print(checkbox.text .." : " .. tostring(value))
    -- end
end

function MM:on_bar_changed(bar, value)
    bar.text = tostring(value .. "%")
    if value == 100 then
        bar.fill_color = U.color(0,255,0,255)
    end
end

function MM:on_slider_changed(slider)
    if slider.id == "volume" then
        self.label.text = slider:get_value()
    elseif slider.id == "test" then
        self.vlabel.text = slider:get_value()
    end
end

function MM:on_click(button)
    if button.text == "Start" then
        self.scene_mgr:switch("Test")
    elseif button.text == "Exit" then
        love.event.quit()
    elseif button.text == "MCF" then
      for k, v in ipairs(ListMDP) do
        if self.tf.text == v then
          self:updateTxt("gg")
          self.scene_mgr:switch("Test")
          break
        else
          self:updateTxt("noob")
          break
        end
      end
    end
end

function MM:updateTxt(str)
  self.tf.text = str
end

local prev_down = false
function MM:update(dt)
    self.super.update(self,dt)
    if Key:key_down("escape") then
        love.event.quit()
    elseif Key:key_down("e") then
        self.bar:set(self.bar.percentage + 5)
    elseif Key:key_down("q") then
        self.bar:set(self.bar.percentage - 5)
    -- elseif Key:key_down("space") then
    --     self.button:enable(not self.button.interactible)
    end

    --mouse stuff
    local mx,my = love.mouse.getPosition()
    local down = love.mouse.isDown(1)

    --if the mouse left btn was just clicked...
    if down and not prev_down then
        if U.point_in_rect({x=mx, y=my}, self.tf:get_rect()) then
            self.tf:set_focus(true)
        else
            self.tf:set_focus(false)
        end
    end

    prev_down = down
    
end

return MM
