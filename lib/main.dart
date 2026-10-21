import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/desktop_screen.dart';
import 'services/mac_system.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MacOsSonomaApp());
}

class MacOsSonomaApp extends StatelessWidget {
  const MacOsSonomaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final system = MacSystemState();

    return ListenableBuilder(
      listenable: system,
      builder: (context, _) {
        return MaterialApp(
          title: 'macOS Sonoma Launcher',
          debugShowCheckedModeBanner: false,
          theme: system.isDarkMode ? MacTheme.darkTheme() : MacTheme.lightTheme(),
          home: const MacDesktopScreen(),
        );
      },
    );
  }
}
