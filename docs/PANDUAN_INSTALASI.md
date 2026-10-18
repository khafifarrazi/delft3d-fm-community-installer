# 🌊 Panduan Instalasi & Distribusi Delft3D Flexible Mesh Suite (All-in-One)

Installer mandiri (*All-in-One Installer*) ini dirancang khusus agar Anda dan rekan-rekan Anda (mahasiswa, peneliti, perekayasa, dan praktisi) dapat menginstal **Delft3D Flexible Mesh Suite 2026.02** secara gratis, instan, dan siap pakai tanpa perlu kompilasi manual atau konfigurasi lingkungan yang rumit.

---

### 📌 Informasi Berkas Installer:
* **Tautan Unduh Google Drive**: [**Unduh Installer (Google Drive Folder)**](https://drive.google.com/drive/folders/1n4nYRUO1JAszAicliTmhP5IbFDc4uOIP?usp=sharing)
* **Nama Berkas**: `Delft3D_FM_Suite_2026.02_AllInOne_Setup.exe`
* **Ukuran Berkas**: `703.4 MB` (737,618,133 bytes)
* **Status**: Siap didistribusikan / dipasang langsung (Bebas data pribadi)
* **SHA256**: `56BCF9F3D873CF774752C0E9E7A880EF90DB5BBC4484C43FA8D5F6EAD0D04235`

---

## 📦 Apa Saja yang Ada di Dalam Installer Ini?

Installer ini mengemas seluruh ekosistem Delft3D FM dalam 1 file `.exe` tunggal:
1. **DeltaShell GUI (OpenHMWQ 2026.02)**: Antarmuka grafis resmi Deltares untuk pemodelan 1D, 2D, dan 3D.
2. **Mesin Kalkulasi Lengkap (Kernels x64)**:
   - **D-Flow FM**: Solver hidrodinamika jaring fleksibel tak terstruktur (unstructured mesh).
   - **D-Waves (SWAN)**: Solver propagasi dan spektral gelombang laut/pantai.
   - **D-Water Quality (DELWAQ)**: Solver kualitas air dan transpor polutan.
   - **D-Morphology**: Solver transpor sedimen dan perubahan morfologi dasar air.
   - Pustaka numerik komputasi performa tinggi: **Intel MKL**, **PETSc**, **NetCDF**, **HDF5**, dan **OpenMP**.
3. **QUICKPLOT Tool (Windows 64-bit)**: Perangkat lunak visualisasi analisis hasil simulasi (peta kontur, vektor arus, profil vertikal, dan time-series).
4. **Tutorials & Studi Kasus Resmi**: Kumpulan data model tutorial resmi dari Deltares (Scheldt estuary, tutorial 1-4, dll.).
5. **Konfigurasi Lingkungan FlexNet Otomatis**: Menyiapkan registry dan folder lisensi `C:\Program Files (x86)\DS_Flex` secara otomatis saat instalasi.

> [!IMPORTANT]
> **Privasi & Keamanan Data Pengguna:**  
> Untuk melindungi data pribadi dan privasi pemilik berkas, paket installer ini **TIDAK menyertakan file lisensi pribadi siapapun**.  
> Setiap pengguna (mahasiswa/peneliti) diarahkan untuk memperoleh file lisensi resmi **GRATIS (100% Legal)** atas nama sendiri/institusi langsung dari portal resmi Deltares dengan langkah mudah di bawah ini.

---

## 🔑 Langkah 1: Dapatkan Lisensi Resmi Gratis dari Deltares

Sebelum atau saat menginstal, dapatkan file lisensi `.lic` resmi Anda dari Deltares:

1. **Buka Portal Resmi Deltares**:
   Kunjungi halaman pendaftaran lisensi Open Source resmi:  
   👉 **[Deltares Software Download - Delft3D FM Suite GUI Open Source](https://download.deltares.nl/delft3d-fm-suite-2d3d-graphical-user-interface-gui-open-source)**  
   *(Atau buka [https://download.deltares.nl/](https://download.deltares.nl/) dan cari "Delft3D FM Suite 2D3D GUI Open Source")*.

2. **Masukkan ke Keranjang (Order € 0.00)**:
   - Pada halaman produk, klik tombol **"Order"** atau **"Add to Cart"** (Biaya: **€ 0.00 / Gratis & Legal**).
   - Klik **"Checkout"** atau **"View Cart"** untuk melanjutkan.

3. **Isi Formulir Pendaftaran**:
   - Masukkan informasi pengguna:
     - **Nama Lengkap**
     - **Alamat Email Aktif** *(Gunakan email kampus/pribadi)*
     - **Nama Institusi/Universitas/Perusahaan**
     - **Negara**: Indonesia
     - **Tujuan Penggunaan**: Educational / Research / General.
   - Centang persetujuan lisensi (*Terms & Conditions*), lalu klik **"Submit Order"** / **"Complete"**.

4. **Unduh File Lisensi dari Email**:
   - Periksa kotak masuk email Anda (cek juga folder *Spam* jika belum masuk dalam 1–5 menit).
   - Deltares akan mengirimkan email konfirmasi pesanan berisikan lampiran atau tautan unduh file lisensi `.lic` (misalnya: `Delft3D_FM_2D3D_GUI_OSS.lic` atau `license.lic`).
   - Simpan file `.lic` tersebut di komputer Anda (misalnya di folder *Downloads* atau *Desktop*).

---

## 🚀 Langkah 2: Jalankan Installer

1. **Buka Installer**:
   Cari file installer:
   ```
   Delft3D_FM_Suite_2026.02_AllInOne_Setup.exe
   ```
   Klik kanan file tersebut, lalu pilih **Run as administrator**.

2. **Ikuti Wizard Instalasi**:
   - **Welcome Screen**: Klik **Next**.
   - **Pilih Lokasi Instalasi**: Secara default di `C:\Program Files\Deltares\Delft3D FM Suite 2026.02 OpenHMWQ` (bisa diubah sesuai kebutuhan).
   - **Pilih Komponen**: Pastikan Core, QuickPlot, dan Tutorials dicentang.
   - **Halaman Opsi Lisensi (License Configuration)**:
     - 🔘 **Opsi 1: Pilih file lisensi (.lic) resmi yang sudah saya peroleh dari Deltares (Direkomendasikan)**:  
       Klik **Next** -> Klik tombol **Browse** -> Pilih file `.lic` yang Anda unduh dari email Deltares pada Langkah 1.  
       *Installer akan secara otomatis menyalin lisensi tersebut ke `C:\Program Files (x86)\DS_Flex\` dan mengonfigurasi registry Windows.*
     - 🔘 **Opsi 2: Lewati**:  
       Pilih opsi ini jika Anda belum mengunduh lisensi saat ini dan ingin menyalinnya secara manual nanti.
   - **Pilih Shortcut**: Centang pembuatan shortcut Desktop untuk **Delft3D FM** dan **QUICKPLOT**.
   - **Install**: Klik tombol **Install** dan tunggu hingga selesai.

---

## 🎯 Membuka Aplikasi & Memulai Pemodelan

Setelah instalasi selesai:
1. Buka icon **Delft3D FM Suite 2026.02** di Desktop Anda (atau dari menu Start).
2. DeltaShell GUI akan langsung terbuka tanpa peringatan lisensi hilang (*License missing error*).
3. Untuk mencoba model pertama kali:
   - Di DeltaShell, buka menu: `File` -> `Open Project...`
   - Arahkan ke folder:
     `C:\Program Files\Deltares\Delft3D FM Suite 2026.02 OpenHMWQ\tutorials\`
   - Buka contoh studi kasus yang tersedia (misal di folder `Tutorial_D-Flow_FM\tutorial01`).

---

## 🛠️ Persyaratan Sistem Minimum (Prerequisites)

Untuk komputer yang masih baru atau belum pernah menginstal perangkat lunak rekayasa/sains:
1. **Sistem Operasi**: Windows 10 atau Windows 11 (64-bit).
2. **RAM**: Minimal 8 GB (disarankan 16 GB atau lebih untuk simulasi grid besar).
3. **Microsoft Visual C++ Redistributable (2015-2022 x64)**:
   - Biasanya sudah terpasang otomatis di Windows Update.
   - Jika saat menjalankan solver muncul pesan kehilangan `msvcp140.dll` atau `vcruntime140.dll`, unduh paket gratis resmi Microsoft di:
     [https://aka.ms/vs/17/release/vc_redist.x64.exe](https://aka.ms/vs/17/release/vc_redist.x64.exe)

---

## 🤝 Berbagi ke Rekan-rekan

Anda cukup membagikan file:
`Delft3D_FM_Suite_2026.02_AllInOne_Setup.exe` (misalnya melalui Google Drive, flashdisk, atau server lokal kampus/kantor). Rekan Anda hanya perlu mendownload dan menjalankannya!
