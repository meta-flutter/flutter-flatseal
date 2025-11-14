# Screenshots and Examples

Visual guide to Flutter Flatseal features and UI.

## Main Interface

### Application List View

```
┌──────────────────────────────────────────────────────────────────┐
│  Flutter Flatseal                         🔄 Refresh    ℹ About  │
├──────────────┬───────────────────────────────────────────────────┤
│              │                                                    │
│  🔍 Search   │  Select an app to view its permissions            │
│  ┌────────┐ │                                                    │
│  │        │ │                                                    │
│  └────────┘ │                                                    │
│              │                                                    │
│  📦 Firefox  │                                                    │
│  org.mozill. │                                                    │
│              │                                                    │
│  📦 GIMP     │                                                    │
│  org.gimp.GI │                                                    │
│              │                                                    │
│  📦 VLC      │                                                    │
│  org.videola │                                                    │
│              │                                                    │
└──────────────┴───────────────────────────────────────────────────┘
```

**Features:**
- Searchable application list on the left
- Click any app to view permissions
- Shows app name and ID
- Scroll for more apps

## Permission Details View

### App Header

```
┌──────────────────────────────────────────────────────────────────┐
│  Flutter Flatseal                         🔄 Refresh    ℹ About  │
├──────────────┬───────────────────────────────────────────────────┤
│              │  📦  Firefox Web Browser                          │
│  [App List]  │  org.mozilla.firefox                              │
│              │  Version: 115.0 • Branch: stable                  │
│              │                               🔄 Reload   🔙 Reset │
│              ├───────────────────────────────────────────────────┤
│              │  [Permission Groups Below]                        │
└──────────────┴───────────────────────────────────────────────────┘
```

**Header shows:**
- App icon and name
- Application ID
- Version and branch information
- Reload button (refresh permissions)
- Reset button (restore defaults)

## Permission Groups

### Filesystem Access

```
┌─────────────────────────────────────────────────────────────────┐
│  📁 Filesystem Access                                       ▼   │
├─────────────────────────────────────────────────────────────────┤
│  All user files                                      ⚫ OFF     │
│  Access to all files in home directory                          │
│                                                                 │
│  All system files                                    ⚪ ON      │
│  Access to all files on the system                              │
│                                                                 │
│  Downloads folder                                    ⚪ ON      │
│  Access to downloads folder                                     │
│                                                                 │
│  Documents folder                                    ⚫ OFF     │
│  Access to documents folder                                     │
│                                                                 │
│  Pictures folder                                     ⚫ OFF     │
│  Access to pictures folder                                      │
└─────────────────────────────────────────────────────────────────┘
```

**Features:**
- Expandable/collapsible groups
- Permission name and description
- Toggle switches for enable/disable
- Visual feedback (on/off state)

### Device Access

```
┌─────────────────────────────────────────────────────────────────┐
│  🖥️  Device Access                                         ▼   │
├─────────────────────────────────────────────────────────────────┤
│  All devices                                         ⚫ OFF     │
│  Access to all devices                                          │
│                                                                 │
│  GPU acceleration                                    ⚪ ON      │
│  Access to GPU for hardware acceleration                        │
│                                                                 │
│  Virtualization                                      ⚫ OFF     │
│  Access to KVM for virtualization                               │
└─────────────────────────────────────────────────────────────────┘
```

### Sockets

```
┌─────────────────────────────────────────────────────────────────┐
│  🔌 Sockets                                                 ▼   │
├─────────────────────────────────────────────────────────────────┤
│  X11 windowing system                                ⚪ ON      │
│  Access to X11 display server                                   │
│                                                                 │
│  Wayland windowing system                            ⚪ ON      │
│  Access to Wayland display server                               │
│                                                                 │
│  PulseAudio                                          ⚪ ON      │
│  Access to PulseAudio sound server                              │
│                                                                 │
│  Session bus                                         ⚪ ON      │
│  Access to session D-Bus                                        │
│                                                                 │
│  System bus                                          ⚫ OFF     │
│  Access to system D-Bus                                         │
└─────────────────────────────────────────────────────────────────┘
```

### Features & Network

```
┌─────────────────────────────────────────────────────────────────┐
│  ⚙️  Features                                              ▼   │
├─────────────────────────────────────────────────────────────────┤
│  Development access                                  ⚫ OFF     │
│  Access to development tools                                    │
│                                                                 │
│  Bluetooth                                           ⚫ OFF     │
│  Access to Bluetooth devices                                    │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│  📶 Network                                                 ▼   │
├─────────────────────────────────────────────────────────────────┤
│  Network access                                      ⚪ ON      │
│  Access to network                                              │
└─────────────────────────────────────────────────────────────────┘
```

## User Interactions

### Toggle Permission

**Before:**
```
│  Network access                                      ⚪ ON      │
```

**User clicks toggle**

**After:**
```
│  Network access                                      ⚫ OFF     │
```

**System executes:**
```bash
flatpak override org.mozilla.firefox --nofeatures=network
```

### Reset Overrides

**Dialog:**
```
┌─────────────────────────────────────────────────────────────────┐
│  Reset Overrides                                                │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Are you sure you want to reset all permission overrides       │
│  for Firefox Web Browser? This will restore the default        │
│  permissions.                                                   │
│                                                                 │
│                                         [Cancel]  [Reset]       │
└─────────────────────────────────────────────────────────────────┘
```

**Result:**
- All custom permissions removed
- Permissions reload to defaults
- Snackbar: "Overrides reset successfully"

## Loading States

### Loading Applications

```
┌──────────────────────────────────────────────────────────────────┐
│  Flutter Flatseal                         🔄 Refresh    ℹ About  │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│                          ⏳ Loading...                           │
│                  Loading Flatpak applications...                │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

## Error States

### Flatpak Not Installed

```
┌──────────────────────────────────────────────────────────────────┐
│  Flutter Flatseal                         🔄 Refresh    ℹ About  │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│                            ⚠️                                    │
│                                                                  │
│            Error: Flatpak is not installed on this system       │
│                                                                  │
│                          [Retry]                                 │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

### No Applications Found

```
┌──────────────────────────────────────────────────────────────────┐
│  Flutter Flatseal                         🔄 Refresh    ℹ About  │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│                            📦                                    │
│                                                                  │
│                  No Flatpak applications found                   │
│              Install some Flatpak apps to get started            │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

## Theme Support

### Light Theme
- Clean, bright interface
- Blue accent color
- High contrast for readability
- Standard Material Design light palette

### Dark Theme
- Dark background reduces eye strain
- Adapted accent colors
- Maintains readability
- Follows system theme preference

## Search Functionality

### Empty Search
```
│  🔍 Search                                                       │
│  ┌──────────────────────────────────────┐                       │
│  │ Search applications...                │                       │
│  └──────────────────────────────────────┘                       │
│                                                                  │
│  📦 Firefox                                                      │
│  📦 GIMP                                                         │
│  📦 VLC                                                          │
│  📦 LibreOffice                                                  │
```

### Active Search
```
│  🔍 Search                                                       │
│  ┌──────────────────────────────────────┐                       │
│  │ fire                           🔍     │                       │
│  └──────────────────────────────────────┘                       │
│                                                                  │
│  📦 Firefox                                                      │
│  org.mozilla.firefox                                             │
```

### No Results
```
│  🔍 Search                                                       │
│  ┌──────────────────────────────────────┐                       │
│  │ nonexistent                    🔍     │                       │
│  └──────────────────────────────────────┘                       │
│                                                                  │
│                  No apps found                                   │
```

## About Dialog

```
┌─────────────────────────────────────────────────────────────────┐
│  About Flutter Flatseal                                         │
├─────────────────────────────────────────────────────────────────┤
│                          🔒                                      │
│                   Flutter Flatseal                              │
│                      Version 1.0.0                              │
│                                                                 │
│  A Flutter application to manage Flatpak sandbox               │
│  permissions, inspired by the original Flatseal project.       │
│                                                                 │
│  Features:                                                      │
│  • View installed Flatpak applications                         │
│  • Manage application permissions                              │
│  • Override sandbox settings                                   │
│  • Reset permission overrides                                  │
│                                                                 │
│                      [View Licenses]  [Close]                   │
└─────────────────────────────────────────────────────────────────┘
```

## Responsive Behavior

### Wide Screen (Desktop)
- Two-pane layout
- App list: 300px fixed width
- Permission details: Flexible width
- Optimal for desktop monitors

### Narrow Screen (Tablet/Mobile - Future)
- Single pane mode
- App list fullscreen initially
- Permission details overlay or navigation
- Bottom navigation bar

## Accessibility

- **High Contrast**: Clear text and icons
- **Keyboard Navigation**: Full keyboard support (planned)
- **Screen Reader**: Proper labels and hints
- **Focus Indicators**: Clear focus states
- **Touch Targets**: Minimum 48x48 dp

## Example Use Cases

### Use Case 1: Restrict Network Access

**Scenario**: User wants to prevent an app from accessing the network

**Steps:**
1. Launch Flutter Flatseal
2. Select the app from list
3. Scroll to "Network" section
4. Toggle "Network access" to OFF
5. App can no longer access network

### Use Case 2: Grant Filesystem Access

**Scenario**: App needs access to Downloads folder

**Steps:**
1. Select app
2. Find "Filesystem Access" group
3. Toggle "Downloads folder" to ON
4. App can now read/write Downloads

### Use Case 3: Reset All Changes

**Scenario**: User made many changes and wants to start over

**Steps:**
1. Select app
2. Click Reset button (🔙) in app header
3. Confirm in dialog
4. All permissions restored to defaults

## Tips for Screenshots

When creating actual screenshots:

1. **Use Real Apps**: Show popular apps (Firefox, GIMP, VLC)
2. **Show Actions**: Capture toggle states, dialogs
3. **Include Context**: Show both panes, app header
4. **Highlight Features**: Circle/annotate key features
5. **Multiple Themes**: Show both light and dark
6. **Error States**: Document error messages
7. **Responsive**: Show different window sizes

## Screenshot Requirements

For actual screenshots to replace these mockups:

- **Format**: PNG
- **Resolution**: 1920x1080 or higher
- **Location**: `screenshots/` directory
- **Naming**: Descriptive names (e.g., `main-interface-light.png`)
- **Include**: Window decorations for context
- **Quality**: High quality, no compression artifacts

## Video Demo Ideas

Potential screencast topics:

1. **Quick Tour**: 2-minute overview of main features
2. **Permission Management**: How to toggle permissions
3. **Search & Filter**: Finding specific apps
4. **Reset Overrides**: Restoring defaults
5. **Real-World Use**: Practical security scenarios

---

**Note**: These are ASCII mockups. Actual screenshots will be added as the application is deployed and tested on real systems.
