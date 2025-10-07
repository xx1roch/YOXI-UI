local YOXI = loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/xx1roch/YOXI-UI/main/source.lua'))()

local Win = YOXI.new(true, "Продвинутый GUI", "Тест 2", Enum.KeyCode.RightControl)
local Tab = Win:NewTab("Настройки", "", "rbxassetid://4483345998")
local Sec = Tab:NewSection("Дополнительно", "")

Sec:NewButton("Супер Сила", function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100 end)
YOXI.Notification("Продвинутый режим!", "Загружен", 3)
