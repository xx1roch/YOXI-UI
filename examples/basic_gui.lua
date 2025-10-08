-- Лоадер
local YOXI = loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/xx1roch/YOXI-UI/main/source.lua'))()
if not YOXI then
    warn("Не удалось загрузить YOXI-UI. Используй локальный код.")
    return
end

-- Создание окна
local Win = YOXI.new(true, "YOXI UI", "Тест", Enum.KeyCode.RightControl, "rbxassetid://6031090997")

-- Вкладка Main
local MainTab = Win:NewTab("Main", "", "rbxassetid://6031090997")
local MainSec = MainTab:NewSection("Test Functions", "")
MainSec:NewToggle("Test Toggle", false, function(state) print("Toggle:", state) end)
MainSec:NewButton("Test Button", function() print("Button clicked!") end)
MainSec:NewColorPicker("Test Color", Color3.new(0, 1, 0), function(color) print("Color:", color) end)
MainSec:NewSlider("Test Slider", 0, 100, 50, function(value) print("Slider:", value) end)
MainSec:NewDropdown("Test Dropdown", {"Option 1", "Option 2", "Option 3"}, "Option 1", function(option) print("Dropdown:", option) end)
MainSec:NewKeybind("Test Keybind", Enum.KeyCode.RightControl, function(key) print("Keybind:", key.Name) end)
local progress = MainSec:NewProgressBar("Test Progress", 0, 100, 0, function(value) print("Progress:", value) end)
wait(1)
progress:SetValue(50)
wait(1)
progress:SetValue(100)

-- Вкладка Settings
local SettingsTab = Win:NewTab("Settings", "", "rbxassetid://6031090997")
local SettingsSec = SettingsTab:NewSection("Configuration", "")

local ConfigNameLabel = Instance.new("TextLabel")
ConfigNameLabel.Size = UDim2.new(0.4, -5, 0, 20)
ConfigNameLabel.Position = UDim2.new(0, 5, 0, 5)
ConfigNameLabel.Text = "Set name config"
ConfigNameLabel.TextColor3 = CurrentTheme.Text
ConfigNameLabel.Parent = SettingsSec.SectionFrame

local ConfigNameInput = Instance.new("TextBox")
ConfigNameInput.Size = UDim2.new(0.4, -5, 0, 30)
ConfigNameInput.Position = UDim2.new(0, 5, 0, 30)
ConfigNameInput.BackgroundColor3 = CurrentTheme.Gray
ConfigNameInput.TextColor3 = CurrentTheme.Text
ConfigNameInput.PlaceholderText = "Enter config name"
ConfigNameInput.Parent = SettingsSec.SectionFrame
local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 5)
InputCorner.Parent = ConfigNameInput

local CreateConfigButton = Instance.new("TextButton")
CreateConfigButton.Size = UDim2.new(0.15, -5, 0, 30)
CreateConfigButton.Position = UDim2.new(0.45, 5, 0, 30)
CreateConfigButton.Text = "Create config"
CreateConfigButton.BackgroundColor3 = CurrentTheme.LightGray
CreateConfigButton.TextColor3 = CurrentTheme.Text
CreateConfigButton.Parent = SettingsSec.SectionFrame
local CreateCorner = Instance.new("UICorner")
CreateCorner.CornerRadius = UDim.new(0, 5)
CreateCorner.Parent = CreateConfigButton
CreateConfigButton.MouseButton1Click:Connect(function()
    local name = ConfigNameInput.Text
    if name and name ~= "" then
        if not isfolder("YOXI-Configs") then makefolder("YOXI-Configs") end
        writefile("YOXI-Configs/" .. name .. ".json", "{}")
        YOXI.Notification("Success", "Config created: " .. name, 2)
        UpdateConfigDropdown()
    end
end)

local ConfigLabel = Instance.new("TextLabel")
ConfigLabel.Size = UDim2.new(0.4, -5, 0, 20)
ConfigLabel.Position = UDim2.new(0.6, 5, 0, 5)
ConfigLabel.Text = "Set config"
ConfigLabel.TextColor3 = CurrentTheme.Text
ConfigLabel.Parent = SettingsSec.SectionFrame

local ConfigDropdown = Instance.new("Frame")
ConfigDropdown.Size = UDim2.new(0.4, -5, 0, 30)
ConfigDropdown.Position = UDim2.new(0.6, 5, 0, 30)
ConfigDropdown.BackgroundColor3 = CurrentTheme.Gray
ConfigDropdown.Parent = SettingsSec.SectionFrame
local ConfigDropdownCorner = Instance.new("UICorner")
ConfigDropdownCorner.CornerRadius = UDim.new(0, 5)
ConfigDropdownCorner.Parent = ConfigDropdown

local ConfigLabelButton = Instance.new("TextButton")
ConfigLabelButton.Size = UDim2.new(1, 0, 1, 0)
ConfigLabelButton.Text = "Select config"
ConfigLabelButton.BackgroundColor3 = CurrentTheme.Gray
ConfigLabelButton.TextColor3 = CurrentTheme.Text
ConfigLabelButton.Parent = ConfigDropdown
local ConfigLabelCorner = Instance.new("UICorner")
ConfigLabelCorner.CornerRadius = UDim.new(0, 5)
ConfigLabelCorner.Parent = ConfigLabelButton

local ConfigList = Instance.new("ScrollingFrame")
ConfigList.Size = UDim2.new(1, 0, 0, 0)
ConfigList.Position = UDim2.new(0, 0, 0, 30)
ConfigList.BackgroundColor3 = CurrentTheme.DarkGray
ConfigList.BackgroundTransparency = 0.5
ConfigList.Parent = ConfigDropdown
ConfigList.CanvasSize = UDim2.new(0, 0, 0, 0)
local ConfigListCorner = Instance.new("UICorner")
ConfigListCorner.CornerRadius = UDim.new(0, 5)
ConfigListCorner.Parent = ConfigList

local function UpdateConfigDropdown()
    ConfigList:ClearAllChildren()
    if isfolder("YOXI-Configs") then
        local files = listfiles("YOXI-Configs")
        for _, file in pairs(files) do
            if file:match("%.json$") then
                local name = file:match("YOXI%-Configs/(.+)%.json")
                local OptionButton = Instance.new("TextButton")
                OptionButton.Size = UDim2.new(1, -10, 0, 30)
                OptionButton.Text = name
                OptionButton.BackgroundColor3 = CurrentTheme.DarkGray
                OptionButton.TextColor3 = CurrentTheme.Text
                OptionButton.Parent = ConfigList
                OptionButton.Position = UDim2.new(0, 5, 0, (#ConfigList:GetChildren() - 1) * 30)
                local OptionButtonCorner = Instance.new("UICorner")
                OptionButtonCorner.CornerRadius = UDim.new(0, 5)
                OptionButtonCorner.Parent = OptionButton
                OptionButton.MouseButton1Click:Connect(function()
                    ConfigLabelButton.Text = "Select config: " .. name
                    local tween = TweenService:Create(ConfigList, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 0)})
                    tween:Play()
                    if loadCallback then loadCallback() end
                end)
            end
        end
        ConfigList.CanvasSize = UDim2.new(0, 0, 0, #ConfigList:GetChildren() * 30)
    end
end
UpdateConfigDropdown()

local LoadConfigButton = Instance.new("TextButton")
LoadConfigButton.Size = UDim2.new(0.15, -5, 0, 30)
LoadConfigButton.Position = UDim2.new(0.6, 5, 0, 70)
LoadConfigButton.Text = "Load config"
LoadConfigButton.BackgroundColor3 = CurrentTheme.LightGray
LoadConfigButton.TextColor3 = CurrentTheme.Text
LoadConfigButton.Parent = SettingsSec.SectionFrame
local LoadCorner = Instance.new("UICorner")
LoadCorner.CornerRadius = UDim.new(0, 5)
LoadCorner.Parent = LoadConfigButton
LoadConfigButton.MouseButton1Click:Connect(function()
    local selected = ConfigLabelButton.Text:match("Select config: (.+)")
    if selected and isfile("YOXI-Configs/" .. selected .. ".json") then
        local json = readfile("YOXI-Configs/" .. selected .. ".json")
        local config = HttpService:JSONDecode(json)
        -- Здесь можно добавить загрузку конфига в текущую вкладку
        YOXI.Notification("Success", "Loaded config: " .. selected, 2)
    end
end)

local DeleteConfigButton = Instance.new("TextButton")
DeleteConfigButton.Size = UDim2.new(0.15, -5, 0, 30)
DeleteConfigButton.Position = UDim2.new(0.75, 5, 0, 70)
DeleteConfigButton.Text = "Delete config"
DeleteConfigButton.BackgroundColor3 = CurrentTheme.LightGray
DeleteConfigButton.TextColor3 = CurrentTheme.Text
DeleteConfigButton.Parent = SettingsSec.SectionFrame
local DeleteCorner = Instance.new("UICorner")
DeleteCorner.CornerRadius = UDim.new(0, 5)
DeleteCorner.Parent = DeleteConfigButton
DeleteConfigButton.MouseButton1Click:Connect(function()
    local selected = ConfigLabelButton.Text:match("Select config: (.+)")
    if selected and isfile("YOXI-Configs/" .. selected .. ".json") then
        delfile("YOXI-Configs/" .. selected .. ".json")
        ConfigLabelButton.Text = "Select config"
        UpdateConfigDropdown()
        YOXI.Notification("Success", "Deleted config: " .. selected, 2)
    end
end)

-- Кастомный Keybind
local KeybindLabel = Instance.new("TextLabel")
KeybindLabel.Size = UDim2.new(0.4, -5, 0, 20)
KeybindLabel.Position = UDim2.new(0, 5, 0, 110)
KeybindLabel.Text = "Set Keybind"
KeybindLabel.TextColor3 = CurrentTheme.Text
KeybindLabel.Parent = SettingsSec.SectionFrame

local KeybindInput = Instance.new("Frame")
KeybindInput.Size = UDim2.new(0.4, -5, 0, 30)
KeybindInput.Position = UDim2.new(0, 5, 0, 135)
KeybindInput.BackgroundColor3 = CurrentTheme.Gray
KeybindInput.Parent = SettingsSec.SectionFrame
local KeybindInputCorner = Instance.new("UICorner")
KeybindInputCorner.CornerRadius = UDim.new(0, 5)
KeybindInputCorner.Parent = KeybindInput

local KeybindButton = Instance.new("TextButton")
KeybindButton.Size = UDim2.new(1, 0, 1, 0)
KeybindButton.Text = "RightControl"
KeybindButton.BackgroundColor3 = CurrentTheme.Gray
KeybindButton.TextColor3 = CurrentTheme.Text
KeybindButton.Parent = KeybindInput
local KeybindButtonCorner = Instance.new("UICorner")
KeybindButtonCorner.CornerRadius = UDim.new(0, 5)
KeybindButtonCorner.Parent = KeybindButton
KeybindButton.MouseButton1Click:Connect(function()
    KeybindButton.Text = "[...]"
    local inputwait = UserInputService.InputBegan:Wait()
    if inputwait.KeyCode ~= Enum.KeyCode.Unknown then
        KeybindButton.Text = inputwait.KeyCode.Name
        Win = YOXI.new(true, "YOXI UI", "Тест", inputwait.KeyCode, "rbxassetid://6031090997") -- Обновляем окно с новым Keybind
    end
end)

-- Вкладка Info
local InfoTab = Win:NewTab("Info", "", "rbxassetid://6031090997")
local InfoSec = InfoTab:NewSection("About", "")
local InfoText = Instance.new("TextLabel")
InfoText.Size = UDim2.new(1, -10, 1, -10)
InfoText.Position = UDim2.new(0, 5, 0, 5)
InfoText.Text = "YOXI UI v1.5\nCreated by xx1roch\nGitHub: https://github.com/xx1roch/YOXI-UI"
InfoText.TextColor3 = CurrentTheme.Text
InfoText.TextWrapped = true
InfoText.Parent = InfoSec.SectionFrame

YOXI.Notification("Готово!", "YOXI UI загружен", 2)
YOXI.LoadTheme("Custom")
