print("LocalScript запущен через инжектор")

-- Проверка и загрузка с GitHub
local function loadFromGitHub()
    local success, HttpService = pcall(function() return game:GetService("HttpService") end)
    if success then
        local url = "https://raw.githubusercontent.com/xx1roch/YOXI-UI/main/source.lua" -- URL кода
        local success, response = pcall(function() return HttpService:GetAsync(url) end)
        if success then
            return response
        end
    end
    warn("Не удалось загрузить с GitHub, использую локальный код из Nothing UI")
    return nil
end

local yoxiCode = loadFromGitHub()
if not yoxiCode then
    yoxiCode = [[
        -- YOXI-UI Library v1.5 (копия Nothing UI с твоим лого)
        local NothingLibrary = {}
        local TweenService = game:GetService("TweenService")
        local UserInputService = game:GetService("UserInputService")
        local HttpService = game:GetService("HttpService")

        -- Тема в стиле Nothing UI
        local Themes = {
            Nothing = {
                Bg = Color3.fromRGB(26, 26, 26),
                Accent = Color3.fromRGB(46, 46, 46),
                DarkAccent = Color3.fromRGB(20, 20, 20),
                Text = Color3.fromRGB(200, 200, 200),
                Red = Color3.fromRGB(255, 50, 50)
            }
        }
        local CurrentTheme = Themes.Nothing

        -- Notification
        local Notification = {}
        function Notification.new(options)
            local frame = Instance.new("ScreenGui")
            frame.Parent = game.CoreGui
            local notif = Instance.new("Frame")
            notif.Size = UDim2.new(0, 300, 0, 100)
            notif.Position = UDim2.new(0.5, -150, 0, -120)
            notif.BackgroundColor3 = CurrentTheme.Accent
            notif.BorderSizePixel = 0
            notif.Parent = frame
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = notif

            local title = Instance.new("TextLabel")
            title.Size = UDim2.new(0.9, 0, 0, 30)
            title.Position = UDim2.new(0.05, 0, 0.1, 0)
            title.Text = options.Title or "Notification"
            title.TextColor3 = CurrentTheme.Text
            title.TextSize = 16
            title.Font = Enum.Font.SourceSansBold
            title.BackgroundTransparency = 1
            title.Parent = notif

            local desc = Instance.new("TextLabel")
            desc.Size = UDim2.new(0.9, 0, 0, 40)
            desc.Position = UDim2.new(0.05, 0, 0.35, 0)
            desc.Text = options.Description or "Example"
            desc.TextColor3 = CurrentTheme.Text
            desc.TextSize = 14
            desc.Font = Enum.Font.SourceSansBold
            desc.TextWrapped = true
            desc.BackgroundTransparency = 1
            desc.Parent = notif

            local icon = Instance.new("ImageLabel")
            icon.Size = UDim2.new(0, 50, 0, 50)
            icon.Position = UDim2.new(0.75, 0, 0.25, 0)
            icon.Image = options.Icon or "rbxassetid://8997385628"
            icon.BackgroundTransparency = 1
            icon.Parent = notif

            spawn(function()
                local tween = TweenService:Create(notif, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -150, 0, 20)})
                tween:Play()
                wait(options.Duration or 5)
                local tween2 = TweenService:Create(notif, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -150, 0, -120)})
                tween2:Play()
                tween2.Completed:Wait()
                frame:Destroy()
            end)
        end
        NothingLibrary.Notification = Notification

        -- Window
        function NothingLibrary.new(options)
            print("Создание нового окна: " .. (options.Title or "NOTHING"))
            local Window = {}
            local ScreenGui = Instance.new("ScreenGui")
            ScreenGui.Name = "YOXI-UI"
            local success, err = pcall(function() ScreenGui.Parent = game.CoreGui end)
            if not success then
                ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
            end
            ScreenGui.ResetOnSpawn = false

            local MainFrame = Instance.new("Frame")
            MainFrame.Size = UDim2.new(0, 500, 0, 300)
            MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
            MainFrame.BackgroundColor3 = CurrentTheme.Bg
            MainFrame.BorderSizePixel = 0
            MainFrame.Parent = ScreenGui
            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 8)
            Corner.Parent = MainFrame
            MainFrame.Visible = false

            local Header = Instance.new("Frame")
            Header.Size = UDim2.new(1, 0, 0, 30)
            Header.BackgroundColor3 = CurrentTheme.Accent
            Header.Parent = MainFrame
            local HeaderCorner = Instance.new("UICorner")
            HeaderCorner.CornerRadius = UDim.new(0, 8)
            HeaderCorner.Parent = Header

            local Logo = Instance.new("ImageLabel")
            Logo.Size = UDim2.new(0, 25, 0, 25)
            Logo.Position = UDim2.new(0, 5, 0, 2.5)
            Logo.Image = options.Logo or "https://raw.githubusercontent.com/xx1roch/YOXI-UI/main/yohi-logo-main.png" -- Твоё лого
            Logo.BackgroundTransparency = 1
            Logo.Parent = Header

            local TitleLabel = Instance.new("TextLabel")
            TitleLabel.Size = UDim2.new(0.6, 0, 1, 0)
            TitleLabel.Position = UDim2.new(0, 35, 0, 0)
            TitleLabel.Text = options.Title or "YOXI UI"
            TitleLabel.TextColor3 = CurrentTheme.Text
            TitleLabel.TextSize = 14
            TitleLabel.Font = Enum.Font.SourceSansBold
            TitleLabel.BackgroundTransparency = 1
            TitleLabel.Parent = Header

            local MinimizeButton = Instance.new("TextButton")
            MinimizeButton.Size = UDim2.new(0, 25, 0, 25)
            MinimizeButton.Position = UDim2.new(1, -55, 0, 2.5)
            MinimizeButton.Text = "-"
            MinimizeButton.BackgroundColor3 = CurrentTheme.Accent
            MinimizeButton.TextColor3 = CurrentTheme.Text
            MinimizeButton.Parent = Header
            local MinCorner = Instance.new("UICorner")
            MinCorner.CornerRadius = UDim.new(0, 5)
            MinCorner.Parent = MinimizeButton

            local CloseButton = Instance.new("TextButton")
            CloseButton.Size = UDim2.new(0, 25, 0, 25)
            CloseButton.Position = UDim2.new(1, -25, 0, 2.5)
            CloseButton.Text = "X"
            CloseButton.BackgroundColor3 = CurrentTheme.Red
            CloseButton.TextColor3 = CurrentTheme.Text
            CloseButton.Parent = Header
            local CloseCorner = Instance.new("UICorner")
            CloseCorner.CornerRadius = UDim.new(0, 5)
            CloseCorner.Parent = CloseButton

            local dragging, dragStart, startPos
            Header.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 and not MinimizeButton:IsDescendantOf(input.Changed) and not CloseButton:IsDescendantOf(input.Changed) then
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
            Header.InputChanged:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
                    local delta = input.Position - dragStart
                    MainFrame.Position = UDim2.new(0, startPos.X.Offset + delta.X, 0, startPos.Y.Offset + delta.Y)
                end
            end)

            local TabList = Instance.new("ScrollingFrame")
            TabList.Size = UDim2.new(0, 120, 1, -30)
            TabList.Position = UDim2.new(0, 0, 0, 30)
            TabList.BackgroundColor3 = CurrentTheme.Accent
            TabList.BackgroundTransparency = 0
            TabList.Parent = MainFrame
            local TabListCorner = Instance.new("UICorner")
            TabListCorner.CornerRadius = UDim.new(0, 5)
            TabListCorner.Parent = TabList
            TabList.CanvasSize = UDim2.new(0, 0, 0, 0)

            local ContentFrame = Instance.new("Frame")
            ContentFrame.Size = UDim2.new(1, -120, 1, -30)
            ContentFrame.Position = UDim2.new(0, 120, 0, 30)
            ContentFrame.BackgroundColor3 = CurrentTheme.DarkAccent
            ContentFrame.Parent = MainFrame
            local ContentCorner = Instance.new("UICorner")
            ContentCorner.CornerRadius = UDim.new(0, 5)
            ContentCorner.Parent = ContentFrame

            local Tabs = {}
            function Window:NewTab(options)
                local Tab = {}
                local TabButton = Instance.new("TextButton")
                TabButton.Size = UDim2.new(1, -10, 0, 35)
                TabButton.Position = UDim2.new(0, 5, 0, #Tabs * 40)
                TabButton.Text = options.Title or "Tab"
                TabButton.TextSize = 14
                TabButton.BackgroundColor3 = CurrentTheme.Accent
                TabButton.TextColor3 = CurrentTheme.Text
                TabButton.Parent = TabList
                local TabButtonCorner = Instance.new("UICorner")
                TabButtonCorner.CornerRadius = UDim.new(0, 5)
                TabButtonCorner.Parent = TabButton
                local UIStroke = Instance.new("UIStroke")
                UIStroke.Thickness = 1
                UIStroke.Color = CurrentTheme.Text
                UIStroke.Parent = TabButton

                local TabFrame = Instance.new("Frame")
                TabFrame.Size = UDim2.new(1, -10, 1, -10)
                TabFrame.Position = UDim2.new(0, 5, 0, 5)
                TabFrame.BackgroundTransparency = 1
                TabFrame.Parent = ContentFrame
                local TabFrameCorner = Instance.new("UICorner")
                TabFrameCorner.CornerRadius = UDim.new(0, 5)
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
                    local tween = TweenService:Create(TabButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundColor3 = CurrentTheme.DarkAccent})
                    tween:Play()
                    for _, btn in pairs(TabList:GetChildren()) do
                        if btn ~= TabButton and btn:IsA("TextButton") then
                            local tween2 = TweenService:Create(btn, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundColor3 = CurrentTheme.Accent})
                            tween2:Play()
                        end
                    end
                end)

                table.insert(Tabs, TabFrame)
                TabList.CanvasSize = UDim2.new(0, 0, 0, #Tabs * 40)

                function Tab:NewSection(options)
                    local Section = {}
                    local sectionFrame = Instance.new("Frame")
                    sectionFrame.Size = UDim2.new(0.45, 0, 1, 0)
                    if options.Position == "Right" then
                        sectionFrame.Position = UDim2.new(0.55, 0, 0, 0)
                    else
                        sectionFrame.Position = UDim2.new(0, 0, 0, 0)
                    end
                    sectionFrame.BackgroundTransparency = 1
                    sectionFrame.Parent = TabFrame

                    local title = Instance.new("TextLabel")
                    title.Size = UDim2.new(1, -10, 0, 30)
                    title.Position = UDim2.new(0, 5, 0, 0)
                    title.Text = options.Title or "Section"
                    title.TextColor3 = CurrentTheme.Text
                    title.TextSize = 14
                    title.Font = Enum.Font.SourceSansBold
                    title.BackgroundTransparency = 1
                    title.Parent = sectionFrame

                    local icon = Instance.new("ImageLabel")
                    icon.Size = UDim2.new(0, 20, 0, 20)
                    icon.Position = UDim2.new(0, 5, 0, 5)
                    icon.Image = options.Icon or ""
                    icon.BackgroundTransparency = 1
                    icon.Parent = title

                    function Section:NewToggle(options)
                        local toggleFrame = Instance.new("Frame")
                        toggleFrame.Size = UDim2.new(1, -10, 0, 30)
                        toggleFrame.Position = UDim2.new(0, 5, 0, title.AbsoluteSize.Y + 5)
                        toggleFrame.BackgroundTransparency = 1
                        toggleFrame.Parent = sectionFrame

                        local toggleButton = Instance.new("TextButton")
                        toggleButton.Size = UDim2.new(0, 30, 0, 20)
                        toggleButton.Position = UDim2.new(1, -35, 0, 5)
                        toggleButton.Text = ""
                        toggleButton.BackgroundColor3 = CurrentTheme.Accent
                        toggleButton.Parent = toggleFrame
                        local toggleCorner = Instance.new("UICorner")
                        toggleCorner.CornerRadius = UDim.new(0, 5)
                        toggleCorner.Parent = toggleButton

                        local toggleState = Instance.new("Frame")
                        toggleState.Size = UDim2.new(0.5, 0, 1, 0)
                        toggleState.Position = UDim2.new(0, 0, 0, 0)
                        toggleState.BackgroundColor3 = CurrentTheme.Text
                        toggleState.Parent = toggleButton
                        local stateCorner = Instance.new("UICorner")
                        stateCorner.CornerRadius = UDim.new(0, 5)
                        stateCorner.Parent = toggleState

                        local titleLabel = Instance.new("TextLabel")
                        titleLabel.Size = UDim2.new(0.8, 0, 1, 0)
                        titleLabel.Position = UDim2.new(0, 0, 0, 0)
                        titleLabel.Text = options.Title or "Toggle"
                        titleLabel.TextColor3 = CurrentTheme.Text
                        titleLabel.TextSize = 14
                        titleLabel.Font = Enum.Font.SourceSansBold
                        titleLabel.BackgroundTransparency = 1
                        titleLabel.Parent = toggleFrame

                        local state = options.Default or false
                        toggleButton.MouseButton1Click:Connect(function()
                            state = not state
                            toggleState.Position = state and UDim2.new(0.5, 0, 0, 0) or UDim2.new(0, 0, 0, 0)
                            if options.Callback then options.Callback(state) end
                        end)
                        if state then toggleState.Position = UDim2.new(0.5, 0, 0, 0) end
                    end

                    function Section:NewButton(options)
                        local buttonFrame = Instance.new("Frame")
                        buttonFrame.Size = UDim2.new(1, -10, 0, 30)
                        buttonFrame.Position = UDim2.new(0, 5, 0, title.AbsoluteSize.Y + 5)
                        buttonFrame.BackgroundTransparency = 1
                        buttonFrame.Parent = sectionFrame

                        local button = Instance.new("TextButton")
                        button.Size = UDim2.new(1, 0, 1, 0)
                        button.Text = options.Title or "Button"
                        button.TextColor3 = CurrentTheme.Text
                        button.TextSize = 14
                        button.Font = Enum.Font.SourceSansBold
                        button.BackgroundColor3 = CurrentTheme.Accent
                        button.Parent = buttonFrame
                        local buttonCorner = Instance.new("UICorner")
                        buttonCorner.CornerRadius = UDim.new(0, 5)
                        buttonCorner.Parent = button

                        button.MouseButton1Click:Connect(function()
                            if options.Callback then options.Callback() end
                        end)
                    end

                    function Section:NewSlider(options)
                        local sliderFrame = Instance.new("Frame")
                        sliderFrame.Size = UDim2.new(1, -10, 0, 40)
                        sliderFrame.Position = UDim2.new(0, 5, 0, title.AbsoluteSize.Y + 5)
                        sliderFrame.BackgroundTransparency = 1
                        sliderFrame.Parent = sectionFrame

                        local titleLabel = Instance.new("TextLabel")
                        titleLabel.Size = UDim2.new(0.8, 0, 0, 20)
                        titleLabel.Position = UDim2.new(0, 0, 0, 0)
                        titleLabel.Text = options.Title or "Slider"
                        titleLabel.TextColor3 = CurrentTheme.Text
                        titleLabel.TextSize = 14
                        titleLabel.Font = Enum.Font.SourceSansBold
                        titleLabel.BackgroundTransparency = 1
                        titleLabel.Parent = sliderFrame

                        local sliderBar = Instance.new("Frame")
                        sliderBar.Size = UDim2.new(0.8, 0, 0, 10)
                        sliderBar.Position = UDim2.new(0, 0, 0, 20)
                        sliderBar.BackgroundColor3 = CurrentTheme.Accent
                        sliderBar.Parent = sliderFrame
                        local sliderCorner = Instance.new("UICorner")
                        sliderCorner.CornerRadius = UDim.new(0, 5)
                        sliderCorner.Parent = sliderBar

                        local sliderFill = Instance.new("Frame")
                        sliderFill.Size = UDim2.new(0, 0, 1, 0)
                        sliderFill.BackgroundColor3 = CurrentTheme.Text
                        sliderFill.Parent = sliderBar
                        local fillCorner = Instance.new("UICorner")
                        fillCorner.CornerRadius = UDim.new(0, 5)
                        fillCorner.Parent = sliderFill

                        local value = options.Default or options.Min or 0
                        local function updateSlider(pos)
                            local size = sliderBar.AbsoluteSize.X
                            local newValue = math.clamp((pos - sliderBar.AbsolutePosition.X) / size * (options.Max - options.Min) + options.Min, options.Min, options.Max)
                            value = math.floor(newValue)
                            sliderFill.Size = UDim2.new(math.clamp((value - options.Min) / (options.Max - options.Min), 0, 1), 0, 1, 0)
                            if options.Callback then options.Callback(value) end
                        end

                        sliderBar.InputBegan:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                updateSlider(input.Position.X)
                                input.Changed:Connect(function()
                                    if input.UserInputState == Enum.UserInputState.End then
                                        updateSlider(input.Position.X)
                                    end
                                end)
                            end
                        end)

                        sliderBar.InputChanged:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseMovement then
                                updateSlider(input.Position.X)
                            end
                        end)
                    end

                    function Section:NewKeybind(options)
                        local keybindFrame = Instance.new("Frame")
                        keybindFrame.Size = UDim2.new(1, -10, 0, 30)
                        keybindFrame.Position = UDim2.new(0, 5, 0, title.AbsoluteSize.Y + 5)
                        keybindFrame.BackgroundTransparency = 1
                        keybindFrame.Parent = sectionFrame

                        local titleLabel = Instance.new("TextLabel")
                        titleLabel.Size = UDim2.new(0.8, 0, 1, 0)
                        titleLabel.Position = UDim2.new(0, 0, 0, 0)
                        titleLabel.Text = options.Title or "Keybind"
                        titleLabel.TextColor3 = CurrentTheme.Text
                        titleLabel.TextSize = 14
                        titleLabel.Font = Enum.Font.SourceSansBold
                        titleLabel.BackgroundTransparency = 1
                        titleLabel.Parent = keybindFrame

                        local keybindButton = Instance.new("TextButton")
                        keybindButton.Size = UDim2.new(0, 50, 0, 20)
                        keybindButton.Position = UDim2.new(1, -55, 0, 5)
                        keybindButton.Text = tostring(options.Default or Enum.KeyCode.Unknown)
                        keybindButton.BackgroundColor3 = CurrentTheme.Accent
                        keybindButton.TextColor3 = CurrentTheme.Text
                        keybindButton.Parent = keybindFrame
                        local keybindCorner = Instance.new("UICorner")
                        keybindCorner.CornerRadius = UDim.new(0, 5)
                        keybindCorner.Parent = keybindButton

                        local binding = false
                        keybindButton.MouseButton1Click:Connect(function()
                            binding = true
                            keybindButton.Text = "..."
                        end)

                        UserInputService.InputBegan:Connect(function(input)
                            if binding and input.UserInputType == Enum.UserInputType.Keyboard then
                                keybindButton.Text = input.KeyCode.Name
                                if options.Callback then options.Callback(input.KeyCode) end
                                binding = false
                            end
                        end)
                    end

                    function Section:NewDropdown(options)
                        local dropdownFrame = Instance.new("Frame")
                        dropdownFrame.Size = UDim2.new(1, -10, 0, 30)
                        dropdownFrame.Position = UDim2.new(0, 5, 0, title.AbsoluteSize.Y + 5)
                        dropdownFrame.BackgroundTransparency = 1
                        dropdownFrame.Parent = sectionFrame

                        local titleLabel = Instance.new("TextLabel")
                        titleLabel.Size = UDim2.new(0.8, 0, 1, 0)
                        titleLabel.Position = UDim2.new(0, 0, 0, 0)
                        titleLabel.Text = options.Title or "Dropdown"
                        titleLabel.TextColor3 = CurrentTheme.Text
                        titleLabel.TextSize = 14
                        titleLabel.Font = Enum.Font.SourceSansBold
                        titleLabel.BackgroundTransparency = 1
                        titleLabel.Parent = dropdownFrame

                        local dropdownButton = Instance.new("TextButton")
                        dropdownButton.Size = UDim2.new(0, 100, 0, 20)
                        dropdownButton.Position = UDim2.new(1, -105, 0, 5)
                        dropdownButton.Text = tostring(options.Default or options.Data[1])
                        dropdownButton.BackgroundColor3 = CurrentTheme.Accent
                        dropdownButton.TextColor3 = CurrentTheme.Text
                        dropdownButton.Parent = dropdownFrame
                        local dropdownCorner = Instance.new("UICorner")
                        dropdownCorner.CornerRadius = UDim.new(0, 5)
                        dropdownCorner.Parent = dropdownButton

                        local dropdownOpen = false
                        local dropdownList = Instance.new("Frame")
                        dropdownList.Size = UDim2.new(1, 0, 0, 0)
                        dropdownList.Position = UDim2.new(0, 5, 0, 35)
                        dropdownList.BackgroundColor3 = CurrentTheme.Accent
                        dropdownList.Parent = dropdownFrame
                        local listCorner = Instance.new("UICorner")
                        listCorner.CornerRadius = UDim.new(0, 5)
                        listCorner.Parent = dropdownList
                        dropdownList.Visible = false

                        dropdownButton.MouseButton1Click:Connect(function()
                            dropdownOpen = not dropdownOpen
                            dropdownList.Visible = dropdownOpen
                            if dropdownOpen then
                                dropdownList.Size = UDim2.new(1, -10, 0, #options.Data * 20)
                                for i, item in pairs(options.Data) do
                                    local itemButton = Instance.new("TextButton")
                                    itemButton.Size = UDim2.new(1, -10, 0, 20)
                                    itemButton.Position = UDim2.new(0, 5, 0, (i - 1) * 20)
                                    itemButton.Text = tostring(item)
                                    itemButton.BackgroundColor3 = CurrentTheme.Accent
                                    itemButton.TextColor3 = CurrentTheme.Text
                                    itemButton.Parent = dropdownList
                                    local itemCorner = Instance.new("UICorner")
                                    itemCorner.CornerRadius = UDim.new(0, 5)
                                    itemCorner.Parent = itemButton
                                    itemButton.MouseButton1Click:Connect(function()
                                        dropdownButton.Text = tostring(item)
                                        if options.Callback then options.Callback(item) end
                                        dropdownOpen = false
                                        dropdownList.Visible = false
                                    end)
                                end
                            end
                        end)

                    function Section:NewTitle(text)
                        local titleFrame = Instance.new("Frame")
                        titleFrame.Size = UDim2.new(1, -10, 0, 30)
                        titleFrame.Position = UDim2.new(0, 5, 0, title.AbsoluteSize.Y + 5)
                        titleFrame.BackgroundTransparency = 1
                        titleFrame.Parent = sectionFrame

                        local titleLabel = Instance.new("TextLabel")
                        titleLabel.Size = UDim2.new(1, 0, 1, 0)
                        titleLabel.Text = text or "Title"
                        titleLabel.TextColor3 = CurrentTheme.Text
                        titleLabel.TextSize = 14
                        titleLabel.Font = Enum.Font.SourceSansBold
                        titleLabel.BackgroundTransparency = 1
                        titleLabel.Parent = titleFrame
                    end

                    return Section
                end
                return Tab
            end

            local function AnimateWindow(show)
                MainFrame.Visible = true
                if show then
                    MainFrame.Size = UDim2.new(0, 0, 0, 30)
                    MainFrame.BackgroundTransparency = 1
                    local sizeTween = TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 500, 0, 300)})
                    local transTween = TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {BackgroundTransparency = 0})
                    sizeTween:Play()
                    transTween:Play()
                else
                    local sizeTween = TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 0, 0, 30)})
                    local transTween = TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {BackgroundTransparency = 1})
                    sizeTween:Play()
                    transTween:Play()
                    sizeTween.Completed:Wait()
                    MainFrame.Visible = false
                end
            end

            MinimizeButton.MouseButton1Click:Connect(function()
                AnimateWindow(false)
            end)

            CloseButton.MouseButton1Click:Connect(function()
                AnimateWindow(false)
            end)

            UserInputService.InputBegan:Connect(function(input)
                if input.KeyCode == options.Keybind then
                    print("Нажата клавиша: " .. tostring(options.Keybind))
                    AnimateWindow(not MainFrame.Visible)
                end
            end)

            return Window
        end

        return NothingLibrary
    ]]
end

local success, result = pcall(loadstring(yoxiCode))
if not success then
    warn("Ошибка при выполнении loadstring: " .. tostring(result))
    return
end

local YOXI = result
print("YOXI загружен, тип: " .. type(YOXI))

-- Проверка и запуск
if type(YOXI) == "table" and type(YOXI.new) == "function" and type(YOXI.Notification) == "table" then
    local Notification = YOXI.Notification()
    Notification.new({
        Title = "Notification",
        Description = "YOXI UI загружен",
        Duration = 5,
        Icon = "rbxassetid://8997385628"
    })
    local Windows = YOXI.new({
        Title = "YOXI UI",
        Description = "YOXI UI Library",
        Keybind = Enum.KeyCode.LeftControl,
        Logo = "https://raw.githubusercontent.com/xx1roch/YOXI-UI/main/yohi-logo-main.png"
    })
    local TabFrame = Windows:NewTab({
        Title = "Example",
        Description = "example tab",
        Icon = "rbxassetid://7733960981"
    })
    local Section = TabFrame:NewSection({
        Title = "Section",
        Icon = "rbxassetid://7743869054",
        Position = "Left"
    })
    local InfoSection = TabFrame:NewSection({
        Title = "Information",
        Icon = "rbxassetid://7733964719",
        Position = "Right"
    })
    Section:NewToggle({
        Title = "Toggle",
        Default = false,
        Callback = function(tr)
            print(tr)
        end,
    })
    Section:NewToggle({
        Title = "Auto Farm",
        Default = false,
        Callback = function(tr)
            print(tr)
        end,
    })
    Section:NewButton({
        Title = "Kill All",
        Callback = function()
            Notification.new({
                Title = "Killed",
                Description = "10",
                Duration = 5,
                Icon = "rbxassetid://8997385628"
            })
            print('killed')
        end,
    })
    Section:NewButton({
        Title = "Teleport",
        Callback = function()
            print('tp')
        end,
    })
    Section:NewSlider({
        Title = "Slider",
        Min = 10,
        Max = 50,
        Default = 25,
        Callback = function(a)
            print(a)
        end,
    })
    Section:NewSlider({
        Title = "WalkSpeed",
        Min = 15,
        Max = 50,
        Default = 16,
        Callback = function(a)
            print(a)
        end,
    })
    Section:NewKeybind({
        Title = "Keybind",
        Default = Enum.KeyCode.RightAlt,
        Callback = function(a)
            print(a)
        end,
    })
    Section:NewKeybind({
        Title = "Auto Combo",
        Default = Enum.KeyCode.T,
        Callback = function(a)
            print(a)
        end,
    })
    Section:NewDropdown({
        Title = "Dropdown",
        Data = {1, 2, 3, 4, 5},
        Default = 1,
        Callback = function(a)
            print(a)
        end,
    })
    Section:NewDropdown({
        Title = "Method",
        Data = {'Teleport', 'Locker', 'Auto'},
        Default = 'Auto',
        Callback = function(a)
            print(a)
        end,
    })
    InfoSection:NewTitle('UI by xx1roch')
    InfoSection:NewButton({
        Title = "Discord",
        Callback = function()
            print('discord.gg/твой_дискорд') -- Замени на свой
        end,
    })
else
    warn("YOXI не содержит необходимые функции!")
end
