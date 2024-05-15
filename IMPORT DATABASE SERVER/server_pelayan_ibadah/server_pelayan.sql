-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 15 Bulan Mei 2024 pada 16.55
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
-- Database: `server_pelayan`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateJadwalIbadah` (IN `p_id_jenis_minggu` INT, IN `p_tgl_ibadah` VARCHAR(225), IN `p_sesi_ibadah` VARCHAR(225), IN `p_keterangan` TEXT)   BEGIN
    INSERT INTO jadwal_ibadah (id_jenis_minggu, tgl_ibadah, sesi_ibadah, keterangan, create_at, update_at)
    VALUES (p_id_jenis_minggu, p_tgl_ibadah, p_sesi_ibadah, p_keterangan, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CreatePelayananIbadahData` (`p_nama_pelayanan_ibadah` VARCHAR(255), `p_keterangan` VARCHAR(255))   BEGIN
    INSERT INTO pelayanan_ibadah (nama_pelayanan_ibadah, keterangan)
    VALUES (p_nama_pelayanan_ibadah, p_keterangan);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CreatePelayanIbadahData` (`p_id_jadwal_ibadah` INT, `p_id_pelayanan_ibadah` INT, `p_keterangan` VARCHAR(255))   BEGIN
    INSERT INTO pelayan_ibadah (id_jadwal_ibadah, id_pelayanan_ibadah, keterangan)
    VALUES (p_id_jadwal_ibadah, p_id_pelayanan_ibadah, p_keterangan);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EditJadwalIbadah` (IN `p_id_jadwal_ibadah` INT, IN `p_id_jenis_minggu` INT, IN `p_tgl_ibadah` VARCHAR(225), IN `p_sesi_ibadah` VARCHAR(225), IN `p_keterangan` TEXT)   BEGIN
    UPDATE jadwal_ibadah
    SET id_jenis_minggu = p_id_jenis_minggu,
        tgl_ibadah = p_tgl_ibadah,
        sesi_ibadah = p_sesi_ibadah,
        keterangan = p_keterangan,
        update_at = CURRENT_TIMESTAMP
    WHERE id_jadwal_ibadah = p_id_jadwal_ibadah;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EditPelayananIbadah` (IN `p_id_pelayanan_ibadah` INT, IN `p_nama_pelayanan_ibadah` VARCHAR(225), IN `p_keterangan` TEXT)   BEGIN
    UPDATE pelayanan_ibadah
    SET nama_pelayanan_ibadah = p_nama_pelayanan_ibadah,
        keterangan = p_keterangan,
        update_at = CURRENT_TIMESTAMP
    WHERE id_pelayanan_ibadah = p_id_pelayanan_ibadah;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetJadwalIbadah` ()   BEGIN
    SELECT j.id_jadwal_ibadah, jm.nama_jenis_minggu, j.tgl_ibadah, j.sesi_ibadah, j.keterangan, j.id_jenis_minggu
    FROM jadwal_ibadah j
    INNER JOIN jenis_minggu jm ON j.id_jenis_minggu = jm.id_jenis_minggu;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetJadwalIbadahByID` (IN `p_id_jadwal_ibadah` INT)   BEGIN
    SELECT j.id_jadwal_ibadah, jm.nama_jenis_minggu, j.tgl_ibadah, j.sesi_ibadah, j.keterangan, j.id_jenis_minggu
    FROM jadwal_ibadah j
    INNER JOIN jenis_minggu jm ON j.id_jenis_minggu = jm.id_jenis_minggu
    WHERE j.id_jadwal_ibadah = p_id_jadwal_ibadah;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPelayananIbadahByID` (IN `p_id_pelayanan_ibadah` INT)   BEGIN
    SELECT id_pelayanan_ibadah, nama_pelayanan_ibadah, keterangan, create_at, is_deleted, update_at
    FROM pelayanan_ibadah
    WHERE id_pelayanan_ibadah = p_id_pelayanan_ibadah;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPelayanIbadahData` ()   BEGIN
    SELECT pi.id_pelayanan_ibadah, pi.id_jadwal_ibadah, p.nama_pelayanan_ibadah, p.keterangan, j.sesi_ibadah, j.tgl_ibadah
    FROM pelayan_ibadah PI
    INNER JOIN pelayanan_ibadah p ON pi.id_pelayanan_ibadah = p.id_pelayanan_ibadah
    INNER JOIN jadwal_ibadah j ON pi.id_jadwal_ibadah = j.id_jadwal_ibadah
    WHERE pi.create_at >= DATE_SUB(CURRENT_DATE(), INTERVAL 6 DAY);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ReadPelayananIbadah` ()   BEGIN
    SELECT id_pelayanan_ibadah, nama_pelayanan_ibadah, keterangan, create_at ,is_deleted, update_at
    FROM pelayanan_ibadah;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `jadwal_ibadah`
--

CREATE TABLE `jadwal_ibadah` (
  `id_jadwal_ibadah` int(11) NOT NULL,
  `id_jenis_minggu` int(11) NOT NULL,
  `tgl_ibadah` timestamp NOT NULL DEFAULT current_timestamp(),
  `sesi_ibadah` varchar(225) NOT NULL,
  `keterangan` text NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `jadwal_ibadah`
--

INSERT INTO `jadwal_ibadah` (`id_jadwal_ibadah`, `id_jenis_minggu`, `tgl_ibadah`, `sesi_ibadah`, `keterangan`, `create_at`, `update_at`, `is_deleted`) VALUES
(1, 1, '2024-04-16 07:17:22', 'Sesi 1', 'Sesi 1 Ibadah Pukul 05.00', '2024-04-16 07:19:58', '2024-04-17 06:10:08', '2024-04-16 07:19:58'),
(2, 22, '2024-04-16 23:39:29', 'Sesi 1', 'Ibadah HKBP Palmarum Sesi 1', '2024-04-16 23:39:29', '2024-04-16 23:39:29', '2024-04-16 23:39:29'),
(3, 22, '2024-04-16 23:39:48', 'Sesi 2', 'Ibadah HKBP Palmarum Sesi 2', '2024-04-16 23:39:48', '2024-04-16 23:39:48', '2024-04-16 23:39:48'),
(4, 22, '2024-04-16 23:40:08', 'Sesi 3', 'Ibadah HKBP Palmarum Sesi 3', '2024-04-16 23:40:08', '2024-04-16 23:40:08', '2024-04-16 23:40:08'),
(5, 7, '2024-04-20 20:12:31', 'Sesi 3', 'Ibadah Sesi 3 HKBP Palmarum', '2024-04-19 20:13:29', '2024-05-14 15:08:34', '2024-04-19 20:13:29'),
(6, 11, '2024-04-29 20:08:06', 'Sesi 1', 'Sesi 1 Kebaktian Pagi HKBP Palmarum', '2024-04-29 20:08:37', '2024-05-14 15:07:50', '2024-04-29 20:08:37'),
(7, 16, '2024-05-14 17:00:00', 'Sesi 1', 'Ibadah Pagi Palmarum', '2024-05-15 03:01:53', '2024-05-15 03:02:00', '2024-05-15 03:01:53'),
(8, 8, '2024-05-14 17:00:00', 'Sesi 2', 'Ibadah Minggu Sesi 2 HKBP Palmarum', '2024-05-15 07:11:38', '2024-05-15 07:11:38', '2024-05-15 07:11:38'),
(9, 7, '2024-05-14 17:00:00', 'Sesi 2', 'Ibadah Sesi 2', '2024-05-15 14:53:52', '2024-05-15 14:53:52', '2024-05-15 14:53:52');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jenis_minggu`
--

CREATE TABLE `jenis_minggu` (
  `id_jenis_minggu` int(11) NOT NULL,
  `nama_jenis_minggu` varchar(225) NOT NULL,
  `keterangan` varchar(225) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `jenis_minggu`
--

INSERT INTO `jenis_minggu` (`id_jenis_minggu`, `nama_jenis_minggu`, `keterangan`, `create_at`, `update_at`, `is_deleted`) VALUES
(1, 'Advent I – IV', 'Minggu-minggu yang menandai persiapan untuk perayaan Natal.', '2024-04-16 06:38:45', '2024-04-16 06:38:45', '2024-04-16 06:38:45'),
(2, 'Natal', 'Minggu yang merayakan kelahiran Yesus Kristus.', '2024-04-16 06:38:45', '2024-04-16 06:38:45', '2024-04-16 06:38:45'),
(3, 'Setelah Tahun Baru', 'Minggu-minggu setelah pergantian tahun baru.', '2024-04-16 06:38:45', '2024-04-16 06:38:45', '2024-04-16 06:38:45'),
(4, 'I – IV Setelah Epifani / Hapapatar', 'Minggu-minggu setelah perayaan Epifani, yang menekankan penerangan dan pemahaman yang semakin mendalam.', '2024-04-16 06:38:45', '2024-04-16 06:38:45', '2024-04-16 06:38:45'),
(5, 'Septuagesima / Sexagesima', 'Minggu-minggu sebelum Minggu sengsara, dengan penekanan khusus pada persiapan spiritual.', '2024-04-16 06:38:45', '2024-04-16 06:38:45', '2024-04-16 06:38:45'),
(6, 'Estomihi', 'Minggu dengan kutipan Mazmur 31:3, menekankan perlindungan dan pertahanan yang diberikan oleh Tuhan.', '2024-04-16 06:38:45', '2024-04-16 06:38:45', '2024-04-16 06:38:45'),
(7, 'Invocavit', 'Minggu dengan kutipan Mazmur 91:15a, menggambarkan respons positif terhadap panggilan Tuhan.', '2024-04-16 06:38:45', '2024-04-16 06:38:45', '2024-04-16 06:38:45'),
(8, 'Reminiscere', 'Minggu dengan kutipan Mazmur 25:6, mengajak untuk mengingat rahmat dan kasih setia Tuhan.', '2024-04-16 06:38:45', '2024-04-16 06:38:45', '2024-04-16 06:38:45'),
(9, 'Okuli', 'Minggu dengan kutipan Mazmur 25:15a, menekankan konsentrasi dan ketaatan kepada Tuhan.', '2024-04-16 06:38:45', '2024-04-16 06:38:45', '2024-04-16 06:38:45'),
(10, 'Letare', 'Minggu dengan kutipan Yesaya 66:10a, mengundang untuk bersukacita.', '2024-04-16 06:38:45', '2024-04-16 06:38:45', '2024-04-16 06:38:45'),
(11, 'Judika', 'Minggu dengan kutipan Mazmur 43:1a, memohon untuk dilepaskan dari kesulitan.', '2024-04-16 06:38:45', '2024-04-16 06:38:45', '2024-04-16 06:38:45'),
(12, 'Palmarum (Maremare)', 'Minggu Palma, merayakan kedatangan Yesus ke Yerusalem sebelum sengsara-Nya.', '2024-04-16 06:38:45', '2024-04-16 06:38:45', '2024-04-16 06:38:45'),
(13, 'Paskah Pertama / Paskah', 'Minggu Paskah, merayakan kebangkitan Yesus Kristus.', '2024-04-16 06:38:45', '2024-04-16 06:38:45', '2024-04-16 06:38:45'),
(14, 'Quasimodo Geniti', 'Minggu dengan kutipan 1 Petrus 2:2, menggambarkan kerinduan akan kata-kata rohani.', '2024-04-16 06:38:45', '2024-04-16 06:38:45', '2024-04-16 06:38:45'),
(15, 'Miserekordias Domini', 'Minggu dengan kutipan Mazmur 33:5b, menekankan kasih Allah yang melimpah.', '2024-04-16 06:38:45', '2024-04-16 06:38:45', '2024-04-16 06:38:45'),
(16, 'Jubilate', 'Minggu dengan kutipan Mazmur 66:1, mengajak untuk memuji Tuhan.', '2024-04-16 06:38:45', '2024-04-16 06:38:45', '2024-04-16 06:38:45'),
(17, 'Kantate', 'Minggu dengan kutipan Mazmur 98:1a, mengundang untuk menyanyikan pujian baru bagi Allah.', '2024-04-16 06:38:45', '2024-04-16 06:38:45', '2024-04-16 06:38:45'),
(18, 'Rogate', 'Minggu dengan kutipan Yeremia 29:12, menekankan pentingnya doa.', '2024-04-16 06:38:45', '2024-04-16 06:38:45', '2024-04-16 06:38:45'),
(19, 'Exaudi', 'Minggu dengan kutipan Mazmur 27:7, memohon agar Tuhan mendengarkan doa-doa.', '2024-04-16 06:38:45', '2024-04-16 06:38:45', '2024-04-16 06:38:45'),
(20, 'Pentakosta', 'Minggu Pentakosta, merayakan turunnya Roh Kudus kepada murid-murid Yesus.', '2024-04-16 06:38:45', '2024-04-16 06:38:45', '2024-04-16 06:38:45'),
(21, 'Trinitatis', 'Minggu Tritunggal, merayakan Tritunggal Kudus: Bapa, Anak, dan Roh Kudus.', '2024-04-16 06:38:45', '2024-04-16 06:38:45', '2024-04-16 06:38:45'),
(22, 'I – XXIV Setelah Trinitatis', 'Minggu-minggu biasa setelah hari Minggu Tritunggal.', '2024-04-16 06:38:45', '2024-04-16 06:38:45', '2024-04-16 06:38:45');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pelayanan_ibadah`
--

CREATE TABLE `pelayanan_ibadah` (
  `id_pelayanan_ibadah` int(11) NOT NULL,
  `nama_pelayanan_ibadah` varchar(225) NOT NULL,
  `keterangan` text NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `pelayanan_ibadah`
--

INSERT INTO `pelayanan_ibadah` (`id_pelayanan_ibadah`, `nama_pelayanan_ibadah`, `keterangan`, `create_at`, `update_at`, `is_deleted`) VALUES
(1, 'Gery', 'Pemain Piano POP', '2024-04-16 06:42:00', '2024-05-15 07:14:13', '2024-04-16 06:42:00'),
(2, 'Ghani', 'Pemain Drum', '2024-04-16 06:42:14', '2024-04-16 06:42:14', '2024-04-16 06:42:14'),
(3, 'Miranda Angelia', 'Singer', '2024-04-16 06:42:27', '2024-04-16 06:42:27', '2024-04-16 06:42:27'),
(4, 'Johannes Sipayung', 'Pemain Piano', '2024-04-16 06:42:43', '2024-04-16 06:42:43', '2024-04-16 06:42:43'),
(5, 'Bastian', 'Pemain Gitar Bass', '2024-04-16 06:43:09', '2024-04-16 06:43:09', '2024-04-16 06:43:09'),
(6, 'Christia', 'Singer', '2024-04-16 06:43:37', '2024-04-16 06:43:37', '2024-04-16 06:43:37'),
(7, 'Budiman', 'Pemain Drum', '2024-04-16 06:44:04', '2024-04-16 06:44:04', '2024-04-16 06:44:04'),
(8, 'Ivan', 'Pemain Gitar Elektrik', '2024-04-16 06:44:34', '2024-04-16 06:44:34', '2024-04-16 06:44:34'),
(9, 'Juicy', 'Pemain Saxophone', '2024-04-16 06:45:17', '2024-04-16 06:45:17', '2024-04-16 06:45:17'),
(10, 'Luicy', 'Pemain Saxophone', '2024-04-16 06:45:29', '2024-04-16 06:45:29', '2024-04-16 06:45:29'),
(11, 'Valen', 'Pemain Gitar Elektrik', '2024-04-16 06:46:09', '2024-04-16 06:46:09', '2024-04-16 06:46:09'),
(12, 'Bruno', 'Pemain Gitar Akustik', '2024-04-16 06:46:23', '2024-04-16 06:46:23', '2024-04-16 06:46:23'),
(13, 'Intel', 'Pemain Perkusi', '2024-04-18 23:56:59', '2024-04-18 23:56:59', '2024-04-18 23:56:59'),
(14, 'Duta', 'Singer', '2024-04-18 23:59:11', '2024-04-18 23:59:11', '2024-04-18 23:59:11'),
(15, 'Jhonson', 'Pemain Perkusi', '2024-04-19 00:02:10', '2024-04-19 00:02:10', '2024-04-19 00:02:10'),
(16, 'Jasa', 'Pemain Perkusi', '2024-04-19 19:17:37', '2024-04-19 19:17:37', '2024-04-19 19:17:37'),
(17, 'johannes sipayung oke', 'Pemain Piano Dalle', '2024-05-14 15:03:07', '2024-05-14 15:03:07', '2024-05-14 15:03:07'),
(18, 'Pangeran Silaen', 'Drum', '2024-05-14 15:11:36', '2024-05-14 15:11:54', '2024-05-14 15:11:36'),
(19, 'Michael Panjaitan', 'Pemain Kecapi', '2024-05-15 03:02:52', '2024-05-15 07:10:56', '2024-05-15 03:02:52');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pelayan_ibadah`
--

CREATE TABLE `pelayan_ibadah` (
  `id_jadwal_ibadah` int(11) NOT NULL,
  `id_pelayanan_ibadah` int(11) NOT NULL,
  `keterangan` text NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `pelayan_ibadah`
--

INSERT INTO `pelayan_ibadah` (`id_jadwal_ibadah`, `id_pelayanan_ibadah`, `keterangan`, `create_at`, `update_at`, `is_deleted`) VALUES
(2, 2, 'Pemain Drum Sesi 1 Ibadah', '2024-04-16 23:48:08', '2024-04-16 23:48:08', '2024-04-16 23:48:08'),
(2, 7, 'Pemain Drum Sesi 1 Ibadah', '2024-04-16 23:48:52', '2024-04-16 23:48:52', '2024-04-16 23:48:52'),
(2, 12, 'Pemain Gitar Akustik Ibadah Sesi 1', '2024-04-16 23:49:51', '2024-04-16 23:49:51', '2024-04-16 23:49:51'),
(2, 5, 'Pemain Gitar Bass Ibadah Sesi 1', '2024-04-16 23:50:07', '2024-04-16 23:50:07', '2024-04-16 23:50:07'),
(3, 11, 'Pemain Gitar Elektrik Ibadah Sesi 2', '2024-04-16 23:50:40', '2024-04-16 23:50:40', '2024-04-16 23:50:40'),
(3, 4, 'Pemain Piano Ibadah Sesi 2', '2024-04-16 23:50:54', '2024-04-16 23:50:54', '2024-04-16 23:50:54'),
(2, 3, 'Singer Ibadah Sesi 1', '2024-04-16 23:51:24', '2024-04-16 23:51:24', '2024-04-16 23:51:24'),
(3, 3, 'Singer Ibadah Sesi 2', '2024-04-16 23:51:52', '2024-04-16 23:51:52', '2024-04-16 23:51:52'),
(2, 10, 'Pemain Saxophone Ibadah Sesi 1', '2024-04-18 21:23:13', '2024-04-18 21:23:13', '2024-04-18 21:23:13'),
(2, 3, 'Song Leader', '2024-04-19 19:31:01', '2024-04-19 19:31:01', '2024-04-19 19:31:01'),
(3, 10, 'Pemain Saxophone Sesi Ibadah 2', '2024-04-19 19:44:07', '2024-04-19 19:44:07', '2024-04-19 19:44:07'),
(5, 14, 'Singer Kebaktian Sesi 3', '2024-04-19 20:14:15', '2024-04-19 20:14:15', '2024-04-19 20:14:15'),
(3, 10, 'Pemain Saxophone Sesi Ibadah 2', '2024-04-29 19:46:57', '2024-04-29 19:46:57', '2024-04-29 19:46:57'),
(6, 7, 'Pemain Drum Sesi 1 Kebaktian Pagi', '2024-04-29 20:09:47', '2024-04-29 20:09:47', '2024-04-29 20:09:47'),
(2, 8, 'Pemain Saxophone Sesi Ibadah 2', '2024-05-14 12:48:43', '2024-05-14 12:48:43', '2024-05-14 12:48:43'),
(6, 18, 'Pemain Drum Sesi 1 Ibadah', '2024-05-14 15:12:31', '2024-05-14 15:12:31', '2024-05-14 15:12:31'),
(7, 19, 'Pemain Kecapi Ibadah Sesi 1 Pagi', '2024-05-15 03:03:40', '2024-05-15 03:03:40', '2024-05-15 03:03:40'),
(8, 3, 'Pemain Piano ', '2024-05-15 07:12:18', '2024-05-15 07:12:18', '2024-05-15 07:12:18'),
(8, 9, 'Pemain Gitar', '2024-05-15 14:50:28', '2024-05-15 14:50:28', '2024-05-15 14:50:28'),
(9, 11, 'Pemain Musik Ibadah Palmarum', '2024-05-15 14:54:33', '2024-05-15 14:54:33', '2024-05-15 14:54:33');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `jadwal_ibadah`
--
ALTER TABLE `jadwal_ibadah`
  ADD PRIMARY KEY (`id_jadwal_ibadah`),
  ADD KEY `id_jenis_minggu` (`id_jenis_minggu`);

--
-- Indeks untuk tabel `jenis_minggu`
--
ALTER TABLE `jenis_minggu`
  ADD PRIMARY KEY (`id_jenis_minggu`);

--
-- Indeks untuk tabel `pelayanan_ibadah`
--
ALTER TABLE `pelayanan_ibadah`
  ADD PRIMARY KEY (`id_pelayanan_ibadah`);

--
-- Indeks untuk tabel `pelayan_ibadah`
--
ALTER TABLE `pelayan_ibadah`
  ADD KEY `id_pelayanan_ibadah` (`id_pelayanan_ibadah`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `jadwal_ibadah`
--
ALTER TABLE `jadwal_ibadah`
  MODIFY `id_jadwal_ibadah` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `jenis_minggu`
--
ALTER TABLE `jenis_minggu`
  MODIFY `id_jenis_minggu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT untuk tabel `pelayanan_ibadah`
--
ALTER TABLE `pelayanan_ibadah`
  MODIFY `id_pelayanan_ibadah` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `jadwal_ibadah`
--
ALTER TABLE `jadwal_ibadah`
  ADD CONSTRAINT `jadwal_ibadah_ibfk_1` FOREIGN KEY (`id_jenis_minggu`) REFERENCES `jenis_minggu` (`id_jenis_minggu`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `pelayan_ibadah`
--
ALTER TABLE `pelayan_ibadah`
  ADD CONSTRAINT `pelayan_ibadah_ibfk_1` FOREIGN KEY (`id_pelayanan_ibadah`) REFERENCES `pelayanan_ibadah` (`id_pelayanan_ibadah`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;