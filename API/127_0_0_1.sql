-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 02, 2020 at 11:35 PM
-- Server version: 10.4.10-MariaDB
-- PHP Version: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `button`
--
CREATE DATABASE IF NOT EXISTS `button` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `button`;

-- --------------------------------------------------------

--
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
CREATE TABLE IF NOT EXISTS `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `artigos`
--

DROP TABLE IF EXISTS `artigos`;
CREATE TABLE IF NOT EXISTS `artigos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_familia` int(11) DEFAULT NULL,
  `id_servico` int(11) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `preco` float DEFAULT NULL,
  `disponivel` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `id_servico` (`id_servico`)
) ;

--
-- Dumping data for table `artigos`
--

INSERT INTO `artigos` (`id`, `id_familia`, `id_servico`, `name`, `preco`, `disponivel`) VALUES
(1, 1, 1, 'Teste', 5.3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `artigos_caracteristicas`
--

DROP TABLE IF EXISTS `artigos_caracteristicas`;
CREATE TABLE IF NOT EXISTS `artigos_caracteristicas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_artigo` int(11) DEFAULT NULL,
  `id_caracteristica` int(11) DEFAULT NULL,
  `descricao` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_artigo` (`id_artigo`),
  KEY `id_caracteristica` (`id_caracteristica`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `artigos_caracteristicas`
--

INSERT INTO `artigos_caracteristicas` (`id`, `id_artigo`, `id_caracteristica`, `descricao`) VALUES
(1, 1, 1, NULL),
(2, 1, 2, NULL),
(3, 1, 11, NULL),
(4, 2, 1, NULL),
(5, 2, 2, NULL),
(6, 2, 3, NULL),
(7, 2, 4, NULL),
(8, 3, 20, NULL),
(9, 3, 21, NULL),
(10, 4, 3, NULL),
(11, 4, 4, NULL),
(12, 5, 1, NULL),
(13, 5, 2, NULL),
(14, 5, 3, NULL),
(15, 5, 4, NULL),
(16, 6, 1, NULL),
(17, 6, 2, NULL),
(18, 6, 3, NULL),
(19, 6, 5, NULL),
(20, 7, 1, NULL),
(21, 7, 2, NULL),
(22, 7, 12, NULL),
(23, 7, 3, NULL),
(24, 7, 4, NULL),
(25, 7, 6, NULL),
(26, 8, 1, NULL),
(27, 8, 2, NULL),
(28, 8, 3, NULL),
(29, 8, 4, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `botao`
--

DROP TABLE IF EXISTS `botao`;
CREATE TABLE IF NOT EXISTS `botao` (
  `id_botao` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) DEFAULT NULL,
  `id_familia_funcao` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_botao`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `botao`
--

INSERT INTO `botao` (`id_botao`, `nome`, `id_familia_funcao`) VALUES
(1, 'Chamar Empregado', NULL),
(2, 'Pedir Conta', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `buttons`
--

DROP TABLE IF EXISTS `buttons`;
CREATE TABLE IF NOT EXISTS `buttons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `caracteristicas`
--

DROP TABLE IF EXISTS `caracteristicas`;
CREATE TABLE IF NOT EXISTS `caracteristicas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_fam_caracteristica` int(11) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_fam_caracteristica` (`id_fam_caracteristica`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `caracteristicas`
--

INSERT INTO `caracteristicas` (`id`, `id_fam_caracteristica`, `name`) VALUES
(1, 1, 'Com Gelo'),
(2, 1, 'Sem Gelo'),
(3, 2, '22 dl'),
(4, 2, '33 dl'),
(5, 2, '0,5 l'),
(6, 2, '1 l'),
(7, 3, 'Curto'),
(8, 3, 'Normal'),
(9, 3, 'Cheio'),
(10, 1, 'ddd'),
(11, 1, 'ddd'),
(12, 1, 'ddd'),
(13, 6, 'Filipa Mendia'),
(14, 5, 'Andreia Filipa do Nascimento'),
(15, 1, 'ddd'),
(16, 1, 'asdasda'),
(17, 1, 'Andreia Filipa do Nascimento'),
(18, 7, 'Sara torres'),
(19, 4, 'Light'),
(20, 8, 'Copo'),
(21, 8, 'Garrafa'),
(22, 10, 'Bem passado'),
(23, 10, 'Mal passado');

-- --------------------------------------------------------

--
-- Table structure for table `empregados`
--

DROP TABLE IF EXISTS `empregados`;
CREATE TABLE IF NOT EXISTS `empregados` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `phone` varchar(64) DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `empregados`
--

INSERT INTO `empregados` (`id`, `name`, `phone`, `email`) VALUES
(1, 'Diogodddd', '910620814', 'diogosantosecastro@gmail.com'),
(2, 'Carlos', '212424129', 'carlos@gmail.com'),
(3, 'Paulinho', '938045658', 'paulinho@gmail.com'),
(4, 'Diogo Santos eCastro', '9106208130', 'damadora.eventos@cruzvermelha.org.pt'),
(5, 'Rita', '9100000000', 'rita@google.com'),
(6, 'catia', '1234567890', 'catia@google.com'),
(7, 'Diogo Santos e Castro', '9106208142', 'osantosecastro@gmail.com'),
(8, 'Tesset', '808808808', 'ola@gmail.com'),
(9, 'catiaasssas', '1234567894', 'catccccia@google.com'),
(10, 'catiaasssasyyy', '1434567894', 'catccccyyyia@google.com'),
(11, 'asasasas', '7434567894', 'catcccssscyyyia@google.com'),
(12, 'asasasasgg', '743567894', 'catccggcssscyyyia@google.com'),
(13, 'asasasasggss', '743507894', 'catccsggcssscyyyia@google.com'),
(14, 'Pipa', '808242424', 'pipa@gmail.com'),
(15, 'Pipaggg', '808224241', 'pipajjj@gmail.com'),
(16, 'Paulo Maria', '707200400', 'paulo_maroa@gmail.com'),
(17, 'wqewqewqe', '910620812', 'Diogosantosesssscastro@gmail.com'),
(18, 'saSAs', '915620814', 'Diogosantossssecastro@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `encaminhamentos`
--

DROP TABLE IF EXISTS `encaminhamentos`;
CREATE TABLE IF NOT EXISTS `encaminhamentos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_fam_encaminhamento` int(11) DEFAULT NULL,
  `id_mesa` int(11) DEFAULT NULL,
  `id_servico` int(11) DEFAULT NULL,
  `id_terminal_empregado` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_fam_encaminhamento` (`id_fam_encaminhamento`),
  KEY `id_mesa` (`id_mesa`),
  KEY `id_servico` (`id_servico`),
  KEY `id_terminal_empregado` (`id_terminal_empregado`)
) ENGINE=MyISAM AUTO_INCREMENT=95 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `encaminhamentos`
--

INSERT INTO `encaminhamentos` (`id`, `id_fam_encaminhamento`, `id_mesa`, `id_servico`, `id_terminal_empregado`) VALUES
(1, 1, 1, 1, 1),
(2, 2, 1, 2, 1),
(3, 2, 2, 2, 2),
(4, 2, 3, 2, 2),
(5, 1, 1, 1, 1),
(6, 1, 2, 1, 1),
(7, 1, 3, 1, 1),
(8, 1, 4, 1, 1),
(9, 1, 5, 1, 1),
(10, 1, 6, 1, 1),
(11, 1, 7, 1, 1),
(12, 1, 8, 1, 1),
(13, 1, 10, 2, 2),
(14, 1, 12, 2, 2),
(15, 1, 9, 1, 2),
(16, 1, 10, 1, 2),
(17, 1, 11, 1, 2),
(18, 1, 12, 1, 2),
(19, 1, 1, 2, 6),
(20, 1, 2, 2, 6),
(21, 1, 3, 2, 6),
(22, 1, 4, 2, 6),
(23, 1, 5, 2, 6),
(24, 1, 6, 2, 6),
(25, 1, 7, 2, 6),
(26, 1, 8, 2, 6),
(27, 1, 9, 2, 6),
(28, 1, 10, 2, 6),
(29, 1, 11, 2, 6),
(30, 1, 12, 2, 6),
(31, 1, 1, 6, 6),
(32, 1, 2, 6, 6),
(33, 1, 3, 6, 6),
(34, 1, 4, 6, 6),
(35, 1, 5, 6, 6),
(36, 1, 6, 6, 6),
(37, 1, 7, 6, 6),
(38, 1, 8, 6, 6),
(39, 1, 9, 6, 6),
(40, 1, 10, 6, 6),
(41, 1, 11, 6, 6),
(42, 1, 12, 6, 6),
(43, 3, 1, 6, 1),
(44, 3, 2, 6, 1),
(45, 3, 3, 6, 1),
(46, 3, 4, 6, 1),
(47, 3, 5, 6, 1),
(48, 3, 6, 6, 1),
(49, 3, 7, 6, 1),
(50, 3, 8, 6, 1),
(51, 3, 9, 6, 1),
(52, 3, 10, 6, 1),
(53, 3, 11, 6, 1),
(54, 3, 12, 6, 1),
(55, 3, 1, 6, 2),
(56, 3, 2, 6, 2),
(57, 3, 3, 6, 2),
(58, 3, 4, 6, 2),
(59, 3, 1, 2, 6),
(60, 3, 2, 2, 6),
(61, 3, 3, 2, 6),
(62, 3, 4, 2, 6),
(63, 3, 5, 2, 6),
(64, 3, 6, 2, 6),
(65, 3, 7, 2, 6),
(66, 3, 8, 2, 6),
(67, 3, 9, 2, 6),
(68, 3, 10, 2, 6),
(69, 3, 11, 2, 6),
(70, 3, 12, 2, 6),
(71, 1, 1, 2, 6),
(72, 1, 2, 2, 6),
(73, 1, 3, 2, 6),
(74, 1, 4, 2, 6),
(75, 1, 5, 2, 6),
(76, 1, 6, 2, 6),
(77, 1, 7, 2, 6),
(78, 1, 8, 2, 6),
(79, 1, 9, 2, 6),
(80, 1, 10, 2, 6),
(81, 1, 11, 2, 6),
(82, 1, 12, 2, 6),
(83, 1, 1, 4, 5),
(84, 1, 2, 4, 5),
(85, 1, 3, 4, 5),
(86, 1, 4, 4, 5),
(87, 1, 5, 4, 5),
(88, 1, 6, 4, 5),
(89, 1, 7, 4, 5),
(90, 1, 8, 4, 5),
(91, 1, 9, 4, 5),
(92, 1, 10, 4, 5),
(93, 1, 11, 4, 5),
(94, 1, 12, 4, 5);

-- --------------------------------------------------------

--
-- Table structure for table `familias_displays`
--

DROP TABLE IF EXISTS `familias_displays`;
CREATE TABLE IF NOT EXISTS `familias_displays` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `familias_displays`
--

INSERT INTO `familias_displays` (`id`, `name`) VALUES
(1, 'Bar'),
(2, 'Esplanada');

-- --------------------------------------------------------

--
-- Table structure for table `familias_mesas`
--

DROP TABLE IF EXISTS `familias_mesas`;
CREATE TABLE IF NOT EXISTS `familias_mesas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `familias_mesas`
--

INSERT INTO `familias_mesas` (`id`, `name`) VALUES
(1, 'ola'),
(2, 'olaaa'),
(3, 'teste');

-- --------------------------------------------------------

--
-- Table structure for table `fam_caracteristicas`
--

DROP TABLE IF EXISTS `fam_caracteristicas`;
CREATE TABLE IF NOT EXISTS `fam_caracteristicas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `id_tipo_caracteristica` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `id_tipo_caracteristica` (`id_tipo_caracteristica`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `fam_caracteristicas`
--

INSERT INTO `fam_caracteristicas` (`id`, `name`, `id_tipo_caracteristica`) VALUES
(1, 'Gelo', 1),
(2, 'Volume', 1),
(3, 'Café', 1),
(4, 'sssss', 1),
(5, 'sdada', 2),
(6, 'Andreia Filipa do Nascimento', 1),
(7, 'Andreia Filipa do Nascimentouuuuu', 2),
(8, 'Vinho', 1),
(9, 'Ddd', 1),
(10, 'Bife', 1);

-- --------------------------------------------------------

--
-- Table structure for table `fam_encaminhamentos`
--

DROP TABLE IF EXISTS `fam_encaminhamentos`;
CREATE TABLE IF NOT EXISTS `fam_encaminhamentos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `default` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `default` (`default`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `fam_encaminhamentos`
--

INSERT INTO `fam_encaminhamentos` (`id`, `name`, `default`) VALUES
(1, 'Dia- semana', '2020-04-20 18:05:18'),
(2, 'Sexta', '2020-04-25 20:47:41'),
(3, 'Sábado', '2020-04-09 18:33:47'),
(4, 'Sábado + esplanada', '2020-04-25 20:00:03');

-- --------------------------------------------------------

--
-- Table structure for table `mesas`
--

DROP TABLE IF EXISTS `mesas`;
CREATE TABLE IF NOT EXISTS `mesas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numero` int(11) DEFAULT NULL,
  `familia_mesas_id` int(11) DEFAULT NULL,
  `familia_display_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numero` (`numero`),
  KEY `familia_mesas_id` (`familia_mesas_id`),
  KEY `familia_display_id` (`familia_display_id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mesas`
--

INSERT INTO `mesas` (`id`, `numero`, `familia_mesas_id`, `familia_display_id`) VALUES
(1, 1, 1, 2),
(2, 2, 1, 2),
(3, 3, 1, 2),
(4, 4, 2, 2),
(5, 5, 1, 1),
(6, 6, 1, 1),
(7, 7, 1, 1),
(8, 8, 1, 1),
(9, 9, 1, 1),
(10, 10, 1, 1),
(11, 11, 1, 1),
(12, 12, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_mesa` int(11) DEFAULT NULL,
  `id_button` int(11) DEFAULT NULL,
  `order_add_time` datetime DEFAULT NULL,
  `finish_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_mesa` (`id_mesa`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `id_mesa`, `id_button`, `order_add_time`, `finish_time`) VALUES
(1, 1, 1, NULL, NULL),
(2, 2, 1, NULL, NULL),
(3, 1, 2, NULL, NULL),
(4, 1, 2, NULL, NULL),
(5, 1, 3, NULL, NULL),
(6, 1, 23, '2020-04-22 10:10:30', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
CREATE TABLE IF NOT EXISTS `pedidos` (
  `id_pedido` int(11) NOT NULL AUTO_INCREMENT,
  `id_botao` int(11) DEFAULT NULL,
  `id_posto` int(11) DEFAULT NULL,
  `qtd` int(11) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `time` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_pedido`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pedidos`
--

INSERT INTO `pedidos` (`id_pedido`, `id_botao`, `id_posto`, `qtd`, `status`, `time`) VALUES
(1, 1, 2, 0, NULL, NULL),
(2, 1, 2, 0, '9', NULL),
(3, 1, 2, 0, '1', NULL),
(4, 1, 2, 0, '1', NULL),
(5, 1, 2, 0, '1', NULL),
(6, 1, 3, 0, '0', NULL),
(7, 2, 2, 0, '1', NULL),
(8, 2, 2, 0, '1', NULL),
(9, 2, 2, 0, '1', NULL),
(10, 2, 2, 0, '1', NULL),
(11, 2, 2, 0, '1', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `servicos`
--

DROP TABLE IF EXISTS `servicos`;
CREATE TABLE IF NOT EXISTS `servicos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `servicos`
--

INSERT INTO `servicos` (`id`, `name`, `description`) VALUES
(1, 'Geral', 'Serviço geral'),
(2, 'Vinho', 'O sommelier é o profissional responsável por cuidar da carta de bebidas de restaurantes, bares, importadoras e lojas especializadas'),
(3, 'Pagamento', 'Serviço de gerente'),
(4, 'Carta', 'Apresentação da carta');

-- --------------------------------------------------------

--
-- Table structure for table `sub_tipo_artigos`
--

DROP TABLE IF EXISTS `sub_tipo_artigos`;
CREATE TABLE IF NOT EXISTS `sub_tipo_artigos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_tipo_artigo` int(11) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_tipo_artigo` (`id_tipo_artigo`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sub_tipo_artigos`
--

INSERT INTO `sub_tipo_artigos` (`id`, `id_tipo_artigo`, `name`) VALUES
(1, 1, 'Coca-cola'),
(2, 1, 'Ice-Tea'),
(3, 2, 'TEste');

-- --------------------------------------------------------

--
-- Table structure for table `terminais_empregados`
--

DROP TABLE IF EXISTS `terminais_empregados`;
CREATE TABLE IF NOT EXISTS `terminais_empregados` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `terminais_empregados`
--

INSERT INTO `terminais_empregados` (`id`, `name`) VALUES
(1, 'Terminal 1'),
(2, 'Terminal 2'),
(3, 'Terminal 3'),
(4, 'Terminal 4'),
(5, 'Terminal 5'),
(6, 'Terminal 6'),
(7, 'Terminal 7'),
(8, 'Terminal 8');

-- --------------------------------------------------------

--
-- Table structure for table `tipo_artigos`
--

DROP TABLE IF EXISTS `tipo_artigos`;
CREATE TABLE IF NOT EXISTS `tipo_artigos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tipo_artigos`
--

INSERT INTO `tipo_artigos` (`id`, `name`) VALUES
(1, 'Teste'),
(2, 'Cafetaria'),
(3, 'Vinhos'),
(4, 'Refrigerantes');

-- --------------------------------------------------------

--
-- Table structure for table `tipo_caracteristicas`
--

DROP TABLE IF EXISTS `tipo_caracteristicas`;
CREATE TABLE IF NOT EXISTS `tipo_caracteristicas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tipo_caracteristicas`
--

INSERT INTO `tipo_caracteristicas` (`id`, `name`) VALUES
(1, 'Escolha Unica'),
(2, 'Multiplos atributos');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(64) DEFAULT NULL,
  `username` varchar(64) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `password_hash` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_users_email` (`email`),
  UNIQUE KEY `ix_users_username` (`username`),
  KEY `role_id` (`role_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `username`, `role_id`, `password_hash`) VALUES
(1, 'diogosantosecastro@gmail.com', 'Diogo', NULL, 'pbkdf2:sha256:150000$syu2bYMT$7701c6980b023effde7e22a73c0fe3220acf508bf508301eb03b180a270e52e3'),
(2, 'teste@tes.com', 'diiogggq', NULL, 'pbkdf2:sha256:150000$inr9Avxe$4d405a130bafbb88996b712cec08a9f0d07c287ffc44b7c3662aba28302cfebe'),
(3, 'tessssss@asdas.com', 'eeeeee', NULL, 'pbkdf2:sha256:150000$VISaPH2c$14027c0666bf85a93678becaf5622349858d0a732eeb3c4e3bcce22ea56ac3eb'),
(4, 'teste@teste.com', 'Teste', NULL, 'pbkdf2:sha256:150000$oLeJ22O3$12909fb0856736760a8a9a95f33a64cabf9a726ab5da069974642b3d376c0010'),
(5, 'afonso@gmail.com', 'Afonso', NULL, 'pbkdf2:sha256:150000$IA5Ez8yX$2e6456e46d5e2b007c75a2a993b11b83ef2d3a1ce77a22c178b488eb6f95293c');
--
-- Database: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
