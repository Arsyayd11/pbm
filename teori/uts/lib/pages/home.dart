import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, bool> _done = {
    'Lari pagi': false,
    'Baca Buku': false,
    'Gmeet Manajemen Proyek': false,
    'Mengerjakan Tugas PBM': false,
  };

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [

        // Quotes
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16), // padding atas & bawah diperbesar
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '"Keberhasilan bukanlah milik orang yang pintar. Keberhasilan adalah milik mereka yang senantiasa berusaha."',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  '- BJ. Habibie',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),

        // Kegiatan Harian
        const SizedBox(height: 16),
        ..._done.entries.map((entry) => CheckboxListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: Text(entry.key),
          subtitle: const Text('07 May 2025'),
          value: entry.value,
          onChanged: (val) => setState(() => _done[entry.key] = val!),
        )),
      ],
    );
  }
}