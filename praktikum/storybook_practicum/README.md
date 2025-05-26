# Praktikum 4: Interactive Storybook

## 👥 Nama dan Npm
| Nama                  | NPM        |
|-----------------------|------------|
| Arsya Yan Duribta | 4522210117 |

Praktikum membangun aplikasi Flutter interaktif sederhana yang menyerupai storybook. Aplikasi ini akan memiliki beberapa halaman yang dapat digeser (`PageView`) dengan elemen interaktif seperti *double tap*, *long press*, dan *drag-and-drop*.

---

## Gambaran Umum Proyek

Aplikasi *Interactive Storybook* ini terdiri dari beberapa halaman yang dapat digeser secara horizontal menggunakan `PageView`. Setiap halaman memiliki fungsi dan interaksi yang berbeda:

* **Halaman Judul (`title_page.dart`):** Halaman pembuka dengan judul cerita dan tombol "Mulai" untuk memulai petualangan.
* **Halaman Adegan Interaktif (`scene_page.dart`):** Halaman utama cerita di mana pengguna dapat berinteraksi dengan elemen-elemen di dalamnya.
* **Halaman Akhir (`end_page.dart`):** Halaman penutup yang menandakan selesainya cerita.

---

## Fitur Utama yang Dikerjakan

Selama praktikum ini, kami fokus pada implementasi fitur-fitur berikut:

### 1. Struktur Navigasi `PageView`
Kami mengimplementasikan `PageView` di `main.dart` sebagai **navigasi utama** aplikasi. Ini memungkinkan pengguna untuk menggeser antar halaman cerita dengan animasi yang mulus. Fungsi `animateToPage` digunakan untuk transisi halaman yang terkontrol.

### 2. Interaksi Objek di Adegan (`scene_page.dart`)
Bagian inti dari praktikum ini adalah menambahkan berbagai **interaksi ke objek** di `scene_page.dart`:

* **Astronaut (`󰥡`):** Kami menambahkan `GestureDetector` dengan `onDoubleTap` untuk membuat astronaut menampilkan atau menyembunyikan balon dialog. Ini memberikan elemen naratif yang muncul saat interaksi.
* **Peti (`📦`):** Sebuah peti yang dapat di-*long press* untuk menampilkan petunjuk. Saat pertama kali ditekan lama, petunjuk "Sepertinya butuh kunci..." muncul, dan kemudian kembali ke "Terkunci..." setelah beberapa detik.
* **Kunci (`🔑`):** Kunci ini adalah elemen `Draggable` yang dapat di-*drag-and-drop*. Logika `onPanUpdate` dan `onPanEnd` digunakan untuk memperbarui posisi kunci saat diseret dan mendeteksi jika kunci di-*drop* di atas peti. Jika kunci berhasil mengenai peti, peti akan terbuka (`🔓`), dan pengguna secara otomatis beralih ke halaman akhir.

### 3. Efek Visual pada Tombol "Mulai"
Pada `title_page.dart`, kami mengganti `ElevatedButton` dengan kombinasi `Card` dan `InkWell`. Ini memberikan **efek visual yang lebih menarik** seperti *shadow* (elevasi) dan *splash effect* saat tombol ditekan, meningkatkan pengalaman pengguna.

### 4. Pergerakan Latar Belakang Terbatas
Kami menambahkan fungsionalitas untuk **menggeser latar belakang** adegan (`scene_page.dart`) secara horizontal atau vertikal, tetapi tidak keduanya sekaligus. Ini dicapai dengan membungkus latar belakang dalam `Transform.translate` dan menggunakan `RawGestureDetector` dengan `HorizontalDragGestureRecognizer` dan `VerticalDragGestureRecognizer` terpisah. Fitur ini mensimulasikan pandangan melalui teleskop atau jendela kapal.

### 5. Fungsionalitas Zoom dan Pan
Untuk memberikan kontrol yang lebih baik kepada pengguna, seluruh `Stack` di `scene_page.dart` dibungkus dengan widget **`InteractiveViewer`**. Ini secara otomatis memungkinkan pengguna untuk **melakukan zoom in/out dan pan** pada seluruh adegan, memberikan kebebasan untuk mengeksplorasi detail.

---

## Tahapan Praktikum

Berikut adalah langkah-langkah yang dilakukan dalam praktikum ini:

### 1\. Membuat Proyek Flutter Baru

Memulai dengan membuat proyek Flutter baru bernama `storybook_practicum`.
![Screenshot Aplikasi](screenshot/screenshot_1.png)

### 2\. Membuka Code Editor

Membuka proyek yang telah dibuat di code editor pilihan Anda.
![Screenshot Aplikasi](screenshot/screenshot_2.png)

### 3\. Membuat Struktur Folder `pages`

Membuat folder `pages` di dalam `lib` dan menambahkan tiga file Dart: `title_page.dart`, `scene_page.dart`, dan `end_page.dart`.

```
lib/
├── pages/
│   └── end_page.dart          # Halaman akhir cerita
│   └── scene_page.dart        # Halaman adegan interaktif
│   └── title_page.dart        # Halaman judul atau awal aplikasi
└── main.dart                  # Titik Masuk Aplikasi, Setup MaterialApp
```
![Screenshot Aplikasi](screenshot/screenshot_3.png)

### 4\. Mengatur `PageView` di `main.dart`

Mengganti isi `lib/main.dart` untuk membuat struktur `PageView` yang akan menampilkan halaman-halaman cerita.
![Screenshot Aplikasi](screenshot/screenshot_4.png)

### 5\. Mengisi `title_page.dart`

Menambahkan `StatelessWidget` sederhana ke `title_page.dart` sebagai halaman awal.
![Screenshot Aplikasi](screenshot/screenshot_5.png)

### 6\. Mengisi `scene_page.dart` dan `end_page.dart`

Melakukan hal yang sama untuk `scene_page.dart` dan `end_page.dart` dengan hanya menampilkan teks judul halaman.
![Screenshot Aplikasi](screenshot/screenshot_6.png)
![Screenshot Aplikasi](screenshot/screenshot_6_2.png)

### 7\. Mengganti `scene_page.dart` menjadi `StatefulWidget`

Mengubah `scene_page.dart` menjadi `StatefulWidget` untuk mengelola state interaksi.
![Screenshot Aplikasi](screenshot/screenshot_7.png)

### 8\. Menambahkan Astronaut & Balon Dialog (Double Tap)

Menambahkan astronaut dan balon dialog yang muncul saat astronaut di-*double tap*.
![Screenshot Aplikasi](screenshot/screenshot_8.png)

### 9\. Menambahkan Peti & Petunjuk (Long Press)

Menambahkan peti yang akan menampilkan petunjuk saat di-*long press*.
![Screenshot Aplikasi](screenshot/screenshot_9.png)


### 10\. Menambahkan Kunci & Logika Drag-and-Drop

Menambahkan kunci yang bisa di-*drag-and-drop* untuk membuka peti.
![Screenshot Aplikasi](screenshot/screenshot_10.png)

### 11\. Hot Reload & Uji Coba

Melakukan hot reload dan menguji semua interaksi yang telah ditambahkan.
![Screenshot Aplikasi](screenshot/screenshot_11.png)

### 12\. Efek Visual (InkWell) di `title_page.dart`

Menambahkan efek visual dengan `Card` dan `InkWell` pada tombol "Mulai" di `title_page.dart`.
![Screenshot Aplikasi](screenshot/screenshot_12.png)

### 13\. Modifikasi Tombol "Mulai Petualangan"

Mengganti `ElevatedButton` dengan `Card` yang dibungkus `InkWell` untuk tampilan yang lebih baik.
![Screenshot Aplikasi](screenshot/screenshot_13.png)

### 14\. & 15. Persiapan Pergerakan Latar Belakang

Bersiap untuk membuat latar belakang yang dapat digeser secara horizontal atau vertikal.
![Screenshot Aplikasi](screenshot/screenshot_15.png)

### 16\. Menambahkan `_backgroundOffset`

Menambahkan variabel state `_backgroundOffset` di `_InteractiveScenePageState` untuk mengelola posisi latar belakang.
![Screenshot Aplikasi](screenshot/screenshot_16.png)

### 17\. Bungkus Latar Belakang dengan `RawGestureDetector` dan `Transform`

Mengganti `Container` latar belakang dengan `RawGestureDetector` dan `Transform` untuk memungkinkan pergerakan latar belakang.
![Screenshot Aplikasi](screenshot/screenshot_17.png)

### 18\. Uji Coba Pergerakan Latar Belakang

Menguji kemampuan menggeser latar belakang hanya pada satu sumbu.
![Screenshot Aplikasi](screenshot/screenshot_18.png)

### 19\. & 20. Fungsionalitas Zoom dengan `InteractiveViewer`

Menambahkan `InteractiveViewer` untuk memungkinkan fungsionalitas zoom dan pan pada seluruh adegan.
![Screenshot Aplikasi](screenshot/screenshot_20.png)


### 21\. Hot Reload & Uji Coba Zoom

Melakukan hot reload dan menguji fungsionalitas zoom dan pan pada adegan.
![Demo Aplikasi](screenshot/screenshot_21_1.png)
![Demo Aplikasi](screenshot/screenshot_21_2.png)
![Demo Aplikasi](screenshot/screenshot_21_3.png)

---

## Cara Menjalankan Aplikasi

1. Pastikan Flutter SDK terinstall
2. Clone repository ini
3. Jalankan command berikut:
```bash
flutter pub get
flutter run
```