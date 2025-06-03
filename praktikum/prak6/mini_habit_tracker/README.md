# Flutter Mini Habit Tracker

**Flutter Mini Habit Tracker** adalah aplikasi seluler yang dibangun menggunakan Flutter, dirancang untuk membantu pengguna membangun dan melacak kebiasaan positif harian. Aplikasi ini ditujukan bagi individu yang mencari alat sederhana dan langsung untuk memantau pertumbuhan pribadi mereka.

## Fitur dan Atribut

### Fitur Utama

* **Pembuatan Kebiasaan Baru**: Memungkinkan pengguna membuat kebiasaan dengan nama, ikon, dan frekuensi.
* **Pelacakan Progres Harian**: Tandai kebiasaan selesai atau belum untuk hari tertentu.
* **Visualisasi Data Progres**: Menampilkan grafik atau ringkasan sederhana progres harian.
* **Pengingat Notifikasi**: Mengatur pengingat agar tidak lupa menjalankan kebiasaan.
* **Manajemen Data Lokal**: Menyimpan data kebiasaan secara lokal di perangkat.
* **Tema Terang dan Gelap**: Dukungan tema terang dan gelap.
* **CRUD Kebiasaan**: Fungsionalitas Create, Read, Update, Delete pada kebiasaan.
* **Reset Progres**: Mereset status semua kebiasaan.

## Screenshots Uji Coba

* **1. Run Aplikasi**
  ![Run Aplikasi](screenshot/img_1.png)

* **2. Uji Strikethrough**
  ![Uji Strikethrough](screenshot/img_2.png)

* **3. Uji Tambah Habit**
  * a. Klik tombol +
    ![Uji Tambah Habit](screenshot/img_3.png)
  * b. Gagal Simpan
    ![Uji Tambah Habit](screenshot/img_4.png)
  * c. Isi Form dan Simpan
    ![Uji Tambah Habit](screenshot/img_5.png)
    ![Uji Tambah Habit](screenshot/img_6.png)

* **4. Uji Edit Habit**
    * a. Klik menu tiga titik pada habit, pilih "Edit".
      ![Uji Edit Habit](screenshot/img_7.png)
    * b. Dialog harus muncul dengan data habit tersebut.
      ![Uji Edit Habit](screenshot/img_8.png)
    * c. Ubah nama/deskripsi dan simpan. Verifikasi perubahan di list.
      ![Uji Edit Habit](screenshot/img_9.png)

* **5. Uji Hapus Habit**
    * a. Klik menu tiga titik pada habit, pilih "Hapus".
      ![Uji Hapus Habit](screenshot/img_10.png)
    * b. Dialog konfirmasi harus muncul. Coba batalkan.
      ![Uji Hapus Habit](screenshot/img_11.png)
    * c. Coba hapus lagi dan konfirmasi. Verifikasi habit hilang dari list.
      ![Uji Hapus Habit](screenshot/img_12.png)

* **6. Uji Progress Bar**
  ![Uji Progress Bar](screenshot/img_13.png)

* **7. Uji Reset**
  ![Uji Reset](screenshot/img_14.png)

* **8. Uji Ephemeral State**
  ![Uji Ephemeral State](screenshot/img_16.png)

* **9. Amati Output print**
  ![Amati Output print](screenshot/img_17.png)
  * `print('build ${habit.name}')` adalah indikator bahwa Flutter sedang merender atau merender ulang representasi visual dari sebuah kebiasaan. Setiap aksi yang menyebabkan perubahan pada data yang ditampilkan oleh `ListView.builder` (seperti menambah, mengedit, menghapus, mengubah status) atau perubahan tampilan global (seperti tema) akan memicu pemanggilan `setState`. Pemanggilan `setState` ini memberitahu Flutter untuk menjadwalkan pembangunan ulang widget yang relevan. Karena `ListView.builder` bergantung pada daftar _habits dan state lainnya (seperti _isDarkMode), ia akan membangun ulang item-itemnya sesuai kebutuhan, yang pada gilirannya menjalankan itemBuilder dan mengeksekusi pernyataan print tersebut.


## Cara Menjalankan Aplikasi

1. Pastikan Flutter SDK terinstall
2. Clone repository ini
3. Jalankan command berikut:
```bash
flutter pub get
flutter run
```
