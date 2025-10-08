--[[
    YOXI UI Source
    Адаптация Twilight ESP Library с кастомной цветовой гаммой

    by xx1roch (на основе Nebula Softworks)
    Licensed Under CC0-1.0 License
]]

local services = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local YOXI = {}
local gui = Instance.new("ScreenGui")
gui.Name = "YOXI UI"
pcall(function() gui.Parent = game.CoreGui end)
if not gui.Parent then gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui") end
gui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 500, 0, 300)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(28, 37, 38) -- Не сильно тёмно-чёрный
mainFrame.BorderSizePixel = 0
mainFrame.Parent = gui
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(0, 120, 1, -30)
tabFrame.Position = UDim2.new(0, 0, 0, 30)
tabFrame.BackgroundColor3 = Color3.fromRGB(74, 74, 74) -- Серый для вкладок
tabFrame.Parent = mainFrame
local tabCorner = Instance.new("UICorner")
tabCorner.CornerRadius = UDim.new(0, 5)
tabCorner.Parent = tabFrame

local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -120, 1, -30)
contentFrame.Position = UDim2.new(0, 120, 0, 30)
contentFrame.BackgroundColor3 = Color3.fromRGB(28, 37, 38)
contentFrame.Parent = mainFrame
local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 5)
contentCorner.Parent = contentFrame

local tabs = {}
function YOXI:NewTab(title)
    local tab = {}
    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(1, -10, 0, 35)
    tabButton.Position = UDim2.new(0, 5, 0, #tabs * 40)
    tabButton.Text = title or "Tab"
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- Белый текст
    tabButton.BackgroundColor3 = Color3.fromRGB(74, 74, 74)
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
    tabFrame.CanvasSize = UDim2.new(0, 0, 0, #tabs * 40)

    tabButton.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do t.Visible = false end
        tabContent.Visible = true
    end)

    return tab
end

function YOXI:Load()
    gui.Enabled = true
end

function YOXI:Unload(destroy)
    gui.Enabled = false
    if destroy then gui:Destroy() end
end

function YOXI:SetOptions(options)
    options = options or {}
    YOXI.settings = {
        currentColors = {
            boxNeutral = Color3.fromRGB(200, 200, 200), -- светло-серый
            boxSelf = Color3.fromRGB(128, 128, 128), -- серый
            boxTeam = Color3.fromRGB(255, 255, 255), -- белый
            boxEnemy = Color3.fromRGB(0, 0, 0), -- черный
        }
    }
end

YOXI:SetOptions()
return YOXI
