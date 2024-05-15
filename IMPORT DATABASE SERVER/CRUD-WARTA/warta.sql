-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 15 Bulan Mei 2024 pada 09.57
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
-- Database: `warta`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `warta`
--

CREATE TABLE `warta` (
  `id_warta` int(11) NOT NULL,
  `warta` text NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `warta`
--

INSERT INTO `warta` (`id_warta`, `warta`, `create_at`, `update_at`, `deleted_at`) VALUES
(1, 'Acara perayaan tersebut diawali dengan ibadah yang diselenggarakan di dalam gedung gerejadan di atas lahan yang baru dibeli yang berlokasi di sekitaran Stadion Mini Tarutung. Ibadah dilayani Liturgis Praeses HKBP Distrik II Silindung, Pdt. Hasudungan Manalu, dan Pendeta HKBP Ressort Palmarum, Pdt. Marthin Gultom, pembaca warta jemaat St. Nelson Siahaan, yang juga anggota MPS dari HKBP Distrik II Silindung.\n\nPerayaan 25 tahun berdirinya HKBP ditandai dengan penggunaan lahan yang baru dibeli sebagai tempat perayaan. Tanah ini diharapkan akan menjadi basis untuk pengembangan lebih lanjut dalam pelayanan HKBP Palmarum. Menurut informasi yang diperoleh, proses pelunasan tanah dilakukan secara bertahap dengan total mencapai Rp. 725.000.000 ditambah biaya penimbunan dan pengurusan surat sekitar Rp. 75.000.000.', '2024-05-15 03:47:03', '2024-05-15 03:47:03', '2024-05-15 03:47:03'),
(2, 'Ephorus HKBP Pdt. Dr. Robinson Butarbutar dalam bimbingan pastoralnya mengajak seluruh parhalado dan warga jemaat untuk menjaga kekompakan. Ephorus juga mengajak seluruh warga HKBP Palmarum menghayati penyambutan Yesus dalam segala dimensi kehidupan mereka.\n\nHKBP Palmarum beranggotakan 146 kepala keluarga jemaat yang dilayani oleh 8 orang penatua, seorang pendeta fungsional, dan seorang pendeta resort. Para jemaat dan majelis gereja terlihat antusias dalam mempersiapkan segala kebutuhan perayaan.', '2024-05-15 03:50:31', '2024-05-15 03:50:31', '2024-05-15 03:50:31'),
(3, 'Rangkaian ibadah dan perayaan dihadiri seluruh parhalado dan warga jemaat,  perwakilan pemerintah, tamu undangan lainnya, seperti Paduan Suara dari HKBP Pearaja, HKBP Tarutung Kota, dan GKPI Kota Tarutung.\n\nParayaan pesta diisi dengan tarian tortor, penyematan ulos oleh Ompu i Ephorus kepada jemaat, pemerhati, dan tamu undangan lainnya. Sukacita mereka bertambah dengan adanya anak rantau yang turut berkontribusi dengan menyumbangkan peralatan musik gerejawi senilai Rp. 200.000.000.', '2024-05-15 04:06:31', '2024-05-15 04:06:31', '2024-05-15 04:06:31');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `warta`
--
ALTER TABLE `warta`
  ADD PRIMARY KEY (`id_warta`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `warta`
--
ALTER TABLE `warta`
  MODIFY `id_warta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
