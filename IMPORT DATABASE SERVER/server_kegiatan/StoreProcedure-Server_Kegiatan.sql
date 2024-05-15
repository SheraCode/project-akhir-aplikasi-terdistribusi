CREATE DATABASE server_kegiatan

USE server_kegiatan




--
-- Table structure for table `gereja`
--

CREATE TABLE `gereja` (
  `id_gereja` INT NOT NULL PRIMARY KEY,
  `id_ressort` INT NOT NULL,
  `id_jenis_gereja` INT NOT NULL,
  `kode_gereja` INT NOT NULL,
  `nama_gereja` VARCHAR(225) NOT NULL,
  `alamat` TEXT NOT NULL,
  `id_kelurahan_gereja` INT NOT NULL,
  `nama_pendeta` VARCHAR(225) NOT NULL,
  `tgl_berdiri` DATE NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

ALTER TABLE `gereja`
  MODIFY `id_gereja` INT NOT NULL AUTO_INCREMENT;
  
  ALTER TABLE `gereja`
  ADD CONSTRAINT `gereja_ibfk_1` FOREIGN KEY (`id_ressort`) REFERENCES `ressort` (`id_ressort`),
  ADD CONSTRAINT `gereja_ibfk_2` FOREIGN KEY (`id_jenis_gereja`) REFERENCES `jenis_gereja` (`id_jenis_gereja`),
  ADD CONSTRAINT `gereja_ibfk_3` FOREIGN KEY (`id_kelurahan_gereja`) REFERENCES `kelurahan` (`id_kelurahan_desa`);
  

 CREATE TABLE `kelurahan` (
  `id_kelurahan_desa` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `nama_kelurahan` VARCHAR(225) NOT NULL,
  `id_kecamatan_kelurahan` INT NOT NULL,
  `create_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
)ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


  DROP TABLE kelurahan
  


CREATE TABLE `ressort` (
  `id_ressort` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `id_distrik` INT NOT NULL,
  `kode_ressort` INT NOT NULL,
  `nama_ressort` VARCHAR(225) NOT NULL,
  `alamat` TEXT NOT NULL,
  `id_kecamatan` INT NOT NULL,
  `pendeta_ressort` VARCHAR(225) NOT NULL,
  `tgl_berdiri` DATE NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

ALTER TABLE `ressort`
  ADD CONSTRAINT `ressort_ibfk_1` FOREIGN KEY (`id_distrik`) REFERENCES `distrik` (`id_distrik`),
  ADD CONSTRAINT `ressort_ibfk_2` FOREIGN KEY (`id_kecamatan`) REFERENCES `kecamatan` (`id_kecamatan`);

DROP TABLE `ressort` 

--
-- Table structure for table `jenis_gereja`
--

CREATE TABLE `jenis_gereja` (
  `id_jenis_gereja` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `jenis_gereja` VARCHAR(225) NOT NULL,
  `keterangan` TEXT NOT NULL,
  `create_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE `jenis_gereja`





--
-- Table structure for table `distrik`
--

CREATE TABLE `distrik` (
  `id_distrik` int NOT NULL   PRIMARY KEY ,
  `kode_distrik` int NOT NULL,
  `nama_distrik` varchar(100) NOT NULL,
  `alamat` text NOT NULL,
  `id_kecamatan` int NOT NULL,
  `nama_paraeses` varchar(225) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


ALTER TABLE `distrik`
  MODIFY `id_distrik` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `distrik`
  ADD CONSTRAINT `distrik_ibfk_1` FOREIGN KEY (`id_kecamatan`) REFERENCES `kecamatan` (`id_kecamatan`);
--
-- Table structure for table `kecamatan`
--

CREATE TABLE `kecamatan` (
  `id_kecamatan` int NOT NULL PRIMARY KEY,
  `nama_kecamatan` varchar(225) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE kecamatan
--
-- Dumping data for table `kecamatan`
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





--
-- Table structure for table `waktu_kegiatan`
--

CREATE TABLE `waktu_kegiatan` (
  `id_waktu_kegiatan` int NOT NULL primary key,
  `id_jenis_kegiatan` int NOT NULL,
  `id_gereja` int NOT NULL,
  `nama_kegiatan` varchar(225) NOT NULL,
  `lokasi_kegiatan` varchar(225) NOT NULL,
  `waktu_kegiatan` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `foto_kegiatan` varchar(400) NOT NULL,
  `keterangan` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `waktu_kegiatan` (
  `id_waktu_kegiatan` INT NOT NULL PRIMARY KEY,
  `id_jenis_kegiatan` INT NOT NULL,
  `id_gereja` INT NOT NULL,
  `nama_kegiatan` VARCHAR(225) NOT NULL,
  `lokasi_kegiatan` VARCHAR(225) NOT NULL,
  `waktu_kegiatan` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `foto_kegiatan` VARCHAR(400) NOT NULL,
  `keterangan` VARCHAR(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`id_jenis_kegiatan`) REFERENCES `jenis_kegiatan` (`id_jenis_kegiatan`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;






--
-- Dumping data for table `waktu_kegiatan`
--

INSERT INTO `waktu_kegiatan` (`id_waktu_kegiatan`, `id_jenis_kegiatan`, `id_gereja`, `nama_kegiatan`, `lokasi_kegiatan`, `waktu_kegiatan`, `foto_kegiatan`, `keterangan`, `create_at`, `update_at`, `is_deleted`) VALUES
(58, 1, 1, 'Paskah HKBP Palmarum Tarutung', 'Medan', '2024-04-11 13:38:34', 'palmarum.jpg', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. In laboriosam facere quo harum placeat. Necessitatibus, debitis rerum earum incidunt quod officia ad blanditiis eum sit non, libero quidem quam adipisci voluptatum excepturi qui. Enim, sed quidem esse animi officiis molestiae nulla architecto? Natus in tempora sit sunt quo. Voluptatem delectus vitae voluptates id ut harum aut molestiae autem repudiandae voluptas sequi odio, consequuntur molestias laborum assumenda nostrum unde ex tempora, nisi non culpa deserunt suscipit possimus? Quis ducimus porro voluptas minus quaerat error, veritatis ut ipsa ullam illum labore sit mollitia totam et fugit maiores magni quidem voluptatibus blanditiis laborum, excepturi nulla! Accusamus magnam delectus corporis. Repellendus commodi reprehenderit cumque nam possimus soluta expedita maiores doloribus asperiores quisquam et in, quaerat incidunt, facilis quidem quas hic culpa debitis! Quisquam nihil, itaque inventore explicabo, aliquam iusto reiciendis, quod qui ullam nam error aliquid ipsum nisi unde ipsam ad sequi magnam facere soluta quibusdam vero enim magni. Laudantium quaerat maxime earum dolore nisi cum autem nobis. Illum exercitationem possimus explicabo id quidem officiis est voluptas, veniam pariatur nobis, molestiae sapiente neque, tempora maiores. Maxime nulla porro eum, quod qui obcaecati eligendi, at, commodi quo quisquam iusto quidem doloribus. Sunt saepe velit beatae accusamus, nihil, error perferendis hic quisquam porro illum, et esse ea? Eveniet, ipsum repellendus excepturi, temporibus, modi nostrum minus maiores nulla fuga aut aspernatur sapiente voluptatem incidunt est? Aliquam laborum asperiores velit incidunt animi, enim dolor. Similique perferendis officiis facilis voluptatem rerum, reiciendis suscipit adipisci alias, magnam perspiciatis provident, aliquam modi repudiandae. Neque illum dolorem ab in deleniti optio totam, facere aspernatur porro similique fugit nesciunt repellendus deserunt sed labore. Veritatis libero et quidem maxime suscipit quos nesciunt, optio unde eum tenetur tempora assumenda eligendi quo facilis officia natus autem labore exercitationem minima ex nulla nostrum maiores. Doloremque, sit debitis!', '2024-04-11 13:38:34', '2024-04-11 13:38:34', '2024-04-11 13:38:34'),
(59, 1, 1, 'Sombu Sihol di kota Sibolga', 'Medan', '2024-04-11 13:39:35', 'sombusihol.jpg', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. In laboriosam facere quo harum placeat. Necessitatibus, debitis rerum earum incidunt quod officia ad blanditiis eum sit non, libero quidem quam adipisci voluptatum excepturi qui. Enim, sed quidem esse animi officiis molestiae nulla architecto? Natus in tempora sit sunt quo. Voluptatem delectus vitae voluptates id ut harum aut molestiae autem repudiandae voluptas sequi odio, consequuntur molestias laborum assumenda nostrum unde ex tempora, nisi non culpa deserunt suscipit possimus? Quis ducimus porro voluptas minus quaerat error, veritatis ut ipsa ullam illum labore sit mollitia totam et fugit maiores magni quidem voluptatibus blanditiis laborum, excepturi nulla! Accusamus magnam delectus corporis. Repellendus commodi reprehenderit cumque nam possimus soluta expedita maiores doloribus asperiores quisquam et in, quaerat incidunt, facilis quidem quas hic culpa debitis! Quisquam nihil, itaque inventore explicabo, aliquam iusto reiciendis, quod qui ullam nam error aliquid ipsum nisi unde ipsam ad sequi magnam facere soluta quibusdam vero enim magni. Laudantium quaerat maxime earum dolore nisi cum autem nobis. Illum exercitationem possimus explicabo id quidem officiis est voluptas, veniam pariatur nobis, molestiae sapiente neque, tempora maiores. Maxime nulla porro eum, quod qui obcaecati eligendi, at, commodi quo quisquam iusto quidem doloribus. Sunt saepe velit beatae accusamus, nihil, error perferendis hic quisquam porro illum, et esse ea? Eveniet, ipsum repellendus excepturi, temporibus, modi nostrum minus maiores nulla fuga aut aspernatur sapiente voluptatem incidunt est? Aliquam laborum asperiores velit incidunt animi, enim dolor. Similique perferendis officiis facilis voluptatem rerum, reiciendis suscipit adipisci alias, magnam perspiciatis provident, aliquam modi repudiandae. Neque illum dolorem ab in deleniti optio totam, facere aspernatur porro similique fugit nesciunt repellendus deserunt sed labore. Veritatis libero et quidem maxime suscipit quos nesciunt, optio unde eum tenetur tempora assumenda eligendi quo facilis officia natus autem labore exercitationem minima ex nulla nostrum maiores. Doloremque, sit debitis!', '2024-04-11 13:39:35', '2024-04-11 13:39:35', '2024-04-11 13:39:35');

	
--
-- Table structure for table `jenis_kegiatan`
--

CREATE TABLE `jenis_kegiatan` (
  `id_jenis_kegiatan` INT NOT NULL primary key ,
  `nama_jenis_kegiatan` VARCHAR(225) NOT NULL,
  `keterangan` TEXT NOT NULL,
  `create_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Dumping data for table `jenis_kegiatan`
--

INSERT INTO `jenis_kegiatan` (`id_jenis_kegiatan`, `nama_jenis_kegiatan`, `keterangan`, `create_at`, `update_at`, `is_deleted`) VALUES
(1, 'Kegiatan Dalam Gereja', 'Semua kegiatan yang dilakukan didalam lingkungan gereja', '2024-04-09 14:04:39', '2024-04-09 14:04:39', '2024-04-09 14:04:39'),
(2, 'Kegiatan Luar Gereja', 'Kegiatan yang dilakukan diluar lingkungan gereja', '2024-04-09 14:05:25', '2024-04-09 14:05:25', '2024-04-09 14:05:25');


DELIMITER //

CREATE PROCEDURE GetWaktuKegiatan()
BEGIN
    SELECT id_waktu_kegiatan, id_jenis_kegiatan, id_gereja, nama_kegiatan, lokasi_kegiatan, waktu_kegiatan, foto_kegiatan, keterangan
    FROM waktu_kegiatan;
END//

DELIMITER ;

CALL GetWaktuKegiatan

DELIMITER //

CREATE PROCEDURE GetWaktuKegiatanByID(IN id INT)
BEGIN
    SELECT id_waktu_kegiatan, id_jenis_kegiatan, id_gereja, nama_kegiatan, lokasi_kegiatan, waktu_kegiatan, foto_kegiatan, keterangan
    FROM waktu_kegiatan
    WHERE id_waktu_kegiatan = id;
END//

DELIMITER ;

CALL GetWaktuKegiatanByID(59)


DELIMITER //

CREATE PROCEDURE GetWaktuKegiatanHome()
BEGIN
    SELECT id_waktu_kegiatan, id_jenis_kegiatan, id_gereja, nama_kegiatan, lokasi_kegiatan, waktu_kegiatan,foto_kegiatan, keterangan
    FROM waktu_kegiatan
    ORDER BY id_waktu_kegiatan DESC
    LIMIT 5;
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE tambah_data_kegiatan(
    IN jenis_kegiatan_id INT,
    IN gereja_id INT,
    IN kegiatan_nama VARCHAR(225),
    IN kegiatan_lokasi VARCHAR(225),
    IN kegiatan_foto VARCHAR(400),
    IN keterangan TEXT
)
BEGIN
    INSERT INTO waktu_kegiatan (id_jenis_kegiatan, id_gereja, nama_kegiatan, lokasi_kegiatan, foto_kegiatan, keterangan)
    VALUES (jenis_kegiatan_id, gereja_id, kegiatan_nama, kegiatan_lokasi, kegiatan_foto, keterangan);
END //
DELIMITER ;



