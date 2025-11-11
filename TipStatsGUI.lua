-- Tip Stats GUI Script
-- Displays all players' TipJarStats.Donated values in a scrollable list

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

-- Bang function (from Infinite Yield)
local function bangPlayer(targetPlayer)
    if targetPlayer and targetPlayer.Parent and targetPlayer.Character then
        local character = targetPlayer.Character
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        
        if humanoidRootPart then
            -- Apply bang effect (teleport player up and down rapidly)
            spawn(function()
                local originalCFrame = humanoidRootPart.CFrame
                local originalPosition = originalCFrame.Position
                
                -- Rapidly move the player up and down
                for i = 1, 10 do
                    if humanoidRootPart and humanoidRootPart.Parent then
                        humanoidRootPart.CFrame = originalCFrame * CFrame.new(0, 50, 0)
                        task.wait(0.05)
                        if humanoidRootPart and humanoidRootPart.Parent then
                            humanoidRootPart.CFrame = originalCFrame * CFrame.new(0, -50, 0)
                            task.wait(0.05)
                        end
                    else
                        break
                    end
                end
                
                -- Return to original position
                if humanoidRootPart and humanoidRootPart.Parent then
                    humanoidRootPart.CFrame = originalCFrame
                end
            end)
        end
    end
end

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TipStatsGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = game:GetService("CoreGui")

-- Store original sizes and states
local originalSize = UDim2.new(0, 500, 0, 600)
local minimizedSize = UDim2.new(0, 500, 0, 45)
local isMinimized = false
local isClosed = false

-- Create Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = originalSize
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -300)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Add corner radius
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

-- Add subtle border
local mainBorder = Instance.new("UIStroke")
mainBorder.Color = Color3.fromRGB(50, 50, 50)
mainBorder.Thickness = 1
mainBorder.Transparency = 0.2
mainBorder.Parent = mainFrame

-- Create Title Bar
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 45)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleBar

-- Add subtle border to title bar
local titleBorder = Instance.new("UIStroke")
titleBorder.Color = Color3.fromRGB(60, 60, 60)
titleBorder.Thickness = 1
titleBorder.Transparency = 0.3
titleBorder.Parent = titleBar

-- Title Text
local titleText = Instance.new("TextLabel")
titleText.Name = "TitleText"
titleText.Size = UDim2.new(1, -20, 1, 0)
titleText.Position = UDim2.new(0, 15, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "Player Tip Stats"
titleText.TextColor3 = Color3.fromRGB(240, 240, 240)
titleText.TextSize = 17
titleText.Font = Enum.Font.GothamSemibold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

-- Search Button
local searchButton = Instance.new("TextButton")
searchButton.Name = "SearchButton"
searchButton.Size = UDim2.new(0, 32, 0, 32)
searchButton.Position = UDim2.new(1, -151, 0, 6.5)
searchButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
searchButton.Text = "S"
searchButton.TextColor3 = Color3.fromRGB(220, 220, 220)
searchButton.TextSize = 16
searchButton.Font = Enum.Font.GothamBold
searchButton.BorderSizePixel = 0
searchButton.Parent = titleBar

local searchCorner = Instance.new("UICorner")
searchCorner.CornerRadius = UDim.new(0, 6)
searchCorner.Parent = searchButton

-- Search button hover effect
searchButton.MouseEnter:Connect(function()
    searchButton.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
end)
searchButton.MouseLeave:Connect(function()
    searchButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
end)

-- Local Player Avatar Icon
local localPlayer = Players.LocalPlayer
local avatarIcon = Instance.new("ImageButton")
avatarIcon.Name = "AvatarIcon"
avatarIcon.Size = UDim2.new(0, 32, 0, 32)
avatarIcon.Position = UDim2.new(1, -114, 0, 6.5)
avatarIcon.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
avatarIcon.BorderSizePixel = 0
avatarIcon.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. localPlayer.UserId .. "&width=150&height=150&format=png"
avatarIcon.Parent = titleBar

local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(0, 6)
avatarCorner.Parent = avatarIcon

-- Avatar icon hover effect
avatarIcon.MouseEnter:Connect(function()
    avatarIcon.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
end)
avatarIcon.MouseLeave:Connect(function()
    avatarIcon.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
end)

-- Minimize Button
local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 32, 0, 32)
minimizeButton.Position = UDim2.new(1, -77, 0, 6.5)
minimizeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
minimizeButton.Text = "−"
minimizeButton.TextColor3 = Color3.fromRGB(220, 220, 220)
minimizeButton.TextSize = 18
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.BorderSizePixel = 0
minimizeButton.Parent = titleBar

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 6)
minimizeCorner.Parent = minimizeButton

-- Minimize button hover effect
minimizeButton.MouseEnter:Connect(function()
    minimizeButton.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
end)
minimizeButton.MouseLeave:Connect(function()
    minimizeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
end)

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 32, 0, 32)
closeButton.Position = UDim2.new(1, -40, 0, 6.5)
closeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
closeButton.Text = "×"
closeButton.TextColor3 = Color3.fromRGB(220, 220, 220)
closeButton.TextSize = 18
closeButton.Font = Enum.Font.GothamBold
closeButton.BorderSizePixel = 0
closeButton.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeButton

-- Close button hover effect
closeButton.MouseEnter:Connect(function()
    closeButton.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
end)
closeButton.MouseLeave:Connect(function()
    closeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
end)

-- Minimize/Maximize function (will be defined after scrollingFrame is created)
local toggleMinimize = nil

-- Create Restore Button (hidden by default, shown when GUI is closed)
local restoreButton = Instance.new("TextButton")
restoreButton.Name = "RestoreButton"
restoreButton.Size = UDim2.new(0, 120, 0, 35)
restoreButton.Position = UDim2.new(1, -130, 0, 10)
restoreButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
restoreButton.Text = "Tip Stats"
restoreButton.TextColor3 = Color3.fromRGB(200, 200, 200)
restoreButton.TextSize = 14
restoreButton.Font = Enum.Font.GothamBold
restoreButton.BorderSizePixel = 0
restoreButton.Visible = false
restoreButton.Parent = screenGui

local restoreCorner = Instance.new("UICorner")
restoreCorner.CornerRadius = UDim.new(0, 6)
restoreCorner.Parent = restoreButton

-- Restore button hover effect
restoreButton.MouseEnter:Connect(function()
    restoreButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
end)
restoreButton.MouseLeave:Connect(function()
    restoreButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

-- Close/Open function
local function toggleClose()
    if isClosed then
        -- Opening animation
        isClosed = false
        mainFrame.Visible = true
        restoreButton.Visible = false
        
        -- Reset properties for animation
        mainFrame.Size = UDim2.new(0, 0, 0, 0)
        mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        mainFrame.BackgroundTransparency = 1
        
        -- Animate opening
        local openSizeTween = TweenService:Create(
            mainFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = isMinimized and minimizedSize or originalSize}
        )
        
        local openPosTween = TweenService:Create(
            mainFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Position = UDim2.new(0.5, -250, 0.5, -300)}
        )
        
        local openFadeTween = TweenService:Create(
            mainFrame,
            TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 0}
        )
        
        openSizeTween:Play()
        openPosTween:Play()
        openFadeTween:Play()
        
        -- Restore minimized state if it was minimized
        if isMinimized then
            openSizeTween.Completed:Wait()
            toggleMinimize()
        end
    else
        -- Closing animation
        isClosed = true
        
        -- Animate closing
        local closeSizeTween = TweenService:Create(
            mainFrame,
            TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In),
            {Size = UDim2.new(0, 0, 0, 0)}
        )
        
        local closePosTween = TweenService:Create(
            mainFrame,
            TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In),
            {Position = UDim2.new(0.5, 0, 0.5, 0)}
        )
        
        local closeFadeTween = TweenService:Create(
            mainFrame,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {BackgroundTransparency = 1}
        )
        
        closeSizeTween:Play()
        closePosTween:Play()
        closeFadeTween:Play()
        
        -- Hide and show restore button after animation
        closeFadeTween.Completed:Connect(function()
            mainFrame.Visible = false
            restoreButton.Visible = true
            
            -- Animate restore button appearance
            restoreButton.Size = UDim2.new(0, 0, 0, 35)
            restoreButton.BackgroundTransparency = 1
            local restoreTween = TweenService:Create(
                restoreButton,
                TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 120, 0, 35), BackgroundTransparency = 0}
            )
            restoreTween:Play()
        end)
    end
end

restoreButton.MouseButton1Click:Connect(toggleClose)
closeButton.MouseButton1Click:Connect(toggleClose)
-- minimizeButton connection will be set up after toggleMinimize is defined

-- Make title bar draggable
local dragging = false
local dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(
        startPos.X.Scale, startPos.X.Offset + delta.X,
        startPos.Y.Scale, startPos.Y.Offset + delta.Y
    )
end

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Create ScrollingFrame
local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Name = "ScrollingFrame"
scrollingFrame.Size = UDim2.new(1, -20, 1, -65)
scrollingFrame.Position = UDim2.new(0, 10, 0, 55)
scrollingFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
scrollingFrame.BorderSizePixel = 0
scrollingFrame.ScrollBarThickness = 6
scrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(70, 70, 70)
scrollingFrame.Parent = mainFrame

local scrollCorner = Instance.new("UICorner")
scrollCorner.CornerRadius = UDim.new(0, 6)
scrollCorner.Parent = scrollingFrame

-- Now define the minimize function after scrollingFrame is created
toggleMinimize = function()
    if isClosed then return end
    
    isMinimized = not isMinimized
    
    local targetSize = isMinimized and minimizedSize or originalSize
    
    -- Animate size with smooth effect
    local sizeTween = TweenService:Create(
        mainFrame,
        TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
        {Size = targetSize}
    )
    
    if isMinimized then
        -- Hide scrolling frame immediately
        scrollingFrame.Visible = false
        minimizeButton.Text = "+"
    else
        -- Show scrolling frame and animate
        scrollingFrame.Visible = true
        scrollingFrame.BackgroundTransparency = 1
        
        local scrollFadeTween = TweenService:Create(
            scrollingFrame,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 0}
        )
        scrollFadeTween:Play()
        
        minimizeButton.Text = "−"
    end
    
    sizeTween:Play()
end

-- Now connect the minimize button after the function is defined
minimizeButton.MouseButton1Click:Connect(toggleMinimize)

-- Create UIListLayout for the list
local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 8)
listLayout.SortOrder = Enum.SortOrder.Name
listLayout.Parent = scrollingFrame

-- Create Padding
local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 8)
padding.PaddingBottom = UDim.new(0, 8)
padding.PaddingLeft = UDim.new(0, 8)
padding.PaddingRight = UDim.new(0, 8)
padding.Parent = scrollingFrame

-- Store update functions for refresh
local playerUpdateFunctions = {}

-- Forward declare createPlayerInfoUI
local createPlayerInfoUI

-- Function to create player info UI
createPlayerInfoUI = function(targetPlayer)
    -- Check if UI already exists
    local existingUI = screenGui:FindFirstChild("PlayerInfo_" .. targetPlayer.Name)
    if existingUI then
        existingUI:Destroy()
    end
    
    -- Create info frame
    local infoFrame = Instance.new("Frame")
    infoFrame.Name = "PlayerInfo_" .. targetPlayer.Name
    infoFrame.Size = UDim2.new(0, 350, 0, 500)
    infoFrame.Position = UDim2.new(0.5, -175, 0.5, -250)
    infoFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    infoFrame.BorderSizePixel = 0
    infoFrame.Parent = screenGui
    infoFrame.ZIndex = 10
    
    local infoCorner = Instance.new("UICorner")
    infoCorner.CornerRadius = UDim.new(0, 10)
    infoCorner.Parent = infoFrame
    
    local infoBorder = Instance.new("UIStroke")
    infoBorder.Color = Color3.fromRGB(50, 50, 50)
    infoBorder.Thickness = 1
    infoBorder.Transparency = 0.2
    infoBorder.Parent = infoFrame
    
    -- Title bar
    local infoTitleBar = Instance.new("Frame")
    infoTitleBar.Name = "TitleBar"
    infoTitleBar.Size = UDim2.new(1, 0, 0, 45)
    infoTitleBar.Position = UDim2.new(0, 0, 0, 0)
    infoTitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    infoTitleBar.BorderSizePixel = 0
    infoTitleBar.Parent = infoFrame
    
    local infoTitleCorner = Instance.new("UICorner")
    infoTitleCorner.CornerRadius = UDim.new(0, 10)
    infoTitleCorner.Parent = infoTitleBar
    
    -- Title text
    local infoTitleText = Instance.new("TextLabel")
    infoTitleText.Name = "TitleText"
    infoTitleText.Size = UDim2.new(1, -50, 1, 0)
    infoTitleText.Position = UDim2.new(0, 15, 0, 0)
    infoTitleText.BackgroundTransparency = 1
    local displayName = targetPlayer.DisplayName ~= targetPlayer.Name and targetPlayer.DisplayName or targetPlayer.Name
    infoTitleText.Text = displayName .. " (" .. targetPlayer.Name .. ")"
    infoTitleText.TextColor3 = Color3.fromRGB(240, 240, 240)
    infoTitleText.TextSize = 16
    infoTitleText.Font = Enum.Font.GothamSemibold
    infoTitleText.TextXAlignment = Enum.TextXAlignment.Left
    infoTitleText.TextTruncate = Enum.TextTruncate.AtEnd
    infoTitleText.Parent = infoTitleBar
    
    -- Close button
    local infoCloseButton = Instance.new("TextButton")
    infoCloseButton.Name = "CloseButton"
    infoCloseButton.Size = UDim2.new(0, 32, 0, 32)
    infoCloseButton.Position = UDim2.new(1, -40, 0, 6.5)
    infoCloseButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    infoCloseButton.Text = "×"
    infoCloseButton.TextColor3 = Color3.fromRGB(220, 220, 220)
    infoCloseButton.TextSize = 18
    infoCloseButton.Font = Enum.Font.GothamBold
    infoCloseButton.BorderSizePixel = 0
    infoCloseButton.Parent = infoTitleBar
    
    local infoCloseCorner = Instance.new("UICorner")
    infoCloseCorner.CornerRadius = UDim.new(0, 6)
    infoCloseCorner.Parent = infoCloseButton
    
    infoCloseButton.MouseEnter:Connect(function()
        infoCloseButton.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
    end)
    infoCloseButton.MouseLeave:Connect(function()
        infoCloseButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    end)
    infoCloseButton.MouseButton1Click:Connect(function()
        infoFrame:Destroy()
    end)
    
    -- Make draggable
    local dragging = false
    local dragInput, dragStart, startPos
    local function update(input)
        local delta = input.Position - dragStart
        infoFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
    infoTitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = infoFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    infoTitleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
    
    -- Content area
    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(1, -20, 1, -65)
    contentFrame.Position = UDim2.new(0, 10, 0, 55)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = infoFrame
    
    -- Avatar
    local avatarImage = Instance.new("ImageLabel")
    avatarImage.Name = "Avatar"
    avatarImage.Size = UDim2.new(0, 100, 0, 100)
    avatarImage.Position = UDim2.new(0.5, -50, 0, 10)
    avatarImage.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    avatarImage.BorderSizePixel = 0
    avatarImage.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. targetPlayer.UserId .. "&width=150&height=150&format=png"
    avatarImage.Parent = contentFrame
    
    local avatarCorner = Instance.new("UICorner")
    avatarCorner.CornerRadius = UDim.new(0, 8)
    avatarCorner.Parent = avatarImage
    
    -- Stats container
    local statsList = Instance.new("ScrollingFrame")
    statsList.Name = "StatsList"
    statsList.Size = UDim2.new(1, 0, 1, -110)
    statsList.Position = UDim2.new(0, 0, 0, 120)
    statsList.BackgroundTransparency = 1
    statsList.BorderSizePixel = 0
    statsList.ScrollBarThickness = 6
    statsList.ScrollBarImageColor3 = Color3.fromRGB(70, 70, 70)
    statsList.Parent = contentFrame
    
    local statsListLayout = Instance.new("UIListLayout")
    statsListLayout.Padding = UDim.new(0, 5)
    statsListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    statsListLayout.Parent = statsList
    
    local statsListPadding = Instance.new("UIPadding")
    statsListPadding.PaddingTop = UDim.new(0, 0)
    statsListPadding.PaddingBottom = UDim.new(0, 5)
    statsListPadding.PaddingLeft = UDim.new(0, 0)
    statsListPadding.PaddingRight = UDim.new(0, 0)
    statsListPadding.Parent = statsList
    
    local function createStatRow(label, value)
        local row = Instance.new("Frame")
        row.Name = label
        row.Size = UDim2.new(1, 0, 0, 35)
        row.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        row.BorderSizePixel = 0
        row.Parent = statsList
        
        local rowCorner = Instance.new("UICorner")
        rowCorner.CornerRadius = UDim.new(0, 6)
        rowCorner.Parent = row
        
        local rowBorder = Instance.new("UIStroke")
        rowBorder.Color = Color3.fromRGB(60, 60, 60)
        rowBorder.Thickness = 1
        rowBorder.Transparency = 0.4
        rowBorder.Parent = row
        
        local labelText = Instance.new("TextLabel")
        labelText.Name = "Label"
        labelText.Size = UDim2.new(0, 100, 1, 0)
        labelText.Position = UDim2.new(0, 10, 0, 0)
        labelText.BackgroundTransparency = 1
        labelText.Text = label .. ":"
        labelText.TextColor3 = Color3.fromRGB(180, 180, 180)
        labelText.TextSize = 14
        labelText.Font = Enum.Font.Gotham
        labelText.TextXAlignment = Enum.TextXAlignment.Left
        labelText.Parent = row
        
        local valueText = Instance.new("TextLabel")
        valueText.Name = "Value"
        valueText.Size = UDim2.new(1, -120, 1, 0)
        valueText.Position = UDim2.new(0, 110, 0, 0)
        valueText.BackgroundTransparency = 1
        valueText.Text = value
        valueText.TextColor3 = Color3.fromRGB(230, 230, 230)
        valueText.TextSize = 14
        valueText.Font = Enum.Font.GothamBold
        valueText.TextXAlignment = Enum.TextXAlignment.Left
        valueText.Parent = row
        
        return valueText
    end
    
    -- Create stat rows with LayoutOrder
    local receivedStat = createStatRow("Received", "0")
    receivedStat.Parent.LayoutOrder = 1
    local donatedStat = createStatRow("Donated", "0")
    donatedStat.Parent.LayoutOrder = 2
    local timeStat = createStatRow("Played Time", "0m")
    timeStat.Parent.LayoutOrder = 3
    local creditsStat = createStatRow("Credits", "0")
    creditsStat.Parent.LayoutOrder = 4
    
    -- Settings section header
    local settingsHeaderFrame = Instance.new("Frame")
    settingsHeaderFrame.Name = "SettingsHeader"
    settingsHeaderFrame.Size = UDim2.new(1, 0, 0, 35)
    settingsHeaderFrame.BackgroundTransparency = 1
    settingsHeaderFrame.LayoutOrder = 5
    settingsHeaderFrame.Parent = statsList
    
    local settingsHeader = Instance.new("TextLabel")
    settingsHeader.Name = "HeaderText"
    settingsHeader.Size = UDim2.new(1, -20, 1, 0)
    settingsHeader.Position = UDim2.new(0, 10, 0, 0)
    settingsHeader.BackgroundTransparency = 1
    settingsHeader.Text = "Their Settings"
    settingsHeader.TextColor3 = Color3.fromRGB(240, 240, 240)
    settingsHeader.TextSize = 16
    settingsHeader.Font = Enum.Font.GothamBold
    settingsHeader.TextXAlignment = Enum.TextXAlignment.Left
    settingsHeader.Parent = settingsHeaderFrame
    
    -- Divider line
    local divider = Instance.new("Frame")
    divider.Name = "Divider"
    divider.Size = UDim2.new(1, -20, 0, 1)
    divider.Position = UDim2.new(0, 10, 1, -1)
    divider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    divider.BorderSizePixel = 0
    divider.Parent = settingsHeaderFrame
    
    -- Create ALL settings rows (must be after header) with LayoutOrder
    local aurasStat = createStatRow("Auras", "Off")
    aurasStat.Parent.LayoutOrder = 6
    local giftsStat = createStatRow("Gifts", "Off")
    giftsStat.Parent.LayoutOrder = 7
    local pianoStat = createStatRow("Piano", "Off")
    pianoStat.Parent.LayoutOrder = 8
    local rankStat = createStatRow("Title", "Off")
    rankStat.Parent.LayoutOrder = 9
    local shadowStat = createStatRow("Shadow", "Off")
    shadowStat.Parent.LayoutOrder = 10
    local teleportStat = createStatRow("Teleport", "Off")
    teleportStat.Parent.LayoutOrder = 11
    local timeSettingStat = createStatRow("Show Total Time", "Off")
    timeSettingStat.Parent.LayoutOrder = 12
    
    -- Update functions
    local function updateReceived()
        local tipJarStats = targetPlayer:FindFirstChild("TipJarStats")
        if not tipJarStats then
            tipJarStats = targetPlayer:WaitForChild("TipJarStats", 1)
        end
        if tipJarStats then
            -- Try direct access first
            local raised = tipJarStats.Raised
            if not raised then
                raised = tipJarStats:FindFirstChild("Raised")
            end
            local donated = tipJarStats.Donated
            if not donated then
                donated = tipJarStats:FindFirstChild("Donated")
            end
            
            if raised then
                -- Check if it's IntValue or NumberValue
                if raised:IsA("IntValue") or raised:IsA("NumberValue") then
                    local raisedValue = raised.Value
                    local displayText = tostring(raisedValue)
                    
                    -- Calculate 60% of received value
                    local sixtyPercent = math.floor(raisedValue * 0.6)
                    displayText = displayText .. " (" .. tostring(sixtyPercent) .. ")"
                    
                    receivedStat.Text = displayText
                else
                    receivedStat.Text = "0"
                end
            else
                receivedStat.Text = "0"
            end
        else
            receivedStat.Text = "0"
        end
    end
    
    local function updateDonated()
        local tipJarStats = targetPlayer:FindFirstChild("TipJarStats")
        if not tipJarStats then
            tipJarStats = targetPlayer:WaitForChild("TipJarStats", 1)
        end
        if tipJarStats then
            -- Try direct access first
            local donated = tipJarStats.Donated
            if not donated then
                donated = tipJarStats:FindFirstChild("Donated")
            end
            if donated then
                -- Check if it's IntValue or NumberValue
                if donated:IsA("IntValue") or donated:IsA("NumberValue") then
                    donatedStat.Text = tostring(donated.Value)
                else
                    donatedStat.Text = "0"
                end
            else
                donatedStat.Text = "0"
            end
        else
            donatedStat.Text = "0"
        end
    end
    
    local function updateTime()
        local minutes = nil
        
        -- Check if Minutes is directly under player first
        local directMinutes = targetPlayer:FindFirstChild("Minutes")
        if directMinutes then
            minutes = directMinutes
        else
            -- Otherwise check leaderstats
            local leaderstats = targetPlayer:FindFirstChild("leaderstats")
            if leaderstats then
                minutes = leaderstats:FindFirstChild("Minutes")
            end
        end
        
        if minutes then
            local totalMinutes = minutes.Value
            if totalMinutes >= 60 then
                local hours = math.floor(totalMinutes / 60)
                local mins = totalMinutes % 60
                timeStat.Text = hours .. "h " .. mins .. "m"
            else
                timeStat.Text = totalMinutes .. "m"
            end
        else
            timeStat.Text = "0m"
        end
    end
    
    local function updateCredits()
        local credits = targetPlayer:FindFirstChild("Credits")
        if credits then
            creditsStat.Text = tostring(credits.Value)
        else
            creditsStat.Text = "0"
        end
    end
    
    local function updateSettings()
        local settings = targetPlayer:FindFirstChild("Settings")
        if settings then
            -- Try direct access first, then FindFirstChild
            local auras = settings.Auras or settings:FindFirstChild("Auras")
            local gifts = settings.Gifts or settings:FindFirstChild("Gifts")
            local piano = settings.Piano or settings:FindFirstChild("Piano")
            local rank = settings.Rank or settings:FindFirstChild("Rank")
            local shadow = settings.Shadow or settings:FindFirstChild("Shadow")
            local teleport = settings.Teleport or settings:FindFirstChild("Teleport")
            local timeSetting = settings.Time or settings:FindFirstChild("Time")
            
            -- Check if they're BoolValue and read the value correctly
            if aurasStat then
                if auras and auras:IsA("BoolValue") then
                    aurasStat.Text = auras.Value and "On" or "Off"
                else
                    aurasStat.Text = "Off"
                end
            end
            if giftsStat then
                if gifts and gifts:IsA("BoolValue") then
                    giftsStat.Text = gifts.Value and "On" or "Off"
                else
                    giftsStat.Text = "Off"
                end
            end
            if pianoStat then
                if piano and piano:IsA("BoolValue") then
                    pianoStat.Text = piano.Value and "On" or "Off"
                else
                    pianoStat.Text = "Off"
                end
            end
            if rankStat then
                if rank and rank:IsA("BoolValue") then
                    rankStat.Text = rank.Value and "On" or "Off"
                else
                    rankStat.Text = "Off"
                end
            end
            if shadowStat then
                if shadow and shadow:IsA("BoolValue") then
                    shadowStat.Text = shadow.Value and "On" or "Off"
                else
                    shadowStat.Text = "Off"
                end
            end
            if teleportStat then
                if teleport and teleport:IsA("BoolValue") then
                    teleportStat.Text = teleport.Value and "On" or "Off"
                else
                    teleportStat.Text = "Off"
                end
            end
            if timeSettingStat then
                if timeSetting and timeSetting:IsA("BoolValue") then
                    -- Invert the value for "Show Total Time"
                    timeSettingStat.Text = timeSetting.Value and "Off" or "On"
                else
                    timeSettingStat.Text = "On"
                end
            end
        else
            if aurasStat then aurasStat.Text = "Off" end
            if giftsStat then giftsStat.Text = "Off" end
            if pianoStat then pianoStat.Text = "Off" end
            if rankStat then rankStat.Text = "Off" end
            if shadowStat then shadowStat.Text = "Off" end
            if teleportStat then teleportStat.Text = "Off" end
            if timeSettingStat then timeSettingStat.Text = "On" end
        end
    end
    
    -- Initial updates
    updateReceived()
    updateDonated()
    updateTime()
    updateCredits()
    updateSettings()
    
    -- Listen for changes
    spawn(function()
        local tipJarStats = targetPlayer:FindFirstChild("TipJarStats")
        if not tipJarStats then
            tipJarStats = targetPlayer:WaitForChild("TipJarStats", 10)
        end
        if tipJarStats then
            -- Handle Raised - try direct access first
            local raised = tipJarStats.Raised
            if not raised then
                raised = tipJarStats:FindFirstChild("Raised")
            end
            if raised then
                updateReceived()
                raised:GetPropertyChangedSignal("Value"):Connect(updateReceived)
            else
                -- Wait for Raised to potentially be created
                local success, result = pcall(function()
                    return tipJarStats:WaitForChild("Raised", 5)
                end)
                if success and result then
                    raised = result
                    updateReceived()
                    raised:GetPropertyChangedSignal("Value"):Connect(updateReceived)
                else
                    -- Listen for when Raised is added
                    tipJarStats.ChildAdded:Connect(function(child)
                        if child.Name == "Raised" then
                            updateReceived()
                            child:GetPropertyChangedSignal("Value"):Connect(updateReceived)
                        end
                    end)
                    -- Still update to show current value (or 0)
                    updateReceived()
                end
            end
            
            -- Handle Donated - try direct access first
            local donated = tipJarStats.Donated
            if not donated then
                donated = tipJarStats:FindFirstChild("Donated")
            end
            if donated then
                updateDonated()
                donated:GetPropertyChangedSignal("Value"):Connect(updateDonated)
            else
                -- Wait for Donated to potentially be created
                local success, result = pcall(function()
                    return tipJarStats:WaitForChild("Donated", 5)
                end)
                if success and result then
                    donated = result
                    updateDonated()
                    donated:GetPropertyChangedSignal("Value"):Connect(updateDonated)
                else
                    -- If Donated doesn't exist, still update to show 0
                    updateDonated()
                end
            end
        end
        
        -- Listen for Minutes changes (check both locations)
        local minutes = targetPlayer:FindFirstChild("Minutes")
        if not minutes then
            local leaderstats = targetPlayer:FindFirstChild("leaderstats")
            if not leaderstats then
                leaderstats = targetPlayer:WaitForChild("leaderstats", 10)
            end
            if leaderstats then
                minutes = leaderstats:FindFirstChild("Minutes")
            end
        end
        
        if minutes then
            updateTime()
            minutes:GetPropertyChangedSignal("Value"):Connect(updateTime)
        end
        
        local credits = targetPlayer:FindFirstChild("Credits")
        if not credits then
            credits = targetPlayer:WaitForChild("Credits", 10)
        end
        if credits then
            credits:GetPropertyChangedSignal("Value"):Connect(updateCredits)
        end
        
        local settings = targetPlayer:FindFirstChild("Settings")
        if not settings then
            settings = targetPlayer:WaitForChild("Settings", 10)
        end
        if settings then
            -- Try direct access first, then FindFirstChild
            local auras = settings.Auras or settings:FindFirstChild("Auras")
            local gifts = settings.Gifts or settings:FindFirstChild("Gifts")
            local piano = settings.Piano or settings:FindFirstChild("Piano")
            local rank = settings.Rank or settings:FindFirstChild("Rank")
            local shadow = settings.Shadow or settings:FindFirstChild("Shadow")
            local teleport = settings.Teleport or settings:FindFirstChild("Teleport")
            local timeSetting = settings.Time or settings:FindFirstChild("Time")
            
            -- Only connect to BoolValue changes
            if auras and auras:IsA("BoolValue") then
                auras:GetPropertyChangedSignal("Value"):Connect(updateSettings)
            end
            if gifts and gifts:IsA("BoolValue") then
                gifts:GetPropertyChangedSignal("Value"):Connect(updateSettings)
            end
            if piano and piano:IsA("BoolValue") then
                piano:GetPropertyChangedSignal("Value"):Connect(updateSettings)
            end
            if rank and rank:IsA("BoolValue") then
                rank:GetPropertyChangedSignal("Value"):Connect(updateSettings)
            end
            if shadow and shadow:IsA("BoolValue") then
                shadow:GetPropertyChangedSignal("Value"):Connect(updateSettings)
            end
            if teleport and teleport:IsA("BoolValue") then
                teleport:GetPropertyChangedSignal("Value"):Connect(updateSettings)
            end
            if timeSetting and timeSetting:IsA("BoolValue") then
                timeSetting:GetPropertyChangedSignal("Value"):Connect(updateSettings)
            end
        end
    end)
    
    -- Update canvas size
    statsListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        local contentSize = statsListLayout.AbsoluteContentSize
        statsList.CanvasSize = UDim2.new(0, 0, 0, contentSize.Y + 10)
    end)
    
    -- Initial canvas size update
    task.wait()
    local contentSize = statsListLayout.AbsoluteContentSize
    statsList.CanvasSize = UDim2.new(0, 0, 0, contentSize.Y + 10)
    
    -- Animate in
    infoFrame.Size = UDim2.new(0, 0, 0, 0)
    infoFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    infoFrame.BackgroundTransparency = 1
    
    local openTween = TweenService:Create(
        infoFrame,
        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 350, 0, 500), Position = UDim2.new(0.5, -175, 0.5, -250), BackgroundTransparency = 0}
    )
    openTween:Play()
end

-- Function to create a player entry
local function createPlayerEntry(player)
    local entryFrame = Instance.new("Frame")
    entryFrame.Name = player.Name
    entryFrame.Size = UDim2.new(1, 0, 0, 60)
    entryFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    entryFrame.BorderSizePixel = 0
    entryFrame.Parent = scrollingFrame
    
    local entryCorner = Instance.new("UICorner")
    entryCorner.CornerRadius = UDim.new(0, 8)
    entryCorner.Parent = entryFrame
    
    -- Add subtle border effect
    local border = Instance.new("UIStroke")
    border.Color = Color3.fromRGB(60, 60, 60)
    border.Thickness = 1
    border.Transparency = 0.4
    border.Parent = entryFrame
    
    -- Player Name (DisplayName with username in parentheses)
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.Size = UDim2.new(1, -110, 0, 22)
    nameLabel.Position = UDim2.new(0, 10, 0, 4)
    nameLabel.BackgroundTransparency = 1
    local displayName = player.DisplayName ~= player.Name and player.DisplayName or player.Name
    nameLabel.Text = displayName .. " (" .. player.Name .. ")"
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextSize = 15
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.TextTruncate = Enum.TextTruncate.AtEnd
    nameLabel.Parent = entryFrame
    
    -- Update display name if it changes
    player:GetPropertyChangedSignal("DisplayName"):Connect(function()
        local newDisplayName = player.DisplayName ~= player.Name and player.DisplayName or player.Name
        nameLabel.Text = newDisplayName .. " (" .. player.Name .. ")"
    end)
    
    -- Bang Button
    local bangButton = Instance.new("TextButton")
    bangButton.Name = "BangButton"
    bangButton.Size = UDim2.new(0, 22, 0, 22)
    bangButton.Position = UDim2.new(1, -80, 0, 4)
    bangButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    bangButton.Text = "💥"
    bangButton.TextColor3 = Color3.fromRGB(220, 220, 220)
    bangButton.TextSize = 14
    bangButton.Font = Enum.Font.GothamBold
    bangButton.BorderSizePixel = 0
    bangButton.Parent = entryFrame
    
    local bangCorner = Instance.new("UICorner")
    bangCorner.CornerRadius = UDim.new(0, 4)
    bangCorner.Parent = bangButton
    
    -- Bang button hover effect
    bangButton.MouseEnter:Connect(function()
        bangButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end)
    bangButton.MouseLeave:Connect(function()
        bangButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end)
    
    -- Bang button click
    bangButton.MouseButton1Click:Connect(function()
        bangPlayer(player)
    end)
    
    -- Teleport Button
    local teleportButton = Instance.new("TextButton")
    teleportButton.Name = "TeleportButton"
    teleportButton.Size = UDim2.new(0, 22, 0, 22)
    teleportButton.Position = UDim2.new(1, -56, 0, 4)
    teleportButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    teleportButton.Text = "→"
    teleportButton.TextColor3 = Color3.fromRGB(220, 220, 220)
    teleportButton.TextSize = 14
    teleportButton.Font = Enum.Font.GothamBold
    teleportButton.BorderSizePixel = 0
    teleportButton.Parent = entryFrame
    
    local teleportCorner = Instance.new("UICorner")
    teleportCorner.CornerRadius = UDim.new(0, 4)
    teleportCorner.Parent = teleportButton
    
    -- Teleport button hover effect
    teleportButton.MouseEnter:Connect(function()
        teleportButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end)
    teleportButton.MouseLeave:Connect(function()
        teleportButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end)
    
    -- Teleport button click
    teleportButton.MouseButton1Click:Connect(function()
        local localPlayer = Players.LocalPlayer
        if localPlayer and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local targetCharacter = player.Character
            if targetCharacter and targetCharacter:FindFirstChild("HumanoidRootPart") then
                localPlayer.Character.HumanoidRootPart.CFrame = targetCharacter.HumanoidRootPart.CFrame
            end
        end
    end)
    
    -- Info Button
    local infoButton = Instance.new("ImageButton")
    infoButton.Name = "InfoButton"
    infoButton.Size = UDim2.new(0, 22, 0, 22)
    infoButton.Position = UDim2.new(1, -32, 0, 4)
    infoButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    infoButton.BorderSizePixel = 0
    infoButton.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=150&height=150&format=png"
    infoButton.Parent = entryFrame
    
    local infoCorner = Instance.new("UICorner")
    infoCorner.CornerRadius = UDim.new(0, 4)
    infoCorner.Parent = infoButton
    
    -- Info button hover effect
    infoButton.MouseEnter:Connect(function()
        infoButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end)
    infoButton.MouseLeave:Connect(function()
        infoButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end)
    
    -- Info button click
    infoButton.MouseButton1Click:Connect(function()
        createPlayerInfoUI(player)
    end)
    
    -- Stats container
    local statsContainer = Instance.new("Frame")
    statsContainer.Name = "StatsContainer"
    statsContainer.Size = UDim2.new(1, -20, 0, 30)
    statsContainer.Position = UDim2.new(0, 10, 0, 28)
    statsContainer.BackgroundTransparency = 1
    statsContainer.Parent = entryFrame
    
    -- Received section
    local receivedContainer = Instance.new("Frame")
    receivedContainer.Name = "ReceivedContainer"
    receivedContainer.Size = UDim2.new(0.33, 0, 1, 0)
    receivedContainer.Position = UDim2.new(0, 0, 0, 0)
    receivedContainer.BackgroundTransparency = 1
    receivedContainer.Parent = statsContainer
    
    local receivedLabel = Instance.new("TextLabel")
    receivedLabel.Name = "ReceivedLabel"
    receivedLabel.Size = UDim2.new(0, 55, 1, 0)
    receivedLabel.Position = UDim2.new(0, 0, 0, 0)
    receivedLabel.BackgroundTransparency = 1
    receivedLabel.Text = "Received:"
    receivedLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    receivedLabel.TextSize = 12
    receivedLabel.Font = Enum.Font.Gotham
    receivedLabel.TextXAlignment = Enum.TextXAlignment.Left
    receivedLabel.Parent = receivedContainer
    
    local receivedValue = Instance.new("TextLabel")
    receivedValue.Name = "ReceivedValue"
    receivedValue.Size = UDim2.new(1, -60, 1, 0)
    receivedValue.Position = UDim2.new(0, 60, 0, 0)
    receivedValue.BackgroundTransparency = 1
    receivedValue.Text = "0"
    receivedValue.TextColor3 = Color3.fromRGB(230, 230, 230)
    receivedValue.TextSize = 12
    receivedValue.Font = Enum.Font.GothamBold
    receivedValue.TextXAlignment = Enum.TextXAlignment.Left
    receivedValue.Parent = receivedContainer
    
    -- Donated section
    local donatedContainer = Instance.new("Frame")
    donatedContainer.Name = "DonatedContainer"
    donatedContainer.Size = UDim2.new(0.33, 0, 1, 0)
    donatedContainer.Position = UDim2.new(0.33, -2, 0, 0)
    donatedContainer.BackgroundTransparency = 1
    donatedContainer.Parent = statsContainer
    
    -- Played Time section
    local timeContainer = Instance.new("Frame")
    timeContainer.Name = "TimeContainer"
    timeContainer.Size = UDim2.new(0.34, 0, 1, 0)
    timeContainer.Position = UDim2.new(0.66, 0, 0, 0)
    timeContainer.BackgroundTransparency = 1
    timeContainer.Parent = statsContainer
    
    local timeLabel = Instance.new("TextLabel")
    timeLabel.Name = "TimeLabel"
    timeLabel.Size = UDim2.new(0, 50, 1, 0)
    timeLabel.Position = UDim2.new(0, 0, 0, 0)
    timeLabel.BackgroundTransparency = 1
    timeLabel.Text = "Time:"
    timeLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    timeLabel.TextSize = 12
    timeLabel.Font = Enum.Font.Gotham
    timeLabel.TextXAlignment = Enum.TextXAlignment.Left
    timeLabel.Parent = timeContainer
    
    local timeValue = Instance.new("TextLabel")
    timeValue.Name = "TimeValue"
    timeValue.Size = UDim2.new(1, -55, 1, 0)
    timeValue.Position = UDim2.new(0, 55, 0, 0)
    timeValue.BackgroundTransparency = 1
    timeValue.Text = "0m"
    timeValue.TextColor3 = Color3.fromRGB(230, 230, 230)
    timeValue.TextSize = 12
    timeValue.Font = Enum.Font.GothamBold
    timeValue.TextXAlignment = Enum.TextXAlignment.Left
    timeValue.Parent = timeContainer
    
    local donatedLabel = Instance.new("TextLabel")
    donatedLabel.Name = "DonatedLabel"
    donatedLabel.Size = UDim2.new(0, 55, 1, 0)
    donatedLabel.Position = UDim2.new(0, 0, 0, 0)
    donatedLabel.BackgroundTransparency = 1
    donatedLabel.Text = "Donated:"
    donatedLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    donatedLabel.TextSize = 12
    donatedLabel.Font = Enum.Font.Gotham
    donatedLabel.TextXAlignment = Enum.TextXAlignment.Left
    donatedLabel.Parent = donatedContainer
    
    local donatedValue = Instance.new("TextLabel")
    donatedValue.Name = "DonatedValue"
    donatedValue.Size = UDim2.new(1, -60, 1, 0)
    donatedValue.Position = UDim2.new(0, 60, 0, 0)
    donatedValue.BackgroundTransparency = 1
    donatedValue.Text = "0"
    donatedValue.TextColor3 = Color3.fromRGB(230, 230, 230)
    donatedValue.TextSize = 12
    donatedValue.Font = Enum.Font.GothamBold
    donatedValue.TextXAlignment = Enum.TextXAlignment.Left
    donatedValue.Parent = donatedContainer
    
    -- Function to update received amount (from Raised property)
    local function updateReceived()
        local tipJarStats = player:FindFirstChild("TipJarStats")
        if not tipJarStats then
            tipJarStats = player:WaitForChild("TipJarStats", 1)
        end
        if tipJarStats then
            -- Try direct access first
            local raised = tipJarStats.Raised
            if not raised then
                raised = tipJarStats:FindFirstChild("Raised")
            end
            local donated = tipJarStats.Donated
            if not donated then
                donated = tipJarStats:FindFirstChild("Donated")
            end
            
            if raised then
                -- Check if it's IntValue or NumberValue
                if raised:IsA("IntValue") or raised:IsA("NumberValue") then
                    local raisedValue = raised.Value
                    local displayText = tostring(raisedValue)
                    
                    -- Calculate 60% of received value
                    local sixtyPercent = math.floor(raisedValue * 0.6)
                    displayText = displayText .. " (" .. tostring(sixtyPercent) .. ")"
                    
                    receivedValue.Text = displayText
                    receivedValue.TextColor3 = Color3.fromRGB(230, 230, 230)
                    return
                end
            end
        end
        receivedValue.Text = "0"
        receivedValue.TextColor3 = Color3.fromRGB(150, 150, 150)
    end
    
    -- Function to update donated amount
    local function updateDonated()
        local tipJarStats = player:FindFirstChild("TipJarStats")
        if not tipJarStats then
            tipJarStats = player:WaitForChild("TipJarStats", 1)
        end
        if tipJarStats then
            -- Try direct access first
            local donated = tipJarStats.Donated
            if not donated then
                donated = tipJarStats:FindFirstChild("Donated")
            end
            if donated then
                -- Check if it's IntValue or NumberValue
                if donated:IsA("IntValue") or donated:IsA("NumberValue") then
                    donatedValue.Text = tostring(donated.Value)
                    donatedValue.TextColor3 = Color3.fromRGB(230, 230, 230)
                    return
                end
            end
        end
        donatedValue.Text = "0"
        donatedValue.TextColor3 = Color3.fromRGB(150, 150, 150)
    end
    
    -- Function to update played time
    local function updateTime()
        local minutes = nil
        
        -- Check if Minutes is directly under player first
        local directMinutes = player:FindFirstChild("Minutes")
        if directMinutes then
            minutes = directMinutes
        else
            -- Otherwise check leaderstats
            local leaderstats = player:FindFirstChild("leaderstats")
            if leaderstats then
                minutes = leaderstats:FindFirstChild("Minutes")
            end
        end
        
        if minutes then
            local totalMinutes = minutes.Value
            if totalMinutes >= 60 then
                local hours = math.floor(totalMinutes / 60)
                local mins = totalMinutes % 60
                timeValue.Text = hours .. "h " .. mins .. "m"
            else
                timeValue.Text = totalMinutes .. "m"
            end
            timeValue.TextColor3 = Color3.fromRGB(230, 230, 230)
        else
            timeValue.Text = "0m"
            timeValue.TextColor3 = Color3.fromRGB(150, 150, 150)
        end
    end
    
    -- Initial updates (instant, no waiting)
    updateReceived()
    updateDonated()
    updateTime()
    
    -- Store update functions for refresh
    playerUpdateFunctions[player.Name] = {
        updateReceived = updateReceived,
        updateDonated = updateDonated,
        updateTime = updateTime
    }
    
    -- Connect to changes asynchronously (non-blocking)
    spawn(function()
        local tipJarStats = player:FindFirstChild("TipJarStats")
        if not tipJarStats then
            tipJarStats = player:WaitForChild("TipJarStats", 10)
        end
        
        if tipJarStats then
            -- Try direct access first
            local raised = tipJarStats.Raised
            if raised then
                updateReceived()
                raised:GetPropertyChangedSignal("Value"):Connect(updateReceived)
            else
                -- Try FindFirstChild
                raised = tipJarStats:FindFirstChild("Raised")
                if raised then
                    updateReceived()
                    raised:GetPropertyChangedSignal("Value"):Connect(updateReceived)
                else
                    -- Wait for Raised to potentially be created
                    local success, result = pcall(function()
                        return tipJarStats:WaitForChild("Raised", 5)
                    end)
                    if success and result then
                        raised = result
                        updateReceived()
                        raised:GetPropertyChangedSignal("Value"):Connect(updateReceived)
                    else
                        -- Listen for when Raised is added
                        tipJarStats.ChildAdded:Connect(function(child)
                            if child.Name == "Raised" then
                                updateReceived()
                                child:GetPropertyChangedSignal("Value"):Connect(updateReceived)
                            end
                        end)
                        -- Still update to show current value (or 0)
                        updateReceived()
                    end
                end
            end
            
            -- Always update Donated
            updateDonated()
            
            -- Try to find Donated and listen for changes - try direct access first
            local donated = tipJarStats.Donated
            if not donated then
                donated = tipJarStats:FindFirstChild("Donated")
            end
            if donated then
                donated:GetPropertyChangedSignal("Value"):Connect(updateDonated)
            else
                -- Wait for Donated to potentially be created
                local success, result = pcall(function()
                    return tipJarStats:WaitForChild("Donated", 5)
                end)
                if success and result then
                    donated = result
                    updateDonated()
                    donated:GetPropertyChangedSignal("Value"):Connect(updateDonated)
                end
            end
        end
        
        -- Listen for Minutes changes (check both locations)
        local minutes = player:FindFirstChild("Minutes")
        if not minutes then
            local leaderstats = player:FindFirstChild("leaderstats")
            if not leaderstats then
                leaderstats = player:WaitForChild("leaderstats", 10)
            end
            if leaderstats then
                minutes = leaderstats:FindFirstChild("Minutes")
            end
        end
        
        if minutes then
            updateTime()
            minutes:GetPropertyChangedSignal("Value"):Connect(updateTime)
        end
    end)
    
    return entryFrame
end

-- Function to refresh all stats
local function refreshAllStats()
    for playerName, updateFuncs in pairs(playerUpdateFunctions) do
        if updateFuncs.updateReceived then
            updateFuncs.updateReceived()
        end
        if updateFuncs.updateDonated then
            updateFuncs.updateDonated()
        end
        if updateFuncs.updateTime then
            updateFuncs.updateTime()
        end
    end
end

-- Search functionality
local searchQuery = ""
local searchTextBox = nil
local searchFrame = nil

-- Function to filter and update the list
local function updateList(filterText)
    filterText = filterText or ""
    filterText = string.lower(filterText)
    
    -- Clear existing entries and update functions
    for _, child in pairs(scrollingFrame:GetChildren()) do
        if child:IsA("Frame") and child.Name ~= "UIListLayout" and child.Name ~= "UIPadding" then
            playerUpdateFunctions[child.Name] = nil
            child:Destroy()
        end
    end
    
    -- Add filtered players
    for _, player in pairs(Players:GetPlayers()) do
        local playerName = string.lower(player.Name)
        local displayName = string.lower(player.DisplayName)
        
        -- Show player if search is empty or matches name/display name
        if filterText == "" or string.find(playerName, filterText, 1, true) or string.find(displayName, filterText, 1, true) then
            createPlayerEntry(player)
        end
    end
    
    -- Update canvas size immediately
    task.wait()
    local contentSize = listLayout.AbsoluteContentSize
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, contentSize.Y + 16)
end

-- Function to toggle search box
local function toggleSearch()
    if searchFrame and searchFrame.Visible then
        -- Hide search
        searchFrame.Visible = false
        searchQuery = ""
        searchTextBox.Text = ""
        -- Adjust scrolling frame back
        scrollingFrame.Position = UDim2.new(0, 10, 0, 50)
        scrollingFrame.Size = UDim2.new(1, -20, 1, -65)
        updateList("")
    else
        -- Show search
        if not searchFrame then
            -- Create search frame
            searchFrame = Instance.new("Frame")
            searchFrame.Name = "SearchFrame"
            searchFrame.Size = UDim2.new(1, -20, 0, 35)
            searchFrame.Position = UDim2.new(0, 10, 0, 50)
            searchFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            searchFrame.BorderSizePixel = 0
            searchFrame.Parent = mainFrame
            searchFrame.ZIndex = 5
            
            local searchFrameCorner = Instance.new("UICorner")
            searchFrameCorner.CornerRadius = UDim.new(0, 6)
            searchFrameCorner.Parent = searchFrame
            
            local searchFrameBorder = Instance.new("UIStroke")
            searchFrameBorder.Color = Color3.fromRGB(50, 50, 50)
            searchFrameBorder.Thickness = 1
            searchFrameBorder.Transparency = 0.3
            searchFrameBorder.Parent = searchFrame
            
            -- Search text box
            searchTextBox = Instance.new("TextBox")
            searchTextBox.Name = "SearchTextBox"
            searchTextBox.Size = UDim2.new(1, -10, 1, -10)
            searchTextBox.Position = UDim2.new(0, 5, 0, 5)
            searchTextBox.BackgroundTransparency = 1
            searchTextBox.Text = ""
            searchTextBox.PlaceholderText = "Search players..."
            searchTextBox.TextColor3 = Color3.fromRGB(240, 240, 240)
            searchTextBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
            searchTextBox.TextSize = 14
            searchTextBox.Font = Enum.Font.Gotham
            searchTextBox.TextXAlignment = Enum.TextXAlignment.Left
            searchTextBox.ClearTextOnFocus = false
            searchTextBox.Parent = searchFrame
            
            -- Search text changed
            searchTextBox:GetPropertyChangedSignal("Text"):Connect(function()
                searchQuery = searchTextBox.Text
                updateList(searchQuery)
            end)
        end
        searchFrame.Visible = true
        -- Adjust scrolling frame to make room for search
        scrollingFrame.Position = UDim2.new(0, 10, 0, 90)
        scrollingFrame.Size = UDim2.new(1, -20, 1, -105)
        searchTextBox:CaptureFocus()
    end
end

-- Connect search button
searchButton.MouseButton1Click:Connect(toggleSearch)

-- Update canvas size when content changes
listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    local contentSize = listLayout.AbsoluteContentSize
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, contentSize.Y + 16)
end)

-- Initial update
updateList()

-- Listen for players joining
Players.PlayerAdded:Connect(function(player)
    -- Only add if search is empty or player matches search
    if searchQuery == "" then
        createPlayerEntry(player)
    else
        local playerName = string.lower(player.Name)
        local displayName = string.lower(player.DisplayName)
        local filterText = string.lower(searchQuery)
        if string.find(playerName, filterText, 1, true) or string.find(displayName, filterText, 1, true) then
            createPlayerEntry(player)
        end
    end
end)

-- Listen for players leaving
Players.PlayerRemoving:Connect(function(player)
    local entry = scrollingFrame:FindFirstChild(player.Name)
    if entry then
        playerUpdateFunctions[player.Name] = nil
        entry:Destroy()
    end
end)


-- Connect avatar icon click handler after function is defined
avatarIcon.MouseButton1Click:Connect(function()
    local currentLocalPlayer = Players.LocalPlayer
    if currentLocalPlayer then
        createPlayerInfoUI(currentLocalPlayer)
    end
end)

print("Tip Stats GUI loaded successfully!")

