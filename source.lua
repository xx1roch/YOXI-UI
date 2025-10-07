
-- YOXI-UI Library v1.1 (расширение на базе NOTHING)
-- Автор: xx1roch | GitHub: https://github.com/xx1roch/YOXI-UI
-- Загрузка: loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/xx1roch/YOXI-UI/main/source.lua'))()

local YOXILibrary = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

-- Тема по умолчанию
local Themes = {
    Dark = { Bg = Color3.fromRGB(25, 25, 25), Accent = Color3.fromRGB(0, 162, 255), Text = Color3.fromRGB(255, 255, 255) },
    Light = { Bg = Color3.fromRGB(240, 240, 240), Accent = Color3.fromRGB(0, 120, 215), Text = Color3.fromRGB(0, 0, 0) }
}
local CurrentTheme = Themes.Dark

-- Создание ScreenGui
local function CreateGUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "YOXI-UI"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ResetOnSpawn = false
    return ScreenGui
end

-- Window
function YOXILibrary.new(destroyOnUnload, title, description, keybind, logo)
    local Window = {}
    local ScreenGui = CreateGUI()
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 500, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
    MainFrame.BackgroundColor3 = CurrentTheme.Bg
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, 0, 0, 40)
    TitleLabel.BackgroundColor3 = CurrentTheme.Accent
    TitleLabel.Text = title or "YOXI-UI"
    TitleLabel.TextColor3 = CurrentTheme.Text
    TitleLabel.TextScaled = true
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Parent = MainFrame

    local Tabs = {}
    function Window:NewTab(title, desc, icon)
        local Tab = {}
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(0, 100, 0, 30)
        TabButton.Text = title
        TabButton.BackgroundColor3 = CurrentTheme.Bg
        TabButton.TextColor3 = CurrentTheme.Text
        TabButton.Parent = MainFrame
        TabButton.Position = UDim2.new(0, 0, 0, 40)

        local TabFrame = Instance.new("ScrollingFrame")
        TabFrame.Size = UDim2.new(1, -110, 1, -70)
        TabFrame.Position = UDim2.new(0, 110, 0, 40)
        TabFrame.BackgroundTransparency = 1
        TabFrame.Parent = MainFrame
        TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

        local Sections = {}
        function Tab:NewSection(title, icon, position)
            local Section = {}
            local SectionFrame = Instance.new("Frame")
            SectionFrame.Size = UDim2.new(1, 0, 0, 50)
            SectionFrame.BackgroundTransparency = 1
            SectionFrame.Parent = TabFrame

            -- Toggle
            function Section:NewToggle(title, default, callback)
                local Toggle = Instance.new("TextButton")
                Toggle.Size = UDim2.new(1, 0, 0, 30)
                Toggle.Text = title .. ": " .. (default and "ON" or "OFF")
                Toggle.BackgroundColor3 = default and CurrentTheme.Accent or CurrentTheme.Bg
                Toggle.TextColor3 = CurrentTheme.Text
                Toggle.Parent = SectionFrame
                local state = default
                Toggle.MouseButton1Click:Connect(function()
                    state = not state
                    Toggle.Text = title .. ": " .. (state and "ON" or "OFF")
                    Toggle.BackgroundColor3 = state and CurrentTheme.Accent or CurrentTheme.Bg
                    if callback then callback(state) end
                end)
            end

            -- Button
            function Section:NewButton(title, callback)
                local Button = Instance.new("TextButton")
                Button.Size = UDim2.new(1, 0, 0, 30)
                Button.Text = title
                Button.BackgroundColor3 = CurrentTheme.Accent
                Button.TextColor3 = CurrentTheme.Text
                Button.Parent = SectionFrame
                Button.MouseButton1Click:Connect(callback or function() print("Button clicked!") end)
            end

            -- ColorPicker (улучшенный с Hue/Saturation)
            function Section:NewColorPicker(title, default, callback)
                local Picker = Instance.new("Frame")
                Picker.Size = UDim2.new(1, 0, 0, 100)
                Picker.BackgroundColor3 = CurrentTheme.Bg
                Picker.Parent = SectionFrame

                local Label = Instance.new("TextLabel")
                Label.Size = UDim2.new(1, 0, 0, 20)
                Label.Text = title .. ": " .. (default and default:ToHex() or "FFFFFF")
                Label.TextColor3 = CurrentTheme.Text
                Label.Parent = Picker

                local ColorFrame = Instance.new("ImageLabel")
                ColorFrame.Size = UDim2.new(1, -10, 0, 80)
                ColorFrame.Position = UDim2.new(0, 5, 0, 20)
                ColorFrame.BackgroundColor3 = default or Color3.new(1, 1, 1)
                ColorFrame.Image = "rbxassetid://4155801252" -- Градиент Hue/Saturation
                ColorFrame.Parent = Picker

                local PickerDot = Instance.new("Frame")
                PickerDot.Size = UDim2.new(0, 10, 0, 10)
                PickerDot.BackgroundColor3 = Color3.new(1, 1, 1)
                PickerDot.BorderSizePixel = 2
                PickerDot.Parent = ColorFrame
                local h, s, v = default and default:ToHSV() or {0, 1, 1}

                ColorFrame.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        local drag = true
                        while drag do
                            local mouse = UserInputService:GetMouseLocation()
                            local relative = ColorFrame:PointToLocal(mouse.X, mouse.Y)
                            local x = math.clamp(relative.X / ColorFrame.AbsoluteSize.X, 0, 1)
                            local y = math.clamp(relative.Y / ColorFrame.AbsoluteSize.Y, 0, 1)
                            s = 1 - y
                            h = x
                            local color = Color3.fromHSV(h, s, v)
                            ColorFrame.BackgroundColor3 = color
                            PickerDot.Position = UDim2.new(x, -5, y, -5)
                            Label.Text = title .. ": " .. color:ToHex()
                            if callback then callback(color) end
                            drag = input.UserInputState ~= Enum.UserInputState.End
                            game:GetService("RunService").Heartbeat:Wait()
                        end
                    end
                end)
            end

            -- Slider
            function Section:NewSlider(title, min, max, default, callback)
                local Slider = Instance.new("Frame")
                Slider.Size = UDim2.new(1, 0, 0, 40)
                Slider.BackgroundColor3 = CurrentTheme.Bg
                Slider.Parent = SectionFrame

                local Label = Instance.new("TextLabel")
                Label.Size = UDim2.new(1, 0, 0, 20)
                Label.Text = title .. ": " .. default
                Label.TextColor3 = CurrentTheme.Text
                Label.Parent = Slider

                local SliderBar = Instance.new("Frame")
                SliderBar.Size = UDim2.new(0.8, 0, 0, 10)
                SliderBar.Position = UDim2.new(0.1, 0, 0.5, 0)
                SliderBar.BackgroundColor3 = CurrentTheme.Accent
                SliderBar.Parent = Slider

                local value = default
                SliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        local drag = true
                        while drag do
                            local mouse = UserInputService:GetMouseLocation()
                            local relative = (mouse.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X
                            value = math.clamp(min + (max - min) * relative, min, max)
                            SliderBar.Size = UDim2.new(relative, 0, 0, 10)
                            Label.Text = title .. ": " .. math.floor(value)
                            if callback then callback(value) end
                            drag = input.UserInputState ~= Enum.UserInputState.End
                            game:GetService("RunService").Heartbeat:Wait()
                        end
                    end
                end)
            end

            -- Dropdown
            function Section:NewDropdown(title, options, default, callback)
                local Dropdown = Instance.new("Frame")
                Dropdown.Size = UDim2.new(1, 0, 0, 30)
                Dropdown.BackgroundColor3 = CurrentTheme.Bg
                Dropdown.Parent = SectionFrame

                local Label = Instance.new("TextLabel")
                Label.Size = UDim2.new(1, 0, 0, 30)
                Label.Text = title .. ": " .. (default or options[1])
                Label.TextColor3 = CurrentTheme.Text
                Label.Parent = Dropdown

                local isOpen = false
                local DropdownList = Instance.new("ScrollingFrame")
                DropdownList.Size = UDim2.new(1, 0, 0, 0)
                DropdownList.Position = UDim2.new(0, 0, 0, 30)
                DropdownList.BackgroundColor3 = CurrentTheme.Bg
                DropdownList.BackgroundTransparency = 0.5
                DropdownList.Parent = Dropdown
                DropdownList.CanvasSize = UDim2.new(0, 0, 0, #options * 30)

                for i, option in pairs(options) do
                    local OptionButton = Instance.new("TextButton")
                    OptionButton.Size = UDim2.new(1, 0, 0, 30)
                    OptionButton.Text = option
                    OptionButton.BackgroundColor3 = CurrentTheme.Bg
                    OptionButton.TextColor3 = CurrentTheme.Text
                    OptionButton.Parent = DropdownList
                    OptionButton.Position = UDim2.new(0, 0, 0, (i - 1) * 30)
                    OptionButton.MouseButton1Click:Connect(function()
                        Label.Text = title .. ": " .. option
                        DropdownList.Size = UDim2.new(1, 0, 0, 0)
                        isOpen = false
                        if callback then callback(option) end
                    end)
                end

                Label.MouseButton1Click:Connect(function()
                    isOpen = not isOpen
                    DropdownList.Size = UDim2.new(1, 0, 0, isOpen and #options * 30 or 0)
                end)
            end

            table.insert(Sections, SectionFrame)
            TabFrame.CanvasSize = UDim2.new(0, 0, 0, #Sections * 50)
            return Section
        end

        table.insert(Tabs, TabFrame)
        return Tab
    end

    local dragging = false
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            MainFrame.Position = MainFrame.Position + UDim2.new(0, input.Delta.X, 0, input.Delta.Y)
        end
    end)
    MainFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)

    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == keybind then
            MainFrame.Visible = not MainFrame.Visible
        end
    end)

    return Window
end

-- Notification
function YOXILibrary.Notification(title, desc, duration, icon)
    local ScreenGui = CreateGUI()
    local Notif = Instance.new("Frame")
    Notif.Size = UDim2.new(0, 300, 0, 100)
    Notif.Position = UDim2.new(0, 10, 0, 10)
    Notif.BackgroundColor3 = CurrentTheme.Bg
    Notif.Parent = ScreenGui

    local Title = Instance.new("TextLabel")
    Title.Text = title
    Title.Parent = Notif
    -- Добавь desc аналогично (упрощён для примера)

    game:GetService("Debris"):AddItem(Notif, duration or 3)
end

-- Смена темы
function YOXILibrary.SetTheme(themeName)
    CurrentTheme = Themes[themeName] or Themes.Dark
    print("Theme changed to:", themeName)
end

-- Загрузка темы из JSON
function YOXILibrary.LoadTheme(themeName)
    local success, result = pcall(function()
        return game:HttpGetAsync('https://raw.githubusercontent.com/xx1roch/YOXI-UI/main/themes/' .. themeName .. '.json')
    end)
    if success then
        local theme = HttpService:JSONDecode(result)
        CurrentTheme = {
            Bg = Color3.fromRGB(theme.Bg[1], theme.Bg[2], theme.Bg[3]),
            Accent = Color3.fromRGB(theme.Accent[1], theme.Accent[2], theme.Accent[3]),
            Text = Color3.fromRGB(theme.Text[1], theme.Text[2], theme.Text[3])
        }
        print("Загружена тема:", themeName)
    else
        warn("Ошибка загрузки темы:", result)
    end
end

return YOXILibrary
