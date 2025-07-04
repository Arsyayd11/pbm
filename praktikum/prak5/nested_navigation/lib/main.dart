import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nested Navigation App',
      theme: ThemeData(
        // Changed primarySwatch to lime
        primarySwatch: Colors.lime,
        // For more specific lime accent usage, you might customize ColorScheme:
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.lime,
          accentColor: Colors.limeAccent, // This will be used for things like FloatingActionButton by default
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

// Layar Utama (HomeScreen)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the App!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SetupFlowScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: const Text('Start Setup Flow'),
            ),
          ],
        ),
      ),
    );
  }
}

// Layar Alur Pengaturan (SetupFlowScreen) dengan Nested Navigator
class SetupFlowScreen extends StatefulWidget {
  const SetupFlowScreen({super.key});

  @override
  State<SetupFlowScreen> createState() => _SetupFlowScreenState();
}

class _SetupFlowScreenState extends State<SetupFlowScreen> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  void _onDeviceFound() {
    _navigatorKey.currentState!.pushNamed('connect_device');
  }

  void _onDeviceConnected() {
    _navigatorKey.currentState!.pushNamed('confirm_device'); // Navigate to the new screen
  }

  void _completeSetup(BuildContext context) {
    Navigator.pop(context); // Kembali ke HomeScreen
  }

  @override
  Widget build(BuildContext context) {
    // This context is the one for SetupFlowScreen itself, used for the final pop
    final parentContext = context;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Setup Flow'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(parentContext), // Use parentContext to pop SetupFlowScreen
        ),
      ),
      body: Navigator(
        key: _navigatorKey,
        initialRoute: 'find_devices',
        onGenerateRoute: (settings) {
          Widget page;
          switch (settings.name) {
            case 'find_devices':
              page = FindDevicesScreen(onDeviceFound: _onDeviceFound);
              break;
            case 'connect_device':
            // Pass _onDeviceConnected to navigate to ConfirmDeviceScreen
              page = ConnectDeviceScreen(onDeviceConnected: _onDeviceConnected);
              break;
            case 'confirm_device': // New case for ConfirmDeviceScreen
              page = ConfirmDeviceScreen(onSetupComplete: () => _completeSetup(parentContext));
              break;
            default:
              page = FindDevicesScreen(onDeviceFound: _onDeviceFound);
          }
          return MaterialPageRoute(builder: (_) => page);
        },
      ),
    );
  }
}

// Layar Pencarian Perangkat (FindDevicesScreen)
class FindDevicesScreen extends StatelessWidget {
  final VoidCallback onDeviceFound;

  const FindDevicesScreen({super.key, required this.onDeviceFound});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Finding Devices...',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onDeviceFound,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              textStyle: const TextStyle(fontSize: 16),
            ),
            child: const Text('Device Found'),
          ),
        ],
      ),
    );
  }
}

// Layar Koneksi Perangkat (ConnectDeviceScreen)
class ConnectDeviceScreen extends StatelessWidget {
  // Changed callback to reflect next step
  final VoidCallback onDeviceConnected;

  const ConnectDeviceScreen({super.key, required this.onDeviceConnected});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Connecting to Device...',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            // Call onDeviceConnected to go to ConfirmDeviceScreen
            onPressed: onDeviceConnected,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              textStyle: const TextStyle(fontSize: 16),
            ),
            // Changed button text
            child: const Text('Device Connected, Next'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Kembali ke FindDevicesScreen
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              textStyle: const TextStyle(fontSize: 16),
            ),
            child: const Text('Back'),
          ),
        ],
      ),
    );
  }
}

// BARU: Layar Konfirmasi Perangkat (ConfirmDeviceScreen)
class ConfirmDeviceScreen extends StatelessWidget {
  final VoidCallback onSetupComplete;

  const ConfirmDeviceScreen({super.key, required this.onSetupComplete});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Confirm Device Details',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text('Is this the correct device and settings?'),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: onSetupComplete, // This will call _completeSetup from SetupFlowScreen
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              textStyle: const TextStyle(fontSize: 16),
            ),
            child: const Text('Confirm & Complete Setup'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Kembali ke ConnectDeviceScreen
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              textStyle: const TextStyle(fontSize: 16),
            ),
            child: const Text('Back'),
          ),
        ],
      ),
    );
  }
}