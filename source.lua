-- YOXI UI Source (адаптация Flux Lib)
-- by xx1roch (на основе weakhoes/Roblox-UI-Libs)
-- Licensed Under MIT License (оригинал Flux Lib)

local Flux = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local gui = Instance.new("ScreenGui")
gui.Name = "YOXI UI"
pcall(function() gui.Parent = game.CoreGui end)
if not gui.Parent then gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui") end
gui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 600, 0, 400)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Темный фон
mainFrame.BorderSizePixel = 0
mainFrame.Parent = gui
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 5)
corner.Parent = mainFrame

-- Замена "prewiew base plate" на лого
local logo = Instance.new("ImageLabel")
logo.Size = UDim2.new(0, 150, 0, 50)
logo.Position = UDim2.new(0, 10, 0, 10)
logo.Image = "https://raw.githubusercontent.com/xx1roch/YOXI-UI/main/yohi-logo-main.png"
logo.BackgroundTransparency = 1
logo.Parent = mainFrame

-- Tab System
local tabFrame = Instance.new("ScrollingFrame")
tabFrame.Size = UDim2.new(0, 150, 1, -60)
tabFrame.Position = UDim2.new(0, 10, 0, 60)
tabFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40) -- Серый для вкладок
tabFrame.BorderSizePixel = 0
tabFrame.Parent = mainFrame
local tabCorner = Instance.new("UICorner")
tabCorner.CornerRadius = UDim.new(0, 5)
tabCorner.Parent = tabFrame
tabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -170, 1, -70)
contentFrame.Position = UDim2.new(0, 160, 0, 60)
contentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25) -- Темный контент
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainFrame
local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 5)
contentCorner.Parent = contentFrame

local tabs = {}
function Flux:NewTab(name)
    local tab = {}
    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(1, -10, 0, 30)
    tabButton.Position = UDim2.new(0, 5, 0, #tabs * 35)
    tabButton.Text = name or "Tab"
    tabButton.TextColor3 = Color3.fromRGB(200, 200, 200) -- Светло-серый текст
    tabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tabButton.Parent = tabFrame
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 5)
    buttonCorner.Parent = tabButton

    local tabContent = Instance.new("Frame")
    tabContent.Size = UDim2.new(1, -10, 1, -10)
    tabContent.Position = UDim2.new(0, 5, 0, 5)
    tabContent.BackgroundTransparency = 1
    tabContent.Parent = contentFrame
    if #tabs == 0 then tabContent.Visible = true else tabContent.Visible = false end

    table.insert(tabs, tabContent)
    tabFrame.CanvasSize = UDim2.new(0, 0, 0, (#tabs + 1) * 35)

    tabButton.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do t.Visible = false end
        tabContent.Visible = true
    end)

    function tab:NewSection(title)
        local section = {}
        local sectionFrame = Instance.new("Frame")
        sectionFrame.Size = UDim2.new(1, -20, 0, 200)
        sectionFrame.Position = UDim2.new(0, 10, 0, 10)
        sectionFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35) -- Серый для секций
        sectionFrame.BorderSizePixel = 0
        sectionFrame.Parent = tabContent
        local sectionCorner = Instance.new("UICorner")
        sectionCorner.CornerRadius = UDim.new(0, 5)
        sectionCorner.Parent = sectionFrame

        local sectionTitle = Instance.new("TextLabel")
        sectionTitle.Size = UDim2.new(1, -10, 0, 30)
        sectionTitle.Position = UDim2.new(0, 5, 0, 5)
        sectionTitle.Text = title or "Section"
        sectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255) -- Белый текст
        sectionTitle.BackgroundTransparency = 1
        sectionTitle.Parent = sectionFrame

        return section
    end

    return tab
end

function Flux:Load()
    gui.Enabled = true
end

function Flux:Unload(destroy)
    gui.Enabled = false
    if destroy then gui:Destroy() end
end

return Flux
