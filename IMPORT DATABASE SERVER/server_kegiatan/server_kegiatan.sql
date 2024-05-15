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
-- Database: `server_kegiatan`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetWaktuKegiatan` ()   BEGIN
    SELECT id_waktu_kegiatan, id_jenis_kegiatan, id_gereja, nama_kegiatan, lokasi_kegiatan, waktu_kegiatan, foto_kegiatan, keterangan
    FROM waktu_kegiatan;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetWaktuKegiatanByID` (IN `id` INT)   BEGIN
    SELECT id_waktu_kegiatan, id_jenis_kegiatan, id_gereja, nama_kegiatan, lokasi_kegiatan, waktu_kegiatan, foto_kegiatan, keterangan
    FROM waktu_kegiatan
    WHERE id_waktu_kegiatan = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetWaktuKegiatanHome` ()   BEGIN
    SELECT id_waktu_kegiatan, id_jenis_kegiatan, id_gereja, nama_kegiatan, lokasi_kegiatan, waktu_kegiatan,foto_kegiatan, keterangan
    FROM waktu_kegiatan
    ORDER BY id_waktu_kegiatan DESC
    LIMIT 5;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tambah_data_kegiatan` (IN `jenis_kegiatan_id` INT, IN `gereja_id` INT, IN `kegiatan_nama` VARCHAR(225), IN `kegiatan_lokasi` VARCHAR(225), IN `kegiatan_foto` VARCHAR(400), IN `keterangan` TEXT)   BEGIN
    INSERT INTO waktu_kegiatan (id_jenis_kegiatan, id_gereja, nama_kegiatan, lokasi_kegiatan, foto_kegiatan, keterangan)
    VALUES (jenis_kegiatan_id, gereja_id, kegiatan_nama, kegiatan_lokasi, kegiatan_foto, keterangan);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ubah_data_kegiatan` (IN `id_kegiatan` INT, IN `jenis_kegiatan_id` INT, IN `gereja_id` INT, IN `kegiatan_nama` VARCHAR(225), IN `kegiatan_foto` VARCHAR(400), IN `keterangan` TEXT)   BEGIN
    UPDATE waktu_kegiatan 
    SET 
        id_jenis_kegiatan = jenis_kegiatan_id,
        id_gereja = gereja_id,
        nama_kegiatan = kegiatan_nama,
        foto_kegiatan = kegiatan_foto,
        keterangan = keterangan
    WHERE
        id_waktu_kegiatan = id_kegiatan;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `distrik`
--

CREATE TABLE `distrik` (
  `id_distrik` int(11) NOT NULL,
  `kode_distrik` int(11) NOT NULL,
  `nama_distrik` varchar(100) NOT NULL,
  `alamat` text NOT NULL,
  `id_kecamatan` int(11) NOT NULL,
  `nama_paraeses` varchar(225) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `gereja`
--

CREATE TABLE `gereja` (
  `id_gereja` int(11) NOT NULL,
  `id_ressort` int(11) NOT NULL,
  `id_jenis_gereja` int(11) NOT NULL,
  `kode_gereja` int(11) NOT NULL,
  `nama_gereja` varchar(225) NOT NULL,
  `alamat` text NOT NULL,
  `id_kelurahan_gereja` int(11) NOT NULL,
  `nama_pendeta` varchar(225) NOT NULL,
  `tgl_berdiri` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `jenis_gereja`
--

CREATE TABLE `jenis_gereja` (
  `id_jenis_gereja` int(11) NOT NULL,
  `jenis_gereja` varchar(225) NOT NULL,
  `keterangan` text NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `jenis_kegiatan`
--

CREATE TABLE `jenis_kegiatan` (
  `id_jenis_kegiatan` int(11) NOT NULL,
  `nama_jenis_kegiatan` varchar(225) NOT NULL,
  `keterangan` text NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `jenis_kegiatan`
--

INSERT INTO `jenis_kegiatan` (`id_jenis_kegiatan`, `nama_jenis_kegiatan`, `keterangan`, `create_at`, `update_at`, `is_deleted`) VALUES
(1, 'Kegiatan Dalam Gereja', 'Semua kegiatan yang dilakukan didalam lingkungan gereja', '2024-04-09 07:04:39', '2024-04-09 07:04:39', '2024-04-09 07:04:39'),
(2, 'Kegiatan Luar Gereja', 'Kegiatan yang dilakukan diluar lingkungan gereja', '2024-04-09 07:05:25', '2024-04-09 07:05:25', '2024-04-09 07:05:25');

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
(0, 'Pilih Kecamatan Anda', '2024-04-01 01:18:39', '2024-04-01 01:18:39', '2024-04-01 01:18:39'),
(1, 'Kecamatan Adian Koting', '2024-03-31 23:47:32', '2024-03-31 23:47:32', '2024-03-31 23:47:32'),
(2, 'Kecamatan Garoga', '2024-03-31 23:48:11', '2024-03-31 23:48:11', '2024-03-31 23:48:11'),
(3, 'Kecamatan Muara', '2024-03-31 23:48:32', '2024-03-31 23:48:32', '2024-03-31 23:48:32'),
(4, 'kecamatan Pagaran\r\n', '2024-03-31 23:48:51', '2024-03-31 23:48:51', '2024-03-31 23:48:51'),
(5, 'Kecamatan Pahae Jae', '2024-03-31 23:49:03', '2024-03-31 23:49:03', '2024-03-31 23:49:03'),
(6, 'Kecamatan Pahae Julu', '2024-03-31 23:49:40', '2024-03-31 23:49:40', '2024-03-31 23:49:40'),
(7, 'Kecamatan Pangaribuan', '2024-03-31 23:49:55', '2024-03-31 23:49:55', '2024-03-31 23:49:55'),
(8, 'Kecamatan Parmonangan', '2024-03-31 23:50:07', '2024-03-31 23:50:07', '2024-03-31 23:50:07'),
(9, 'Kecamatan Purba Tua', '2024-03-31 23:50:19', '2024-03-31 23:50:19', '2024-03-31 23:50:19'),
(10, 'Kecamatan Siatas Barita', '2024-03-31 23:50:30', '2024-03-31 23:50:30', '2024-03-31 23:50:30'),
(11, 'Kecamatan Siborongborong', '2024-03-31 23:50:47', '2024-03-31 23:50:47', '2024-03-31 23:50:47'),
(12, 'Kecamatan Sipangumban', '2024-03-31 23:51:15', '2024-03-31 23:51:15', '2024-03-31 23:51:15'),
(13, 'Kecamatan Sipahutar', '2024-03-31 23:51:23', '2024-03-31 23:51:23', '2024-03-31 23:51:23'),
(14, 'Kecamatan Sipoholon', '2024-03-31 23:51:34', '2024-03-31 23:51:34', '2024-03-31 23:51:34'),
(15, 'Kecamatan Tarutung', '2024-03-31 23:51:48', '2024-03-31 23:51:48', '2024-03-31 23:51:48');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kelurahan`
--

CREATE TABLE `kelurahan` (
  `id_kelurahan_desa` int(11) NOT NULL,
  `nama_kelurahan` varchar(225) NOT NULL,
  `id_kecamatan_kelurahan` int(11) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `ressort`
--

CREATE TABLE `ressort` (
  `id_ressort` int(11) NOT NULL,
  `id_distrik` int(11) NOT NULL,
  `kode_ressort` int(11) NOT NULL,
  `nama_ressort` varchar(225) NOT NULL,
  `alamat` text NOT NULL,
  `id_kecamatan` int(11) NOT NULL,
  `pendeta_ressort` varchar(225) NOT NULL,
  `tgl_berdiri` date NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `waktu_kegiatan`
--

CREATE TABLE `waktu_kegiatan` (
  `id_waktu_kegiatan` int(11) NOT NULL,
  `id_jenis_kegiatan` int(11) NOT NULL,
  `id_gereja` int(11) NOT NULL,
  `nama_kegiatan` varchar(225) NOT NULL,
  `lokasi_kegiatan` varchar(225) NOT NULL,
  `waktu_kegiatan` timestamp NOT NULL DEFAULT current_timestamp(),
  `foto_kegiatan` varchar(400) NOT NULL,
  `keterangan` varchar(4000) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `waktu_kegiatan`
--

INSERT INTO `waktu_kegiatan` (`id_waktu_kegiatan`, `id_jenis_kegiatan`, `id_gereja`, `nama_kegiatan`, `lokasi_kegiatan`, `waktu_kegiatan`, `foto_kegiatan`, `keterangan`, `create_at`, `update_at`, `is_deleted`) VALUES
(64, 1, 1, 'Partonggoan Pemuda ', 'Tarutung Kota', '2024-05-15 07:26:23', 'HKBP_Palmarum,_Res._Palmarum_02.jpg', 'Pemuda-pemudi gereja merupakan pilar penting dalam kehidupan berjemaat. Mereka tidak hanya menjadi penerus generasi, tetapi juga berperan aktif dalam berbagai kegiatan gerejawi, seperti pelayanan, pengajaran, dan misi sosial. Semangat mereka dalam melayani Tuhan dan sesama mencerminkan nilai-nilai kasih, kepedulian, dan solidaritas yang diajarkan oleh Yesus Kristus. Melalui kegiatan seperti persekutuan doa, kelompok studi Alkitab, dan bakti sosial, mereka belajar dan tumbuh dalam iman bersama-sama. Selain itu, pemuda-pemudi gereja juga sering terlibat dalam upaya pengembangan komunitas, membantu mereka yang kurang beruntung, dan menjadi teladan dalam menjunjung tinggi moralitas Kristen. Kehadiran mereka memberikan energi dan inovasi baru yang sangat dibutuhkan dalam gereja, menjadikan gereja sebagai tempat yang dinamis dan relevan bagi generasi muda.', '2024-05-15 07:26:23', '2024-05-15 07:26:23', '2024-05-15 07:26:23'),
(65, 1, 0, 'Conference HKBP Church', 'Medan', '2024-05-15 07:34:17', '1000148233.jpg', 'Tanah itu berdampingan dengan letak bangunan gereja. Direncanakan ke depan, lokasi baru tersebut untuk pengembangan pelayanan HKBP Palmarum V.\n\nWarga HKBP Palmarum menampilkan kesatuan hatinya untuk mengadakan peningkatan berbagai pelayanan gereja. Jemaat dan majelis gereja cukup antusias mempersiapkan semua kebutuhan Perayaan yang diselenggarakan hari ini. Semangat gotong royong begitu nyata dihidupi oleh warga HKBP Palmarum.\n\nKini anggota jemaatnya berjumlah 146 kepala keluarga, yang dilayani 8 orang tua, seorang pendeta fungsional dan seorang pendeta resort. mengungkapkan semua hal yang menarik danu menggembirakan pada perayaan tersebut.\n\nSejak berdirinya HKBP Palmarum, perbuatan-perbuatan Allah yang luar biasa itu dapat dirasakan semua jemaat. Pelayan-pelayan penuh waktu yang telah silih berganti menyaksikan\n“Karya Allah itu, melalui kesetiaan, ketaatan dan kebaikan seluruh jemaat di sini. Itu sesuai dengan nats khotbah minggu ini, dua murid yang diutus, pemiliknya tinggal dan khalayak ramai yang mengelu-elukan Yesus Kristus, Raja dan Mesias,” ungkap Ompu i Ephorus.', '2024-05-15 07:34:17', '2024-05-15 07:34:17', '2024-05-15 07:34:17');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `distrik`
--
ALTER TABLE `distrik`
  ADD PRIMARY KEY (`id_distrik`),
  ADD KEY `distrik_ibfk_1` (`id_kecamatan`);

--
-- Indeks untuk tabel `gereja`
--
ALTER TABLE `gereja`
  ADD PRIMARY KEY (`id_gereja`),
  ADD KEY `gereja_ibfk_1` (`id_ressort`),
  ADD KEY `gereja_ibfk_2` (`id_jenis_gereja`),
  ADD KEY `gereja_ibfk_3` (`id_kelurahan_gereja`);

--
-- Indeks untuk tabel `jenis_gereja`
--
ALTER TABLE `jenis_gereja`
  ADD PRIMARY KEY (`id_jenis_gereja`);

--
-- Indeks untuk tabel `jenis_kegiatan`
--
ALTER TABLE `jenis_kegiatan`
  ADD PRIMARY KEY (`id_jenis_kegiatan`);

--
-- Indeks untuk tabel `kecamatan`
--
ALTER TABLE `kecamatan`
  ADD PRIMARY KEY (`id_kecamatan`);

--
-- Indeks untuk tabel `kelurahan`
--
ALTER TABLE `kelurahan`
  ADD PRIMARY KEY (`id_kelurahan_desa`);

--
-- Indeks untuk tabel `ressort`
--
ALTER TABLE `ressort`
  ADD PRIMARY KEY (`id_ressort`),
  ADD KEY `ressort_ibfk_1` (`id_distrik`),
  ADD KEY `ressort_ibfk_2` (`id_kecamatan`);

--
-- Indeks untuk tabel `waktu_kegiatan`
--
ALTER TABLE `waktu_kegiatan`
  ADD PRIMARY KEY (`id_waktu_kegiatan`),
  ADD KEY `id_jenis_kegiatan` (`id_jenis_kegiatan`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `distrik`
--
ALTER TABLE `distrik`
  MODIFY `id_distrik` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `gereja`
--
ALTER TABLE `gereja`
  MODIFY `id_gereja` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `jenis_gereja`
--
ALTER TABLE `jenis_gereja`
  MODIFY `id_jenis_gereja` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `kelurahan`
--
ALTER TABLE `kelurahan`
  MODIFY `id_kelurahan_desa` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `ressort`
--
ALTER TABLE `ressort`
  MODIFY `id_ressort` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `waktu_kegiatan`
--
ALTER TABLE `waktu_kegiatan`
  MODIFY `id_waktu_kegiatan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `distrik`
--
ALTER TABLE `distrik`
  ADD CONSTRAINT `distrik_ibfk_1` FOREIGN KEY (`id_kecamatan`) REFERENCES `kecamatan` (`id_kecamatan`);

--
-- Ketidakleluasaan untuk tabel `gereja`
--
ALTER TABLE `gereja`
  ADD CONSTRAINT `gereja_ibfk_1` FOREIGN KEY (`id_ressort`) REFERENCES `ressort` (`id_ressort`),
  ADD CONSTRAINT `gereja_ibfk_2` FOREIGN KEY (`id_jenis_gereja`) REFERENCES `jenis_gereja` (`id_jenis_gereja`),
  ADD CONSTRAINT `gereja_ibfk_3` FOREIGN KEY (`id_kelurahan_gereja`) REFERENCES `kelurahan` (`id_kelurahan_desa`);

--
-- Ketidakleluasaan untuk tabel `ressort`
--
ALTER TABLE `ressort`
  ADD CONSTRAINT `ressort_ibfk_1` FOREIGN KEY (`id_distrik`) REFERENCES `distrik` (`id_distrik`),
  ADD CONSTRAINT `ressort_ibfk_2` FOREIGN KEY (`id_kecamatan`) REFERENCES `kecamatan` (`id_kecamatan`);

--
-- Ketidakleluasaan untuk tabel `waktu_kegiatan`
--
ALTER TABLE `waktu_kegiatan`
  ADD CONSTRAINT `waktu_kegiatan_ibfk_1` FOREIGN KEY (`id_jenis_kegiatan`) REFERENCES `jenis_kegiatan` (`id_jenis_kegiatan`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
