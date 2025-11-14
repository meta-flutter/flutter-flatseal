# Flutter Flatseal Architecture

This document describes the architecture and design decisions of Flutter Flatseal.

## Overview

Flutter Flatseal is a Flutter application that provides a graphical interface for managing Flatpak application permissions. It follows a clean architecture pattern with clear separation of concerns.

## Architecture Layers

```
┌─────────────────────────────────────────────────────────────┐
│                      Presentation Layer                      │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   Screens    │  │   Widgets    │  │    Theme     │      │
│  │              │  │              │  │              │      │
│  │ - HomeScreen │  │ - AppList    │  │ - Material3  │      │
│  │              │  │ - PermDetails│  │ - Dark/Light │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
                            ▲
                            │
┌─────────────────────────────────────────────────────────────┐
│                     Business Logic Layer                     │
│  ┌──────────────────────────────────────────────────────┐   │
│  │              FlatpakService                          │   │
│  │  (State Management - ChangeNotifier)                 │   │
│  │                                                      │   │
│  │  - loadApps()                                       │   │
│  │  - selectApp()                                      │   │
│  │  - overridePermission()                             │   │
│  │  - resetOverrides()                                 │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                            ▲
                            │
┌─────────────────────────────────────────────────────────────┐
│                       Data Layer                             │
│  ┌──────────────┐  ┌──────────────┐                        │
│  │    Models    │  │  Flatpak CLI  │                        │
│  │              │  │               │                        │
│  │ - FlatpakApp │  │ - Process.run │                        │
│  │ - Permission │  │ - Command exec│                        │
│  └──────────────┘  └──────────────┘                        │
└─────────────────────────────────────────────────────────────┘
```

## Component Details

### Presentation Layer

#### Screens
- **HomeScreen**: Main application screen with two-pane layout
  - Left pane: Application list with search
  - Right pane: Permission details for selected app
  - AppBar with refresh and about actions

#### Widgets
- **AppList**: Searchable list of Flatpak applications
  - Filter functionality
  - Selection state management
  - App metadata display

- **PermissionDetails**: Shows permissions for selected app
  - App header with metadata
  - Permission groups organized by category
  - Actions: reload, reset overrides

- **PermissionGroup**: Expandable group of related permissions
  - Category icon and title
  - List of permission items with toggles
  - Collapsible sections

- **PermissionItem**: Individual permission toggle
  - Display name and description
  - Switch control for enable/disable
  - Real-time state updates

#### Theme
- Material Design 3
- System theme detection (light/dark)
- Consistent color scheme based on seed color
- Proper contrast and accessibility

### Business Logic Layer

#### FlatpakService
Central service using Provider pattern for state management.

**Responsibilities:**
- Execute Flatpak CLI commands
- Parse command output
- Manage application state
- Notify listeners of changes

**Key Methods:**
- `isFlatpakInstalled()`: Check for Flatpak availability
- `loadApps()`: Fetch list of installed applications
- `selectApp(FlatpakApp)`: Select app and load permissions
- `loadAppPermissions(FlatpakApp)`: Get app-specific permissions
- `overridePermission()`: Apply permission change
- `resetOverrides()`: Remove all overrides
- `getOverrides()`: Get current override settings

**State Properties:**
- `apps`: List of available applications
- `selectedApp`: Currently selected application
- `isLoading`: Loading state indicator
- `error`: Error message if any

### Data Layer

#### Models

**FlatpakApp**
```dart
class FlatpakApp {
  final String id;              // Application ID (org.example.App)
  final String name;            // Display name
  final String version;         // Version string
  final String branch;          // Branch (stable, beta, etc.)
  final String origin;          // Origin repository (flathub, etc.)
  final String? runtime;        // Runtime dependency
  final Map<String, dynamic> permissions;  // Current permissions
}
```

**Permission**
```dart
class Permission {
  final String category;        // Permission category
  final String key;             // Permission key
  final String displayName;     // Human-readable name
  final String? description;    // Description text
  final PermissionType type;    // Type of permission
  bool enabled;                 // Current state
  String? value;                // Optional value
}
```

**PermissionType**
```dart
enum PermissionType {
  boolean,      // Simple on/off
  filesystem,   // File system access
  device,       // Device access
  feature,      // Feature flag
  socket,       // Socket/IPC
  environment,  // Environment variable
  dbus,         // D-Bus access
  custom,       // Custom/other
}
```

#### Flatpak CLI Integration

Commands used:
```bash
# List applications
flatpak list --app --columns=application,name,version,branch,origin

# Show permissions
flatpak info --show-permissions <app-id>

# Override permission
flatpak override <app-id> --<category>=<permission>

# Remove permission
flatpak override <app-id> --no<category>=<permission>

# Reset overrides
flatpak override --reset <app-id>

# Show current overrides
flatpak override --show <app-id>
```

## Data Flow

### Application Startup
```
1. FlatsealApp (main.dart)
   ↓
2. ChangeNotifierProvider(FlatpakService)
   ↓
3. MaterialApp + HomeScreen
   ↓
4. HomeScreen.initState()
   ↓
5. FlatpakService.loadApps()
   ↓
6. Execute: flatpak list --app
   ↓
7. Parse output → List<FlatpakApp>
   ↓
8. Update state → notifyListeners()
   ↓
9. UI rebuilds with app list
```

### Permission Toggle Flow
```
1. User toggles permission switch
   ↓
2. PermissionItem.onChanged()
   ↓
3. FlatpakService.overridePermission()
   ↓
4. Execute: flatpak override <app> --<category>=<perm>
   ↓
5. Check exit code
   ↓
6. If success:
   - FlatpakService.loadAppPermissions()
   - Execute: flatpak info --show-permissions <app>
   - Parse and update state
   - notifyListeners()
   ↓
7. UI rebuilds with updated permission state
```

### App Selection Flow
```
1. User clicks app in list
   ↓
2. AppListItem.onTap()
   ↓
3. FlatpakService.selectApp(app)
   ↓
4. FlatpakService.loadAppPermissions(app)
   ↓
5. Execute: flatpak info --show-permissions <app>
   ↓
6. Parse permissions
   ↓
7. Update _selectedApp with permissions
   ↓
8. notifyListeners()
   ↓
9. PermissionDetails rebuilds with app permissions
```

## State Management

### Provider Pattern
- Simple and effective for this app's scope
- Single `FlatpakService` provides global state
- Widgets listen via `context.watch<FlatpakService>()`
- Actions triggered via `context.read<FlatpakService>()`

### State Updates
- All state changes go through `FlatpakService`
- `notifyListeners()` triggers widget rebuilds
- Granular rebuilds using `Consumer<FlatpakService>`
- Error handling via error property

## Error Handling

### Levels
1. **Flatpak Not Installed**
   - Check on app startup
   - Show error message with instructions
   - Provide retry option

2. **Command Execution Failures**
   - Catch process errors
   - Display user-friendly messages
   - Log technical details

3. **Permission Denied**
   - May need elevated permissions
   - Inform user of requirements
   - Provide guidance

4. **Parse Errors**
   - Handle malformed output
   - Fallback to safe defaults
   - Report parsing issues

## Performance Considerations

### Optimization Strategies
1. **Lazy Loading**: Load permissions only when app is selected
2. **Caching**: Store app list until manual refresh
3. **Async Operations**: All I/O operations are async
4. **Efficient Rebuilds**: Use `Consumer` for targeted updates
5. **const Constructors**: Use const where possible

### Bottlenecks
- Flatpak CLI execution (I/O bound)
- Permission parsing (CPU bound for large apps)
- UI rebuilds for large app lists

## Security Considerations

1. **Command Injection Prevention**
   - No shell interpolation
   - Use `Process.run()` with argument list
   - Validate input parameters

2. **Permission Model**
   - Read-only by default for queries
   - Write operations require explicit user action
   - No automatic permission grants

3. **Error Information**
   - Don't expose sensitive system information
   - Sanitize error messages shown to user
   - Log details for debugging

## Testing Strategy

### Unit Tests
- Model serialization/deserialization
- Permission logic
- State management operations
- Command parsing

### Widget Tests
- UI component rendering
- User interactions
- State updates
- Error displays

### Integration Tests (Future)
- Full user flows
- Multi-app scenarios
- Error recovery
- Performance benchmarks

## Future Enhancements

### Planned Features
1. **Advanced Permissions**
   - Custom filesystem paths
   - Environment variables
   - D-Bus detailed configuration

2. **Profiles**
   - Save/load permission sets
   - Import/export functionality
   - Preset templates

3. **Search & Filter**
   - Advanced filtering options
   - Permission-based search
   - Recently modified apps

4. **Multi-selection**
   - Batch operations
   - Apply to multiple apps
   - Group management

5. **History & Undo**
   - Track permission changes
   - Undo/redo functionality
   - Change log

### Technical Improvements
1. **Caching**: Reduce CLI calls
2. **Indexing**: Faster search
3. **Notifications**: Permission change alerts
4. **Logging**: Debug information
5. **Analytics**: Usage patterns (privacy-respecting)

## Platform Integration

### Linux Desktop
- GTK3 window management
- System theme integration
- Desktop file for app launcher
- Icon in system themes
- Keyboard shortcuts

### Android (Future)
- Limited Flatpak support
- Alternative permission management
- Mobile-optimized UI

### Other Platforms
- macOS: Experimental, limited use
- Windows: Not applicable (no Flatpak)
- Web: View-only mode possible

## Build System

### Flutter
- SDK 3.0+ required
- Hot reload for development
- AOT compilation for production

### Linux
- CMake build system
- GTK3 dependencies
- Native C++ entry point

### CI/CD
- GitHub Actions
- Automated tests
- Multi-platform builds
- Artifact generation

## Dependencies

### Core Dependencies
- `flutter`: Framework
- `provider`: State management
- `process_run`: Command execution
- `shared_preferences`: Settings storage
- `cupertino_icons`: iOS-style icons

### Dev Dependencies
- `flutter_test`: Testing framework
- `flutter_lints`: Code analysis

### Platform Dependencies
- Linux: GTK3, Flatpak
- Android: Java 17+

## References

- [Flutter Documentation](https://docs.flutter.dev/)
- [Provider Package](https://pub.dev/packages/provider)
- [Flatpak Documentation](https://docs.flatpak.org/)
- [Original Flatseal](https://github.com/tchx84/Flatseal)
- [Material Design 3](https://m3.material.io/)
