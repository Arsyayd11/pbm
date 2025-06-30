import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pedometer/pedometer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Penghitung Langkah',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StepCounterPage(),
    );
  }
}

class StepCounterPage extends StatefulWidget {
  const StepCounterPage({super.key});

  @override
  State<StepCounterPage> createState() => _StepCounterPageState();
}

class _StepCounterPageState extends State<StepCounterPage> {
  int _stepCount = 0;
  Stream<StepCount>? _stepCountStream;
  bool _isCounting = false;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    PermissionStatus status = await Permission.activityRecognition.status;
    if (status.isGranted) {
      // Sudah diizinkan, langsung bisa pakai sensor
      _startListening();
    }
  }

  void _startListening() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream?.listen(_onStepCount).onError((error) {
      print('Error: $error');
    });
    setState(() {
      _isCounting = true;
    });
  }

  void _onStepCount(StepCount event) {
    setState(() {
      _stepCount = event.steps;
    });
  }

  Future<void> _requestPermissionAndStart() async {
    PermissionStatus status = await Permission.activityRecognition.request();

    if (status.isGranted) {
      _startListening();
    } else if (status.isDenied) {
      _showDeniedDialog();
    }
  }

  void _showDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Izin Ditolak'),
        content: const Text('Aplikasi tidak dapat digunakan tanpa izin aktivitas.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Izin Diperlukan'),
        content: const Text('Aplikasi memerlukan izin untuk mengakses aktivitas kamu.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _requestPermissionAndStart();
            },
            child: const Text('Izinkan'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showDeniedDialog();
            },
            child: const Text('Tolak'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Penghitung Langkah')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Jumlah Langkah:',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              '$_stepCount',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _isCounting ? null : _showPermissionDialog,
              child: const Text('Mulai Hitung Langkah'),
            ),
          ],
        ),
      ),
    );
  }
}
