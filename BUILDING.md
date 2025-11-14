# Building Flutter Flatseal

Detailed instructions for building Flutter Flatseal on various platforms.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Setting Up Development Environment](#setting-up-development-environment)
3. [Building for Linux Desktop](#building-for-linux-desktop)
4. [Building for Other Platforms](#building-for-other-platforms)
5. [Troubleshooting](#troubleshooting)

## Prerequisites

### Required Software

- **Flutter SDK**: Version 3.0.0 or later
- **Dart SDK**: Included with Flutter
- **Git**: For version control
- **Flatpak**: Runtime dependency

### Platform-Specific Requirements

#### Linux Desktop

```bash
# Install build essentials
sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev

# Install Flatpak
sudo apt-get install flatpak

# On Fedora:
sudo dnf install clang cmake ninja-build gtk3-devel flatpak

# On Arch:
sudo pacman -S clang cmake ninja gtk3 flatpak
```



## Setting Up Development Environment

### 1. Install Flutter

Download and install Flutter SDK:

```bash
# Clone Flutter repository
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"

# Add to your shell profile (.bashrc, .zshrc, etc.)
echo 'export PATH="$PATH:/path/to/flutter/bin"' >> ~/.bashrc
source ~/.bashrc

# Verify installation
flutter doctor
```

### 2. Enable Platform Support

```bash
# Enable Linux desktop
flutter config --enable-linux-desktop

# Verify enabled platforms
flutter devices
```

### 3. Clone and Setup Project

```bash
# Clone the repository
git clone https://github.com/meta-flutter/flutter-flatseal.git
cd flutter-flatseal

# Get dependencies
flutter pub get

# Verify setup
flutter doctor -v
```

## Building for Linux Desktop

### Debug Build

Fast build for development and testing:

```bash
flutter build linux --debug
```

Output: `build/linux/x64/debug/bundle/`

### Release Build

Optimized build for distribution:

```bash
flutter build linux --release
```

Output: `build/linux/x64/release/bundle/`

### Profile Build

For performance profiling:

```bash
flutter build linux --profile
```

### CMake Build Options

For advanced users, you can customize the CMake build:

```bash
cd build/linux/x64/release
cmake ../../../linux -DCMAKE_BUILD_TYPE=Release
cmake --build .
```

### Installation

Install to system directories:

```bash
cd build/linux/x64/release
sudo cmake --install . --prefix /usr
```

This installs:
- Binary: `/usr/bin/flutter_flatseal`
- Desktop file: `/usr/share/applications/flutter_flatseal.desktop`
- Icon: `/usr/share/icons/hicolor/128x128/apps/flutter_flatseal.png`

## Building for Other Platforms

### Web (Limited Functionality)

Note: Flatpak interaction requires system access not available in web builds.

```bash
flutter config --enable-web
flutter build web --release
```

### macOS (Experimental)

```bash
flutter config --enable-macos-desktop
flutter build macos --release
```

Note: Flatpak is not commonly used on macOS, so functionality will be limited.

### Windows (Experimental)

```bash
flutter config --enable-windows-desktop
flutter build windows --release
```

Note: Flatpak is not available on Windows.

## Build Optimization

### Reducing Binary Size

```bash
# Strip debug symbols
flutter build linux --release --split-debug-info=./debug-info --obfuscate
```

### Tree Shaking

Automatically enabled in release builds to remove unused code.

### AOT Compilation

Release builds use ahead-of-time compilation for better performance.

## Development Builds

### Hot Reload

During development, use hot reload for instant updates:

```bash
flutter run -d linux
# Press 'r' to hot reload
# Press 'R' to hot restart
```

### Debug Mode Features

- Observatory (debugging tools)
- Hot reload/restart
- Detailed error messages
- Performance overlay

Access with:
```bash
flutter run -d linux --verbose
```

## Continuous Integration

### GitHub Actions Example

```yaml
name: Build

on: [push, pull_request]

jobs:
  build-linux:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
          channel: 'stable'
      
      - name: Install dependencies
        run: |
          sudo apt-get update
          sudo apt-get install -y clang cmake ninja-build pkg-config libgtk-3-dev
      
      - name: Get dependencies
        run: flutter pub get
      
      - name: Build Linux
        run: flutter build linux --release
      
      - name: Archive build
        uses: actions/upload-artifact@v2
        with:
          name: linux-build
          path: build/linux/x64/release/bundle/
```

## Troubleshooting

### Flutter Doctor Issues

```bash
# Run comprehensive check
flutter doctor -v
```

### Build Failures

**GTK not found**:
```bash
sudo apt-get install libgtk-3-dev
```

**Ninja not found**:
```bash
sudo apt-get install ninja-build
```

**CMake errors**:
```bash
# Update CMake
sudo apt-get install --upgrade cmake
```

### Clean Build

If experiencing persistent issues:

```bash
flutter clean
flutter pub get
flutter build linux --release
```

### Cache Issues

```bash
# Clear pub cache
flutter pub cache repair

# Clear build cache
rm -rf build/
rm -rf .dart_tool/
```

## Build Scripts

### Automated Build Script

Create `build.sh`:

```bash
#!/bin/bash
set -e

echo "Building Flutter Flatseal..."

# Clean previous builds
flutter clean

# Get dependencies
flutter pub get

# Run tests
flutter test

# Analyze code
flutter analyze

# Build release
flutter build linux --release

echo "Build complete: build/linux/x64/release/bundle/"
```

Make executable and run:
```bash
chmod +x build.sh
./build.sh
```

## Performance Considerations

### Build Time Optimization

```bash
# Use cached builds
flutter build linux --release --cache-dir=./build-cache

# Parallel builds (adjust based on CPU cores)
flutter build linux --release -j 8
```

### Binary Size

Release builds are typically:
- Linux: ~15-25 MB (uncompressed bundle)

## Next Steps

After building:
1. Test the application thoroughly
2. Run on different Linux distributions
3. Create distribution packages (Snap, Flatpak, AppImage)
4. Set up automated builds in CI/CD

## References

- [Flutter Desktop Support](https://docs.flutter.dev/desktop)
- [Building Linux Applications](https://docs.flutter.dev/platform-integration/linux/building)
- [Flutter Build Modes](https://docs.flutter.dev/testing/build-modes)
- [CMake Documentation](https://cmake.org/documentation/)
