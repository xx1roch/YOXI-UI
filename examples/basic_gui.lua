local YOXI = loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/xx1roch/YOXI-UI/main/source.lua'))()

local Win = YOXI.new(true, "Arise Blade Ball Premium", "Тест", Enum.KeyCode.RightShift, "rbxassetid://6031090997")
local Tab1 = Win:NewTab("Arise", "", "rbxassetid://6031090997")
local Sec1 = Tab1:NewSection("Auto Parry", "")

Sec1:NewToggle("Toggle", false, function(state) print("Auto Parry:", state) end) -- Тест
Sec1:NewSlider("Accuracy Threshold", 0, 99, 99, function(value) print("Accuracy:", value) end) -- Тест
Sec1:NewButton("Test Button", function() print("Button clicked!") end) -- Тест
Sec1:NewColorPicker("Color", Color3.new(0, 1, 0), function(color) print("Color:", color) end) -- Тест
Sec1:NewDropdown("Curve Camera", {"On", "Off"}, "Off", function(option) print("Curve:", option) end) -- Тест
local progress = Sec1:NewProgressBar("Lobby AP", 0, 100, 0, function(value) print("Progress:", value) end) -- Тест
wait(1)
progress:SetValue(50)
wait(1)
progress:SetValue(100)

local Tab2 = Win:NewTab("Auto Spam", "", "rbxassetid://6031090997")
local Sec2 = Tab2:NewSection("Settings", "")
Sec2:NewToggle("Toggle", false, function(state) print("Auto Spam:", state) end) -- Тест
Sec2:NewSlider("Spam speed", 0, 100, 26, function(value) print("Speed:", value) end) -- Тест

YOXI.Notification("Готово!", "GUI загружен", 2)
YOXI.LoadTheme("dark")
