
CREATE TABLE bank (
  id_bank INT NOT NULL AUTO_INCREMENT,
  nama_bank VARCHAR(225) NOT NULL,
  keterangan TEXT NOT NULL,
  create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  is_deleted TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_bank)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE bank;

CREATE DATABASE server_pemasukan


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

DROP TABLE kategori_pemasukab;



CREATE TABLE `kategori_pemasukab` (
  `id_kategori_pemasukan` INT AUTO_INCREMENT PRIMARY KEY,
  `kategori_pemasukan` VARCHAR(225) NOT NULL,
  `deskripsi` TEXT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


INSERT INTO `kategori_pemasukab` (`id_kategori_pemasukan`, `kategori_pemasukan`, `deskripsi`, `created_at`, `updated_at`, `is_deleted`) VALUES
(1, 'Bantuan Dana Organisasi', 'Bantuan Dana dari Organisasi', '2024-04-29 01:15:53', '2024-04-29 01:15:53', '2024-04-29 01:15:53'),
(2, 'Persembahan Kebaktian ', 'Persembahan Gereja HKBP Palmarum', '2024-04-29 01:16:18', '2024-04-29 01:16:18', '2024-04-29 01:16:18'),
(3, 'Sumbangan Jemaat', 'Persembahan Sumbangan Jemaat HKBP Palmarum Tarutung', '2024-04-29 01:26:37', '2024-04-29 01:26:37', '2024-04-29 01:26:37');



CREATE TABLE `pemasukan` (
  `id_pemasukan` INT AUTO_INCREMENT PRIMARY KEY,
  `tanggal_pemasukan` DATE NOT NULL,
  `total_pemasukan` INT NOT NULL,
  `bentuk_pemasukan` VARCHAR(225) NOT NULL,
  `id_kategori_pemasukan` INT NOT NULL,
  `bukti_pemasukan` VARCHAR(500) NOT NULL,
  `id_bank` INT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT `fk_kategori_pemasukan` FOREIGN KEY (`id_kategori_pemasukan`) REFERENCES `kategori_pemasukab` (`id_kategori_pemasukan`),
  CONSTRAINT `fk_bank` FOREIGN KEY (`id_bank`) REFERENCES `bank` (`id_bank`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE pemasukan;


INSERT INTO `pemasukan` (`id_pemasukan`, `tanggal_pemasukan`, `total_pemasukan`, `bentuk_pemasukan`, `id_kategori_pemasukan`, `bukti_pemasukan`, `id_bank`, `created_at`, `updated_at`, `is_deleted`) VALUES
(1, '2024-12-12', 320000, 'Transfer', 2, 'pemasukan\\cce50b45-321b-4f56-8d51-2f54325d19b2.JPG', 1, '2024-04-29 02:22:25', '2024-04-29 02:22:25', '2024-04-29 02:22:25'),
(2, '2024-03-12', 345000, 'Transfer', 2, 'pemasukan\\a8f36023-1010-49b3-b20d-698d5290510d.JPG', 4, '2024-04-29 03:39:11', '2024-04-29 03:39:11', '2024-04-29 03:39:11'),
(3, '2024-02-14', 35000, 'Tunai', 3, 'pemasukan\\9a650356-1267-4e8f-96e9-47a4e001fd78.JPG', 10, '2024-04-29 13:08:05', '2024-04-29 13:08:05', '2024-04-29 13:08:05');


DELIMITER //

CREATE PROCEDURE `GetAllPemasukan` ()
BEGIN
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
END //

DELIMITER ;

CALL GetAllPemasukan


-- CREATE PEMASUKAN


DELIMITER //

CREATE PROCEDURE `insert_pemasukan` (
    IN `p_tanggal_pemasukan` DATE,
    IN `p_total_pemasukan` INT,
    IN `p_bentuk_pemasukan` VARCHAR(225),
    IN `p_id_kategori_pemasukan` INT,
    IN `p_bukti_pemasukan` VARCHAR(500),
    IN `p_id_bank` INT
)
BEGIN
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
END //

DELIMITER ;


DROP PROCEDURE IF EXISTS `insert_pemasukan`;


DELIMITER //

CREATE PROCEDURE `update_pemasukan` (
    IN `p_id_pemasukan` INT,
    IN `p_tanggal_pemasukan` DATE,
    IN `p_total_pemasukan` INT,
    IN `p_bentuk_pemasukan` VARCHAR(225),
    IN `p_id_kategori_pemasukan` INT,
    IN `p_bukti_pemasukan` VARCHAR(500),
    IN `p_id_bank` INT
)
BEGIN
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
END //

DELIMITER ;



-- GetPemasukanBYID
DELIMITER //

CREATE PROCEDURE `getByIdPemasukan` (
    IN `p_id_pemasukan` INT
)
BEGIN
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
END //

DELIMITER ;

DROP PROCEDURE getByIdPemasukan

CALL getByIdPemasukan(1)

