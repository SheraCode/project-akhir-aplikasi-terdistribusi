-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 15 Bulan Mei 2024 pada 16.56
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
-- Indeks untuk tabel `jenis_kegiatan`
--
ALTER TABLE `jenis_kegiatan`
  ADD PRIMARY KEY (`id_jenis_kegiatan`);

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
-- AUTO_INCREMENT untuk tabel `waktu_kegiatan`
--
ALTER TABLE `waktu_kegiatan`
  MODIFY `id_waktu_kegiatan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `waktu_kegiatan`
--
ALTER TABLE `waktu_kegiatan`
  ADD CONSTRAINT `waktu_kegiatan_ibfk_1` FOREIGN KEY (`id_jenis_kegiatan`) REFERENCES `jenis_kegiatan` (`id_jenis_kegiatan`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;