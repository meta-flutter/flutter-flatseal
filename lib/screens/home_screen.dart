import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_flatseal/services/flatpak_service.dart';
import 'package:flutter_flatseal/widgets/app_list.dart';
import 'package:flutter_flatseal/widgets/permission_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load apps on startup
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FlatpakService>().loadApps();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Flatseal'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<FlatpakService>().loadApps();
            },
            tooltip: 'Refresh app list',
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              _showAboutDialog(context);
            },
            tooltip: 'About',
          ),
        ],
      ),
      body: Consumer<FlatpakService>(
        builder: (context, service, child) {
          if (service.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading Flatpak applications...'),
                ],
              ),
            );
          }

          if (service.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${service.error}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      service.loadApps();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (service.apps.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.apps,
                    size: 48,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No Flatpak applications found',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Install some Flatpak apps to get started',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }

          return Row(
            children: [
              // App list on the left
              SizedBox(
                width: 300,
                child: AppList(apps: service.apps),
              ),
              const VerticalDivider(width: 1),
              // Permission details on the right
              Expanded(
                child: service.selectedApp != null
                    ? PermissionDetails(app: service.selectedApp!)
                    : const Center(
                        child: Text(
                          'Select an app to view its permissions',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Flutter Flatseal',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(Icons.security, size: 48),
      children: [
        const Text(
          'A Flutter application to manage Flatpak sandbox permissions, '
          'inspired by the original Flatseal project.',
        ),
        const SizedBox(height: 16),
        const Text(
          'Features:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const Text('• View installed Flatpak applications'),
        const Text('• Manage application permissions'),
        const Text('• Override sandbox settings'),
        const Text('• Reset permission overrides'),
      ],
    );
  }
}
