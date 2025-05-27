// import 'package:flutter/material.dart';
//
// // Kelas untuk merepresentasikan data item
// class Item {
//   final int id;
//   final String name;
//
//   Item({required this.id, required this.name});
// }
//
// // Kelas untuk parsing informasi rute
// class AppRouteInformationParser extends RouteInformationParser<RoutePath> {
//   @override
//   Future<RoutePath> parseRouteInformation(RouteInformation routeInformation) async {
//     // Menggunakan routeInformation.uri untuk mendapatkan Uri
//     final uri = routeInformation.uri;
//
//     // Menangani rute root (/)
//     if (uri.pathSegments.isEmpty) {
//       return RoutePath.home();
//     }
//
//     // Menangani rute /detail/:id
//     if (uri.pathSegments.length == 2 && uri.pathSegments[0] == 'detail') {
//       final id = int.tryParse(uri.pathSegments[1]);
//       if (id != null) {
//         return RoutePath.detail(id);
//       }
//     }
//
//     // Kembali ke home jika rute tidak dikenali
//     return RoutePath.home();
//   }
//
//   @override
//   RouteInformation restoreRouteInformation(RoutePath path) {
//     if (path.isHome) {
//       return RouteInformation(uri: Uri.parse('/'));
//     }
//     if (path.isDetail) {
//       return RouteInformation(uri: Uri.parse('/detail/${path.id}'));
//     }
//     return RouteInformation(uri: Uri.parse('/'));
//   }
// }
//
// // Kelas untuk konfigurasi rute
// class RoutePath {
//   final bool isHome;
//   final int? id;
//
//   RoutePath.home()
//       : isHome = true,
//         id = null;
//
//   RoutePath.detail(this.id) : isHome = false;
//
//   bool get isDetail => !isHome;
// }
//
// // Kelas untuk router delegate
// class AppRouterDelegate extends RouterDelegate<RoutePath>
//     with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
//   @override
//   final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//
//   int? _selectedItemId;
//   final List<Item> _items = [
//     Item(id: 1, name: 'Item 1'),
//     Item(id: 2, name: 'Item 2'),
//     Item(id: 3, name: 'Item 3'),
//   ];
//
//   // Mengatur item yang dipilih
//   void selectItem(int id) {
//     _selectedItemId = id;
//     notifyListeners();
//   }
//
//   // Kembali ke home
//   void goHome() {
//     _selectedItemId = null;
//     notifyListeners();
//   }
//
//   @override
//   RoutePath get currentConfiguration {
//     if (_selectedItemId == null) {
//       return RoutePath.home();
//     }
//     return RoutePath.detail(_selectedItemId);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Navigator(
//       key: navigatorKey,
//       pages: [
//         // Selalu tampilkan HomeScreen
//         MaterialPage(
//           key: const ValueKey('HomeScreen'),
//           child: HomeScreen(
//             items: _items,
//             onItemSelected: selectItem,
//           ),
//         ),
//         // Tampilkan DetailScreen jika ada item yang dipilih
//         if (_selectedItemId != null)
//           MaterialPage(
//             key: ValueKey('DetailScreen-$_selectedItemId'),
//             child: DetailScreen(
//               item: _items.firstWhere((item) => item.id == _selectedItemId),
//               onBack: goHome,
//             ),
//           ),
//       ],
//       onPopPage: (route, result) {
//         if (!route.didPop(result)) return false;
//         goHome();
//         return true;
//       },
//     );
//   }
//
//   @override
//   Future<void> setNewRoutePath(RoutePath path) async {
//     if (path.isHome) {
//       _selectedItemId = null;
//     } else if (path.isDetail && path.id != null) {
//       _selectedItemId = path.id;
//     }
//   }
// }
//
// // Aplikasi utama
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       title: 'Deep Linking App',
//       theme: ThemeData(
//         primarySwatch: Colors.teal,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//         textTheme: const TextTheme(
//           bodyMedium: TextStyle(fontSize: 16),
//         ),
//       ),
//       routerDelegate: AppRouterDelegate(),
//       routeInformationParser: AppRouteInformationParser(),
//     );
//   }
// }
//
// // Layar Utama (HomeScreen)
// class HomeScreen extends StatelessWidget {
//   final List<Item> items;
//   final Function(int) onItemSelected;
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
//             onTap: () => onItemSelected(item.id),
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
//

import 'package:flutter/material.dart';

// Kelas untuk merepresentasikan data item
class Item {
  final int id;
  final String name;

  Item({required this.id, required this.name});
}

// Kelas untuk konfigurasi rute
enum AppScreen { home, detail, settings }

class RoutePath {
  final AppScreen screen;
  final int? id; // Hanya relevan untuk detail

  RoutePath.home()
      : screen = AppScreen.home,
        id = null;

  RoutePath.detail(this.id) : screen = AppScreen.detail;

  RoutePath.settings()
      : screen = AppScreen.settings,
        id = null;

  bool get isHome => screen == AppScreen.home;
  bool get isDetail => screen == AppScreen.detail;
  bool get isSettings => screen == AppScreen.settings;
}

// Kelas untuk parsing informasi rute
class AppRouteInformationParser extends RouteInformationParser<RoutePath> {
  @override
  Future<RoutePath> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = routeInformation.uri;

    // Menangani rute root (/)
    if (uri.pathSegments.isEmpty) {
      return RoutePath.home();
    }

    // Menangani rute /settings
    if (uri.pathSegments.length == 1 && uri.pathSegments[0] == 'settings') {
      return RoutePath.settings();
    }

    // Menangani rute /detail/:id
    if (uri.pathSegments.length == 2 && uri.pathSegments[0] == 'detail') {
      final id = int.tryParse(uri.pathSegments[1]);
      if (id != null) {
        return RoutePath.detail(id);
      }
    }

    // Kembali ke home jika rute tidak dikenali
    return RoutePath.home();
  }

  @override
  RouteInformation restoreRouteInformation(RoutePath path) {
    if (path.isHome) {
      return RouteInformation(uri: Uri.parse('/'));
    }
    if (path.isDetail && path.id != null) {
      return RouteInformation(uri: Uri.parse('/detail/${path.id}'));
    }
    if (path.isSettings) {
      return RouteInformation(uri: Uri.parse('/settings'));
    }
    // Default jika path tidak dikenali (seharusnya tidak terjadi jika path valid)
    return RouteInformation(uri: Uri.parse('/'));
  }
}

// Kelas untuk router delegate
class AppRouterDelegate extends RouterDelegate<RoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  RoutePath _currentPath = RoutePath.home();

  final List<Item> _items = [
    Item(id: 1, name: 'Item 1'),
    Item(id: 2, name: 'Item 2'),
    Item(id: 3, name: 'Item 3'),
  ];

  // Mengatur item yang dipilih (navigasi ke detail)
  void selectItem(int id) {
    _currentPath = RoutePath.detail(id);
    notifyListeners();
  }

  // Kembali ke home
  void goHome() {
    _currentPath = RoutePath.home();
    notifyListeners();
  }

  // Navigasi ke settings
  void goToSettings() {
    _currentPath = RoutePath.settings();
    notifyListeners();
  }

  @override
  RoutePath get currentConfiguration => _currentPath;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        // Selalu tampilkan HomeScreen sebagai dasar
        MaterialPage(
          key: const ValueKey('HomeScreen'),
          child: HomeScreen(
            items: _items,
            onItemSelected: selectItem,
            onGoToSettings: goToSettings, // Tambahkan callback untuk ke Settings
          ),
        ),
        // Tampilkan DetailScreen jika rute adalah detail
        if (_currentPath.isDetail && _currentPath.id != null)
          MaterialPage(
            key: ValueKey('DetailScreen-${_currentPath.id}'),
            child: DetailScreen(
              item: _items.firstWhere((item) => item.id == _currentPath.id),
              onBack: goHome,
            ),
          ),
        // Tampilkan SettingsScreen jika rute adalah settings
        if (_currentPath.isSettings)
          MaterialPage(
            key: const ValueKey('SettingsScreen'),
            child: SettingsScreen(
              onBack: goHome,
            ),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        // Jika halaman Detail atau Settings di-pop, kembali ke Home
        goHome();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RoutePath path) async {
    _currentPath = path;
    // Tidak perlu notifyListeners() di sini karena Router akan rebuild widget
  }
}

// Aplikasi utama
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Deep Linking App',
      theme: ThemeData(
        // Menggunakan ColorScheme untuk kustomisasi warna yang lebih baik
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.lime, // Warna primer utama
            accentColor: Colors.limeAccent, // Warna aksen
            brightness: Brightness.light,
          ).copyWith(
            secondary: Colors.limeAccent, // Alias untuk accentColor di ColorScheme modern
            onPrimary: Colors.black87, // Warna teks/ikon di atas warna primer
            onSecondary: Colors.black87, // Warna teks/ikon di atas warna sekunder
          ),
          primaryColor: Colors.lime, // Untuk kompatibilitas atau override jika diperlukan
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(fontSize: 16),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.lime, // Atur warna AppBar
            foregroundColor: Colors.black87, // Warna ikon dan teks di AppBar
            titleTextStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            centerTitle: true,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.limeAccent,
              foregroundColor: Colors.black87,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          listTileTheme: ListTileThemeData(
            iconColor: Colors.lime[700],
          )
      ),
      routerDelegate: AppRouterDelegate(),
      routeInformationParser: AppRouteInformationParser(),
    );
  }
}

// Layar Utama (HomeScreen)
class HomeScreen extends StatelessWidget {
  final List<Item> items;
  final Function(int) onItemSelected;
  final VoidCallback onGoToSettings; // Callback untuk navigasi ke Settings

  const HomeScreen({
    super.key,
    required this.items,
    required this.onItemSelected,
    required this.onGoToSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: onGoToSettings,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text('ID: ${item.id}'),
            onTap: () => onItemSelected(item.id),
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
        // Tombol kembali akan ditangani oleh Navigator dan onPopPage
        // Jika ingin tombol kembali eksplisit di AppBar yang memanggil onBack:
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: onBack,
        // ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Item: ${item.name}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'ID: ${item.id}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onBack,
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

// Layar Pengaturan (SettingsScreen) - BARU
class SettingsScreen extends StatelessWidget {
  final VoidCallback onBack;

  const SettingsScreen({
    super.key,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        // Tombol kembali akan ditangani oleh Navigator dan onPopPage
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: onBack,
        // ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.settings_applications, size: 80, color: Colors.grey),
            const SizedBox(height: 20),
            const Text(
              'App Settings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Configure your app preferences here.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: onBack,
              child: const Text('Back to Home'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Contoh aksi lain di halaman settings
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Another setting action!')),
                );
              },
              child: Text(
                'Another Action',
                style: TextStyle(color: Theme.of(context).primaryColorDark),
              ),
            )
          ],
        ),
      ),
    );
  }
}