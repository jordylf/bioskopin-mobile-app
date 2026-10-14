# 🎬 Bioskopin - Mobile Cinema Booking App & API

Bioskopin adalah aplikasi mobile pemesanan tiket bioskop berbasis **Flutter** dengan arsitektur **Clean Architecture (BLoC Pattern)**, yang terintegrasi dengan RESTful API backend berbasis **PHP Native** & **MySQL**.

---

## 📁 Struktur Repositori

```text
bioskopin-mobile-app/
├── bioskopin-app/       # Frontend Mobile App (Flutter)
│   ├── android/         # Android Native Configuration
│   ├── assets/          # Static Assets (Images, Icons)
│   ├── lib/             # Flutter Clean Architecture Source Code
│   │   ├── config/      # Theme & GoRouter configuration
│   │   ├── core/        # Widgets, Constants, Injection Container, Utilities
│   │   └── features/    # Authentication, Booking, Film, Home, Profile
│   └── pubspec.yaml     # Dependencies & Metadata
├── bioskopin-api/       # Backend RESTful API (PHP Native)
│   ├── auth/            # Endpoint Login & Register
│   ├── booking/         # Endpoint CRUD Booking Tiket
│   ├── config/          # Database Connection (PDO/MySQLi)
│   ├── film/            # Endpoint CRUD Film & Jadwal
│   ├── jwt/             # JWT Encoding & Verification Helper
│   ├── profile/         # Endpoint User Profile
│   ├── bioskopin.sql    # Database Dump MySQL
│   └── composer.json    # Composer Dependencies (Firebase JWT)
└── README.md
```

---

## 🚀 Fitur Utama

- **Autentikasi Pengguna**: Registrasi akun baru, Login dengan token JWT, dan sesi tersimpan lokal (`shared_preferences`).
- **Katalog Film (Home)**: Tampilan daftar film yang sedang tayang, detail sinopsis, genre, durasi, dan poster.
- **Pemesanan Tiket (Booking)**: Pemilihan film, jumlah tiket, dan pembuatan order pemesanan.
- **Riwayat Booking**: Melihat daftar tiket yang telah dipesan beserta statusnya (`pending`, `confirmed`, `canceled`).
- **Manajemen Profil**: Melihat profil pengguna dan update data akun.

---

## 🛠️ Tech Stack & Dependencies

### Mobile App (Flutter)
- **State Management**: `flutter_bloc` / `bloc` (Cubit & BLoC)
- **Networking**: `dio`, `retrofit`
- **Routing**: `go_router`
- **Dependency Injection**: `get_it`
- **Functional Programming**: `dartz` (Either error handling)
- **Serialization**: `json_annotation`, `json_serializable`, `build_runner`
- **UI Enhancements**: `skeletonizer`, `overlay_loader_with_app_icon`, `intl`

### Backend API & Database
- **Language**: PHP Native
- **Authentication**: `firebase/php-jwt`
- **Database**: MySQL / MariaDB
- **Documentation**: [Postman Collection Documenter](https://documenter.getpostman.com/view/39377679/2sAYJ7eyQP)

---

## ⚙️ Petunjuk Menjalankan Proyek

### 1. Setup Backend API (`bioskopin-api`)
1. Tempatkan folder `bioskopin-api` pada web server lokal Anda (misal `htdocs` di XAMPP atau `www` di Laragon).
2. Buat database baru di MySQL dengan nama `bioskopin`.
3. Import file database:
   ```bash
   mysql -u root bioskopin < bioskopin-api/bioskopin.sql
   ```
4. Sesuaikan konfigurasi database pada `bioskopin-api/config/database.php` jika diperlukan:
   ```php
   private $host = "localhost";
   private $db_name = "bioskopin";
   private $username = "root";
   private $password = "";
   ```
5. Install dependensi Composer untuk JWT:
   ```bash
   cd bioskopin-api
   composer install
   ```

### 2. Setup Mobile App (`bioskopin-app`)
1. Masuk ke direktori aplikasi Flutter:
   ```bash
   cd bioskopin-app
   ```
2. Sesuaikan `apiBaseUrl` pada file `lib/core/constants/constants.dart` dengan URL backend API Anda (IP lokal / ngrok / live URL).
3. Install dependensi Flutter:
   ```bash
   flutter pub get
   ```
4. Jalankan aplikasi pada emulator atau perangkat fisik:
   ```bash
   flutter run
   ```

---

## 📄 Lisensi & Kontributor
- **Pengembang**: Jordy Lian Ferdinand ([@jordylf](https://github.com/jordylf))
- Dibuat untuk keperluan Tugas UAS Praktik Mobile Computing.
