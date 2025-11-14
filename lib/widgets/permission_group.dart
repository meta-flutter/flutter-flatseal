import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_flatseal/models/flatpak_app.dart';
import 'package:flutter_flatseal/models/permission.dart';
import 'package:flutter_flatseal/services/flatpak_service.dart';

class PermissionGroup extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Permission> permissions;
  final FlatpakApp app;

  const PermissionGroup({
    super.key,
    required this.title,
    required this.icon,
    required this.permissions,
    required this.app,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        initiallyExpanded: true,
        children: permissions.map((permission) {
          return PermissionItem(
            permission: permission,
            app: app,
          );
        }).toList(),
      ),
    );
  }
}

class PermissionItem extends StatelessWidget {
  final Permission permission;
  final FlatpakApp app;

  const PermissionItem({
    super.key,
    required this.permission,
    required this.app,
  });

  @override
  Widget build(BuildContext context) {
    // Check if this permission is currently enabled
    final isEnabled = _isPermissionEnabled(app, permission);

    return ListTile(
      title: Text(permission.displayName),
      subtitle: permission.description != null
          ? Text(
              permission.description!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            )
          : null,
      trailing: Switch(
        value: isEnabled,
        onChanged: (value) async {
          final service = context.read<FlatpakService>();
          final success = await service.overridePermission(
            app.id,
            permission.category,
            permission.key,
            value,
          );

          if (context.mounted) {
            if (!success) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to update permission: ${service.error}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
      ),
    );
  }

  bool _isPermissionEnabled(FlatpakApp app, Permission permission) {
    // Check if permission is in app's permissions map
    final category = app.permissions[permission.category];
    if (category != null && category is List) {
      return category.contains(permission.key);
    }
    return false;
  }
}
