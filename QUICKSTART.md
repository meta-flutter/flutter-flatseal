# Quick Start Guide

Get Flutter Flatseal running in 5 minutes!

## Prerequisites Check

Before starting, verify you have:

```bash
# Check Flutter
flutter --version
# Expected: Flutter 3.0.0 or later

# Check Flatpak
flatpak --version
# Expected: Flatpak 1.0.0 or later

# Check GTK3 (Linux only)
pkg-config --modversion gtk+-3.0
# Expected: 3.0 or later
```

If any are missing, see [Installation](#installation) below.

## 5-Minute Setup

### 1. Clone the Repository (30 seconds)

```bash
git clone https://github.com/meta-flutter/flutter-flatseal.git
cd flutter-flatseal
```

### 2. Install Dependencies (1 minute)

```bash
flutter pub get
```

### 3. Run the Application (30 seconds)

```bash
flutter run -d linux
```

That's it! The app should now be running.

## Installation

### Install Flutter

#### Ubuntu/Debian

```bash
# Install dependencies
sudo apt-get update
sudo apt-get install -y curl git unzip xz-utils zip libglu1-mesa

# Clone Flutter
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"

# Add to .bashrc
echo 'export PATH="$PATH:/path/to/flutter/bin"' >> ~/.bashrc

# Verify
flutter doctor
```

#### Fedora

```bash
# Install dependencies
sudo dnf install curl git unzip xz zip mesa-libGLU

# Clone Flutter
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"

# Verify
flutter doctor
```

#### Arch Linux

```bash
# Install Flutter from AUR
yay -S flutter

# Or manually
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"

# Verify
flutter doctor
```

### Install Flatpak

#### Ubuntu/Debian

```bash
sudo apt install flatpak
```

#### Fedora

```bash
sudo dnf install flatpak
```

#### Arch Linux

```bash
sudo pacman -S flatpak
```

### Install Build Tools (Linux Desktop)

#### Ubuntu/Debian

```bash
sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev
```

#### Fedora

```bash
sudo dnf install clang cmake ninja-build gtk3-devel
```

#### Arch Linux

```bash
sudo pacman -S clang cmake ninja gtk3
```

## First Run

### 1. Start the App

```bash
cd flutter-flatseal
flutter run -d linux
```

### 2. Initial Screen

You'll see:
- **Left pane**: List of installed Flatpak apps
- **Right pane**: "Select an app to view its permissions"

### 3. Select an App

Click any app in the left pane to view its permissions.

### 4. Manage Permissions

- **View categories**: Filesystem, Devices, Sockets, Features
- **Toggle switches**: Enable/disable permissions
- **Reset button**: Restore default permissions

## Common Issues

### "Flatpak is not installed"

**Solution**: Install Flatpak
```bash
sudo apt install flatpak  # Ubuntu/Debian
sudo dnf install flatpak  # Fedora
sudo pacman -S flatpak    # Arch Linux
```

### "No applications found"

**Cause**: No Flatpak apps installed

**Solution**: Install some Flatpak apps
```bash
# Add Flathub repository
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install an app
flatpak install flathub org.gnome.Calculator
```

### "GTK not found" (Build Error)

**Solution**: Install GTK development libraries
```bash
sudo apt-get install libgtk-3-dev  # Ubuntu/Debian
sudo dnf install gtk3-devel        # Fedora
sudo pacman -S gtk3                # Arch Linux
```

### "Flutter not found"

**Solution**: Add Flutter to PATH
```bash
export PATH="$PATH:/path/to/flutter/bin"
# Add to .bashrc for permanent
```

## Building Release Version

For a production build:

```bash
flutter build linux --release
```

Find the executable at:
```
build/linux/x64/release/bundle/flutter_flatseal
```

Run it:
```bash
./build/linux/x64/release/bundle/flutter_flatseal
```

## Next Steps

### Explore Features

1. **Search Apps**: Use the search bar to filter applications
2. **View Permissions**: Click an app to see all its permissions
3. **Change Permissions**: Toggle switches to enable/disable
4. **Reset Overrides**: Use the reset button to restore defaults

### Development

Want to contribute? See:
- [CONTRIBUTING.md](CONTRIBUTING.md) - Development guidelines
- [ARCHITECTURE.md](ARCHITECTURE.md) - Code structure
- [BUILDING.md](BUILDING.md) - Detailed build instructions

### Learn More

- [Full README](README.md) - Complete documentation
- [Flatpak Documentation](https://docs.flatpak.org/) - Learn about Flatpak
- [Flutter Documentation](https://docs.flutter.dev/) - Flutter guides

## Tips & Tricks

### Hot Reload

During development, make code changes and press:
- `r` - Hot reload (fast, preserves state)
- `R` - Hot restart (full restart)

### Debug Mode

Run with verbose output:
```bash
flutter run -d linux --verbose
```

### Performance

See performance stats:
```bash
flutter run -d linux --profile
```

Press `p` in the terminal to toggle performance overlay.

### VS Code

For the best development experience, use VS Code with the Flutter extension:

1. Install [VS Code](https://code.visualstudio.com/)
2. Install Flutter extension
3. Open project folder
4. Press F5 to run with debugging

### Keyboard Shortcuts (in development)

- `Ctrl+C` - Stop the app
- `r` - Hot reload
- `R` - Hot restart
- `h` - Help
- `q` - Quit

## Quick Reference

### Project Structure

```
flutter-flatseal/
├── lib/
│   ├── main.dart           # Entry point
│   ├── models/             # Data models
│   ├── services/           # Business logic
│   ├── screens/            # UI screens
│   └── widgets/            # UI components
├── linux/                  # Linux platform files
├── test/                   # Tests
└── pubspec.yaml           # Dependencies
```

### Key Files

- `lib/main.dart` - Application entry point
- `lib/services/flatpak_service.dart` - Flatpak integration
- `lib/screens/home_screen.dart` - Main UI
- `pubspec.yaml` - Project configuration

### Useful Commands

```bash
# Get dependencies
flutter pub get

# Run tests
flutter test

# Analyze code
flutter analyze

# Format code
flutter format lib/

# Build release
flutter build linux --release

# Clean build artifacts
flutter clean
```

## Getting Help

### Documentation

- [README.md](README.md) - Main documentation
- [BUILDING.md](BUILDING.md) - Build instructions
- [CONTRIBUTING.md](CONTRIBUTING.md) - Contribution guide
- [ARCHITECTURE.md](ARCHITECTURE.md) - Technical details

### Support

- [GitHub Issues](https://github.com/meta-flutter/flutter-flatseal/issues) - Report bugs
- [Discussions](https://github.com/meta-flutter/flutter-flatseal/discussions) - Ask questions

### Resources

- [Flutter Docs](https://docs.flutter.dev/)
- [Flatpak Docs](https://docs.flatpak.org/)
- [Original Flatseal](https://github.com/tchx84/Flatseal)

## Success! 🎉

You now have Flutter Flatseal running! 

Try these next:
1. Install a Flatpak app if you don't have any
2. Select an app and explore its permissions
3. Try toggling a permission (like network access)
4. Reset permissions to see the default state
5. Read the full documentation to learn more

Happy permission managing!
