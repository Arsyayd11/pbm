import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

import 'pages/home.dart';
import 'pages/jadwal.dart';
import 'pages/profil.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;
  int _selectedIndex = 0;

  static const destinations = <NavigationDestination>[
    NavigationDestination(icon: Icon(Icons.domain_verification_rounded), label: 'Beranda'),
    NavigationDestination(icon: Icon(Icons.schedule_rounded), label: 'Jadwal'),
    NavigationDestination(icon: Icon(Icons.person_outline_rounded), label: 'Profil'),
  ];

  final List<Widget> _pages = const [
    HomePage(),
    JadwalPage(),
    AkunPage(),
  ];

  void setTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Update color scheme configuration
    final lightColorScheme = ColorScheme.fromSeed(
      seedColor: Colors.limeAccent,
      brightness: Brightness.light,
    );

    final darkColorScheme = ColorScheme.fromSeed(
      seedColor: Colors.limeAccent,
      brightness: Brightness.dark,
    );

    return MaterialApp(
      title: 'UTS PBM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        appBarTheme: AppBarTheme(
          backgroundColor: lightColorScheme.primaryContainer,
          titleTextStyle: TextStyle(
            color: lightColorScheme.onPrimaryContainer,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        appBarTheme: AppBarTheme(
          backgroundColor: darkColorScheme.primaryContainer,
          titleTextStyle: TextStyle(
            color: darkColorScheme.onPrimaryContainer,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      themeMode: _themeMode,
      home: AdaptiveScaffold(
        useDrawer: false,
        destinations: destinations,
        selectedIndex: _selectedIndex,
        onSelectedIndexChange: (i) => setState(() => _selectedIndex = i),

        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(destinations[_selectedIndex].label),
        ),
        appBarBreakpoint: const WidthPlatformBreakpoint(begin: 0),

        body: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _pages[_selectedIndex]),
            ],
          );
        },
      ),
    );
  }
}