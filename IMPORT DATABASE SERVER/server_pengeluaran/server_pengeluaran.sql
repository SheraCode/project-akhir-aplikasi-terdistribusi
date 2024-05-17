-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 15 Bulan Mei 2024 pada 09.56
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
-- Database: `server_pengeluaran`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ambil_pengeluaran` ()   BEGIN
    SELECT
	P.id_pengeluaran,
        p.jumlah_pengeluaran,
        p.tanggal_pengeluaran,
        p.keterangan_pengeluaran,
        b.nama_bank,
        kp.kategori_pengeluaran,
        p.bukti_pengeluaran,
        p.id_kategori_pengeluaran,
        p.id_bank
    FROM
        pengeluaran p
    INNER JOIN
        bank b ON p.id_bank = b.id_bank
    INNER JOIN
        kategori_pengeluaran kp ON p.id_kategori_pengeluaran = kp.id_kategori_pengeluaran;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getById_pengeluaran` (IN `p_id_pengeluaran` INT)   BEGIN
    SELECT
        p.id_pengeluaran,
        p.jumlah_pengeluaran,
        p.tanggal_pengeluaran,
        p.keterangan_pengeluaran,
        b.nama_bank,
        kp.kategori_pengeluaran,
        p.bukti_pengeluaran,
        p.id_bank,
        p.id_kategori_pengeluaran
    FROM
        pengeluaran p
    INNER JOIN
        bank b ON p.id_bank = b.id_bank
    INNER JOIN
        kategori_pengeluaran kp ON p.id_kategori_pengeluaran = kp.id_kategori_pengeluaran
    WHERE
        p.id_pengeluaran = p_id_pengeluaran;
END$$


CREATE DEFINER=`root`@`localhost` PROCEDURE `tambah_pengeluaran` (
    IN `p_jumlah_pengeluaran` INT, 
    IN `p_tanggal_pengeluaran` VARCHAR(225), 
    IN `p_keterangan_pengeluaran` VARCHAR(225), 
    IN `p_id_kategori_pengeluaran` INT, 
    IN `p_id_bank` INT, 
    IN `p_bukti_pengeluaran` VARCHAR(500)
)
BEGIN
    -- Check if the record already exists
    IF NOT EXISTS (
        SELECT 1 
        FROM `pengeluaran` 
        WHERE `jumlah_pengeluaran` = p_jumlah_pengeluaran 
          AND `tanggal_pengeluaran` = p_tanggal_pengeluaran 
          AND `keterangan_pengeluaran` = p_keterangan_pengeluaran 
          AND `id_kategori_pengeluaran` = p_id_kategori_pengeluaran 
          AND `id_bank` = p_id_bank 
          AND `bukti_pengeluaran` = p_bukti_pengeluaran
    ) THEN
        -- Insert the new record if it does not exist
        INSERT INTO `pengeluaran` (
            `jumlah_pengeluaran`,
            `tanggal_pengeluaran`,
            `keterangan_pengeluaran`,
            `id_kategori_pengeluaran`,
            `id_bank`,
            `bukti_pengeluaran`
        ) VALUES (
            p_jumlah_pengeluaran,
            p_tanggal_pengeluaran,
            p_keterangan_pengeluaran,
            p_id_kategori_pengeluaran,
            p_id_bank,
            p_bukti_pengeluaran
        );
    END IF;
END$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ubah_pengeluaran` (IN `p_IDpengeluaran` INT, IN `p_bukti_pengeluaran` VARCHAR(500), IN `p_jumlah_pengeluaran` INT, IN `p_tanggal_pengeluaran` VARCHAR(255), IN `p_keterangan_pengeluaran` VARCHAR(255), IN `p_id_kategori_pengeluaran` INT, IN `p_id_bank` INT)   BEGIN
    UPDATE pengeluaran
    SET
        jumlah_pengeluaran = p_jumlah_pengeluaran,
        tanggal_pengeluaran = p_tanggal_pengeluaran,
        keterangan_pengeluaran = p_keterangan_pengeluaran,
        id_kategori_pengeluaran = p_id_kategori_pengeluaran,
        id_bank = p_id_bank,
        bukti_pengeluaran = p_bukti_pengeluaran
    WHERE
        id_pengeluaran = p_IDpengeluaran;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `bank`
--

CREATE TABLE `bank` (
  `id_bank` int(11) NOT NULL,
  `nama_bank` varchar(225) NOT NULL,
  `keterangan` text NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `bank`
--

INSERT INTO `bank` (`id_bank`, `nama_bank`, `keterangan`, `create_at`, `update_at`, `is_deleted`) VALUES
(1, 'BRI', 'Bank Rakyat Indonesia', '2024-04-27 08:22:33', '2024-04-27 08:22:33', '2024-04-27 08:22:33'),
(2, 'BNI', 'Bank Negara Indonesia', '2024-04-27 08:22:45', '2024-04-27 08:22:45', '2024-04-27 08:22:45'),
(3, 'Bank Mayapada', 'Bank Mayapada', '2024-04-27 08:23:03', '2024-04-27 08:23:03', '2024-04-27 08:23:03'),
(4, 'BCA', 'Bank Central Asia', '2024-04-27 08:23:41', '2024-04-27 08:23:41', '2024-04-27 08:23:41'),
(5, 'Dana', 'Platform Dana', '2024-04-27 08:23:58', '2024-04-27 08:23:58', '2024-04-27 08:23:58'),
(6, 'Mandiri', 'Bank Mandiri', '2024-04-27 08:24:11', '2024-04-27 08:24:11', '2024-04-27 08:24:11'),
(7, 'BSI', 'Bank Syariah Indonesia', '2024-04-27 08:24:27', '2024-04-27 08:24:27', '2024-04-27 08:24:27'),
(8, 'Bank Aceh', 'Bank Aceh', '2024-04-27 08:24:42', '2024-04-27 08:24:42', '2024-04-27 08:24:42'),
(9, 'Bank Lainnya', 'Bank Lainnya yang terdaftar di Indonesia', '2024-04-27 08:25:20', '2024-04-27 08:25:20', '2024-04-27 08:25:20'),
(10, 'Tunai', 'Secara Tunai', '2024-04-29 05:42:03', '2024-04-29 05:42:03', '2024-04-29 05:42:03');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kategori_pengeluaran`
--

CREATE TABLE `kategori_pengeluaran` (
  `id_kategori_pengeluaran` int(11) NOT NULL,
  `kategori_pengeluaran` varchar(225) NOT NULL,
  `deskripsi` text NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `kategori_pengeluaran`
--

INSERT INTO `kategori_pengeluaran` (`id_kategori_pengeluaran`, `kategori_pengeluaran`, `deskripsi`, `create_at`, `update_at`, `is_deleted`) VALUES
(1, 'Perbaikan Gereja', 'Pengeluaran Maintenance Gereja HKBP Palmarum', '2024-04-27 08:12:13', '2024-04-27 08:12:13', '2024-04-27 08:12:13'),
(2, 'Acara Gereja', 'Pengeluaran Acara Gereja HKBP Palmarum', '2024-04-27 08:13:42', '2024-04-27 08:13:42', '2024-04-27 08:13:42'),
(3, 'Acara Diluar Gereja', 'Pengeluaran Acara Diluar Gereja ', '2024-04-27 08:15:18', '2024-04-27 08:15:18', '2024-04-27 08:15:18'),
(4, 'Bantuan Dana ke Organisasi', 'Bantuan Dana Ke Organisasi di Gereja HKBP Palmarum', '2024-04-27 08:18:03', '2024-04-27 08:18:03', '2024-04-27 08:18:03'),
(5, 'Dana Sosial', 'Bantuan Dana Sosial', '2024-04-27 08:19:11', '2024-04-27 08:19:11', '2024-04-27 08:19:11'),
(6, 'Lainnya', 'Pengeluaran Lainnya yang terjadi didalam gereja maupun diluar gereja', '2024-04-27 08:19:50', '2024-04-27 08:19:50', '2024-04-27 08:19:50');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pengeluaran`
--

CREATE TABLE `pengeluaran` (
  `id_pengeluaran` int(11) NOT NULL,
  `jumlah_pengeluaran` int(11) NOT NULL,
  `tanggal_pengeluaran` varchar(15) NOT NULL,
  `keterangan_pengeluaran` varchar(225) NOT NULL,
  `id_kategori_pengeluaran` int(11) NOT NULL,
  `id_bank` int(11) NOT NULL,
  `bukti_pengeluaran` varchar(500) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `pengeluaran`
--

INSERT INTO `pengeluaran` (`id_pengeluaran`, `jumlah_pengeluaran`, `tanggal_pengeluaran`, `keterangan_pengeluaran`, `id_kategori_pengeluaran`, `id_bank`, `bukti_pengeluaran`, `created_at`, `updated_at`, `is_deleted`) VALUES
(13, 1500000, '', 'Acara Kebaktian Minggu Malam HKBP Palmarum', 3, 5, '1000155950.jpg', '2024-04-27 22:08:09', '2024-04-27 22:08:09', '2024-04-27 22:08:09'),
(15, 2000000, '2024-4-27', 'Acara Kebaktian Minggu Malam HKBP Palmarum', 2, 2, 'pengeluaran\\e0677290-7a10-4535-a1a3-ce175eba6bd8.JPG', '2024-04-27 22:28:44', '2024-04-27 22:28:44', '2024-04-27 22:28:44'),
(16, 1300000, '2024-12-12', 'Acara Kebaktian Minggu Sore HKBP Palmarum', 2, 5, 'pengeluaran\\a52a7522-0541-4450-8d1b-00fa0c1ab01f.JPG', '2024-04-27 22:29:23', '2024-04-27 22:29:23', '2024-04-27 22:29:23'),
(17, 200000, '2024-05-13', 'Acara Kebaktian Minggu Malam HKBP Palmarum', 2, 2, 'jerkt.jpg', '2024-05-13 02:59:17', '2024-05-13 02:59:17', '2024-05-13 02:59:17'),
(18, 600000, '', 'Bantuan Natal', 4, 7, '3eb897af-84ec-433d-8735-81e03c486927268869566046959445.jpg', '2024-05-15 04:12:23', '2024-05-15 04:12:23', '2024-05-15 04:12:23'),
(19, 600000, '', 'Bantuan Natal', 4, 7, '3eb897af-84ec-433d-8735-81e03c486927268869566046959445.jpg', '2024-05-15 04:12:40', '2024-05-15 04:12:40', '2024-05-15 04:12:40'),
(20, 500000, '', 'Bantuan Natal', 4, 6, '68ec7fbb-05f0-4fa0-8aa2-ac871d56ee975236696290467662239.jpg', '2024-05-15 04:14:28', '2024-05-15 04:14:28', '2024-05-15 04:14:28'),
(21, 500000, '', 'Bantuan Natal', 4, 6, '68ec7fbb-05f0-4fa0-8aa2-ac871d56ee975236696290467662239.jpg', '2024-05-15 04:14:33', '2024-05-15 04:14:33', '2024-05-15 04:14:33'),
(22, 500000, '', 'Bantuan Natal', 4, 6, '68ec7fbb-05f0-4fa0-8aa2-ac871d56ee975236696290467662239.jpg', '2024-05-15 04:14:35', '2024-05-15 04:14:35', '2024-05-15 04:14:35'),
(23, 500000, '', 'Bantuan Natal', 4, 6, '68ec7fbb-05f0-4fa0-8aa2-ac871d56ee975236696290467662239.jpg', '2024-05-15 04:14:36', '2024-05-15 04:14:36', '2024-05-15 04:14:36'),
(24, 500000, '', 'Bantuan Natal', 4, 6, '68ec7fbb-05f0-4fa0-8aa2-ac871d56ee975236696290467662239.jpg', '2024-05-15 04:14:36', '2024-05-15 04:14:36', '2024-05-15 04:14:36'),
(25, 500000, '', 'Bantuan Natal', 5, 6, 'e109c24c-882b-45c2-8796-db0e2961d8ac8983298960844225202.jpg', '2024-05-15 04:17:25', '2024-05-15 04:17:25', '2024-05-15 04:17:25'),
(26, 500000, '', 'Bansos', 6, 5, '1000155950.jpg', '2024-05-15 04:18:30', '2024-05-15 04:18:30', '2024-05-15 04:18:30'),
(27, 500000, '', 'makan bersama', 2, 9, '1000155819.jpg', '2024-05-15 04:19:30', '2024-05-15 04:19:30', '2024-05-15 04:19:30'),
(28, 8000, '', 'atap rusak kali', 1, 6, '1000155949.jpg', '2024-05-15 04:23:04', '2024-05-15 04:23:04', '2024-05-15 04:23:04');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `bank`
--
ALTER TABLE `bank`
  ADD PRIMARY KEY (`id_bank`);

--
-- Indeks untuk tabel `kategori_pengeluaran`
--
ALTER TABLE `kategori_pengeluaran`
  ADD PRIMARY KEY (`id_kategori_pengeluaran`);

--
-- Indeks untuk tabel `pengeluaran`
--
ALTER TABLE `pengeluaran`
  ADD PRIMARY KEY (`id_pengeluaran`),
  ADD KEY `fk_pengeluaran_kategori` (`id_kategori_pengeluaran`),
  ADD KEY `fk_pengeluaran_bank` (`id_bank`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `bank`
--
ALTER TABLE `bank`
  MODIFY `id_bank` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `kategori_pengeluaran`
--
ALTER TABLE `kategori_pengeluaran`
  MODIFY `id_kategori_pengeluaran` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `pengeluaran`
--
ALTER TABLE `pengeluaran`
  MODIFY `id_pengeluaran` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `pengeluaran`
--
ALTER TABLE `pengeluaran`
  ADD CONSTRAINT `fk_pengeluaran_bank` FOREIGN KEY (`id_bank`) REFERENCES `bank` (`id_bank`),
  ADD CONSTRAINT `fk_pengeluaran_kategori` FOREIGN KEY (`id_kategori_pengeluaran`) REFERENCES `kategori_pengeluaran` (`id_kategori_pengeluaran`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
