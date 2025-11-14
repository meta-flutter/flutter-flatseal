# Contributing to Flutter Flatseal

Thank you for your interest in contributing to Flutter Flatseal! This document provides guidelines and instructions for contributing.

## Code of Conduct

By participating in this project, you agree to maintain a respectful and inclusive environment for everyone.

## How to Contribute

### Reporting Bugs

Before creating bug reports, please check existing issues. When creating a bug report, include:

- **Clear title and description**
- **Steps to reproduce** the issue
- **Expected behavior** vs actual behavior
- **System information**:
  - OS and version
  - Flutter version (`flutter --version`)
  - Flatpak version (`flatpak --version`)
- **Screenshots** if applicable
- **Error messages** or logs

### Suggesting Enhancements

Enhancement suggestions are welcome! Please include:

- **Clear description** of the feature
- **Use case** - why is this useful?
- **Examples** from other applications (if applicable)
- **Implementation ideas** (optional)

### Pull Requests

1. **Fork the repository**
   ```bash
   git clone https://github.com/meta-flutter/flutter-flatseal.git
   cd flutter-flatseal
   ```

2. **Create a feature branch**
   ```bash
   git checkout -b feature/my-new-feature
   ```

3. **Make your changes**
   - Follow the coding style
   - Write clear commit messages
   - Add tests if applicable
   - Update documentation

4. **Test your changes**
   ```bash
   flutter test
   flutter analyze
   flutter build linux --release
   ```

5. **Commit your changes**
   ```bash
   git add .
   git commit -m "Add feature: description"
   ```

6. **Push to your fork**
   ```bash
   git push origin feature/my-new-feature
   ```

7. **Create a Pull Request**
   - Use a clear title
   - Describe your changes
   - Reference related issues
   - Add screenshots for UI changes

## Development Setup

### Prerequisites

```bash
# Install Flutter
# See: https://docs.flutter.dev/get-started/install

# Install dependencies
sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev flatpak

# Clone and setup
git clone https://github.com/meta-flutter/flutter-flatseal.git
cd flutter-flatseal
flutter pub get
```

### Running the App

```bash
# Development mode
flutter run -d linux

# With hot reload enabled
flutter run -d linux --hot
```

### Running Tests

```bash
# All tests
flutter test

# Specific test file
flutter test test/widget_test.dart

# With coverage
flutter test --coverage
```

## Coding Standards

### Dart Style Guide

Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style):

```dart
// Good
class MyClass {
  final String name;
  
  MyClass({required this.name});
  
  void doSomething() {
    // implementation
  }
}

// Use const constructors when possible
const MyWidget({super.key});

// Use trailing commas
MyWidget(
  child: Text('Hello'),
  onTap: () {},
);
```

### Code Formatting

```bash
# Format all Dart files
flutter format lib/

# Check formatting without modifying
flutter format --set-exit-if-changed lib/
```

### Linting

```bash
# Run analyzer
flutter analyze

# Fix auto-fixable issues
dart fix --apply
```

### Widget Naming

- Use descriptive names: `PermissionListItem` not `Item`
- Suffix with widget type: `HomeScreen`, `AppList`, etc.
- Use `State<T>` for stateful widgets: `_HomeScreenState`

### File Organization

```
lib/
├── main.dart           # App entry point
├── models/             # Data models
├── services/           # Business logic
├── screens/            # Full-screen views
├── widgets/            # Reusable components
└── utils/              # Helper functions
```

## Commit Messages

Use clear, descriptive commit messages:

```
# Good
Add permission override functionality
Fix crash when no apps are installed
Update README with build instructions
Refactor FlatpakService to use async/await

# Bad
fix bug
update stuff
wip
```

### Commit Message Format

```
<type>: <subject>

<body>

<footer>
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting)
- `refactor`: Code refactoring
- `test`: Test additions/changes
- `chore`: Build/tooling changes

Example:
```
feat: Add D-Bus permission management

Implement functionality to view and modify D-Bus permissions
for Flatpak applications. Includes both session and system bus
support.

Closes #42
```

## Testing Guidelines

### Unit Tests

```dart
test('FlatpakApp can be created', () {
  final app = FlatpakApp(
    id: 'org.example.App',
    name: 'Example App',
    version: '1.0.0',
    branch: 'stable',
    origin: 'flathub',
  );
  
  expect(app.id, 'org.example.App');
});
```

### Widget Tests

```dart
testWidgets('App list displays apps', (WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: AppList(apps: testApps),
    ),
  );
  
  expect(find.text('Test App'), findsOneWidget);
});
```

### Integration Tests

Place integration tests in `integration_test/`:

```dart
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  testWidgets('Full app flow', (tester) async {
    // Test complete user flow
  });
}
```

## Documentation

### Code Comments

```dart
/// Service to interact with Flatpak command-line tools.
///
/// Provides methods to:
/// - List installed applications
/// - View application permissions
/// - Override permissions
/// - Reset overrides
class FlatpakService extends ChangeNotifier {
  // Implementation
}
```

### README Updates

Update README.md when:
- Adding new features
- Changing requirements
- Modifying build process
- Adding new dependencies

## Pull Request Process

1. **Update documentation** if needed
2. **Add tests** for new functionality
3. **Ensure all tests pass**
4. **Run code analysis** and fix issues
5. **Update CHANGELOG.md** (if applicable)
6. **Request review** from maintainers
7. **Address feedback** promptly

### PR Checklist

- [ ] Code follows project style guidelines
- [ ] Tests added/updated and passing
- [ ] Documentation updated
- [ ] No breaking changes (or documented)
- [ ] Commit messages are clear
- [ ] PR description is complete

## Areas for Contribution

Looking for ways to contribute? Consider:

### High Priority
- [ ] Add D-Bus permission management
- [ ] Implement environment variable overrides
- [ ] Add custom filesystem path support
- [ ] Create integration tests
- [ ] Improve error handling

### Medium Priority
- [ ] Add permission presets/profiles
- [ ] Implement import/export functionality
- [ ] Add search filters
- [ ] Create mobile-responsive layout
- [ ] Add keyboard shortcuts

### Documentation
- [ ] Video tutorials
- [ ] More screenshots
- [ ] Troubleshooting guide
- [ ] Comparison with original Flatseal
- [ ] Flatpak permission guide

### Testing
- [ ] Increase test coverage
- [ ] Add performance tests
- [ ] Test on various distributions
- [ ] Accessibility testing

## Questions?

- Open an issue for questions
- Check existing documentation
- Review closed issues and PRs

## Recognition

Contributors will be acknowledged in:
- CONTRIBUTORS.md file
- Release notes
- Project README

Thank you for contributing to Flutter Flatseal!
