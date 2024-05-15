CREATE DATABASE server_pengeluaran

USE server_pengeluaran



CREATE TABLE bank (
  id_bank INT NOT NULL AUTO_INCREMENT,
  nama_bank VARCHAR(225) NOT NULL,
  keterangan TEXT NOT NULL,
  create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  is_deleted TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_bank)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bank`
--

INSERT INTO `bank` (`id_bank`, `nama_bank`, `keterangan`, `create_at`, `update_at`, `is_deleted`) VALUES
(1, 'BRI', 'Bank Rakyat Indonesia', '2024-04-27 15:22:33', '2024-04-27 15:22:33', '2024-04-27 15:22:33'),
(2, 'BNI', 'Bank Negara Indonesia', '2024-04-27 15:22:45', '2024-04-27 15:22:45', '2024-04-27 15:22:45'),
(3, 'Bank Mayapada', 'Bank Mayapada', '2024-04-27 15:23:03', '2024-04-27 15:23:03', '2024-04-27 15:23:03'),
(4, 'BCA', 'Bank Central Asia', '2024-04-27 15:23:41', '2024-04-27 15:23:41', '2024-04-27 15:23:41'),
(5, 'Dana', 'Platform Dana', '2024-04-27 15:23:58', '2024-04-27 15:23:58', '2024-04-27 15:23:58'),
(6, 'Mandiri', 'Bank Mandiri', '2024-04-27 15:24:11', '2024-04-27 15:24:11', '2024-04-27 15:24:11'),
(7, 'BSI', 'Bank Syariah Indonesia', '2024-04-27 15:24:27', '2024-04-27 15:24:27', '2024-04-27 15:24:27'),
(8, 'Bank Aceh', 'Bank Aceh', '2024-04-27 15:24:42', '2024-04-27 15:24:42', '2024-04-27 15:24:42'),
(9, 'Bank Lainnya', 'Bank Lainnya yang terdaftar di Indonesia', '2024-04-27 15:25:20', '2024-04-27 15:25:20', '2024-04-27 15:25:20'),
(10, 'Tunai', 'Secara Tunai', '2024-04-29 12:42:03', '2024-04-29 12:42:03', '2024-04-29 12:42:03');




CREATE TABLE kategori_pengeluaran (
  id_kategori_pengeluaran INT NOT NULL AUTO_INCREMENT,
  kategori_pengeluaran VARCHAR(225) NOT NULL,
  deskripsi TEXT NOT NULL,
  create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  is_deleted TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_kategori_pengeluaran)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `kategori_pengeluaran` (`id_kategori_pengeluaran`, `kategori_pengeluaran`, `deskripsi`, `create_at`, `update_at`, `is_deleted`) VALUES
(1, 'Perbaikan Gereja', 'Pengeluaran Maintenance Gereja HKBP Palmarum', '2024-04-27 15:12:13', '2024-04-27 15:12:13', '2024-04-27 15:12:13'),
(2, 'Acara Gereja', 'Pengeluaran Acara Gereja HKBP Palmarum', '2024-04-27 15:13:42', '2024-04-27 15:13:42', '2024-04-27 15:13:42'),
(3, 'Acara Diluar Gereja', 'Pengeluaran Acara Diluar Gereja ', '2024-04-27 15:15:18', '2024-04-27 15:15:18', '2024-04-27 15:15:18'),
(4, 'Bantuan Dana ke Organisasi', 'Bantuan Dana Ke Organisasi di Gereja HKBP Palmarum', '2024-04-27 15:18:03', '2024-04-27 15:18:03', '2024-04-27 15:18:03'),
(5, 'Dana Sosial', 'Bantuan Dana Sosial', '2024-04-27 15:19:11', '2024-04-27 15:19:11', '2024-04-27 15:19:11'),
(6, 'Lainnya', 'Pengeluaran Lainnya yang terjadi didalam gereja maupun diluar gereja', '2024-04-27 15:19:50', '2024-04-27 15:19:50', '2024-04-27 15:19:50');


CREATE TABLE pengeluaran (
  id_pengeluaran INT NOT NULL AUTO_INCREMENT,
  jumlah_pengeluaran INT NOT NULL,
  tanggal_pengeluaran VARCHAR(15) NOT NULL,
  keterangan_pengeluaran VARCHAR(225) NOT NULL,
  id_kategori_pengeluaran INT NOT NULL,
  id_bank INT NOT NULL,
  bukti_pengeluaran VARCHAR(500) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  is_deleted TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_pengeluaran),
  CONSTRAINT fk_pengeluaran_kategori FOREIGN KEY (id_kategori_pengeluaran) REFERENCES kategori_pengeluaran (id_kategori_pengeluaran),
  CONSTRAINT fk_pengeluaran_bank FOREIGN KEY (id_bank) REFERENCES bank (id_bank)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pengeluaran`
--

INSERT INTO `pengeluaran` (`id_pengeluaran`, `jumlah_pengeluaran`, `tanggal_pengeluaran`, `keterangan_pengeluaran`, `id_kategori_pengeluaran`, `id_bank`, `bukti_pengeluaran`, `created_at`, `updated_at`, `is_deleted`) VALUES
(13, 1500000, '2024-4-27', 'Acara Kebaktian Minggu Malam HKBP Palmarum', 2, 6, 'pengeluaran\\27f8fe1c-79d7-45b0-9b92-6fb1be9ad947.JPG', '2024-04-28 05:08:09', '2024-04-28 05:08:09', '2024-04-28 05:08:09'),
(15, 2000000, '2024-4-27', 'Acara Kebaktian Minggu Malam HKBP Palmarum', 2, 2, 'pengeluaran\\e0677290-7a10-4535-a1a3-ce175eba6bd8.JPG', '2024-04-28 05:28:44', '2024-04-28 05:28:44', '2024-04-28 05:28:44'),
(16, 1300000, '2024-12-12', 'Acara Kebaktian Minggu Sore HKBP Palmarum', 2, 5, 'pengeluaran\\a52a7522-0541-4450-8d1b-00fa0c1ab01f.JPG', '2024-04-28 05:29:23', '2024-04-28 05:29:23', '2024-04-28 05:29:23');




-- GET PENGELUARAN
DELIMITER //

CREATE PROCEDURE ambil_pengeluaran()
BEGIN
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
END //

DELIMITER ;

CALL ambil_pengeluaran();


-- Create Pengeluaran
DELIMITER //

CREATE PROCEDURE tambah_pengeluaran(
    IN p_jumlah_pengeluaran INT,
    IN p_tanggal_pengeluaran VARCHAR(225),
    IN p_keterangan_pengeluaran VARCHAR(225),
    IN p_id_kategori_pengeluaran INT,
    IN p_id_bank INT,
    IN p_bukti_pengeluaran VARCHAR(500)
)
BEGIN
    INSERT INTO pengeluaran (
        jumlah_pengeluaran,
        tanggal_pengeluaran,
        keterangan_pengeluaran,
        id_kategori_pengeluaran,
        id_bank,
        bukti_pengeluaran
    ) VALUES (
        p_jumlah_pengeluaran,
        p_tanggal_pengeluaran,
        p_keterangan_pengeluaran,
        p_id_kategori_pengeluaran,
        p_id_bank,
        p_bukti_pengeluaran
    );
END //

DELIMITER ;

DROP PROCEDURE ambil_pengeluaran


-- Update Pengeluaran
DELIMITER //

CREATE PROCEDURE ubah_pengeluaran(
    IN p_IDpengeluaran INT,
    IN p_bukti_pengeluaran VARCHAR(500),
    IN p_jumlah_pengeluaran INT,
    IN p_tanggal_pengeluaran VARCHAR(255),
    IN p_keterangan_pengeluaran VARCHAR(255),
    IN p_id_kategori_pengeluaran INT,
    IN p_id_bank INT
)
BEGIN
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
END //

DELIMITER ;

DROP PROCEDURE ubah_pengeluaran


-- GETBYID Pengeluaran
DELIMITER //

CREATE PROCEDURE getById_pengeluaran(
    IN p_id_pengeluaran INT
)
BEGIN
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
END //

DELIMITER ;

CALL getById_pengeluaran(13)