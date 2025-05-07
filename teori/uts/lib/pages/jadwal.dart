import 'package:flutter/material.dart';

class JadwalPage extends StatelessWidget {
  const JadwalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, List<List<String>>> jadwal = {
      'Senin': [
        ['Pemrograman Berbasis Mobile', 'A', '3', '08:00-10:30', 'Adi Wahyu Pribadi, S.Si., M.Kom.'],
        ['Big Data Analysis', 'A', '3', '10:30-13:00', 'Dr. Bambang Hariyanto, ST., MT.'],
      ],
      'Selasa': [
        ['Metodelogi Penelitian', 'A', '3', '11:20-13:50', 'Dr. Iman Paryudi, M.Sc.'],
        ['Prak. Pemrograman Berbasis Mobile', 'A', '1', '14:00-16:20', 'Adi Wahyu Pribadi, S.Si., M.Kom.'],
      ],
      'Rabu': [
        ['Manajemen Proyek', 'A', '3', '09:40 - 12:10', 'Dra. Sri Rezeki Candra N, M.Kom'],
      ],
      'Kamis': [
        ['Pengantar Data Science', 'A', '3', '10:30-13:00', 'Dr. Iman Paryudi, M.Sc.'],
      ],
      'Jumat': [
        ['Geoinformatika', 'B', '2', '08:00 - 09:40', 'Febri Maspiyanti, S.Kom., M.Kom.'],
      ],
    };

    final isSmall = MediaQuery.of(context).size.width < 600;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: jadwal.entries.map((entry) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    entry.key,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowHeight: 40,
                    columnSpacing: 24,
                    columns: const [
                    DataColumn(label: Text('Mata Kuliah')),
                    DataColumn(label: Text('Kelas')),
                    DataColumn(label: Text('SKS')),
                    DataColumn(label: Text('Jam')),
                    DataColumn(label: Text('Dosen')),
                    ],
                    rows: entry.value.map((matkul) {
                      return DataRow(
                        cells: matkul.map((val) {
                          return DataCell(
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 200),
                              child: Text(val),
                            ),
                          );
                        }).toList(),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}