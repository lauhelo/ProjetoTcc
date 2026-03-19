-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.32-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para entrelacos
DROP DATABASE IF EXISTS `entrelacos`;
CREATE DATABASE IF NOT EXISTS `entrelacos` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin */;
USE `entrelacos`;

-- Copiando estrutura para tabela entrelacos.animais
DROP TABLE IF EXISTS `animais`;
CREATE TABLE IF NOT EXISTS `animais` (
  `id_animal` int(11) NOT NULL AUTO_INCREMENT,
  `id_ong` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `especie` varchar(50) NOT NULL,
  `raca` varchar(100) DEFAULT NULL,
  `porte` varchar(20) NOT NULL,
  `idade` int(11) NOT NULL,
  `sexo` varchar(10) NOT NULL,
  `descricao` text NOT NULL,
  `status` varchar(20) NOT NULL,
  `imagem` varchar(255) DEFAULT NULL,
  `ong` varchar(150) NOT NULL,
  `cidade` varchar(100) NOT NULL,
  `estado` char(2) NOT NULL,
  PRIMARY KEY (`id_animal`),
  KEY `fk_animais_ong` (`id_ong`),
  CONSTRAINT `fk_animais_ong` FOREIGN KEY (`id_ong`) REFERENCES `ong` (`id_ong`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Copiando dados para a tabela entrelacos.animais: ~0 rows (aproximadamente)
DELETE FROM `animais`;

-- Copiando estrutura para tabela entrelacos.cadastro
DROP TABLE IF EXISTS `cadastro`;
CREATE TABLE IF NOT EXISTS `cadastro` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `email` varchar(50) NOT NULL,
  `cep` varchar(100) NOT NULL,
  `cpf` varchar(20) NOT NULL,
  `telefone` varchar(20) NOT NULL,
  `data_nascimento` date NOT NULL,
  `senha` varchar(100) NOT NULL,
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Copiando dados para a tabela entrelacos.cadastro: ~2 rows (aproximadamente)
DELETE FROM `cadastro`;
INSERT INTO `cadastro` (`id_usuario`, `nome`, `email`, `cep`, `cpf`, `telefone`, `data_nascimento`, `senha`) VALUES
	(5, 'Laura', 'la@gmail.com', '1111111', '1111111111', '(11) 11111111', '1111-11-11', 'fCUjyYWIH7LCtM++kX6xLExLYeiYrU5xYM/KSHyjxPM='),
	(6, 'Pietro', 'arianagrande@gmail.com', '000000', '00000000000', '(00) 000000000', '0000-00-00', 'lO3yjG1to4/TXXrVPkhTB/ifvq8SBIXI0XpD8yPe7nE=');

-- Copiando estrutura para tabela entrelacos.dicas
DROP TABLE IF EXISTS `dicas`;
CREATE TABLE IF NOT EXISTS `dicas` (
  `id_dica` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `titulo` varchar(150) NOT NULL,
  `conteudo` text NOT NULL,
  `categoria` varchar(50) NOT NULL,
  `imagem` varchar(256) DEFAULT NULL,
  `data_publicacao` date NOT NULL,
  PRIMARY KEY (`id_dica`),
  KEY `fk_dicas_usuario` (`id_usuario`),
  CONSTRAINT `fk_dicas_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `cadastro` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Copiando dados para a tabela entrelacos.dicas: ~0 rows (aproximadamente)
DELETE FROM `dicas`;

-- Copiando estrutura para tabela entrelacos.doacao
DROP TABLE IF EXISTS `doacao`;
CREATE TABLE IF NOT EXISTS `doacao` (
  `id_doacao` int(11) NOT NULL AUTO_INCREMENT,
  `id_ong` int(11) NOT NULL,
  `tipo_doacao` varchar(50) NOT NULL,
  `descricao` text NOT NULL,
  `data_cadastro` date NOT NULL,
  PRIMARY KEY (`id_doacao`),
  KEY `fk_doacao_ong` (`id_ong`),
  CONSTRAINT `fk_doacao_ong` FOREIGN KEY (`id_ong`) REFERENCES `ong` (`id_ong`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Copiando dados para a tabela entrelacos.doacao: ~0 rows (aproximadamente)
DELETE FROM `doacao`;

-- Copiando estrutura para tabela entrelacos.login
DROP TABLE IF EXISTS `login`;
CREATE TABLE IF NOT EXISTS `login` (
  `id_login` int(11) NOT NULL AUTO_INCREMENT,
  `id_cadastro` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `senha` varchar(100) NOT NULL,
  PRIMARY KEY (`id_login`),
  KEY `fk_login_usuario` (`id_cadastro`),
  CONSTRAINT `fk_login_usuario` FOREIGN KEY (`id_cadastro`) REFERENCES `cadastro` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Copiando dados para a tabela entrelacos.login: ~0 rows (aproximadamente)
DELETE FROM `login`;

-- Copiando estrutura para tabela entrelacos.ong
DROP TABLE IF EXISTS `ong`;
CREATE TABLE IF NOT EXISTS `ong` (
  `id_ong` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL,
  `telefone` varchar(20) NOT NULL,
  `endereco` varchar(200) NOT NULL,
  `cidade` varchar(100) NOT NULL,
  `estado` char(2) NOT NULL,
  `pix` varchar(256) DEFAULT NULL,
  `trabalho_ofe` text NOT NULL,
  PRIMARY KEY (`id_ong`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Copiando dados para a tabela entrelacos.ong: ~0 rows (aproximadamente)
DELETE FROM `ong`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
