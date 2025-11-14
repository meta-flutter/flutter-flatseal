import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/flatpak_app.dart';
import '../services/flatpak_service.dart';

class AppList extends StatefulWidget {
  final List<FlatpakApp> apps;

  const AppList({super.key, required this.apps});

  @override
  State<AppList> createState() => _AppListState();
}

class _AppListState extends State<AppList> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredApps = widget.apps.where((app) {
      return app.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          app.id.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Search applications...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
        ),
        Expanded(
          child: filteredApps.isEmpty
              ? const Center(
                  child: Text('No apps found'),
                )
              : ListView.builder(
                  itemCount: filteredApps.length,
                  itemBuilder: (context, index) {
                    return AppListItem(app: filteredApps[index]);
                  },
                ),
        ),
      ],
    );
  }
}

class AppListItem extends StatelessWidget {
  final FlatpakApp app;

  const AppListItem({super.key, required this.app});

  @override
  Widget build(BuildContext context) {
    final service = context.watch<FlatpakService>();
    final isSelected = service.selectedApp?.id == app.id;

    return ListTile(
      leading: const Icon(Icons.apps),
      title: Text(
        app.name,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        app.id,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
      ),
      selected: isSelected,
      selectedTileColor: Theme.of(context).colorScheme.primaryContainer,
      onTap: () {
        service.selectApp(app);
      },
    );
  }
}
