# 🛠️ Panduan Pemecahan Masalah (Troubleshooting & FAQ)

Dokumen ini berisi panduan solusi untuk masalah umum yang mungkin dihadapi saat instalasi atau pengoperasian **Delft3D Flexible Mesh Suite**.

---

## 1. Peringatan Windows Defender SmartScreen ("Windows protected your PC")

### Gejala:
Saat pertama kali menjalankan `Delft3D_FM_Suite_2026.02_AllInOne_Setup.exe`, Windows menampilkan layar biru peringatan SmartScreen.

### Penyebab:
File installer ini adalah build mandiri komunitas (*community build*) yang belum memiliki sertifikat digital komersial berbayar (EV Code Signing Certificate). Windows Defender secara otomatis menampilkan peringatan ini untuk semua file `.exe` baru yang diunduh dari internet.

### Solusi:
1. Pada jendela SmartScreen, klik tautan bertuliskan **"More info"** (*Informasi selengkapnya*).
2. Klik tombol **"Run anyway"** (*Tetap jalankan*).
3. Installer akan berjalan dengan normal.

---

## 2. Kesalahan Library C++ Hilang (`MSVCP140.dll` atau `VCRUNTIME140.dll`)

### Gejala:
Saat membuka DeltaShell atau saat memulai perhitungan simulasi, muncul pesan error:  
`The code execution cannot proceed because MSVCP140.dll was not found.` atau `vcruntime140_1.dll was not found.`

### Penyebab:
Komputer target belum memiliki runtime **Microsoft Visual C++ Redistributable (2015-2022 x64)**.

### Solusi:
Unduh dan pasang paket resmi dari Microsoft (bebas biaya):
👉 **[Microsoft Visual C++ 2015–2022 Redistributable (x64)](https://aka.ms/vs/17/release/vc_redist.x64.exe)**  
Setelah instalasi selesai, buka kembali aplikasi Delft3D FM.

---

## 3. Pesan Error "License file not found" atau "DeltaShell license missing"

### Gejala:
Aplikasi DeltaShell menolak terbuka dan meminta file lisensi yang valid.

### Penyebab:
File lisensi `.lic` belum dipasang di folder FlexNet atau path registry belum terdaftar.

### Solusi:
1. Pastikan Anda telah memiliki file lisensi resmi `.lic` dari Deltares (ikuti panduan di [PANDUAN_LISENSI_DELTARES.md](PANDUAN_LISENSI_DELTARES.md)).
2. Pastikan file tersebut diletakkan di:
   ```
   C:\Program Files (x86)\DS_Flex\
   ```
3. Pastikan ekstensi file adalah `.lic` (bukan `.lic.txt`). Di File Explorer, aktifkan opsi *View -> File name extensions*.
4. Buka aplikasi kembali.

---

## 4. Mesin Solver Tidak Ditemukan oleh GUI ("Calculation Engine Not Found")

### Gejala:
Model berhasil dimuat di GUI DeltaShell, namun saat tombol *Run Simulation* ditekan, muncul pesan bahwa mesin kalkulasi (`dflowfm-cli.exe` atau `dimr.exe`) tidak ditemukan.

### Penyebab:
Struktur direktori plugin kernel tidak lengkap atau rusak.

### Solusi:
Buka folder instalasi (default: `C:\Program Files\Deltares\Delft3D FM Suite 2026.02 OpenHMWQ\plugins\DeltaShell.Dimr\kernels\x64\bin`).  
Pastikan berkas-berkas berikut ada di folder `bin`:
* `dimr.exe`
* `dflowfm-cli.exe`
* `wave.exe`
* `delwaq.exe`
* `dflowfm.dll`, `mkl_rt.2.dll`, `petsc.dll`, dll.

Jika berkas-berkas tersebut tidak ada, jalankan kembali installer dan pastikan komponen **Delft3D FM Core** tercentang saat instalasi.

---

## 5. Mengoptimalkan Kecepatan Perhitungan Multi-Core (OpenMP)

### Rekomendasi:
Secara default, D-Flow FM menggunakan paralelisasi multi-threading OpenMP. Untuk mengunci jumlah core CPU yang digunakan:
1. Buka Command Prompt / PowerShell.
2. Atur variabel lingkungan jumlah thread sebelum menjalankan perintah simulasi CLI:
   ```cmd
   set OMP_NUM_THREADS=8
   ```
   *(Ganti angka `8` dengan jumlah core fisik prosesor komputer Anda)*.
