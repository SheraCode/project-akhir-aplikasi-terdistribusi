-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 15 Bulan Mei 2024 pada 09.53
-- Versi server: 10.4.24-MariaDB
-- Versi PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `server_jemaat`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetImageNameFromDatabaseProcedure` (IN `jemaatID` VARCHAR(50), OUT `imageName` VARCHAR(255))   BEGIN
    SELECT foto_jemaat INTO imageName FROM jemaat WHERE id_jemaat = jemaatID;
    
    IF imageName IS NULL THEN
        SET imageName = 'image not found';
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetJemaat` (IN `jemaat_id` INT)   BEGIN
    SELECT
        j.id_jemaat,
        j.nama_depan,
        j.nama_belakang,
        j.jenis_kelamin,
        j.alamat,
        j.id_bidang_pendidikan,
        j.id_pekerjaan,
        j.no_hp,
        j.isBaptis,
        j.isSidi,
        j.isMenikah,
        j.isMeninggal,
        j.keterangan,
        j.id_pendidikan
    FROM
        jemaat j
    WHERE
        j.id_jemaat = jemaat_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetJemaatBirthdayToday` ()   BEGIN
    DECLARE today_month_day VARCHAR(5);
    
    -- Ambil bulan dan tanggal hari ini dalam format MM-DD
    SET today_month_day = DATE_FORMAT(NOW(), '%m-%d');
    
    -- Query untuk mengambil jemaat yang berulang tahun hari ini
    SELECT
        id_jemaat,
        nama_depan,
        nama_belakang,
        tgl_lahir,
        foto_jemaat  -- Menambahkan kolom foto_jemaat
    FROM
        jemaat
    WHERE
        DATE_FORMAT(tgl_lahir, '%m-%d') = today_month_day;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LoginProcedure` (IN `userEmail` VARCHAR(100), IN `userPassword` VARCHAR(100), OUT `jemaatID` INT, OUT `rolejemaat` VARCHAR(225), OUT `jemaatNamaDepan` VARCHAR(225), OUT `jemaatNamaBelakang` VARCHAR(225), OUT `jemaatEmail` VARCHAR(225), OUT `jemaatPassword` VARCHAR(225), OUT `jemaatGelarDepan` VARCHAR(225), OUT `jemaatGelarBelakang` VARCHAR(225), OUT `jemaatTempatLahir` VARCHAR(50), OUT `jemaatJenisKelamin` VARCHAR(225), OUT `jemaatIDHubKeluarga` INT, OUT `jemaatIDStatusPernikahan` INT, OUT `jemaatIDStatusAmaIna` INT, OUT `jemaatIDStatusAnak` INT, OUT `jemaatIDPendidikan` INT, OUT `jemaatIDBidangPendidikan` INT, OUT `jemaatBidangPendidikanLainnya` VARCHAR(225), OUT `jemaatIDPekerjaan` INT, OUT `jemaatNamaPekerjaanLainnya` VARCHAR(225), OUT `jemaatGolDarah` VARCHAR(225), OUT `jemaatAlamat` VARCHAR(455), OUT `jemaatIsSidi` VARCHAR(225), OUT `jemaatIDKecamatan` INT, OUT `jemaatNoTelepon` INT, OUT `jemaatNoHP` INT, OUT `jemaatFotoJemaat` VARCHAR(500), OUT `jemaatKeterangan` VARCHAR(500), OUT `jemaatIsBaptis` VARCHAR(225), OUT `jemaatIsMenikah` VARCHAR(225), OUT `jemaatIsMeninggal` VARCHAR(225), OUT `jemaatIsRPP` VARCHAR(225), OUT `jemaatCreateAt` TIMESTAMP, OUT `jemaatUpdateAt` TIMESTAMP, OUT `jemaatIsDeleted` TIMESTAMP)   BEGIN
    DECLARE rowCount INT DEFAULT 0;

    -- Hitung jumlah baris yang sesuai dengan email dan password yang diberikan
    SELECT COUNT(*) INTO rowCount FROM jemaat WHERE email = userEmail AND PASSWORD = userPassword;

    -- Jika ada baris yang sesuai, ambil data jemaat
    IF rowCount = 1 THEN
        SELECT id_jemaat, role_jemaat,nama_depan, nama_belakang, email, PASSWORD, gelar_depan, gelar_belakang, tempat_lahir,
               jenis_kelamin, id_hub_keluarga, id_status_pernikahan, id_status_ama_ina, id_status_anak, id_pendidikan,
               id_bidang_pendidikan, bidang_pendidikan_lainnya, id_pekerjaan, nama_pekerjaan_lainnya, gol_darah,
               alamat, isSidi, id_kecamatan, no_telepon, no_hp, foto_jemaat, keterangan, isBaptis, isMenikah,
               isMeninggal, isRPP, create_at, update_at, is_deleted
        INTO jemaatID, rolejemaat,jemaatNamaDepan, jemaatNamaBelakang, jemaatEmail, jemaatPassword, jemaatGelarDepan,
             jemaatGelarBelakang, jemaatTempatLahir, jemaatJenisKelamin, jemaatIDHubKeluarga, jemaatIDStatusPernikahan,
             jemaatIDStatusAmaIna, jemaatIDStatusAnak, jemaatIDPendidikan, jemaatIDBidangPendidikan,
             jemaatBidangPendidikanLainnya, jemaatIDPekerjaan, jemaatNamaPekerjaanLainnya, jemaatGolDarah, jemaatAlamat,
             jemaatIsSidi, jemaatIDKecamatan, jemaatNoTelepon, jemaatNoHP, jemaatFotoJemaat, jemaatKeterangan,
             jemaatIsBaptis, jemaatIsMenikah, jemaatIsMeninggal, jemaatIsRPP, jemaatCreateAt, jemaatUpdateAt, jemaatIsDeleted
        FROM jemaat
        WHERE email = userEmail AND PASSWORD = userPassword;
    ELSE
        -- Jika tidak ada baris yang sesuai, kembalikan NULL untuk semua output
        SET jemaatID = NULL;
        SET rolejemaat = NULL;
        SET jemaatNamaDepan = NULL;
        SET jemaatNamaBelakang = NULL;
        SET jemaatEmail = NULL;
        SET jemaatPassword = NULL;
        SET jemaatGelarDepan = NULL;
        SET jemaatGelarBelakang = NULL;
        SET jemaatTempatLahir = NULL;
        SET jemaatJenisKelamin = NULL;
        SET jemaatIDHubKeluarga = NULL;
        SET jemaatIDStatusPernikahan = NULL;
        SET jemaatIDStatusAmaIna = NULL;
        SET jemaatIDStatusAnak = NULL;
        SET jemaatIDPendidikan = NULL;
        SET jemaatIDBidangPendidikan = NULL;
        SET jemaatBidangPendidikanLainnya = NULL;
        SET jemaatIDPekerjaan = NULL;
        SET jemaatNamaPekerjaanLainnya = NULL;
        SET jemaatGolDarah = NULL;
        SET jemaatAlamat = NULL;
        SET jemaatIsSidi = NULL;
        SET jemaatIDKecamatan = NULL;
        SET jemaatNoTelepon = NULL;
        SET jemaatNoHP = NULL;
        SET jemaatFotoJemaat = NULL;
        SET jemaatKeterangan = NULL;
        SET jemaatIsBaptis = NULL;
        SET jemaatIsMenikah = NULL;
        SET jemaatIsMeninggal = NULL;
        SET jemaatIsRPP = NULL;
        SET jemaatCreateAt = NULL;
        SET jemaatUpdateAt = NULL;
        SET jemaatIsDeleted = NULL;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateJemaatProcedure` (IN `jemaatID` INT, IN `namaDepan` VARCHAR(225), IN `namaBelakang` VARCHAR(225), IN `jenisKelamin` VARCHAR(225), IN `alamat` VARCHAR(455), IN `idBidangPendidikan` INT, IN `idPekerjaan` INT, IN `noHP` VARCHAR(225), IN `isBaptis` VARCHAR(225), IN `isMenikah` VARCHAR(225), IN `isMeninggal` VARCHAR(225), IN `keterangan` VARCHAR(500), IN `email` VARCHAR(225), IN `PASSWORD` VARCHAR(225), IN `bidangPendidikanLainnya` VARCHAR(225), IN `namaPekerjaanLainnya` VARCHAR(225))   BEGIN
    UPDATE jemaat SET
        nama_depan = namaDepan,
        nama_belakang = namaBelakang,
        jenis_kelamin = jenisKelamin,
        alamat = alamat,
        id_bidang_pendidikan = idBidangPendidikan,
        id_pekerjaan = idPekerjaan,
        no_hp = noHP,
        isBaptis = isBaptis,
        isMenikah = isMenikah,
        isMeninggal = isMeninggal,
        keterangan = keterangan,
        email = email,
        PASSWORD = PASSWORD,
        bidang_pendidikan_lainnya = bidangPendidikanLainnya,
        nama_pekerjaan_lainnya = namaPekerjaanLainnya
    WHERE id_jemaat = jemaatID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateJemaatProfileProcedure` (IN `jemaatID` INT, IN `namaDepan` VARCHAR(225), IN `namaBelakang` VARCHAR(225), IN `tempatLahir` VARCHAR(225), IN `noHP` VARCHAR(225), IN `alamat` VARCHAR(455), IN `email` VARCHAR(225))   BEGIN
    UPDATE jemaat SET
        nama_depan = namaDepan,
        nama_belakang = namaBelakang,
        tempat_lahir = tempatLahir,
        no_hp = noHP,
        alamat = alamat,
        email = email
    WHERE id_jemaat = jemaatID;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `bidang_pendidikan`
--

CREATE TABLE `bidang_pendidikan` (
  `id_bidang_pendidikan` int(11) NOT NULL,
  `nama_bidang_pendidikan` varchar(225) NOT NULL,
  `keterangan` varchar(225) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `bidang_pendidikan`
--

INSERT INTO `bidang_pendidikan` (`id_bidang_pendidikan`, `nama_bidang_pendidikan`, `keterangan`, `create_at`, `update_at`, `is_deleted`) VALUES
(0, 'Pilih Pendidikan', 'Pilih Pendidikan Anda', '2024-04-01 23:47:53', '2024-04-01 23:47:53', '2024-04-01 23:47:53'),
(1, 'Pendidikan Formal (SD,SMP,SMA)', 'Pendidikan umum merupakan pendidikan dasar dan menengah yang mengutamakan perluasan pengetahuan yang diperlukan oleh peserta didik untuk melanjutkan pendidikan ke jenjang yang lebih tinggi.', '2024-03-31 20:33:53', '2024-03-31 20:33:53', '2024-03-31 20:33:53'),
(2, 'Pendidikan Kejuruan (SMK)', 'Pendidikan kejuruan merupakan pendidikan menengah yang mempersiapkan peserta didik terutama untuk bekerja dalam bidang tertentu.', '2024-03-31 20:34:50', '2024-03-31 20:34:50', '2024-03-31 20:34:50'),
(3, 'Pendidikan Profesi', 'Pendidikan profesi merupakan pendidikan tinggi setelah program sarjana yang mempersiapkan peserta didik untuk memasuki suatu profesi atau menjadi seorang profesional.', '2024-03-31 20:35:54', '2024-03-31 20:35:54', '2024-03-31 20:35:54'),
(4, 'Pendidikan Vokasi', 'Pendidikan vokasi merupakan pendidikan tinggi yang mempersiapkan peserta didik untuk memiliki pekerjaan dengan keahlian terapan tertentu maksimal dalam jenjang diploma 4 setara dengan program sarjana (strata 1).', '2024-03-31 20:36:15', '2024-03-31 20:36:15', '2024-03-31 20:36:15'),
(5, 'Pendidikan Keagamaan', 'Pendidikan keagamaan merupakan pendidikan dasar, menengah, dan tinggi yang mempersiapkan peserta didik untuk dapat menjalankan peranan yang menuntut penguasaan pengetahuan dan pengalaman terhadap ajaran agama ', '2024-03-31 20:36:46', '2024-03-31 20:36:46', '2024-03-31 20:36:46'),
(6, 'Pendidikan Khusus', 'Pendidikan khusus merupakan penyelenggaraan pendidikan untuk peserta didik yang berkebutuhan khusus atau peserta didik yang memiliki kecerdasan luar biasa yang diselenggarakan secara inklusif (bergabung dengan sekolah biasa) ', '2024-03-31 20:37:14', '2024-03-31 20:37:14', '2024-03-31 20:37:14'),
(7, 'Pilih Bidang Pendidikan Anda', 'Pilih Bidang Pendidikan Anda Sekarang', '2024-04-01 01:17:43', '2024-04-01 01:17:43', '2024-04-01 01:17:43');

-- --------------------------------------------------------

--
-- Struktur dari tabel `hubungan_keluarga`
--

CREATE TABLE `hubungan_keluarga` (
  `id_hub_keluarga` int(11) NOT NULL,
  `nama_hub_keluarga` varchar(225) NOT NULL,
  `keterangan` varchar(225) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `hubungan_keluarga`
--

INSERT INTO `hubungan_keluarga` (`id_hub_keluarga`, `nama_hub_keluarga`, `keterangan`, `create_at`, `update_at`, `is_deleted`) VALUES
(0, 'Isi Hubungan Keluarga', 'Isi Hubungan Keluarga Anda', '2024-04-01 08:14:40', '2024-04-01 08:14:40', '2024-04-01 08:14:40'),
(1, 'Ayah', 'Orang Tua Dalam Keluarga', '2024-04-01 03:15:49', '2024-04-01 03:16:23', '2024-04-01 03:16:23'),
(2, 'Ibu', 'Orang Tua Dalam Keluarga', '2024-04-01 03:16:30', '2024-04-01 03:16:50', '2024-04-01 03:16:50'),
(3, 'Anak', 'Anak Dalam Keluarga', '2024-04-01 03:17:34', '2024-04-01 03:17:34', '2024-04-01 03:17:34'),
(4, 'Saudara Kandung', 'Saudara Kandung Di Dalam Keluarga', '2024-04-01 03:18:05', '2024-04-01 03:18:05', '2024-04-01 03:18:05');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jemaat`
--

CREATE TABLE `jemaat` (
  `id_jemaat` int(11) NOT NULL,
  `role_jemaat` varchar(225) NOT NULL DEFAULT 'jemaat',
  `nama_depan` varchar(225) NOT NULL,
  `nama_belakang` varchar(225) NOT NULL,
  `tgl_lahir` varchar(225) NOT NULL DEFAULT 'Isi tgl lahir',
  `email` varchar(225) DEFAULT 'Isi Email Anda',
  `password` varchar(225) DEFAULT 'Isi Password Anda',
  `gelar_depan` varchar(225) DEFAULT 'Isi Gelar Anda',
  `gelar_belakang` varchar(225) DEFAULT 'Isi Gelar Anda',
  `tempat_lahir` varchar(50) DEFAULT 'Isi Tempat Lahir',
  `jenis_kelamin` varchar(225) DEFAULT 'Isi Jenis Kelamin',
  `id_hub_keluarga` int(11) DEFAULT 0,
  `id_status_pernikahan` int(11) DEFAULT 0,
  `id_status_ama_ina` int(11) DEFAULT 0,
  `id_status_anak` int(11) DEFAULT 0,
  `id_pendidikan` int(11) DEFAULT 0,
  `id_bidang_pendidikan` int(11) DEFAULT 0,
  `bidang_pendidikan_lainnya` varchar(225) DEFAULT 'Isi Bidang Pendidikan Lainnya(opsional)',
  `id_pekerjaan` int(11) DEFAULT 0,
  `nama_pekerjaan_lainnya` varchar(225) DEFAULT 'Isi Bidang Pendidikan Lainnya',
  `gol_darah` varchar(225) DEFAULT 'Pilih Gol Darah',
  `alamat` varchar(455) DEFAULT 'Isi Alamat Anda',
  `isSidi` varchar(225) DEFAULT 'Pilih Status Sidi Anda',
  `id_kecamatan` int(11) DEFAULT 0,
  `no_telepon` varchar(50) DEFAULT '0',
  `no_hp` int(11) DEFAULT 0,
  `foto_jemaat` varchar(500) DEFAULT 'avatarjemaat.jpg',
  `keterangan` varchar(500) DEFAULT 'Isi Ketarangan',
  `isBaptis` varchar(225) DEFAULT 'Pilih Status Baptis',
  `isMenikah` varchar(225) DEFAULT 'Pilih Status Menikah',
  `isMeninggal` varchar(225) DEFAULT 'tidak',
  `isRPP` varchar(225) DEFAULT 'tidak',
  `create_at` timestamp NULL DEFAULT current_timestamp(),
  `update_at` timestamp NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `jemaat`
--

INSERT INTO `jemaat` (`id_jemaat`, `role_jemaat`, `nama_depan`, `nama_belakang`, `tgl_lahir`, `email`, `password`, `gelar_depan`, `gelar_belakang`, `tempat_lahir`, `jenis_kelamin`, `id_hub_keluarga`, `id_status_pernikahan`, `id_status_ama_ina`, `id_status_anak`, `id_pendidikan`, `id_bidang_pendidikan`, `bidang_pendidikan_lainnya`, `id_pekerjaan`, `nama_pekerjaan_lainnya`, `gol_darah`, `alamat`, `isSidi`, `id_kecamatan`, `no_telepon`, `no_hp`, `foto_jemaat`, `keterangan`, `isBaptis`, `isMenikah`, `isMeninggal`, `isRPP`, `create_at`, `update_at`, `is_deleted`) VALUES
(2, 'jemaat', 'Miranda', 'Angeliaa', '2004-4-27', 'mirandaangelia@gmail.com', 'miranda27', 'Isi Gelar Anda', 'Isi Gelar Anda', 'Jakarta Selatan', 'Laki-laki', 3, 0, 0, 0, 4, 0, 'Pendidikan Hobi', 5, 'Software Developer', 'AB', 'Jln Sudirman Nomor 136', 'Sidi', 10, '0', 0, '@reallygreatsite.png', '', 'Baptis', 'Menikah', '', 'tidak', '2024-04-01 08:25:09', '2024-04-01 08:25:09', '2024-04-01 08:25:09'),
(3, 'majelis', 'Johannes Bastian Jasa', 'Sipayung', '2005-4-27', 'johannesssipayung27@gmail.com', 'oan123', 'Isi Gelar Anda', 'Isi Gelar Anda', 'Isi Tempat Lahir', 'Laki-laki', 3, 0, 0, 0, 5, 3, '', 3, '', 'B', 'Sempurna Garden No 14', 'Sidi', 5, '0', 0, '31. Johannes Sipayung.JPG', '', 'Baptis', 'Belum Menikah', '', 'tidak', '2024-04-26 09:49:31', '2024-04-26 09:49:31', '2024-04-26 09:49:31');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jenis_status`
--

CREATE TABLE `jenis_status` (
  `id_jenis_status` int(11) NOT NULL,
  `jenis_status` varchar(225) NOT NULL,
  `keterangan` varchar(225) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `jenis_status`
--

INSERT INTO `jenis_status` (`id_jenis_status`, `jenis_status`, `keterangan`, `create_at`, `update_at`, `is_deleted`) VALUES
(1, 'Pernikahan', 'Status Pernikahan Di Dalam Jemaat\r\n', '2024-03-31 20:19:28', '2024-03-31 20:19:28', '2024-03-31 20:19:28'),
(2, 'Pembaptisan', 'Status Pembaptisan Di Dalam Keluarga', '2024-03-31 20:19:49', '2024-03-31 20:19:49', '2024-03-31 20:19:49'),
(3, 'Angkat Sidi', 'Status Angkat Sidi Di Dalam Jemaat', '2024-03-31 20:20:18', '2024-03-31 20:20:18', '2024-03-31 20:20:18'),
(4, 'Ama', 'Status Ama Di Dalam Jemaat', '2024-03-31 20:21:20', '2024-03-31 20:21:20', '2024-03-31 20:21:20'),
(5, 'Ina', 'Status Ina Di Dalam Jemaat', '2024-03-31 20:21:51', '2024-03-31 20:21:51', '2024-03-31 20:21:51'),
(6, 'Anak', 'Sebagai Anak Di Dalam Keluarga', '2024-03-31 20:31:39', '2024-03-31 20:31:39', '2024-03-31 20:31:39'),
(7, 'Pilih Status Anda', 'Pilih Status Anda Terlebih Dahulu', '2024-04-01 01:15:46', '2024-04-01 01:15:46', '2024-04-01 01:15:46'),
(8, 'Pendeta', 'Pendeta Gereja', '2024-04-15 19:30:51', '2024-04-15 19:30:51', '2024-04-15 19:30:51'),
(9, 'Pemusik Gereja', 'Pemusik Gereja HKBP Palmarum', '2024-04-15 19:31:07', '2024-04-15 19:31:07', '2024-04-15 19:31:07'),
(10, 'Majelis Jemaat', 'Majelis Jemaat HKBP Palmarum', '2024-04-15 20:38:16', '2024-04-15 20:38:16', '2024-04-15 20:38:16'),
(11, 'Bendahara', 'Bendahara Jemaat HKBP Palmarum Tarutung', '2024-04-19 02:49:03', '2024-04-19 02:49:03', '2024-04-19 02:49:03'),
(12, 'Menunggu Persetujuan', 'Menunggu Persetujuan Majelis HKBP Palmarum', '2024-04-29 18:49:24', '2024-04-29 18:49:24', '2024-04-29 18:49:24'),
(13, 'Ditolak ', 'Ditolak oleh Majelis HKBP Palmarum Tarutung', '2024-04-29 18:49:47', '2024-04-29 18:49:47', '2024-04-29 18:49:47'),
(14, 'Disetujui', 'Disetujui oleh Majelis HKBP Palmarum Tarutung', '2024-04-29 18:50:09', '2024-04-29 18:50:09', '2024-04-29 18:50:09');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kecamatan`
--

CREATE TABLE `kecamatan` (
  `id_kecamatan` int(11) NOT NULL,
  `nama_kecamatan` varchar(225) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `kecamatan`
--

INSERT INTO `kecamatan` (`id_kecamatan`, `nama_kecamatan`, `create_at`, `update_at`, `is_deleted`) VALUES
(0, 'Pilih Kecamatan Anda', '2024-04-01 08:18:39', '2024-04-01 08:18:39', '2024-04-01 08:18:39'),
(1, 'Kecamatan Adian Koting', '2024-04-01 06:47:32', '2024-04-01 06:47:32', '2024-04-01 06:47:32'),
(2, 'Kecamatan Garoga', '2024-04-01 06:48:11', '2024-04-01 06:48:11', '2024-04-01 06:48:11'),
(3, 'Kecamatan Muara', '2024-04-01 06:48:32', '2024-04-01 06:48:32', '2024-04-01 06:48:32'),
(4, 'kecamatan Pagaran\r\n', '2024-04-01 06:48:51', '2024-04-01 06:48:51', '2024-04-01 06:48:51'),
(5, 'Kecamatan Pahae Jae', '2024-04-01 06:49:03', '2024-04-01 06:49:03', '2024-04-01 06:49:03'),
(6, 'Kecamatan Pahae Julu', '2024-04-01 06:49:40', '2024-04-01 06:49:40', '2024-04-01 06:49:40'),
(7, 'Kecamatan Pangaribuan', '2024-04-01 06:49:55', '2024-04-01 06:49:55', '2024-04-01 06:49:55'),
(8, 'Kecamatan Parmonangan', '2024-04-01 06:50:07', '2024-04-01 06:50:07', '2024-04-01 06:50:07'),
(9, 'Kecamatan Purba Tua', '2024-04-01 06:50:19', '2024-04-01 06:50:19', '2024-04-01 06:50:19'),
(10, 'Kecamatan Siatas Barita', '2024-04-01 06:50:30', '2024-04-01 06:50:30', '2024-04-01 06:50:30'),
(11, 'Kecamatan Siborongborong', '2024-04-01 06:50:47', '2024-04-01 06:50:47', '2024-04-01 06:50:47'),
(12, 'Kecamatan Sipangumban', '2024-04-01 06:51:15', '2024-04-01 06:51:15', '2024-04-01 06:51:15'),
(13, 'Kecamatan Sipahutar', '2024-04-01 06:51:23', '2024-04-01 06:51:23', '2024-04-01 06:51:23'),
(14, 'Kecamatan Sipoholon', '2024-04-01 06:51:34', '2024-04-01 06:51:34', '2024-04-01 06:51:34'),
(15, 'Kecamatan Tarutung', '2024-04-01 06:51:48', '2024-04-01 06:51:48', '2024-04-01 06:51:48');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pekerjaan`
--

CREATE TABLE `pekerjaan` (
  `id_pekerjaan` int(11) NOT NULL,
  `pekerjaan` varchar(225) NOT NULL,
  `keterangan` varchar(225) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `pekerjaan`
--

INSERT INTO `pekerjaan` (`id_pekerjaan`, `pekerjaan`, `keterangan`, `create_at`, `update_at`, `is_deleted`) VALUES
(0, 'Tidak Bekerja', 'Tidak Bekerja Apapun', '2024-04-01 06:41:21', '2024-04-01 06:41:21', '2024-04-01 06:41:21'),
(1, 'Petani', 'Petani Ladang', '2024-04-01 06:44:28', '2024-04-01 06:44:28', '2024-04-01 06:44:28'),
(2, 'Pegawai Negara Sipil', 'PNS(Pegawai Negara Sipil)', '2024-04-01 06:45:03', '2024-04-01 06:45:03', '2024-04-01 06:45:03'),
(3, 'Pegawai Swasta', 'Pegawai BUMS', '2024-04-01 06:45:21', '2024-04-01 06:45:21', '2024-04-01 06:45:21'),
(4, 'Pegawai BUMN', 'Pegawai Badan Usaha Milik Negara', '2024-04-01 06:45:48', '2024-04-01 06:45:48', '2024-04-01 06:45:48'),
(5, 'Pilih Pekerjaan Anda', 'Pilih Pekerjaan Anda ', '2024-04-01 08:18:22', '2024-04-01 08:18:22', '2024-04-01 08:18:22');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pendidikan`
--

CREATE TABLE `pendidikan` (
  `id_pendidikan` int(11) NOT NULL,
  `pendidikan` varchar(225) NOT NULL,
  `keterangan` varchar(225) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `pendidikan`
--

INSERT INTO `pendidikan` (`id_pendidikan`, `pendidikan`, `keterangan`, `create_at`, `update_at`, `is_deleted`) VALUES
(0, 'Pilih Pendidikan Anda', 'Pilih Pendidikan Anda Terlebih Dahulu', '2024-04-01 08:17:02', '2024-04-01 08:17:02', '2024-04-01 08:17:02'),
(1, 'Sekolah Dasar', 'Pendidikan Sekolah Dasar', '2024-04-01 06:38:51', '2024-04-01 06:38:51', '2024-04-01 06:38:51'),
(2, 'Tidak Sekolah', 'Belum Sekolah/Tidak Sekolah', '2024-04-01 06:39:13', '2024-04-01 06:39:13', '2024-04-01 06:39:13'),
(3, 'SMP/SLTP', 'Sekolah Menengah Pertama', '2024-04-01 06:39:33', '2024-04-01 06:39:33', '2024-04-01 06:39:33'),
(4, 'SMA/SLTA', 'Sekolah Menengah Atas', '2024-04-01 06:39:47', '2024-04-01 06:39:47', '2024-04-01 06:39:47'),
(5, 'Diploma', 'Diploma (D1,D2,D3,D4)', '2024-04-01 06:40:15', '2024-04-01 06:40:15', '2024-04-01 06:40:15'),
(6, 'Strata 1', 'Pendidikan Strata 1', '2024-04-02 06:37:12', '2024-04-02 06:37:12', '2024-04-02 06:37:12'),
(7, 'Strata 2', 'Pendidikan Strata 2', '2024-04-01 06:40:29', '2024-04-01 06:40:29', '2024-04-01 06:40:29'),
(8, 'Strata 3', 'Pendidikan Strata 3', '2024-04-01 06:40:47', '2024-04-01 06:40:47', '2024-04-01 06:40:47');

-- --------------------------------------------------------

--
-- Struktur dari tabel `status`
--

CREATE TABLE `status` (
  `id_status` int(11) NOT NULL,
  `status` varchar(225) NOT NULL,
  `id_jenis_status` int(11) NOT NULL,
  `keterangan` varchar(225) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `status`
--

INSERT INTO `status` (`id_status`, `status`, `id_jenis_status`, `keterangan`, `create_at`, `update_at`, `is_deleted`) VALUES
(0, 'Pilih Status', 7, 'Pilih Status Anda sekarang', '2024-04-01 08:16:18', '2024-04-01 08:16:18', '2024-04-01 08:16:18'),
(1, 'Ama', 4, 'Sebagai Ama di Jemaat', '2024-04-01 03:27:15', '2024-04-01 03:27:15', '2024-04-01 03:27:15'),
(2, 'Ina', 5, 'Sebagai Ina di Jemaat', '2024-04-01 03:27:44', '2024-04-01 03:27:44', '2024-04-01 03:27:44'),
(3, 'Anak', 6, 'Sebagai Anak Di Jemaat', '2024-04-01 03:31:59', '2024-04-01 03:31:59', '2024-04-01 03:31:59'),
(7, 'Pemusik Gereja', 9, 'Pemusik Gereja HKBP Palmarum', '2024-04-16 02:31:47', '2024-04-16 02:31:47', '2024-04-16 02:31:47'),
(8, 'Pendeta', 8, 'Pendeta HKBP Palmarum HKBP Palmarum', '2024-04-16 02:32:07', '2024-04-16 02:32:07', '2024-04-16 02:32:07'),
(9, 'Majelis Jemaat', 10, 'Majelis Jemaat HKBP Palmarum', '2024-04-16 03:38:54', '2024-04-16 03:38:54', '2024-04-16 03:38:54'),
(10, 'Bendahara', 11, 'Bendahara Jemaat', '2024-04-19 09:49:27', '2024-04-19 09:49:27', '2024-04-19 09:49:27'),
(11, 'Menunggu Persetujuan', 12, 'Menunggu Persetujuan Majelis HKBP Palmarum Tarutung', '2024-04-30 01:50:41', '2024-04-30 01:50:41', '2024-04-30 01:50:41'),
(12, 'Ditolak', 13, 'Ditolak oleh Majelis HKBP Palmarum Tarutung', '2024-04-30 01:51:03', '2024-04-30 01:51:03', '2024-04-30 01:51:03'),
(13, 'Disetujui', 14, 'Disetujui oleh Majelis HKBP Palmarum Tarutung', '2024-04-30 01:51:34', '2024-04-30 01:51:34', '2024-04-30 01:51:34');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `bidang_pendidikan`
--
ALTER TABLE `bidang_pendidikan`
  ADD PRIMARY KEY (`id_bidang_pendidikan`);

--
-- Indeks untuk tabel `hubungan_keluarga`
--
ALTER TABLE `hubungan_keluarga`
  ADD PRIMARY KEY (`id_hub_keluarga`);

--
-- Indeks untuk tabel `jemaat`
--
ALTER TABLE `jemaat`
  ADD PRIMARY KEY (`id_jemaat`),
  ADD KEY `id_hub_keluarga` (`id_hub_keluarga`),
  ADD KEY `id_status_ama_ina` (`id_status_ama_ina`),
  ADD KEY `id_status_anak` (`id_status_anak`),
  ADD KEY `id_status_pernikahan` (`id_status_pernikahan`),
  ADD KEY `id_pendidikan` (`id_pendidikan`),
  ADD KEY `id_bidang_pendidikan` (`id_bidang_pendidikan`),
  ADD KEY `id_pekerjaan` (`id_pekerjaan`),
  ADD KEY `id_kecamatan` (`id_kecamatan`);

--
-- Indeks untuk tabel `jenis_status`
--
ALTER TABLE `jenis_status`
  ADD PRIMARY KEY (`id_jenis_status`);

--
-- Indeks untuk tabel `kecamatan`
--
ALTER TABLE `kecamatan`
  ADD PRIMARY KEY (`id_kecamatan`);

--
-- Indeks untuk tabel `pekerjaan`
--
ALTER TABLE `pekerjaan`
  ADD PRIMARY KEY (`id_pekerjaan`);

--
-- Indeks untuk tabel `pendidikan`
--
ALTER TABLE `pendidikan`
  ADD PRIMARY KEY (`id_pendidikan`);

--
-- Indeks untuk tabel `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`id_status`),
  ADD KEY `id_jenis_status` (`id_jenis_status`);

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `jemaat`
--
ALTER TABLE `jemaat`
  ADD CONSTRAINT `jemaat_ibfk_1` FOREIGN KEY (`id_hub_keluarga`) REFERENCES `hubungan_keluarga` (`id_hub_keluarga`),
  ADD CONSTRAINT `jemaat_ibfk_2` FOREIGN KEY (`id_kecamatan`) REFERENCES `kecamatan` (`id_kecamatan`),
  ADD CONSTRAINT `jemaat_ibfk_3` FOREIGN KEY (`id_pekerjaan`) REFERENCES `pekerjaan` (`id_pekerjaan`),
  ADD CONSTRAINT `jemaat_ibfk_4` FOREIGN KEY (`id_pendidikan`) REFERENCES `pendidikan` (`id_pendidikan`),
  ADD CONSTRAINT `jemaat_ibfk_5` FOREIGN KEY (`id_status_ama_ina`) REFERENCES `status` (`id_status`),
  ADD CONSTRAINT `jemaat_ibfk_6` FOREIGN KEY (`id_status_anak`) REFERENCES `status` (`id_status`),
  ADD CONSTRAINT `jemaat_ibfk_7` FOREIGN KEY (`id_status_pernikahan`) REFERENCES `status` (`id_status`),
  ADD CONSTRAINT `jemaat_ibfk_8` FOREIGN KEY (`id_bidang_pendidikan`) REFERENCES `bidang_pendidikan` (`id_bidang_pendidikan`);

--
-- Ketidakleluasaan untuk tabel `status`
--
ALTER TABLE `status`
  ADD CONSTRAINT `status_ibfk_1` FOREIGN KEY (`id_jenis_status`) REFERENCES `jenis_status` (`id_jenis_status`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
