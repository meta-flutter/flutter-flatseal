import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_flatseal/models/flatpak_app.dart';

/// Service to interact with Flatpak command-line tools
class FlatpakService extends ChangeNotifier {
  List<FlatpakApp> _apps = [];
  bool _isLoading = false;
  String? _error;
  FlatpakApp? _selectedApp;

  List<FlatpakApp> get apps => _apps;
  bool get isLoading => _isLoading;
  String? get error => _error;
  FlatpakApp? get selectedApp => _selectedApp;

  /// Check if Flatpak is installed on the system
  Future<bool> isFlatpakInstalled() async {
    try {
      final result = await Process.run('which', ['flatpak']);
      return result.exitCode == 0;
    } catch (e) {
      return false;
    }
  }

  /// Load all installed Flatpak applications
  Future<void> loadApps() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      if (!await isFlatpakInstalled()) {
        throw Exception('Flatpak is not installed on this system');
      }

      final result = await Process.run(
        'flatpak',
        ['list', '--app', '--columns=application,name,version,branch,origin'],
      );

      if (result.exitCode != 0) {
        throw Exception('Failed to list Flatpak apps: ${result.stderr}');
      }

      _apps = _parseFlatpakList(result.stdout.toString());
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Parse flatpak list output
  List<FlatpakApp> _parseFlatpakList(String output) {
    final apps = <FlatpakApp>[];
    final lines = output.trim().split('\n');

    for (final line in lines) {
      if (line.isEmpty) continue;

      final parts = line.split('\t');
      if (parts.length >= 5) {
        apps.add(
          FlatpakApp(
            id: parts[0].trim(),
            name: parts[1].trim().isEmpty ? parts[0].trim() : parts[1].trim(),
            version: parts[2].trim(),
            branch: parts[3].trim(),
            origin: parts[4].trim(),
          ),
        );
      }
    }

    return apps;
  }

  /// Select an app to view/edit its permissions
  Future<void> selectApp(FlatpakApp app) async {
    _selectedApp = app;
    await loadAppPermissions(app);
    notifyListeners();
  }

  /// Load permissions for a specific app
  Future<void> loadAppPermissions(FlatpakApp app) async {
    try {
      final result = await Process.run(
        'flatpak',
        ['info', '--show-permissions', app.id],
      );

      if (result.exitCode == 0) {
        final permissions = _parsePermissions(result.stdout.toString());
        _selectedApp = app.copyWith(permissions: permissions);
        notifyListeners();
      }
    } catch (e) {
      _error = 'Failed to load permissions: $e';
      notifyListeners();
    }
  }

  /// Parse permissions from flatpak info output
  Map<String, dynamic> _parsePermissions(String output) {
    final permissions = <String, dynamic>{};
    final lines = output.split('\n');
    String? currentCategory;

    for (final line in lines) {
      if (line.isEmpty) continue;

      if (line.startsWith('[')) {
        // Category header
        currentCategory = line.replaceAll('[', '').replaceAll(']', '').trim();
        permissions[currentCategory] = <String>[];
      } else if (currentCategory != null && line.trim().isNotEmpty) {
        // Permission entry
        final permission = line.trim();
        if (permissions[currentCategory] is List) {
          (permissions[currentCategory] as List).add(permission);
        }
      }
    }

    return permissions;
  }

  /// Override a permission for an app
  Future<bool> overridePermission(
    String appId,
    String category,
    String permission,
    bool enable,
  ) async {
    try {
      final action = enable ? '--$category=$permission' : '--no$category=$permission';
      final result = await Process.run(
        'flatpak',
        ['override', appId, action],
      );

      if (result.exitCode == 0) {
        // Reload permissions to reflect changes
        if (_selectedApp?.id == appId) {
          await loadAppPermissions(_selectedApp!);
        }
        return true;
      } else {
        _error = 'Failed to override permission: ${result.stderr}';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = 'Failed to override permission: $e';
      notifyListeners();
      return false;
    }
  }

  /// Reset all overrides for an app
  Future<bool> resetOverrides(String appId) async {
    try {
      final result = await Process.run(
        'flatpak',
        ['override', '--reset', appId],
      );

      if (result.exitCode == 0) {
        // Reload permissions
        if (_selectedApp?.id == appId) {
          await loadAppPermissions(_selectedApp!);
        }
        return true;
      } else {
        _error = 'Failed to reset overrides: ${result.stderr}';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = 'Failed to reset overrides: $e';
      notifyListeners();
      return false;
    }
  }

  /// Get current overrides for an app
  Future<Map<String, dynamic>> getOverrides(String appId) async {
    try {
      final result = await Process.run(
        'flatpak',
        ['override', '--show', appId],
      );

      if (result.exitCode == 0) {
        return _parsePermissions(result.stdout.toString());
      }
      return {};
    } catch (e) {
      return {};
    }
  }
}
