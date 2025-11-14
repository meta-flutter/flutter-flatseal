# Changelog

All notable changes to Flutter Flatseal will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned
- D-Bus permission management
- Environment variable overrides
- Custom filesystem path support
- Import/Export permission profiles
- Undo/Redo functionality
- Snap/Flatpak/AppImage packaging

## [1.0.0] - 2024-11-14

### Added
- Initial release of Flutter Flatseal
- List all installed Flatpak applications
- Search and filter applications
- View application permissions by category:
  - Filesystem access (home, host, XDG directories)
  - Device access (all, DRI, KVM)
  - Sockets (X11, Wayland, PulseAudio, D-Bus, etc.)
  - Features (network, development, Bluetooth, etc.)
- Toggle individual permissions on/off
- Reset all overrides to defaults
- Material Design 3 UI with dark/light theme support
- Two-pane responsive layout
- Real-time permission updates
- Error handling and loading states
- Linux desktop support with GTK3 integration
- Comprehensive documentation:
  - README with features and usage
  - BUILDING guide for all platforms
  - PACKAGING guide for distributions
  - CONTRIBUTING guidelines
  - ARCHITECTURE documentation
  - QUICKSTART guide
- Unit tests for models
- GitHub Actions CI/CD workflow
- Code analysis and linting configuration

### Technical Details
- Flutter SDK 3.0+ support
- Provider state management
- Process-based Flatpak CLI integration
- CMake build system for Linux
- Material Design 3 theming
- Proper error handling
- Async/await operations

### Dependencies
- flutter: SDK
- provider: ^6.1.1 (state management)
- process_run: ^0.14.2 (command execution)
- shared_preferences: ^2.2.2 (settings)
- cupertino_icons: ^1.0.6 (icons)
- flutter_lints: ^3.0.1 (linting)

### Platform Support
- **Linux Desktop**: Full support (GTK3)
- **macOS**: Experimental
- **Windows**: Not supported (no Flatpak)
- **Web**: Not supported (requires system access)

### Known Limitations
- D-Bus permissions not yet manageable
- Environment variables not supported
- Custom filesystem paths require manual editing
- No profile import/export
- No undo functionality

### Documentation
- Complete README with installation and usage
- Detailed building instructions for multiple platforms
- Packaging guides for Snap, Flatpak, AppImage, DEB, RPM, AUR
- Contributing guidelines with coding standards
- Architecture documentation with diagrams
- Quick start guide for new users

## Release Notes

### Version 1.0.0 - Initial Release

Flutter Flatseal brings Flatpak permission management to Flutter! This initial release provides core functionality to view and manage sandbox permissions for installed Flatpak applications.

#### Highlights

**Core Features:**
- Browse all installed Flatpak applications
- View detailed permissions grouped by category
- Toggle permissions with simple switches
- Reset overrides to restore defaults
- Search and filter applications

**User Experience:**
- Modern Material Design 3 interface
- Automatic dark/light theme
- Responsive two-pane layout
- Real-time updates
- Clear error messages

**Developer Experience:**
- Clean architecture with separation of concerns
- Comprehensive documentation
- Unit tests included
- CI/CD pipeline configured
- Easy to build and extend

#### Getting Started

```bash
# Install dependencies
flutter pub get

# Run on Linux
flutter run -d linux

# Build release
flutter build linux --release
```

See [QUICKSTART.md](QUICKSTART.md) for detailed instructions.

#### Comparison with Original Flatseal

Flutter Flatseal aims to provide similar functionality to the original Flatseal project while leveraging Flutter's cross-platform capabilities:

**Advantages:**
- Cross-platform potential
- Modern Material Design UI
- Easy to extend with Flutter widgets
- Hot reload for fast development

**Original Flatseal Advantages:**
- More mature and battle-tested
- Native GTK integration
- Broader feature set (D-Bus, environment variables)
- Better desktop integration

#### Roadmap

Future versions will include:
- Advanced permission types (D-Bus, environment)
- Permission profiles and presets
- Import/Export functionality
- Batch operations
- Undo/Redo
- Enhanced search and filtering

#### Contributing

We welcome contributions! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

#### Support

- Report bugs: [GitHub Issues](https://github.com/meta-flutter/flutter-flatseal/issues)
- Ask questions: [GitHub Discussions](https://github.com/meta-flutter/flutter-flatseal/discussions)
- Documentation: [README.md](README.md)

#### Acknowledgments

- Original [Flatseal](https://github.com/tchx84/Flatseal) by Martin Abente Lahaye
- Flutter team for the excellent framework
- Flatpak community

#### License

Flutter Flatseal is released under the MIT License. See [LICENSE](LICENSE) for details.

---

## Version History

- **1.0.0** (2024-11-14) - Initial release

---

## Upgrade Notes

### From Nothing to 1.0.0

This is the initial release. Just follow the installation instructions in the README.

---

## Breaking Changes

None - this is the first release.

---

## Deprecations

None - this is the first release.

---

## Security

### Reporting Security Issues

Please report security vulnerabilities to the project maintainers via GitHub Security Advisories or by opening a private issue.

### Security Considerations

- All Flatpak commands are executed with explicit argument lists (no shell injection)
- Permission changes require explicit user action
- No automatic or silent permission modifications
- Error messages sanitized to avoid information disclosure

---

## Migration Guide

N/A - First release

---

## FAQ

### Why Flutter instead of GTK?

Flutter provides:
- Cross-platform potential
- Modern UI framework
- Fast development with hot reload
- Large ecosystem of packages

### Will this replace the original Flatseal?

No, this is an alternative implementation. The original Flatseal remains the primary, more mature option. Flutter Flatseal is for those who prefer Flutter or need cross-platform capabilities.

### Can I contribute?

Yes! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

---

**Note**: This changelog follows [Keep a Changelog](https://keepachangelog.com/) conventions.
