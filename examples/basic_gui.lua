-- Лоадер
local YOXI = loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/xx1roch/YOXI-UI/main/source.lua'))()
if not YOXI then
    warn("Не удалось загрузить YOXI-UI. Используй локальный код или проверь репозиторий.")
    return
end

-- Создание окна
local Win = YOXI.new(true, "Arise Blade Ball Premium", "Тест", Enum.KeyCode.RightControl, "rbxassetid://6031090997")
local Tab1 = Win:NewTab("Arise", "", "rbxassetid://6031090997")
local Sec1 = Tab1:NewSection("Auto Parry", "")

-- Toggle с сохранением состояния
local toggle = Sec1:NewToggle("Toggle", false, function(state)
    print("Auto Parry:", state)
end)
toggle.Name = "Toggle1"
local toggleState = Instance.new("BoolValue")
toggleState.Name = "ToggleState"
toggleState.Value = false
toggleState.Parent = toggle

-- Slider с сохранением состояния
local slider = Sec1:NewSlider("Accuracy Threshold", 0, 99, 99, function(value)
    print("Accuracy:", value)
end)
slider.Name = "Slider1"
local sliderValue = Instance.new("IntValue")
sliderValue.Name = "SliderValue"
sliderValue.Value = 99
sliderValue.Parent = slider
local sliderMax = Instance.new("IntValue")
sliderMax.Name = "SliderMax"
sliderMax.Value = 99
sliderMax.Parent = slider

-- Button
Sec1:NewButton("Test Button", function()
    print("Button clicked!")
end)

-- ColorPicker
Sec1:NewColorPicker("Color", Color3.new(0, 1, 0), function(color)
    print("Color:", color)
end)

-- Dropdown
Sec1:NewDropdown("Curve Camera", {"On", "Off"}, "Off", function(option)
    print("Curve:", option)
end)

-- ProgressBar
local progress = Sec1:NewProgressBar("Lobby AP", 0, 100, 0, function(value)
    print("Progress:", value)
end)
progress.Name = "Progress1"
local progressValue = Instance.new("IntValue")
progressValue.Name = "ProgressValue"
progressValue.Value = 0
progressValue.Parent = progress
local progressMax = Instance.new("IntValue")
progressMax.Name = "ProgressMax"
progressMax.Value = 100
progressMax.Parent = progress

-- Keybind
Sec1:NewKeybind("Keybind", Enum.KeyCode.RightControl, function(key)
    print("New Keybind:", key.Name)
end)

-- Config Buttons
Sec1:NewConfigButton(function()
    print("Config saved")
end, function()
    print("Config loaded")
end)

-- Тест ProgressBar
wait(1)
progress:SetValue(50)
wait(1)
progress:SetValue(100)

-- Вторая вкладка
local Tab2 = Win:NewTab("Auto Spam", "", "rbxassetid://6031090997")
local Sec2 = Tab2:NewSection("Settings", "")

local toggle2 = Sec2:NewToggle("Toggle", false, function(state)
    print("Auto Spam:", state)
end)
toggle2.Name = "Toggle2"
local toggleState2 = Instance.new("BoolValue")
toggleState2.Name = "ToggleState"
toggleState2.Value = false
toggleState2.Parent = toggle2

local slider2 = Sec2:NewSlider("Spam speed", 0, 100, 26, function(value)
    print("Speed:", value)
end)
slider2.Name = "Slider2"
local sliderValue2 = Instance.new("IntValue")
sliderValue2.Name = "SliderValue"
sliderValue2.Value = 26
sliderValue2.Parent = slider2
local sliderMax2 = Instance.new("IntValue")
sliderMax2.Name = "SliderMax"
sliderMax2.Value = 100
sliderMax2.Parent = slider2

-- Уведомление и тема
YOXI.Notification("Готово!", "GUI загружен", 2)
YOXI.LoadTheme("dark")
