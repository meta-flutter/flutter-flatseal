import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_flatseal/models/flatpak_app.dart';
import 'package:flutter_flatseal/models/permission.dart';
import 'package:flutter_flatseal/services/flatpak_service.dart';
import 'package:flutter_flatseal/widgets/permission_group.dart';

class PermissionDetails extends StatelessWidget {
  final FlatpakApp app;

  const PermissionDetails({super.key, required this.app});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // App header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
          child: Row(
            children: [
              const Icon(Icons.apps, size: 48),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      app.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      app.id,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Version: ${app.version} • Branch: ${app.branch}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  context.read<FlatpakService>().loadAppPermissions(app);
                },
                tooltip: 'Reload permissions',
              ),
              IconButton(
                icon: const Icon(Icons.restore),
                onPressed: () {
                  _showResetDialog(context, app);
                },
                tooltip: 'Reset all overrides',
              ),
            ],
          ),
        ),
        // Permissions list
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PermissionGroup(
                  title: 'Filesystem Access',
                  icon: Icons.folder,
                  permissions: FlatpakPermissions.getDefaultPermissions()
                      .where((p) => p.category == 'filesystems')
                      .toList(),
                  app: app,
                ),
                const SizedBox(height: 16),
                PermissionGroup(
                  title: 'Device Access',
                  icon: Icons.devices,
                  permissions: FlatpakPermissions.getDefaultPermissions()
                      .where((p) => p.category == 'devices')
                      .toList(),
                  app: app,
                ),
                const SizedBox(height: 16),
                PermissionGroup(
                  title: 'Sockets',
                  icon: Icons.cable,
                  permissions: FlatpakPermissions.getDefaultPermissions()
                      .where((p) => p.category == 'sockets')
                      .toList(),
                  app: app,
                ),
                const SizedBox(height: 16),
                PermissionGroup(
                  title: 'Features',
                  icon: Icons.settings,
                  permissions: FlatpakPermissions.getDefaultPermissions()
                      .where(
                        (p) => p.category == 'features' && p.key != 'network',
                      )
                      .toList(),
                  app: app,
                ),
                const SizedBox(height: 16),
                PermissionGroup(
                  title: 'Network',
                  icon: Icons.wifi,
                  permissions: FlatpakPermissions.getDefaultPermissions()
                      .where(
                        (p) => p.category == 'features' && p.key == 'network',
                      )
                      .toList(),
                  app: app,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showResetDialog(BuildContext context, FlatpakApp app) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Reset Overrides'),
          content: Text(
            'Are you sure you want to reset all permission overrides for ${app.name}? '
            'This will restore the default permissions.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                final service = context.read<FlatpakService>();
                final success = await service.resetOverrides(app.id);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        success
                            ? 'Overrides reset successfully'
                            : 'Failed to reset overrides',
                      ),
                    ),
                  );
                }
              },
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );
  }
}
