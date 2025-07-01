import 'package:aplikasi_sederhana/page/MapsPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aplikasi_sederhana/page/SmsVerificationPage.dart';
import 'package:aplikasi_sederhana/view/login.dart';
import 'package:aplikasi_sederhana/view/register.dart';
import 'package:aplikasi_sederhana/view/profile.dart';
import 'package:aplikasi_sederhana/page/ListViewPage.dart';
import 'package:aplikasi_sederhana/page/CameraPage.dart';
import 'package:aplikasi_sederhana/page/PreferencesPage.dart';
import 'package:aplikasi_sederhana/page/NetworkPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('darkMode') ?? false;

  runApp(MyApp(initialDarkMode: isDarkMode));
}

class MyApp extends StatefulWidget {
  final bool initialDarkMode;
  const MyApp({super.key, required this.initialDarkMode});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.initialDarkMode;
  }

  void _toggleTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', value);
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Tugas Harian',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/sms': (context) => const SmsVerificationPage(),
        '/profile': (context) => const ProfilePage(),
        '/listview': (context) => const ListViewPage(),
        '/camera': (context) => const CameraPage(),
        '/preferences':
            (context) => PreferencesPage(
              isDarkMode: _isDarkMode,
              onToggleTheme: _toggleTheme,
            ),
        '/maps': (context) => const MapsPage(),
        '/network': (context) => const NetworkPage(),
      },
    );
  }
}
