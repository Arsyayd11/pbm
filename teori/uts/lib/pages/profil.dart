import 'package:flutter/material.dart';
import '../main.dart';

class AkunPage extends StatefulWidget {
  const AkunPage({Key? key}) : super(key: key);

  @override
  _AkunPageState createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          color: colorScheme.surfaceVariant,
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colorScheme.primary,
                      width: 3,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundImage: const AssetImage('assets/images/arsya.jpg'),
                    backgroundColor: colorScheme.primary.withOpacity(0.2),
                    radius: 50,
                  ),
                ),
                const SizedBox(width: 24), // Jarak diperbesar
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Arsya Yan Duribta',
                          style: TextStyle(
                            fontSize: 20, // Perbesar font
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface,
                          )),
                      const SizedBox(height: 8), // Tambah spacing
                      Text(
                        'NIM: 4522210117\narsyayd11@gmail.com',
                        style: TextStyle(
                          fontSize: 16, // Perbesar font
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20), // Tambah spacing antar card
        Card(
          color: colorScheme.surfaceVariant,
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12), // Tambah padding
            child: SwitchListTile(
              title: Text('Dark Mode',
                  style: TextStyle(
                    fontSize: 18, // Perbesar font
                    color: colorScheme.onSurface,
                  )),
              activeColor: colorScheme.primary,
              value: isDark,
              onChanged: (val) {
                setState(() => isDark = val);
                MyApp.of(context)!.setTheme(isDark);
              },
            ),
          ),
        ),
      ],
    );
  }
}

