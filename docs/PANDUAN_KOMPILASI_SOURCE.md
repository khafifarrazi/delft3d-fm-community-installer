# Panduan Teknis dan Acuan Kerja: Kompilasi Mandiri Delft3D Flexible Mesh (Delft3D FM)

Dokumen ini disusun sebagai **Standar Operasional Prosedur (SOP) dan Acuan Kerja Teknis** untuk mengunduh, mengonfigurasi, mengompilasi, dan mengintegrasikan mesin komputasi (*computational kernels*) **Delft3D Flexible Mesh Suite** yang bersumber dari repositori resmi [GitHub Deltares/Delft3D](https://github.com/Deltares/Delft3D).

---

## Daftar Isi
1. [Arsitektur & Konsep Dasar Delft3D FM](#1-arsitektur--konsep-dasar-delft3d-fm)
2. [Pemilihan Jalur Kompilasi (Build Pathways)](#2-pemilihan-jalur-kompilasi-build-pathways)
3. [Jalur A: Kompilasi Native Windows (Direkomendasikan untuk Integrasi GUI)](#3-jalur-a-kompilasi-native-windows)
   - [3.1 Daftar Prasyarat Software (Prerequisites)](#31-daftar-prasyarat-software-prerequisites)
   - [3.2 Tahap 1: Pengambilan Kode Sumber (Git Clone)](#32-tahap-1-pengambilan-kode-sumber-git-clone)
   - [3.3 Tahap 2: Konfigurasi Conan Package Manager](#33-tahap-2-konfigurasi-conan-package-manager)
   - [3.4 Tahap 3: Eksekusi Kompilasi dan Build Kernel](#34-tahap-3-eksekusi-kompilasi-dan-build-kernel)
   - [3.5 Tahap 4: Verifikasi Hasil Kompilasi](#35-tahap-4-verifikasi-hasil-kompilasi)
   - [3.6 Tahap 5: Download & Integrasi GUI Resmi Deltares](#36-tahap-5-download--integrasi-gui-resmi-deltares)
4. [Jalur B: Kompilasi Berbasis Container / Linux (WSL2 & Docker)](#4-jalur-b-kompilasi-berbasis-container--linux-wsl2--docker)
   - [4.1 Keunggulan & Skenario Penggunaan](#41-keunggulan--skenario-penggunaan)
   - [4.2 Langkah Build Menggunakan Docker](#42-langkah-build-menggunakan-docker)
   - [4.3 Eksekusi Simulasi dari CLI / Script](#43-eksekusi-simulasi-dari-cli--script)
5. [Troubleshooting & Solusi Masalah Umum (FAQ)](#5-troubleshooting--solusi-masalah-umum-faq)
6. [Struktur Direktori Akhir dan Cheatsheet Perintah](#6-struktur-direktori-akhir-dan-cheatsheet-perintah)

---

## 1. Arsitektur & Konsep Dasar Delft3D FM

Sebelum memulai proses kompilasi, sangat penting untuk memahami arsitektur pemisahan sistem yang diterapkan oleh Deltares:

```
┌────────────────────────────────────────────────────────┐
│     Delft3D FM Suite GUI (DeltaShell) - Windows        │
│  • Antarmuka visual gratis dari download.deltares.nl   │
│  • Belum dilengkapi mesin komputasi (kernel kosong)    │
└───────────────────────────┬────────────────────────────┘
                            │ Memanggil file eksekusi
                            ▼
┌────────────────────────────────────────────────────────┐
│       Computational Kernels (Source Code di GitHub)    │
│  • dimr.exe (Deltares Integrated Model Runner)         │
│  • dflowfm.exe (Mesin hidrodinamika & morfologi)       │
│  • wave.exe (D-Waves), fbc.exe, waq.exe, dll.          │
│  • Ditulis dalam Fortran modern dan C/C++              │
└────────────────────────────────────────────────────────┘
```

* **Computational Kernels (GitHub)**: Merupakan *engine* murni tanpa UI yang melakukan kalkulasi fisika-matematika hidrodinamika, gelombang, sedimentasi, dan kualitas air. Mesin utama dikoordinasikan oleh **DIMR** (*Deltares Integrated Model Runner*).
* **Graphical User Interface (GUI DeltaShell)**: Merupakan aplikasi antarmuka visual Windows yang bertugas mendesain grid/mesh, menentukan batasan (*boundary conditions*), dan memvisualisasikan parameter.
* **Tujuan Akhir Kerja**: Mengompilasi kode sumber kernel dari GitHub menjadi file `.exe` dan pustaka `.dll`, lalu menautkannya ke dalam direktori instalasi GUI Deltares.

---

## 2. Pemilihan Jalur Kompilasi (Build Pathways)

Pilih jalur yang sesuai dengan kebutuhan operasional:

| Parameter | Jalur A: Native Windows | Jalur B: Docker / Linux (WSL2) |
| :--- | :--- | :--- |
| **Tujuan Utama** | Integrasi penuh dengan GUI Windows (DeltaShell). | Menjalankan simulasi batch, automasi script, atau HPC. |
| **Kebutuhan Tool** | Visual Studio 2022, Intel oneAPI (HPC + Base), Cygwin, Conan 2. | Docker Desktop atau WSL2 Ubuntu dengan environment container resmi. |
| **Tingkat Kompleksitas** | Menengah–Tinggi (perlu konfigurasi compiler Fortran + C++ di Windows). | Rendah–Menengah (dependensi sudah dikemas dalam container). |
| **Kemudahan Pemakaian** | User-friendly lewat antarmuka visual GUI. | Efisien untuk komputasi berat via terminal / command line. |

---

## 3. Jalur A: Kompilasi Native Windows

### 3.1 Daftar Prasyarat Software (Prerequisites)

Pastikan semua perangkat lunak berikut terpasang sebelum menjalankan proses kompilasi:

1. **Git for Windows**
   - Unduh: [gitforwindows.org](https://gitforwindows.org/)
   - Catatan: Dibutuhkan untuk mengkloning repositori.
2. **Microsoft Visual Studio 2022** (Community / Professional / Enterprise)
   - Unduh: [visualstudio.microsoft.com/vs/community](https://visualstudio.microsoft.com/vs/community/)
   - Beban kerja wajib: **Desktop development with C++**
   - Komponen wajib di tab kanan (*Installation details*):
     - `MSVC v143 - VS 2022 C++ x64/x86 build tools`
     - `C++/CLI support for v143 build tools`
     - `C++ MFC for latest v143 build tools`
     - `Windows 10/11 SDK (versi terbaru)`
3. **Intel oneAPI Base Toolkit**
   - Unduh: [Intel oneAPI Base Toolkit](https://www.intel.com/content/www/us/en/developer/tools/oneapi/base-toolkit-download.html)
   - Komponen penting: **Intel oneAPI Math Kernel Library (oneMKL)**.
4. **Intel oneAPI HPC Toolkit**
   - Unduh: [Intel oneAPI HPC Toolkit](https://www.intel.com/content/www/us/en/developer/tools/oneapi/hpc-toolkit-download.html)
   - Komponen wajib:
     - **Intel Fortran Compiler (`ifx` dan `ifort`)**
     - **Intel MPI Library**
   - *Penting:* Pastikan opsi integrasi dengan Microsoft Visual Studio 2022 dicentang saat instalasi.
5. **CMake (versi >= 3.20)**
   - Unduh: [cmake.org/download](https://cmake.org/download/)
   - Pastikan opsi *Add CMake to the system PATH for all users* dicentang saat instalasi.
6. **Python (versi 3.10 - 3.14)**
   - Tersedia di sistem Anda (misal `C:\Python314\python.exe`).
7. **Conan Package Manager (versi 2.x)**
   - Pasang melalui terminal Command Prompt / PowerShell:
     ```powershell
     pip install conan
     ```
   - Verifikasi versi:
     ```powershell
     conan --version
     # Output minimal: Conan version 2.x.x
     ```
8. **Cygwin 64-bit**
   - Pasang di lokasi baku: `C:\cygwin64`
   - Unduh installer dari [cygwin.com](https://www.cygwin.com/).
   - Pada pemilihan paket, pastikan menambahkan:
     - `make`
     - `python3`
   - *Alasan:* Dibutuhkan oleh Conan untuk mengompilasi pustaka numerik PETSc dari resep lokal di Windows.

> **PENTING: Hindari Spasi pada Path Direktori Kerja:**
> Jangan menaruh repositori atau build folder di direktori yang mengandung spasi (misalnya `D:\Delft3D Flexible Mesh` sebaiknya menggunakan `D:\Delft3D-FM` atau `D:\Delft3D_Source`). Spasi pada path sering memicu kegagalan saat proses link library C/Fortran dan resep Conan/Cygwin.

---

### 3.2 Tahap 1: Struktur Folder Kerja

Kode sumber Delft3D sudah ditempatkan di direktori kerja utama yang bebas spasi:
```
D:\Delft3D_Flexible_Mesh\Delft3D-main\
```

---

### 3.3 Tahap 2: Konfigurasi Conan Package Manager

Deltares menggunakan **Conan 2** untuk mengelola dependensi pihak ketiga (NetCDF, HDF5, PROJ, PETSc, Metis, dll.).

1. Buka terminal khusus:
   > **Start Menu** -> Cari **"Intel oneAPI command prompt for Intel 64 for Visual Studio 2026"**.
   > *(Seluruh perintah kompilasi berikutnya WAJIB dijalankan dari terminal ini)*.

2. Pindah ke folder kerja:
   ```cmd
   d:
   cd D:\Delft3D_Flexible_Mesh\Delft3D-main
   ```

3. Inisialisasi Conan untuk pengguna publik / open-source (*external*):
   ```cmd
   python run_conan.py initialize external
   ```
   *(Langkah ini sudah sukses dijalankan dan profil compiler telah terdaftar di sistem)*.

4. **Penyesuaian Khusus Jalur Cygwin (Sudah Diterapkan):**
   Karena Cygwin dipasang di `D:\Cygwin`, profil Conan `delft3d_windows_msvc_195_v1` di `%USERPROFILE%\.conan2\profiles\` sudah diarahkan ke:
   ```ini
   tools.microsoft.bash:path=D:/Cygwin/bin/bash.exe
   ```

---

### 3.4 Tahap 3: Eksekusi Kompilasi dan Build Kernel

Jalankan perintah build terpadu (`build.py`) yang dioptimalkan untuk konfigurasi **Visual Studio 2026** dan profil **Release**:

```cmd
python build.py --config fm-suite --build --build-type Release --keep-build --profile delft3d_windows_msvc_195_v1
```

#### Penjelasan Parameter:
* `--config fm-suite`: Mengompilasi modul khusus Delft3D Flexible Mesh (`dimr`, `dflowfm`, `wave`, `fbc`, `waq`).
* `--build`: Langsung mengompilasi dan menginstal biner ke folder target `install_fm-suite`.
* `--build-type Release`: Menghasilkan biner versi Release dengan optimasi performa penuh untuk simulasi komputasi numerik.
* `--keep-build`: Mempertahankan folder build dan konfigurasi Conan yang telah selesai disiapkan.
* `--profile delft3d_windows_msvc_195_v1`: Menggunakan profil compiler resmi untuk Visual Studio 2026 dan Intel oneAPI.
* *(Seluruh 24 dependensi pihak ketiga seperti HDF5, NetCDF, GDAL, PETSc, SWAN telah selesai dikompilasi 100% dan tersimpan di cache lokal `%USERPROFILE%\.conan2`).*

---

### 3.5 Tahap 4: Verifikasi Hasil Kompilasi

Setelah proses kompilasi selesai dengan status sukses, periksa folder hasil instalasi:
`D:\Delft3D_Flexible_Mesh\Delft3D-main\install_fm-suite\`

Pastikan struktur direktori berikut terbentuk:
```
install_fm-suite/
├── bin/
│   ├── dimr.exe                 # Model Runner utama (DIMR)
│   ├── dflowfm-cli.exe          # Mesin D-Flow Flexible Mesh utama (CLI)
│   ├── wave.exe                 # Mesin simulasi gelombang (D-Waves)
│   ├── swan_mpi.exe / swan_omp  # SWAN wave simulation engines
│   ├── delwaq.exe               # D-Water Quality engine
│   ├── rr.exe                   # D-Rainfall Runoff engine
│   ├── FBCTools.exe             # Feed-Back Control tools
│   └── *.dll                    # Library pendukung (NetCDF, HDF5, GDAL, PETSc, MKL, dll.)
└── share/
    └── ...                      # File template, tabel parameter, dan metadata
```

Lakukan pengujian cepat dari terminal untuk memverifikasi eksekusi:
```cmd
D:\Delft3D_Flexible_Mesh\Delft3D-main\install_fm-suite\bin\dflowfm-cli.exe --version
D:\Delft3D_Flexible_Mesh\Delft3D-main\install_fm-suite\bin\dimr.exe -?
```
Jika nomor versi atau ringkasan bantuan muncul di layar, berarti kernel komputasi Anda **berhasil dibuat secara sempurna**.

---

### 3.6 Tahap 5: Download & Integrasi GUI Resmi Deltares

Agar Anda memiliki aplikasi pemodelan lengkap dengan tampilan visual:

1. **Registrasi Akun Unduhan**:
   - Buka: [Deltares Software Download Portal](https://download.deltares.nl/delft3d-fm-suite-2d3d-graphical-user-interface-gui-open-source)
   - Tambahkan paket **Delft3D FM Suite 2D3D Graphical User Interface (GUI) Open Source** ke keranjang.
   - Isi formulir dan kirimkan permohonan lisensi gratis. Tautan unduhan installer dan lisensi akan dikirim via email.
2. **Pasang Aplikasi GUI**:
   - Ekstrak installer dan jalankan proses instalasi.
   - Folder instalasi default biasanya:
     `C:\Program Files\Deltares\Delft3D FM Suite <versi> OpenHMWQ\`
3. **Persiapkan Folder Target Kernel**:
   - Buka direktori instalasi GUI tersebut di File Explorer.
   - Masuk ke subfolder:
     `plugins\DeltaShell.Dimr\`
   - Buat folder baru bernama `kernels`, dan di dalamnya buat folder `x64`, sehingga jalurnya menjadi:
     `plugins\DeltaShell.Dimr\kernels\x64\`
4. **Pindahkan Biner Kernel**:
   - Salin seluruh isi dari folder hasil kompilasi Anda (`D:\Delft3D_Flexible_Mesh\Delft3D-main\install_fm-suite\bin` dan `D:\Delft3D_Flexible_Mesh\Delft3D-main\install_fm-suite\share`) ke dalam:
     `C:\Program Files\Deltares\Delft3D FM Suite <versi> OpenHMWQ\plugins\DeltaShell.Dimr\kernels\x64\`
5. **Jalankan Aplikasi**:
   - Luncurkan Delft3D FM dari Start Menu.
   - Buat atau buka contoh model Flexible Mesh, lalu tekan tombol **Run Simulation**. GUI sekarang akan mengeksekusi kernel kompilasi mandiri Anda!

---

## 4. Jalur B: Kompilasi Berbasis Container / Linux (WSL2 & Docker)

Jika Anda tidak ingin menginstal compiler Visual Studio dan Intel oneAPI di Windows (yang memakan ruang disk puluhan GB), gunakan jalur Docker / WSL2.

### 4.1 Keunggulan & Skenario Penggunaan
* Lingkungan bersih, terisolasi, dan tidak mengotori registri Windows.
* Didukung secara *native* oleh Deltares untuk keperluan *automated testing* dan komputasi performa tinggi.
* Sangat ideal jika Anda menjalankan kalkulasi berbasis skrip Python (`dfm_tools` / `hydrolib-core`).

### 4.2 Langkah Build Menggunakan Docker

1. Pastikan **Docker Desktop** sudah aktif di Windows Anda (dengan backend WSL2).
2. Dari direktori repositori `D:\Delft3D_FM`, jalankan perintah build container:
   ```bash
   docker build . -f doc/delft3d.Dockerfile \
       -t delft3d-fm:latest \
       --build-arg INTEL_ONEAPI_VERSION=2024 \
       --build-arg INTEL_FORTRAN_COMPILER=ifx \
       --build-arg BUILD_TYPE=Release \
       --build-arg CONFIGURATION=fm-suite
   ```
3. Docker akan secara otomatis mengunduh base image Linux Deltares, mengompilasi resep dependensi, dan mengompilasi seluruh kernel Delft3D FM.

### 4.3 Eksekusi Simulasi dari CLI / Script

Untuk menjalankan kalkulasi simulasi dari contoh model yang ada:
```bash
# Masuk ke folder contoh simulasi
cd examples/dflowfm/01_dflowfm_sequential

# Jalankan container Docker yang memetakan folder kerja saat ini
docker run --rm -v "%CD%":/work -w /work delft3d-fm:latest /delft3d/bin/run_dimr.sh
```

---

## 5. Troubleshooting & Solusi Masalah Umum (FAQ)

### Kasus 1: Error `MSB3073` saat kompilasi di Visual Studio
* **Penyebab**: Perintah build dijalankan di luar lingkungan variabel Intel oneAPI.
* **Solusi**: Selalu jalankan kompilasi atau luncurkan Visual Studio melalui terminal **Intel oneAPI command prompt for Intel 64 for Visual Studio 2022** dengan perintah: `devenv build_fm-suite\fm-suite.sln`.

### Kasus 2: Error path saat Cygwin mengompilasi dependensi PETSc
* **Penyebab**: Lokasi Cygwin bukan di `C:\cygwin64` atau ada spasi pada nama direktori project.
* **Solusi**:
  1. Pastikan project berada di direktori tanpa spasi (misal `D:\Delft3D_FM`).
  2. Buka file konfigurasi profil Conan di `%USERPROFILE%\.conan2\profiles\<nama_profil>` dan pastikan baris `tools.microsoft.bash:path` mengarah ke executable `bash.exe` milik Cygwin yang benar.

### Kasus 3: GUI tidak mendeteksi kernel (`Engine not found`)
* **Penyebab**: Peletakan folder biner tidak sesuai dengan struktur yang diharapkan oleh plugin DeltaShell.
* **Solusi**: Pastikan struktur jalurnya persis seperti:
  `<Instalasi_GUI>\plugins\DeltaShell.Dimr\kernels\x64\bin\dimr.exe`
  *(Catatan: Pada versi rilis terdahulu file `.dll` berada di folder `lib/`, pastikan pada versi terbaru semua file `.dll` berada berdampingan dengan file `.exe` di folder `bin/`)*.

---

## 6. Struktur Direktori Akhir dan Cheatsheet Perintah

### Ringkasan Alur Kerja Cepat (Quick Cheatsheet):

```cmd
:: 1. Buka Intel oneAPI Command Prompt for VS 2022
:: 2. Masuk ke folder project
d:
cd D:\Delft3D_FM

:: 3. Inisialisasi Conan (hanya satu kali)
python run_conan.py initialize external

:: 4. Build dan instalasi otomatis
python build.py --config fm-suite --build --build-dependencies

:: 5. Uji coba kernel
.\install_fm-suite\bin\dflowfm.exe --help
```

---

## 7. Distribusi Siap Pakai: Standalone All-in-One Installer (.exe)

Bagi rekan-rekan mahasiswa, peneliti, atau praktisi yang ingin langsung menggunakan Delft3D FM tanpa perlu melalui proses kompilasi manual atau konfigurasi lingkungan yang panjang, telah disediakan installer terpadu:

* **File Installer**: `D:\Delft3D_Flexible_Mesh\Installer_Output\Delft3D_FM_Suite_2026.02_AllInOne_Setup.exe`
* **Ukuran File**: ~703.4 MB
* **Checksum SHA256**: `56BCF9F3D873CF774752C0E9E7A880EF90DB5BBC4484C43FA8D5F6EAD0D04235`
* **Panduan Penggunaan**: [PANDUAN_INSTALASI_DELFT3D_FM_ALL_IN_ONE.md](file:///D:/Delft3D_Flexible_Mesh/PANDUAN_INSTALASI_DELFT3D_FM_ALL_IN_ONE.md)

Installer ini secara otomatis memasang:
1. DeltaShell GUI (OpenHMWQ 2026.02)
2. Solver Numerik Lengkap (D-Flow FM, D-Waves, D-Water Quality, D-Morphology)
3. QUICKPLOT Tool 2.72 (64-bit)
4. Model Kasus & Dataset Tutorial Resmi
5. **Konfigurasi Lisensi Otomatis**: Memfasilitasi pemilihan file lisensi resmi Deltares yang diperoleh pengguna secara mandiri dan mendaftarkannya ke sistem/registry FlexNet secara otomatis tanpa perlu konfigurasi manual.

---
*Dokumen ini dirancang sebagai acuan kerja resmi pengembang mandiri Delft3D FM.*  
*Sumber acuan: [Deltares Delft3D Official Repository](https://github.com/Deltares/Delft3D)*

