import 'Settings.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'AboutPage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool notification = false;
  bool isDarkMode = false;

  void updateTheme(bool val) {
    setState(() {
      isDarkMode = val;
    });
  }

  void updateNotification(bool val) {
    setState(() {
      notification = val;
    });
  }

  void resetDefault() {
    setState(() {
      isDarkMode = false;
      notification = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Battery Life Predictor',
      debugShowCheckedModeBanner: false,

      initialRoute: '/',

      routes: {
        '/': (context) => Home(),

        '/settings': (context) => Settings(
          isDarkMode: isDarkMode,
          onThemeChanged: updateTheme,
          notification: notification,
          onNotificationChange: updateNotification,
          resetDefaults: resetDefault,
        ),

        '/about': (context) => const AboutPage(),
      },

      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
