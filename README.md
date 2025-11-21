# TipStatsGUI

A comprehensive Roblox script providing an advanced GUI interface for tracking player tip statistics with extensive utility features for player interaction and game automation.

## Overview

TipStatsGUI displays all players' TipJarStats.Donated values in a scrollable, searchable list with real-time updates. The script includes player interaction tools, automation features, and customization options for managing tip jar statistics and player interactions.

## Core Features

### Tip Statistics Display

Monitors TipJarStats for all players, tracking both Donated and Raised values. The GUI presents this information in an organized list that updates in real-time. Players can be sorted by donation amount, and a search function allows quick filtering.

### Donation Notifications

Sophisticated donation detection system monitors changes to player TipJarStats values. When a donation is detected, the system identifies the donor by cross-referencing donation increases. Notifications display who donated, how much, and to whom, with a teleport button for quick access.

### Player Interaction Tools

- Bang Function: Continuously teleports your character to a target player's position with animation support for R6 and R15 rigs. Automatically stops if target leaves or character dies.

- Spy Function: View the game from another player's perspective by setting camera to follow their character. Auto-reconnects on respawn.

- Teleport: Instantly teleport to any player's location.

- Player Info Panels: Detailed panels showing donation statistics and quick action buttons.

### Player Visibility Management

- Global Hide: Hide all players with a single toggle, making characters transparent and freezing movement.

- Individual Hide: Hide specific players while keeping others visible.

- Tip Jar Hiding: Automatically hide tip jars owned by hidden players with ownership tracking.

- Smart Restoration: Properly restores all hidden states including transparency, walk speed, and jump power.

### Location Hub

Save and teleport to custom locations. The Location Hub provides buttons for saving current position, loading saved locations, and quick teleportation. Location data persists across sessions.

### Settings Panel

Comprehensive settings with customization options:

- Hover Range: Adjust distance for player info panel appearance.

- Hotkey Configuration: Set custom hotkeys for opening and closing the GUI.

- Player Visibility Toggles: Control global and individual hiding states.

- Tip Jar Visibility: Toggle tip jar hiding for hidden players.

- Search Functionality: Enable or disable search feature.

- Notification Settings: Control donation notification behavior.

Settings automatically save and load on script start.

### Chat Command System

Monitors chat for commands:

- Reset: Type "%re" or "%reset" to reset character.

- Rejoin: Type "%rejoin" to rejoin current server.

- Server Hop: Type "%serverhop" to find and join a different server.

Works with both legacy chat and TextChatService for compatibility.

### Buzzer Auto-Click

Automatically clicks buzzer objects when within 32 studs range. Scans for buzzer tables in workspace and interacts automatically with cooldown protection.

### AFK Tag Management

Automatically disables AFK tags for all players to prevent AFK detection issues. Runs on startup and continues for new players. Notifies users that AFK text display will be affected.

### Version Management

Version tracking ensures only one script instance runs. When newer versions are detected, old instances automatically clean up resources and exit gracefully.

### UI Features

- Minimizable window with title bar only mode.

- Draggable interface for main GUI and settings panel.

- Hover previews showing information before opening full panels.

- Contextual tooltips for UI elements.

- Smooth tween animations for state transitions.

- Modern dark-themed design with rounded corners.

## Technical Details

Utilizes multiple Roblox services including Players, TweenService, RunService, Workspace, TextService, HttpService, TextChatService, MarketplaceService, ReplicatedStorage, TeleportService, UserInputService, and GuiService. Implements connection tracking, error handling with pcall, and efficient PropertyChangedSignal updates. Data persists through Roblox storage. Cleanup functions restore all modified game state.

## Usage

Execute in a Roblox executor. GUI appears automatically showing all players and tip statistics. Use search to filter, click players for info panels, and access settings via settings button.

## Roadmap

Future features:

- Report Bug Button: Quick access in settings to report bugs with Discord contact.

## Version

Current Version: 0.9.2beta

Includes automatic version checking with notifications for updates or when newer versions are running.
