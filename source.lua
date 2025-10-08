-- YOXI-UI Library v1.4 (локальная версия)
-- Автор: xx1roch | GitHub: https://github.com/xx1roch/YOXI-UI

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

-- Window с новым дизайном
function YOXILibrary.new(destroyOnUnload, title, description, keybind, logo)
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

    -- Логотип/название
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1, 0, 0, 40)
    Header.BackgroundColor3 = CurrentTheme.Accent
    Header.Parent = MainFrame
    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 10)
    HeaderCorner.Parent = Header

    local Logo = Instance.new("ImageLabel")
    Logo.Size = UDim2.new(0, 30, 0, 30)
    Logo.Position = UDim2.new(0, 5, 0, 5)
    Logo.Image = logo or "rbxassetid://6031090997"
    Logo.Parent = Header

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(0.9, 0, 1, 0)
    TitleLabel.Position = UDim2.new(0, 40, 0, 0)
    TitleLabel.Text = title or "YOXI-UI"
    TitleLabel.TextColor3 = CurrentTheme.Text
    TitleLabel.TextScaled = true
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Parent = Header

    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -35, 0, 5)
    CloseButton.Text = "X"
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    CloseButton.TextColor3 = CurrentTheme.Text
    CloseButton.Parent = Header
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 5)
    CloseCorner.Parent = CloseButton
    CloseButton.MouseButton1Click:Connect(function()
        AnimateWindow(false)
    end)

    -- Вкладки слева
    local TabList = Instance.new("ScrollingFrame")
    TabList.Size = UDim2.new(0, 150, 1, -40)
    TabList.Position = UDim2.new(0, 0, 0, 40)
    TabList.BackgroundColor3 = CurrentTheme.Bg
    TabList.BackgroundTransparency = 0.5
    TabList.Parent = MainFrame
    local TabListCorner = Instance.new("UICorner")
    TabListCorner.CornerRadius = UDim.new(0, 10)
    TabListCorner.Parent = TabList
    TabList.CanvasSize = UDim2.new(0, 0, 0, 0)

    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, -150, 1, -40)
    ContentFrame.Position = UDim2.new(0, 150, 0, 40)
    ContentFrame.BackgroundColor3 = CurrentTheme.Bg
    ContentFrame.Parent = MainFrame
    local ContentCorner = Instance.new("UICorner")
    ContentCorner.CornerRadius = UDim.new(0, 10)
    ContentCorner.Parent = ContentFrame

    local Tabs = {}
    function Window:NewTab(title, desc, icon)
        local Tab = {}
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(1, -10, 0, 40)
        TabButton.Position = UDim2.new(0, 5, 0, (#Tabs * 40))
        TabButton.Text = title
        TabButton.BackgroundColor3 = CurrentTheme.Bg
        TabButton.TextColor3 = CurrentTheme.Text
        TabButton.Parent = TabList
        local TabButtonCorner = Instance.new("UICorner")
        TabButtonCorner.CornerRadius = UDim.new(0, 5)
        TabButtonCorner.Parent = TabButton

        local TabFrame = Instance.new("Frame")
        TabFrame.Size = UDim2.new(1, -10, 1, -10)
        TabFrame.Position = UDim2.new(0, 5, 0, 5)
        TabFrame.BackgroundTransparency = 1
        TabFrame.Parent = ContentFrame
        local TabFrameCorner = Instance.new("UICorner")
        TabFrameCorner.CornerRadius = UDim.new(0, 10)
        TabFrameCorner.Parent = TabFrame

        if #Tabs == 0 then
            TabFrame.Visible = true
        else
            TabFrame.Visible = false
        end

        TabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(Tabs) do
                tab.Visible = false
            end
            TabFrame.Visible = true
            local tween = TweenService:Create(TabButton, TweenInfo.new(0.2), {BackgroundColor3 = CurrentTheme.Accent})
            tween:Play()
            for _, btn in pairs(TabList:GetChildren()) do
                if btn ~= TabButton and btn:IsA("TextButton") then
                    local tween2 = TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = CurrentTheme.Bg})
                    tween2:Play()
                end
            end
        end)

        local Sections = {}
        function Tab:NewSection(title, icon, position)
            local Section = {}
            local SectionFrame = Instance.new("Frame")
            SectionFrame.Size = UDim2.new(1, -10, 0, 50)
            SectionFrame.BackgroundColor3 = CurrentTheme.Bg
            SectionFrame.Parent = TabFrame
            local SectionCorner = Instance.new("UICorner")
            SectionCorner.CornerRadius = UDim.new(0, 5)
            SectionCorner.Parent = SectionFrame
            SectionFrame.Position = UDim2.new(0, 0, 0, (#Sections * 60))

            -- Toggle
            function Section:NewToggle(title, default, callback)
                local Toggle = Instance.new("TextButton")
                Toggle.Size = UDim2.new(1, -10, 0, 30)
                Toggle.Text = title
                Toggle.BackgroundColor3 = default and CurrentTheme.Accent or CurrentTheme.Bg
                Toggle.TextColor3 = CurrentTheme.Text
                Toggle.Parent = SectionFrame
                local ToggleCorner = Instance.new("UICorner")
                ToggleCorner.CornerRadius = UDim.new(0, 5)
                ToggleCorner.Parent = Toggle
                local state = default
                local Indicator = Instance.new("Frame")
                Indicator.Size = UDim2.new(0, 20, 0, 20)
                Indicator.Position = UDim2.new(1, -30, 0, 5)
                Indicator.BackgroundColor3 = state and CurrentTheme.Accent or CurrentTheme.Bg
                Indicator.Parent = Toggle
                local IndicatorCorner = Instance.new("UICorner")
                IndicatorCorner.CornerRadius = UDim.new(0, 5)
                IndicatorCorner.Parent = Indicator
                Toggle.MouseButton1Click:Connect(function()
                    state = not state
                    local tween = TweenService:Create(Indicator, TweenInfo.new(0.2), {BackgroundColor3 = state and CurrentTheme.Accent or CurrentTheme.Bg})
                    tween:Play()
                    if callback then callback(state) end
                end)
                return Toggle
            end

            -- Button
            function Section:NewButton(title, callback)
                local Button = Instance.new("TextButton")
                Button.Size = UDim2.new(1, -10, 0, 30)
                Button.Text = title
                Button.BackgroundColor3 = CurrentTheme.Accent
                Button.TextColor3 = CurrentTheme.Text
                Button.Parent = SectionFrame
                local ButtonCorner = Instance.new("UICorner")
                ButtonCorner.CornerRadius = UDim.new(0, 5)
                ButtonCorner.Parent = Button
                Button.MouseButton1Click:Connect(function()
                    local tween = TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = CurrentTheme.Accent:Lerp(Color3.new(0.5, 0.5, 0.5), 0.5)})
                    tween:Play()
                    tween.Completed:Wait()
                    tween = TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = CurrentTheme.Accent})
                    tween:Play()
                    if callback then callback() end
                end)
                return Button
            end

            -- ColorPicker
            function Section:NewColorPicker(title, default, callback)
                local Picker = Instance.new("Frame")
                Picker.Size = UDim2.new(1, -10, 0, 100)
                Picker.BackgroundColor3 = CurrentTheme.Bg
                Picker.Parent = SectionFrame
                local PickerCorner = Instance.new("UICorner")
                PickerCorner.CornerRadius = UDim.new(0, 5)
                PickerCorner.Parent = Picker

                local Label = Instance.new("TextLabel")
                Label.Size = UDim2.new(1, 0, 0, 20)
                Label.Text = title .. ": " .. (default and default:ToHex() or "FFFFFF")
                Label.TextColor3 = CurrentTheme.Text
                Label.Parent = Picker

                local ColorFrame = Instance.new("ImageLabel")
                ColorFrame.Size = UDim2.new(1, -10, 0, 80)
                ColorFrame.Position = UDim2.new(0, 5, 0, 20)
                ColorFrame.BackgroundColor3 = default or Color3.new(1, 1, 1)
                ColorFrame.Image = "rbxassetid://4155801252"
                ColorFrame.Parent = Picker
                local ColorFrameCorner = Instance.new("UICorner")
                ColorFrameCorner.CornerRadius = UDim.new(0, 5)
                ColorFrameCorner.Parent = ColorFrame

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
                            local tween = TweenService:Create(ColorFrame, TweenInfo.new(0.2), {BackgroundColor3 = color})
                            tween:Play()
                            PickerDot.Position = UDim2.new(x, -5, y, -5)
                            Label.Text = title .. ": " .. color:ToHex()
                            if callback then callback(color) end
                            drag = input.UserInputState ~= Enum.UserInputState.End
                            game:GetService("RunService").Heartbeat:Wait()
                        end
                    end
                end)
                return Picker
            end

            -- Slider
            function Section:NewSlider(title, min, max, default, callback)
                local Slider = Instance.new("Frame")
                Slider.Size = UDim2.new(1, -10, 0, 40)
                Slider.BackgroundColor3 = CurrentTheme.Bg
                Slider.Parent = SectionFrame
                local SliderCorner = Instance.new("UICorner")
                SliderCorner.CornerRadius = UDim.new(0, 5)
                SliderCorner.Parent = Slider

                local Label = Instance.new("TextLabel")
                Label.Size = UDim2.new(1, 0, 0, 20)
                Label.Text = title .. ": " .. default
                Label.TextColor3 = CurrentTheme.Text
                Label.Parent = Slider

                local SliderBar = Instance.new("Frame")
                SliderBar.Size = UDim2.new(0, 0, 0, 10)
                SliderBar.Position = UDim2.new(0, 0, 0.5, 0)
                SliderBar.BackgroundColor3 = CurrentTheme.Accent
                SliderBar.Parent = Slider
                local SliderBarCorner = Instance.new("UICorner")
                SliderBarCorner.CornerRadius = UDim.new(0, 5)
                SliderBarCorner.Parent = SliderBar

                local value = default
                local tween = TweenService:Create(SliderBar, TweenInfo.new(0.3), {Size = UDim2.new(default / max, 0, 0, 10)})
                tween:Play()
                Label.Text = title .. ": " .. default

                SliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        local drag = true
                        while drag do
                            local mouse = UserInputService:GetMouseLocation()
                            local relative = (mouse.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X
                            value = math.clamp(min + (max - min) * relative, min, max)
                            local newSize = UDim2.new(value / max, 0, 0, 10)
                            tween = TweenService:Create(SliderBar, TweenInfo.new(0.2), {Size = newSize})
                            tween:Play()
                            Label.Text = title .. ": " .. math.floor(value)
                            if callback then callback(value) end
                            drag = input.UserInputState ~= Enum.UserInputState.End
                            game:GetService("RunService").Heartbeat:Wait()
                        end
                    end
                end)
                return Slider
            end

            -- Dropdown
            function Section:NewDropdown(title, options, default, callback)
                local Dropdown = Instance.new("Frame")
                Dropdown.Size = UDim2.new(1, -10, 0, 30)
                Dropdown.BackgroundColor3 = CurrentTheme.Bg
                Dropdown.Parent = SectionFrame
                local DropdownCorner = Instance.new("UICorner")
                DropdownCorner.CornerRadius = UDim.new(0, 5)
                DropdownCorner.Parent = Dropdown

                local Label = Instance.new("TextButton")
                Label.Size = UDim2.new(1, 0, 0, 30)
                Label.Text = title .. ": " .. (default or options[1])
                Label.BackgroundColor3 = CurrentTheme.Bg
                Label.TextColor3 = CurrentTheme.Text
                Label.Parent = Dropdown
                local LabelCorner = Instance.new("UICorner")
                LabelCorner.CornerRadius = UDim.new(0, 5)
                LabelCorner.Parent = Label

                local isOpen = false
                local DropdownList = Instance.new("ScrollingFrame")
                DropdownList.Size = UDim2.new(1, 0, 0, 0)
                DropdownList.Position = UDim2.new(0, 0, 0, 30)
                DropdownList.BackgroundColor3 = CurrentTheme.Bg
                DropdownList.BackgroundTransparency = 0.5
                DropdownList.Parent = Dropdown
                DropdownList.CanvasSize = UDim2.new(0, 0, 0, #options * 30)
                local DropdownListCorner = Instance.new("UICorner")
                DropdownListCorner.CornerRadius = UDim.new(0, 5)
                DropdownListCorner.Parent = DropdownList

                for i, option in pairs(options) do
                    local OptionButton = Instance.new("TextButton")
                    OptionButton.Size = UDim2.new(1, -10, 0, 30)
                    OptionButton.Text = option
                    OptionButton.BackgroundColor3 = CurrentTheme.Bg
                    OptionButton.TextColor3 = CurrentTheme.Text
                    OptionButton.Parent = DropdownList
                    OptionButton.Position = UDim2.new(0, 5, 0, (i - 1) * 30)
                    local OptionButtonCorner = Instance.new("UICorner")
                    OptionButtonCorner.CornerRadius = UDim.new(0, 5)
                    OptionButtonCorner.Parent = OptionButton
                    OptionButton.MouseButton1Click:Connect(function()
                        Label.Text = title .. ": " .. option
                        local tween = TweenService:Create(DropdownList, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 0)})
                        tween:Play()
                        isOpen = false
                        if callback then callback(option) end
                    end)
                end

                Label.MouseButton1Click:Connect(function()
                    isOpen = not isOpen
                    local targetSize = isOpen and UDim2.new(1, 0, 0, #options * 30) or UDim2.new(1, 0, 0, 0)
                    local tween = TweenService:Create(DropdownList, TweenInfo.new(0.2), {Size = targetSize})
                    tween:Play()
                end)
                return Dropdown
            end

            -- Keybind
            function Section:NewKeybind(title, default, callback)
                local Keybind = Instance.new("Frame")
                Keybind.Size = UDim2.new(1, -10, 0, 30)
                Keybind.BackgroundColor3 = CurrentTheme.Bg
                Keybind.Parent = SectionFrame
                local KeybindCorner = Instance.new("UICorner")
                KeybindCorner.CornerRadius = UDim.new(0, 5)
                KeybindCorner.Parent = Keybind

                local Label = Instance.new("TextButton")
                Label.Size = UDim2.new(1, 0, 1, 0)
                Label.Text = title .. ": " .. (default.Name or "RightControl")
                Label.BackgroundColor3 = CurrentTheme.Bg
                Label.TextColor3 = CurrentTheme.Text
                Label.Parent = Keybind
                local LabelCorner = Instance.new("UICorner")
                LabelCorner.CornerRadius = UDim.new(0, 5)
                LabelCorner.Parent = Label

                local currentKey = default or Enum.KeyCode.RightControl
                Label.MouseButton1Click:Connect(function()
                    Label.Text = title .. ": [...]"
                    local inputwait = UserInputService.InputBegan:Wait()
                    if inputwait.KeyCode ~= Enum.KeyCode.Unknown then
                        currentKey = inputwait.KeyCode
                        Label.Text = title .. ": " .. currentKey.Name
                        if callback then callback(currentKey) end
                    end
                end)

                return Keybind
            end

            -- ProgressBar
            function Section:NewProgressBar(title, min, max, default, callback)
                local Progress = Instance.new("Frame")
                Progress.Size = UDim2.new(1, -10, 0, 40)
                Progress.BackgroundColor3 = CurrentTheme.Bg
                Progress.Parent = SectionFrame
                local ProgressCorner = Instance.new("UICorner")
                ProgressCorner.CornerRadius = UDim.new(0, 5)
                ProgressCorner.Parent = Progress

                local Label = Instance.new("TextLabel")
                Label.Size = UDim2.new(1, 0, 0, 20)
                Label.Text = title .. ": " .. math.floor((default / max) * 100) .. "%"
                Label.TextColor3 = CurrentTheme.Text
                Label.Parent = Progress

                local Bar = Instance.new("Frame")
                Bar.Size = UDim2.new(default / max, 0, 0, 10)
                Bar.Position = UDim2.new(0, 0, 0.5, 0)
                Bar.BackgroundColor3 = CurrentTheme.Accent
                Bar.Parent = Progress
                local BarCorner = Instance.new("UICorner")
                BarCorner.CornerRadius = UDim.new(0, 5)
                BarCorner.Parent = Bar

                local value = default
                function Progress:SetValue(newValue)
                    value = math.clamp(newValue, min, max)
                    local tween = TweenService:Create(Bar, TweenInfo.new(0.3), {Size = UDim2.new(value / max, 0, 0, 10)})
                    tween:Play()
                    Label.Text = title .. ": " .. math.floor((value / max) * 100) .. "%"
                    if callback then callback(value) end
                end

                return Progress
            end

            -- Config System
            function Section:NewConfigButton(saveCallback, loadCallback)
                local ConfigButton = Instance.new("TextButton")
                ConfigButton.Size = UDim2.new(1, -10, 0, 30)
                ConfigButton.Text = "Save Config"
                ConfigButton.BackgroundColor3 = CurrentTheme.Accent
                ConfigButton.TextColor3 = CurrentTheme.Text
                ConfigButton.Parent = SectionFrame
                local ConfigButtonCorner = Instance.new("UICorner")
                ConfigButtonCorner.CornerRadius = UDim.new(0, 5)
                ConfigButtonCorner.Parent = ConfigButton

                ConfigButton.MouseButton1Click:Connect(function()
                    local config = {}
                    for _, child in pairs(SectionFrame:GetChildren()) do
                        if child:IsA("Frame") or child:IsA("TextButton") then
                            if child:FindFirstChild("ToggleState") then
                                config[child.Name] = child:FindFirstChild("ToggleState").Value
                            elseif child:FindFirstChild("SliderValue") then
                                config[child.Name] = child:FindFirstChild("SliderValue").Value
                            elseif child:FindFirstChild("ColorValue") then
                                config[child.Name] = child:FindFirstChild("ColorValue").Value
                            elseif child:FindFirstChild("DropdownValue") then
                                config[child.Name] = child:FindFirstChild("DropdownValue").Value
                            elseif child:FindFirstChild("ProgressValue") then
                                config[child.Name] = child:FindFirstChild("ProgressValue").Value
                            end
                        end
                    end
                    local json = HttpService:JSONEncode(config)
                    if not isfolder("YOXI-Configs") then makefolder("YOXI-Configs") end
                    writefile("YOXI-Configs/config.json", json)
                    if saveCallback then saveCallback() end
                    YOXI.Notification("Success", "Config saved!", 2)
                end)

                local LoadButton = Instance.new("TextButton")
                LoadButton.Size = UDim2.new(1, -10, 0, 30)
                LoadButton.Position = UDim2.new(0, 0, 0, 40)
                LoadButton.Text = "Load Config"
                LoadButton.BackgroundColor3 = CurrentTheme.Accent
                LoadButton.TextColor3 = CurrentTheme.Text
                LoadButton.Parent = SectionFrame
                local LoadButtonCorner = Instance.new("UICorner")
                LoadButtonCorner.CornerRadius = UDim.new(0, 5)
                LoadButtonCorner.Parent = LoadButton

                LoadButton.MouseButton1Click:Connect(function()
                    if isfile("YOXI-Configs/config.json") then
                        local json = readfile("YOXI-Configs/config.json")
                        local config = HttpService:JSONDecode(json)
                        for name, value in pairs(config) do
                            local child = SectionFrame:FindFirstChild(name)
                            if child then
                                if child:FindFirstChild("ToggleState") then
                                    child:FindFirstChild("ToggleState").Value = value
                                    local toggle = child
                                    local state = value
                                    local tween = TweenService:Create(toggle:FindFirstChild("Indicator"), TweenInfo.new(0.2), {BackgroundColor3 = state and CurrentTheme.Accent or CurrentTheme.Bg})
                                    tween:Play()
                                elseif child:FindFirstChild("SliderValue") then
                                    child:FindFirstChild("SliderValue").Value = value
                                    local slider = child:FindFirstChild("SliderBar")
                                    local tween = TweenService:Create(slider, TweenInfo.new(0.2), {Size = UDim2.new(value / child:FindFirstChild("SliderMax").Value, 0, 0, 10)})
                                    tween:Play()
                                    child:FindFirstChild("Label").Text = child.Name .. ": " .. math.floor(value)
                                elseif child:FindFirstChild("ColorValue") then
                                    child:FindFirstChild("ColorValue").Value = value
                                    local colorFrame = child:FindFirstChild("ColorFrame")
                                    local tween = TweenService:Create(colorFrame, TweenInfo.new(0.2), {BackgroundColor3 = value})
                                    tween:Play()
                                    child:FindFirstChild("Label").Text = child.Name .. ": " .. value:ToHex()
                                elseif child:FindFirstChild("DropdownValue") then
                                    child:FindFirstChild("DropdownValue").Value = value
                                    child:FindFirstChild("Label").Text = child.Name .. ": " .. value
                                elseif child:FindFirstChild("ProgressValue") then
                                    child:FindFirstChild("ProgressValue").Value = value
                                    local bar = child:FindFirstChild("Bar")
                                    local tween = TweenService:Create(bar, TweenInfo.new(0.2), {Size = UDim2.new(value / child:FindFirstChild("ProgressMax").Value, 0, 0, 10)})
                                    tween:Play()
                                    child:FindFirstChild("Label").Text = child.Name .. ": " .. math.floor((value / child:FindFirstChild("ProgressMax").Value) * 100) .. "%"
                                end
                            end
                        end
                        if loadCallback then loadCallback() end
                        YOXI.Notification("Success", "Config loaded!", 2)
                    else
                        YOXI.Notification("Error", "No config found!", 2)
                    end
                end)
            end

            table.insert(Sections, SectionFrame)
            TabFrame.Size = UDim2.new(1, -10, 0, #Sections * 60 + 70)
            return Section
        end

        table.insert(Tabs, TabFrame)
        TabList.CanvasSize = UDim2.new(0, 0, 0, #Tabs * 40)
        return Tab
    end

    -- Анимация появления окна
    local function AnimateWindow(show)
        MainFrame.Visible = true
        local targetPos = show and UDim2.new(0.5, -300, 0.5, -200) or UDim2.new(0.5, -300, 1, 0)
        local tween = TweenService:Create(MainFrame, TweenInfo.new(0.3), {Position = targetPos})
        tween:Play()
        if not show then
            tween.Completed:Wait()
            MainFrame.Visible = false
        end
    end

    local dragging = false
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and not Header:FindFirstChildWhichIsA("TextButton"):IsDescendantOf(input.Target) then dragging = true end
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
            AnimateWindow(not MainFrame.Visible)
        end
    end)

    return Window
end

-- Notification
function YOXILibrary.Notification(title, desc, duration, icon)
    local ScreenGui = CreateGUI()
    local Notif = Instance.new("Frame")
    Notif.Size = UDim2.new(0, 300, 0, 100)
    Notif.Position = UDim2.new(0, 10, 0, -100)
    Notif.BackgroundColor3 = CurrentTheme.Bg
    Notif.Parent = ScreenGui
    local NotifCorner = Instance.new("UICorner")
    NotifCorner.CornerRadius = UDim.new(0, 10)
    NotifCorner.Parent = Notif

    local Title = Instance.new("TextLabel")
    Title.Text = title
    Title.Parent = Notif

    local tweenIn = TweenService:Create(Notif, TweenInfo.new(0.3), {Position = UDim2.new(0, 10, 0, 10)})
    tweenIn:Play()
    game:GetService("Debris"):AddItem(Notif, duration or 3)
    tweenIn.Completed:Wait()
    local tweenOut = TweenService:Create(Notif, TweenInfo.new(0.3), {Position = UDim2.new(0, 10, 0, -100)})
    delay(duration or 3, function() tweenOut:Play() end)
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
