-- Script to get player position and copy to clipboard
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

-- Function to get player position
local function getPlayerPosition()
    if not localPlayer or not localPlayer.Character then
        warn("Character not found!")
        return nil
    end
    
    local rootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart") 
        or localPlayer.Character:FindFirstChild("Torso") 
        or localPlayer.Character:FindFirstChild("UpperTorso")
    
    if not rootPart then
        warn("Root part not found!")
        return nil
    end
    
    return rootPart.Position
end

-- Get the position
local position = getPlayerPosition()

if position then
    -- Format: X, Y, Z
    local positionString = string.format("%.3f, %.3f, %.3f", position.X, position.Y, position.Z)
    
    -- Print to output
    print("Player Position:", positionString)
    print("X:", position.X, "Y:", position.Y, "Z:", position.Z)
    
    -- Copy to clipboard
    setclipboard(positionString)
    print("Position copied to clipboard!")
else
    warn("Failed to get player position")
end













