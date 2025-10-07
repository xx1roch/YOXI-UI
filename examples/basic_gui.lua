local YOXI = loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/xx1roch/YOXI-UI/main/source.lua'))()

local Win = YOXI.new(true, "Библия GUI v1", "Тест", Enum.KeyCode.RightShift)
local Tab = Win:NewTab("Основное", "", "rbxassetid://4483345998")
local Sec = Tab:NewSection("Компоненты", "")

Sec:NewToggle("АвтоФарм", false, function(state) print("Фарм:", state) end)
Sec:NewButton("Телепорт", function() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0,50,0) end)
Sec:NewColorPicker("Цвет", Color3.new(1,0,0), function(color) print("Новый цвет:", color) end)
Sec:NewSlider("Скорость", 16, 100, 16, function(value) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value end)
Sec:NewDropdown("Оружие", {"Пистолет", "Ружьё", "Граната"}, "Пистолет", function(option) print("Выбрано:", option) end)

YOXI.Notification("Готово!", "GUI загружен", 2)
YOXI.LoadTheme("dark") -- Предполагается, что есть themes/dark.json
