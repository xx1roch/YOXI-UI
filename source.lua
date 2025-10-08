-- YOXI-UI Library v1.5 (универсальная для Roblox, включая PlayStation)
-- Автор: xx1roch | GitHub: https://github.com/xx1roch/YOXI-UI

local YOXILibrary = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = (function()
    local success, service = pcall(function() return game:GetService("HttpService") end)
    return success and service or nil
end)()

-- Тема по умолчанию (локальная, без загрузки через HTTP)
local Themes = {
    Custom = {
        Bg = Color3.fromRGB(28, 37, 38),    -- Черный
        DarkGray = Color3.fromRGB(47, 47, 47), -- Темно-серый
        Gray = Color3.fromRGB(74, 74, 74),  -- Серый
        LightGray = Color3.fromRGB(127, 127, 127), -- Светло-серый
        Text = Color3.fromRGB(255, 255, 255) -- Белый
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
        warn("Не удалось создать ScreenGui: " .. (err or "неизвестная ошибка"))
        ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "YOXI-UI"
        ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    end
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

    -- Отсек 3: Логотип и лейбл
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1, 0, 0, 40)
    Header.BackgroundColor3 = CurrentTheme.DarkGray
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
    TitleLabel.Text = title or "YOXI UI"
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

    -- Отсек 1: Вкладки
    local TabList = Instance.new("ScrollingFrame")
    TabList.Size = UDim2.new(0, 150, 1, -40)
    TabList.Position = UDim2.new(0, 0, 0, 40)
    TabList.BackgroundColor3 = CurrentTheme.DarkGray
    TabList.BackgroundTransparency = 0.5
    TabList.Parent = MainFrame
    local TabListCorner = Instance.new("UICorner")
    TabListCorner.CornerRadius = UDim.new(0, 10)
    TabListCorner.Parent = TabList
    TabList.CanvasSize = UDim2.new(0, 0, 0, 0)

    -- Отсек 2: Функции
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, -150, 1, -40)
    ContentFrame.Position = UDim2.new(0, 150, 0, 40)
    ContentFrame.BackgroundColor3 = CurrentTheme.Gray
    ContentFrame.Parent = MainFrame
    local ContentCorner = Instance.new("UICorner")
    ContentCorner.CornerRadius = UDim.new(0, 10)
    ContentCorner.Parent = ContentFrame

    local Tabs = {}
    local function CreateFixedTabs()
        local tabNames = {"Main", "Settings", "Info"}
        for _, name in pairs(tabNames) do
            local TabButton = Instance.new("TextButton")
            TabButton.Size = UDim2.new(1, -10, 0, 40)
            TabButton.Position = UDim2.new(0, 5, 0, (#Tabs * 40))
            TabButton.Text = name
            TabButton.BackgroundColor3 = CurrentTheme.DarkGray
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
                local tween = TweenService:Create(TabButton, TweenInfo.new(0.2), {BackgroundColor3 = CurrentTheme.LightGray})
                tween:Play()
                for _, btn in pairs(TabList:GetChildren()) do
                    if btn ~= TabButton and btn:IsA("TextButton") then
                        local tween2 = TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = CurrentTheme.DarkGray})
                        tween2:Play()
                    end
                end
            end)

            local Sections = {}
            function Tab:NewSection(title)
                local Section = {}
                local SectionFrame = Instance.new("Frame")
                SectionFrame.Size = UDim2.new(1, -10, 0, 50)
                SectionFrame.BackgroundColor3 = CurrentTheme.Gray
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
                    Toggle.BackgroundColor3 = default and CurrentTheme.LightGray or CurrentTheme.Gray
                    Toggle.TextColor3 = CurrentTheme.Text
                    Toggle.Parent = SectionFrame
                    local ToggleCorner = Instance.new("UICorner")
                    ToggleCorner.CornerRadius = UDim.new(0, 5)
                    ToggleCorner.Parent = Toggle
                    local state = default
                    local Indicator = Instance.new("Frame")
                    Indicator.Size = UDim2.new(0, 20, 0, 20)
                    Indicator.Position = UDim2.new(1, -30, 0, 5)
                    Indicator.BackgroundColor3 = state and CurrentTheme.LightGray or CurrentTheme.Gray
                    Indicator.Parent = Toggle
                    local IndicatorCorner = Instance.new("UICorner")
                    IndicatorCorner.CornerRadius = UDim.new(0, 5)
                    IndicatorCorner.Parent = Indicator
                    Toggle.MouseButton1Click:Connect(function()
                        state = not state
                        local tween = TweenService:Create(Indicator, TweenInfo.new(0.2), {BackgroundColor3 = state and CurrentTheme.LightGray or CurrentTheme.Gray})
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
                    Button.BackgroundColor3 = CurrentTheme.LightGray
                    Button.TextColor3 = CurrentTheme.Text
                    Button.Parent = SectionFrame
                    local ButtonCorner = Instance.new("UICorner")
                    ButtonCorner.CornerRadius = UDim.new(0, 5)
                    ButtonCorner.Parent = Button
                    Button.MouseButton1Click:Connect(function()
                        local tween = TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = CurrentTheme.LightGray:Lerp(Color3.new(0.5, 0.5, 0.5), 0.5)})
                        tween:Play()
                        tween.Completed:Wait()
                        tween = TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = CurrentTheme.LightGray})
                        tween:Play()
                        if callback then callback() end
                    end)
                    return Button
                end

                table.insert(Sections, SectionFrame)
                TabFrame.Size = UDim2.new(1, -10, 0, #Sections * 60 + 70)
                return Section
            end

            table.insert(Tabs, TabFrame)
            TabList.CanvasSize = UDim2.new(0, 0, 0, #Tabs * 40)
            return Tab
        end
    end
    CreateFixedTabs()

    -- Анимация открытия/сворачивания
    local function AnimateWindow(show)
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

    -- Плавное перемещение
    local dragging, dragStart, startPos
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and not Header:FindFirstChildWhichIsA("TextButton"):IsDescendantOf(input.Target) then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    MainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStart
            local tween = TweenService:Create(MainFrame, TweenInfo.new(0.1), {Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)})
            tween:Play()
        end
    end)

    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == keybind then
            AnimateWindow(not MainFrame.Visible)
            print("Keybind pressed:", keybind.Name)
        end
    end)

    return Window
end

-- Notification с анимацией
function YOXILibrary.Notification(title, desc, duration)
    local ScreenGui = CreateGUI()
    local Notif = Instance.new("Frame")
    Notif.Size = UDim2.new(0, 300, 0, 100)
    Notif.Position = UDim2.new(0, 10, 0, -100)
    Notif.BackgroundColor3 = CurrentTheme.DarkGray
    Notif.Parent = ScreenGui
    local NotifCorner = Instance.new("UICorner")
    NotifCorner.CornerRadius = UDim.new(0, 10)
    NotifCorner.Parent = Notif

    local Title = Instance.new("TextLabel")
    Title.Text = title
    Title.Size = UDim2.new(1, -10, 0, 20)
    Title.Position = UDim2.new(0, 5, 0, 5)
    Title.TextColor3 = CurrentTheme.Text
    Title.Parent = Notif

    local Description = Instance.new("TextLabel")
    Description.Text = desc
    Description.Size = UDim2.new(1, -10, 0, 70)
    Description.Position = UDim2.new(0, 5, 0, 30)
    Description.TextColor3 = CurrentTheme.LightGray
    Description.TextWrapped = true
    Description.Parent = Notif

    local tweenIn = TweenService:Create(Notif, TweenInfo.new(0.3), {Position = UDim2.new(0, 10, 0, 10)})
    tweenIn:Play()
    game:GetService("Debris"):AddItem(Notif, duration or 3)
    tweenIn.Completed:Wait()
    local tweenOut = TweenService:Create(Notif, TweenInfo.new(0.3), {Position = UDim2.new(0, 10, 0, -100)})
    delay(duration or 3, function() tweenOut:Play() end)
end

-- Смена темы (без HTTP)
function YOXILibrary.SetTheme(themeName)
    CurrentTheme = Themes[themeName] or Themes.Custom
    print("Theme changed to:", themeName)
end

return YOXILibrary
