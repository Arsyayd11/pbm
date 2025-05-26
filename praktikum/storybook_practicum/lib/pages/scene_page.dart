// lib/pages/scene_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class InteractiveScenePage extends StatefulWidget {
  final VoidCallback onQuestComplete;
  const InteractiveScenePage({super.key, required this.onQuestComplete,});

  @override
  State<InteractiveScenePage> createState() => _InteractiveScenePageState();
}

class _InteractiveScenePageState extends State<InteractiveScenePage> {
  // Variabel state untuk posisi, dialog, dan status peti
  Offset _keyPosition = const Offset(50, 300);
  bool _isDialogueVisible = false;
  bool _isChestOpen = false;
  String _chestHint = "Terkunci...";

  // Tambahkan variabel state baru
  Offset _backgroundOffset = Offset.zero;

  // GlobalKeys untuk mendapatkan posisi dan ukuran widget
  final GlobalKey _chestKey = GlobalKey();

  // Di build method scene_page.dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InteractiveViewer( // <--- WIDGET DITAMBAHKAN DI SINI
        boundaryMargin: const EdgeInsets.all(double.infinity),
        minScale: 1.0,
        maxScale: 3.0,
        child: Stack(
          children: [
            // ... semua widget di dalam Stack tetap sama seperti sebelumnya ...
            // Latar Belakang
            // Ganti Container latar belakang dengan kode ini:
            Transform.translate(
              offset: _backgroundOffset,
              child: RawGestureDetector(
                gestures: {
                  HorizontalDragGestureRecognizer: GestureRecognizerFactoryWithHandlers<
                      HorizontalDragGestureRecognizer>(
                        () => HorizontalDragGestureRecognizer(),
                        (instance) {
                      instance.onUpdate = (details) {
                        setState(() {
                          // Batasi pergerakan agar tidak terlalu jauh
                          _backgroundOffset += Offset(details.delta.dx, 0);
                        });
                      };
                    },
                  ),
                  VerticalDragGestureRecognizer: GestureRecognizerFactoryWithHandlers<
                      VerticalDragGestureRecognizer>(
                        () => VerticalDragGestureRecognizer(),
                        (instance) {
                      instance.onUpdate = (details) {
                        setState(() {
                          _backgroundOffset += Offset(0, details.delta.dy);
                        });
                      };
                    },
                  ),
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 1.2, // Buat BG lebih besar agar ada ruang gerak
                  height: MediaQuery.of(context).size.height * 1.2,
                  color: const Color(0xff303952),
                  child: const Center(
                    child: Text(
                      "🪐",
                      style: TextStyle(fontSize: 200, color: Colors.white24),
                    ),
                  ),
                ),
              ),
            ),

            // Elemen-elemen adegan akan kita tambahkan di sini

            // Di dalam children dari Stack:
            // Astronaut (Double Tap)
            Positioned(
              bottom: 50,
              left: 60,
              child: GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    _isDialogueVisible = !_isDialogueVisible;
                  });
                },
                child: const Text(
                  "🧑‍🚀", // Menggunakan emoji astronaut yang lebih mudah dilihat
                  style: TextStyle(fontSize: 80),
                ),
              ),
            ),

            // Balon Dialog
            if (_isDialogueVisible)
              Positioned(
                bottom: 140,
                left: 30,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Aku harus buka peti itu!",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),

            // Di dalam children dari Stack:
            // Peti (Long Press)
            Positioned(
              key: _chestKey, // Memberi kunci global pada peti
              bottom: 50,
              right: 50,
              child: GestureDetector(
                onLongPress: () {
                  if (_isChestOpen) return;
                  setState(() {
                    _chestHint = "Sepertinya butuh kunci...";
                  });
                  // Menghilangkan petunjuk setelah beberapa detik
                  Future.delayed(
                      const Duration(seconds: 2), () => setState(() => _chestHint = "Terkunci..."));
                },
                child: Text(
                  _isChestOpen ? "🔓" : "📦",
                  style: const TextStyle(fontSize: 80),
                ),
              ),
            ),

            // Teks Petunjuk Peti
            Positioned(
              bottom: 140,
              right: 20,
              child: Text(
                _chestHint,
                style: const TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
              ),
            ),

            // Di dalam children dari Stack:
            // Kunci (Drag & Drop)
            Positioned(
              left: _keyPosition.dx,
              top: _keyPosition.dy,
              child: GestureDetector(
                onPanUpdate: (details) {
                  if (_isChestOpen) return; // Kunci tidak bisa digerakkan jika peti sudah terbuka
                  setState(() {
                    _keyPosition += details.delta;
                  });
                },
                onPanEnd: (details) {
                  if (_isChestOpen) return;

                  // Cek apakah kunci di-drop di atas peti
                  final RenderBox chestBox = _chestKey.currentContext!.findRenderObject() as RenderBox;
                  final chestPosition = chestBox.localToGlobal(Offset.zero);
                  final chestRect = chestPosition & chestBox.size;

                  if (chestRect.contains(_keyPosition)) {
                    setState(() {
                      _isChestOpen = true;
                      _chestHint = "Terbuka!";
                      // Sembunyikan kunci
                      _keyPosition = const Offset(-100, -100);
                    });
                    // Pindah ke halaman akhir setelah quest selesai
                    Future.delayed(const Duration(seconds: 2), widget.onQuestComplete);
                  }
                },
                child: const Text("🔑", style: TextStyle(fontSize: 50)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Stack(
  //       children: [
  //         // Latar Belakang
  //         // Ganti Container latar belakang dengan kode ini:
  //         Transform.translate(
  //           offset: _backgroundOffset,
  //           child: RawGestureDetector(
  //             gestures: {
  //               HorizontalDragGestureRecognizer: GestureRecognizerFactoryWithHandlers<
  //                   HorizontalDragGestureRecognizer>(
  //                     () => HorizontalDragGestureRecognizer(),
  //                     (instance) {
  //                   instance.onUpdate = (details) {
  //                     setState(() {
  //                       // Batasi pergerakan agar tidak terlalu jauh
  //                       _backgroundOffset += Offset(details.delta.dx, 0);
  //                     });
  //                   };
  //                 },
  //               ),
  //               VerticalDragGestureRecognizer: GestureRecognizerFactoryWithHandlers<
  //                   VerticalDragGestureRecognizer>(
  //                     () => VerticalDragGestureRecognizer(),
  //                     (instance) {
  //                   instance.onUpdate = (details) {
  //                     setState(() {
  //                       _backgroundOffset += Offset(0, details.delta.dy);
  //                     });
  //                   };
  //                 },
  //               ),
  //             },
  //             child: Container(
  //               width: MediaQuery.of(context).size.width * 1.2, // Buat BG lebih besar agar ada ruang gerak
  //               height: MediaQuery.of(context).size.height * 1.2,
  //               color: const Color(0xff303952),
  //               child: const Center(
  //                 child: Text(
  //                   "🪐",
  //                   style: TextStyle(fontSize: 200, color: Colors.white24),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //
  //         // Elemen-elemen adegan akan kita tambahkan di sini
  //
  //         // Di dalam children dari Stack:
  //         // Astronaut (Double Tap)
  //         Positioned(
  //           bottom: 50,
  //           left: 60,
  //           child: GestureDetector(
  //             onDoubleTap: () {
  //               setState(() {
  //                 _isDialogueVisible = !_isDialogueVisible;
  //               });
  //             },
  //             child: const Text(
  //               "🧑‍🚀", // Menggunakan emoji astronaut yang lebih mudah dilihat
  //               style: TextStyle(fontSize: 80),
  //             ),
  //           ),
  //         ),
  //
  //         // Balon Dialog
  //         if (_isDialogueVisible)
  //           Positioned(
  //             bottom: 140,
  //             left: 30,
  //             child: Container(
  //               padding: const EdgeInsets.all(12),
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //               child: const Text(
  //                 "Aku harus buka peti itu!",
  //                 style: TextStyle(color: Colors.black),
  //               ),
  //             ),
  //           ),
  //
  //         // Di dalam children dari Stack:
  //         // Peti (Long Press)
  //         Positioned(
  //           key: _chestKey, // Memberi kunci global pada peti
  //           bottom: 50,
  //           right: 50,
  //           child: GestureDetector(
  //             onLongPress: () {
  //               if (_isChestOpen) return;
  //               setState(() {
  //                 _chestHint = "Sepertinya butuh kunci...";
  //               });
  //               // Menghilangkan petunjuk setelah beberapa detik
  //               Future.delayed(
  //                   const Duration(seconds: 2), () => setState(() => _chestHint = "Terkunci..."));
  //             },
  //             child: Text(
  //               _isChestOpen ? "🔓" : "📦",
  //               style: const TextStyle(fontSize: 80),
  //             ),
  //           ),
  //         ),
  //
  //         // Teks Petunjuk Peti
  //         Positioned(
  //           bottom: 140,
  //           right: 20,
  //           child: Text(
  //             _chestHint,
  //             style: const TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
  //           ),
  //         ),
  //
  //         // Di dalam children dari Stack:
  //         // Kunci (Drag & Drop)
  //         Positioned(
  //           left: _keyPosition.dx,
  //           top: _keyPosition.dy,
  //           child: GestureDetector(
  //             onPanUpdate: (details) {
  //               if (_isChestOpen) return; // Kunci tidak bisa digerakkan jika peti sudah terbuka
  //               setState(() {
  //                 _keyPosition += details.delta;
  //               });
  //             },
  //             onPanEnd: (details) {
  //               if (_isChestOpen) return;
  //
  //               // Cek apakah kunci di-drop di atas peti
  //               final RenderBox chestBox = _chestKey.currentContext!.findRenderObject() as RenderBox;
  //               final chestPosition = chestBox.localToGlobal(Offset.zero);
  //               final chestRect = chestPosition & chestBox.size;
  //
  //               if (chestRect.contains(_keyPosition)) {
  //                 setState(() {
  //                   _isChestOpen = true;
  //                   _chestHint = "Terbuka!";
  //                   // Sembunyikan kunci
  //                   _keyPosition = const Offset(-100, -100);
  //                 });
  //                 // Pindah ke halaman akhir setelah quest selesai
  //                 Future.delayed(const Duration(seconds: 2), widget.onQuestComplete);
  //               }
  //             },
  //             child: const Text("🔑", style: TextStyle(fontSize: 50)),
  //           ),
  //         ),
  //
  //       ],
  //     ),
  //   );
  // }
}