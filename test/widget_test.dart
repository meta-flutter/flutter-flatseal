import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_flatseal/main.dart';
import 'package:flutter_flatseal/models/flatpak_app.dart';
import 'package:flutter_flatseal/models/permission.dart';

void main() {
  group('FlatsealApp', () {
    testWidgets('App launches successfully', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(const FlatsealApp());
        expect(find.text('Flutter Flatseal'), findsOneWidget);
        
        // Pump a frame to trigger the post-frame callback
        await tester.pump();
        
        // Allow some time for async operations to complete
        await Future.delayed(const Duration(milliseconds: 100));
        
        // Pump again to process any state changes
        await tester.pump();
      });
    });
  });

  group('FlatpakApp Model', () {
    test('FlatpakApp can be created', () {
      final app = FlatpakApp(
        id: 'org.example.TestApp',
        name: 'Test App',
        version: '1.0.0',
        branch: 'stable',
        origin: 'flathub',
      );

      expect(app.id, 'org.example.TestApp');
      expect(app.name, 'Test App');
      expect(app.version, '1.0.0');
      expect(app.branch, 'stable');
      expect(app.origin, 'flathub');
    });

    test('FlatpakApp can be copied with modifications', () {
      final app = FlatpakApp(
        id: 'org.example.TestApp',
        name: 'Test App',
        version: '1.0.0',
        branch: 'stable',
        origin: 'flathub',
      );

      final updatedApp = app.copyWith(version: '2.0.0');

      expect(updatedApp.id, app.id);
      expect(updatedApp.version, '2.0.0');
      expect(updatedApp.branch, app.branch);
    });

    test('FlatpakApp can be created from info map', () {
      final info = {
        'id': 'org.example.TestApp',
        'name': 'Test App',
        'version': '1.0.0',
        'branch': 'stable',
        'origin': 'flathub',
      };

      final app = FlatpakApp.fromFlatpakInfo(info);

      expect(app.id, 'org.example.TestApp');
      expect(app.name, 'Test App');
    });
  });

  group('Permission Model', () {
    test('Permission can be created', () {
      final permission = Permission(
        category: 'filesystems',
        key: 'home',
        displayName: 'Home Directory',
        description: 'Access to home directory',
        type: PermissionType.filesystem,
        enabled: true,
      );

      expect(permission.category, 'filesystems');
      expect(permission.key, 'home');
      expect(permission.displayName, 'Home Directory');
      expect(permission.enabled, true);
    });

    test('Permission can be copied with modifications', () {
      final permission = Permission(
        category: 'filesystems',
        key: 'home',
        displayName: 'Home Directory',
        type: PermissionType.filesystem,
        enabled: false,
      );

      final updated = permission.copyWith(enabled: true);

      expect(updated.enabled, true);
      expect(updated.key, permission.key);
    });

    test('Default permissions are defined', () {
      final permissions = FlatpakPermissions.getDefaultPermissions();

      expect(permissions.isNotEmpty, true);
      expect(
        permissions.any((p) => p.category == 'filesystems'),
        true,
      );
      expect(
        permissions.any((p) => p.category == 'devices'),
        true,
      );
      expect(
        permissions.any((p) => p.category == 'sockets'),
        true,
      );
    });

    test('Filesystem permissions include common directories', () {
      final permissions = FlatpakPermissions.getDefaultPermissions();
      final filesystemPerms = permissions
          .where((p) => p.category == 'filesystems')
          .map((p) => p.key)
          .toList();

      expect(filesystemPerms.contains('home'), true);
      expect(filesystemPerms.contains('xdg-download'), true);
      expect(filesystemPerms.contains('xdg-documents'), true);
    });
  });

  group('Permission Types', () {
    test('All permission types are defined', () {
      expect(PermissionType.boolean, isNotNull);
      expect(PermissionType.filesystem, isNotNull);
      expect(PermissionType.device, isNotNull);
      expect(PermissionType.feature, isNotNull);
      expect(PermissionType.socket, isNotNull);
      expect(PermissionType.environment, isNotNull);
      expect(PermissionType.dbus, isNotNull);
      expect(PermissionType.custom, isNotNull);
    });
  });
}
