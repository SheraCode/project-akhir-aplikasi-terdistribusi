-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 15 Bulan Mei 2024 pada 09.55
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
-- Database: `server_pemasukan`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllPemasukan` ()   BEGIN
    SELECT
        p.id_pemasukan,
        p.tanggal_pemasukan,
        p.bukti_pemasukan,
        p.total_pemasukan,
        p.bentuk_pemasukan,
        b.nama_bank AS nama_bank,
        kp.kategori_pemasukan AS nama_kategori,
        p.id_bank,
        p.id_kategori_pemasukan
    FROM
        pemasukan p
    INNER JOIN
        bank b ON p.id_bank = b.id_bank
    INNER JOIN
        kategori_pemasukab kp ON p.id_kategori_pemasukan = kp.id_kategori_pemasukan;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getByIdPemasukan` (IN `p_id_pemasukan` INT)   BEGIN
    SELECT
        p.id_pemasukan,
        p.tanggal_pemasukan,
        p.total_pemasukan,
        p.bentuk_pemasukan,
        kp.kategori_pemasukan,
        p.bukti_pemasukan,
        b.nama_bank,
        p.id_bank,
        p.id_kategori_pemasukan
    FROM
        pemasukan p
    INNER JOIN
        bank b ON p.id_bank = b.id_bank
    INNER JOIN
        kategori_pemasukab kp ON p.id_kategori_pemasukan = kp.id_kategori_pemasukan
    WHERE
        p.id_pemasukan = p_id_pemasukan;
END$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_pemasukan` (
    IN `p_tanggal_pemasukan` DATE, 
    IN `p_total_pemasukan` INT, 
    IN `p_bentuk_pemasukan` VARCHAR(225), 
    IN `p_id_kategori_pemasukan` INT, 
    IN `p_bukti_pemasukan` VARCHAR(500), 
    IN `p_id_bank` INT
)
BEGIN
    -- Check if the record already exists
    IF NOT EXISTS (
        SELECT 1 
        FROM `pemasukan` 
        WHERE `tanggal_pemasukan` = p_tanggal_pemasukan 
          AND `total_pemasukan` = p_total_pemasukan 
          AND `bentuk_pemasukan` = p_bentuk_pemasukan 
          AND `id_kategori_pemasukan` = p_id_kategori_pemasukan 
          AND `bukti_pemasukan` = p_bukti_pemasukan 
          AND `id_bank` = p_id_bank
    ) THEN
        -- Insert the new record if it does not exist
        INSERT INTO `pemasukan` (
            `tanggal_pemasukan`,
            `total_pemasukan`,
            `bentuk_pemasukan`,
            `id_kategori_pemasukan`,
            `bukti_pemasukan`,
            `id_bank`
        ) VALUES (
            p_tanggal_pemasukan,
            p_total_pemasukan,
            p_bentuk_pemasukan,
            p_id_kategori_pemasukan,
            p_bukti_pemasukan,
            p_id_bank
        );
    END IF;
END$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_pemasukan` (IN `p_id_pemasukan` INT, IN `p_tanggal_pemasukan` DATE, IN `p_total_pemasukan` INT, IN `p_bentuk_pemasukan` VARCHAR(225), IN `p_id_kategori_pemasukan` INT, IN `p_bukti_pemasukan` VARCHAR(500), IN `p_id_bank` INT)   BEGIN
    UPDATE pemasukan
    SET
        tanggal_pemasukan = p_tanggal_pemasukan,
        total_pemasukan = p_total_pemasukan,
        bentuk_pemasukan = p_bentuk_pemasukan,
        id_kategori_pemasukan = p_id_kategori_pemasukan,
        bukti_pemasukan = p_bukti_pemasukan,
        id_bank = p_id_bank
    WHERE
        id_pemasukan = p_id_pemasukan;
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
-- Struktur dari tabel `kategori_pemasukab`
--

CREATE TABLE `kategori_pemasukab` (
  `id_kategori_pemasukan` int(11) NOT NULL,
  `kategori_pemasukan` varchar(225) NOT NULL,
  `deskripsi` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `kategori_pemasukab`
--

INSERT INTO `kategori_pemasukab` (`id_kategori_pemasukan`, `kategori_pemasukan`, `deskripsi`, `created_at`, `updated_at`, `is_deleted`) VALUES
(1, 'Bantuan Dana Organisasi', 'Bantuan Dana dari Organisasi', '2024-04-28 18:15:53', '2024-04-28 18:15:53', '2024-04-28 18:15:53'),
(2, 'Persembahan Kebaktian ', 'Persembahan Gereja HKBP Palmarum', '2024-04-28 18:16:18', '2024-04-28 18:16:18', '2024-04-28 18:16:18'),
(3, 'Sumbangan Jemaat', 'Persembahan Sumbangan Jemaat HKBP Palmarum Tarutung', '2024-04-28 18:26:37', '2024-04-28 18:26:37', '2024-04-28 18:26:37');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pemasukan`
--

CREATE TABLE `pemasukan` (
  `id_pemasukan` int(11) NOT NULL,
  `tanggal_pemasukan` date NOT NULL,
  `total_pemasukan` int(11) NOT NULL,
  `bentuk_pemasukan` varchar(225) NOT NULL,
  `id_kategori_pemasukan` int(11) NOT NULL,
  `bukti_pemasukan` varchar(500) NOT NULL,
  `id_bank` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `pemasukan`
--

INSERT INTO `pemasukan` (`id_pemasukan`, `tanggal_pemasukan`, `total_pemasukan`, `bentuk_pemasukan`, `id_kategori_pemasukan`, `bukti_pemasukan`, `id_bank`, `created_at`, `updated_at`, `is_deleted`) VALUES
(1, '2024-12-12', 320000, 'Transfer', 2, 'cce50b45-321b-4f56-8d51-2f54325d19b2.JPG', 1, '2024-04-28 19:22:25', '2024-04-28 19:22:25', '2024-04-28 19:22:25'),
(2, '2024-03-12', 345000, 'Transfer', 2, 'pemasukan\\a8f36023-1010-49b3-b20d-698d5290510d.JPG', 4, '2024-04-28 20:39:11', '2024-04-28 20:39:11', '2024-04-28 20:39:11'),
(3, '2024-02-14', 35000, 'Tunai', 3, 'pemasukan\\9a650356-1267-4e8f-96e9-47a4e001fd78.JPG', 10, '2024-04-29 06:08:05', '2024-04-29 06:08:05', '2024-04-29 06:08:05'),
(4, '0000-00-00', 500000, 'Transfer', 1, '2c65e40f-728e-466a-9768-a54bc7ca43cb520096006182737514.jpg', 1, '2024-05-15 03:08:13', '2024-05-15 03:08:13', '2024-05-15 03:08:13'),
(5, '0000-00-00', 500000, 'Transfer', 2, '256098f9-efc6-4cb1-a7e3-210f1fd371c03672040295924617210.jpg', 9, '2024-05-15 04:07:35', '2024-05-15 04:07:35', '2024-05-15 04:07:35');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `bank`
--
ALTER TABLE `bank`
  ADD PRIMARY KEY (`id_bank`);

--
-- Indeks untuk tabel `kategori_pemasukab`
--
ALTER TABLE `kategori_pemasukab`
  ADD PRIMARY KEY (`id_kategori_pemasukan`);

--
-- Indeks untuk tabel `pemasukan`
--
ALTER TABLE `pemasukan`
  ADD PRIMARY KEY (`id_pemasukan`),
  ADD KEY `fk_kategori_pemasukan` (`id_kategori_pemasukan`),
  ADD KEY `fk_bank` (`id_bank`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `bank`
--
ALTER TABLE `bank`
  MODIFY `id_bank` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `kategori_pemasukab`
--
ALTER TABLE `kategori_pemasukab`
  MODIFY `id_kategori_pemasukan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `pemasukan`
--
ALTER TABLE `pemasukan`
  MODIFY `id_pemasukan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `pemasukan`
--
ALTER TABLE `pemasukan`
  ADD CONSTRAINT `fk_bank` FOREIGN KEY (`id_bank`) REFERENCES `bank` (`id_bank`),
  ADD CONSTRAINT `fk_kategori_pemasukan` FOREIGN KEY (`id_kategori_pemasukan`) REFERENCES `kategori_pemasukab` (`id_kategori_pemasukan`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
