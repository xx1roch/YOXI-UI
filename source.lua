-- YOXI-UI Library v1.5 (минимальная версия для диагностики)
-- Автор: xx1roch | GitHub: https://github.com/xx1roch/YOXI-UI

local YOXILibrary = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

print("YOXI Library initialized") -- Проверка загрузки модуля

-- Тема по умолчанию
local Themes = {
    Custom = {
        Bg = Color3.fromRGB(28, 37, 38),
        DarkGray = Color3.fromRGB(47, 47, 47),
        Gray = Color3.fromRGB(74, 74, 74),
        LightGray = Color3.fromRGB(127, 127, 127),
        Text = Color3.fromRGB(255, 255, 255)
    }
}
local CurrentTheme = Themes.Custom

-- Создание ScreenGui с проверкой
local function CreateGUI()
    local ScreenGui
    local success, err = pcall(function()
        ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "YOXI-UI"
        ScreenGui.Parent = game.CoreGui
        ScreenGui.ResetOnSpawn = false
    end)
    if not success then
        warn("CoreGui недоступен, использую PlayerGui: " .. (err or "неизвестная ошибка"))
        ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "YOXI-UI"
        ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    end
    print("ScreenGui создан, родитель: " .. tostring(ScreenGui.Parent))
    return ScreenGui
end

-- Window с новым дизайном
function YOXILibrary.new(destroyOnUnload, title, description, keybind, logo)
    print("Создание нового окна: " .. (title or "YOXI UI")) -- Отладка
    local Window = {}
    local ScreenGui = CreateGUI()
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 600, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    MainFrame.BackgroundColor3 = CurrentTheme.Bg
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = MainFrame
    MainFrame.Visible = false

    -- Простая анимация для теста
    local function AnimateWindow(show)
        print("Анимация окна: " .. tostring(show))
        MainFrame.Visible = true
        if show then
            MainFrame.Size = UDim2.new(0, 0, 0, 40)
            local tween = TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 600, 0, 400)})
            tween:Play()
        else
            local tween = TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 40)})
            tween:Play()
            tween.Completed:Wait()
            MainFrame.Visible = false
        end
    end

    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == keybind then
            print("Нажата клавиша: " .. tostring(keybind))
            AnimateWindow(not MainFrame.Visible)
        end
    end)

    return Window
end

-- Минимальная Notification
function YOXILibrary.Notification(title, desc, duration)
    print("Notification: " .. title .. " - " .. desc)
end

function YOXILibrary.SetTheme(themeName)
    CurrentTheme = Themes[themeName] or Themes.Custom
    print("Тема изменена на: " .. themeName)
end

return YOXILibrary
