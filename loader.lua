local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local URL = "https://flowauth.net/v1/loaders/7581b602d8cffcec148aa00d17f82777.lua"

local gui = Instance.new("ScreenGui")
gui.Name = "MobileLoader"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(300, 180)
frame.Position = UDim2.fromScale(0.5, 0.5)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 45)
title.Position = UDim2.fromOffset(10, 10)
title.BackgroundTransparency = 1
title.Text = "SCRIPT LOADER"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 22
title.Font = Enum.Font.GothamBold
title.Parent = frame

local ring = Instance.new("TextLabel")
ring.Size = UDim2.fromOffset(45, 45)
ring.Position = UDim2.new(0.5, -22, 0, 55)
ring.BackgroundTransparency = 1
ring.Text = "◌"
ring.TextColor3 = Color3.fromRGB(255, 70, 180)
ring.TextSize = 40
ring.Font = Enum.Font.GothamBold
ring.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -40, 0, 50)
button.Position = UDim2.new(0, 20, 1, -65)
button.BackgroundColor3 = Color3.fromRGB(255, 60, 170)
button.Text = "LOAD SCRIPT"
button.TextColor3 = Color3.new(1, 1, 1)
button.TextSize = 18
button.Font = Enum.Font.GothamBold
button.Parent = frame

Instance.new("UICorner", button).CornerRadius = UDim.new(0, 12)

-- Loading ring animation
task.spawn(function()
    while gui.Parent do
        ring.Rotation += 15
        task.wait(0.05)
    end
end)

button.Activated:Connect(function()
    button.Text = "LOADING..."
    button.Active = false

    local success, result = pcall(function()
        local code = game:HttpGet(URL)
        return loadstring(code)()
    end)

    if success then
        button.Text = "LOADED ✓"
    else
        button.Text = "LOAD FAILED"
        warn("Loader error:", result)
        task.wait(2)
        button.Text = "LOAD SCRIPT"
        button.Active = true
    end
end)
