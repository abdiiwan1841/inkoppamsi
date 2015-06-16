-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 17, 2015 at 03:52 AM
-- Server version: 5.6.16
-- PHP Version: 5.5.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `inkop_pamsiacc`
--

-- --------------------------------------------------------

--
-- Table structure for table `journal_details`
--

CREATE TABLE IF NOT EXISTS `journal_details` (
  `no_bukti` varchar(5) NOT NULL,
  `id_rekening` int(6) NOT NULL,
  `id_posisi` int(4) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  KEY `no_bukti` (`no_bukti`,`id_rekening`,`id_posisi`),
  KEY `id_rekening` (`id_rekening`),
  KEY `id_posisi` (`id_posisi`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `journal_headers`
--

CREATE TABLE IF NOT EXISTS `journal_headers` (
  `no_bukti` varchar(5) NOT NULL,
  `tanggal` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `keterangan` varchar(255) NOT NULL,
  `jumlah` decimal(15,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`no_bukti`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `klasifikasi`
--

CREATE TABLE IF NOT EXISTS `klasifikasi` (
  `id_klasifikasi` int(1) NOT NULL,
  `keterangan` varchar(60) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id_klasifikasi`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `klasifikasi`
--

INSERT INTO `klasifikasi` (`id_klasifikasi`, `keterangan`, `created_at`, `updated_at`) VALUES
(1, 'KLASIFIKASI UTAMA', '2015-02-02 16:24:51', '0000-00-00 00:00:00'),
(2, 'GOLONGAN', '2015-02-02 16:25:06', '0000-00-00 00:00:00'),
(3, 'KELOMPOK', '2015-02-02 16:25:20', '0000-00-00 00:00:00'),
(4, 'RINCIAN', '2015-02-02 16:25:33', '0000-00-00 00:00:00'),
(5, 'JENIS', '2015-02-02 16:25:46', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `posisis`
--

CREATE TABLE IF NOT EXISTS `posisis` (
  `id_posisi` int(4) NOT NULL AUTO_INCREMENT,
  `keterangan` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id_posisi`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `profils`
--

CREATE TABLE IF NOT EXISTS `profils` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `nama_perusahaan` varchar(100) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `telpon` varchar(15) NOT NULL,
  `fax` varchar(15) NOT NULL,
  `email` varchar(255) NOT NULL,
  `website` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `rekenings`
--

CREATE TABLE IF NOT EXISTS `rekenings` (
  `id_rekening` int(6) NOT NULL,
  `nama_rekening` varchar(255) NOT NULL,
  `id_klasifikasi` int(1) NOT NULL,
  `parent_id` int(6) NOT NULL,
  `normal_balance` varchar(10) NOT NULL,
  `posisi` varchar(10) NOT NULL,
  `saldo_awal_debet` decimal(15,2) NOT NULL,
  `saldo_awal_kredit` decimal(15,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id_rekening`),
  KEY `id_klasifikasi` (`id_klasifikasi`),
  KEY `parent_id` (`parent_id`),
  KEY `id_klasifikasi_2` (`id_klasifikasi`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rekenings`
--

INSERT INTO `rekenings` (`id_rekening`, `nama_rekening`, `id_klasifikasi`, `parent_id`, `normal_balance`, `posisi`, `saldo_awal_debet`, `saldo_awal_kredit`, `created_at`, `updated_at`) VALUES
(100000, 'AKTIVA', 1, 100000, 'DEBET', 'NERACA', '0.00', '0.00', '2015-02-02 16:27:18', '2015-01-13 17:00:00'),
(110000, 'AKTIVA LANCAR', 1, 100000, '', '', '0.00', '0.00', '2015-01-14 14:34:02', '0000-00-00 00:00:00'),
(111000, 'KAS DITANGAN', 1, 110000, '', '', '0.00', '0.00', '2015-01-14 14:43:30', '0000-00-00 00:00:00');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `journal_details`
--
ALTER TABLE `journal_details`
  ADD CONSTRAINT `journal_details_ibfk_1` FOREIGN KEY (`no_bukti`) REFERENCES `journal_headers` (`no_bukti`),
  ADD CONSTRAINT `journal_details_ibfk_2` FOREIGN KEY (`id_rekening`) REFERENCES `rekenings` (`id_rekening`),
  ADD CONSTRAINT `journal_details_ibfk_3` FOREIGN KEY (`id_posisi`) REFERENCES `posisis` (`id_posisi`);

--
-- Constraints for table `rekenings`
--
ALTER TABLE `rekenings`
  ADD CONSTRAINT `rekenings_ibfk_1` FOREIGN KEY (`id_klasifikasi`) REFERENCES `klasifikasi` (`id_klasifikasi`),
  ADD CONSTRAINT `rekenings_ibfk_2` FOREIGN KEY (`parent_id`) REFERENCES `rekenings` (`id_rekening`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
