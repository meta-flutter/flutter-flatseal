# Flutter Flatseal

A Flutter application that manages Flatpak sandbox permissions, inspired by the original [Flatseal](https://github.com/tchx84/Flatseal) project.

## Features

- 🔍 **View Installed Apps**: Browse all Flatpak applications installed on your system
- 🔐 **Manage Permissions**: Control filesystem access, device access, sockets, and other permissions
- 🎨 **Modern UI**: Flutter-native Material Design interface
- 🖥️ **Desktop-First**: Optimized for Linux desktop with GTK support
- 🔄 **Real-time Updates**: Instantly apply permission changes
- 🔙 **Reset Overrides**: Easily restore default permissions

## Screenshots

The application features a two-pane layout:
- **Left Pane**: Searchable list of installed Flatpak applications
- **Right Pane**: Detailed permission settings for the selected application

## Prerequisites

- **Flutter SDK** (3.0.0 or later)
- **Flatpak** (installed and configured on your system)
- **Linux Desktop Environment** (for full functionality)
- **GTK 3.0+** (for Linux desktop builds)

### Installing Flatpak

If you don't have Flatpak installed:

```bash
# Ubuntu/Debian
sudo apt install flatpak

# Fedora
sudo dnf install flatpak

# Arch Linux
sudo pacman -S flatpak
```

## Building the Application

### 1. Clone the Repository

```bash
git clone https://github.com/meta-flutter/flutter-flatseal.git
cd flutter-flatseal
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Enable Linux Desktop Support (if not already enabled)

```bash
flutter config --enable-linux-desktop
```

### 4. Build for Linux

```bash
flutter build linux --release
```

The built application will be located at:
```
build/linux/x64/release/bundle/
```

## Running the Application

### Development Mode

Run directly with Flutter:

```bash
flutter run -d linux
```

### Production Build

After building, run the executable:

```bash
./build/linux/x64/release/bundle/flutter_flatseal
```

## Installation

### Manual Installation

1. Build the application (see above)
2. Copy the bundle to your preferred location:

```bash
sudo cp -r build/linux/x64/release/bundle /opt/flutter-flatseal
sudo ln -s /opt/flutter-flatseal/flutter_flatseal /usr/local/bin/flutter-flatseal
```

3. Install the desktop entry:

```bash
sudo cp linux/flutter_flatseal.desktop /usr/share/applications/
```

### CMake Installation

```bash
cd build/linux/x64/release
sudo cmake --install . --prefix /usr
```

## Usage

1. **Launch the Application**
   - From application menu: Search for "Flutter Flatseal"
   - From terminal: `flutter-flatseal` or `flutter run`

2. **Select an Application**
   - Browse or search for a Flatpak app in the left pane
   - Click on an app to view its permissions

3. **Manage Permissions**
   - Toggle switches to enable/disable specific permissions
   - Changes are applied immediately
   - Look for categories: Filesystem, Devices, Sockets, Features, Network

4. **Reset Overrides**
   - Click the restore icon in the app header
   - Confirm to reset all custom permissions to defaults

## Project Structure

```
flutter-flatseal/
├── lib/
│   ├── main.dart              # Application entry point
│   ├── models/                # Data models
│   │   ├── flatpak_app.dart   # Flatpak application model
│   │   └── permission.dart    # Permission definitions
│   ├── services/              # Business logic
│   │   └── flatpak_service.dart  # Flatpak command interaction
│   ├── screens/               # Main screens
│   │   └── home_screen.dart   # Home screen with app list
│   └── widgets/               # Reusable UI components
│       ├── app_list.dart      # Application list widget
│       ├── permission_details.dart  # Permission view
│       └── permission_group.dart    # Permission category
├── linux/                     # Linux desktop configuration
│   ├── CMakeLists.txt
│   ├── main.cc
│   ├── my_application.cc/h
│   └── flutter_flatseal.desktop
├── test/                      # Unit tests
└── pubspec.yaml              # Dependencies
```

## Permissions Categories

The application manages the following permission categories:

### Filesystem Access
- Home directory
- All system files
- XDG directories (Downloads, Documents, Pictures, Music, Videos)

### Device Access
- All devices
- GPU acceleration (DRI)
- Virtualization (KVM)

### Sockets
- X11/Wayland display servers
- PulseAudio sound system
- D-Bus (session and system)
- SSH authentication agent
- Smart cards (PCSC)
- CUPS printing

### Features
- Development tools
- Bluetooth
- Network access
- Multi-architecture support

## Development

### Running Tests

```bash
flutter test
```

### Code Analysis

```bash
flutter analyze
```

### Format Code

```bash
flutter format lib/
```

## Packaging

### Snap Package (Planned)

```bash
# Coming soon
snapcraft
```

### Flatpak Package (Planned)

```bash
# Coming soon
flatpak-builder --force-clean build-dir com.example.FlutterFlatseal.yml
```

### AppImage (Planned)

AppImage packaging will be added in future releases.

## Troubleshooting

### Flatpak Not Found

**Error**: "Flatpak is not installed on this system"

**Solution**: Install Flatpak using your distribution's package manager (see Prerequisites)

### Permission Denied

**Error**: Failed to override permissions

**Solution**: Ensure you have proper permissions. Some operations may require sudo:
```bash
sudo flutter-flatseal
```

### No Applications Shown

**Issue**: Application list is empty

**Causes**:
- No Flatpak applications installed
- Flatpak not properly configured

**Solution**: Install Flatpak apps or check Flatpak installation:
```bash
flatpak list --app
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Comparison with Original Flatseal

This Flutter implementation provides:
- ✅ Modern Material Design UI
- ✅ Fast, native performance via Flutter
- ✅ Easy to extend and maintain
- ✅ Matches core Flatseal functionality
- ✅ Linux desktop focused

Original Flatseal advantages:
- More mature and battle-tested
- GTK native (better desktop integration)
- Broader Linux distribution support

## License

This project is intended as a Flutter implementation study of Flatseal functionality. 

Original Flatseal: Copyright © 2020-2024 Martin Abente Lahaye (GPLv3)

## Acknowledgments

- Original [Flatseal](https://github.com/tchx84/Flatseal) by Martin Abente Lahaye
- Flutter team for the excellent framework
- Flatpak community for the sandboxing technology

## Roadmap

- [x] Basic application listing
- [x] Permission viewing
- [x] Permission overrides
- [x] Linux desktop support
- [ ] Advanced permission editing (custom paths, environment variables)
- [ ] D-Bus permission management
- [ ] Import/Export permission profiles
- [ ] Multiple application selection
- [ ] Undo/Redo functionality
- [ ] Search and filter improvements
- [ ] Package as Snap/Flatpak/AppImage

## Support

For issues, questions, or suggestions:
- Open an issue on [GitHub](https://github.com/meta-flutter/flutter-flatseal/issues)
- Check existing issues for similar problems
- Provide detailed information about your system and the issue
