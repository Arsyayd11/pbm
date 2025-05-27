// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// // Kelas untuk merepresentasikan data item
// class Item {
//   final int id;
//   final String name;
//
//   Item({required this.id, required this.name});
// }
//
// // Aplikasi utama
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   // State untuk melacak item yang dipilih
//   Item? _selectedItem;
//
//   // Daftar item contoh
//   final List<Item> _items = [
//     Item(id: 1, name: 'Item 1'),
//     Item(id: 2, name: 'Item 2'),
//     Item(id: 3, name: 'Item 3'),
//   ];
//
//   // Fungsi untuk menangani pemilihan item
//   void _selectItem(Item item) {
//     setState(() {
//       _selectedItem = item;
//     });
//   }
//
//   // Fungsi untuk kembali ke HomeScreen
//   void _clearSelection() {
//     setState(() {
//       _selectedItem = null;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Navigator 2.0 App',
//       theme: ThemeData(
//         primarySwatch: Colors.teal,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//         textTheme: const TextTheme(
//           bodyMedium: TextStyle(fontSize: 16),
//         ),
//       ),
//       home: Navigator(
//         // Daftar pages didefinisikan secara deklaratif
//         pages: [
//           // Selalu tampilkan HomeScreen
//           MaterialPage(
//             key: const ValueKey('HomeScreen'),
//             child: HomeScreen(
//               items: _items,
//               onItemSelected: _selectItem,
//             ),
//           ),
//           // Tampilkan DetailScreen jika ada item yang dipilih
//           if (_selectedItem != null)
//             MaterialPage(
//               key: ValueKey(_selectedItem),
//               child: DetailScreen(
//                 item: _selectedItem!,
//                 onBack: _clearSelection,
//               ),
//             ),
//         ],
//         // Menangani pop (kembali) dari tumpukan navigasi
//         onPopPage: (route, result) {
//           if (!route.didPop(result)) return false;
//           // Bersihkan item yang dipilih saat pop
//           _clearSelection();
//           return true;
//         },
//       ),
//     );
//   }
// }
//
// // Layar Utama (HomeScreen)
// class HomeScreen extends StatelessWidget {
//   final List<Item> items;
//   final Function(Item) onItemSelected;
//
//   const HomeScreen({
//     super.key,
//     required this.items,
//     required this.onItemSelected,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//         centerTitle: true,
//       ),
//       body: ListView.builder(
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           final item = items[index];
//           return ListTile(
//             title: Text(item.name),
//             subtitle: Text('ID: ${item.id}'),
//             onTap: () => onItemSelected(item),
//             trailing: const Icon(Icons.arrow_forward),
//           );
//         },
//       ),
//     );
//   }
// }
//
// // Layar Detail (DetailScreen)
// class DetailScreen extends StatelessWidget {
//   final Item item;
//   final VoidCallback onBack;
//
//   const DetailScreen({
//     super.key,
//     required this.item,
//     required this.onBack,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Detail: ${item.name}'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Item: ${item.name}',
//               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               'ID: ${item.id}',
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: onBack,
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                 textStyle: const TextStyle(fontSize: 16),
//               ),
//               child: const Text('Back to Home'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Kelas untuk merepresentasikan data item
class Item {
  final int id;
  final String name;
  final String description; // <-- Field baru ditambahkan

  Item({required this.id, required this.name, required this.description}); // <-- Constructor diperbarui
}

// Aplikasi utama
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // State untuk melacak item yang dipilih
  Item? _selectedItem;

  // Daftar item contoh
  final List<Item> _items = [
    Item(id: 1, name: 'Item 1', description: 'Ini adalah deskripsi untuk Item 1 yang luar biasa.'), // <-- Deskripsi ditambahkan
    Item(id: 2, name: 'Item 2', description: 'Deskripsi menarik untuk Item 2 ada di sini.'), // <-- Deskripsi ditambahkan
    Item(id: 3, name: 'Item 3', description: 'Item 3 hadir dengan deskripsi yang sangat detail.'), // <-- Deskripsi ditambahkan
  ];

  // Fungsi untuk menangani pemilihan item
  void _selectItem(Item item) {
    setState(() {
      _selectedItem = item;
    });
  }

  // Fungsi untuk kembali ke HomeScreen
  void _clearSelection() {
    setState(() {
      _selectedItem = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigator 2.0 App',
      theme: ThemeData(
          primarySwatch: Colors.lime, // <-- Warna utama diubah menjadi lime
          // Anda juga bisa menggunakan colorScheme untuk kontrol yang lebih detail
          // colorScheme: ColorScheme.fromSwatch(
          //   primarySwatch: Colors.lime,
          //   accentColor: Colors.limeAccent, // <-- Warna aksen
          // ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(fontSize: 16),
          ),
          appBarTheme: AppBarTheme( // Contoh penggunaan limeAccent untuk AppBar jika diinginkan
            backgroundColor: Colors.lime, // Latar belakang AppBar
            foregroundColor: Colors.black, // Warna teks dan ikon di AppBar
            // Jika Anda ingin menggunakan limeAccent secara spesifik di AppBar
            // backgroundColor: Colors.limeAccent,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData( // Contoh kustomisasi ElevatedButton
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.limeAccent, // Latar belakang tombol
                foregroundColor: Colors.black, // Warna teks tombol
              )
          )
      ),
      home: Navigator(
        // Daftar pages didefinisikan secara deklaratif
        pages: [
          // Selalu tampilkan HomeScreen
          MaterialPage(
            key: const ValueKey('HomeScreen'),
            child: HomeScreen(
              items: _items,
              onItemSelected: _selectItem,
            ),
          ),
          // Tampilkan DetailScreen jika ada item yang dipilih
          if (_selectedItem != null)
            MaterialPage(
              key: ValueKey(_selectedItem),
              child: DetailScreen(
                item: _selectedItem!,
                onBack: _clearSelection,
              ),
            ),
        ],
        // Menangani pop (kembali) dari tumpukan navigasi
        onPopPage: (route, result) {
          if (!route.didPop(result)) return false;
          // Bersihkan item yang dipilih saat pop
          _clearSelection();
          return true;
        },
      ),
    );
  }
}

// Layar Utama (HomeScreen)
class HomeScreen extends StatelessWidget {
  final List<Item> items;
  final Function(Item) onItemSelected;

  const HomeScreen({
    super.key,
    required this.items,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text('ID: ${item.id}\nDeskripsi Singkat: ${item.description.substring(0, (item.description.length > 30 ? 30 : item.description.length))}...'), // Menampilkan cuplikan deskripsi
            onTap: () => onItemSelected(item),
            trailing: const Icon(Icons.arrow_forward),
          );
        },
      ),
    );
  }
}

// Layar Detail (DetailScreen)
class DetailScreen extends StatelessWidget {
  final Item item;
  final VoidCallback onBack;

  const DetailScreen({
    super.key,
    required this.item,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail: ${item.name}'),
        centerTitle: true,
        // Anda bisa menggunakan Theme.of(context).colorScheme.secondary untuk limeAccent jika didefinisikan di colorScheme
        // backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: Padding( // Menambahkan Padding untuk tampilan yang lebih baik
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start, // Agar teks rata kiri
            children: [
              Text(
                'Item: ${item.name}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'ID: ${item.id}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text( // <-- Menampilkan deskripsi
                'Deskripsi:',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                item.description,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              Center( // Tombol kembali di tengah
                child: ElevatedButton(
                  onPressed: onBack,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: const TextStyle(fontSize: 16),
                    // backgroundColor: Colors.limeAccent, // Contoh penggunaan limeAccent
                    // foregroundColor: Colors.black87,
                  ),
                  child: const Text('Back to Home'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}