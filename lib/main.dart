import 'package:flutter/material.dart';

const Color lightThemeTextColor = Colors.black87;
const Color darkThemeTextColor = Colors.white70;

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontSize: 32, fontWeight: FontWeight.bold, color: lightThemeTextColor),
    headlineMedium: TextStyle(
        fontSize: 24, color: lightThemeTextColor), // Keep the headlineMedium
    bodyLarge: TextStyle(fontSize: 18, color: lightThemeTextColor),
    bodyMedium: TextStyle(fontSize: 16, color: lightThemeTextColor),
    bodySmall: TextStyle(fontSize: 14, color: lightThemeTextColor),
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.blue, // Background color for the AppBar in light mode
    titleTextStyle: TextStyle(
      color: Colors.white, // AppBar title text color for light mode
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.white), // Icon color
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    foregroundColor: Colors.grey,
    backgroundColor: Colors.black,
    textStyle: const TextStyle(),
  )),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  scaffoldBackgroundColor: Colors.white,
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontSize: 32, fontWeight: FontWeight.bold, color: darkThemeTextColor),
    headlineMedium: TextStyle(
        fontSize: 38,
        color: darkThemeTextColor), // Keep the headlineMedium for dark mode
    bodyLarge: TextStyle(fontSize: 18, color: darkThemeTextColor),
    bodyMedium: TextStyle(fontSize: 16, color: darkThemeTextColor),
    bodySmall: TextStyle(fontSize: 14, color: darkThemeTextColor),
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.red, // Background color for dark mode AppBar
    titleTextStyle: TextStyle(
      color: Colors.white, // AppBar title text color for dark mode
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.white), // Icon color
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.yellow,
      backgroundColor: Colors.red,
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.red)
      .copyWith(brightness: Brightness.dark),
  scaffoldBackgroundColor: Colors.black,
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  IconData get _themeModeIcon {
    switch (_themeMode) {
      case ThemeMode.light:
        return Icons.brightness_low;
      case ThemeMode.dark:
        return Icons.brightness_2;
      case ThemeMode.system:
      default:
        return Icons.brightness_auto;
    }
  }

  void _toggleThemeMode() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : _themeMode == ThemeMode.dark
              ? ThemeMode.system
              : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Theme Toggler'),
          actions: [
            IconButton(
              icon: const Icon(Icons.brightness_6),
              onPressed: _toggleThemeMode,
            ),
          ],
        ),
        body: Center(
          child: MyWidget(
            themeMode: _themeMode,
            themeModeIcon: _themeModeIcon,
            onButtonTap: _toggleThemeMode,
          ),
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  final ThemeMode themeMode;
  final IconData themeModeIcon;
  final void Function() onButtonTap;

  const MyWidget({
    required this.themeMode,
    required this.themeModeIcon,
    super.key,
    required this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Hello, World!',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 20),
        Text('Current Theme Mode: ${themeMode.toString().split('.').last}',
            style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 10),
        Icon(themeModeIcon, size: 48),
        const SizedBox(height: 20),
        ElevatedButton(
            onPressed: onButtonTap, child: const Text("Switch Mode")),
      ],
    );
  }
}
