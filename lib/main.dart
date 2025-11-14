import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'services/flatpak_service.dart';

void main() {
  runApp(const FlatsealApp());
}

class FlatsealApp extends StatelessWidget {
  const FlatsealApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FlatpakService(),
      child: MaterialApp(
        title: 'Flutter Flatseal',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: ThemeMode.system,
        home: const HomeScreen(),
      ),
    );
  }
}
