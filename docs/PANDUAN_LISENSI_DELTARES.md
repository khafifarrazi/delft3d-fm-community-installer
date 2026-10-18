# 🔑 Panduan Lengkap Perolehan Lisensi Resmi Deltares Delft3D FM

Dokumen ini menjelaskan tata cara resmi, legal, dan gratis (**€ 0.00**) untuk memperoleh file lisensi (`.lic`) Deltares Delft3D Flexible Mesh Suite secara langsung dari portal resmi Deltares, Belanda.

---

## 📌 Mengapa Lisensi Resmi Diperlukan?
Deltares merilis mesin simulasi (*calculation kernels*) Delft3D sebagai perangkat lunak sumber terbuka (*open source* under GPL/AGPL). Untuk antarmuka visual grafis (*DeltaShell GUI*), Deltares menggunakan sistem manajemen lisensi **FlexNet Publisher** yang mensyaratkan file lisensi valid bertanda tangan digital resmi (*cryptographic signature*) dari Deltares.

Lisensi ini diberikan secara **cuma-cuma (100% Free of Charge & Legal)** bagi seluruh komunitas akademik, mahasiswa, peneliti, dan praktisi di seluruh dunia.

---

## 🚀 Langkah-langkah Memperoleh Lisensi Resmi

### 1. Buka Portal Registrasi Deltares
Kunjungi tautan produk resmi di bawah ini:
👉 **[Deltares Software Download: Delft3D FM Suite GUI Open Source](https://download.deltares.nl/delft3d-fm-suite-2d3d-graphical-user-interface-gui-open-source)**

*(Alternatif: Buka [https://download.deltares.nl/](https://download.deltares.nl/) dan cari `"Delft3D FM Suite 2D3D Graphical User Interface (GUI) Open Source"`)*.

### 2. Tambahkan ke Keranjang Belanja (*Order*)
* Pada halaman produk, klik tombol **"Order"** atau **"Add to Cart"**.
* Perhatikan harga yang tertera: **€ 0.00 (Gratis)**.
* Klik tombol **"View Cart"** atau **"Checkout"**.

### 3. Lengkapi Formulir Identitas Pengguna
Isi kolom formulir dengan data Anda:
* **First Name & Last Name**: Nama lengkap Anda.
* **Email Address**: Alamat email aktif (sangat disarankan menggunakan email institusi/kampus atau email pribadi yang dapat Anda akses).
* **Company / Organization**: Nama Universitas, Politeknik, Lembaga Riset, atau Perusahaan Anda.
* **Country**: Indonesia.
* **Intended Use**: Pilih *Education*, *Research*, atau *General*.
* Centang kotak persetujuan:
  * ☑️ *I accept the Deltares software license terms and conditions.*
* Klik tombol **"Submit Order"** / **"Send Request"**.

### 4. Periksa Email Masuk
Dalam waktu 1 hingga 5 menit:
1. Buka kotak masuk (*inbox*) email Anda.  
   *(Jika belum muncul, periksa juga folder **Spam** atau **Promotions**)*.
2. Anda akan menerima email resmi dari Deltares (biasanya dengan subjek *"Your Deltares Software Order"*).
3. Di dalam email terdapat tautan atau lampiran berkas lisensi berekstensi `.lic` (misalnya: `Delft3D_FM_2D3D_GUI_OSS.lic` atau `license.lic`).
4. Unduh berkas `.lic` tersebut dan simpan di komputer Anda.

---

## 🛠️ Cara Mengaktifkan Lisensi di Komputer Anda

### Skenario A: Saat Menginstal dengan All-in-One Installer
1. Jalankan `Delft3D_FM_Suite_2026.02_AllInOne_Setup.exe` (*Run as administrator*).
2. Pada halaman **Konfigurasi Lisensi**:
   * Pilih opsi: **"Pilih file lisensi (.lic) resmi yang sudah saya peroleh dari Deltares"**.
   * Klik **Next** -> Klik tombol **Browse** -> Pilih file `.lic` yang Anda unduh dari email Deltares.
3. Installer akan otomatis menyalin lisensi ke direktori sistem Windows dan mengonfigurasi Registry FlexNet.

### Skenario B: Memasang atau Memperbarui Lisensi Secara Manual
Jika Anda sudah menginstal aplikasi sebelumnya atau masa berlaku lisensi Anda telah habis:
1. Buka File Explorer di Windows.
2. Masuk ke direktori:
   ```
   C:\Program Files (x86)\DS_Flex\
   ```
   *(Jika folder belum ada, buat folder baru dengan nama `DS_Flex` di dalam `C:\Program Files (x86)\`)*.
3. Salin (*copy-paste*) file `.lic` resmi Anda ke dalam folder tersebut.
4. Buka aplikasi Delft3D FM. DeltaShell akan langsung mendeteksi lisensi tersebut secara otomatis.

---

## 🔍 Pertanyaan Umum seputar Lisensi (FAQ)

### ❓ Apakah lisensi ini memiliki masa kadaluarsa?
Ya. Deltares biasanya menerbitkan lisensi komunitas open source dengan masa aktif **1 hingga 2 tahun**. Jika masa aktif telah habis, Anda cukup mengulang langkah registrasi di atas di portal Deltares untuk mendapatkan berkas lisensi baru secara gratis, lalu letakkan berkas baru tersebut di folder `C:\Program Files (x86)\DS_Flex\`.

### ❓ Apakah lisensi ini terikat pada satu komputer saja?
Lisensi Open Source resmi dari portal Deltares umumnya memiliki parameter `HOSTID=ANY`, yang berarti dapat digunakan pada komputer/laptop manapun tanpa perlu registrasi MAC Address khusus.

### ❓ Bagaimana jika muncul error "License file not found" saat membuka aplikasi?
1. Pastikan file `.lic` Anda berada di: `C:\Program Files (x86)\DS_Flex\`.
2. Pastikan ekstensi file benar-benar `.lic` (bukan `.lic.txt`).
3. Periksa registry Windows:
   * Tekan `Win + R` -> ketik `regedit` -> Enter.
   * Arahkan ke: `HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\FLEXlm License Manager`
   * Pastikan key `DHSDELFT_LICENSE_FILE` bernilai: `;C:\Program Files (x86)\DS_Flex;`
