-- Tip Stats GUI Script
-- Displays all players' TipJarStats.Donated values in a scrollable list

-- Version system to ensure only one instance runs at a time
local SCRIPT_VERSION = "1.3.0released"

-- Function to compare version strings (e.g., "0.5beta" vs "0.6beta" or "0.5.1beta")
local function compareVersions(version1, version2)
    -- Parse version string into numeric parts (e.g., "0.5.1beta" -> {0, 5, 1})
    local function parseVersion(versionStr)
        if type(versionStr) == "number" then
            return {versionStr}
        end
        local versionStrTxt = tostring(versionStr)
        -- Match the numeric part (e.g., "0.5.1" from "0.5.1beta")
        local numericPart = string.match(versionStrTxt, "^([%d%.]+)")
        if not numericPart then
            return {0}
        end
        
        -- Split by dots to get version parts
        local parts = {}
        for part in string.gmatch(numericPart, "([%d]+)") do
            table.insert(parts, tonumber(part) or 0)
        end
        
        return parts
    end
    
    local parts1 = parseVersion(version1)
    local parts2 = parseVersion(version2)
    
    -- Compare version parts (major.minor.patch)
    local maxParts = math.max(#parts1, #parts2)
    for i = 1, maxParts do
        local part1 = parts1[i] or 0
        local part2 = parts2[i] or 0
        
        if part1 > part2 then
            return 1  -- version1 is newer
        elseif part1 < part2 then
            return -1  -- version2 is newer
        end
    end
    
    -- If all numeric parts are equal, compare as strings (handles "0.5beta" vs "0.5alpha")
    local str1 = tostring(version1)
    local str2 = tostring(version2)
    if str1 > str2 then
        return 1
    elseif str1 < str2 then
        return -1
    else
        return 0  -- versions are equal
    end
end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TextService = game:GetService("TextService")
local HttpService = game:GetService("HttpService")
local TextChatService = game:GetService("TextChatService")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local VoiceChatService = game:GetService("VoiceChatService")

-- Version check and cleanup system
local versionTrackerName = "TipStatsGUI_VersionTracker"
local versionTracker = ReplicatedStorage:FindFirstChild(versionTrackerName)

if versionTracker then
    local existingVersion = versionTracker:GetAttribute("Version") or "0"
    local comparison = compareVersions(existingVersion, SCRIPT_VERSION)
    
    if comparison >= 0 then
        -- A newer or equal version is already running, clean up and exit
        print("TipStatsGUI: A newer or equal version (" .. tostring(existingVersion) .. ") is already running. Exiting this instance.")
        
        -- Clean up any existing UIs from this instance
        pcall(function()
            local existingScreenGui = Players.LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("TipStatsGUI")
            if existingScreenGui then
                existingScreenGui:Destroy()
            end
        end)
        
        return -- Exit script
    else
        -- This version is newer, update the tracker
        versionTracker:SetAttribute("Version", SCRIPT_VERSION)
        print("TipStatsGUI: Updated to version " .. tostring(SCRIPT_VERSION))
    end
else
    -- First instance, create tracker
    versionTracker = Instance.new("StringValue")
    versionTracker.Name = versionTrackerName
    versionTracker:SetAttribute("Version", SCRIPT_VERSION)
    versionTracker.Parent = ReplicatedStorage
    print("TipStatsGUI: Initialized version " .. tostring(SCRIPT_VERSION))
end

-- Script running flag (set to false to stop all processes)
local scriptRunning = true

-- Track all connections for cleanup
local allConnections = {}
local function trackConnection(connection)
    if connection then
        table.insert(allConnections, connection)
    end
    return connection
end

-- Cleanup function to close all UIs when a newer version is detected
local function cleanupAllUIs()
    if not scriptRunning then
        return -- Already cleaned up
    end
    
    scriptRunning = false
    
    print("TipStatsGUI: Starting cleanup of old instance...")
    
    -- Disconnect ALL tracked connections first
    pcall(function()
        for _, connection in ipairs(allConnections) do
            if connection and typeof(connection) == "RBXScriptConnection" then
                pcall(function()
                    connection:Disconnect()
                end)
            end
        end
        allConnections = {}
    end)
    
    pcall(function()
        -- Stop all active functions first
        -- Unbang any banged player
        if currentBangedPlayer then
            unbangPlayer()
        end
        
        -- Unspy any spied player
        if viewing then
            unspyPlayer()
        end
        
        -- Clear hover states
        if hoverPreviewDelayHandle then
            task.cancel(hoverPreviewDelayHandle)
            hoverPreviewDelayHandle = nil
        end
        if hoverCharacterAddedConnection then
            hoverCharacterAddedConnection:Disconnect()
            hoverCharacterAddedConnection = nil
        end
        if hoverHighlight then
            hoverHighlight:Destroy()
            hoverHighlight = nil
        end
        hoveredPlayer = nil
        
        -- Show all hidden players (both global and individual)
        if playersHidden then
            -- Show all globally hidden players by restoring their transparency
            for player, character in pairs(hiddenCharacters) do
                if character and character.Parent then
                    -- Restore Humanoid state
                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        local originalWalkSpeed = humanoid:GetAttribute("OriginalWalkSpeed")
                        if originalWalkSpeed ~= nil then
                            humanoid.WalkSpeed = originalWalkSpeed
                            humanoid:SetAttribute("OriginalWalkSpeed", nil)
                        end
                        local originalJumpPower = humanoid:GetAttribute("OriginalJumpPower")
                        if originalJumpPower ~= nil then
                            humanoid.JumpPower = originalJumpPower
                            humanoid:SetAttribute("OriginalJumpPower", nil)
                        end
                    end
                    -- Restore all parts' transparency
                    for _, descendant in ipairs(character:GetDescendants()) do
                        if descendant:IsA("BasePart") then
                            local originalTransparency = descendant:GetAttribute("OriginalTransparency")
                            if originalTransparency ~= nil then
                                descendant.Transparency = originalTransparency
                                descendant:SetAttribute("OriginalTransparency", nil)
                            end
                        end
                    end
                    -- Restore HumanoidRootPart separately
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        local originalTransparency = humanoidRootPart:GetAttribute("OriginalTransparency")
                        if originalTransparency ~= nil then
                            humanoidRootPart.Transparency = originalTransparency
                            humanoidRootPart:SetAttribute("OriginalTransparency", nil)
                        end
                    end
                end
            end
            hiddenCharacters = {}
            playersHidden = false
        end
        
        -- Show all individually hidden players
        for player, _ in pairs(individuallyHiddenPlayers) do
            if player and player.Character then
                -- Restore Humanoid state
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    local originalWalkSpeed = humanoid:GetAttribute("OriginalWalkSpeed")
                    if originalWalkSpeed ~= nil then
                        humanoid.WalkSpeed = originalWalkSpeed
                        humanoid:SetAttribute("OriginalWalkSpeed", nil)
                    end
                    local originalJumpPower = humanoid:GetAttribute("OriginalJumpPower")
                    if originalJumpPower ~= nil then
                        humanoid.JumpPower = originalJumpPower
                        humanoid:SetAttribute("OriginalJumpPower", nil)
                    end
                end
                -- Restore all parts' transparency
                for _, descendant in ipairs(player.Character:GetDescendants()) do
                    if descendant:IsA("BasePart") then
                        local originalTransparency = descendant:GetAttribute("OriginalTransparency")
                        if originalTransparency ~= nil then
                            descendant.Transparency = originalTransparency
                            descendant:SetAttribute("OriginalTransparency", nil)
                        end
                    end
                end
                -- Restore HumanoidRootPart separately
                local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    local originalTransparency = humanoidRootPart:GetAttribute("OriginalTransparency")
                    if originalTransparency ~= nil then
                        humanoidRootPart.Transparency = originalTransparency
                        humanoidRootPart:SetAttribute("OriginalTransparency", nil)
                    end
                end
            end
        end
        individuallyHiddenPlayers = {}
        
        local coreGui = nil
        pcall(function()
            coreGui = game:GetService("CoreGui")
        end)
        
        if not coreGui then
            return
        end
        
        -- Close all player info UIs from screenGui if it exists
        if screenGui then
            for _, child in ipairs(screenGui:GetChildren()) do
                if child:IsA("Frame") and string.sub(child.Name, 1, 11) == "PlayerInfo_" then
                    child:Destroy()
                end
            end
        end
        
        -- Clean up main ScreenGui from CoreGui
        -- First destroy the local reference
        if screenGui and screenGui.Parent then
            pcall(function()
                screenGui:Destroy()
            end)
            screenGui = nil
        end
        
        local mainScreenGui = coreGui:FindFirstChild("TipStatsGUI")
        if mainScreenGui then
            -- Clean up all child UIs before destroying main GUI
            -- Location Hub
            local locationHub = mainScreenGui:FindFirstChild("LocationHub")
            if locationHub then
                locationHub:Destroy()
            end
            
            -- Settings Panel
            local settingsPanel = mainScreenGui:FindFirstChild("SettingsPanel")
            if settingsPanel then
                settingsPanel:Destroy()
            end
            
            -- Hover Info Banner
            local hoverInfo = mainScreenGui:FindFirstChild("HoverInfoBanner")
            if hoverInfo then
                hoverInfo:Destroy()
            end
            
            -- All Player Info UIs
            for _, child in ipairs(mainScreenGui:GetChildren()) do
                if child:IsA("Frame") and string.sub(child.Name, 1, 11) == "PlayerInfo_" then
                    child:Destroy()
                end
            end
            
            -- Destroy main ScreenGui (this will destroy all remaining children)
            mainScreenGui:Destroy()
        end
        
        -- Clean up donation notification GUI
        local donationGui = coreGui:FindFirstChild("DonationNotificationGui")
        if donationGui then
            donationGui:Destroy()
        end
        
        -- Clean up from PlayerGui as well
        local playerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")
        if playerGui then
            local playerScreenGui = playerGui:FindFirstChild("TipStatsGUI")
            if playerScreenGui then
                playerScreenGui:Destroy()
            end
        end
        
        -- Clean up any hover highlights in workspace
        for _, descendant in ipairs(Workspace:GetDescendants()) do
            if descendant:IsA("Highlight") and descendant.Name == "TipStatsHoverOutline" then
                descendant:Destroy()
            end
        end
        
        -- Clean up version tracker if this instance created it
        if versionTracker and versionTracker:GetAttribute("Version") == SCRIPT_VERSION then
            versionTracker:Destroy()
        end
        
        print("TipStatsGUI: Cleanup completed. Old instance stopped.")
    end)
end

-- Monitor for version changes (in case a newer version starts)
-- Check more frequently for immediate detection
spawn(function()
    while scriptRunning do
        task.wait(0.1) -- Check every 0.1 seconds instead of 1 second for faster detection
        if not scriptRunning then
            return
        end
        
        if versionTracker and versionTracker:GetAttribute("Version") then
            local currentVersion = versionTracker:GetAttribute("Version")
            local comparison = compareVersions(currentVersion, SCRIPT_VERSION)
            if comparison > 0 then
                print("TipStatsGUI: Detected newer version (" .. tostring(currentVersion) .. "). Cleaning up and exiting.")
                cleanupAllUIs()
                return
            end
        else
            -- Tracker was removed, exit
            if scriptRunning then
                cleanupAllUIs()
            end
            return
        end
    end
end)

-- Also monitor for attribute changes on the version tracker for immediate detection
if versionTracker then
    trackConnection(versionTracker:GetAttributeChangedSignal("Version"):Connect(function()
        if not scriptRunning then
            return
        end
        local currentVersion = versionTracker:GetAttribute("Version")
        if currentVersion then
            local comparison = compareVersions(currentVersion, SCRIPT_VERSION)
            if comparison > 0 then
                print("TipStatsGUI: Detected newer version (" .. tostring(currentVersion) .. ") via attribute change. Cleaning up and exiting.")
                cleanupAllUIs()
            end
        end
    end))
end

local clientPlayer = Players.LocalPlayer
while not clientPlayer do
    task.wait()
    clientPlayer = Players.LocalPlayer
end

local clientMouse = nil
pcall(function()
    if clientPlayer then
        clientMouse = clientPlayer:GetMouse()
    end
end)

local INTERACTION_DISTANCE = 20

-- Bang function (from Infinite Yield) - continuously teleports yourself to target player
local bangLoop = nil
local bangDied = nil
local bangAnim = nil
local bang = nil
local currentBangedPlayer = nil

-- Spy/View function (from Infinite Yield) - view from another player's perspective
local viewing = nil
local viewDied = nil
local viewChanged = nil

-- Reset and position tracking
local lastPosition = nil
local respawnConnection = nil

-- Check if player is R15 (from Infinite Yield)
local function isR15(player)
    if player and player.Character then
        local humanoid = player.Character:FindFirstChildOfClass('Humanoid')
        if humanoid then
            return humanoid.RigType == Enum.HumanoidRigType.R15
        end
    end
    return false
end

local function getRoot(char)
    return char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
end

local function getTorso(char)
    return char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("LowerTorso") or char:FindFirstChild("HumanoidRootPart")
end

local function getPlayerFromInstance(instance)
    while instance do
        local player = Players:GetPlayerFromCharacter(instance)
        if player then
            return player
        end
        instance = instance.Parent
    end
    return nil
end

local function isPlayerWithinDistance(targetPlayer, maxDistance)
    maxDistance = maxDistance or INTERACTION_DISTANCE
    if not clientPlayer then
        return false
    end

    local localCharacter = clientPlayer.Character
    local targetCharacter = targetPlayer and targetPlayer.Character

    if not localCharacter or not targetCharacter then
        return false
    end

    local localRoot = getRoot(localCharacter)
    local targetRoot = getRoot(targetCharacter)
    if not localRoot or not targetRoot then
        return false
    end

    local distance = (localRoot.Position - targetRoot.Position).Magnitude
    return distance <= maxDistance, distance
end

local function unbangPlayer()
    if bangLoop then
        bangLoop:Disconnect()
        bangLoop = nil
    end
    if bangDied then
        bangDied:Disconnect()
        bangDied = nil
    end
    if bang then
        bang:Stop()
        bang = nil
    end
    if bangAnim then
        bangAnim:Destroy()
        bangAnim = nil
    end
    currentBangedPlayer = nil
end

local function bangPlayer(targetPlayer)
    if not targetPlayer or not targetPlayer.Parent then
        return
    end
    
    local localPlayer = Players.LocalPlayer
    if not localPlayer then
        return
    end
    
    -- If clicking on the same player, unbang them
    if currentBangedPlayer == targetPlayer then
        unbangPlayer()
        return
    end
    
    -- Stop any existing bang
    unbangPlayer()
    
    -- Set current banged player
    currentBangedPlayer = targetPlayer
    
    spawn(function()
        -- Wait for local character
        local localCharacter = localPlayer.Character
        if not localCharacter then
            localCharacter = localPlayer.CharacterAdded:Wait(5)
        end
        
        if not localCharacter or not localCharacter.Parent then
            return
        end
        
        local humanoid = localCharacter:FindFirstChildWhichIsA("Humanoid")
        if not humanoid then
            return
        end
        
        -- Wait for target character
        local targetCharacter = targetPlayer.Character
        if not targetCharacter then
            targetCharacter = targetPlayer.CharacterAdded:Wait(5)
        end
        
        if not targetCharacter or not targetCharacter.Parent then
            return
        end
        
        -- Create and play bang animation (like Infinite Yield)
        bangAnim = Instance.new("Animation")
        bangAnim.AnimationId = not isR15(localPlayer) and "rbxassetid://148840371" or "rbxassetid://5918726674"
        bang = humanoid:LoadAnimation(bangAnim)
        bang:Play(0.1, 1, 1)
        bang:AdjustSpeed(3)
        
        -- Connect to character death to stop bang
        bangDied = humanoid.Died:Connect(function()
            unbangPlayer()
        end)
        
        -- Also stop if target player leaves or character is removed
        if targetPlayer.CharacterRemoving then
            targetPlayer.CharacterRemoving:Connect(function()
                if currentBangedPlayer == targetPlayer then
                    unbangPlayer()
                end
            end)
        end
        
        -- Bang offset (1.1 studs forward from target)
        local bangOffset = CFrame.new(0, 0, 1.1)
        
        -- Continuously teleport to target player's position (like Infinite Yield)
        -- Use RenderStepped for 240 FPS support (runs every frame before rendering)
        bangLoop = RunService.RenderStepped:Connect(function()
            pcall(function()
                local otherRoot = getTorso(targetCharacter)
                local localRoot = getRoot(localCharacter)
                
                if otherRoot and localRoot and otherRoot.Parent and localRoot.Parent then
                    localRoot.CFrame = otherRoot.CFrame * bangOffset
                end
            end)
        end)
    end)
end

-- Spy/View function (from Infinite Yield) - view from another player's perspective
local function unspyPlayer()
    if viewing ~= nil then
        viewing = nil
    end
    if viewDied then
        viewDied:Disconnect()
        viewDied = nil
    end
    if viewChanged then
        viewChanged:Disconnect()
        viewChanged = nil
    end
    local localPlayer = Players.LocalPlayer
    if localPlayer and localPlayer.Character then
        Workspace.CurrentCamera.CameraSubject = localPlayer.Character:FindFirstChildOfClass("Humanoid")
    end
end

local function spyPlayer(targetPlayer)
    if not targetPlayer or not targetPlayer.Parent then
        return
    end
    
    local localPlayer = Players.LocalPlayer
    if not localPlayer then
        return
    end
    
    -- If clicking on the same player, unspy them
    if viewing == targetPlayer then
        unspyPlayer()
        return
    end
    
    -- Stop any existing spy
    unspyPlayer()
    
    -- Set viewing player
    viewing = targetPlayer
    
    spawn(function()
        -- Wait for target character
        local targetCharacter = targetPlayer.Character
        if not targetCharacter then
            targetCharacter = targetPlayer.CharacterAdded:Wait(5)
        end
        
        if not targetCharacter or not targetCharacter.Parent then
            unspyPlayer()
            return
        end
        
        -- Set camera to target player's character
        Workspace.CurrentCamera.CameraSubject = targetCharacter:FindFirstChildOfClass("Humanoid")
        
        -- Function to reconnect camera when character respawns
        local function viewDiedFunc()
            if viewing == targetPlayer then
                repeat 
                    task.wait() 
                until targetPlayer.Character ~= nil and getRoot(targetPlayer.Character)
                if viewing == targetPlayer then
                    Workspace.CurrentCamera.CameraSubject = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
                end
            end
        end
        
        -- Connect to character respawn
        viewDied = targetPlayer.CharacterAdded:Connect(viewDiedFunc)
        
        -- Function to keep camera on target if something tries to change it
        local function viewChangedFunc()
            if viewing == targetPlayer and targetPlayer.Character then
                Workspace.CurrentCamera.CameraSubject = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
            end
        end
        
        -- Connect to camera subject changes
        viewChanged = Workspace.CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(viewChangedFunc)
        
        -- Also stop if target player leaves
        targetPlayer.AncestryChanged:Connect(function()
            if not targetPlayer.Parent then
                if viewing == targetPlayer then
                    unspyPlayer()
                end
            end
        end)
    end)
end

-- Donation Notification System
local donationNotifications = {}
local previousDonations = {} -- Track previous donation values for each player
local previousReceived = {} -- Track previous received values for each player
local notificationContainer = nil
donationNotifications.leaderboardNotified = {}
donationNotifications.leaderboardActive = {}
donationNotifications.leaderboardCounter = 0
donationNotifications.minutesNotified = {}
donationNotifications.minutesActive = {}
donationNotifications.minutesCounter = 0

-- Unified notification system
local function createNotification(title, message, notificationType, actionButton, actionCallback)
    notificationType = notificationType or "info" -- "info", "warning", "success"
    
    if not screenGui or not screenGui.Parent then
        return -- ScreenGui not ready yet
    end
    
    if not notificationContainer then
        -- Create notification container
        notificationContainer = Instance.new("Frame")
        notificationContainer.Name = "NotificationContainer"
        notificationContainer.Size = UDim2.new(0, 400, 0, 300)
        notificationContainer.Position = UDim2.new(0.5, -200, 0, 10)
        notificationContainer.AnchorPoint = Vector2.new(0.5, 0)
        notificationContainer.BackgroundTransparency = 1
        notificationContainer.Parent = screenGui
        
        local notificationLayout = Instance.new("UIListLayout")
        notificationLayout.SortOrder = Enum.SortOrder.LayoutOrder
        notificationLayout.Padding = UDim.new(0, 10)
        notificationLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        notificationLayout.VerticalAlignment = Enum.VerticalAlignment.Top
        notificationLayout.Parent = notificationContainer
        
        local notificationPadding = Instance.new("UIPadding")
        notificationPadding.PaddingTop = UDim.new(0, 10)
        notificationPadding.Parent = notificationContainer
    end
    
    -- Determine colors based on type
    local borderColor, bgColor
    if notificationType == "success" then
        borderColor = Color3.fromRGB(100, 200, 100)
        bgColor = Color3.fromRGB(40, 60, 40)
    elseif notificationType == "warning" then
        borderColor = Color3.fromRGB(255, 180, 50)
        bgColor = Color3.fromRGB(60, 50, 30)
    else
        borderColor = Color3.fromRGB(100, 150, 255)
        bgColor = Color3.fromRGB(40, 40, 60)
    end
    
    -- Create notification frame
    local notification = Instance.new("Frame")
    notification.Name = "Notification_" .. tick()
    notification.Size = UDim2.new(0, 380, 0, 100)
    notification.BackgroundColor3 = bgColor
    notification.BorderSizePixel = 0
    notification.Parent = notificationContainer
    notification.LayoutOrder = #donationNotifications + 1
    
    local notificationCorner = Instance.new("UICorner")
    notificationCorner.CornerRadius = UDim.new(0, 10)
    notificationCorner.Parent = notification
    
    local notificationBorder = Instance.new("UIStroke")
    notificationBorder.Color = borderColor
    notificationBorder.Thickness = 3
    notificationBorder.Transparency = 0
    notificationBorder.Parent = notification
    
    -- Title label
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(1, actionButton and -100 or -40, 0, 30)
    titleLabel.Position = UDim2.new(0, 15, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 16
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextTruncate = Enum.TextTruncate.AtEnd
    titleLabel.Parent = notification
    
    -- Message label
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Name = "MessageLabel"
    messageLabel.Size = UDim2.new(1, actionButton and -100 or -40, 0, 40)
    messageLabel.Position = UDim2.new(0, 15, 0, 40)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Text = message
    messageLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    messageLabel.TextSize = 13
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.TextWrapped = true
    messageLabel.Parent = notification
    
    -- Action button (if provided)
    if actionButton and actionCallback then
        local actionBtn = Instance.new("TextButton")
        actionBtn.Name = "ActionButton"
        actionBtn.Size = UDim2.new(0, 90, 0, 35)
        actionBtn.Position = UDim2.new(1, -100, 0.5, -17.5)
        actionBtn.AnchorPoint = Vector2.new(0, 0.5)
        actionBtn.BackgroundColor3 = borderColor
        actionBtn.Text = actionButton
        actionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        actionBtn.TextSize = 12
        actionBtn.Font = Enum.Font.GothamBold
        actionBtn.BorderSizePixel = 0
        actionBtn.Parent = notification
        
        local actionCorner = Instance.new("UICorner")
        actionCorner.CornerRadius = UDim.new(0, 6)
        actionCorner.Parent = actionBtn
        
        actionBtn.MouseEnter:Connect(function()
            actionBtn.BackgroundColor3 = Color3.fromRGB(
                math.min(255, borderColor.R * 255 * 1.2),
                math.min(255, borderColor.G * 255 * 1.2),
                math.min(255, borderColor.B * 255 * 1.2)
            )
        end)
        actionBtn.MouseLeave:Connect(function()
            actionBtn.BackgroundColor3 = borderColor
        end)
        
        actionBtn.MouseButton1Click:Connect(actionCallback)
    end
    
    -- Close button (X)
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 25, 0, 25)
    closeButton.Position = UDim2.new(1, -30, 0, 8)
    closeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    closeButton.Text = "×"
    closeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    closeButton.TextSize = 18
    closeButton.Font = Enum.Font.GothamBold
    closeButton.BorderSizePixel = 0
    closeButton.Parent = notification
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 4)
    closeCorner.Parent = closeButton
    
    closeButton.MouseEnter:Connect(function()
        closeButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    end)
    closeButton.MouseLeave:Connect(function()
        closeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end)
    
    local function closeNotification()
        local fadeTween = TweenService:Create(
            notification,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 0)}
        )
        fadeTween:Play()
        fadeTween.Completed:Connect(function()
            notification:Destroy()
            for i, notif in ipairs(donationNotifications) do
                if notif == notification then
                    table.remove(donationNotifications, i)
                    break
                end
            end
        end)
    end
    
    closeButton.MouseButton1Click:Connect(closeNotification)
    
    -- Animate in
    notification.Size = UDim2.new(0, 0, 0, 0)
    notification.BackgroundTransparency = 1
    local slideTween = TweenService:Create(
        notification,
        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 380, 0, 100), BackgroundTransparency = 0}
    )
    slideTween:Play()
    
    -- Auto-remove after 8 seconds (or 5 for warnings)
    local autoRemoveTime = notificationType == "warning" and 5 or 8
    task.delay(autoRemoveTime, function()
        if notification and notification.Parent then
            closeNotification()
        end
    end)
    
    table.insert(donationNotifications, notification)
    return notification
end

-- Function to teleport to a player
local function teleportToPlayer(targetPlayer)
    local localPlayer = Players.LocalPlayer
    if not localPlayer or not localPlayer.Character then
        return
    end
    
    local localRoot = getRoot(localPlayer.Character)
    if not localRoot then
        return
    end
    
    spawn(function()
        local targetCharacter = targetPlayer.Character
        if not targetCharacter then
            targetCharacter = targetPlayer.CharacterAdded:Wait(5)
        end
        
        if targetCharacter then
            local targetRoot = getRoot(targetCharacter)
            if targetRoot then
                localRoot.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 2) -- 2 studs in front
            end
        end
    end)
end

-- Function to create a donation notification
local function createDonationNotification(player, amount)
    createNotification(
        player.DisplayName .. " (" .. player.Name .. ")",
        "Donated " .. amount .. " Robux!",
        "success",
        "Teleport",
        function()
            teleportToPlayer(player)
        end
    )
end

-- Function to monitor donations for all players (using PropertyChangedSignal for reliable detection)
local function monitorDonations()
    local function setupPlayerMonitoring(player)
        -- Call ensureTipJarTracking if it exists (defined later in the script)
        if ensureTipJarTrackingFunc then
            ensureTipJarTrackingFunc(player)
        end
        spawn(function()
            tipJarStats = player:FindFirstChild("TipJarStats")
            if not tipJarStats then
                tipJarStats = player:WaitForChild("TipJarStats", 10)
            end
            
            if tipJarStats then
                -- Monitor Received/Raised value
                received = tipJarStats.Raised
                if not received then
                    received = tipJarStats:FindFirstChild("Raised")
                end
                
                if received and (received:IsA("IntValue") or received:IsA("NumberValue")) then
                    -- Initialize previous value
                    previousReceived[player.UserId] = received.Value
                    
                    -- Listen for changes
                    received:GetPropertyChangedSignal("Value"):Connect(function()
                        currentReceived = received.Value
                        previousReceivedValue = previousReceived[player.UserId] or currentReceived
                        
                        if currentReceived > previousReceivedValue then
                            increase = currentReceived - previousReceivedValue
                            if increase > 0 then
                                print("Donation detected! Receiver:", player.Name, "Increase:", increase)
                                
                                -- Try to find the donator
                                donatorFound = nil
                                
                                for _, donator in ipairs(Players:GetPlayers()) do
                                    if donator ~= player then
                                        donatorTipJarStats = donator:FindFirstChild("TipJarStats")
                                        if donatorTipJarStats then
                                            donatorDonated = donatorTipJarStats.Donated
                                            if not donatorDonated then
                                                donatorDonated = donatorTipJarStats:FindFirstChild("Donated")
                                            end
                                            
                                            if donatorDonated and (donatorDonated:IsA("IntValue") or donatorDonated:IsA("NumberValue")) then
                                                donatorCurrentDonated = donatorDonated.Value
                                                donatorPreviousDonated = previousDonations[donator.UserId] or donatorCurrentDonated
                                                
                                                if donatorCurrentDonated > donatorPreviousDonated then
                                                    donatorIncrease = donatorCurrentDonated - donatorPreviousDonated
                                                    if math.abs(donatorIncrease - increase) <= 1 then
                                                        donatorFound = donator
                                                        previousDonations[donator.UserId] = donatorCurrentDonated
                                                        break
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                                
                                -- Log donation (notification removed due to local variable limit)
                                if donatorFound then
                                    print("TipStatsGUI: Donation detected -", donatorFound.Name, "donated", increase, "to", player.Name)
                                else
                                    print("TipStatsGUI: Donation detected - Someone donated", increase, "to", player.Name)
                                end
                                
                                -- Update stored value
                                previousReceived[player.UserId] = currentReceived
                            end
                        elseif currentReceived ~= previousReceivedValue then
                            -- Value changed, update tracking
                            previousReceived[player.UserId] = currentReceived
                        end
                    end)
                end
                
                -- Monitor Donated value for tracking
                donated = tipJarStats.Donated
                if not donated then
                    donated = tipJarStats:FindFirstChild("Donated")
                end
                
                if donated and (donated:IsA("IntValue") or donated:IsA("NumberValue")) then
                    -- Initialize previous value
                    previousDonations[player.UserId] = donated.Value
                    
                    -- Listen for changes to update tracking
                    donated:GetPropertyChangedSignal("Value"):Connect(function()
                        previousDonations[player.UserId] = donated.Value
                    end)
                end
            end
        end)
    end
    
    -- Setup monitoring for existing players
    for _, player in ipairs(Players:GetPlayers()) do
        setupPlayerMonitoring(player)
    end
    
    -- Setup monitoring for new players
    Players.PlayerAdded:Connect(function(player)
        setupPlayerMonitoring(player)
    end)
    
    -- Clean up when players leave and log their departure
    Players.PlayerRemoving:Connect(function(player)
        previousDonations[player.UserId] = nil
        previousReceived[player.UserId] = nil
        -- Log player leaving in their profile
        logPlayerLeaving(player)
    end)
end

-- Create ScreenGui - first destroy any existing one from old instances (using globals to reduce local register usage)
coreGui = nil
pcall(function()
    coreGui = game:GetService("CoreGui")
end)

if not coreGui then
    warn("TipStatsGUI: CoreGui service not available")
    return
end

existingScreenGui = coreGui:FindFirstChild("TipStatsGUI")
if existingScreenGui then
    pcall(function()
        existingScreenGui:Destroy()
    end)
    task.wait(0.1) -- Wait a moment for cleanup
end

screenGui = Instance.new("ScreenGui")
screenGui.Name = "TipStatsGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function()
    screenGui.Parent = coreGui
end)

-- Store original sizes and states
originalSize = UDim2.new(0, 500, 0, 600)
minimizedSize = UDim2.new(0, 500, 0, 45)
isMinimized = false
isClosed = false
playerInfoTargetPosition = UDim2.new(1, -20, 0, 80)

-- Create Main Frame
mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = originalSize
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -300)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Add corner radius
corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

-- Add subtle border
mainBorder = Instance.new("UIStroke")
mainBorder.Color = Color3.fromRGB(50, 50, 50)
mainBorder.Thickness = 1
mainBorder.Transparency = 0.2
mainBorder.Parent = mainFrame

-- Create Title Bar
titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 45)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleBar

-- Add subtle border to title bar
titleBorder = Instance.new("UIStroke")
titleBorder.Color = Color3.fromRGB(60, 60, 60)
titleBorder.Thickness = 1
titleBorder.Transparency = 0.3
titleBorder.Parent = titleBar

-- Tooltip system
local tooltip = nil
local tooltipConnection = nil

local function createTooltip(text)
    if tooltip then
        tooltip:Destroy()
    end
    
    tooltip = Instance.new("Frame")
    tooltip.Name = "Tooltip"
    tooltip.Size = UDim2.new(0, 0, 0, 0)
    tooltip.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    tooltip.BorderSizePixel = 0
    tooltip.ZIndex = 100
    tooltip.Parent = screenGui
    
    local tooltipCorner = Instance.new("UICorner")
    tooltipCorner.CornerRadius = UDim.new(0, 6)
    tooltipCorner.Parent = tooltip
    
    local tooltipBorder = Instance.new("UIStroke")
    tooltipBorder.Color = Color3.fromRGB(60, 60, 60)
    tooltipBorder.Thickness = 1
    tooltipBorder.Parent = tooltip
    
    local tooltipText = Instance.new("TextLabel")
    tooltipText.Name = "TooltipText"
    tooltipText.Size = UDim2.new(1, -12, 1, -8)
    tooltipText.Position = UDim2.new(0, 6, 0, 4)
    tooltipText.BackgroundTransparency = 1
    tooltipText.Text = text
    tooltipText.TextColor3 = Color3.fromRGB(240, 240, 240)
    tooltipText.TextSize = 12
    tooltipText.Font = Enum.Font.Gotham
    tooltipText.TextXAlignment = Enum.TextXAlignment.Left
    tooltipText.TextYAlignment = Enum.TextYAlignment.Top
    tooltipText.TextWrapped = true
    tooltipText.Parent = tooltip
    
    -- Calculate size based on text
    local textSize = TextService:GetTextSize(text, 12, Enum.Font.Gotham, Vector2.new(200, math.huge))
    tooltip.Size = UDim2.new(0, math.min(textSize.X + 12, 250), 0, textSize.Y + 8)
    
    return tooltip
end

local function showTooltip(button, text)
    local tooltipVisible = false
    local tooltipFrame = nil
    
    button.MouseEnter:Connect(function()
        if tooltip then
            tooltip:Destroy()
        end
        
        tooltipVisible = true
        
        -- Wait 0.2 seconds before showing tooltip
        spawn(function()
            task.wait(0.2)
            
            -- Check if mouse is still hovering after delay
            if not tooltipVisible then
                return
            end
            
            -- Check if button still exists and is valid
            if not button or not button.Parent then
                return
            end
            
            tooltipFrame = createTooltip(text)
            
            -- Wait a frame for size to be calculated
            task.wait()
            
            -- Check again if still visible
            if not tooltipVisible then
                if tooltipFrame and tooltipFrame.Parent then
                    tooltipFrame:Destroy()
                    tooltipFrame = nil
                end
                return
            end
            
            -- Position tooltip above the button
            local buttonPosition = button.AbsolutePosition
            local buttonSize = button.AbsoluteSize
            local tooltipSize = tooltipFrame.AbsoluteSize
            
            -- Center tooltip above button
            local xPos = buttonPosition.X + (buttonSize.X / 2) - (tooltipSize.X / 2)
            local yPos = buttonPosition.Y - tooltipSize.Y - 5
            
            -- Make sure tooltip doesn't go off screen
            if xPos < 5 then
                xPos = 5
            elseif xPos + tooltipSize.X > screenGui.AbsoluteSize.X - 5 then
                xPos = screenGui.AbsoluteSize.X - tooltipSize.X - 5
            end
            
            tooltipFrame.Position = UDim2.new(0, xPos, 0, yPos)
            
            -- Animate in
            tooltipFrame.Size = UDim2.new(0, 0, 0, 0)
            tooltipFrame.BackgroundTransparency = 1
            local tween = TweenService:Create(
                tooltipFrame,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, tooltipSize.X, 0, tooltipSize.Y), BackgroundTransparency = 0}
            )
            tween:Play()
        end)
    end)
    
    button.MouseLeave:Connect(function()
        tooltipVisible = false
        if tooltipFrame and tooltipFrame.Parent then
            local tween = TweenService:Create(
                tooltipFrame,
                TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}
            )
            tween:Play()
            tween.Completed:Connect(function()
                if tooltipFrame and tooltipFrame.Parent then
                    tooltipFrame:Destroy()
                    tooltipFrame = nil
                    tooltip = nil
                end
            end)
        end
    end)
end

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

-- Settings Button
local settingsButton = Instance.new("TextButton")
settingsButton.Name = "SettingsButton"
settingsButton.Size = UDim2.new(0, 32, 0, 32)
settingsButton.Position = UDim2.new(1, -188, 0, 6.5) -- Left of search button (32px button + 5px spacing)
settingsButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
settingsButton.Text = "⚙"
settingsButton.TextColor3 = Color3.fromRGB(220, 220, 220)
settingsButton.TextSize = 16
settingsButton.Font = Enum.Font.GothamBold
settingsButton.BorderSizePixel = 0
settingsButton.Parent = titleBar

local settingsCorner = Instance.new("UICorner")
settingsCorner.CornerRadius = UDim.new(0, 6)
settingsCorner.Parent = settingsButton

settingsButton.MouseEnter:Connect(function()
    settingsButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
end)
settingsButton.MouseLeave:Connect(function()
    settingsButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
end)

showTooltip(settingsButton, "Settings")

-- Hide players state (for global hide)
local playersHidden = false
local hiddenCharacters = {}
local playerAddedConnection = nil
local locationHubButton = nil

-- Individual player hide state
local individuallyHiddenPlayers = {}
local playerTipJarOwnership = {}

local settingsState = {
    showLocationHubButton = true,
    hideAllTipJars = false,
    disableAltRequirement = false,
    disableHoverInfo = false,
    disableHoverOutline = false,
    toggleKeyCode = Enum.KeyCode.V,
    hoverRange = 20,
    buildPlayerProfile = false,
}

-- Settings persistence system (using executor workspace folder)
local SETTINGS_FILENAME = "TipStatsGUI_Settings.json"

-- Function to save settings to executor workspace folder
local function saveSettings()
    pcall(function()
        -- Check if executor file I/O functions are available
        if not writefile then
            warn("TipStatsGUI: writefile function not available. Settings cannot be saved to workspace folder.")
            return
        end
        
        -- Convert settings to a saveable format
        local settingsToSave = {
            showLocationHubButton = settingsState.showLocationHubButton,
            hideAllTipJars = settingsState.hideAllTipJars,
            disableAltRequirement = settingsState.disableAltRequirement,
            disableHoverInfo = settingsState.disableHoverInfo,
            disableHoverOutline = settingsState.disableHoverOutline,
            hoverRange = settingsState.hoverRange,
            toggleKeyCodeName = settingsState.toggleKeyCode and settingsState.toggleKeyCode.Name or nil,
            buildPlayerProfile = settingsState.buildPlayerProfile,
        }
        
        -- Encode to JSON
        local success, jsonString = pcall(function()
            return HttpService:JSONEncode(settingsToSave)
        end)
        
        if not success or not jsonString then
            warn("TipStatsGUI: Failed to encode settings to JSON")
            return
        end
        
        -- Save to workspace folder
        local writeSuccess, writeError = pcall(function()
            writefile(SETTINGS_FILENAME, jsonString)
        end)
        
        if writeSuccess then
            print("TipStatsGUI: Settings saved to workspace folder: " .. SETTINGS_FILENAME)
            
            -- Debug: Verify file was saved
            if isfile then
                task.wait(0.1) -- Small delay to ensure file is written
                if isfile(SETTINGS_FILENAME) then
                    print("TipStatsGUI: [DEBUG] Verified - Settings file exists in workspace folder")
                    
                    -- Debug: Read back and verify content
                    local verifySuccess, verifyContent = pcall(function()
                        if readfile then
                            return readfile(SETTINGS_FILENAME)
                        end
                        return nil
                    end)
                    
                    if verifySuccess and verifyContent == jsonString then
                        print("TipStatsGUI: [DEBUG] Verified - Settings file content matches saved data")
                    elseif verifySuccess then
                        warn("TipStatsGUI: [DEBUG] WARNING - Settings file content does not match!")
                    end
                else
                    warn("TipStatsGUI: [DEBUG] WARNING - Settings file not found after save!")
                end
            end
        else
            warn("TipStatsGUI: Failed to save settings to workspace folder. Error: " .. tostring(writeError))
        end
    end)
end

-- Function to load settings from executor workspace folder
local function loadSettings()
    pcall(function()
        -- Check if executor file I/O functions are available
        if not readfile or not isfile then
            print("TipStatsGUI: readfile/isfile functions not available. Using default settings.")
            return
        end
        
        -- Check if settings file exists
        if not isfile(SETTINGS_FILENAME) then
            print("TipStatsGUI: No settings file found in workspace folder. Using default settings.")
            return
        end
        
        print("TipStatsGUI: [DEBUG] Settings file found in workspace folder: " .. SETTINGS_FILENAME)
        
        -- Read file content
        local success, fileContent = pcall(function()
            return readfile(SETTINGS_FILENAME)
        end)
        
        if not success or not fileContent or fileContent == "" then
            warn("TipStatsGUI: Failed to read settings file or file is empty")
            return
        end
        
        print("TipStatsGUI: [DEBUG] Successfully read settings file. Content length: " .. tostring(#fileContent) .. " characters")
        
        -- Decode JSON
        local decodeSuccess, settingsData = pcall(function()
            return HttpService:JSONDecode(fileContent)
        end)
        
        if not decodeSuccess or not settingsData then
            warn("TipStatsGUI: Failed to decode settings JSON")
            return
        end
        
        print("TipStatsGUI: [DEBUG] Successfully decoded settings JSON")
        
        -- Load settings
        local loadedCount = 0
        if settingsData.showLocationHubButton ~= nil then
            settingsState.showLocationHubButton = settingsData.showLocationHubButton
            loadedCount = loadedCount + 1
        end
        if settingsData.hideAllTipJars ~= nil then
            settingsState.hideAllTipJars = settingsData.hideAllTipJars
            loadedCount = loadedCount + 1
        end
        if settingsData.disableAltRequirement ~= nil then
            settingsState.disableAltRequirement = settingsData.disableAltRequirement
            loadedCount = loadedCount + 1
        end
        if settingsData.disableHoverInfo ~= nil then
            settingsState.disableHoverInfo = settingsData.disableHoverInfo
            loadedCount = loadedCount + 1
        end
        if settingsData.disableHoverOutline ~= nil then
            settingsState.disableHoverOutline = settingsData.disableHoverOutline
            loadedCount = loadedCount + 1
        end
        if settingsData.hoverRange ~= nil then
            settingsState.hoverRange = math.max(20, math.min(100, settingsData.hoverRange))
            loadedCount = loadedCount + 1
        end
        if settingsData.toggleKeyCodeName then
            -- Convert key name back to KeyCode
            local keyCode = Enum.KeyCode[settingsData.toggleKeyCodeName]
            if keyCode then
                settingsState.toggleKeyCode = keyCode
                loadedCount = loadedCount + 1
            end
        end
        if settingsData.buildPlayerProfile ~= nil then
            settingsState.buildPlayerProfile = settingsData.buildPlayerProfile
            loadedCount = loadedCount + 1
        end
        
        print("TipStatsGUI: Settings loaded from workspace folder. Loaded " .. tostring(loadedCount) .. " setting(s)")
    end)
end

-- Load settings on startup
loadSettings()

-- Player Profile System
local playerChatMessages = {} -- Store chat messages by player name
local lastLoggedMessages = {} -- Track last logged message per player to prevent duplicates
local PROFILE_BASE_FOLDER = "Players"

-- Function to ensure Players folder exists
local function ensurePlayersFolder()
    if not writefile then
        return false
    end
    
    -- Try using makefolder if available (some executors like Synapse X support this)
    if makefolder then
        local success, err = pcall(function()
            makefolder(PROFILE_BASE_FOLDER)
        end)
        if success then
            return true
        end
    end
    
    -- Fallback: Try creating folder by writing a test file in it
    -- Some executors auto-create folders when you write to a path with "/"
    local testFile = PROFILE_BASE_FOLDER .. "/.test"
    local success, err = pcall(function()
        writefile(testFile, "test")
    end)
    
    if success then
        task.wait(0.1)
        if isfile and isfile(testFile) then
            -- Clean up test file (silent)
            pcall(function()
                if delfile then
                    delfile(testFile)
                end
            end)
            return true
        end
    end
    
    warn("TipStatsGUI: [Profile] Could not create Players folder. Error: " .. tostring(err))
    return false
end

-- Function to ensure player subfolder exists (Players/PlayerName/)
local function ensurePlayerSubfolder(playerName)
    if not writefile then
        return false
    end
    
    -- First ensure base Players folder exists
    if not ensurePlayersFolder() then
        return false
    end
    
    local playerFolder = PROFILE_BASE_FOLDER .. "/" .. playerName
    
    -- Try using makefolder if available
    if makefolder then
        local success, err = pcall(function()
            makefolder(playerFolder)
        end)
        if success then
            return true
        end
    end
    
    -- Fallback: Try creating folder by writing a test file in it
    local testFile = playerFolder .. "/.test"
    local success, err = pcall(function()
        writefile(testFile, "test")
    end)
    
    if success then
        task.wait(0.1)
        if isfile and isfile(testFile) then
            -- Clean up test file (silent)
            pcall(function()
                if delfile then
                    delfile(testFile)
                end
            end)
            return true
        end
    end
    
    warn("TipStatsGUI: [Profile] Could not create player subfolder for: " .. playerName)
    return false
end

-- Function to get current timestamp in ISO format
local function getCurrentTimestamp()
    local dateTable = os.date("*t")
    return string.format("%04d-%02d-%02dT%02d:%02d:%02d", 
        dateTable.year, dateTable.month, dateTable.day,
        dateTable.hour, dateTable.min, dateTable.sec)
end

-- Function to pretty-print JSON with indentation
local function prettyPrintJSON(jsonString)
    if not jsonString then
        return ""
    end
    
    local result = ""
    local indent = 0
    local indentStr = "  " -- 2 spaces per indent level
    local inString = false
    local escapeNext = false
    
    for i = 1, #jsonString do
        local char = jsonString:sub(i, i)
        
        if escapeNext then
            result = result .. char
            escapeNext = false
        elseif char == "\\" then
            result = result .. char
            escapeNext = true
        elseif char == '"' then
            result = result .. char
            inString = not inString
        elseif inString then
            result = result .. char
        elseif char == "{" or char == "[" then
            result = result .. char
            indent = indent + 1
            result = result .. "\n" .. string.rep(indentStr, indent)
        elseif char == "}" or char == "]" then
            indent = indent - 1
            result = result .. "\n" .. string.rep(indentStr, indent) .. char
        elseif char == "," then
            result = result .. char
            result = result .. "\n" .. string.rep(indentStr, indent)
        elseif char == ":" then
            result = result .. char .. " "
        elseif char == " " or char == "\n" or char == "\t" then
            -- Skip whitespace outside strings
        else
            result = result .. char
        end
    end
    
    return result
end

-- Function to collect all player profile data
local function collectPlayerProfileData(player)
    if not player or not player.Parent then
        return nil
    end
    
    local profileData = {
        timestamp = getCurrentTimestamp(),
        userId = player.UserId,
        displayName = player.DisplayName or player.Name,
        username = player.Name,
        stats = {},
        settings = {},
        backpack = {},
        chat = {}
    }
    
    -- Collect TipJarStats
    local tipJarStats = player:FindFirstChild("TipJarStats")
    if tipJarStats then
        local donated = tipJarStats.Donated or tipJarStats:FindFirstChild("Donated")
        local received = tipJarStats.Raised or tipJarStats:FindFirstChild("Raised")
        
        if donated and (donated:IsA("IntValue") or donated:IsA("NumberValue")) then
            profileData.stats.donated = donated.Value
        else
            profileData.stats.donated = 0
        end
        
        if received and (received:IsA("IntValue") or received:IsA("NumberValue")) then
            profileData.stats.received = received.Value
        else
            profileData.stats.received = 0
        end
    else
        profileData.stats.donated = 0
        profileData.stats.received = 0
    end
    
    -- Collect Playtime (Minutes)
    local minutes = nil
    local directMinutes = player:FindFirstChild("Minutes")
    if directMinutes then
        minutes = directMinutes
    else
        local leaderstats = player:FindFirstChild("leaderstats")
        if leaderstats then
            minutes = leaderstats:FindFirstChild("Minutes")
        end
    end
    
    if minutes and (minutes:IsA("IntValue") or minutes:IsA("NumberValue")) then
        profileData.stats.playtime = minutes.Value
    else
        profileData.stats.playtime = 0
    end
    
    -- Collect Credits
    local credits = player:FindFirstChild("Credits")
    if credits and (credits:IsA("IntValue") or credits:IsA("NumberValue")) then
        profileData.stats.credits = credits.Value
    else
        profileData.stats.credits = 0
    end
    
    -- Collect Settings
    local settings = player:FindFirstChild("Settings")
    if settings then
        local function getSettingValue(name)
            local setting = settings[name] or settings:FindFirstChild(name)
            if setting and setting:IsA("BoolValue") then
                return setting.Value
            end
            return nil
        end
        
        profileData.settings.auras = getSettingValue("Auras")
        profileData.settings.gifts = getSettingValue("Gifts")
        profileData.settings.piano = getSettingValue("Piano")
        profileData.settings.rank = getSettingValue("Rank")
        profileData.settings.shadow = getSettingValue("Shadow")
        profileData.settings.teleport = getSettingValue("Teleport")
        profileData.settings.time = getSettingValue("Time")
    end
    
    -- Collect Backpack Items
    local backpack = player:FindFirstChild("Backpack")
    if backpack then
        for _, item in ipairs(backpack:GetChildren()) do
            if item:IsA("Tool") or item:IsA("HopperBin") then
                table.insert(profileData.backpack, {
                    name = item.Name,
                    class = item.ClassName
                })
            end
        end
        -- Sort by name
        table.sort(profileData.backpack, function(a, b)
            return a.name < b.name
        end)
    end
    
    -- Note: Chat messages are NOT included in profile data
    -- They are saved separately to messages.json to reduce lag
    -- Chat messages are loaded separately in loadPlayerProfile() and merged for display
    
    return profileData
end

-- Function to save chat messages separately to messages.json
local function savePlayerChatMessages(playerName, messages)
    if not writefile or not isfile or not readfile then
        return false
    end
    
    if not ensurePlayerSubfolder(playerName) then
        return false
    end
    
    local messagesFile = PROFILE_BASE_FOLDER .. "/" .. playerName .. "/messages.json"
    
    -- Read existing messages if file exists
    local existingMessages = {}
    if isfile(messagesFile) then
        local success, fileContent = pcall(function()
            return readfile(messagesFile)
        end)
        
        if success and fileContent and fileContent ~= "" then
            local decodeSuccess, decoded = pcall(function()
                return HttpService:JSONDecode(fileContent)
            end)
            if decodeSuccess and decoded and type(decoded) == "table" then
                existingMessages = decoded
            end
        end
    end
    
    -- Merge new messages with existing (avoid duplicates based on timestamp and content)
    local messageMap = {}
    for _, msg in ipairs(existingMessages) do
        local key = (msg.timestamp or "") .. "|" .. (msg.content or "")
        messageMap[key] = msg
    end
    
    -- Add new messages
    for _, msg in ipairs(messages) do
        local key = (msg.timestamp or "") .. "|" .. (msg.content or "")
        if not messageMap[key] then
            table.insert(existingMessages, msg)
            messageMap[key] = msg
        end
    end
    
    -- Encode and save
    local success, jsonString = pcall(function()
        return HttpService:JSONEncode(existingMessages)
    end)
    
    if not success or not jsonString then
        return false
    end
    
    -- Pretty-print JSON for readability
    local formattedJSON = prettyPrintJSON(jsonString)
    
    -- Save to file
    local writeSuccess, writeError = pcall(function()
        writefile(messagesFile, formattedJSON)
    end)
    
    return writeSuccess
end

-- Function to save player profile to workspace folder (without chat messages)
local function savePlayerProfile(player, profileData)
    if not writefile or not isfile or not readfile then
        warn("TipStatsGUI: File I/O functions not available. Cannot save player profile.")
        return false
    end
    
    if not profileData then
        warn("TipStatsGUI: No profile data to save for player: " .. tostring(player and player.Name or "unknown"))
        return false
    end
    
    -- Ensure player subfolder exists (required - no fallback to root)
    local playerName = player.Name
    
    if not ensurePlayerSubfolder(playerName) then
        warn("TipStatsGUI: [Profile] Failed to create player subfolder. Cannot save profile for: " .. playerName)
        return false
    end
    
    -- Remove chat messages from profile data (saved separately)
    local profileDataWithoutChat = {}
    for k, v in pairs(profileData) do
        if k ~= "chat" then
            profileDataWithoutChat[k] = v
        end
    end
    
    -- Use folder path: Players/PlayerName/profile.json
    local profileFile = PROFILE_BASE_FOLDER .. "/" .. playerName .. "/profile.json"
    
    -- Read existing profile if it exists
    local existingEntries = {}
    if isfile(profileFile) then
        local success, fileContent = pcall(function()
            return readfile(profileFile)
        end)
        
        if success and fileContent and fileContent ~= "" then
            local decodeSuccess, decoded = pcall(function()
                return HttpService:JSONDecode(fileContent)
            end)
            if decodeSuccess and decoded and type(decoded) == "table" then
                existingEntries = decoded
            end
        end
    end
    
    -- Append new entry (without chat messages)
    table.insert(existingEntries, profileDataWithoutChat)
    
    -- Encode and save
    local success, jsonString = pcall(function()
        return HttpService:JSONEncode(existingEntries)
    end)
    
    if not success or not jsonString then
        warn("TipStatsGUI: Failed to encode profile data for player: " .. playerName)
        return false
    end
    
    -- Pretty-print JSON for readability
    local formattedJSON = prettyPrintJSON(jsonString)
    
    -- Save to file (silent to reduce console spam)
    local writeSuccess, writeError = pcall(function()
        writefile(profileFile, formattedJSON)
    end)
    
    if writeSuccess then
        -- Verify file was created
        task.wait(0.1)
        if isfile(profileFile) then
            return true
        else
            warn("TipStatsGUI: [Profile] Write reported success but file not found: " .. profileFile)
            return false
        end
    else
        warn("TipStatsGUI: [Profile] Failed to save profile for: " .. playerName .. " - " .. tostring(writeError))
        return false
    end
end

-- Function to load player profile (loads both profile.json and messages.json)
local function loadPlayerProfile(player)
    if not readfile or not isfile then
        return nil
    end
    
    local playerName = player.Name
    local profileFile = PROFILE_BASE_FOLDER .. "/" .. playerName .. "/profile.json"
    local messagesFile = PROFILE_BASE_FOLDER .. "/" .. playerName .. "/messages.json"
    
    -- Load profile data
    local profileEntries = nil
    if isfile(profileFile) then
        local success, fileContent = pcall(function()
            return readfile(profileFile)
        end)
        
        if success and fileContent and fileContent ~= "" then
            local decodeSuccess, decoded = pcall(function()
                return HttpService:JSONDecode(fileContent)
            end)
            if decodeSuccess and decoded and type(decoded) == "table" then
                profileEntries = decoded
            end
        end
    end
    
    -- Load messages data
    local messagesData = nil
    if isfile(messagesFile) then
        local success, fileContent = pcall(function()
            return readfile(messagesFile)
        end)
        
        if success and fileContent and fileContent ~= "" then
            local decodeSuccess, decoded = pcall(function()
                return HttpService:JSONDecode(fileContent)
            end)
            if decodeSuccess and decoded and type(decoded) == "table" then
                messagesData = decoded
            end
        end
    end
    
    -- If no profile entries, return nil
    if not profileEntries then
        return nil
    end
    
    -- Merge messages into profile entries for display
    if messagesData and #messagesData > 0 then
        -- Format messages by date (same logic as before)
        local function parseTimestamp(ts)
            if not ts then return nil, nil end
            local datePart, timePart = ts:match("^(%d%d%d%d%-%d%d%-%d%d)T(%d%d:%d%d:%d%d)$")
            return datePart, timePart
        end
        
        local messagesByDate = {}
        for _, msg in ipairs(messagesData) do
            local date, time = parseTimestamp(msg.timestamp)
            if date then
                if not messagesByDate[date] then
                    messagesByDate[date] = {}
                end
                table.insert(messagesByDate[date], {
                    time = time or "00:00:00",
                    sender = msg.sender or playerName,
                    recipient = msg.recipient,
                    content = msg.content or ""
                })
            end
        end
        
        -- Sort messages within each date by time
        for date, messages in pairs(messagesByDate) do
            table.sort(messages, function(a, b)
                return (a.time or "") < (b.time or "")
            end)
        end
        
        -- Convert to array format sorted by date (newest first)
        local sortedDates = {}
        for date in pairs(messagesByDate) do
            table.insert(sortedDates, date)
        end
        table.sort(sortedDates, function(a, b)
            return a > b -- Newest first
        end)
        
        -- Add chat data to each profile entry
        local chatData = {
            format = "grouped_by_date",
            messages = {}
        }
        
        for _, date in ipairs(sortedDates) do
            table.insert(chatData.messages, {
                date = date,
                messages = messagesByDate[date]
            })
        end
        
        -- Add chat to all entries (for backward compatibility and display)
        for _, entry in ipairs(profileEntries) do
            entry.chat = chatData
        end
    end
    
    return profileEntries
end

-- Function to log player leaving
local function logPlayerLeaving(player)
    if not settingsState.buildPlayerProfile then
        return
    end
    
    if not writefile or not isfile or not readfile then
        return
    end
    
    local playerName = player.Name
    local profileFile = PROFILE_BASE_FOLDER .. "/" .. playerName .. "/profile.json"
    
    -- Read existing profile
    local existingEntries = {}
    if isfile(profileFile) then
        local success, fileContent = pcall(function()
            return readfile(profileFile)
        end)
        
        if success and fileContent and fileContent ~= "" then
            local decodeSuccess, decoded = pcall(function()
                return HttpService:JSONDecode(fileContent)
            end)
            if decodeSuccess and decoded and type(decoded) == "table" then
                existingEntries = decoded
            end
        end
    end
    
    -- Add "player left" entry
    local leaveEntry = {
        timestamp = getCurrentTimestamp(),
        event = "player_left",
        userId = player.UserId,
        displayName = player.DisplayName or player.Name,
        username = player.Name
    }
    
    table.insert(existingEntries, leaveEntry)
    
    -- Save updated profile
    local success, jsonString = pcall(function()
        return HttpService:JSONEncode(existingEntries)
    end)
    
    if success and jsonString then
        -- Pretty-print JSON for readability
        local formattedJSON = prettyPrintJSON(jsonString)
        local writeSuccess = pcall(function()
            writefile(profileFile, formattedJSON)
        end)
        if writeSuccess then
            -- Silent - no console spam
        end
    end
end

-- Function to update all player profiles
local function updateAllPlayerProfiles()
    if not settingsState.buildPlayerProfile then
        return
    end
    
    if not writefile then
        return
    end
    
    -- Save players sequentially with delay to prevent lag
    for _, player in ipairs(Players:GetPlayers()) do
        if player and player.Parent then
            local profileData = collectPlayerProfileData(player)
            if profileData then
                savePlayerProfile(player, profileData)
                task.wait(0.75) -- Delay after each save to prevent lag
            end
        end
    end
end

-- Profile update system: snapshot on join + periodic updates
local profileUpdateConnection = nil
local profilePeriodicUpdate = nil

local function startProfileUpdateSystem()
    if not settingsState.buildPlayerProfile then
        return
    end
    
    -- Take snapshot of all existing players immediately when enabled
    task.spawn(function()
        -- Create profiles sequentially for all players in lobby with delay to prevent lag
        for _, player in ipairs(Players:GetPlayers()) do
            if player and player.Parent then
                local profileData = collectPlayerProfileData(player)
                if profileData then
                    savePlayerProfile(player, profileData)
                    task.wait(0.75) -- Delay after each save to prevent lag
                end
            end
        end
    end)
    
    -- Hook into player join events
    if not profileUpdateConnection then
        profileUpdateConnection = Players.PlayerAdded:Connect(function(player)
            if settingsState.buildPlayerProfile then
                -- Wait a bit for player data to load
                task.spawn(function()
                    task.wait(3)
                    if player and player.Parent then
                        local profileData = collectPlayerProfileData(player)
                        if profileData then
                            savePlayerProfile(player, profileData)
                        end
                    end
                end)
            end
        end)
    end
    
    -- Set up periodic updates (every 60 seconds)
    if profilePeriodicUpdate then
        profilePeriodicUpdate:Disconnect()
    end
    
    local lastUpdateTime = tick()
    profilePeriodicUpdate = RunService.Heartbeat:Connect(function()
        local currentTime = tick()
        if currentTime - lastUpdateTime >= 60 then
            lastUpdateTime = currentTime
            if settingsState.buildPlayerProfile then
                updateAllPlayerProfiles()
            end
        end
    end)
    
    -- Profile system started (silent to reduce console spam)
end

local function stopProfileUpdateSystem()
    if profileUpdateConnection then
        profileUpdateConnection:Disconnect()
        profileUpdateConnection = nil
    end
    
    if profilePeriodicUpdate then
        profilePeriodicUpdate:Disconnect()
        profilePeriodicUpdate = nil
    end
    
    -- Profile system stopped (silent to reduce console spam)
end

-- Start profile system if enabled on load - create profiles immediately
task.spawn(function()
    task.wait(0.5) -- Small delay to ensure everything is loaded
    if settingsState.buildPlayerProfile then
        startProfileUpdateSystem()
        -- Also create profiles sequentially for all current players with delay to prevent lag
        task.spawn(function()
            for _, player in ipairs(Players:GetPlayers()) do
                if player and player.Parent then
                    local profileData = collectPlayerProfileData(player)
                    if profileData then
                        savePlayerProfile(player, profileData)
                        task.wait(0.75) -- Delay after each save to prevent lag
                        -- Profile created (silent to reduce console spam)
                    end
                end
            end
        end)
    end
end)

local hiddenTipJarData = {}
local individualHideConnections = {}
local individualHideStateChanged = Instance.new("BindableEvent")
local tipJarTrackingConnections = {}
local ensureTipJarTrackingFunc = nil -- Will be set when function is defined

local function recordTipJarOwnership(player)
    if player then
        playerTipJarOwnership[player] = true
    end
end

local function containerHasTipJar(container)
    if not container then
        return false
    end
    return container:FindFirstChild("TipJar") ~= nil
end

local function playerOwnsTipJar(player)
    if not player then
        return false
    end
    if playerTipJarOwnership[player] then
        return true
    end
    if containerHasTipJar(player:FindFirstChild("Backpack")) or containerHasTipJar(player.Character) then
        recordTipJarOwnership(player)
        return true
    end
    return false
end

local function setTipJarHidden(tool, hidden)
    if not tool then
        return
    end

    local data = hiddenTipJarData[tool]
    if hidden then
        if not data then
            data = {
                originals = {},
            }
            hiddenTipJarData[tool] = data

            data.descendantAdded = tool.DescendantAdded:Connect(function(descendant)
                if settingsState.hideAllTipJars then
                    if descendant:IsA("BasePart") then
                        if data.originals[descendant] == nil then
                            data.originals[descendant] = descendant.LocalTransparencyModifier
                        end
                        descendant.LocalTransparencyModifier = 1
                    elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
                        if data.originals[descendant] == nil then
                            data.originals[descendant] = descendant.Transparency
                        end
                        descendant.Transparency = 1
                    elseif descendant:IsA("ProximityPrompt") then
                        if data.originals[descendant] == nil then
                            data.originals[descendant] = descendant.Enabled
                        end
                        descendant.Enabled = false
                    end
                end
            end)

            data.descendantRemoving = tool.DescendantRemoving:Connect(function(descendant)
                data.originals[descendant] = nil
            end)

            data.ancestryChanged = tool.AncestryChanged:Connect(function(_, parent)
                if not parent then
                    if data.descendantAdded then data.descendantAdded:Disconnect() end
                    if data.descendantRemoving then data.descendantRemoving:Disconnect() end
                    if data.ancestryChanged then data.ancestryChanged:Disconnect() end
                    hiddenTipJarData[tool] = nil
                end
            end)
        end

        for _, descendant in ipairs(tool:GetDescendants()) do
            if descendant:IsA("BasePart") then
                if data.originals[descendant] == nil then
                    data.originals[descendant] = descendant.LocalTransparencyModifier
                end
                descendant.LocalTransparencyModifier = 1
            elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
                if data.originals[descendant] == nil then
                    data.originals[descendant] = descendant.Transparency
                end
                descendant.Transparency = 1
            elseif descendant:IsA("ProximityPrompt") then
                if data.originals[descendant] == nil then
                    data.originals[descendant] = descendant.Enabled
                end
                descendant.Enabled = false
            end
        end
    else
        if data then
            for instanceRef, originalValue in pairs(data.originals) do
                if instanceRef:IsA("BasePart") then
                    instanceRef.LocalTransparencyModifier = originalValue or 0
                elseif instanceRef:IsA("Decal") or instanceRef:IsA("Texture") then
                    instanceRef.Transparency = originalValue or 0
                elseif instanceRef:IsA("ProximityPrompt") then
                    instanceRef.Enabled = (originalValue == nil) and true or originalValue
                end
            end
            if data.descendantAdded then data.descendantAdded:Disconnect() end
            if data.descendantRemoving then data.descendantRemoving:Disconnect() end
            if data.ancestryChanged then data.ancestryChanged:Disconnect() end
            hiddenTipJarData[tool] = nil
        end
    end
end

local function applyTipJarVisibilityToTool(tool)
    if not tool then
        return
    end
    setTipJarHidden(tool, settingsState.hideAllTipJars)
end

local function applyTipJarVisibilityForContainer(container)
    if not container then
        return
    end
    for _, child in ipairs(container:GetChildren()) do
        if child.Name == "TipJar" then
            applyTipJarVisibilityToTool(child)
        end
        if child:IsA("Tool") or child:IsA("Model") then
            applyTipJarVisibilityForContainer(child)
        end
    end
end

local function applyTipJarVisibilityForPlayer(player)
    if not player then
        return
    end
    applyTipJarVisibilityForContainer(player.Character)
    applyTipJarVisibilityForContainer(player:FindFirstChild("Backpack"))
end

local function applyTipJarVisibilityForAllPlayers()
    for _, player in ipairs(Players:GetPlayers()) do
        applyTipJarVisibilityForPlayer(player)
    end
end

local function ensureTipJarTracking(player)
    if not player then
        return
    end
    if tipJarTrackingConnections[player] then
        return
    end

    local connections = {}

    local function trackContainer(container)
        if not container then
            return
        end

        for _, child in ipairs(container:GetChildren()) do
            if child.Name == "TipJar" then
                recordTipJarOwnership(player)
                applyTipJarVisibilityToTool(child)
            end
        end

        table.insert(connections, container.ChildAdded:Connect(function(child)
            if child.Name == "TipJar" then
                recordTipJarOwnership(player)
                applyTipJarVisibilityToTool(child)
            end
        end))
    end

    local function observeBackpack(backpack)
        trackContainer(backpack)
    end

    local backpack = player:FindFirstChild("Backpack")
    if backpack then
        observeBackpack(backpack)
    end

    table.insert(connections, player.ChildAdded:Connect(function(child)
        if child.Name == "Backpack" then
            observeBackpack(child)
        end
    end))

    local function observeCharacter(character)
        trackContainer(character)
    end

    if player.Character then
        observeCharacter(player.Character)
    end

    table.insert(connections, player.CharacterAdded:Connect(function(character)
        observeCharacter(character)
    end))

    tipJarTrackingConnections[player] = connections
    applyTipJarVisibilityForPlayer(player)
end

-- Set the function reference for use in monitorDonations
ensureTipJarTrackingFunc = ensureTipJarTracking

-- Function to hide a character
local function hideCharacter(character)
    if not character or not character.Parent then return end
    
    -- Get Humanoid and HumanoidRootPart first
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    
    -- Store original Humanoid state to prevent AFK detection issues
    if humanoid then
        if not humanoid:GetAttribute("OriginalWalkSpeed") then
            humanoid:SetAttribute("OriginalWalkSpeed", humanoid.WalkSpeed)
        end
        if not humanoid:GetAttribute("OriginalJumpPower") then
            humanoid:SetAttribute("OriginalJumpPower", humanoid.JumpPower)
        end
    end
    
    -- Hide all parts except HumanoidRootPart
    for _, descendant in ipairs(character:GetDescendants()) do
        -- Skip HumanoidRootPart completely to avoid creating blocks
        if descendant == humanoidRootPart then
            continue
        end
        
        if descendant:IsA("BasePart") then
            if not descendant:GetAttribute("OriginalTransparency") then
                descendant:SetAttribute("OriginalTransparency", descendant.Transparency)
            end
            if not descendant:GetAttribute("OriginalCanCollide") then
                descendant:SetAttribute("OriginalCanCollide", descendant.CanCollide)
            end
            descendant.Transparency = 1
            -- Only disable collision on non-essential parts
            if descendant ~= humanoidRootPart then
                descendant.CanCollide = false
            end
        elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
            if not descendant:GetAttribute("OriginalTransparency") then
                descendant:SetAttribute("OriginalTransparency", descendant.Transparency)
            end
            descendant.Transparency = 1
        elseif descendant:IsA("BillboardGui") or descendant:IsA("SurfaceGui") then
            -- Hide username, title, and emoji displays
            if not descendant:GetAttribute("OriginalEnabled") then
                descendant:SetAttribute("OriginalEnabled", descendant.Enabled)
            end
            descendant.Enabled = false
        end
    end
    
    -- Also check PlayerGui for any name tags or UI elements
    local player = Players:GetPlayerFromCharacter(character)
    if player then
        local playerGui = player:FindFirstChild("PlayerGui")
        if playerGui then
            for _, gui in ipairs(playerGui:GetDescendants()) do
                if gui:IsA("BillboardGui") or gui:IsA("SurfaceGui") then
                    if not gui:GetAttribute("OriginalEnabled") then
                        gui:SetAttribute("OriginalEnabled", gui.Enabled)
                    end
                    gui.Enabled = false
                end
            end
        end
    end
    
    -- Only hide HumanoidRootPart visually, don't modify its properties in a way that creates blocks
    if humanoidRootPart then
        if not humanoidRootPart:GetAttribute("OriginalTransparency") then
            humanoidRootPart:SetAttribute("OriginalTransparency", humanoidRootPart.Transparency)
        end
        humanoidRootPart.Transparency = 1
        -- Don't disable collision on HumanoidRootPart as it might cause issues
        
        -- Also hide any BillboardGui attached to HumanoidRootPart (username/title/emojis)
        for _, gui in ipairs(humanoidRootPart:GetChildren()) do
            if gui:IsA("BillboardGui") or gui:IsA("SurfaceGui") then
                if not gui:GetAttribute("OriginalEnabled") then
                    gui:SetAttribute("OriginalEnabled", gui.Enabled)
                end
                gui.Enabled = false
            end
        end
    end
    
    -- Also check Head for any name tags
    local head = character:FindFirstChild("Head")
    if head then
        for _, gui in ipairs(head:GetChildren()) do
            if gui:IsA("BillboardGui") or gui:IsA("SurfaceGui") then
                if not gui:GetAttribute("OriginalEnabled") then
                    gui:SetAttribute("OriginalEnabled", gui.Enabled)
                end
                gui.Enabled = false
            end
        end
    end
    
    character:SetAttribute("WasHidden", true)
    
    -- Disable AFKTag to prevent AFK detection issues
    pcall(function()
        local player = Players:GetPlayerFromCharacter(character)
        if player then
            disableAFKTagForPlayer(player.Name)
        end
    end)
end

-- Function to show a character
local function showCharacter(character)
    if not character or not character.Parent then return end
    
    -- Get Humanoid and HumanoidRootPart first
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    
    -- Restore original Humanoid state to prevent AFK detection issues
    if humanoid then
        local originalWalkSpeed = humanoid:GetAttribute("OriginalWalkSpeed")
        if originalWalkSpeed ~= nil then
            humanoid.WalkSpeed = originalWalkSpeed
            humanoid:SetAttribute("OriginalWalkSpeed", nil)
        else
            -- Ensure WalkSpeed is set to a valid value (default is 16)
            if humanoid.WalkSpeed == 0 then
                humanoid.WalkSpeed = 16
            end
        end
        local originalJumpPower = humanoid:GetAttribute("OriginalJumpPower")
        if originalJumpPower ~= nil then
            humanoid.JumpPower = originalJumpPower
            humanoid:SetAttribute("OriginalJumpPower", nil)
        else
            -- Ensure JumpPower is set to a valid value (default is 50)
            if humanoid.JumpPower == 0 then
                humanoid.JumpPower = 50
            end
        end
    end
    
    -- Restore all parts except HumanoidRootPart
    for _, descendant in ipairs(character:GetDescendants()) do
        -- Skip HumanoidRootPart to restore separately
        if descendant == humanoidRootPart then
            continue
        end
        
        if descendant:IsA("BasePart") then
            local originalTransparency = descendant:GetAttribute("OriginalTransparency")
            if originalTransparency ~= nil then
                descendant.Transparency = originalTransparency
            else
                descendant.Transparency = 0
            end
            -- Restore original CanCollide value
            local originalCanCollide = descendant:GetAttribute("OriginalCanCollide")
            if originalCanCollide ~= nil then
                descendant.CanCollide = originalCanCollide
            else
                descendant.CanCollide = true
            end
            descendant:SetAttribute("OriginalTransparency", nil)
            descendant:SetAttribute("OriginalCanCollide", nil)
        elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
            local originalTransparency = descendant:GetAttribute("OriginalTransparency")
            if originalTransparency ~= nil then
                descendant.Transparency = originalTransparency
            else
                descendant.Transparency = 0
            end
            descendant:SetAttribute("OriginalTransparency", nil)
        elseif descendant:IsA("BillboardGui") or descendant:IsA("SurfaceGui") then
            -- Restore username, title, and emoji displays
            local originalEnabled = descendant:GetAttribute("OriginalEnabled")
            if originalEnabled ~= nil then
                descendant.Enabled = originalEnabled
            else
                descendant.Enabled = true
            end
            descendant:SetAttribute("OriginalEnabled", nil)
        end
    end
    
    -- Also restore PlayerGui UI elements
    local player = Players:GetPlayerFromCharacter(character)
    if player then
        local playerGui = player:FindFirstChild("PlayerGui")
        if playerGui then
            for _, gui in ipairs(playerGui:GetDescendants()) do
                if gui:IsA("BillboardGui") or gui:IsA("SurfaceGui") then
                    local originalEnabled = gui:GetAttribute("OriginalEnabled")
                    if originalEnabled ~= nil then
                        gui.Enabled = originalEnabled
                    else
                        gui.Enabled = true
                    end
                    gui:SetAttribute("OriginalEnabled", nil)
                end
            end
        end
    end
    
    -- Restore HumanoidRootPart separately
    if humanoidRootPart then
        local originalTransparency = humanoidRootPart:GetAttribute("OriginalTransparency")
        if originalTransparency ~= nil then
            humanoidRootPart.Transparency = originalTransparency
        else
            humanoidRootPart.Transparency = 0
        end
        humanoidRootPart:SetAttribute("OriginalTransparency", nil)
        
        -- Restore original CanCollide value if it was stored
        local originalCanCollide = humanoidRootPart:GetAttribute("OriginalCanCollide")
        if originalCanCollide ~= nil then
            humanoidRootPart.CanCollide = originalCanCollide
            humanoidRootPart:SetAttribute("OriginalCanCollide", nil)
        end
        
        -- Restore BillboardGui on HumanoidRootPart (username/title/emojis)
        for _, gui in ipairs(humanoidRootPart:GetChildren()) do
            if gui:IsA("BillboardGui") or gui:IsA("SurfaceGui") then
                local originalEnabled = gui:GetAttribute("OriginalEnabled")
                if originalEnabled ~= nil then
                    gui.Enabled = originalEnabled
                else
                    gui.Enabled = true
                end
                gui:SetAttribute("OriginalEnabled", nil)
            end
        end
    end
    
    -- Also restore Head name tags
    local head = character:FindFirstChild("Head")
    if head then
        for _, gui in ipairs(head:GetChildren()) do
            if gui:IsA("BillboardGui") or gui:IsA("SurfaceGui") then
                local originalEnabled = gui:GetAttribute("OriginalEnabled")
                if originalEnabled ~= nil then
                    gui.Enabled = originalEnabled
                else
                    gui.Enabled = true
                end
                gui:SetAttribute("OriginalEnabled", nil)
            end
        end
    end
    
    character:SetAttribute("WasHidden", nil)
    
    -- Disable AFKTag to prevent AFK detection issues
    pcall(function()
        local player = Players:GetPlayerFromCharacter(character)
        if player then
            disableAFKTagForPlayer(player.Name)
        end
    end)
end

local function isPlayerIndividuallyHidden(player)
    return individuallyHiddenPlayers[player] == true
end

local function setIndividualHideState(player, hidden)
    if not player then
        return
    end

    if hidden then
        if not individuallyHiddenPlayers[player] then
            individuallyHiddenPlayers[player] = true
        end
        if player.Character then
            hideCharacter(player.Character)
        end

        if individualHideConnections[player] then
            individualHideConnections[player]:Disconnect()
        end

        individualHideConnections[player] = player.CharacterAdded:Connect(function(character)
            if individuallyHiddenPlayers[player] then
                hideCharacter(character)
            end
        end)
    else
        if individuallyHiddenPlayers[player] then
            individuallyHiddenPlayers[player] = nil
        end
        if player.Character then
            showCharacter(player.Character)
        end

        if individualHideConnections[player] then
            individualHideConnections[player]:Disconnect()
            individualHideConnections[player] = nil
        end
    end

    individualHideStateChanged:Fire(player, individuallyHiddenPlayers[player] == true)
end

local function toggleIndividualHideState(player)
    setIndividualHideState(player, not individuallyHiddenPlayers[player])
end

-- Function to disable AFK tags for a specific player
local function disableAFKTagForPlayer(playerName)
    pcall(function()
        if not Workspace:FindFirstChild("PlayerCharacters") then
            return
        end
        
        local playerCharFolder = Workspace.PlayerCharacters:FindFirstChild(playerName)
        if not playerCharFolder then
            return
        end
        
        local humanoidRootPart = playerCharFolder:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then
            return
        end
        
        local afkTag = humanoidRootPart:FindFirstChild("AFKTag")
        if not afkTag then
            return
        end
        
        local data = afkTag:FindFirstChild("Data")
        if data then
            if not data:GetAttribute("OriginalEnabled") then
                data:SetAttribute("OriginalEnabled", data.Enabled)
            end
            data.Enabled = false
            print("TipStatsGUI: Disabled AFKTag for", playerName)
        else
            -- Try disabling the AFKTag itself if Data doesn't exist
            if not afkTag:GetAttribute("OriginalEnabled") then
                afkTag:SetAttribute("OriginalEnabled", afkTag.Enabled)
            end
            afkTag.Enabled = false
            print("TipStatsGUI: Disabled AFKTag (no Data) for", playerName)
        end
    end)
end

-- Function to disable AFK tags for all players
local function disableAFKTagsForAllPlayers()
    pcall(function()
        if not Workspace:FindFirstChild("PlayerCharacters") then
            return
        end
        
        for _, playerCharFolder in ipairs(Workspace.PlayerCharacters:GetChildren()) do
            if playerCharFolder:IsA("Model") or playerCharFolder:IsA("Folder") then
                disableAFKTagForPlayer(playerCharFolder.Name)
            end
        end
    end)
end

-- Function to toggle player visibility
local function togglePlayersVisibility()
    playersHidden = not playersHidden
    local localPlayer = Players.LocalPlayer
    
    -- Disable AFK tags for all players to prevent AFK detection issues
    disableAFKTagsForAllPlayers()
    
    if playersHidden then
        -- Hide all other players
        hiddenCharacters = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and player.Character then
                local character = player.Character
                hiddenCharacters[player] = character
                hideCharacter(character)
            end
        end
        
        -- Listen for new players joining (only connect once)
        if not playerAddedConnection then
            playerAddedConnection = Players.PlayerAdded:Connect(function(player)
                if playersHidden and player ~= localPlayer then
                    if player.Character then
                        task.wait(0.1)
                        local character = player.Character
                        hiddenCharacters[player] = character
                        hideCharacter(character)
                    else
                        player.CharacterAdded:Connect(function(character)
                            if playersHidden then
                                hiddenCharacters[player] = character
                                hideCharacter(character)
                            end
                        end)
                    end
                end
            end)
        end
        
        -- Also listen for character respawns
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer then
                player.CharacterAdded:Connect(function(character)
                    if playersHidden then
                        hiddenCharacters[player] = character
                        hideCharacter(character)
                    end
                end)
            end
        end
        
        print("TipStatsGUI: All other players hidden")
    else
        -- Show all hidden players
        for player, character in pairs(hiddenCharacters) do
            if character and character.Parent then
                showCharacter(character)
            end
        end
        
        -- Also restore any players that joined while hidden
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and player.Character then
                local character = player.Character
                if character:GetAttribute("WasHidden") then
                    showCharacter(character)
                end
            end
        end
        
        hiddenCharacters = {}
        
        -- Disable AFK tags for all players after unhiding to prevent AFK detection issues
        disableAFKTagsForAllPlayers()
        
        print("TipStatsGUI: All players shown")
    end
    
    -- Update settings toggle if it exists
    if hidePlayersToggleButton and updateHidePlayersToggle then
        updateHidePlayersToggle(playersHidden)
    end
end


-- Location Hub UI
local locationHubUI = nil
local settingsPanel = nil
local savedLocationHubPosition = nil -- Save position when closed
local savedMainUIPosition = nil -- Save main UI position when closed
local hidePlayersToggleButton = nil -- Reference to the toggle button in settings
local updateHidePlayersToggle = nil -- Function to update the toggle state

local function updateLocationHubVisibility()
    if locationHubButton then
        locationHubButton.Visible = settingsState.showLocationHubButton
    end
    if not settingsState.showLocationHubButton and locationHubUI then
        locationHubUI:Destroy()
        locationHubUI = nil
    end
end

local settingsDragConnection = nil

local function closeSettingsPanel()
    if settingsPanel then
        if settingsDragConnection then
            settingsDragConnection:Disconnect()
            settingsDragConnection = nil
        end
        settingsPanel:Destroy()
        settingsPanel = nil
    end
end

local function createSettingsToggle(parent, labelText, initialState, onToggle)
    -- Create bubble-style frame (matching player entry design)
    local optionFrame = Instance.new("Frame")
    optionFrame.Name = labelText:gsub("%s+", "") .. "Option"
    optionFrame.Size = UDim2.new(1, 0, 0, 50)
    optionFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    optionFrame.BorderSizePixel = 0
    optionFrame.Parent = parent

    local entryCorner = Instance.new("UICorner")
    entryCorner.CornerRadius = UDim.new(0, 8)
    entryCorner.Parent = optionFrame

    -- Add subtle border effect (matching player entry)
    local border = Instance.new("UIStroke")
    border.Color = Color3.fromRGB(60, 60, 60)
    border.Thickness = 1
    border.Transparency = 0.4
    border.Parent = optionFrame

    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(1, -80, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 14
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextTruncate = Enum.TextTruncate.AtEnd
    label.Parent = optionFrame

    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = "Toggle"
    toggleButton.Size = UDim2.new(0, 60, 0, 26)
    toggleButton.Position = UDim2.new(1, -70, 0.5, -13)
    toggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    toggleButton.TextColor3 = Color3.fromRGB(220, 220, 220)
    toggleButton.TextSize = 12
    toggleButton.Font = Enum.Font.GothamBold
    toggleButton.BorderSizePixel = 0
    toggleButton.Parent = optionFrame

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 6)
    toggleCorner.Parent = toggleButton

    -- Add border to toggle button (matching player entry buttons)
    local toggleBorder = Instance.new("UIStroke")
    toggleBorder.Color = Color3.fromRGB(60, 60, 60)
    toggleBorder.Thickness = 1
    toggleBorder.Transparency = 0.3
    toggleBorder.Parent = toggleButton

    local currentState = initialState

    local function updateVisual()
        toggleButton.Text = currentState and "ON" or "OFF"
        toggleButton.BackgroundColor3 = currentState and Color3.fromRGB(70, 150, 90) or Color3.fromRGB(90, 90, 90)
    end

    -- Hover effect for toggle button
    toggleButton.MouseEnter:Connect(function()
        if currentState then
            toggleButton.BackgroundColor3 = Color3.fromRGB(80, 170, 100)
        else
            toggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        end
    end)
    toggleButton.MouseLeave:Connect(function()
        updateVisual()
    end)

    -- Hover effect for entire frame
    optionFrame.MouseEnter:Connect(function()
        optionFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    end)
    optionFrame.MouseLeave:Connect(function()
        optionFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    end)

    toggleButton.MouseButton1Click:Connect(function()
        currentState = not currentState
        updateVisual()
        onToggle(currentState)
    end)

    updateVisual()
    
    -- Return the toggle button and update function for external control
    return toggleButton, function(newState)
        currentState = newState
        updateVisual()
    end
end

-- Function to create a slider setting (bubble style)
local function createSettingsSlider(parent, labelText, minValue, maxValue, initialValue, onValueChanged)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Name = "SliderOption"
    sliderFrame.Size = UDim2.new(1, 0, 0, 60)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    sliderFrame.BorderSizePixel = 0
    sliderFrame.Parent = parent

    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 8)
    sliderCorner.Parent = sliderFrame

    -- Add subtle border effect (matching player entry)
    local sliderBorder = Instance.new("UIStroke")
    sliderBorder.Color = Color3.fromRGB(60, 60, 60)
    sliderBorder.Thickness = 1
    sliderBorder.Transparency = 0.4
    sliderBorder.Parent = sliderFrame

    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(1, -20, 0, 20)
    label.Position = UDim2.new(0, 10, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 14
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = sliderFrame

    local valueLabel = Instance.new("TextLabel")
    valueLabel.Name = "ValueLabel"
    valueLabel.Size = UDim2.new(0, 50, 0, 20)
    valueLabel.Position = UDim2.new(1, -60, 0, 5)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(math.floor(initialValue))
    valueLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    valueLabel.TextSize = 14
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Parent = sliderFrame

    local sliderContainer = Instance.new("Frame")
    sliderContainer.Name = "SliderContainer"
    sliderContainer.Size = UDim2.new(1, -20, 0, 20)
    sliderContainer.Position = UDim2.new(0, 10, 0, 30)
    sliderContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    sliderContainer.BorderSizePixel = 0
    sliderContainer.Parent = sliderFrame

    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(0, 4)
    containerCorner.Parent = sliderContainer

    local sliderTrack = Instance.new("Frame")
    sliderTrack.Name = "Track"
    sliderTrack.Size = UDim2.new(1, -4, 1, -4)
    sliderTrack.Position = UDim2.new(0, 2, 0, 2)
    sliderTrack.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    sliderTrack.BorderSizePixel = 0
    sliderTrack.Parent = sliderContainer

    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(0, 4)
    trackCorner.Parent = sliderTrack

    local sliderFill = Instance.new("Frame")
    sliderFill.Name = "Fill"
    sliderFill.Size = UDim2.new(0, 0, 1, 0)
    sliderFill.Position = UDim2.new(0, 0, 0, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(70, 150, 90)
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderTrack

    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 4)
    fillCorner.Parent = sliderFill

    local sliderButton = Instance.new("TextButton")
    sliderButton.Name = "Button"
    sliderButton.Size = UDim2.new(0, 12, 0, 12)
    sliderButton.Position = UDim2.new(0, -6, 0.5, -6)
    sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderButton.Text = ""
    sliderButton.BorderSizePixel = 0
    sliderButton.Parent = sliderTrack

    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = sliderButton

    local currentValue = initialValue
    local isDragging = false

    local function updateSlider(value)
        currentValue = math.clamp(value, minValue, maxValue)
        local percentage = (currentValue - minValue) / (maxValue - minValue)
        sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
        sliderButton.Position = UDim2.new(percentage, -6, 0.5, -6)
        valueLabel.Text = tostring(math.floor(currentValue))
        onValueChanged(currentValue)
    end

    local function getValueFromPosition(x)
        local trackSize = sliderTrack.AbsoluteSize.X
        local relativeX = math.clamp(x - sliderTrack.AbsolutePosition.X, 0, trackSize)
        local percentage = relativeX / trackSize
        return minValue + (maxValue - minValue) * percentage
    end

    local dragConnection = nil
    local heartbeatConnection = nil

    local function startDragging()
        isDragging = true
        
        if heartbeatConnection then
            heartbeatConnection:Disconnect()
        end
        
        heartbeatConnection = RunService.Heartbeat:Connect(function()
            if isDragging then
                local mousePos = UserInputService:GetMouseLocation()
                local newValue = getValueFromPosition(mousePos.X)
                updateSlider(newValue)
            end
        end)
    end

    local function stopDragging()
        isDragging = false
        if heartbeatConnection then
            heartbeatConnection:Disconnect()
            heartbeatConnection = nil
        end
    end

    sliderButton.MouseButton1Down:Connect(function()
        startDragging()
    end)

    dragConnection = UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            stopDragging()
        end
    end)

    sliderTrack.MouseButton1Down:Connect(function()
        startDragging()
        local mousePos = UserInputService:GetMouseLocation()
        local newValue = getValueFromPosition(mousePos.X)
        updateSlider(newValue)
    end)
    
    -- Clean up connections when slider frame is destroyed
    sliderFrame.AncestryChanged:Connect(function()
        if not sliderFrame.Parent then
            stopDragging()
            if dragConnection then
                dragConnection:Disconnect()
            end
        end
    end)

    -- Hover effect for entire frame
    sliderFrame.MouseEnter:Connect(function()
        sliderFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    end)
    sliderFrame.MouseLeave:Connect(function()
        sliderFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    end)

    -- Initialize slider
    updateSlider(initialValue)
end

local function toggleSettingsPanel()
    if not screenGui then
        warn("TipStatsGUI: screenGui not available for settings panel")
        return
    end
    
    if settingsPanel and settingsPanel.Parent then
        closeSettingsPanel()
        return
    end

    settingsPanel = Instance.new("Frame")
    settingsPanel.Name = "SettingsPanel"
    settingsPanel.Size = UDim2.new(0, 320, 0, 380)
    -- Position at bottom right with proper margins to ensure full visibility
    settingsPanel.AnchorPoint = Vector2.new(0, 0) -- No anchor for easier dragging
    settingsPanel.Position = UDim2.new(1, -340, 1, -400) -- Bottom right position
    settingsPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    settingsPanel.BorderSizePixel = 0
    settingsPanel.Visible = true
    settingsPanel.Parent = screenGui
    settingsPanel.ZIndex = 60

    local panelCorner = Instance.new("UICorner")
    panelCorner.CornerRadius = UDim.new(0, 10)
    panelCorner.Parent = settingsPanel

    local panelStroke = Instance.new("UIStroke")
    panelStroke.Color = Color3.fromRGB(60, 60, 60)
    panelStroke.Thickness = 1
    panelStroke.Transparency = 0.3
    panelStroke.Parent = settingsPanel

    local panelTitleBar = Instance.new("Frame")
    panelTitleBar.Name = "TitleBar"
    panelTitleBar.Size = UDim2.new(1, 0, 0, 45)
    panelTitleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    panelTitleBar.BorderSizePixel = 0
    panelTitleBar.Parent = settingsPanel

    local titleBarCorner = Instance.new("UICorner")
    titleBarCorner.CornerRadius = UDim.new(0, 10)
    titleBarCorner.Parent = panelTitleBar

    -- Add subtle border to title bar (matching main UI)
    local titleBarBorder = Instance.new("UIStroke")
    titleBarBorder.Color = Color3.fromRGB(60, 60, 60)
    titleBarBorder.Thickness = 1
    titleBarBorder.Transparency = 0.3
    titleBarBorder.Parent = panelTitleBar

    local panelTitle = Instance.new("TextLabel")
    panelTitle.Name = "Title"
    panelTitle.Size = UDim2.new(1, -40, 1, 0)
    panelTitle.Position = UDim2.new(0, 15, 0, 0)
    panelTitle.BackgroundTransparency = 1
    panelTitle.Text = "Settings"
    panelTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
    panelTitle.TextSize = 17
    panelTitle.Font = Enum.Font.GothamSemibold
    panelTitle.TextXAlignment = Enum.TextXAlignment.Left
    panelTitle.Parent = panelTitleBar

    local settingsCloseButton = Instance.new("TextButton")
    settingsCloseButton.Name = "CloseButton"
    settingsCloseButton.Size = UDim2.new(0, 32, 0, 32)
    settingsCloseButton.Position = UDim2.new(1, -40, 0, 6.5)
    settingsCloseButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    settingsCloseButton.Text = "×"
    settingsCloseButton.TextColor3 = Color3.fromRGB(220, 220, 220)
    settingsCloseButton.TextSize = 18
    settingsCloseButton.Font = Enum.Font.GothamBold
    settingsCloseButton.BorderSizePixel = 0
    settingsCloseButton.Parent = panelTitleBar

    local settingsCloseCorner = Instance.new("UICorner")
    settingsCloseCorner.CornerRadius = UDim.new(0, 6)
    settingsCloseCorner.Parent = settingsCloseButton

    settingsCloseButton.MouseEnter:Connect(function()
        settingsCloseButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    end)
    settingsCloseButton.MouseLeave:Connect(function()
        settingsCloseButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end)

    settingsCloseButton.MouseButton1Click:Connect(closeSettingsPanel)

    -- Create transparent drag area overlay (excluding close button)
    local dragArea = Instance.new("TextButton")
    dragArea.Name = "DragArea"
    dragArea.Size = UDim2.new(1, -50, 1, 0)
    dragArea.Position = UDim2.new(0, 0, 0, 0)
    dragArea.BackgroundTransparency = 1
    dragArea.Text = ""
    dragArea.BorderSizePixel = 0
    dragArea.ZIndex = 10
    dragArea.Parent = panelTitleBar

    local optionsContainer = Instance.new("ScrollingFrame")
    optionsContainer.Name = "Options"
    optionsContainer.Size = UDim2.new(1, -20, 1, -79)
    optionsContainer.Position = UDim2.new(0, 10, 0, 59)
    optionsContainer.BackgroundTransparency = 1
    optionsContainer.BorderSizePixel = 0
    optionsContainer.ScrollBarThickness = 6
    optionsContainer.ScrollBarImageColor3 = Color3.fromRGB(40, 40, 40)
    optionsContainer.Parent = settingsPanel

    local optionsLayout = Instance.new("UIListLayout")
    optionsLayout.Padding = UDim.new(0, 8)
    optionsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    optionsLayout.Parent = optionsContainer

    local optionsPadding = Instance.new("UIPadding")
    optionsPadding.PaddingTop = UDim.new(0, 8)
    optionsPadding.PaddingBottom = UDim.new(0, 8)
    optionsPadding.PaddingLeft = UDim.new(0, 10)
    optionsPadding.PaddingRight = UDim.new(0, 10)
    optionsPadding.Parent = optionsContainer
    
    -- Update canvas size when content changes
    optionsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        local contentSize = optionsLayout.AbsoluteContentSize
        optionsContainer.CanvasSize = UDim2.new(0, 0, 0, contentSize.Y + 10)
    end)

    createSettingsToggle(optionsContainer, "Show Location Hub Button", settingsState.showLocationHubButton, function(state)
        settingsState.showLocationHubButton = state
        updateLocationHubVisibility()
        saveSettings() -- Save settings when changed
    end)

    createSettingsToggle(optionsContainer, "Disable Alt + Right Click requirement", settingsState.disableAltRequirement, function(state)
        settingsState.disableAltRequirement = state
        saveSettings() -- Save settings when changed
    end)

    createSettingsToggle(optionsContainer, "Disable Hover Quick Info", settingsState.disableHoverInfo, function(state)
        settingsState.disableHoverInfo = state
        if state then
            updateHoverInfoDisplay(nil)
        end
        saveSettings() -- Save settings when changed
    end)

    createSettingsToggle(optionsContainer, "Disable Hover Outline", settingsState.disableHoverOutline, function(state)
        settingsState.disableHoverOutline = state
        if state then
            clearHoverHighlight()
        elseif hoveredPlayer then
            applyHoverHighlight(hoveredPlayer.Character)
        end
        saveSettings() -- Save settings when changed
    end)

    createSettingsToggle(optionsContainer, "Disable all Tip Jars", settingsState.hideAllTipJars, function(state)
        settingsState.hideAllTipJars = state
        applyTipJarVisibilityForAllPlayers()
        saveSettings() -- Save settings when changed
    end)

    local hidePlayersToggleBtn, updateHidePlayersToggleFunc = createSettingsToggle(optionsContainer, "Hide All Players", playersHidden, function(state)
        if state ~= playersHidden then
            togglePlayersVisibility()
        end
    end)
    hidePlayersToggleButton = hidePlayersToggleBtn
    updateHidePlayersToggle = updateHidePlayersToggleFunc

    createSettingsToggle(optionsContainer, "Build Player Profile", settingsState.buildPlayerProfile, function(state)
        settingsState.buildPlayerProfile = state
        saveSettings() -- Save settings when changed
        if state then
            -- Start profile building system
            startProfileUpdateSystem()
        else
            -- Stop profile building system
            stopProfileUpdateSystem()
        end
    end)

    createSettingsSlider(optionsContainer, "Hover Range", 20, 100, math.max(20, math.min(100, settingsState.hoverRange or 20)), function(value)
        settingsState.hoverRange = value
        saveSettings() -- Save settings when changed
    end)

    -- Create bubble-style hotkey frame (matching other settings)
    local hotkeyFrame = Instance.new("Frame")
    hotkeyFrame.Name = "HotkeyOption"
    hotkeyFrame.Size = UDim2.new(1, 0, 0, 50)
    hotkeyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    hotkeyFrame.BorderSizePixel = 0
    hotkeyFrame.Parent = optionsContainer

    local hotkeyCorner = Instance.new("UICorner")
    hotkeyCorner.CornerRadius = UDim.new(0, 8)
    hotkeyCorner.Parent = hotkeyFrame

    -- Add subtle border effect (matching player entry)
    local hotkeyBorder = Instance.new("UIStroke")
    hotkeyBorder.Color = Color3.fromRGB(60, 60, 60)
    hotkeyBorder.Thickness = 1
    hotkeyBorder.Transparency = 0.4
    hotkeyBorder.Parent = hotkeyFrame

    local hotkeyLabel = Instance.new("TextLabel")
    hotkeyLabel.Name = "Label"
    hotkeyLabel.Size = UDim2.new(1, -80, 1, 0)
    hotkeyLabel.Position = UDim2.new(0, 10, 0, 0)
    hotkeyLabel.BackgroundTransparency = 1
    hotkeyLabel.Text = "Toggle Hotkey"
    hotkeyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    hotkeyLabel.TextSize = 14
    hotkeyLabel.Font = Enum.Font.GothamBold
    hotkeyLabel.TextXAlignment = Enum.TextXAlignment.Left
    hotkeyLabel.Parent = hotkeyFrame

    toggleKeyButton = Instance.new("TextButton")
    toggleKeyButton.Name = "HotkeyButton"
    toggleKeyButton.Size = UDim2.new(0, 60, 0, 26)
    toggleKeyButton.Position = UDim2.new(1, -70, 0.5, -13)
    toggleKeyButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    toggleKeyButton.TextColor3 = Color3.fromRGB(220, 220, 220)
    toggleKeyButton.TextSize = 12
    toggleKeyButton.Font = Enum.Font.GothamBold
    toggleKeyButton.BorderSizePixel = 0
    toggleKeyButton.Parent = hotkeyFrame

    local toggleKeyCorner = Instance.new("UICorner")
    toggleKeyCorner.CornerRadius = UDim.new(0, 6)
    toggleKeyCorner.Parent = toggleKeyButton

    -- Add border to hotkey button (matching other buttons)
    local toggleKeyButtonBorder = Instance.new("UIStroke")
    toggleKeyButtonBorder.Color = Color3.fromRGB(60, 60, 60)
    toggleKeyButtonBorder.Thickness = 1
    toggleKeyButtonBorder.Transparency = 0.3
    toggleKeyButtonBorder.Parent = toggleKeyButton

    local function updateHotkeyButton()
        if settingsState.toggleKeyCode then
            toggleKeyButton.Text = settingsState.toggleKeyCode.Name
        else
            toggleKeyButton.Text = "None"
        end
    end

    updateHotkeyButton()

    -- Hover effect for hotkey button
    toggleKeyButton.MouseEnter:Connect(function()
        toggleKeyButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end)
    toggleKeyButton.MouseLeave:Connect(function()
        if not toggleKeyListening then
            toggleKeyButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        end
    end)

    -- Hover effect for entire frame
    hotkeyFrame.MouseEnter:Connect(function()
        hotkeyFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    end)
    hotkeyFrame.MouseLeave:Connect(function()
        hotkeyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    end)

    toggleKeyButton.MouseButton1Click:Connect(function()
        -- Disconnect previous connection if exists
        if hotkeyListeningConnection then
            hotkeyListeningConnection:Disconnect()
            hotkeyListeningConnection = nil
        end
        
        toggleKeyListening = true
        toggleKeyButton.Text = "Press key..."
        toggleKeyButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        print("TipStatsGUI: Waiting for key press...")
        
        -- Create dedicated connection for hotkey listening
        hotkeyListeningConnection = UserInputService.InputBegan:Connect(function(input, processed)
            if not scriptRunning then
                return
            end
            
            if not toggleKeyListening then
                if hotkeyListeningConnection then
                    hotkeyListeningConnection:Disconnect()
                    hotkeyListeningConnection = nil
                end
                return
            end
            
            -- Handle keyboard input
            if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode then
                -- Allow escape key to cancel
                if input.KeyCode == Enum.KeyCode.Escape then
                    toggleKeyListening = false
                    if toggleKeyButton then
                        local function updateHotkeyButton()
                            if settingsState.toggleKeyCode then
                                toggleKeyButton.Text = settingsState.toggleKeyCode.Name
                            else
                                toggleKeyButton.Text = "None"
                            end
                        end
                        updateHotkeyButton()
                        toggleKeyButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                    end
                    print("TipStatsGUI: Hotkey listening cancelled (Escape)")
                    if hotkeyListeningConnection then
                        hotkeyListeningConnection:Disconnect()
                        hotkeyListeningConnection = nil
                    end
                    return
                end
                
                -- Capture any valid key
                if input.KeyCode ~= Enum.KeyCode.Unknown then
                    settingsState.toggleKeyCode = input.KeyCode
                    toggleKeyListening = false
                    
                    if toggleKeyButton then
                        toggleKeyButton.Text = input.KeyCode.Name
                        toggleKeyButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                    end
                    
                    print("TipStatsGUI: Hotkey set to", input.KeyCode.Name)
                    saveSettings() -- Save settings when hotkey changes
                    if hotkeyListeningConnection then
                        hotkeyListeningConnection:Disconnect()
                        hotkeyListeningConnection = nil
                    end
                    return
                end
            -- Handle mouse clicks to cancel
            elseif input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 then
                toggleKeyListening = false
                if toggleKeyButton then
                    local function updateHotkeyButton()
                        if settingsState.toggleKeyCode then
                            toggleKeyButton.Text = settingsState.toggleKeyCode.Name
                        else
                            toggleKeyButton.Text = "None"
                        end
                    end
                    updateHotkeyButton()
                    toggleKeyButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                end
                print("TipStatsGUI: Hotkey listening cancelled (mouse click)")
                if hotkeyListeningConnection then
                    hotkeyListeningConnection:Disconnect()
                    hotkeyListeningConnection = nil
                end
            end
        end)
    end)
    
    -- Report Bug button (matching other settings toggles exactly)
    local reportBugFrame = Instance.new("Frame")
    reportBugFrame.Name = "ReportBugOption"
    reportBugFrame.Size = UDim2.new(1, 0, 0, 50)
    reportBugFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    reportBugFrame.BorderSizePixel = 0
    reportBugFrame.Visible = true
    reportBugFrame.Parent = optionsContainer

    local reportBugCorner = Instance.new("UICorner")
    reportBugCorner.CornerRadius = UDim.new(0, 8)
    reportBugCorner.Parent = reportBugFrame

    local reportBugBorder = Instance.new("UIStroke")
    reportBugBorder.Color = Color3.fromRGB(60, 60, 60)
    reportBugBorder.Thickness = 1
    reportBugBorder.Transparency = 0.4
    reportBugBorder.Parent = reportBugFrame

    local reportBugLabel = Instance.new("TextLabel")
    reportBugLabel.Name = "Label"
    reportBugLabel.Size = UDim2.new(1, -20, 1, 0)
    reportBugLabel.Position = UDim2.new(0, 10, 0, 0)
    reportBugLabel.BackgroundTransparency = 1
    reportBugLabel.Text = "Report Bug"
    reportBugLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    reportBugLabel.TextSize = 14
    reportBugLabel.Font = Enum.Font.GothamBold
    reportBugLabel.TextXAlignment = Enum.TextXAlignment.Left
    reportBugLabel.Visible = true
    reportBugLabel.Parent = reportBugFrame
    reportBugLabel.Active = false

    -- Make entire frame clickable with TextButton overlay
    local reportBugButton = Instance.new("TextButton")
    reportBugButton.Name = "ReportBugButton"
    reportBugButton.Size = UDim2.new(1, 0, 1, 0)
    reportBugButton.Position = UDim2.new(0, 0, 0, 0)
    reportBugButton.BackgroundTransparency = 1
    reportBugButton.Text = ""
    reportBugButton.BorderSizePixel = 0
    reportBugButton.ZIndex = 2
    reportBugButton.Visible = true
    reportBugButton.Parent = reportBugFrame

    reportBugFrame.MouseEnter:Connect(function()
        reportBugFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    end)
    reportBugFrame.MouseLeave:Connect(function()
        reportBugFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    end)

    reportBugButton.MouseButton1Click:Connect(function()
        local discordUsername = "dckrzw"
        pcall(function()
            setclipboard(discordUsername)
            createNotification(
                "Report Bug",
                "Discord username '" .. discordUsername .. "' copied to clipboard!",
                "success"
            )
        end)
    end)
    
    print("TipStatsGUI: Report Bug button created and added to settings")
    
    -- Force canvas size update after all elements are added
    task.wait(0.2)
    local contentSize = optionsLayout.AbsoluteContentSize
    optionsContainer.CanvasSize = UDim2.new(0, 0, 0, contentSize.Y + 20)
    
    -- Update canvas size when content changes
    optionsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        local newContentSize = optionsLayout.AbsoluteContentSize
        optionsContainer.CanvasSize = UDim2.new(0, 0, 0, newContentSize.Y + 20)
    end)

    -- Make title bar draggable
    local draggingSettings = false
    local settingsDragInput = nil
    local settingsDragStart = nil
    local settingsStartPos = nil
    
    local function updateSettingsDrag(input)
        local delta = input.Position - settingsDragStart
        settingsPanel.Position = UDim2.new(
            settingsStartPos.X.Scale,
            settingsStartPos.X.Offset + delta.X,
            settingsStartPos.Y.Scale,
            settingsStartPos.Y.Offset + delta.Y
        )
    end
    
    dragArea.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingSettings = true
            settingsDragStart = input.Position
            settingsStartPos = settingsPanel.Position
            
            local connection
            connection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    draggingSettings = false
                    if connection then
                        connection:Disconnect()
                    end
                end
            end)
        end
    end)
    
    dragArea.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            settingsDragInput = input
        end
    end)

    if settingsDragConnection then
        settingsDragConnection:Disconnect()
        settingsDragConnection = nil
    end

    settingsDragConnection = UserInputService.InputChanged:Connect(function(input)
        if input == settingsDragInput and draggingSettings then
            updateSettingsDrag(input)
        end
    end)
end

settingsButton.MouseButton1Click:Connect(function()
    pcall(function()
        toggleSettingsPanel()
    end)
end)

-- Location Hub function (defined before button so it can be called)
local function createLocationHub()
    -- Close existing UI if open
    if locationHubUI then
        -- Save position before destroying
        savedLocationHubPosition = locationHubUI.Position
        locationHubUI:Destroy()
        locationHubUI = nil
        return
    end
        
    -- Create location hub frame
    locationHubUI = Instance.new("Frame")
    locationHubUI.Name = "LocationHub"
    locationHubUI.Size = UDim2.new(0, 400, 0, 500)
    -- Use saved position if available, otherwise use default
    locationHubUI.Position = savedLocationHubPosition or UDim2.new(0.5, -200, 0.5, -250)
    locationHubUI.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    locationHubUI.BorderSizePixel = 0
    locationHubUI.Parent = screenGui
    locationHubUI.ZIndex = 15
    
    local hubCorner = Instance.new("UICorner")
    hubCorner.CornerRadius = UDim.new(0, 10)
    hubCorner.Parent = locationHubUI
    
    -- Add subtle border effect (matching player entry style)
    local hubBorder = Instance.new("UIStroke")
    hubBorder.Color = Color3.fromRGB(60, 60, 60)
    hubBorder.Thickness = 1
    hubBorder.Transparency = 0.4
    hubBorder.Parent = locationHubUI
    
    -- Title bar
    local hubTitleBar = Instance.new("Frame")
    hubTitleBar.Name = "TitleBar"
    hubTitleBar.Size = UDim2.new(1, 0, 0, 45)
    hubTitleBar.Position = UDim2.new(0, 0, 0, 0)
    hubTitleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    hubTitleBar.BorderSizePixel = 0
    hubTitleBar.Parent = locationHubUI
    
    local hubTitleCorner = Instance.new("UICorner")
    hubTitleCorner.CornerRadius = UDim.new(0, 10)
    hubTitleCorner.Parent = hubTitleBar
    
    -- Add subtle border to title bar (matching main UI)
    local hubTitleBorder = Instance.new("UIStroke")
    hubTitleBorder.Color = Color3.fromRGB(60, 60, 60)
    hubTitleBorder.Thickness = 1
    hubTitleBorder.Transparency = 0.3
    hubTitleBorder.Parent = hubTitleBar
    
    -- Title text (matching main UI style)
    local hubTitleText = Instance.new("TextLabel")
    hubTitleText.Name = "TitleText"
    hubTitleText.Size = UDim2.new(1, -20, 1, 0)
    hubTitleText.Position = UDim2.new(0, 15, 0, 0)
    hubTitleText.BackgroundTransparency = 1
    hubTitleText.Text = "Location Hub"
    hubTitleText.TextColor3 = Color3.fromRGB(240, 240, 240)
    hubTitleText.TextSize = 17
    hubTitleText.Font = Enum.Font.GothamSemibold
    hubTitleText.TextXAlignment = Enum.TextXAlignment.Left
    hubTitleText.Parent = hubTitleBar
    
    -- Close button
    local hubCloseButton = Instance.new("TextButton")
    hubCloseButton.Name = "CloseButton"
    hubCloseButton.Size = UDim2.new(0, 32, 0, 32)
    hubCloseButton.Position = UDim2.new(1, -40, 0, 6.5)
    hubCloseButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    hubCloseButton.Text = "×"
    hubCloseButton.TextColor3 = Color3.fromRGB(220, 220, 220)
    hubCloseButton.TextSize = 18
    hubCloseButton.Font = Enum.Font.GothamBold
    hubCloseButton.BorderSizePixel = 0
    hubCloseButton.Parent = hubTitleBar
    
    local hubCloseCorner = Instance.new("UICorner")
    hubCloseCorner.CornerRadius = UDim.new(0, 6)
    hubCloseCorner.Parent = hubCloseButton
    
    -- Add border to close button
    local hubCloseBorder = Instance.new("UIStroke")
    hubCloseBorder.Color = Color3.fromRGB(60, 60, 60)
    hubCloseBorder.Thickness = 1
    hubCloseBorder.Transparency = 0.3
    hubCloseBorder.Parent = hubCloseButton
    
    hubCloseButton.MouseEnter:Connect(function()
        hubCloseButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    end)
    hubCloseButton.MouseLeave:Connect(function()
        hubCloseButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end)
    
    hubCloseButton.MouseButton1Click:Connect(function()
        -- Save position before destroying
        if locationHubUI then
            savedLocationHubPosition = locationHubUI.Position
        end
        locationHubUI:Destroy()
        locationHubUI = nil
    end)
    
    -- Make title bar draggable
    local hubDragging = false
    local hubDragInput = nil
    local hubDragStart = nil
    local hubStartPos = nil
    
    local function hubUpdate(input)
        if hubDragging and hubDragStart and hubStartPos then
            local delta = input.Position - hubDragStart
            locationHubUI.Position = UDim2.new(
                hubStartPos.X.Scale, hubStartPos.X.Offset + delta.X,
                hubStartPos.Y.Scale, hubStartPos.Y.Offset + delta.Y
            )
        end
    end
    
    hubTitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            hubDragging = true
            hubDragStart = input.Position
            hubStartPos = locationHubUI.Position
            
            local connection
            connection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    hubDragging = false
                    hubDragInput = nil
                    connection:Disconnect()
                end
            end)
        end
    end)
    
    hubTitleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            hubDragInput = input
        end
    end)
    
    local dragConnection
    dragConnection = UserInputService.InputChanged:Connect(function(input)
        if hubDragging and input == hubDragInput then
            hubUpdate(input)
        end
    end)
    
    -- Clean up connection when hub is destroyed
    locationHubUI.AncestryChanged:Connect(function()
        pcall(function()
            if locationHubUI and not locationHubUI.Parent then
                if dragConnection then
                    dragConnection:Disconnect()
                end
            end
        end)
    end)
    
    -- Tab bar (Windows-style tabs)
    local tabBar = Instance.new("Frame")
    tabBar.Name = "TabBar"
    tabBar.Size = UDim2.new(1, 0, 0, 35)
    tabBar.Position = UDim2.new(0, 0, 0, 45)
    tabBar.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    tabBar.BorderSizePixel = 0
    tabBar.Parent = locationHubUI
    
    local tabBarLayout = Instance.new("UIListLayout")
    tabBarLayout.FillDirection = Enum.FillDirection.Horizontal
    tabBarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    tabBarLayout.Padding = UDim.new(0, 2)
    tabBarLayout.Parent = tabBar
    
    local tabBarPadding = Instance.new("UIPadding")
    tabBarPadding.PaddingLeft = UDim.new(0, 2)
    tabBarPadding.PaddingRight = UDim.new(0, 2)
    tabBarPadding.PaddingTop = UDim.new(0, 2)
    tabBarPadding.PaddingBottom = UDim.new(0, 2)
    tabBarPadding.Parent = tabBar
    
    -- Tab state
    local activeTab = "Locations"
    local locationsContent = nil
    local groupsContent = nil
    
    -- Function to create tab button
    local function createTabButton(tabName, isActive)
        local tabButton = Instance.new("TextButton")
        tabButton.Name = tabName .. "Tab"
        tabButton.Size = UDim2.new(0.5, -3, 1, -4)
        tabButton.BackgroundColor3 = isActive and Color3.fromRGB(20, 20, 20) or Color3.fromRGB(12, 12, 12)
        tabButton.BorderSizePixel = 0
        tabButton.Text = tabName
        tabButton.TextColor3 = isActive and Color3.fromRGB(240, 240, 240) or Color3.fromRGB(150, 150, 150)
        tabButton.TextSize = 14
        tabButton.Font = Enum.Font.GothamSemibold
        tabButton.Parent = tabBar
        
        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 6)
        tabCorner.Parent = tabButton
        
        -- Active tab indicator (bottom border)
        if isActive then
            local activeIndicator = Instance.new("Frame")
            activeIndicator.Name = "ActiveIndicator"
            activeIndicator.Size = UDim2.new(1, 0, 0, 3)
            activeIndicator.Position = UDim2.new(0, 0, 1, -3)
            activeIndicator.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
            activeIndicator.BorderSizePixel = 0
            activeIndicator.Parent = tabButton
            
            local indicatorCorner = Instance.new("UICorner")
            indicatorCorner.CornerRadius = UDim.new(0, 2)
            indicatorCorner.Parent = activeIndicator
        end
        
        tabButton.MouseEnter:Connect(function()
            if not isActive then
                tabButton.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
            end
        end)
        
        tabButton.MouseLeave:Connect(function()
            if not isActive then
                tabButton.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
            end
        end)
        
        tabButton.MouseButton1Click:Connect(function()
            if activeTab == tabName then
                return
            end
            
            -- Update active tab
            activeTab = tabName
            
            -- Update all tabs
            for _, child in ipairs(tabBar:GetChildren()) do
                if child:IsA("TextButton") then
                    local isNowActive = child.Name == (tabName .. "Tab")
                    child.BackgroundColor3 = isNowActive and Color3.fromRGB(20, 20, 20) or Color3.fromRGB(12, 12, 12)
                    child.TextColor3 = isNowActive and Color3.fromRGB(240, 240, 240) or Color3.fromRGB(150, 150, 150)
                    
                    -- Update active indicator
                    local indicator = child:FindFirstChild("ActiveIndicator")
                    if isNowActive and not indicator then
                        indicator = Instance.new("Frame")
                        indicator.Name = "ActiveIndicator"
                        indicator.Size = UDim2.new(1, 0, 0, 3)
                        indicator.Position = UDim2.new(0, 0, 1, -3)
                        indicator.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
                        indicator.BorderSizePixel = 0
                        indicator.Parent = child
                        
                        local indicatorCorner = Instance.new("UICorner")
                        indicatorCorner.CornerRadius = UDim.new(0, 2)
                        indicatorCorner.Parent = indicator
                    elseif not isNowActive and indicator then
                        indicator:Destroy()
                    end
                end
            end
            
            -- Show/hide content
            if locationsContent then
                locationsContent.Visible = (tabName == "Locations")
            end
            if groupsContent then
                groupsContent.Visible = (tabName == "Groups")
            end
        end)
        
        return tabButton
    end
    
    -- Create tabs
    createTabButton("Locations", true)
    createTabButton("Groups", false)
    
    -- Content area (matching main UI scrolling frame) - Locations tab
    locationsContent = Instance.new("ScrollingFrame")
    locationsContent.Name = "LocationsContent"
    locationsContent.Size = UDim2.new(1, -20, 1, -100)
    locationsContent.Position = UDim2.new(0, 10, 0, 80)
    locationsContent.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    locationsContent.BorderSizePixel = 0
    locationsContent.ScrollBarThickness = 6
    locationsContent.ScrollBarImageColor3 = Color3.fromRGB(40, 40, 40)
    locationsContent.Visible = true
    locationsContent.Parent = locationHubUI
    
    local locationsContentCorner = Instance.new("UICorner")
    locationsContentCorner.CornerRadius = UDim.new(0, 6)
    locationsContentCorner.Parent = locationsContent
    
    local locationsLayout = Instance.new("UIListLayout")
    locationsLayout.Padding = UDim.new(0, 4)
    locationsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    locationsLayout.Parent = locationsContent
    
    local locationsPadding = Instance.new("UIPadding")
    locationsPadding.PaddingTop = UDim.new(0, 5)
    locationsPadding.PaddingBottom = UDim.new(0, 5)
    locationsPadding.PaddingLeft = UDim.new(0, 0)
    locationsPadding.PaddingRight = UDim.new(0, 0)
    locationsPadding.Parent = locationsContent
    
    -- Groups content area
    groupsContent = Instance.new("ScrollingFrame")
    groupsContent.Name = "GroupsContent"
    groupsContent.Size = UDim2.new(1, -20, 1, -100)
    groupsContent.Position = UDim2.new(0, 10, 0, 80)
    groupsContent.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    groupsContent.BorderSizePixel = 0
    groupsContent.ScrollBarThickness = 6
    groupsContent.ScrollBarImageColor3 = Color3.fromRGB(40, 40, 40)
    groupsContent.Visible = false
    groupsContent.Parent = locationHubUI
    
    local groupsContentCorner = Instance.new("UICorner")
    groupsContentCorner.CornerRadius = UDim.new(0, 6)
    groupsContentCorner.Parent = groupsContent
    
    local groupsLayout = Instance.new("UIListLayout")
    groupsLayout.Padding = UDim.new(0, 8)
    groupsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    groupsLayout.Parent = groupsContent
    
    local groupsPadding = Instance.new("UIPadding")
    groupsPadding.PaddingTop = UDim.new(0, 5)
    groupsPadding.PaddingBottom = UDim.new(0, 5)
    groupsPadding.PaddingLeft = UDim.new(0, 5)
    groupsPadding.PaddingRight = UDim.new(0, 5)
    groupsPadding.Parent = groupsContent
    
    -- Define locations
    local locations = {
        {name = "Toilet hidden spot", position = Vector3.new(-401.484, -99.925, 382.643)},
        {name = "777", position = Vector3.new(-544.519, 5.501, -228.711)},
        {name = "Cave", position = Vector3.new(-477.880, -49.337, 283.521)},
        {name = "Piano", position = Vector3.new(-119.136, 8.733, -244.815)},
        {name = "Tower", position = Vector3.new(205.746, 291.924, -226.568)},
        {name = "Island", position = Vector3.new(415.040, 39.866, -19.076)},
        {name = "Deleted Spawn", position = Vector3.new(-96.276, 2614.579, 3177.841), deleted = true}
    }
    
    -- Function to create location button
    local function createLocationButton(locationData, index)
        local locationButton = Instance.new("TextButton")
        locationButton.Name = "Location" .. index
        locationButton.Size = UDim2.new(1, 0, 0, 60)
        locationButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        locationButton.BorderSizePixel = 0
        locationButton.Text = ""
        locationButton.Parent = locationsContent
        locationButton.LayoutOrder = index
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 8)
        buttonCorner.Parent = locationButton
        
        -- Add subtle border effect (matching player entry style)
        local buttonBorder = Instance.new("UIStroke")
        buttonBorder.Color = Color3.fromRGB(60, 60, 60)
        buttonBorder.Thickness = 1
        buttonBorder.Transparency = 0.3
        buttonBorder.Parent = locationButton
        
        -- Location name (matching player entry style)
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Name = "NameLabel"
        nameLabel.Size = UDim2.new(1, -110, 0, 22)
        nameLabel.Position = UDim2.new(0, 10, 0, 4)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = locationData.name
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.TextSize = 15
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.TextTruncate = Enum.TextTruncate.AtEnd
        nameLabel.Parent = locationButton
        
        -- Coordinates display
        local coordsLabel = Instance.new("TextLabel")
        coordsLabel.Name = "CoordsLabel"
        coordsLabel.Size = UDim2.new(1, -110, 0, 20)
        coordsLabel.Position = UDim2.new(0, 10, 0, 30)
        coordsLabel.BackgroundTransparency = 1
        coordsLabel.Text = string.format("X: %.2f, Y: %.2f, Z: %.2f", locationData.position.X, locationData.position.Y, locationData.position.Z)
        coordsLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
        coordsLabel.TextSize = 12
        coordsLabel.Font = Enum.Font.Gotham
        coordsLabel.TextXAlignment = Enum.TextXAlignment.Left
        coordsLabel.Parent = locationButton
        
        -- Teleport button (matching player entry button style)
        local teleportBtn = Instance.new("TextButton")
        teleportBtn.Name = "TeleportButton"
        teleportBtn.Size = UDim2.new(0, 22, 0, 22)
        teleportBtn.Position = UDim2.new(1, -32, 0, 4)
        teleportBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        teleportBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
        teleportBtn.Text = "→"
        teleportBtn.TextSize = 14
        teleportBtn.Font = Enum.Font.GothamBold
        teleportBtn.BorderSizePixel = 0
        teleportBtn.Parent = locationButton
        
        local teleportCorner = Instance.new("UICorner")
        teleportCorner.CornerRadius = UDim.new(0, 4)
        teleportCorner.Parent = teleportBtn
        
        -- Add small outline to teleport button
        local teleportBorder = Instance.new("UIStroke")
        teleportBorder.Color = Color3.fromRGB(60, 60, 60)
        teleportBorder.Thickness = 1
        teleportBorder.Transparency = 0.3
        teleportBorder.Parent = teleportBtn
        
        teleportBtn.MouseEnter:Connect(function()
            teleportBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        end)
        teleportBtn.MouseLeave:Connect(function()
            teleportBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        end)
        
        -- Teleport functionality
        teleportBtn.MouseButton1Click:Connect(function()
            local localPlayer = Players.LocalPlayer
            if not localPlayer or not localPlayer.Character then
                return
            end
            
            local root = getRoot(localPlayer.Character)
            if root then
                root.CFrame = CFrame.new(locationData.position)
                print("Teleported to:", locationData.name, locationData.position)
                -- Save position and close the hub after teleporting
                if locationHubUI then
                    savedLocationHubPosition = locationHubUI.Position
                end
                locationHubUI:Destroy()
                locationHubUI = nil
        end
    end)
        
        -- Hover effect for entire button (matching player entry style)
        locationButton.MouseEnter:Connect(function()
            locationButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        end)
        locationButton.MouseLeave:Connect(function()
            locationButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        end)
    end
    
    -- Create buttons for all locations
    for i, locationData in ipairs(locations) do
        createLocationButton(locationData, i)
    end
    
    -- Update canvas size for locations
    locationsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        local contentSize = locationsLayout.AbsoluteContentSize
        locationsContent.CanvasSize = UDim2.new(0, 0, 0, contentSize.Y + 10)
    end)
    
    -- Initial canvas size for locations
    task.wait()
    local locationsContentSize = locationsLayout.AbsoluteContentSize
    locationsContent.CanvasSize = UDim2.new(0, 0, 0, locationsContentSize.Y + 10)
    
    -- Groups detection and display system
    local GROUP_DETECTION_DISTANCE = 30
    local groupDetectionCounter = 0
    local activeGroupContainers = {} -- Keyed by group signature (sorted user IDs)
    local playerVoiceStates = {}
    local avatarViewports = {}
    
    -- Function to get group signature (for comparison)
    local function getGroupSignature(group)
        local userIds = {}
        for _, player in ipairs(group) do
            table.insert(userIds, player.UserId)
        end
        table.sort(userIds)
        return table.concat(userIds, ",")
    end
    
    -- Function to detect player groups
    local function detectPlayerGroups()
        local groups = {}
        local players = Players:GetPlayers()
        local processed = {}
        
        for _, player in ipairs(players) do
            if processed[player] then
                continue
            end
            
            local playerRoot = nil
            if player.Character then
                playerRoot = getRoot(player.Character)
            end
            
            if not playerRoot then
                continue
            end
            
            local group = {player}
            processed[player] = true
            
            -- Find all players within 30 studs
            for _, otherPlayer in ipairs(players) do
                if processed[otherPlayer] or otherPlayer == player then
                    continue
                end
                
                if otherPlayer.Character then
                    local otherRoot = getRoot(otherPlayer.Character)
                    if otherRoot then
                        local distance = (playerRoot.Position - otherRoot.Position).Magnitude
                        if distance <= GROUP_DETECTION_DISTANCE then
                            table.insert(group, otherPlayer)
                            processed[otherPlayer] = true
                        end
                    end
                end
            end
            
            -- Only add groups with 2+ players
            if #group >= 2 then
                table.insert(groups, group)
            end
        end
        
        return groups
    end
    
    -- Function to calculate group center
    local function calculateGroupCenter(group)
        local totalPos = Vector3.new(0, 0, 0)
        local count = 0
        
        for _, player in ipairs(group) do
            if player.Character then
                local root = getRoot(player.Character)
                if root then
                    totalPos = totalPos + root.Position
                    count = count + 1
                end
            end
        end
        
        if count > 0 then
            return totalPos / count
        end
        return nil
    end
    
    -- Function to create player avatar (using headshot API)
    local function createPlayerAvatar(player, parentFrame)
        -- Create avatar image label
        local avatarImage = Instance.new("ImageLabel")
        avatarImage.Name = "Avatar_" .. player.UserId
        avatarImage.Size = UDim2.new(0, 60, 0, 60)
        avatarImage.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        avatarImage.BorderSizePixel = 0
        avatarImage.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=150&height=150&format=png"
        avatarImage.Parent = parentFrame
        
        local avatarCorner = Instance.new("UICorner")
        avatarCorner.CornerRadius = UDim.new(0, 8)
        avatarCorner.Parent = avatarImage
        
        local avatarBorder = Instance.new("UIStroke")
        avatarBorder.Color = Color3.fromRGB(60, 60, 60)
        avatarBorder.Thickness = 1
        avatarBorder.Transparency = 0.3
        avatarBorder.Parent = avatarImage
        
        return avatarImage
    end
    
    -- Function to setup voice chat detection
    local function setupVoiceChatDetection(player)
        if playerVoiceStates[player.UserId] then
            return
        end
        
        playerVoiceStates[player.UserId] = {
            isSpeaking = false,
            isMuted = false
        }
        
        pcall(function()
            if VoiceChatService then
                local success, participant = pcall(function()
                    return VoiceChatService:GetPlayerAsync(player.UserId)
                end)
                
                if success and participant then
                    participant.StateChanged:Connect(function()
                        local newState = participant.State
                        if playerVoiceStates[player.UserId] then
                            playerVoiceStates[player.UserId].isSpeaking = (newState == Enum.VoiceChatState.Speaking)
                            playerVoiceStates[player.UserId].isMuted = (newState == Enum.VoiceChatState.Muted)
                        end
                    end)
                end
            end
        end)
    end
    
    -- Function to create group container
    local function createGroupContainer(group, groupIndex)
        local groupContainer = Instance.new("Frame")
        groupContainer.Name = "Group_" .. groupIndex
        groupContainer.Size = UDim2.new(1, 0, 0, 0)
        groupContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        groupContainer.BorderSizePixel = 0
        groupContainer.Parent = groupsContent
        groupContainer.LayoutOrder = groupIndex
        
        local groupCorner = Instance.new("UICorner")
        groupCorner.CornerRadius = UDim.new(0, 8)
        groupCorner.Parent = groupContainer
        
        local groupBorder = Instance.new("UIStroke")
        groupBorder.Color = Color3.fromRGB(60, 60, 60)
        groupBorder.Thickness = 1
        groupBorder.Transparency = 0.3
        groupBorder.Parent = groupContainer
        
        -- Group header
        local groupHeader = Instance.new("Frame")
        groupHeader.Name = "Header"
        groupHeader.Size = UDim2.new(1, 0, 0, 35)
        groupHeader.BackgroundTransparency = 1
        groupHeader.Parent = groupContainer
        
        local playerCountLabel = Instance.new("TextLabel")
        playerCountLabel.Name = "PlayerCount"
        playerCountLabel.Size = UDim2.new(1, -100, 1, 0)
        playerCountLabel.Position = UDim2.new(0, 10, 0, 0)
        playerCountLabel.BackgroundTransparency = 1
        playerCountLabel.Text = #group .. " Players"
        playerCountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        playerCountLabel.TextSize = 15
        playerCountLabel.Font = Enum.Font.GothamBold
        playerCountLabel.TextXAlignment = Enum.TextXAlignment.Left
        playerCountLabel.Parent = groupHeader
        
        -- Teleport button
        local teleportBtn = Instance.new("TextButton")
        teleportBtn.Name = "TeleportButton"
        teleportBtn.Size = UDim2.new(0, 80, 0, 28)
        teleportBtn.Position = UDim2.new(1, -90, 0, 3.5)
        teleportBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        teleportBtn.Text = "Teleport"
        teleportBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
        teleportBtn.TextSize = 13
        teleportBtn.Font = Enum.Font.GothamSemibold
        teleportBtn.BorderSizePixel = 0
        teleportBtn.Parent = groupHeader
        
        local teleportCorner = Instance.new("UICorner")
        teleportCorner.CornerRadius = UDim.new(0, 6)
        teleportCorner.Parent = teleportBtn
        
        local teleportBorder = Instance.new("UIStroke")
        teleportBorder.Color = Color3.fromRGB(60, 60, 60)
        teleportBorder.Thickness = 1
        teleportBorder.Transparency = 0.3
        teleportBorder.Parent = teleportBtn
        
        teleportBtn.MouseEnter:Connect(function()
            teleportBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end)
        
        teleportBtn.MouseLeave:Connect(function()
            teleportBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        end)
        
        -- Teleport functionality (uses current group data from container)
        teleportBtn.MouseButton1Click:Connect(function()
            -- Get current group from container's stored players
            local currentGroup = {}
            local avatarsContainer = groupContainer:FindFirstChild("AvatarsContainer")
            if avatarsContainer then
                for _, child in ipairs(avatarsContainer:GetChildren()) do
                    if child:IsA("Frame") and child.Name:match("^Player_") then
                        local userId = tonumber(child.Name:match("Player_(%d+)"))
                        if userId then
                            local player = Players:GetPlayerByUserId(userId)
                            if player then
                                table.insert(currentGroup, player)
                            end
                        end
                    end
                end
            end
            
            -- Fallback to original group if no players found
            if #currentGroup == 0 then
                currentGroup = group
            end
            
            local groupCenter = calculateGroupCenter(currentGroup)
            if groupCenter then
                local localPlayer = Players.LocalPlayer
                if localPlayer and localPlayer.Character then
                    local root = getRoot(localPlayer.Character)
                    if root then
                        root.CFrame = CFrame.new(groupCenter)
                    end
                end
            end
        end)
        
        -- Avatars container
        local avatarsContainer = Instance.new("Frame")
        avatarsContainer.Name = "AvatarsContainer"
        avatarsContainer.Size = UDim2.new(1, -20, 0, 0)
        avatarsContainer.Position = UDim2.new(0, 10, 0, 40)
        avatarsContainer.BackgroundTransparency = 1
        avatarsContainer.Parent = groupContainer
        
        local avatarsLayout = Instance.new("UIListLayout")
        avatarsLayout.FillDirection = Enum.FillDirection.Horizontal
        avatarsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
        avatarsLayout.Padding = UDim.new(0, 8)
        avatarsLayout.Parent = avatarsContainer
        
        -- Create avatar for each player
        for _, player in ipairs(group) do
            setupVoiceChatDetection(player)
            
            local playerFrame = Instance.new("Frame")
            playerFrame.Name = "Player_" .. player.UserId
            playerFrame.Size = UDim2.new(0, 60, 0, 85)
            playerFrame.BackgroundTransparency = 1
            playerFrame.Parent = avatarsContainer
            
            -- Avatar image (using headshot API)
            local avatarImage = createPlayerAvatar(player, playerFrame)
            avatarImage.Position = UDim2.new(0, 0, 0, 0)
            
            -- Voice chat indicator
            local vcIndicator = Instance.new("Frame")
            vcIndicator.Name = "VCIndicator"
            vcIndicator.Size = UDim2.new(0, 20, 0, 20)
            vcIndicator.Position = UDim2.new(1, -20, 0, 0)
            vcIndicator.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
            vcIndicator.BorderSizePixel = 0
            vcIndicator.Visible = false
            vcIndicator.Parent = avatarImage
            
            local vcCorner = Instance.new("UICorner")
            vcCorner.CornerRadius = UDim.new(0, 10)
            vcCorner.Parent = vcIndicator
            
            local vcIcon = Instance.new("TextLabel")
            vcIcon.Name = "Icon"
            vcIcon.Size = UDim2.new(1, 0, 1, 0)
            vcIcon.BackgroundTransparency = 1
            vcIcon.Text = "🎤"
            vcIcon.TextSize = 14
            vcIcon.Font = Enum.Font.GothamBold
            vcIcon.Parent = vcIndicator
            
            -- Update VC indicator
            local function updateVCIndicator()
                local voiceState = playerVoiceStates[player.UserId]
                if voiceState and voiceState.isSpeaking then
                    vcIndicator.Visible = true
                else
                    vcIndicator.Visible = false
                end
            end
            
            -- Check VC state periodically
            task.spawn(function()
                while playerFrame.Parent do
                    updateVCIndicator()
                    task.wait(0.1)
                end
            end)
            
            -- Player name
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Name = "NameLabel"
            nameLabel.Size = UDim2.new(1, 0, 0, 20)
            nameLabel.Position = UDim2.new(0, 0, 1, -20)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = player.Name
            nameLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
            nameLabel.TextSize = 11
            nameLabel.Font = Enum.Font.Gotham
            nameLabel.TextXAlignment = Enum.TextXAlignment.Center
            nameLabel.TextTruncate = Enum.TextTruncate.AtEnd
            nameLabel.Parent = playerFrame
        end
        
        -- Update avatars container size
        task.wait()
        local avatarsSize = avatarsLayout.AbsoluteContentSize
        avatarsContainer.Size = UDim2.new(1, -20, 0, avatarsSize.Y)
        groupContainer.Size = UDim2.new(1, 0, 0, 40 + avatarsSize.Y + 5)
        
        avatarsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            local newSize = avatarsLayout.AbsoluteContentSize
            avatarsContainer.Size = UDim2.new(1, -20, 0, newSize.Y)
            groupContainer.Size = UDim2.new(1, 0, 0, 40 + newSize.Y + 5)
        end)
        
        activeGroupContainers[groupIndex] = groupContainer
        
        return groupContainer
    end
    
    -- Function to get group signature (for comparison)
    local function getGroupSignature(group)
        local userIds = {}
        for _, player in ipairs(group) do
            table.insert(userIds, player.UserId)
        end
        table.sort(userIds)
        return table.concat(userIds, ",")
    end
    
    -- Helper function to create a single player avatar frame
    local function createPlayerFrame(player, parentContainer)
        setupVoiceChatDetection(player)
        
        local playerFrame = Instance.new("Frame")
        playerFrame.Name = "Player_" .. player.UserId
        playerFrame.Size = UDim2.new(0, 60, 0, 85)
        playerFrame.BackgroundTransparency = 1
        playerFrame.Parent = parentContainer
        
        local avatarImage = createPlayerAvatar(player, playerFrame)
        avatarImage.Position = UDim2.new(0, 0, 0, 0)
        
        local vcIndicator = Instance.new("Frame")
        vcIndicator.Name = "VCIndicator"
        vcIndicator.Size = UDim2.new(0, 20, 0, 20)
        vcIndicator.Position = UDim2.new(1, -20, 0, 0)
        vcIndicator.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        vcIndicator.BorderSizePixel = 0
        vcIndicator.Visible = false
        vcIndicator.Parent = avatarImage
        
        local vcCorner = Instance.new("UICorner")
        vcCorner.CornerRadius = UDim.new(0, 10)
        vcCorner.Parent = vcIndicator
        
        local vcIcon = Instance.new("TextLabel")
        vcIcon.Name = "Icon"
        vcIcon.Size = UDim2.new(1, 0, 1, 0)
        vcIcon.BackgroundTransparency = 1
        vcIcon.Text = "🎤"
        vcIcon.TextSize = 14
        vcIcon.Font = Enum.Font.GothamBold
        vcIcon.Parent = vcIndicator
        
        local function updateVCIndicator()
            local voiceState = playerVoiceStates[player.UserId]
            if voiceState and voiceState.isSpeaking then
                vcIndicator.Visible = true
            else
                vcIndicator.Visible = false
            end
        end
        
        task.spawn(function()
            while playerFrame.Parent do
                updateVCIndicator()
                task.wait(0.1)
            end
        end)
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Name = "NameLabel"
        nameLabel.Size = UDim2.new(1, 0, 0, 20)
        nameLabel.Position = UDim2.new(0, 0, 1, -20)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = player.Name
        nameLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
        nameLabel.TextSize = 11
        nameLabel.Font = Enum.Font.Gotham
        nameLabel.TextXAlignment = Enum.TextXAlignment.Center
        nameLabel.TextTruncate = Enum.TextTruncate.AtEnd
        nameLabel.Parent = playerFrame
        
        return playerFrame
    end
    
    -- Function to update groups display (truly incremental - only changes what actually changed)
    local function updateGroupsDisplay()
        -- Save scroll position FIRST before any changes
        local savedScrollPosition = groupsContent.CanvasPosition.Y
        
        -- Detect groups
        local groups = detectPlayerGroups()
        
        -- Create signature map for new groups
        local newGroupSignatures = {}
        for i, group in ipairs(groups) do
            local signature = getGroupSignature(group)
            newGroupSignatures[signature] = {group = group, index = i}
        end
        
        -- Find existing groups that should be removed
        local groupsToRemove = {}
        for signature, container in pairs(activeGroupContainers) do
            if not newGroupSignatures[signature] then
                table.insert(groupsToRemove, signature)
            end
        end
        
        -- Remove groups that no longer exist
        for _, signature in ipairs(groupsToRemove) do
            local container = activeGroupContainers[signature]
            if container and container.Parent then
                container:Destroy()
            end
            activeGroupContainers[signature] = nil
        end
        
        -- Update or create groups
        for signature, groupData in pairs(newGroupSignatures) do
            local existingContainer = activeGroupContainers[signature]
            
            if existingContainer and existingContainer.Parent then
                -- Only update if something actually changed
                local avatarsContainer = existingContainer:FindFirstChild("AvatarsContainer")
                if avatarsContainer then
                    -- Get existing player user IDs
                    local existingPlayerIds = {}
                    for _, child in ipairs(avatarsContainer:GetChildren()) do
                        if child:IsA("Frame") and child.Name:match("^Player_") then
                            local userId = tonumber(child.Name:match("Player_(%d+)"))
                            if userId then
                                existingPlayerIds[userId] = child
                            end
                        end
                    end
                    
                    -- Get new player user IDs
                    local newPlayerIds = {}
                    for _, player in ipairs(groupData.group) do
                        newPlayerIds[player.UserId] = player
                    end
                    
                    -- Only remove players that actually left (don't touch anything else)
                    for userId, playerFrame in pairs(existingPlayerIds) do
                        if not newPlayerIds[userId] then
                            playerFrame:Destroy()
                        end
                    end
                    
                    -- Only add players that actually joined (don't recreate existing ones)
                    for userId, player in pairs(newPlayerIds) do
                        if not existingPlayerIds[userId] then
                            createPlayerFrame(player, avatarsContainer)
                        end
                    end
                    
                    -- Update player count only if it changed
                    local header = existingContainer:FindFirstChild("Header")
                    if header then
                        local playerCountLabel = header:FindFirstChild("PlayerCount")
                        if playerCountLabel then
                            local newCount = #groupData.group
                            if playerCountLabel.Text ~= newCount .. " Players" then
                                playerCountLabel.Text = newCount .. " Players"
                            end
                        end
                    end
                end
            else
                -- Create new container
                local container = createGroupContainer(groupData.group, groupData.index)
                activeGroupContainers[signature] = container
            end
        end
        
        -- Update canvas size only if needed (check if it actually changed)
        local groupsContentSize = groupsLayout.AbsoluteContentSize
        local newCanvasSize = groupsContentSize.Y + 10
        if groupsContent.CanvasSize.Y.Offset ~= newCanvasSize then
            groupsContent.CanvasSize = UDim2.new(0, 0, 0, newCanvasSize)
            -- Only restore scroll if canvas size changed
            task.wait() -- Wait one frame for canvas size to apply
            local maxScroll = math.max(0, groupsContent.CanvasSize.Y.Offset - groupsContent.AbsoluteSize.Y)
            local restoredPosition = math.min(savedScrollPosition, maxScroll)
            groupsContent.CanvasPosition = Vector2.new(0, restoredPosition)
        end
    end
    
    -- Update groups periodically (removed AbsoluteContentSize connection to prevent scroll jumps)
    
    -- Start group detection loop
    task.spawn(function()
        while locationHubUI and locationHubUI.Parent do
            if activeTab == "Groups" then
                updateGroupsDisplay()
            end
            task.wait(1.5) -- Check every 1.5 seconds
        end
    end)
    
    -- Animate in
    local targetPosition = savedLocationHubPosition or UDim2.new(0.5, -200, 0.5, -250)
    locationHubUI.Size = UDim2.new(0, 0, 0, 0)
    locationHubUI.Position = UDim2.new(0.5, 0, 0.5, 0) -- Start from center
    locationHubUI.BackgroundTransparency = 1
    
    local openTween = TweenService:Create(
        locationHubUI,
        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 400, 0, 500), Position = targetPosition, BackgroundTransparency = 0}
    )
    openTween:Play()
end

-- Location Hub Button (separate icon at bottom left of screen)
locationHubButton = Instance.new("TextButton")
locationHubButton.Name = "LocationHubButton"
locationHubButton.Size = UDim2.new(0, 50, 0, 50)
locationHubButton.AnchorPoint = Vector2.new(0, 1) -- Bottom left anchor
locationHubButton.Position = UDim2.new(0, 20, 1, -20) -- 20px from bottom left
locationHubButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
locationHubButton.Text = "◉"
locationHubButton.TextColor3 = Color3.fromRGB(220, 220, 220)
locationHubButton.TextSize = 24
locationHubButton.Font = Enum.Font.GothamBold
locationHubButton.BorderSizePixel = 0
locationHubButton.Parent = screenGui
locationHubButton.ZIndex = 20 -- Always on top

local locationHubButtonCorner = Instance.new("UICorner")
locationHubButtonCorner.CornerRadius = UDim.new(0, 8)
locationHubButtonCorner.Parent = locationHubButton

-- Add border for visibility
local locationHubButtonBorder = Instance.new("UIStroke")
locationHubButtonBorder.Color = Color3.fromRGB(50, 50, 50)
locationHubButtonBorder.Thickness = 2
locationHubButtonBorder.Transparency = 0.3
locationHubButtonBorder.Parent = locationHubButton

-- Location hub button hover effect
locationHubButton.MouseEnter:Connect(function()
    locationHubButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
end)
locationHubButton.MouseLeave:Connect(function()
    locationHubButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
end)

-- Location hub button tooltip
showTooltip(locationHubButton, "Location Hub")

-- Location hub button click - open Location Hub
locationHubButton.MouseButton1Click:Connect(function()
    print("Location Hub button clicked")
    createLocationHub()
end)

updateLocationHubVisibility()

-- Search Button
local searchButton = Instance.new("TextButton")
searchButton.Name = "SearchButton"
searchButton.Size = UDim2.new(0, 32, 0, 32)
searchButton.Position = UDim2.new(1, -151, 0, 6.5) -- 37px spacing from avatar icon
searchButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
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
    searchButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
end)
searchButton.MouseLeave:Connect(function()
    searchButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
end)

-- Search button tooltip
showTooltip(searchButton, "Search players")

-- Local Player Avatar Icon
local localPlayer = Players.LocalPlayer
local avatarIcon = Instance.new("ImageButton")
avatarIcon.Name = "AvatarIcon"
avatarIcon.Size = UDim2.new(0, 32, 0, 32)
avatarIcon.Position = UDim2.new(1, -114, 0, 6.5) -- 37px spacing from minimize button
avatarIcon.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
avatarIcon.BorderSizePixel = 0
avatarIcon.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. localPlayer.UserId .. "&width=150&height=150&format=png"
avatarIcon.Parent = titleBar

local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(0, 6)
avatarCorner.Parent = avatarIcon

-- Avatar icon hover effect
avatarIcon.MouseEnter:Connect(function()
    avatarIcon.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
end)
avatarIcon.MouseLeave:Connect(function()
    avatarIcon.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
end)

-- Avatar icon tooltip
showTooltip(avatarIcon, "View your stats")

-- Minimize Button
local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 32, 0, 32)
minimizeButton.Position = UDim2.new(1, -77, 0, 6.5) -- 37px spacing from close button
minimizeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
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
    minimizeButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
end)
minimizeButton.MouseLeave:Connect(function()
    minimizeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
end)

-- Minimize button tooltip
showTooltip(minimizeButton, "Minimize")

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 32, 0, 32)
closeButton.Position = UDim2.new(1, -40, 0, 6.5) -- Right edge, 8px from edge (40 - 32 = 8)
closeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
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
    closeButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
end)
closeButton.MouseLeave:Connect(function()
    closeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
end)

-- Close button tooltip
showTooltip(closeButton, "Close")

-- Minimize/Maximize function (will be defined after scrollingFrame is created)
local toggleMinimize = nil
local forceCloseSearch = nil

-- Create Restore Button (hidden by default, shown when GUI is closed)
local restoreButton = Instance.new("TextButton")
restoreButton.Name = "RestoreButton"
restoreButton.Size = UDim2.new(0, 120, 0, 35)
restoreButton.Position = UDim2.new(1, -130, 0, 10)
restoreButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
restoreButton.Text = "Tip Stats"
restoreButton.TextColor3 = Color3.fromRGB(240, 240, 240)
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
    restoreButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
end)
restoreButton.MouseLeave:Connect(function()
    restoreButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
end)

-- Close/Open function
local isClosing = false
local function toggleClose()
    if isClosing then
        return -- Prevent multiple close calls
    end
    
    if isClosed then
        -- Opening animation
        isClosed = false
        mainFrame.Visible = true
        restoreButton.Visible = false
        
        -- Get saved position or use default center position
        local targetPosition = savedMainUIPosition or UDim2.new(0.5, -250, 0.5, -300)
        
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
            {Position = targetPosition}
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
        isClosing = true
        closeSettingsPanel()
        
        -- Save current position before closing
        savedMainUIPosition = mainFrame.Position
        
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
        
        -- Hide scrolling frame immediately when closing
        if scrollingFrame then
            scrollingFrame.Visible = false
        end
        
        closeSizeTween:Play()
        closePosTween:Play()
        closeFadeTween:Play()
        
        -- Hide and show restore button after animation
        closeFadeTween.Completed:Connect(function()
            isClosing = false -- Reset closing flag
            mainFrame.Visible = false
            if restoreButton then
                restoreButton.Visible = false
            end
        end)
    end
end

restoreButton.Visible = false
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
scrollingFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
scrollingFrame.BorderSizePixel = 0
scrollingFrame.ScrollBarThickness = 6
scrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(40, 40, 40)
scrollingFrame.Parent = mainFrame

local scrollCorner = Instance.new("UICorner")
scrollCorner.CornerRadius = UDim.new(0, 6)
scrollCorner.Parent = scrollingFrame

-- Now define the minimize function after scrollingFrame is created
toggleMinimize = function()
    -- Allow minimize even while closing - it will cancel the close operation
    if isClosing then
        isClosing = false -- Cancel the close operation
        isClosed = false -- Reset closed state since we're canceling the close
        -- Cancel any ongoing close animations
        if mainFrame then
            mainFrame.Visible = true
        end
    end
    
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
        if scrollingFrame then
            scrollingFrame.Visible = false
        end
        minimizeButton.Text = "+"
        if forceCloseSearch then
            forceCloseSearch(true)
        end
    else
        -- Show scrolling frame and animate
        if scrollingFrame then
            scrollingFrame.Visible = true
            scrollingFrame.BackgroundTransparency = 1
        end
        
        if scrollingFrame then
            local scrollFadeTween = TweenService:Create(
                scrollingFrame,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundTransparency = 0}
            )
            scrollFadeTween:Play()
        end
        
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

local hoverPreviewPlayer = nil

local function closePlayerInfoFrame(frame)
    if not frame or not frame.Parent then
        return
    end
    
    if frame:GetAttribute("Closing") then
        return
    end

    frame:SetAttribute("Closing", true)

    -- Collect all content to fade out
    local contentToFade = {}
    
    pcall(function()
        -- Add main content frames
        local titleBar = frame:FindFirstChild("TitleBar")
        local contentFrame = frame:FindFirstChild("ContentFrame")
        if titleBar then table.insert(contentToFade, titleBar) end
        if contentFrame then table.insert(contentToFade, contentFrame) end
        
        -- Add all other UI elements
        for _, child in ipairs(frame:GetChildren()) do
            if child ~= titleBar and child ~= contentFrame then
                if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("ImageLabel") or child:IsA("ImageButton") or child:IsA("Frame") then
                    table.insert(contentToFade, child)
                end
            end
        end
        
        -- Also fade out all descendants
        local contentSet = {}
        for _, element in ipairs(contentToFade) do
            contentSet[element] = true
        end
        
        for _, descendant in ipairs(frame:GetDescendants()) do
            if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("ImageLabel") or descendant:IsA("ImageButton") or descendant:IsA("UIStroke") then
                if not contentSet[descendant] then
                    contentSet[descendant] = true
                    table.insert(contentToFade, descendant)
                end
            end
        end
    end)

    -- Shrink and move frame (background transparency removed - keep background visible)
    local closeSizeTween = TweenService:Create(
        frame,
        TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        {Size = UDim2.new(0, 0, 0, 0)}
    )

    local closePosTween = TweenService:Create(
        frame,
        TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        {Position = playerInfoTargetPosition}
    )

    -- Fade out all content
    local fadeOutContentTweens = {}
    pcall(function()
        for _, element in ipairs(contentToFade) do
            if element and element.Parent and frame.Parent then
                local success, tween = pcall(function()
                    if element:IsA("TextLabel") or element:IsA("TextButton") then
                        return TweenService:Create(
                            element,
                            TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                            {TextTransparency = 1, BackgroundTransparency = element:IsA("TextButton") and 1 or element.BackgroundTransparency}
                        )
                    elseif element:IsA("ImageLabel") or element:IsA("ImageButton") then
                        return TweenService:Create(
                            element,
                            TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                            {ImageTransparency = 1, BackgroundTransparency = element:IsA("ImageButton") and 1 or element.BackgroundTransparency}
                        )
                    elseif element:IsA("Frame") then
                        return TweenService:Create(
                            element,
                            TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                            {BackgroundTransparency = 1}
                        )
                    elseif element:IsA("UIStroke") then
                        return TweenService:Create(
                            element,
                            TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                            {Transparency = 1}
                        )
                    end
                end)
                if success and tween then
                    table.insert(fadeOutContentTweens, tween)
                end
            end
        end
    end)

    -- Play all animations
    pcall(function()
        if frame and frame.Parent then
            -- frameFadeTween removed - background stays visible
            closeSizeTween:Play()
            closePosTween:Play()
            for _, tween in ipairs(fadeOutContentTweens) do
                if tween then
                    tween:Play()
                end
            end

            -- Destroy frame when animation completes
            closeSizeTween.Completed:Connect(function()
                if frame and frame.Parent then
                    frame:Destroy()
                end
            end)
        end
    end)
end

local function closePlayerInfoUIForPlayer(playerOrName, previewOnly)
    if not screenGui then
        return
    end

    local targetName = nil
    if typeof(playerOrName) == "Instance" and playerOrName:IsA("Player") then
        targetName = playerOrName.Name
    elseif typeof(playerOrName) == "string" then
        targetName = playerOrName
    end

    if not targetName then
        return
    end

    local existing = screenGui:FindFirstChild("PlayerInfo_" .. targetName)
    if existing then
        if previewOnly and existing:GetAttribute("HoverPreview") ~= true then
            return
        end
        closePlayerInfoFrame(existing)
    end
end

local function closeAllPlayerInfoUI(exceptPlayerName)
    if not screenGui then
        return
    end

    for _, child in ipairs(screenGui:GetChildren()) do
        if child:IsA("Frame") and string.sub(child.Name, 1, 11) == "PlayerInfo_" then
            if not exceptPlayerName or child.Name ~= "PlayerInfo_" .. exceptPlayerName then
                closePlayerInfoFrame(child)
            end
        end
    end
end

-- Forward declare createPlayerInfoUI
local createPlayerInfoUI

-- Function to create player info UI
createPlayerInfoUI = function(targetPlayer, options)
    options = options or {}
    local toggleOnExisting = options.toggleOnExisting ~= false
    local previewMode = options.previewMode == true
    ensureTipJarTracking(targetPlayer)

    if not previewMode then
        closeAllPlayerInfoUI(targetPlayer.Name)
    end

    -- Check if UI already exists
    local existingUI = screenGui:FindFirstChild("PlayerInfo_" .. targetPlayer.Name)
    if existingUI then
        local isClosing = existingUI:GetAttribute("Closing") == true
        local existingIsPreview = existingUI:GetAttribute("HoverPreview") == true
        
        -- If it's closing, destroy it first
        if isClosing then
            existingUI:Destroy()
        elseif previewMode and existingIsPreview then
            return existingUI
        elseif existingIsPreview and not previewMode then
            if hoverPreviewPlayer == targetPlayer then
                hoverPreviewPlayer = nil
            end
            closePlayerInfoFrame(existingUI)
        else
            if toggleOnExisting then
                closePlayerInfoFrame(existingUI)
                return nil
            end
            return existingUI
        end
    end
    
    -- Create info frame
    local infoFrame = Instance.new("Frame")
    infoFrame.Name = "PlayerInfo_" .. targetPlayer.Name
    local startPosition = UDim2.new(1, 20, 0, playerInfoTargetPosition.Y.Offset)
    infoFrame.Size = UDim2.new(0, 0, 0, 500)
    infoFrame.Position = startPosition
    infoFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    infoFrame.BorderSizePixel = 0
    infoFrame.BackgroundTransparency = 0
    infoFrame.Visible = true
    infoFrame.Parent = screenGui
    infoFrame.ZIndex = 10
    infoFrame.AnchorPoint = Vector2.new(1, 0)
    
    local infoCorner = Instance.new("UICorner")
    infoCorner.CornerRadius = UDim.new(0, 10)
    infoCorner.Parent = infoFrame
    
    local infoBorder = Instance.new("UIStroke")
    infoBorder.Color = Color3.fromRGB(50, 50, 50)
    infoBorder.Thickness = 1
    infoBorder.Transparency = 0.2
    infoBorder.Parent = infoFrame
    infoFrame:SetAttribute("HoverPreview", previewMode and true or false)
    
    -- Title bar
    local infoTitleBar = Instance.new("Frame")
    infoTitleBar.Name = "TitleBar"
    infoTitleBar.Size = UDim2.new(1, 0, 0, 45)
    infoTitleBar.Position = UDim2.new(0, 0, 0, 0)
    infoTitleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
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
    
    -- Hide button (individual hide)
    local infoHideButton = Instance.new("TextButton")
    infoHideButton.Name = "HideButton"
    infoHideButton.Size = UDim2.new(0, 32, 0, 32)
    infoHideButton.Position = UDim2.new(1, -114, 0, 6.5)
    infoHideButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    infoHideButton.Text = "H"
    infoHideButton.TextColor3 = Color3.fromRGB(150, 150, 150)
    infoHideButton.TextSize = 16
    infoHideButton.Font = Enum.Font.GothamBold
    infoHideButton.BorderSizePixel = 0
    infoHideButton.Parent = infoTitleBar

    local infoHideCorner = Instance.new("UICorner")
    infoHideCorner.CornerRadius = UDim.new(0, 6)
    infoHideCorner.Parent = infoHideButton

    showTooltip(infoHideButton, "Hide this player")
    
    -- Copy button (copy username)
    local infoCopyButton = Instance.new("TextButton")
    infoCopyButton.Name = "CopyButton"
    infoCopyButton.Size = UDim2.new(0, 32, 0, 32)
    infoCopyButton.Position = UDim2.new(1, -77, 0, 6.5)
    infoCopyButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    infoCopyButton.Text = "📋"
    infoCopyButton.TextColor3 = Color3.fromRGB(150, 150, 150)
    infoCopyButton.TextSize = 16
    infoCopyButton.Font = Enum.Font.GothamBold
    infoCopyButton.BorderSizePixel = 0
    infoCopyButton.Parent = infoTitleBar
    
    local infoCopyCorner = Instance.new("UICorner")
    infoCopyCorner.CornerRadius = UDim.new(0, 6)
    infoCopyCorner.Parent = infoCopyButton
    
    infoCopyButton.MouseEnter:Connect(function()
        infoCopyButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        infoCopyButton.TextColor3 = Color3.fromRGB(230, 230, 230)
    end)
    infoCopyButton.MouseLeave:Connect(function()
        infoCopyButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        infoCopyButton.TextColor3 = Color3.fromRGB(150, 150, 150)
    end)
    infoCopyButton.MouseButton1Click:Connect(function()
        -- Copy username to clipboard
        local username = targetPlayer.Name
        pcall(function()
            setclipboard(username)
        end)
    end)

    local infoHideButtonHovering = false
    local function updateInfoHideButtonState(hidden, hovering)
        local isHidden = hidden
        if isHidden == nil then
            isHidden = isPlayerIndividuallyHidden(targetPlayer)
        end
        local isHovering = hovering
        if isHovering == nil then
            isHovering = infoHideButtonHovering
        end
        local idleColor = isHidden and Color3.fromRGB(200, 120, 120) or Color3.fromRGB(150, 150, 150)
        local hoverColor = isHidden and Color3.fromRGB(255, 170, 170) or Color3.fromRGB(230, 230, 230)
        infoHideButton.TextColor3 = isHovering and hoverColor or idleColor
    end

    updateInfoHideButtonState()

    infoHideButton.MouseEnter:Connect(function()
        infoHideButtonHovering = true
        infoHideButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        updateInfoHideButtonState(nil, true)
    end)

    infoHideButton.MouseLeave:Connect(function()
        infoHideButtonHovering = false
        infoHideButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        updateInfoHideButtonState(nil, false)
    end)

    infoHideButton.MouseButton1Click:Connect(function()
        toggleIndividualHideState(targetPlayer)
        updateInfoHideButtonState()
    end)

    local infoHideStateConnection = individualHideStateChanged.Event:Connect(function(changedPlayer, hidden)
        if changedPlayer == targetPlayer then
            updateInfoHideButtonState(hidden)
        end
    end)
    
    -- Close button
    local infoCloseButton = Instance.new("TextButton")
    infoCloseButton.Name = "CloseButton"
    infoCloseButton.Size = UDim2.new(0, 32, 0, 32)
    infoCloseButton.Position = UDim2.new(1, -40, 0, 6.5)
    infoCloseButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    infoCloseButton.Text = "×"
    infoCloseButton.TextColor3 = Color3.fromRGB(150, 150, 150)
    infoCloseButton.TextSize = 18
    infoCloseButton.Font = Enum.Font.GothamBold
    infoCloseButton.BorderSizePixel = 0
    infoCloseButton.Parent = infoTitleBar
    
    local infoCloseCorner = Instance.new("UICorner")
    infoCloseCorner.CornerRadius = UDim.new(0, 6)
    infoCloseCorner.Parent = infoCloseButton
    
    infoCloseButton.MouseEnter:Connect(function()
        infoCloseButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        infoCloseButton.TextColor3 = Color3.fromRGB(230, 230, 230)
    end)
    infoCloseButton.MouseLeave:Connect(function()
        infoCloseButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        infoCloseButton.TextColor3 = Color3.fromRGB(150, 150, 150)
    end)
    
    infoCloseButton.MouseButton1Click:Connect(function()
        closePlayerInfoFrame(infoFrame)
    end)
    
    if previewMode then
        infoFrame.Destroying:Connect(function()
            if hoverPreviewPlayer == targetPlayer then
                hoverPreviewPlayer = nil
            end
        end)
    end
    
    infoFrame.Destroying:Connect(function()
        if infoHideStateConnection then
            infoHideStateConnection:Disconnect()
            infoHideStateConnection = nil
        end
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
    contentFrame.Position = UDim2.new(0, 20, 0, 55)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = infoFrame
    contentFrame.Parent = infoFrame
    
    -- Avatar
    local avatarImage = Instance.new("ImageLabel")
    avatarImage.Name = "Avatar"
    avatarImage.Size = UDim2.new(0, 100, 0, 100)
    avatarImage.Position = UDim2.new(0.5, -50, 0, 10)
    avatarImage.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
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
    statsListPadding.PaddingTop = UDim.new(0, 8)
    statsListPadding.PaddingBottom = UDim.new(0, 5)
    statsListPadding.PaddingLeft = UDim.new(0, 0)
    statsListPadding.PaddingRight = UDim.new(0, 0)
    statsListPadding.Parent = statsList
    
    local function createStatRow(label, value)
        local row = Instance.new("Frame")
        row.Name = label
        row.Size = UDim2.new(1, 0, 0, 35)
        row.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        row.BorderSizePixel = 0
        row.Parent = statsList
        
        local rowCorner = Instance.new("UICorner")
        rowCorner.CornerRadius = UDim.new(0, 8)
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
    receivedStat.Parent.Size = UDim2.new(1, -18, 0, 35)
    receivedStat.Parent.Position = UDim2.new(0, 15, 0, 0)
    local donatedStat = createStatRow("Donated", "0")
    donatedStat.Parent.LayoutOrder = 2
    donatedStat.Parent.Size = UDim2.new(1, -18, 0, 35)
    donatedStat.Parent.Position = UDim2.new(0, 15, 0, 0)
    local timeStat = createStatRow("Played Time", "0m")
    timeStat.Parent.LayoutOrder = 3
    timeStat.Parent.Size = UDim2.new(1, -18, 0, 35)
    timeStat.Parent.Position = UDim2.new(0, 15, 0, 0)
    local creditsStat = createStatRow("Credits", "0")
    creditsStat.Parent.LayoutOrder = 4
    creditsStat.Parent.Size = UDim2.new(1, -18, 0, 35)
    creditsStat.Parent.Position = UDim2.new(0, 15, 0, 0)
    
    -- Settings section header
    local settingsHeaderFrame = Instance.new("Frame")
    settingsHeaderFrame.Name = "SettingsHeader"
    settingsHeaderFrame.Size = UDim2.new(1, -20, 0, 35)
    settingsHeaderFrame.Position = UDim2.new(0, 20, 0, 0)
    settingsHeaderFrame.BackgroundTransparency = 1
    settingsHeaderFrame.LayoutOrder = 5
    settingsHeaderFrame.Parent = statsList
    
    local settingsHeader = Instance.new("TextLabel")
    settingsHeader.Name = "HeaderText"
    settingsHeader.Size = UDim2.new(1, 0, 1, 0)
    settingsHeader.Position = UDim2.new(0, 0, 0, 0)
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
    divider.Size = UDim2.new(1, 0, 0, 1)
    divider.Position = UDim2.new(0, 0, 1, -1)
    divider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    divider.BorderSizePixel = 0
    divider.Parent = settingsHeaderFrame
    
    -- Create ALL settings rows (must be after header) with LayoutOrder
    local aurasStat = createStatRow("Auras", "Off")
    aurasStat.Parent.LayoutOrder = 6
    aurasStat.Parent.Size = UDim2.new(1, -18, 0, 35)
    aurasStat.Parent.Position = UDim2.new(0, 15, 0, 0)
    local giftsStat = createStatRow("Gifts", "Off")
    giftsStat.Parent.LayoutOrder = 7
    giftsStat.Parent.Size = UDim2.new(1, -18, 0, 35)
    giftsStat.Parent.Position = UDim2.new(0, 15, 0, 0)
    local pianoStat = createStatRow("Piano", "Off")
    pianoStat.Parent.LayoutOrder = 8
    pianoStat.Parent.Size = UDim2.new(1, -18, 0, 35)
    pianoStat.Parent.Position = UDim2.new(0, 15, 0, 0)
    local rankStat = createStatRow("Title", "Off")
    rankStat.Parent.LayoutOrder = 9
    rankStat.Parent.Size = UDim2.new(1, -18, 0, 35)
    rankStat.Parent.Position = UDim2.new(0, 15, 0, 0)
    local shadowStat = createStatRow("Shadow", "Off")
    shadowStat.Parent.LayoutOrder = 10
    shadowStat.Parent.Size = UDim2.new(1, -18, 0, 35)
    shadowStat.Parent.Position = UDim2.new(0, 15, 0, 0)
    local teleportStat = createStatRow("Teleport", "Off")
    teleportStat.Parent.LayoutOrder = 11
    teleportStat.Parent.Size = UDim2.new(1, -18, 0, 35)
    teleportStat.Parent.Position = UDim2.new(0, 15, 0, 0)
    local timeSettingStat = createStatRow("Show Total Time", "Off")
    timeSettingStat.Parent.LayoutOrder = 12
    timeSettingStat.Parent.Size = UDim2.new(1, -18, 0, 35)
    timeSettingStat.Parent.Position = UDim2.new(0, 15, 0, 0)
    
    -- Backpack items section header
    local backpackHeaderFrame = Instance.new("Frame")
    backpackHeaderFrame.Name = "BackpackHeader"
    backpackHeaderFrame.Size = UDim2.new(1, -20, 0, 35)
    backpackHeaderFrame.Position = UDim2.new(0, 20, 0, 0)
    backpackHeaderFrame.BackgroundTransparency = 1
    backpackHeaderFrame.LayoutOrder = 13
    backpackHeaderFrame.Parent = statsList
    
    local backpackHeader = Instance.new("TextLabel")
    backpackHeader.Name = "HeaderText"
    backpackHeader.Size = UDim2.new(1, 0, 1, 0)
    backpackHeader.Position = UDim2.new(0, 0, 0, 0)
    backpackHeader.BackgroundTransparency = 1
    backpackHeader.Text = "Backpack Items"
    backpackHeader.TextColor3 = Color3.fromRGB(240, 240, 240)
    backpackHeader.TextSize = 16
    backpackHeader.Font = Enum.Font.GothamBold
    backpackHeader.TextXAlignment = Enum.TextXAlignment.Left
    backpackHeader.Parent = backpackHeaderFrame
    
    -- Divider line for backpack section
    local backpackDivider = Instance.new("Frame")
    backpackDivider.Name = "Divider"
    backpackDivider.Size = UDim2.new(1, 0, 0, 1)
    backpackDivider.Position = UDim2.new(0, 0, 1, -1)
    backpackDivider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    backpackDivider.BorderSizePixel = 0
    backpackDivider.Parent = backpackHeaderFrame
    
    -- Backpack items container
    local backpackItemsContainer = Instance.new("Frame")
    backpackItemsContainer.Name = "BackpackItemsContainer"
    backpackItemsContainer.Size = UDim2.new(1, 0, 0, 0)
    backpackItemsContainer.BackgroundTransparency = 1
    backpackItemsContainer.LayoutOrder = 14
    backpackItemsContainer.Parent = statsList
    
    local backpackItemsLayout = Instance.new("UIListLayout")
    backpackItemsLayout.Padding = UDim.new(0, 3)
    backpackItemsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    backpackItemsLayout.Parent = backpackItemsContainer
    
    -- Function to create backpack item display
    local function createBackpackItemRow(itemName, itemClass)
        local itemRow = Instance.new("Frame")
        itemRow.Name = itemName
        itemRow.Size = UDim2.new(1, 0, 0, 25)
        itemRow.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        itemRow.BorderSizePixel = 0
        itemRow.Parent = backpackItemsContainer
        
        local itemCorner = Instance.new("UICorner")
        itemCorner.CornerRadius = UDim.new(0, 4)
        itemCorner.Parent = itemRow
        
        local itemLabel = Instance.new("TextLabel")
        itemLabel.Name = "ItemLabel"
        itemLabel.Size = UDim2.new(1, -20, 1, 0)
        itemLabel.Position = UDim2.new(0, 20, 0, 0)
        itemLabel.BackgroundTransparency = 1
        itemLabel.Text = itemName .. " (" .. itemClass .. ")"
        itemLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
        itemLabel.TextSize = 12
        itemLabel.Font = Enum.Font.Gotham
        itemLabel.TextXAlignment = Enum.TextXAlignment.Left
        itemLabel.TextTruncate = Enum.TextTruncate.AtEnd
        itemLabel.Parent = itemRow
        
        return itemRow
    end
    
    -- Function to update backpack items display
    local function updateBackpackItems()
        -- Clear existing items (but keep UIListLayout)
        for _, child in ipairs(backpackItemsContainer:GetChildren()) do
            if child:IsA("Frame") or child:IsA("TextLabel") then
                child:Destroy()
            end
        end
        
        -- Get backpack
        local backpack = targetPlayer:FindFirstChild("Backpack")
        if not backpack then
            -- Show "No items" message if backpack doesn't exist
            local noItemsLabel = Instance.new("TextLabel")
            noItemsLabel.Name = "NoItems"
            noItemsLabel.Size = UDim2.new(1, -20, 0, 20)
            noItemsLabel.Position = UDim2.new(0, 20, 0, 0)
            noItemsLabel.BackgroundTransparency = 1
            noItemsLabel.Text = "No backpack found"
            noItemsLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
            noItemsLabel.TextSize = 12
            noItemsLabel.Font = Enum.Font.Gotham
            noItemsLabel.TextXAlignment = Enum.TextXAlignment.Left
            noItemsLabel.Parent = backpackItemsContainer
            return
        end
        
        -- Get all items in backpack
        local items = {}
        for _, item in ipairs(backpack:GetChildren()) do
            if item:IsA("Tool") or item:IsA("HopperBin") then
                table.insert(items, {name = item.Name, class = item.ClassName})
            end
        end
        
        -- Sort items by name
        table.sort(items, function(a, b)
            return a.name < b.name
        end)
        
        -- Create rows for each item
        if #items == 0 then
            -- Show "No items" message
            local noItemsLabel = Instance.new("TextLabel")
            noItemsLabel.Name = "NoItems"
            noItemsLabel.Size = UDim2.new(1, -20, 0, 20)
            noItemsLabel.Position = UDim2.new(0, 20, 0, 0)
            noItemsLabel.BackgroundTransparency = 1
            noItemsLabel.Text = "No items in backpack"
            noItemsLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
            noItemsLabel.TextSize = 12
            noItemsLabel.Font = Enum.Font.Gotham
            noItemsLabel.TextXAlignment = Enum.TextXAlignment.Left
            noItemsLabel.Parent = backpackItemsContainer
        else
            for _, itemData in ipairs(items) do
                createBackpackItemRow(itemData.name, itemData.class)
            end
        end
        
        -- Update container size
        task.wait()
        local contentSize = backpackItemsLayout.AbsoluteContentSize
        backpackItemsContainer.Size = UDim2.new(1, 0, 0, math.max(contentSize.Y, 20))
    end
    
    -- Gamepasses section removed
    
    -- Profile History section header
    local profileHistoryHeaderFrame = Instance.new("Frame")
    profileHistoryHeaderFrame.Name = "ProfileHistoryHeader"
    profileHistoryHeaderFrame.Size = UDim2.new(1, -20, 0, 35)
    profileHistoryHeaderFrame.Position = UDim2.new(0, 20, 0, 0)
    profileHistoryHeaderFrame.BackgroundTransparency = 1
    profileHistoryHeaderFrame.LayoutOrder = 15
    profileHistoryHeaderFrame.Parent = statsList
    
    local profileHistoryHeader = Instance.new("TextLabel")
    profileHistoryHeader.Name = "HeaderText"
    profileHistoryHeader.Size = UDim2.new(1, 0, 1, 0)
    profileHistoryHeader.Position = UDim2.new(0, 0, 0, 0)
    profileHistoryHeader.BackgroundTransparency = 1
    profileHistoryHeader.Text = "Profile History"
    profileHistoryHeader.TextColor3 = Color3.fromRGB(240, 240, 240)
    profileHistoryHeader.TextSize = 16
    profileHistoryHeader.Font = Enum.Font.GothamBold
    profileHistoryHeader.TextXAlignment = Enum.TextXAlignment.Left
    profileHistoryHeader.Parent = profileHistoryHeaderFrame
    
    -- Divider line for profile history section
    local profileHistoryDivider = Instance.new("Frame")
    profileHistoryDivider.Name = "Divider"
    profileHistoryDivider.Size = UDim2.new(1, 0, 0, 1)
    profileHistoryDivider.Position = UDim2.new(0, 0, 1, -1)
    profileHistoryDivider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    profileHistoryDivider.BorderSizePixel = 0
    profileHistoryDivider.Parent = profileHistoryHeaderFrame
    
    -- Profile history container
    local profileHistoryContainer = Instance.new("Frame")
    profileHistoryContainer.Name = "ProfileHistoryContainer"
    profileHistoryContainer.Size = UDim2.new(1, -20, 0, 0)
    profileHistoryContainer.Position = UDim2.new(0, 20, 0, 0)
    profileHistoryContainer.BackgroundTransparency = 1
    profileHistoryContainer.LayoutOrder = 16
    profileHistoryContainer.Parent = statsList
    
    local profileHistoryLayout = Instance.new("UIListLayout")
    profileHistoryLayout.Padding = UDim.new(0, 5)
    profileHistoryLayout.SortOrder = Enum.SortOrder.LayoutOrder
    profileHistoryLayout.Parent = profileHistoryContainer
    
    -- Add padding to container to center blocks
    local containerPadding = Instance.new("UIPadding")
    containerPadding.PaddingLeft = UDim.new(0, 5)
    containerPadding.PaddingRight = UDim.new(0, 5)
    containerPadding.Parent = profileHistoryContainer
    
    -- Function to format timestamp (remove T, show date on left, time on right)
    local function formatTimestamp(timestamp)
        if not timestamp then
            return "Unknown", ""
        end
        -- Format: YYYY-MM-DDTHH:MM:SS -> "YYYY-MM-DD" and "HH:MM:SS"
        local date, time = timestamp:match("^(%d%d%d%d%-%d%d%-%d%d)T(%d%d:%d%d:%d%d)$")
        if date and time then
            return date, time
        end
        -- Fallback if format doesn't match
        return timestamp:gsub("T", " "), ""
    end
    
    -- Function to compare two profile entries (only donated, received, playtime)
    local function compareProfileEntries(entry1, entry2)
        if not entry1 or not entry2 then
            return {}
        end
        
        local differences = {}
        
        -- Only compare stats (donated, received, playtime)
        if entry1.stats and entry2.stats then
            if entry1.stats.donated ~= entry2.stats.donated then
                local diff = entry2.stats.donated - entry1.stats.donated
                table.insert(differences, {
                    type = "donated",
                    label = "Donated",
                    old = entry1.stats.donated,
                    new = entry2.stats.donated,
                    diff = diff
                })
            end
            if entry1.stats.received ~= entry2.stats.received then
                local diff = entry2.stats.received - entry1.stats.received
                table.insert(differences, {
                    type = "received",
                    label = "Received",
                    old = entry1.stats.received,
                    new = entry2.stats.received,
                    diff = diff
                })
            end
            if entry1.stats.playtime ~= entry2.stats.playtime then
                local diff = entry2.stats.playtime - entry1.stats.playtime
                table.insert(differences, {
                    type = "playtime",
                    label = "Playtime",
                    old = entry1.stats.playtime,
                    new = entry2.stats.playtime,
                    diff = diff
                })
            end
        end
        
        return differences
    end
    
    -- Function to update profile history display
    local function updateProfileHistory()
        -- Clear existing history
        for _, child in ipairs(profileHistoryContainer:GetChildren()) do
            if child:IsA("Frame") or child:IsA("TextLabel") then
                child:Destroy()
            end
        end
        
        -- Load profile
        local profileEntries = loadPlayerProfile(targetPlayer)
        if not profileEntries or #profileEntries == 0 then
            local noHistoryLabel = Instance.new("TextLabel")
            noHistoryLabel.Name = "NoHistory"
            noHistoryLabel.Size = UDim2.new(1, -20, 0, 30)
            noHistoryLabel.Position = UDim2.new(0, 20, 0, 0)
            noHistoryLabel.BackgroundTransparency = 1
            noHistoryLabel.Text = "No profile history found"
            noHistoryLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
            noHistoryLabel.TextSize = 12
            noHistoryLabel.Font = Enum.Font.Gotham
            noHistoryLabel.TextXAlignment = Enum.TextXAlignment.Left
            noHistoryLabel.Parent = profileHistoryContainer
            return
        end
        
        -- Filter out entries without stats (like "player_left" events) - only show entries with stats
        local statsEntries = {}
        for _, entry in ipairs(profileEntries) do
            if entry.stats and not entry.event then
                table.insert(statsEntries, entry)
            end
        end
        
        if #statsEntries == 0 then
            local noHistoryLabel = Instance.new("TextLabel")
            noHistoryLabel.Name = "NoHistory"
            noHistoryLabel.Size = UDim2.new(1, -20, 0, 30)
            noHistoryLabel.Position = UDim2.new(0, 20, 0, 0)
            noHistoryLabel.BackgroundTransparency = 1
            noHistoryLabel.Text = "No profile history found"
            noHistoryLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
            noHistoryLabel.TextSize = 12
            noHistoryLabel.Font = Enum.Font.Gotham
            noHistoryLabel.TextXAlignment = Enum.TextXAlignment.Left
            noHistoryLabel.Parent = profileHistoryContainer
            return
        end
        
        -- Sort by timestamp (newest first)
        table.sort(statsEntries, function(a, b)
            return (a.timestamp or "") > (b.timestamp or "")
        end)
        
        -- Filter to only show entries from different sessions
        -- A new session is defined as: first entry, or entry with >5 minutes gap from previous
        local sessionEntries = {}
        local SESSION_GAP_MINUTES = 5
        
        for i, entry in ipairs(statsEntries) do
            if i == 1 then
                -- Always include the first (newest) entry
                table.insert(sessionEntries, entry)
            else
                -- Check time gap from previous entry
                local prevEntry = statsEntries[i - 1]
                if prevEntry and prevEntry.timestamp and entry.timestamp then
                    -- Parse timestamps: YYYY-MM-DDTHH:MM:SS and calculate gap in minutes
                    local function getTimeInMinutes(ts)
                        local datePart, timePart = ts:match("^(%d%d%d%d%-%d%d%-%d%d)T(%d%d:%d%d):%d%d$")
                        if datePart and timePart then
                            local hour, min = timePart:match("^(%d%d):(%d%d)$")
                            if hour and min then
                                -- Extract date components
                                local year, month, day = datePart:match("^(%d%d%d%d)%-(%d%d)%-(%d%d)$")
                                if year and month and day then
                                    -- Simple calculation: convert to minutes since a reference
                                    -- We'll use a simpler approach: compare dates and times separately
                                    return {
                                        date = datePart,
                                        hour = tonumber(hour),
                                        min = tonumber(min),
                                        totalMinutes = (tonumber(hour) * 60) + tonumber(min)
                                    }
                                end
                            end
                        end
                        return nil
                    end
                    
                    local time1 = getTimeInMinutes(prevEntry.timestamp)
                    local time2 = getTimeInMinutes(entry.timestamp)
                    
                    if time1 and time2 then
                        -- If different dates, it's a new session
                        if time1.date ~= time2.date then
                            table.insert(sessionEntries, entry)
                        else
                            -- Same date, check time gap
                            local gapMinutes = 0
                            if time1.totalMinutes > time2.totalMinutes then
                                gapMinutes = time1.totalMinutes - time2.totalMinutes
                            else
                                -- Handle day rollover (shouldn't happen with same date, but just in case)
                                gapMinutes = (24 * 60) - time2.totalMinutes + time1.totalMinutes
                            end
                            
                            -- If gap is more than SESSION_GAP_MINUTES, this is a new session
                            if gapMinutes > SESSION_GAP_MINUTES then
                                table.insert(sessionEntries, entry)
                            end
                        end
                    else
                        -- If parsing fails, include entry to be safe
                        table.insert(sessionEntries, entry)
                    end
                else
                    -- If no previous entry or missing timestamp, include this entry
                    table.insert(sessionEntries, entry)
                end
            end
        end
        
        -- Filter out entries with no meaningful changes
        local meaningfulEntries = {}
        for i, entry in ipairs(sessionEntries) do
            if i == 1 then
                -- Always include the first (newest) entry
                table.insert(meaningfulEntries, entry)
            else
                -- Check if this entry has any changes compared to previous
                local prevEntry = sessionEntries[i - 1]
                local differences = compareProfileEntries(entry, prevEntry)
                
                -- Only include if there are actual changes
                if #differences > 0 then
                    table.insert(meaningfulEntries, entry)
                end
            end
        end
        
        if #meaningfulEntries == 0 then
            local noHistoryLabel = Instance.new("TextLabel")
            noHistoryLabel.Name = "NoHistory"
            noHistoryLabel.Size = UDim2.new(1, -20, 0, 30)
            noHistoryLabel.Position = UDim2.new(0, 20, 0, 0)
            noHistoryLabel.BackgroundTransparency = 1
            noHistoryLabel.Text = "No profile history with changes found"
            noHistoryLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
            noHistoryLabel.TextSize = 12
            noHistoryLabel.Font = Enum.Font.Gotham
            noHistoryLabel.TextXAlignment = Enum.TextXAlignment.Left
            noHistoryLabel.Parent = profileHistoryContainer
            return
        end
        
        -- Show date buttons and comparison (only meaningful entries)
        for i, entry in ipairs(meaningfulEntries) do
            -- Check if this entry will have differences shown
            local hasDifferences = false
            if i < #meaningfulEntries then
                local prevEntry = meaningfulEntries[i + 1]
                local differences = compareProfileEntries(prevEntry, entry)
                hasDifferences = #differences > 0
            end
            
            local dateFrame = Instance.new("Frame")
            dateFrame.Name = "DateEntry_" .. i
            -- Reduced height for compact display
            local baseHeight = hasDifferences and 36 or 28
            -- Center the frame with small margins (moved 10px right)
            dateFrame.Size = UDim2.new(1, -10, 0, baseHeight)
            dateFrame.Position = UDim2.new(0, 17, 0, 0)
            dateFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            dateFrame.BorderSizePixel = 0
            dateFrame.LayoutOrder = i
            dateFrame.Parent = profileHistoryContainer
            
            local dateCorner = Instance.new("UICorner")
            dateCorner.CornerRadius = UDim.new(0, 6)
            dateCorner.Parent = dateFrame
            
            local dateBorder = Instance.new("UIStroke")
            dateBorder.Color = Color3.fromRGB(60, 60, 60)
            dateBorder.Thickness = 1
            dateBorder.Transparency = 0.4
            dateBorder.Parent = dateFrame
            
            -- Add padding to frame content - increased padding
            local framePadding = Instance.new("UIPadding")
            framePadding.PaddingLeft = UDim.new(0, 10)
            framePadding.PaddingRight = UDim.new(0, 10)
            framePadding.PaddingTop = UDim.new(0, 4)
            framePadding.PaddingBottom = UDim.new(0, 4)
            framePadding.Parent = dateFrame
            
            -- Format timestamp: date on left, time on right
            local dateStr, timeStr = formatTimestamp(entry.timestamp)
            
            -- Date label (left side)
            local dateLabel = Instance.new("TextLabel")
            dateLabel.Name = "DateLabel"
            dateLabel.Size = UDim2.new(0.5, -5, 0, 16)
            dateLabel.Position = UDim2.new(0, 0, 0, 0)
            dateLabel.BackgroundTransparency = 1
            dateLabel.Text = dateStr
            dateLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
            dateLabel.TextSize = 12
            dateLabel.Font = Enum.Font.Gotham
            dateLabel.TextXAlignment = Enum.TextXAlignment.Left
            dateLabel.Parent = dateFrame
            
            -- Time label (right side) - equal spacing on both sides
            local timeLabel = Instance.new("TextLabel")
            timeLabel.Name = "TimeLabel"
            timeLabel.Size = UDim2.new(0.5, -5, 0, 16)
            timeLabel.Position = UDim2.new(0.5, 0, 0, 0)
            timeLabel.BackgroundTransparency = 1
            timeLabel.Text = timeStr
            timeLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
            timeLabel.TextSize = 12
            timeLabel.Font = Enum.Font.Gotham
            timeLabel.TextXAlignment = Enum.TextXAlignment.Right
            timeLabel.TextTruncate = Enum.TextTruncate.AtEnd
            timeLabel.Parent = dateFrame
            
            -- Show comparison if there's a previous entry
            if i < #meaningfulEntries then
                local prevEntry = meaningfulEntries[i + 1]
                local differences = compareProfileEntries(prevEntry, entry)
                
                if #differences > 0 then
                    local diffText = ""
                    for j, diff in ipairs(differences) do
                        if j > 1 then
                            diffText = diffText .. ", "
                        end
                        if diff.type == "new_items" then
                            diffText = diffText .. diff.label .. ": " .. table.concat(diff.items, ", ")
                        else
                            local sign = diff.diff > 0 and "+" or ""
                            diffText = diffText .. diff.label .. ": " .. sign .. tostring(diff.diff) .. " (" .. tostring(diff.old) .. " → " .. tostring(diff.new) .. ")"
                        end
                    end
                    
                    local diffLabel = Instance.new("TextLabel")
                    diffLabel.Name = "DiffLabel"
                    diffLabel.Size = UDim2.new(1, 0, 0, 16)
                    diffLabel.Position = UDim2.new(0, 0, 0, 16)
                    diffLabel.BackgroundTransparency = 1
                    diffLabel.Text = diffText
                    diffLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
                    diffLabel.TextSize = 11
                    diffLabel.Font = Enum.Font.Gotham
                    diffLabel.TextXAlignment = Enum.TextXAlignment.Left
                    diffLabel.TextWrapped = true
                    diffLabel.Parent = dateFrame
                    
                    -- Compact height for entries with differences (kept same size and centered, moved 10px right)
                    dateFrame.Size = UDim2.new(1, -10, 0, 36)
                    dateFrame.Position = UDim2.new(0, 17, 0, 0)
                end
            end
        end
        
        -- Update container size
        task.wait()
        local contentSize = profileHistoryLayout.AbsoluteContentSize
        profileHistoryContainer.Size = UDim2.new(1, -20, 0, math.max(contentSize.Y, 20))
    end
    
    -- Update profile history on UI creation
    updateProfileHistory()
    
    -- Update functions
    local function updateReceived()
        -- First check if TipJar is in backpack
        if not playerOwnsTipJar(targetPlayer) then
            -- Update the label to show "Doesn't own Tip Jar" centered
            local labelText = receivedStat.Parent:FindFirstChild("Label")
            if labelText then
                labelText.Text = "Doesn't own Tip Jar"
                labelText.TextXAlignment = Enum.TextXAlignment.Center
                labelText.Size = UDim2.new(1, 0, 1, 0)
                labelText.Position = UDim2.new(0, 0, 0, 0)
            end
            receivedStat.Text = ""
            return
        end
        
        -- Reset label back to "Received:" if TipJar exists
        local labelText = receivedStat.Parent:FindFirstChild("Label")
        if labelText then
            labelText.Text = "Received:"
            labelText.TextXAlignment = Enum.TextXAlignment.Left
            labelText.Size = UDim2.new(0, 100, 1, 0)
            labelText.Position = UDim2.new(0, 10, 0, 0)
        end
        
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
                timeStat.Text = hours .. "h " .. mins .. "m (" .. totalMinutes .. ")"
            else
                timeStat.Text = totalMinutes .. "m (" .. totalMinutes .. ")"
            end
        else
            timeStat.Text = "0m (0)"
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
            -- All settings are inverted EXCEPT "Show Total Time"
            if aurasStat then
                if auras and auras:IsA("BoolValue") then
                    -- Inverted logic
                    aurasStat.Text = auras.Value and "Off" or "On"
                else
                    aurasStat.Text = "On"
                end
            end
            if giftsStat then
                if gifts and gifts:IsA("BoolValue") then
                    -- Inverted logic
                    giftsStat.Text = gifts.Value and "Off" or "On"
                else
                    giftsStat.Text = "On"
                end
            end
            if pianoStat then
                if piano and piano:IsA("BoolValue") then
                    -- Inverted logic
                    pianoStat.Text = piano.Value and "Off" or "On"
                else
                    pianoStat.Text = "On"
                end
            end
            if rankStat then
                if rank and rank:IsA("BoolValue") then
                    -- Inverted logic
                    rankStat.Text = rank.Value and "Off" or "On"
                else
                    rankStat.Text = "On"
                end
            end
            if shadowStat then
                if shadow and shadow:IsA("BoolValue") then
                    -- Inverted logic
                    shadowStat.Text = shadow.Value and "Off" or "On"
                else
                    shadowStat.Text = "On"
                end
            end
            if teleportStat then
                if teleport and teleport:IsA("BoolValue") then
                    -- Inverted logic
                    teleportStat.Text = teleport.Value and "Off" or "On"
                else
                    teleportStat.Text = "On"
                end
            end
            if timeSettingStat then
                if timeSetting and timeSetting:IsA("BoolValue") then
                    -- Normal logic for "Show Total Time" (NOT inverted)
                    timeSettingStat.Text = timeSetting.Value and "On" or "Off"
                else
                    timeSettingStat.Text = "Off"
                end
            end
        else
            if aurasStat then aurasStat.Text = "On" end
            if giftsStat then giftsStat.Text = "On" end
            if pianoStat then pianoStat.Text = "On" end
            if rankStat then rankStat.Text = "On" end
            if shadowStat then shadowStat.Text = "On" end
            if teleportStat then teleportStat.Text = "On" end
            if timeSettingStat then timeSettingStat.Text = "Off" end
        end
    end
    
    -- Initial updates
    updateReceived()
    updateDonated()
    updateTime()
    updateCredits()
    updateSettings()
    updateBackpackItems()
    -- updateGamepasses() -- Removed
    
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
                pcall(function()
                    donated:GetPropertyChangedSignal("Value"):Connect(updateDonated)
                end)
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
        
        -- Monitor backpack for changes
        local backpack = targetPlayer:FindFirstChild("Backpack")
        if not backpack then
            backpack = targetPlayer:WaitForChild("Backpack", 10)
        end
        if backpack then
            updateBackpackItems()
            -- Listen for items being added or removed
            backpack.ChildAdded:Connect(function(child)
                if child:IsA("Tool") or child:IsA("HopperBin") then
                    updateBackpackItems()
                    -- Check if TipJar was added
                    if child.Name == "TipJar" then
                        recordTipJarOwnership(targetPlayer)
                        updateReceived()
                    end
                end
            end)
            backpack.ChildRemoved:Connect(function(child)
                if child:IsA("Tool") or child:IsA("HopperBin") then
                    updateBackpackItems()
                    -- Check if TipJar was removed
                    if child.Name == "TipJar" then
                        recordTipJarOwnership(targetPlayer)
                        updateReceived()
                    end
                end
            end)
        end
        
        -- Gamepasses monitoring removed
    end)
    
    -- Update canvas size
    statsListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        local contentSize = statsListLayout.AbsoluteContentSize
        statsList.CanvasSize = UDim2.new(0, 0, 0, contentSize.Y + 10)
    end)
    
    -- Also update canvas when backpack items change
    backpackItemsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        local contentSize = statsListLayout.AbsoluteContentSize
        statsList.CanvasSize = UDim2.new(0, 0, 0, contentSize.Y + 10)
    end)
    
    -- Also update canvas when gamepasses change
    -- gamepassesLayout removed
    
    -- Initial canvas size update
    task.wait()
    local contentSize = statsListLayout.AbsoluteContentSize
    statsList.CanvasSize = UDim2.new(0, 0, 0, contentSize.Y + 10)
    
    -- Animate in with smooth animation
    -- Set border transparency for animation
    if infoBorder then
        infoBorder.Transparency = 1
    end
    
    -- Use a single combined tween for smoother animation with optimized settings
    local combinedTween = TweenService:Create(
        infoFrame,
        TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0),
        {
            Size = UDim2.new(0, 350, 0, 500),
            Position = playerInfoTargetPosition
        }
    )
    
    local borderTween = nil
    if infoBorder then
        borderTween = TweenService:Create(
            infoBorder,
            TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0),
            {Transparency = 0.2}
        )
    end
    
    -- Play animations with slight delay to ensure frame is ready
    task.spawn(function()
        task.wait(0.01)
        combinedTween:Play()
        if borderTween then
            borderTween:Play()
        end
    end)
    
    return infoFrame
end

-- Hover highlight + Alt+Right-click inspect system
local HOVER_PREVIEW_DELAY = 0.2
local RIGHT_CLICK_COOLDOWN = 0.35
local lastRightClickTime = 0
local hoveredPlayer = nil
local hoverPreviewDelayHandle = nil
local hoverHighlight = nil
local hoverCharacterAddedConnection = nil
local hoverInfoFrame = nil
local hoverInfoAvatar = nil
local hoverInfoNameLabel = nil
local hoverInfoUsernameLabel = nil
local hoverInfoDonatedIcon = nil
local hoverInfoDonatedLabel = nil
local hoverInfoReceivedIcon = nil
local hoverInfoReceivedLabel = nil
local hoverInfoVisible = false
local hoverInfoTween = nil
local currentHoverInfoPlayer = nil
local hoverInfoBaseSize = UDim2.new(0, 300, 0, 72)
local hoverInfoCollapsedSize = UDim2.new(0, 300, 0, 0)

local altKeyDown = false
local toggleKeyListening = false
local toggleKeyButton = nil
local hotkeyListeningConnection = nil

local function isAltModifierDown(inputObject)
    if settingsState.disableAltRequirement then
        return true
    end
    
    -- Check actual current key state first (most reliable)
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) or UserInputService:IsKeyDown(Enum.KeyCode.RightAlt) then
        return true
    end
    
    -- Check input object's modifier state if available
    if inputObject and inputObject.IsModifierKeyDown then
        local success, result = pcall(function()
            return inputObject:IsModifierKeyDown(Enum.ModifierKey.Alt)
        end)
        if success and result then
            return true
        end
    end
    
    -- Only use cached flag as last resort (may be stale)
    if altKeyDown then
        -- Double-check it's actually still down
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) or UserInputService:IsKeyDown(Enum.KeyCode.RightAlt) then
            return true
        else
            -- Reset stale flag
            altKeyDown = false
        end
    end
    
    return false
end

local function ensureHoverInfoUI()
    if hoverInfoFrame then
        return
    end

    hoverInfoFrame = Instance.new("Frame")
    hoverInfoFrame.Name = "HoverInfoBanner"
    hoverInfoFrame.Size = hoverInfoCollapsedSize
    hoverInfoFrame.AnchorPoint = Vector2.new(0.5, 1)
    hoverInfoFrame.Position = UDim2.new(0.5, 0, 1, 100)
    hoverInfoFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    hoverInfoFrame.BackgroundTransparency = 1
    hoverInfoFrame.BorderSizePixel = 0
    hoverInfoFrame.Visible = false
    hoverInfoFrame.Parent = screenGui
    hoverInfoFrame.ZIndex = 50

    local hoverInfoCorner = Instance.new("UICorner")
    hoverInfoCorner.CornerRadius = UDim.new(0, 10)
    hoverInfoCorner.Parent = hoverInfoFrame

    local hoverInfoStroke = Instance.new("UIStroke")
    hoverInfoStroke.Color = Color3.fromRGB(60, 60, 60)
    hoverInfoStroke.Thickness = 1
    hoverInfoStroke.Transparency = 0.3
    hoverInfoStroke.Parent = hoverInfoFrame

    hoverInfoAvatar = Instance.new("ImageLabel")
    hoverInfoAvatar.Name = "Avatar"
    hoverInfoAvatar.Size = UDim2.new(0, 44, 0, 44)
    hoverInfoAvatar.Position = UDim2.new(0, 8, 0.5, -22)
    hoverInfoAvatar.BackgroundTransparency = 1
    hoverInfoAvatar.Image = ""
    hoverInfoAvatar.ImageTransparency = 1
    hoverInfoAvatar.Parent = hoverInfoFrame

    local avatarCorner = Instance.new("UICorner")
    avatarCorner.CornerRadius = UDim.new(1, 0)
    avatarCorner.Parent = hoverInfoAvatar

    hoverInfoNameLabel = Instance.new("TextLabel")
    hoverInfoNameLabel.Name = "DisplayName"
    hoverInfoNameLabel.Size = UDim2.new(1, -70, 0, 26)
    hoverInfoNameLabel.Position = UDim2.new(0, 60, 0, 8)
    hoverInfoNameLabel.BackgroundTransparency = 1
    hoverInfoNameLabel.Text = ""
    hoverInfoNameLabel.TextColor3 = Color3.fromRGB(235, 235, 235)
    hoverInfoNameLabel.TextSize = 16
    hoverInfoNameLabel.Font = Enum.Font.GothamBold
    hoverInfoNameLabel.TextXAlignment = Enum.TextXAlignment.Left
    hoverInfoNameLabel.TextTruncate = Enum.TextTruncate.AtEnd
    hoverInfoNameLabel.TextTransparency = 1
    hoverInfoNameLabel.Parent = hoverInfoFrame

    hoverInfoUsernameLabel = Instance.new("TextLabel")
    hoverInfoUsernameLabel.Name = "Username"
    hoverInfoUsernameLabel.Size = UDim2.new(1, -70, 0, 20)
    hoverInfoUsernameLabel.Position = UDim2.new(0, 60, 0, 38)
    hoverInfoUsernameLabel.BackgroundTransparency = 1
    hoverInfoUsernameLabel.Text = ""
    hoverInfoUsernameLabel.TextColor3 = Color3.fromRGB(170, 170, 170)
    hoverInfoUsernameLabel.TextSize = 14
    hoverInfoUsernameLabel.Font = Enum.Font.Gotham
    hoverInfoUsernameLabel.TextXAlignment = Enum.TextXAlignment.Left
    hoverInfoUsernameLabel.TextTruncate = Enum.TextTruncate.AtEnd
    hoverInfoUsernameLabel.TextTransparency = 1
    hoverInfoUsernameLabel.Parent = hoverInfoFrame

    hoverInfoDonatedIcon = Instance.new("ImageLabel")
    hoverInfoDonatedIcon.Name = "DonatedIcon"
    hoverInfoDonatedIcon.Size = UDim2.new(0, 16, 0, 16)
    hoverInfoDonatedIcon.Position = UDim2.new(1, -110, 0, 10)
    hoverInfoDonatedIcon.BackgroundTransparency = 1
    hoverInfoDonatedIcon.Image = "rbxassetid://6031288895"
    hoverInfoDonatedIcon.ImageColor3 = Color3.fromRGB(0, 170, 0)
    hoverInfoDonatedIcon.ImageTransparency = 1
    hoverInfoDonatedIcon.Parent = hoverInfoFrame

    hoverInfoDonatedLabel = Instance.new("TextLabel")
    hoverInfoDonatedLabel.Name = "DonatedText"
    hoverInfoDonatedLabel.Size = UDim2.new(0, 90, 0, 18)
    hoverInfoDonatedLabel.Position = UDim2.new(1, -90, 0, 8)
    hoverInfoDonatedLabel.BackgroundTransparency = 1
    hoverInfoDonatedLabel.Text = "D: --"
    hoverInfoDonatedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    hoverInfoDonatedLabel.TextSize = 14
    hoverInfoDonatedLabel.Font = Enum.Font.GothamBold
    hoverInfoDonatedLabel.TextXAlignment = Enum.TextXAlignment.Left
    hoverInfoDonatedLabel.TextTruncate = Enum.TextTruncate.AtEnd
    hoverInfoDonatedLabel.TextTransparency = 1
    hoverInfoDonatedLabel.Parent = hoverInfoFrame

    hoverInfoReceivedIcon = Instance.new("ImageLabel")
    hoverInfoReceivedIcon.Name = "ReceivedIcon"
    hoverInfoReceivedIcon.Size = UDim2.new(0, 16, 0, 16)
    hoverInfoReceivedIcon.Position = UDim2.new(1, -110, 0, 40)
    hoverInfoReceivedIcon.BackgroundTransparency = 1
    hoverInfoReceivedIcon.Image = "rbxassetid://6031288895"
    hoverInfoReceivedIcon.ImageColor3 = Color3.fromRGB(0, 170, 0)
    hoverInfoReceivedIcon.ImageTransparency = 1
    hoverInfoReceivedIcon.Parent = hoverInfoFrame

    hoverInfoReceivedLabel = Instance.new("TextLabel")
    hoverInfoReceivedLabel.Name = "ReceivedText"
    hoverInfoReceivedLabel.Size = UDim2.new(0, 90, 0, 18)
    hoverInfoReceivedLabel.Position = UDim2.new(1, -90, 0, 38)
    hoverInfoReceivedLabel.BackgroundTransparency = 1
    hoverInfoReceivedLabel.Text = "R: --"
    hoverInfoReceivedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    hoverInfoReceivedLabel.TextSize = 14
    hoverInfoReceivedLabel.Font = Enum.Font.Gotham
    hoverInfoReceivedLabel.TextXAlignment = Enum.TextXAlignment.Left
    hoverInfoReceivedLabel.TextTruncate = Enum.TextTruncate.AtEnd
    hoverInfoReceivedLabel.TextTransparency = 1
    hoverInfoReceivedLabel.Parent = hoverInfoFrame
end

local function setHoverInfoVisible(visible)
    ensureHoverInfoUI()
    if hoverInfoVisible == visible then
        return
    end
    hoverInfoVisible = visible

    if hoverInfoTween then
        hoverInfoTween:Cancel()
    end

    if visible then
        hoverInfoFrame.Visible = true
        hoverInfoFrame.Size = hoverInfoCollapsedSize
    end

    local targetPosition = visible and UDim2.new(0.5, 0, 1, -20) or UDim2.new(0.5, 0, 1, 100)
    local targetBackgroundTransparency = visible and 0 or 1
    hoverInfoTween = TweenService:Create(
        hoverInfoFrame,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, visible and Enum.EasingDirection.Out or Enum.EasingDirection.In),
        {
            Position = targetPosition,
            BackgroundTransparency = targetBackgroundTransparency,
            Size = visible and hoverInfoBaseSize or hoverInfoCollapsedSize,
        }
    )
    hoverInfoTween:Play()
    hoverInfoTween.Completed:Connect(function()
        if not hoverInfoVisible then
            hoverInfoFrame.Visible = false
        end
    end)

    local targetTextTransparency = visible and 0 or 1
    local targetImageTransparency = visible and 0 or 1

    local textElements = {hoverInfoNameLabel, hoverInfoUsernameLabel, hoverInfoDonatedLabel, hoverInfoReceivedLabel}
    for _, element in ipairs(textElements) do
        TweenService:Create(
            element,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, visible and Enum.EasingDirection.Out or Enum.EasingDirection.In),
            {TextTransparency = targetTextTransparency}
        ):Play()
    end

    local imageElements = {hoverInfoAvatar, hoverInfoDonatedIcon, hoverInfoReceivedIcon}
    for _, icon in ipairs(imageElements) do
        TweenService:Create(
            icon,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, visible and Enum.EasingDirection.Out or Enum.EasingDirection.In),
            {ImageTransparency = targetImageTransparency}
        ):Play()
    end
end

local function getTipJarValue(player, valueName)
    local tipStats = player and player:FindFirstChild("TipJarStats")
    if not tipStats then
        return nil
    end
    local valueObject = tipStats[valueName] or tipStats:FindFirstChild(valueName)
    if valueObject and (valueObject:IsA("IntValue") or valueObject:IsA("NumberValue")) then
        return valueObject.Value
    end
    return nil
end

local function formatRobuxAmount(amount)
    if amount == nil then
        return "--"
    end
    local formatted = tostring(amount)
    local k = formatted
    local result = ""
    local len = #k
    local count = 0
    for i = len, 1, -1 do
        result = string.sub(k, i, i) .. result
        count += 1
        if count == 3 and i > 1 then
            result = "," .. result
            count = 0
        end
    end
    return result
end

local function updateHoverInfoDisplay(player)
    ensureHoverInfoUI()
    if player and not settingsState.disableHoverInfo then
        if currentHoverInfoPlayer ~= player then
            currentHoverInfoPlayer = player
            hoverInfoAvatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="
                .. player.UserId .. "&width=150&height=150&format=png"
            local displayName = player.DisplayName ~= "" and player.DisplayName or player.Name
            hoverInfoNameLabel.Text = displayName
            hoverInfoUsernameLabel.Text = "@" .. player.Name

            local donatedValue = getTipJarValue(player, "Donated")
            local receivedValue = getTipJarValue(player, "Raised")
            hoverInfoDonatedLabel.Text = "D: " .. formatRobuxAmount(donatedValue)
            hoverInfoReceivedLabel.Text = "R: " .. formatRobuxAmount(receivedValue)
        end
        setHoverInfoVisible(true)
    else
        currentHoverInfoPlayer = nil
        setHoverInfoVisible(false)
    end
end

local function clearHoverHighlight()
    if hoverHighlight then
        hoverHighlight:Destroy()
        hoverHighlight = nil
    end
end

local function applyHoverHighlight(character)
    if not character or settingsState.disableHoverOutline then
        return
    end

    clearHoverHighlight()

    local highlight = Instance.new("Highlight")
    highlight.Name = "TipStatsHoverOutline"
    highlight.FillTransparency = 1
    highlight.OutlineTransparency = 0
    highlight.OutlineColor = Color3.fromRGB(55, 55, 55)
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Adornee = character
    highlight.Parent = character

    highlight.Destroying:Connect(function()
        if hoverHighlight == highlight then
            hoverHighlight = nil
        end
    end)

    hoverHighlight = highlight
end

local function closeHoverPreviewForPlayer(player)
    if not player then
        return
    end
    closePlayerInfoUIForPlayer(player, true)
    if hoverPreviewPlayer == player then
        hoverPreviewPlayer = nil
    end
end

local function setHoveredPlayer(newPlayer)
    if hoveredPlayer == newPlayer then
        return
    end

    if hoverPreviewDelayHandle then
        task.cancel(hoverPreviewDelayHandle)
        hoverPreviewDelayHandle = nil
    end

    if hoverCharacterAddedConnection then
        hoverCharacterAddedConnection:Disconnect()
        hoverCharacterAddedConnection = nil
    end

    if hoveredPlayer then
        closeHoverPreviewForPlayer(hoveredPlayer)
    end

    hoveredPlayer = newPlayer
    updateHoverInfoDisplay(hoveredPlayer)

    clearHoverHighlight()

    if not hoveredPlayer then
        return
    end

    local function attachHighlight()
        if hoveredPlayer == newPlayer then
            applyHoverHighlight(hoveredPlayer.Character)
        end
    end

    if hoveredPlayer.Character then
        attachHighlight()
    else
        hoverCharacterAddedConnection = hoveredPlayer.CharacterAdded:Connect(function()
            attachHighlight()
        end)
    end

    hoverPreviewDelayHandle = task.delay(HOVER_PREVIEW_DELAY, function()
        hoverPreviewDelayHandle = nil
        if hoveredPlayer ~= newPlayer then
            return
        end
        -- highlight already applied; no profile auto-open
    end)
end

-- Leaderboard Player Notification System (using existing tables, 0 new locals)
donationNotifications.checkLeaderboardForPlayers = function()
    donationNotifications.leaderboardCheckSuccess, donationNotifications.leaderboardCheckResult = pcall(function()
        donationNotifications.leaderboardTemp = workspace:FindFirstChild("Map")
        if not donationNotifications.leaderboardTemp then return {} end
        donationNotifications.leaderboardTemp = donationNotifications.leaderboardTemp:FindFirstChild("POI")
        if not donationNotifications.leaderboardTemp then return {} end
        donationNotifications.leaderboardTemp = donationNotifications.leaderboardTemp:FindFirstChild("Leaderboards")
        if not donationNotifications.leaderboardTemp then return {} end
        donationNotifications.leaderboardTemp = donationNotifications.leaderboardTemp:FindFirstChild("Donated")
        if not donationNotifications.leaderboardTemp then return {} end
        donationNotifications.leaderboardTemp = donationNotifications.leaderboardTemp:FindFirstChild("Board")
        if not donationNotifications.leaderboardTemp then return {} end
        donationNotifications.leaderboardTemp = donationNotifications.leaderboardTemp:FindFirstChild("SurfaceGui")
        if not donationNotifications.leaderboardTemp then return {} end
        donationNotifications.leaderboardTemp = donationNotifications.leaderboardTemp:FindFirstChild("Frame")
        if not donationNotifications.leaderboardTemp then return {} end
        donationNotifications.leaderboardTemp = donationNotifications.leaderboardTemp:FindFirstChild("List")
        if not donationNotifications.leaderboardTemp then return {} end
        donationNotifications.leaderboardMatches = {}
        donationNotifications.leaderboardPlayers = Players:GetPlayers()
        donationNotifications.leaderboardNames = {}
        donationNotifications.leaderboardI = 1
        while donationNotifications.leaderboardI <= #donationNotifications.leaderboardPlayers do
            donationNotifications.leaderboardNames[donationNotifications.leaderboardPlayers[donationNotifications.leaderboardI].Name:lower()] = donationNotifications.leaderboardPlayers[donationNotifications.leaderboardI]
            donationNotifications.leaderboardI = donationNotifications.leaderboardI + 1
        end
        donationNotifications.leaderboardI = 1
        while donationNotifications.leaderboardI <= 100 do
            donationNotifications.leaderboardKey = tostring(donationNotifications.leaderboardI)
            donationNotifications.leaderboardItem = donationNotifications.leaderboardTemp:FindFirstChild(donationNotifications.leaderboardKey)
            if donationNotifications.leaderboardItem then
                donationNotifications.leaderboardUsernameFrame = donationNotifications.leaderboardItem:FindFirstChild("Username")
                if donationNotifications.leaderboardUsernameFrame then
                    donationNotifications.leaderboardUsernameLabel = donationNotifications.leaderboardUsernameFrame:FindFirstChild("Username")
                    if donationNotifications.leaderboardUsernameLabel and donationNotifications.leaderboardUsernameLabel:IsA("TextLabel") then
                        donationNotifications.leaderboardUsername = donationNotifications.leaderboardUsernameLabel.Text
                        if donationNotifications.leaderboardUsername and donationNotifications.leaderboardUsername ~= "" then
                            donationNotifications.leaderboardPlaceFrame = donationNotifications.leaderboardItem:FindFirstChild("Place")
                            if donationNotifications.leaderboardPlaceFrame and donationNotifications.leaderboardPlaceFrame:IsA("TextLabel") then
                                donationNotifications.leaderboardPlace = donationNotifications.leaderboardPlaceFrame.Text
                                donationNotifications.leaderboardPlayer = donationNotifications.leaderboardNames[donationNotifications.leaderboardUsername:lower()]
                                if donationNotifications.leaderboardPlayer then
                                    table.insert(donationNotifications.leaderboardMatches, {
                                        player = donationNotifications.leaderboardPlayer,
                                        place = donationNotifications.leaderboardPlace,
                                        username = donationNotifications.leaderboardUsername
                                    })
                                end
                            end
                        end
                    end
                end
            end
            donationNotifications.leaderboardI = donationNotifications.leaderboardI + 1
        end
        return donationNotifications.leaderboardMatches
    end)
    if donationNotifications.leaderboardCheckSuccess then
        return donationNotifications.leaderboardCheckResult or {}
    else
        return {}
    end
end

donationNotifications.createLeaderboardNotification = function()
    donationNotifications.leaderboardPlayer = donationNotifications.createLeaderboardNotificationPlayer
    donationNotifications.leaderboardPlace = donationNotifications.createLeaderboardNotificationPlace
    if not donationNotifications.leaderboardPlayer or not donationNotifications.leaderboardPlayer.Parent then
        return
    end
    if donationNotifications.leaderboardActive[donationNotifications.leaderboardPlayer.UserId] then
        return
    end
    donationNotifications.leaderboardActiveCount = 0
    donationNotifications.leaderboardTemp = next(donationNotifications.leaderboardActive)
    while donationNotifications.leaderboardTemp do
        donationNotifications.leaderboardActiveCount = donationNotifications.leaderboardActiveCount + 1
        donationNotifications.leaderboardTemp = next(donationNotifications.leaderboardActive, donationNotifications.leaderboardTemp)
    end
    donationNotifications.leaderboardNotificationFrame = Instance.new("Frame")
    donationNotifications.leaderboardNotificationFrame.Name = "LeaderboardNotification_" .. donationNotifications.leaderboardPlayer.UserId
    donationNotifications.leaderboardNotificationFrame.Size = UDim2.new(0, 350, 0, 60)
    donationNotifications.leaderboardNotificationFrame.AnchorPoint = Vector2.new(0.5, 1)
    donationNotifications.leaderboardNotificationFrame.Position = UDim2.new(0.5, 0, 1, -120 - (donationNotifications.leaderboardActiveCount * 70))
    donationNotifications.leaderboardNotificationFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    donationNotifications.leaderboardNotificationFrame.BackgroundTransparency = 0
    donationNotifications.leaderboardNotificationFrame.BorderSizePixel = 0
    donationNotifications.leaderboardNotificationFrame.Visible = true
    donationNotifications.leaderboardNotificationFrame.Parent = screenGui
    donationNotifications.leaderboardNotificationFrame.ZIndex = 51
    donationNotifications.leaderboardNotificationCorner = Instance.new("UICorner")
    donationNotifications.leaderboardNotificationCorner.CornerRadius = UDim.new(0, 10)
    donationNotifications.leaderboardNotificationCorner.Parent = donationNotifications.leaderboardNotificationFrame
    donationNotifications.leaderboardNotificationStroke = Instance.new("UIStroke")
    donationNotifications.leaderboardNotificationStroke.Color = Color3.fromRGB(60, 60, 60)
    donationNotifications.leaderboardNotificationStroke.Thickness = 1
    donationNotifications.leaderboardNotificationStroke.Transparency = 0.3
    donationNotifications.leaderboardNotificationStroke.Parent = donationNotifications.leaderboardNotificationFrame
    donationNotifications.leaderboardNotificationLabel = Instance.new("TextLabel")
    donationNotifications.leaderboardNotificationLabel.Name = "NotificationText"
    donationNotifications.leaderboardNotificationLabel.Size = UDim2.new(1, -80, 1, 0)
    donationNotifications.leaderboardNotificationLabel.Position = UDim2.new(0, 15, 0, 0)
    donationNotifications.leaderboardNotificationLabel.BackgroundTransparency = 1
    donationNotifications.leaderboardNotificationLabel.Text = "[" .. donationNotifications.leaderboardPlace .. "] " .. donationNotifications.leaderboardPlayer.Name .. " is in your server!"
    donationNotifications.leaderboardNotificationLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    donationNotifications.leaderboardNotificationLabel.TextSize = 16
    donationNotifications.leaderboardNotificationLabel.Font = Enum.Font.GothamBold
    donationNotifications.leaderboardNotificationLabel.TextXAlignment = Enum.TextXAlignment.Left
    donationNotifications.leaderboardNotificationLabel.TextWrapped = true
    donationNotifications.leaderboardNotificationLabel.Parent = donationNotifications.leaderboardNotificationFrame
    donationNotifications.leaderboardTeleportButton = Instance.new("TextButton")
    donationNotifications.leaderboardTeleportButton.Name = "TeleportButton"
    donationNotifications.leaderboardTeleportButton.Size = UDim2.new(0, 22, 0, 22)
    donationNotifications.leaderboardTeleportButton.Position = UDim2.new(1, -32, 0.5, -11)
    donationNotifications.leaderboardTeleportButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    donationNotifications.leaderboardTeleportButton.Text = "→"
    donationNotifications.leaderboardTeleportButton.TextColor3 = Color3.fromRGB(220, 220, 220)
    donationNotifications.leaderboardTeleportButton.TextSize = 14
    donationNotifications.leaderboardTeleportButton.Font = Enum.Font.GothamBold
    donationNotifications.leaderboardTeleportButton.BorderSizePixel = 0
    donationNotifications.leaderboardTeleportButton.Parent = donationNotifications.leaderboardNotificationFrame
    donationNotifications.leaderboardTeleportCorner = Instance.new("UICorner")
    donationNotifications.leaderboardTeleportCorner.CornerRadius = UDim.new(0, 4)
    donationNotifications.leaderboardTeleportCorner.Parent = donationNotifications.leaderboardTeleportButton
    donationNotifications.leaderboardTeleportBorder = Instance.new("UIStroke")
    donationNotifications.leaderboardTeleportBorder.Color = Color3.fromRGB(60, 60, 60)
    donationNotifications.leaderboardTeleportBorder.Thickness = 1
    donationNotifications.leaderboardTeleportBorder.Transparency = 0.3
    donationNotifications.leaderboardTeleportBorder.Parent = donationNotifications.leaderboardTeleportButton
    donationNotifications.leaderboardTeleportButton.MouseEnter:Connect(function()
        donationNotifications.leaderboardTeleportButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end)
    donationNotifications.leaderboardTeleportButton.MouseLeave:Connect(function()
        donationNotifications.leaderboardTeleportButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end)
    donationNotifications.leaderboardTeleportButton.MouseButton1Click:Connect(function()
        if donationNotifications.leaderboardPlayer.Character then
            donationNotifications.leaderboardRoot = getRoot(donationNotifications.leaderboardPlayer.Character)
            donationNotifications.leaderboardLocalPlayer = Players.LocalPlayer
            if donationNotifications.leaderboardRoot and donationNotifications.leaderboardLocalPlayer and donationNotifications.leaderboardLocalPlayer.Character then
                donationNotifications.leaderboardLocalRoot = getRoot(donationNotifications.leaderboardLocalPlayer.Character)
                if donationNotifications.leaderboardLocalRoot then
                    donationNotifications.leaderboardLocalRoot.CFrame = donationNotifications.leaderboardRoot.CFrame
                end
            end
        end
    end)
    donationNotifications.leaderboardActive[donationNotifications.leaderboardPlayer.UserId] = donationNotifications.leaderboardNotificationFrame
    donationNotifications.leaderboardNotificationFrame.Size = UDim2.new(0, 0, 0, 60)
    donationNotifications.leaderboardSizeTween = TweenService:Create(
        donationNotifications.leaderboardNotificationFrame,
        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 350, 0, 60)}
    )
    donationNotifications.leaderboardSizeTween:Play()
    task.spawn(function()
        task.wait(8)
        if donationNotifications.leaderboardNotificationFrame.Parent then
            donationNotifications.leaderboardFadeTween = TweenService:Create(
                donationNotifications.leaderboardNotificationFrame,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                {BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 60)}
            )
            if donationNotifications.leaderboardNotificationLabel then
                donationNotifications.leaderboardTextFade = TweenService:Create(
                    donationNotifications.leaderboardNotificationLabel,
                    TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                    {TextTransparency = 1}
                )
                donationNotifications.leaderboardTextFade:Play()
            end
            donationNotifications.leaderboardFadeTween:Play()
            donationNotifications.leaderboardFadeTween.Completed:Wait()
            if donationNotifications.leaderboardNotificationFrame.Parent then
                donationNotifications.leaderboardNotificationFrame:Destroy()
            end
            donationNotifications.leaderboardActive[donationNotifications.leaderboardPlayer.UserId] = nil
        end
    end)
    donationNotifications.leaderboardPlayer.AncestryChanged:Connect(function()
        if not donationNotifications.leaderboardPlayer.Parent then
            if donationNotifications.leaderboardActive[donationNotifications.leaderboardPlayer.UserId] then
                donationNotifications.leaderboardActive[donationNotifications.leaderboardPlayer.UserId]:Destroy()
                donationNotifications.leaderboardActive[donationNotifications.leaderboardPlayer.UserId] = nil
            end
        end
    end)
    donationNotifications.leaderboardNotificationFrame.Destroying:Connect(function()
        donationNotifications.leaderboardActive[donationNotifications.leaderboardPlayer.UserId] = nil
    end)
end

donationNotifications.processLeaderboardMatches = function()
    donationNotifications.leaderboardCheckSuccess, donationNotifications.leaderboardCheckResult = donationNotifications.checkLeaderboardForPlayers()
    if donationNotifications.leaderboardCheckSuccess and donationNotifications.leaderboardCheckResult then
        donationNotifications.leaderboardI = 1
        while donationNotifications.leaderboardI <= #donationNotifications.leaderboardCheckResult do
            donationNotifications.leaderboardMatch = donationNotifications.leaderboardCheckResult[donationNotifications.leaderboardI]
            if donationNotifications.leaderboardMatch.player and donationNotifications.leaderboardMatch.place and donationNotifications.leaderboardMatch.username then
                if not donationNotifications.leaderboardNotified[donationNotifications.leaderboardMatch.player.UserId] then
                    donationNotifications.leaderboardNotified[donationNotifications.leaderboardMatch.player.UserId] = true
                    donationNotifications.createLeaderboardNotificationPlayer = donationNotifications.leaderboardMatch.player
                    donationNotifications.createLeaderboardNotificationPlace = donationNotifications.leaderboardMatch.place
                    donationNotifications.createLeaderboardNotification()
                end
            end
            donationNotifications.leaderboardI = donationNotifications.leaderboardI + 1
        end
    end
end

donationNotifications.startLeaderboardChecking = function()
    task.wait(2)
    donationNotifications.processLeaderboardMatches()
    donationNotifications.processMinutesMatches()
    trackConnection(RunService.Heartbeat:Connect(function()
        donationNotifications.leaderboardCounter = donationNotifications.leaderboardCounter + 1
        if donationNotifications.leaderboardCounter >= 420 then
            donationNotifications.leaderboardCounter = 0
            donationNotifications.processLeaderboardMatches()
            donationNotifications.processMinutesMatches()
        end
    end))
end

-- Minutes Leaderboard Notification System (using existing tables, 0 new locals)
donationNotifications.checkMinutesForPlayers = function()
    donationNotifications.minutesCheckSuccess, donationNotifications.minutesCheckResult = pcall(function()
        donationNotifications.minutesTemp = workspace:FindFirstChild("Map")
        if not donationNotifications.minutesTemp then return {} end
        donationNotifications.minutesTemp = donationNotifications.minutesTemp:FindFirstChild("POI")
        if not donationNotifications.minutesTemp then return {} end
        donationNotifications.minutesTemp = donationNotifications.minutesTemp:FindFirstChild("Leaderboards")
        if not donationNotifications.minutesTemp then return {} end
        donationNotifications.minutesTemp = donationNotifications.minutesTemp:FindFirstChild("Minutes")
        if not donationNotifications.minutesTemp then return {} end
        donationNotifications.minutesTemp = donationNotifications.minutesTemp:FindFirstChild("Board")
        if not donationNotifications.minutesTemp then return {} end
        donationNotifications.minutesTemp = donationNotifications.minutesTemp:FindFirstChild("SurfaceGui")
        if not donationNotifications.minutesTemp then return {} end
        donationNotifications.minutesTemp = donationNotifications.minutesTemp:FindFirstChild("Frame")
        if not donationNotifications.minutesTemp then return {} end
        donationNotifications.minutesTemp = donationNotifications.minutesTemp:FindFirstChild("List")
        if not donationNotifications.minutesTemp then return {} end
        donationNotifications.minutesMatches = {}
        donationNotifications.minutesPlayers = Players:GetPlayers()
        donationNotifications.minutesNames = {}
        donationNotifications.minutesI = 1
        while donationNotifications.minutesI <= #donationNotifications.minutesPlayers do
            donationNotifications.minutesNames[donationNotifications.minutesPlayers[donationNotifications.minutesI].Name:lower()] = donationNotifications.minutesPlayers[donationNotifications.minutesI]
            donationNotifications.minutesI = donationNotifications.minutesI + 1
        end
        donationNotifications.minutesI = 1
        while donationNotifications.minutesI <= 100 do
            donationNotifications.minutesKey = tostring(donationNotifications.minutesI)
            donationNotifications.minutesItem = donationNotifications.minutesTemp:FindFirstChild(donationNotifications.minutesKey)
            if donationNotifications.minutesItem then
                donationNotifications.minutesAmountFrame = donationNotifications.minutesItem:FindFirstChild("Amount")
                if donationNotifications.minutesAmountFrame and donationNotifications.minutesAmountFrame:IsA("TextLabel") then
                    donationNotifications.minutesAmount = donationNotifications.minutesAmountFrame.Text
                    donationNotifications.minutesPlaceFrame = donationNotifications.minutesItem:FindFirstChild("Place")
                    if donationNotifications.minutesPlaceFrame and donationNotifications.minutesPlaceFrame:IsA("TextLabel") then
                        donationNotifications.minutesPlace = donationNotifications.minutesPlaceFrame.Text
                        donationNotifications.minutesUsernameFrame = donationNotifications.minutesItem:FindFirstChild("Username")
                        if donationNotifications.minutesUsernameFrame then
                            donationNotifications.minutesUsernameLabel = donationNotifications.minutesUsernameFrame:FindFirstChild("Username")
                            if donationNotifications.minutesUsernameLabel and donationNotifications.minutesUsernameLabel:IsA("TextLabel") then
                                donationNotifications.minutesUsername = donationNotifications.minutesUsernameLabel.Text
                                if donationNotifications.minutesUsername and donationNotifications.minutesUsername ~= "" then
                                    donationNotifications.minutesPlayer = donationNotifications.minutesNames[donationNotifications.minutesUsername:lower()]
                                    if donationNotifications.minutesPlayer then
                                        table.insert(donationNotifications.minutesMatches, {
                                            player = donationNotifications.minutesPlayer,
                                            place = donationNotifications.minutesPlace,
                                            amount = donationNotifications.minutesAmount,
                                            username = donationNotifications.minutesUsername
                                        })
                                    end
                                end
                            end
                        end
                    end
                end
            end
            donationNotifications.minutesI = donationNotifications.minutesI + 1
        end
        return donationNotifications.minutesMatches
    end)
    if donationNotifications.minutesCheckSuccess then
        return donationNotifications.minutesCheckResult or {}
    else
        return {}
    end
end

donationNotifications.createMinutesNotification = function()
    donationNotifications.minutesPlayer = donationNotifications.createMinutesNotificationPlayer
    donationNotifications.minutesPlace = donationNotifications.createMinutesNotificationPlace
    donationNotifications.minutesAmount = donationNotifications.createMinutesNotificationAmount
    if not donationNotifications.minutesPlayer or not donationNotifications.minutesPlayer.Parent then
        return
    end
    if donationNotifications.minutesActive[donationNotifications.minutesPlayer.UserId] then
        return
    end
    donationNotifications.minutesActiveCount = 0
    donationNotifications.minutesTemp = next(donationNotifications.minutesActive)
    while donationNotifications.minutesTemp do
        donationNotifications.minutesActiveCount = donationNotifications.minutesActiveCount + 1
        donationNotifications.minutesTemp = next(donationNotifications.minutesActive, donationNotifications.minutesTemp)
    end
    donationNotifications.minutesNotificationFrame = Instance.new("Frame")
    donationNotifications.minutesNotificationFrame.Name = "MinutesNotification_" .. donationNotifications.minutesPlayer.UserId
    donationNotifications.minutesNotificationFrame.Size = UDim2.new(0, 350, 0, 60)
    donationNotifications.minutesNotificationFrame.AnchorPoint = Vector2.new(0.5, 1)
    donationNotifications.minutesNotificationFrame.Position = UDim2.new(0.5, 0, 1, -120 - (donationNotifications.minutesActiveCount * 70))
    donationNotifications.minutesNotificationFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    donationNotifications.minutesNotificationFrame.BackgroundTransparency = 0
    donationNotifications.minutesNotificationFrame.BorderSizePixel = 0
    donationNotifications.minutesNotificationFrame.Visible = true
    donationNotifications.minutesNotificationFrame.Parent = screenGui
    donationNotifications.minutesNotificationFrame.ZIndex = 51
    donationNotifications.minutesNotificationCorner = Instance.new("UICorner")
    donationNotifications.minutesNotificationCorner.CornerRadius = UDim.new(0, 10)
    donationNotifications.minutesNotificationCorner.Parent = donationNotifications.minutesNotificationFrame
    donationNotifications.minutesNotificationStroke = Instance.new("UIStroke")
    donationNotifications.minutesNotificationStroke.Color = Color3.fromRGB(60, 60, 60)
    donationNotifications.minutesNotificationStroke.Thickness = 1
    donationNotifications.minutesNotificationStroke.Transparency = 0.3
    donationNotifications.minutesNotificationStroke.Parent = donationNotifications.minutesNotificationFrame
    donationNotifications.minutesNotificationLabel = Instance.new("TextLabel")
    donationNotifications.minutesNotificationLabel.Name = "NotificationText"
    donationNotifications.minutesNotificationLabel.Size = UDim2.new(1, -80, 1, 0)
    donationNotifications.minutesNotificationLabel.Position = UDim2.new(0, 15, 0, 0)
    donationNotifications.minutesNotificationLabel.BackgroundTransparency = 1
    donationNotifications.minutesNotificationLabel.Text = "[" .. donationNotifications.minutesPlace .. "] " .. donationNotifications.minutesPlayer.Name .. " (" .. donationNotifications.minutesAmount .. " min) is in your server!"
    donationNotifications.minutesNotificationLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    donationNotifications.minutesNotificationLabel.TextSize = 16
    donationNotifications.minutesNotificationLabel.Font = Enum.Font.GothamBold
    donationNotifications.minutesNotificationLabel.TextXAlignment = Enum.TextXAlignment.Left
    donationNotifications.minutesNotificationLabel.TextWrapped = true
    donationNotifications.minutesNotificationLabel.Parent = donationNotifications.minutesNotificationFrame
    donationNotifications.minutesTeleportButton = Instance.new("TextButton")
    donationNotifications.minutesTeleportButton.Name = "TeleportButton"
    donationNotifications.minutesTeleportButton.Size = UDim2.new(0, 22, 0, 22)
    donationNotifications.minutesTeleportButton.Position = UDim2.new(1, -32, 0.5, -11)
    donationNotifications.minutesTeleportButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    donationNotifications.minutesTeleportButton.Text = "→"
    donationNotifications.minutesTeleportButton.TextColor3 = Color3.fromRGB(220, 220, 220)
    donationNotifications.minutesTeleportButton.TextSize = 14
    donationNotifications.minutesTeleportButton.Font = Enum.Font.GothamBold
    donationNotifications.minutesTeleportButton.BorderSizePixel = 0
    donationNotifications.minutesTeleportButton.Parent = donationNotifications.minutesNotificationFrame
    donationNotifications.minutesTeleportCorner = Instance.new("UICorner")
    donationNotifications.minutesTeleportCorner.CornerRadius = UDim.new(0, 4)
    donationNotifications.minutesTeleportCorner.Parent = donationNotifications.minutesTeleportButton
    donationNotifications.minutesTeleportBorder = Instance.new("UIStroke")
    donationNotifications.minutesTeleportBorder.Color = Color3.fromRGB(60, 60, 60)
    donationNotifications.minutesTeleportBorder.Thickness = 1
    donationNotifications.minutesTeleportBorder.Transparency = 0.3
    donationNotifications.minutesTeleportBorder.Parent = donationNotifications.minutesTeleportButton
    donationNotifications.minutesTeleportButton.MouseEnter:Connect(function()
        donationNotifications.minutesTeleportButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end)
    donationNotifications.minutesTeleportButton.MouseLeave:Connect(function()
        donationNotifications.minutesTeleportButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end)
    donationNotifications.minutesTeleportButton.MouseButton1Click:Connect(function()
        if donationNotifications.minutesPlayer.Character then
            donationNotifications.minutesRoot = getRoot(donationNotifications.minutesPlayer.Character)
            donationNotifications.minutesLocalPlayer = Players.LocalPlayer
            if donationNotifications.minutesRoot and donationNotifications.minutesLocalPlayer and donationNotifications.minutesLocalPlayer.Character then
                donationNotifications.minutesLocalRoot = getRoot(donationNotifications.minutesLocalPlayer.Character)
                if donationNotifications.minutesLocalRoot then
                    donationNotifications.minutesLocalRoot.CFrame = donationNotifications.minutesRoot.CFrame
                end
            end
        end
    end)
    donationNotifications.minutesActive[donationNotifications.minutesPlayer.UserId] = donationNotifications.minutesNotificationFrame
    donationNotifications.minutesNotificationFrame.Size = UDim2.new(0, 0, 0, 60)
    donationNotifications.minutesSizeTween = TweenService:Create(
        donationNotifications.minutesNotificationFrame,
        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 350, 0, 60)}
    )
    donationNotifications.minutesSizeTween:Play()
    task.spawn(function()
        task.wait(8)
        if donationNotifications.minutesNotificationFrame.Parent then
            donationNotifications.minutesFadeTween = TweenService:Create(
                donationNotifications.minutesNotificationFrame,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                {BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 60)}
            )
            if donationNotifications.minutesNotificationLabel then
                donationNotifications.minutesTextFade = TweenService:Create(
                    donationNotifications.minutesNotificationLabel,
                    TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                    {TextTransparency = 1}
                )
                donationNotifications.minutesTextFade:Play()
            end
            donationNotifications.minutesFadeTween:Play()
            donationNotifications.minutesFadeTween.Completed:Wait()
            if donationNotifications.minutesNotificationFrame.Parent then
                donationNotifications.minutesNotificationFrame:Destroy()
            end
            donationNotifications.minutesActive[donationNotifications.minutesPlayer.UserId] = nil
        end
    end)
    donationNotifications.minutesPlayer.AncestryChanged:Connect(function()
        if not donationNotifications.minutesPlayer.Parent then
            if donationNotifications.minutesActive[donationNotifications.minutesPlayer.UserId] then
                donationNotifications.minutesActive[donationNotifications.minutesPlayer.UserId]:Destroy()
                donationNotifications.minutesActive[donationNotifications.minutesPlayer.UserId] = nil
            end
        end
    end)
    donationNotifications.minutesNotificationFrame.Destroying:Connect(function()
        donationNotifications.minutesActive[donationNotifications.minutesPlayer.UserId] = nil
    end)
end

donationNotifications.processMinutesMatches = function()
    donationNotifications.minutesCheckSuccess, donationNotifications.minutesCheckResult = donationNotifications.checkMinutesForPlayers()
    if donationNotifications.minutesCheckSuccess and donationNotifications.minutesCheckResult then
        donationNotifications.minutesI = 1
        while donationNotifications.minutesI <= #donationNotifications.minutesCheckResult do
            donationNotifications.minutesMatch = donationNotifications.minutesCheckResult[donationNotifications.minutesI]
            if donationNotifications.minutesMatch.player and donationNotifications.minutesMatch.place and donationNotifications.minutesMatch.amount and donationNotifications.minutesMatch.username then
                if not donationNotifications.minutesNotified[donationNotifications.minutesMatch.player.UserId] then
                    donationNotifications.minutesNotified[donationNotifications.minutesMatch.player.UserId] = true
                    donationNotifications.createMinutesNotificationPlayer = donationNotifications.minutesMatch.player
                    donationNotifications.createMinutesNotificationPlace = donationNotifications.minutesMatch.place
                    donationNotifications.createMinutesNotificationAmount = donationNotifications.minutesMatch.amount
                    donationNotifications.createMinutesNotification()
                end
            end
            donationNotifications.minutesI = donationNotifications.minutesI + 1
        end
    end
end

task.spawn(donationNotifications.startLeaderboardChecking)

local function evaluateHoverTarget()
    if not scriptRunning then
        return
    end
    
    if not clientMouse then
        return
    end

    local target = clientMouse.Target
    if not target then
        setHoveredPlayer(nil)
        return
    end

    local targetPlayer = getPlayerFromInstance(target)
    if targetPlayer and targetPlayer ~= clientPlayer then
        local hoverDistance = settingsState.hoverRange or INTERACTION_DISTANCE
        local withinDistance = isPlayerWithinDistance(targetPlayer, hoverDistance)
        if withinDistance then
            setHoveredPlayer(targetPlayer)
            return
        end
    end

    setHoveredPlayer(nil)
end

if clientMouse then
    clientMouse.Move:Connect(evaluateHoverTarget)
end

trackConnection(RunService.RenderStepped:Connect(function()
    if not scriptRunning then
        return
    end
    evaluateHoverTarget()
end))

local function showRightClickHint(targetPlayer, mousePosition)
end

local function tryOpenPlayerInfoFromRightClick()
    if not scriptRunning then
        return false
    end
    
    if not clientPlayer or not clientMouse then
        return false
    end

    local targetPart = clientMouse.Target
    if not targetPart then
        return false
    end

    local targetPlayer = getPlayerFromInstance(targetPart)
    if not targetPlayer or targetPlayer == clientPlayer then
        return false
    end

    local localCharacter = clientPlayer.Character
    local targetCharacter = targetPlayer.Character
    if not localCharacter or not targetCharacter then
        return false
    end

    local localRoot = getRoot(localCharacter)
    local targetRoot = getRoot(targetCharacter)
    if not localRoot or not targetRoot then
        return false
    end

    local distance = (localRoot.Position - targetRoot.Position).Magnitude
    local rightClickDistance = settingsState.hoverRange or INTERACTION_DISTANCE
    if distance > rightClickDistance then
        createNotification(
            "Tip Stats",
            "Move closer to inspect " .. (targetPlayer.DisplayName or targetPlayer.Name) .. ".",
            "warning"
        )
        return true
    end

    createPlayerInfoUI(targetPlayer)
    local mousePosition = UserInputService:GetMouseLocation()
    return true
end

trackConnection(UserInputService.InputBegan:Connect(function(input, processed)
    if not scriptRunning then
        return
    end
    
    -- Check for hotkey listening FIRST (before any other checks, ignore processed flag)
    if toggleKeyListening then
        if input.UserInputType == Enum.UserInputType.Keyboard then
            if input.KeyCode then
                -- Allow escape key to cancel
                if input.KeyCode == Enum.KeyCode.Escape then
                    toggleKeyListening = false
                    if toggleKeyButton then
                        local function updateHotkeyButton()
                            if settingsState.toggleKeyCode then
                                toggleKeyButton.Text = settingsState.toggleKeyCode.Name
                            else
                                toggleKeyButton.Text = "None"
                            end
                        end
                        updateHotkeyButton()
                        toggleKeyButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                    end
                    print("TipStatsGUI: Hotkey listening cancelled (Escape)")
                    return
                end
                
                -- Capture any valid key (ignore processed flag when listening)
                if input.KeyCode ~= Enum.KeyCode.Unknown then
                    settingsState.toggleKeyCode = input.KeyCode
                    toggleKeyListening = false
                    
                    if toggleKeyButton then
                        toggleKeyButton.Text = input.KeyCode.Name
                        toggleKeyButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                    end
                    
                    print("TipStatsGUI: Hotkey set to", input.KeyCode.Name)
                    saveSettings() -- Save settings when hotkey changes
                    return -- Prevent other handlers from processing this input
                end
            end
        elseif input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 then
            -- Cancel hotkey listening if user clicks elsewhere
            toggleKeyListening = false
            if toggleKeyButton then
                local function updateHotkeyButton()
                    if settingsState.toggleKeyCode then
                        toggleKeyButton.Text = settingsState.toggleKeyCode.Name
                    else
                        toggleKeyButton.Text = "None"
                    end
                end
                updateHotkeyButton()
                toggleKeyButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            end
            print("TipStatsGUI: Hotkey listening cancelled (mouse click)")
            return
        end
        -- If listening but input type doesn't match, just return to prevent other handlers
        return
    end

    if input.KeyCode == Enum.KeyCode.LeftAlt or input.KeyCode == Enum.KeyCode.RightAlt then
        altKeyDown = true
    end

    if not processed and input.UserInputType == Enum.UserInputType.Keyboard then
        if settingsState.toggleKeyCode and input.KeyCode == settingsState.toggleKeyCode then
            if not UserInputService:GetFocusedTextBox() then
                toggleClose()
            end
            return
        end
    end

    if processed then
        return
    end

    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        if not isAltModifierDown(input) then
            return
        end
        if tick() - lastRightClickTime < RIGHT_CLICK_COOLDOWN then
            return
        end
        if tryOpenPlayerInfoFromRightClick() then
            lastRightClickTime = tick()
        end
    end
end))

-- Track Alt key release to reset altKeyDown flag
trackConnection(UserInputService.InputEnded:Connect(function(input)
    if not scriptRunning then
        return
    end
    
    if input.KeyCode == Enum.KeyCode.LeftAlt or input.KeyCode == Enum.KeyCode.RightAlt then
        altKeyDown = false
    end
end))

-- Function to create a player entry
local function createPlayerEntry(player)
    ensureTipJarTracking(player)
    local entryFrame = Instance.new("Frame")
    entryFrame.Name = player.Name
    entryFrame.Size = UDim2.new(1, 0, 0, 60)
    entryFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
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
    nameLabel.Size = UDim2.new(1, -134, 0, 22)
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
    
    -- Premium badge (if player has premium) - positioned after username
    local premiumBadge = nil
    if player.MembershipType == Enum.MembershipType.Premium then
        premiumBadge = Instance.new("TextLabel")
        premiumBadge.Name = "PremiumBadge"
        premiumBadge.Size = UDim2.new(0, 18, 0, 18)
        premiumBadge.BackgroundTransparency = 1
        premiumBadge.Text = "⭐"
        premiumBadge.TextColor3 = Color3.fromRGB(255, 215, 0) -- Gold color
        premiumBadge.TextSize = 14
        premiumBadge.Font = Enum.Font.GothamBold
        premiumBadge.Parent = entryFrame
        premiumBadge.ZIndex = nameLabel.ZIndex + 1
        
        -- Function to update premium badge position (after username in parentheses, on the right)
        local function updatePremiumBadgePosition()
            if not premiumBadge or not premiumBadge.Parent then return end
            spawn(function()
                task.wait(0.1) -- Wait for text to render
                if not premiumBadge or not premiumBadge.Parent or not nameLabel then return end
                local textBounds = nameLabel.TextBounds
                -- Position badge at the end of the text (right side) with a small gap
                local xPos = nameLabel.Position.X.Offset + textBounds.X + 4
                premiumBadge.Position = UDim2.new(0, xPos, 0, nameLabel.Position.Y.Offset + 2)
            end)
        end
        
        -- Update position when text changes
        nameLabel:GetPropertyChangedSignal("TextBounds"):Connect(updatePremiumBadgePosition)
        updatePremiumBadgePosition()
    end
    
    -- Update display name if it changes
    player:GetPropertyChangedSignal("DisplayName"):Connect(function()
        local newDisplayName = player.DisplayName ~= player.Name and player.DisplayName or player.Name
        nameLabel.Text = newDisplayName .. " (" .. player.Name .. ")"
        if premiumBadge then
            spawn(function()
                task.wait(0.1) -- Wait for text to update
                if not premiumBadge or not premiumBadge.Parent or not nameLabel then return end
                local textBounds = nameLabel.TextBounds
                -- Position badge at the end of the text (right side) with a small gap
                local xPos = nameLabel.Position.X.Offset + textBounds.X + 4
                premiumBadge.Position = UDim2.new(0, xPos, 0, nameLabel.Position.Y.Offset + 2)
            end)
        end
    end)
    
    -- Hide Button (individual player hide) - leftmost button
    local hideButton = Instance.new("TextButton")
    hideButton.Name = "HideButton"
    hideButton.Size = UDim2.new(0, 22, 0, 22)
    hideButton.Position = UDim2.new(1, -128, 0, 4)
    hideButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    hideButton.Text = "H"
    hideButton.TextColor3 = Color3.fromRGB(150, 150, 150)
    hideButton.TextSize = 14
    hideButton.Font = Enum.Font.GothamBold
    hideButton.BorderSizePixel = 0
    hideButton.Parent = entryFrame
    
    local hideCorner = Instance.new("UICorner")
    hideCorner.CornerRadius = UDim.new(0, 4)
    hideCorner.Parent = hideButton
    
    -- Hide button tooltip
    showTooltip(hideButton, "Hide this player")
    
    local hideButtonHovering = false
    local function updateHideButtonState(hidden, hovering)
        local isHidden = hidden
        if isHidden == nil then
            isHidden = isPlayerIndividuallyHidden(player)
        end
        local isHovering = hovering
        if isHovering == nil then
            isHovering = hideButtonHovering
        end
        local idleColor = isHidden and Color3.fromRGB(200, 120, 120) or Color3.fromRGB(150, 150, 150)
        local hoverColor = isHidden and Color3.fromRGB(255, 170, 170) or Color3.fromRGB(230, 230, 230)
        hideButton.TextColor3 = isHovering and hoverColor or idleColor
    end

    updateHideButtonState()

    hideButton.MouseEnter:Connect(function()
        hideButtonHovering = true
        hideButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        updateHideButtonState(nil, true)
    end)
    hideButton.MouseLeave:Connect(function()
        hideButtonHovering = false
        hideButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        updateHideButtonState(nil, false)
    end)
    
    hideButton.MouseButton1Click:Connect(function()
        toggleIndividualHideState(player)
        updateHideButtonState()
    end)

    local hideStateConnection = individualHideStateChanged.Event:Connect(function(changedPlayer, hidden)
        if changedPlayer == player then
            updateHideButtonState(hidden)
                    end
                end)

    entryFrame.Destroying:Connect(function()
        if hideStateConnection then
            hideStateConnection:Disconnect()
            hideStateConnection = nil
        end
    end)
    
    -- Bang Button
    local bangButton = Instance.new("TextButton")
    bangButton.Name = "BangButton"
    bangButton.Size = UDim2.new(0, 22, 0, 22)
    bangButton.Position = UDim2.new(1, -104, 0, 4)
    bangButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
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
        bangButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end)
    bangButton.MouseLeave:Connect(function()
        bangButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end)
    
    -- Bang button tooltip
    showTooltip(bangButton, "bangs this player")
    
    -- Bang button click
    bangButton.MouseButton1Click:Connect(function()
        bangPlayer(player)
    end)
    
    -- Spy Button
    local spyButton = Instance.new("TextButton")
    spyButton.Name = "SpyButton"
    spyButton.Size = UDim2.new(0, 22, 0, 22)
    spyButton.Position = UDim2.new(1, -80, 0, 4)
    spyButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    spyButton.Text = "👁"
    spyButton.TextColor3 = Color3.fromRGB(220, 220, 220)
    spyButton.TextSize = 14
    spyButton.Font = Enum.Font.GothamBold
    spyButton.BorderSizePixel = 0
    spyButton.Parent = entryFrame
    
    local spyCorner = Instance.new("UICorner")
    spyCorner.CornerRadius = UDim.new(0, 4)
    spyCorner.Parent = spyButton
    
    -- Spy button hover effect
    spyButton.MouseEnter:Connect(function()
        spyButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end)
    spyButton.MouseLeave:Connect(function()
        spyButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end)
    
    -- Spy button tooltip
    showTooltip(spyButton, "View from this player's perspective")
    
    spyButton.MouseButton1Click:Connect(function()
        spyPlayer(player)
    end)
    
    -- Teleport Button
    local teleportButton = Instance.new("TextButton")
    teleportButton.Name = "TeleportButton"
    teleportButton.Size = UDim2.new(0, 22, 0, 22)
    teleportButton.Position = UDim2.new(1, -56, 0, 4)
    teleportButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
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
        teleportButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end)
    teleportButton.MouseLeave:Connect(function()
        teleportButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end)
    
    -- Teleport button tooltip
    showTooltip(teleportButton, "Teleport to this player")
    
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
    infoButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    infoButton.BorderSizePixel = 0
    infoButton.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=150&height=150&format=png"
    infoButton.Parent = entryFrame
    
    local infoCorner = Instance.new("UICorner")
    infoCorner.CornerRadius = UDim.new(0, 4)
    infoCorner.Parent = infoButton
    
    -- Info button hover effect
    infoButton.MouseEnter:Connect(function()
        infoButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end)
    infoButton.MouseLeave:Connect(function()
        infoButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
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
    
    -- Helper function to check if TipJar is in backpack
    -- Function to update received amount (from Raised property)
    local function updateReceived()
        -- First check if TipJar is in backpack
        if not playerOwnsTipJar(player) then
            -- Update the label to show "Doesn't own Tip Jar"
            receivedLabel.Text = "Doesn't own Tip Jar"
            receivedValue.Text = ""
            receivedValue.TextColor3 = Color3.fromRGB(150, 150, 150)
            return
        end
        
        -- Reset label back to "Received:" if TipJar exists
        receivedLabel.Text = "Received:"
        
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
                timeValue.Text = hours .. "h " .. mins .. "m (" .. totalMinutes .. ")"
            else
                timeValue.Text = totalMinutes .. "m (" .. totalMinutes .. ")"
            end
            timeValue.TextColor3 = Color3.fromRGB(230, 230, 230)
        else
            timeValue.Text = "0m (0)"
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
                donated:GetPropertyChangedSignal("Value"):Connect(function()
                    updateDonated()
                    -- Re-sort the list when donation changes
                    if searchTextBox and searchTextBox.Text then
                        updateList(searchTextBox.Text)
                    else
                        updateList("")
                    end
                end)
            else
                -- Wait for Donated to potentially be created
                local success, result = pcall(function()
                    return tipJarStats:WaitForChild("Donated", 5)
                end)
                if success and result then
                    donated = result
                    updateDonated()
                    donated:GetPropertyChangedSignal("Value"):Connect(function()
                        updateDonated()
                        -- Re-sort the list when donation changes
                        if searchTextBox and searchTextBox.Text then
                            updateList(searchTextBox.Text)
                        else
                            updateList("")
                        end
                    end)
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
        
        -- Monitor backpack for TipJar changes
        local backpack = player:FindFirstChild("Backpack")
        if not backpack then
            backpack = player:WaitForChild("Backpack", 10)
        end
        if backpack then
            -- Listen for items being added or removed
            backpack.ChildAdded:Connect(function(child)
                -- Check if TipJar was added
                if child.Name == "TipJar" then
                    recordTipJarOwnership(player)
                    updateReceived()
                end
            end)
            backpack.ChildRemoved:Connect(function(child)
                -- Check if TipJar was removed
                if child.Name == "TipJar" then
                    recordTipJarOwnership(player)
                    updateReceived()
                end
            end)
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
local searchDebounce = nil
local searchClearButton = nil

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

-- Store search tweens to cancel them if needed
local searchHideTween = nil
local searchOpenTween = nil
local searchScrollTween = nil

-- Helper to immediately close the search UI (used when minimizing/closing)
forceCloseSearch = function(skipAnimation)
    local currentSearchFrame = searchFrame
    if not currentSearchFrame then
        currentSearchFrame = mainFrame:FindFirstChild("SearchFrame")
        if currentSearchFrame then
            searchFrame = currentSearchFrame
        end
    end
    if not currentSearchFrame or not currentSearchFrame.Visible then
        return
    end
    
    -- Cancel any ongoing animations
    if searchOpenTween then
        searchOpenTween:Cancel()
        searchOpenTween = nil
    end
    if searchHideTween then
        searchHideTween:Cancel()
        searchHideTween = nil
    end
    if searchScrollTween then
        searchScrollTween:Cancel()
        searchScrollTween = nil
    end
    
    if skipAnimation or not currentSearchFrame.Visible then
        currentSearchFrame.Visible = false
        currentSearchFrame.Size = UDim2.new(1, -20, 0, 35)
        currentSearchFrame.BackgroundTransparency = 0
    end
    
    if scrollingFrame then
        scrollingFrame.Position = UDim2.new(0, 10, 0, 50)
        scrollingFrame.Size = UDim2.new(1, -20, 1, -65)
    end
    
    searchQuery = ""
    if searchTextBox then
        searchTextBox.Text = ""
        searchTextBox:ReleaseFocus()
    end
    if searchClearButton then
        searchClearButton.Visible = false
    end
    
    updateList("")
end

-- Function to toggle search box
local function toggleSearch()
    -- Don't allow opening search when minimized
    if isMinimized then
        return
    end
    
    if searchFrame and searchFrame.Visible then
        -- Cancel any ongoing open animation
        if searchOpenTween then
            searchOpenTween:Cancel()
            searchOpenTween = nil
        end
        
        -- Hide search with animation
        searchHideTween = TweenService:Create(
            searchFrame,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {
                Size = UDim2.new(1, -20, 0, 0),
                BackgroundTransparency = 1
            }
        )
        searchHideTween:Play()
        searchHideTween.Completed:Connect(function()
            searchFrame.Visible = false
            searchFrame.Size = UDim2.new(1, -20, 0, 35)
            searchFrame.BackgroundTransparency = 0
            searchHideTween = nil
        end)
        
        searchQuery = ""
        if searchTextBox then
            searchTextBox.Text = ""
        end
        if searchClearButton then
            searchClearButton.Visible = false
        end
        
        -- Adjust scrolling frame back with animation
        searchScrollTween = TweenService:Create(
            scrollingFrame,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {
                Position = UDim2.new(0, 10, 0, 50),
                Size = UDim2.new(1, -20, 1, -65)
            }
        )
        searchScrollTween:Play()
        searchScrollTween.Completed:Connect(function()
            searchScrollTween = nil
        end)
        
        updateList("")
    else
        -- Show search
        if not searchFrame then
            -- Create search frame
            searchFrame = Instance.new("Frame")
            searchFrame.Name = "SearchFrame"
            searchFrame.Size = UDim2.new(1, -20, 0, 0)
            searchFrame.Position = UDim2.new(0, 10, 0, 50)
            searchFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
            searchFrame.BackgroundTransparency = 1
            searchFrame.BorderSizePixel = 0
            searchFrame.Visible = true
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
            
            -- Search text box (with space for clear button)
            searchTextBox = Instance.new("TextBox")
            searchTextBox.Name = "SearchTextBox"
            searchTextBox.Size = UDim2.new(1, -40, 1, -10)
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
            
            -- Clear button (X) - appears when there's text
            searchClearButton = Instance.new("TextButton")
            searchClearButton.Name = "ClearButton"
            searchClearButton.Size = UDim2.new(0, 25, 0, 25)
            searchClearButton.AnchorPoint = Vector2.new(1, 0.5)
            searchClearButton.Position = UDim2.new(1, -5, 0.5, 0)
            searchClearButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            searchClearButton.Text = "×"
            searchClearButton.TextColor3 = Color3.fromRGB(200, 200, 200)
            searchClearButton.TextSize = 18
            searchClearButton.Font = Enum.Font.GothamBold
            searchClearButton.BorderSizePixel = 0
            searchClearButton.Visible = false
            searchClearButton.Parent = searchFrame
            searchClearButton.ZIndex = searchFrame.ZIndex + 1
            
            local clearButtonCorner = Instance.new("UICorner")
            clearButtonCorner.CornerRadius = UDim.new(0, 4)
            clearButtonCorner.Parent = searchClearButton
            
            -- Clear button hover effect
            searchClearButton.MouseEnter:Connect(function()
                searchClearButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            end)
            searchClearButton.MouseLeave:Connect(function()
                searchClearButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            end)
            
            -- Clear button click
            searchClearButton.MouseButton1Click:Connect(function()
                searchTextBox.Text = ""
                searchQuery = ""
                updateList("")
            end)
            
            -- Function to update clear button visibility
            local function updateClearButtonVisibility()
                if searchClearButton then
                    searchClearButton.Visible = searchTextBox.Text ~= ""
                end
            end
            
            -- Search text changed (with debounce to avoid reloading on every keystroke)
            searchTextBox:GetPropertyChangedSignal("Text"):Connect(function()
                searchQuery = searchTextBox.Text
                updateClearButtonVisibility()
                
                -- Cancel previous debounce
                if searchDebounce then
                    task.cancel(searchDebounce)
                end
                
                -- Create new debounce (wait 0.3 seconds after user stops typing)
                searchDebounce = task.delay(0.3, function()
                    updateList(searchQuery)
                    searchDebounce = nil
                end)
            end)
        end
        
        -- Cancel any ongoing hide animation
        if searchHideTween then
            searchHideTween:Cancel()
            searchHideTween = nil
        end
        
        -- Animate search frame opening
        searchFrame.Visible = true
        searchOpenTween = TweenService:Create(
            searchFrame,
            TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {
                Size = UDim2.new(1, -20, 0, 35),
                BackgroundTransparency = 0
            }
        )
        searchOpenTween:Play()
        
        -- Adjust scrolling frame to make room for search with animation
        searchScrollTween = TweenService:Create(
            scrollingFrame,
            TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {
                Position = UDim2.new(0, 10, 0, 90),
                Size = UDim2.new(1, -20, 1, -105)
            }
        )
        searchScrollTween:Play()
        searchScrollTween.Completed:Connect(function()
            searchScrollTween = nil
        end)
        
        -- Focus text box after animation
        searchOpenTween.Completed:Connect(function()
            if searchTextBox then
                searchTextBox:CaptureFocus()
            end
            searchOpenTween = nil
        end)
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
    -- Log player leaving in their profile
    logPlayerLeaving(player)
    
    -- Unspy if this player is being spied on
    if viewing == player then
        unspyPlayer()
    end

    if hoveredPlayer == player then
        setHoveredPlayer(nil)
    end
    closeHoverPreviewForPlayer(player)
    setIndividualHideState(player, false)
    playerTipJarOwnership[player] = nil
    if tipJarTrackingConnections[player] then
        for _, conn in ipairs(tipJarTrackingConnections[player]) do
            conn:Disconnect()
        end
        tipJarTrackingConnections[player] = nil
    end
    
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

-- Start monitoring donations
monitorDonations()

-- Donation notification function removed due to local variable limit issues
-- Donations are now logged to console instead

-- Setup respawn teleport handler
local localPlayer = Players.LocalPlayer
if localPlayer then
    -- Handle character respawn
    local function onCharacterAdded(character)
        spawn(function()
            -- Wait longer to ensure character is fully loaded
            task.wait(0.5)
            
            if not character or not character.Parent then
                return
            end
            
            -- Wait for root part to exist
            local root = getRoot(character)
            local attempts = 0
            while not root and attempts < 20 do
                task.wait(0.1)
                root = getRoot(character)
                attempts = attempts + 1
            end
            
            if root and lastPosition then
                -- Teleport back to saved position
                root.CFrame = lastPosition
                -- Clear position after teleporting
                task.wait(0.1)
                lastPosition = nil
            end
        end)
    end
    
    -- Connect to character respawn
    if localPlayer.Character then
        onCharacterAdded(localPlayer.Character)
    end
    
    localPlayer.CharacterAdded:Connect(onCharacterAdded)
end

-- Function to reset character (called when "%re" is detected in chat)
local function resetCharacter()
    pcall(function()
        local localPlayer = Players.LocalPlayer
        if not localPlayer or not localPlayer.Character then
            warn("TipStatsGUI: Cannot reset - no character found")
            return
        end
        
        local character = localPlayer.Character
        local root = getRoot(character)
        
        if root then
            -- Save current position before reset
            lastPosition = root.CFrame
        end
        
        print("TipStatsGUI: Resetting character...")
        
        -- Simple reset - just kill the character
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Health = 0
        else
            character:BreakJoints()
        end
    end)
end

-- Function to rejoin the same server (called when "%rejoin" is detected in chat)
local function rejoinServer()
    pcall(function()
        local localPlayer = Players.LocalPlayer
        if not localPlayer then
            warn("TipStatsGUI: Cannot rejoin - no local player found")
            return
        end
        
        local placeId = game.PlaceId
        local jobId = game.JobId
        
        if not placeId or not jobId then
            warn("TipStatsGUI: Cannot rejoin - invalid PlaceId or JobId")
            return
        end
        
        print("TipStatsGUI: Rejoining server - PlaceId:", placeId, "JobId:", jobId)
        
        -- Simple rejoin - use TeleportToPlaceInstance
        TeleportService:TeleportToPlaceInstance(placeId, jobId, localPlayer)
    end)
end

-- Function to server hop (teleport to a different server of the same place)
local function serverHop()
    pcall(function()
        local localPlayer = Players.LocalPlayer
        if not localPlayer then
            warn("TipStatsGUI: Cannot server hop - no local player found")
            return
        end
        
        local placeId = game.PlaceId
        
        if not placeId then
            warn("TipStatsGUI: Cannot server hop - invalid PlaceId")
            return
        end
        
        print("TipStatsGUI: Server hopping - PlaceId:", placeId)
        
        -- Simple server hop - just teleport to the place (will find a new server)
        TeleportService:Teleport(placeId, localPlayer)
    end)
end

-- Chat message detection for "%re" command
spawn(function()
    if not scriptRunning then
        return
    end
    
    local chatLocalPlayer = Players.LocalPlayer
    if not chatLocalPlayer then
        chatLocalPlayer = Players.PlayerAdded:Wait()
    end
    
    -- Helper function to check and execute commands
    local function checkAndExecute(messageText)
        if not messageText then 
            return false 
        end
        
        -- Convert to string and trim whitespace
        local messageStr = tostring(messageText)
        local trimmed = messageStr:gsub("^%s+", ""):gsub("%s+$", "")
        local lowerTrimmed = trimmed:lower()
        
        print("TipStatsGUI: Received chat message:", lowerTrimmed) -- Debug
        
        -- Check for commands (exact match or with leading/trailing spaces)
        -- Also check without % sign as fallback
        local command = lowerTrimmed:match("^%s*(%%?%w+)%s*$")
        if command then
            command = command:lower()
            
            if command == "%re" or command == "re" or command == "%reset" or command == "reset" then
                print("TipStatsGUI: Detected reset command - resetting character")
                resetCharacter()
                return true
            elseif command == "%rejoin" or command == "rejoin" then
                print("TipStatsGUI: Detected rejoin command - rejoining server")
                rejoinServer()
                return true
            elseif command == "%serverhop" or command == "serverhop" then
                print("TipStatsGUI: Detected serverhop command - hopping to different server")
                serverHop()
                return true
            end
        end
        
        -- Also check the trimmed message directly (in case pattern matching fails)
        if lowerTrimmed == "%re" or lowerTrimmed == "re" or lowerTrimmed == "%reset" or lowerTrimmed == "reset" then
            print("TipStatsGUI: Detected reset command (direct) - resetting character")
            resetCharacter()
            return true
        elseif lowerTrimmed == "%rejoin" or lowerTrimmed == "rejoin" then
            print("TipStatsGUI: Detected rejoin command (direct) - rejoining server")
            rejoinServer()
            return true
        elseif lowerTrimmed == "%serverhop" or lowerTrimmed == "serverhop" then
            print("TipStatsGUI: Detected serverhop command (direct) - hopping to different server")
            serverHop()
            return true
        end
        
        return false
    end
    
    local function hookLegacyChat(player)
        if not player or player:IsDescendantOf(game) == false then
            return
        end
        local connection = player.Chatted:Connect(function(message)
            if scriptRunning then
                -- Only execute commands if this is the local player
                if player == Players.LocalPlayer then
                    print("TipStatsGUI: Legacy chat received from local player:", message) -- Debug
                    checkAndExecute(message)
                end
                -- Note: Chat logging is handled by hookNewChat to avoid duplicates
            end
        end)
        print("TipStatsGUI: Hooked legacy chat for player:", player.Name)
        return connection
    end
    
    local function hookNewChat()
        if not TextChatService then
            return
        end
        
        -- Hook into MessageReceived event
        local success, err = pcall(function()
            TextChatService.MessageReceived:Connect(function(message)
                if not scriptRunning then
                    return
                end
                
                -- Try different ways to get the message text and sender
                local messageText = nil
                local sender = nil
                local recipient = nil
                
                -- Method 1: message.Text and message.TextSource
                if message.Text then
                    messageText = message.Text
                end
                
                if message.TextSource then
                    sender = Players:GetPlayerByUserId(message.TextSource.UserId)
                end
                
                -- Method 2: Try message properties directly
                if not messageText and message.Message then
                    messageText = message.Message
                end
                
                -- Method 3: Try to get from TextSource properties
                if not sender and message.TextSource then
                    local textSource = message.TextSource
                    if textSource.UserId then
                        sender = Players:GetPlayerByUserId(textSource.UserId)
                    end
                end
                
                -- Track chat message for profile system (all players) - only log once per message
                if settingsState.buildPlayerProfile and sender and messageText then
                    local playerName = sender.Name
                    local currentTime = tick()
                    local lastMessage = lastLoggedMessages[playerName]
                    
                    -- Check if this is a duplicate (same content within 0.5 seconds)
                    local isDuplicate = false
                    if lastMessage and lastMessage.content == messageText and (currentTime - lastMessage.time) < 0.5 then
                        isDuplicate = true
                    end
                    
                    if not isDuplicate then
                        if not playerChatMessages[playerName] then
                            playerChatMessages[playerName] = {}
                        end
                        local messageEntry = {
                            sender = playerName,
                            recipient = recipient,
                            content = messageText,
                            timestamp = getCurrentTimestamp()
                        }
                        table.insert(playerChatMessages[playerName], messageEntry)
                        
                        -- Save message immediately to messages.json (separate from profile)
                        task.spawn(function()
                            savePlayerChatMessages(playerName, {messageEntry})
                        end)
                        
                        -- Track this message to prevent duplicates
                        lastLoggedMessages[playerName] = {
                            content = messageText,
                            time = currentTime
                        }
                    end
                end
                
                -- Execute if it's from local player
                if sender and sender == Players.LocalPlayer and messageText then
                    print("TipStatsGUI: New chat received:", messageText) -- Debug
                    checkAndExecute(messageText)
                end
            end)
            print("TipStatsGUI: New chat hook connected successfully")
        end)
        
        if not success then
            warn("TipStatsGUI: Failed to hook new chat:", err)
        else
            print("TipStatsGUI: New chat system hooked")
        end
        
        -- Also try hooking into TextChatService.ChatInputBarConfiguration if available
        pcall(function()
            local chatBar = TextChatService:FindFirstChild("ChatInputBarConfiguration")
            if chatBar then
                -- This is a fallback - the MessageReceived should work, but this is extra
                print("TipStatsGUI: ChatInputBarConfiguration found")
            end
        end)
    end
    
    -- Also try hooking into TextChatService.ChatVersion changes
    local function tryHookTextChat()
        if TextChatService then
            local success, chatVersion = pcall(function()
                return TextChatService.ChatVersion
            end)
            
            if success and chatVersion == Enum.ChatVersion.TextChatService then
                -- New chat system
                hookNewChat()
            end
        end
    end
    
    -- Initialize both systems (they can coexist)
    local legacyConnected = false
    local newChatConnected = false

    local function initLegacy()
        if legacyConnected then
            return
        end
        legacyConnected = true
        local success, err = pcall(function()
            -- Hook legacy chat for local player (for commands)
            if chatLocalPlayer then
                hookLegacyChat(chatLocalPlayer)
            end
            -- Also hook for all other players (for profile tracking)
            if settingsState.buildPlayerProfile then
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= chatLocalPlayer then
                        hookLegacyChat(player)
                    end
                end
                Players.PlayerAdded:Connect(function(player)
                    if settingsState.buildPlayerProfile and player ~= chatLocalPlayer then
                        hookLegacyChat(player)
                    end
                end)
            end
        end)
        if success then
            print("TipStatsGUI: Legacy chat detection initialized")
        else
            warn("TipStatsGUI: Failed to initialize legacy chat:", err)
        end
    end

    local function initNewChat()
        if newChatConnected then
            return
        end
        newChatConnected = true
        hookNewChat()
        print("TipStatsGUI: New chat detection initialized")
    end

    -- Always try to hook both systems
    initLegacy()
    initNewChat()
    tryHookTextChat()
    
    -- Also hook directly to local player's Chatted event as additional fallback
    -- This is the most reliable method
    local function setupDirectChatHook(player)
        if not player then
            return
        end
        pcall(function()
            player.Chatted:Connect(function(message)
                if scriptRunning then
                    -- Note: Chat logging is handled by hookNewChat to avoid duplicates
                    print("TipStatsGUI: Direct Chatted event received:", message) -- Debug
                    local executed = checkAndExecute(message)
                    if executed then
                        print("TipStatsGUI: Command executed successfully")
                    end
                end
            end)
            print("TipStatsGUI: Direct Chatted event hooked for:", player.Name)
        end)
    end
    
    if chatLocalPlayer then
        setupDirectChatHook(chatLocalPlayer)
    end
    
    -- Also wait for player if not available yet
    Players.PlayerAdded:Connect(function(player)
        if player == Players.LocalPlayer then
            setupDirectChatHook(player)
        end
    end)
    
    -- Additional fallback: Hook into Players.LocalPlayer when it becomes available
    task.spawn(function()
        local player = Players.LocalPlayer
        if not player then
            player = Players.PlayerAdded:Wait()
        end
        if player == Players.LocalPlayer then
            setupDirectChatHook(player)
        end
    end)
    
    print("TipStatsGUI: Chat detection system fully initialized")
end)


print("Tip Stats GUI loaded successfully!")

-- Disable AFK tags for all players on startup to prevent AFK detection issues
task.wait(1) -- Wait a bit for PlayerCharacters to load
disableAFKTagsForAllPlayers()

-- Also disable AFK tags for new players
if Workspace:FindFirstChild("PlayerCharacters") then
    Workspace.PlayerCharacters.ChildAdded:Connect(function(child)
        task.wait(0.5) -- Wait for HumanoidRootPart to be created
        if child:IsA("Model") or child:IsA("Folder") then
            disableAFKTagForPlayer(child.Name)
        end
    end)
end

-- AFK warning notification removed

