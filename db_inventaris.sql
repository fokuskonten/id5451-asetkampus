-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: db_inventaris
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bahan_praktek`
--

DROP TABLE IF EXISTS `bahan_praktek`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bahan_praktek` (
  `id_praktek` int(11) NOT NULL AUTO_INCREMENT,
  `kode_bahan` varchar(20) DEFAULT NULL,
  `nama_bahan` varchar(100) DEFAULT NULL,
  `spesifikasi` text DEFAULT NULL,
  `id_jurusan` int(11) DEFAULT NULL,
  `id_lab` int(11) DEFAULT NULL,
  `stok` int(11) DEFAULT NULL,
  `kondisi` enum('Baik','Kurang Baik','Rusak') DEFAULT 'Baik',
  `satuan` varchar(50) DEFAULT NULL,
  `tgl_masuk` date DEFAULT NULL,
  PRIMARY KEY (`id_praktek`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bahan_praktek`
--

LOCK TABLES `bahan_praktek` WRITE;
/*!40000 ALTER TABLE `bahan_praktek` DISABLE KEYS */;
/*!40000 ALTER TABLE `bahan_praktek` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `distribusi_history`
--

DROP TABLE IF EXISTS `distribusi_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `distribusi_history` (
  `id_history` int(11) NOT NULL AUTO_INCREMENT,
  `id_distribusi` int(11) DEFAULT NULL,
  `jumlah_masuk` int(11) DEFAULT NULL,
  `tanggal_log` datetime DEFAULT NULL,
  `keterangan_log` text DEFAULT NULL,
  `status_log` enum('Lengkap','Sebagian') DEFAULT NULL,
  PRIMARY KEY (`id_history`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `distribusi_history`
--

LOCK TABLES `distribusi_history` WRITE;
/*!40000 ALTER TABLE `distribusi_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `distribusi_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `distribusi_lab`
--

DROP TABLE IF EXISTS `distribusi_lab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `distribusi_lab` (
  `id_distribusi` int(11) NOT NULL AUTO_INCREMENT,
  `id_permintaan` int(11) DEFAULT NULL,
  `id_praktek` int(11) DEFAULT NULL,
  `id_lab` int(11) DEFAULT NULL,
  `kode_distribusi` varchar(50) DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `jumlah_diterima` int(11) DEFAULT 0,
  `tanggal_distribusi` datetime DEFAULT NULL,
  `spesifikasi` text DEFAULT NULL,
  `kondisi` varchar(50) DEFAULT NULL,
  `status` enum('dikirim','diterima','ditolak') NOT NULL,
  `keterangan` text DEFAULT NULL,
  `tanggal_diterima` datetime DEFAULT NULL,
  `balasan_admin` text DEFAULT NULL,
  `is_read_lab` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id_distribusi`),
  KEY `id_praktek` (`id_praktek`),
  KEY `id_lab` (`id_lab`),
  CONSTRAINT `distribusi_lab_ibfk_1` FOREIGN KEY (`id_praktek`) REFERENCES `bahan_praktek` (`id_praktek`),
  CONSTRAINT `distribusi_lab_ibfk_2` FOREIGN KEY (`id_lab`) REFERENCES `lab` (`id_lab`)
) ENGINE=InnoDB AUTO_INCREMENT=308 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `distribusi_lab`
--

LOCK TABLES `distribusi_lab` WRITE;
/*!40000 ALTER TABLE `distribusi_lab` DISABLE KEYS */;
/*!40000 ALTER TABLE `distribusi_lab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gudang_persediaan`
--

DROP TABLE IF EXISTS `gudang_persediaan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gudang_persediaan` (
  `id_persediaan` int(11) NOT NULL AUTO_INCREMENT,
  `nama_barang` varchar(255) NOT NULL,
  `satuan` varchar(50) DEFAULT NULL,
  `stok_awal` int(11) DEFAULT 0,
  `pengajuan_barang` int(11) DEFAULT 0,
  `pemakaian_barang` int(11) DEFAULT 0,
  `stok_akhir` int(11) GENERATED ALWAYS AS (`stok_awal` + `pengajuan_barang` - `pemakaian_barang`) VIRTUAL,
  `tgl_input` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_persediaan`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gudang_persediaan`
--

LOCK TABLES `gudang_persediaan` WRITE;
/*!40000 ALTER TABLE `gudang_persediaan` DISABLE KEYS */;
/*!40000 ALTER TABLE `gudang_persediaan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jurusan`
--

DROP TABLE IF EXISTS `jurusan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jurusan` (
  `id_jurusan` int(11) NOT NULL AUTO_INCREMENT,
  `nama_jurusan` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_jurusan`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jurusan`
--

LOCK TABLES `jurusan` WRITE;
/*!40000 ALTER TABLE `jurusan` DISABLE KEYS */;
INSERT INTO `jurusan` VALUES (1,'Teknik Kimia Mineral'),(2,'Teknik Industri Agro'),(3,'Teknik Manufaktur Industri Agro'),(4,'Otomasi Sistem Permesinan'),(8,'Laboratorium Mata Kuliah Umum');
/*!40000 ALTER TABLE `jurusan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kepala_lab`
--

DROP TABLE IF EXISTS `kepala_lab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kepala_lab` (
  `id_kepala` int(11) NOT NULL AUTO_INCREMENT,
  `id_lab` int(11) DEFAULT NULL,
  `nama_kepala` varchar(100) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `pin_pemulihan` varchar(6) DEFAULT NULL,
  `password_plain` varchar(255) DEFAULT NULL,
  `nip` varchar(50) DEFAULT NULL,
  `kontak` varchar(20) DEFAULT NULL,
  `role` varchar(20) DEFAULT 'kepala_lab',
  PRIMARY KEY (`id_kepala`),
  UNIQUE KEY `username` (`username`),
  KEY `id_lab` (`id_lab`),
  CONSTRAINT `kepala_lab_ibfk_1` FOREIGN KEY (`id_lab`) REFERENCES `lab` (`id_lab`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kepala_lab`
--

LOCK TABLES `kepala_lab` WRITE;
/*!40000 ALTER TABLE `kepala_lab` DISABLE KEYS */;
INSERT INTO `kepala_lab` VALUES (9,6,'KAROLUS GANTENG','testing','$2y$10$cWTCZpvWh3TjVneYD6WAoec1Er/Jhhp801flFL..69bmIMdT3sIJS',NULL,'testing','9999999999','034023023029','kepala_lab'),(11,20,'Iman Pradana A. Assegaf, M.Eng','pengelasan','$2y$10$msHZ8.zOsxwzDhlNjT/A/ec6A/tuidpIv9KX6IeBSE9PscbFir5oG',NULL,'pengelasan','9999999999','034023023029','kepala_lab'),(12,21,'Nursida, A.Md','nursida','$2y$10$b65FbUZBpL7PDjNSJkEjHOppCq9nh1sRxLq25aVjP.51cjM08Us7q',NULL,'atim123','1997xxx','081234567890','kepala_lab');
/*!40000 ALTER TABLE `kepala_lab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lab`
--

DROP TABLE IF EXISTS `lab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lab` (
  `id_lab` int(11) NOT NULL AUTO_INCREMENT,
  `id_jurusan` int(11) DEFAULT NULL,
  `nama_lab` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_lab`),
  KEY `id_jurusan` (`id_jurusan`),
  CONSTRAINT `lab_ibfk_1` FOREIGN KEY (`id_jurusan`) REFERENCES `jurusan` (`id_jurusan`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lab`
--

LOCK TABLES `lab` WRITE;
/*!40000 ALTER TABLE `lab` DISABLE KEYS */;
INSERT INTO `lab` VALUES (6,4,'Laboratorium Pneumatik dan Hidrolik'),(7,4,'Laboratorium Instalasi Listrik'),(9,4,'Laboratorium Otomasi'),(10,4,'Laboratorium Sistem Permesinan '),(11,4,'Laboratorium Teknologi Informasi dan Jaringan'),(12,4,'Laboratorium Elektronika dan Instrumentasi'),(13,4,'Laboratorium Mesin Listrik'),(15,2,'Laboratorium Sistem Produksi '),(16,2,'Laboratorium Perancangan Teknik Industri '),(17,2,'Laboratorium Sistem Kerja dan Ergonomi'),(18,2,'Laboratorium Rekayasa Tekno-Ekonomi'),(19,1,'Laboratorium Dasar Proses dan Pengujian Terpadu'),(20,3,'Workshop Pengelasan'),(21,3,'Laboratorium CNC'),(22,3,'Laboratorium Gambar'),(23,3,' Laboratorium Pengujian Material'),(24,3,'Workshop Proses Produksi'),(25,2,'Laboratorium Teknologi Proses Agro'),(26,2,'Laboratorium Statistik dan Rekayasa Kualitas'),(27,4,'Laboratorium Manufaktur Terapan'),(28,1,'Laboratorium Konversi Biomassa dan Lingkungan '),(29,1,'Laboratorium Material dan Metalurgi Ekstraktif'),(30,1,'Laboratorium Simulasi Proses'),(31,1,'Laboratorium Operasi Teknik Kimia'),(32,1,'Laboratorium Benefisiasi Mineral'),(33,3,'Laboratorium Pemeliharaan Mesin Industri'),(34,3,'Laboratorium Desain'),(36,8,'Laboratorium Fisika');
/*!40000 ALTER TABLE `lab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_key`
--

DROP TABLE IF EXISTS `master_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_key` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kode_rahasia` varchar(255) NOT NULL,
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_key`
--

LOCK TABLES `master_key` WRITE;
/*!40000 ALTER TABLE `master_key` DISABLE KEYS */;
INSERT INTO `master_key` VALUES (1,'ADMIN_SECRET_2026','2026-01-09 02:18:09');
/*!40000 ALTER TABLE `master_key` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pemakaian_lab`
--

DROP TABLE IF EXISTS `pemakaian_lab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pemakaian_lab` (
  `id_pemakaian` int(11) NOT NULL AUTO_INCREMENT,
  `id_distribusi` int(11) NOT NULL,
  `kode_distribusi` varchar(50) NOT NULL,
  `id_praktek` int(11) NOT NULL,
  `id_lab` int(11) NOT NULL,
  `jumlah_pakai` int(11) NOT NULL,
  `tgl_pakai` datetime DEFAULT current_timestamp(),
  `keterangan` text DEFAULT NULL,
  `status_kunci` int(11) DEFAULT 0,
  PRIMARY KEY (`id_pemakaian`),
  KEY `id_praktek` (`id_praktek`),
  CONSTRAINT `pemakaian_lab_ibfk_1` FOREIGN KEY (`id_praktek`) REFERENCES `bahan_praktek` (`id_praktek`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pemakaian_lab`
--

LOCK TABLES `pemakaian_lab` WRITE;
/*!40000 ALTER TABLE `pemakaian_lab` DISABLE KEYS */;
/*!40000 ALTER TABLE `pemakaian_lab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pengaturan_sistem`
--

DROP TABLE IF EXISTS `pengaturan_sistem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pengaturan_sistem` (
  `nama_pengaturan` varchar(50) NOT NULL,
  `nilai_pengaturan` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`nama_pengaturan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pengaturan_sistem`
--

LOCK TABLES `pengaturan_sistem` WRITE;
/*!40000 ALTER TABLE `pengaturan_sistem` DISABLE KEYS */;
INSERT INTO `pengaturan_sistem` VALUES ('status_input_stok',0);
/*!40000 ALTER TABLE `pengaturan_sistem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permintaan_bahan`
--

DROP TABLE IF EXISTS `permintaan_bahan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permintaan_bahan` (
  `id_permintaan` int(11) NOT NULL AUTO_INCREMENT,
  `id_barang` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `stok_saat_ini` int(11) DEFAULT 0,
  `tgl_permintaan` datetime NOT NULL,
  `status` enum('pending','approved','rejected') NOT NULL,
  PRIMARY KEY (`id_permintaan`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permintaan_bahan`
--

LOCK TABLES `permintaan_bahan` WRITE;
/*!40000 ALTER TABLE `permintaan_bahan` DISABLE KEYS */;
/*!40000 ALTER TABLE `permintaan_bahan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permintaan_barang`
--

DROP TABLE IF EXISTS `permintaan_barang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permintaan_barang` (
  `id_permintaan` int(11) NOT NULL AUTO_INCREMENT,
  `id_kepala` int(11) NOT NULL,
  `id_barang` int(11) NOT NULL,
  `stok_awal` int(11) DEFAULT 0,
  `spesifikasi` text DEFAULT NULL,
  `jumlah_minta` int(11) NOT NULL,
  `kondisi` varchar(50) DEFAULT NULL,
  `jumlah_disetujui` int(11) DEFAULT 0,
  `jumlah_terpenuhi` int(11) DEFAULT 0,
  `tgl_permintaan` datetime DEFAULT current_timestamp(),
  `tgl_proses` datetime DEFAULT NULL,
  `status` enum('pending','disetujui','ditolak','dikirim') DEFAULT 'pending',
  `keterangan_kepala` text DEFAULT NULL,
  `catatan_admin` text DEFAULT NULL,
  PRIMARY KEY (`id_permintaan`),
  KEY `fk_permintaan_bahan` (`id_barang`),
  CONSTRAINT `fk_permintaan_bahan` FOREIGN KEY (`id_barang`) REFERENCES `bahan_praktek` (`id_praktek`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=220 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permintaan_barang`
--

LOCK TABLES `permintaan_barang` WRITE;
/*!40000 ALTER TABLE `permintaan_barang` DISABLE KEYS */;
/*!40000 ALTER TABLE `permintaan_barang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `pin_pemulihan` varchar(6) DEFAULT NULL,
  `role` enum('admin','admin-acc','kepala_lab') DEFAULT NULL,
  `nama_lengkap` varchar(100) DEFAULT NULL,
  `nip` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','$2y$10$oNtL6LXdZdRCrrXm/FIlDeudgXpZW/V4o/qoDfVuljmK50OTD32Za','123456','admin','Administrator Aset Kampus','198501012010011001'),(17,'ibudiann','$2y$10$RIYks5pewj1.RNT/iWq3hOI8MK6Jl7Q8anBd0/r7TkIgNCHokr0o6','212223','admin','Ibu Dian','10101010101010101');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-19  6:17:20
