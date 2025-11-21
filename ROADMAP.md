# TipStatsGUI Roadmap

This document tracks the development progress of TipStatsGUI, including completed features, features in progress, and planned future enhancements.

## ✅ Completed Features

### Core Functionality
- **Tip Statistics Display** - Real-time monitoring and display of all players' TipJarStats (Donated and Raised values)
- **Search Functionality** - Quick filtering of players by name
- **Sorting System** - Sort players by donation amount
- **Real-time Updates** - Automatic updates when player statistics change

### Donation System
- **Donation Detection** - Sophisticated system that monitors TipJarStats changes
- **Donor Identification** - Cross-references donation increases to identify donors
- **Donation Notifications** - Displays who donated, how much, and to whom
- **Teleport to Donor** - Quick access button in donation notifications

### Player Interaction Tools
- **Bang Function** - Continuously teleports character to target player's position
  - Animation support for R6 and R15 rigs
  - Auto-stops if target leaves or character dies
- **Spy Function** - View game from another player's perspective
  - Camera follows target character
  - Auto-reconnects on respawn
- **Teleport** - Instant teleportation to any player's location
- **Player Info Panels** - Detailed panels showing donation statistics and quick action buttons

### Player Visibility Management
- **Global Hide** - Hide all players with single toggle
  - Makes characters transparent
  - Freezes movement
- **Individual Hide** - Hide specific players while keeping others visible
- **Tip Jar Hiding** - Automatically hide tip jars owned by hidden players
  - Ownership tracking system
- **Smart Restoration** - Properly restores all hidden states
  - Transparency restoration
  - Walk speed restoration
  - Jump power restoration

### Location Hub
- **Save Locations** - Save current position to custom location
- **Load Locations** - Load saved locations from storage
- **Quick Teleportation** - Instant teleport to saved locations
- **Persistent Storage** - Location data persists across sessions

### Settings Panel
- **Hover Range Configuration** - Adjust distance for player info panel appearance
- **Hotkey Configuration** - Set custom hotkeys for opening/closing GUI
- **Player Visibility Toggles** - Control global and individual hiding states
- **Tip Jar Visibility Toggle** - Control tip jar hiding for hidden players
- **Search Toggle** - Enable/disable search functionality
- **Notification Settings** - Control donation notification behavior
- **Auto-save/Load** - Settings automatically save and load on script start

### Chat Command System
- **Reset Command** - Type `%re` or `%reset` to reset character
- **Rejoin Command** - Type `%rejoin` to rejoin current server
- **Server Hop Command** - Type `%serverhop` to find and join different server
- **Dual Chat Support** - Works with both legacy chat and TextChatService

### Automation Features
- **Buzzer Auto-Click** - Automatically clicks buzzer objects within 32 studs range
  - Scans for buzzer tables in workspace
  - Automatic interaction with cooldown protection
- **AFK Tag Management** - Automatically disables AFK tags for all players
  - Runs on startup
  - Continues for new players
  - Prevents AFK detection issues

### Version Management
- **Version Tracking** - Ensures only one script instance runs
- **Auto Cleanup** - Old instances automatically clean up resources when newer version detected
- **Graceful Exit** - Proper cleanup and exit when version conflict detected
- **Version Notifications** - Notifies users of updates or conflicts

### UI Features
- **Minimizable Window** - Title bar only mode for minimized state
- **Draggable Interface** - Main GUI and settings panel are draggable
- **Hover Previews** - Information previews before opening full panels
- **Contextual Tooltips** - Helpful tooltips for UI elements
- **Smooth Animations** - Tween animations for state transitions
- **Modern Design** - Dark-themed design with rounded corners
- **Profile History UI** - Compact, readable format showing date/time and statistic changes

### Player Profile System
- **Build Player Profile Toggle** - Setting to automatically collect and save player statistics
- **Persistent Storage** - Saves player data to workspace folder in organized JSON files
- **Profile History** - View historical snapshots of player statistics with date/time tracking
- **Change Comparison** - Compare statistics between different sessions
  - Donated changes
  - Received changes
  - Playtime changes
- **Chat Message Logging** - Automatically logs all chat messages organized by date and time
- **Session Filtering** - Only shows profile entries from different sessions (filters frequent updates)
- **Human-Readable Format** - JSON files are pretty-printed with proper indentation
- **Chat Organization** - Chat messages grouped by date, sorted by time within each day
- **Profile Data Collection**:
  - TipJarStats (Donated, Received/Raised)
  - Playtime (Minutes)
  - Credits
  - Settings (Auras, Gifts, Piano, Rank, Shadow, Teleport, Time)
  - Backpack items
  - Gamepasses
  - Chat messages (organized by date/time)
  - Player join/leave events
- **Separate Storage** - Profile data saved to `Players/[PlayerName]/profile.json` and messages to `Players/[PlayerName]/messages.json`

### Technical Implementation
- **Multi-Service Integration** - Utilizes Players, TweenService, RunService, Workspace, TextService, HttpService, TextChatService, MarketplaceService, ReplicatedStorage, TeleportService, UserInputService, and GuiService
- **Connection Tracking** - Proper connection management
- **Error Handling** - Comprehensive pcall error handling
- **Efficient Updates** - PropertyChangedSignal updates for performance
- **State Cleanup** - Cleanup functions restore all modified game state

## 🚧 In Progress

_No features currently in progress_

## 🔜 Coming Soon

### Assets & Visual Enhancements
- **Image Assets** - Add image assets for enhanced UI visuals
  - Executor logos and icons
  - Feature icons
  - UI element graphics

### Executor Detection
- **Executor Detection System** - Detect which executor is being used
- **Executor-Specific Images** - Display executor logo/image when detected
- **Executor Compatibility Info** - Show compatibility status and recommendations

### Interactive Trees Function
- **Interactive Trees Toggle** - Toggle for interactive tree functionality in settings
- **Tree Interaction Automation** - Automatic interaction with interactive trees in the game

## 📋 Future Considerations

### Potential Enhancements
- Additional automation features
- Enhanced player tracking
- More customization options
- Performance optimizations
- Additional game-specific features

---

**Last Updated:** Based on Version 1.2.0release

**Note:** This roadmap is subject to change based on user feedback and development priorities.

