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
CREATE DATABASE IF NOT EXISTS `entrelacos` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin */;
USE `entrelacos`;

-- Copiando estrutura para tabela entrelacos.animais
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Copiando dados para a tabela entrelacos.animais: ~1 rows (aproximadamente)
DELETE FROM `animais`;
INSERT INTO `animais` (`id_animal`, `id_ong`, `nome`, `especie`, `raca`, `porte`, `idade`, `sexo`, `descricao`, `status`, `imagem`, `ong`, `cidade`, `estado`) VALUES
	(6, 2, 'Rex', 'Cachorro', 'Vira-lata', 'Médio', 3, 'Macho', 'Muito brincalhão e gosta de crianças', 'Disponível', 'https://exemplo.com/cachorro.jpg', 'Patinhas Felizes', 'Campinas', 'SP');

-- Copiando estrutura para tabela entrelacos.cadastro
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Copiando dados para a tabela entrelacos.cadastro: ~3 rows (aproximadamente)
DELETE FROM `cadastro`;
INSERT INTO `cadastro` (`id_usuario`, `nome`, `email`, `cep`, `cpf`, `telefone`, `data_nascimento`, `senha`) VALUES
	(5, 'Laura', 'la@gmail.com', '1111111', '1111111111', '(11) 11111111', '1111-11-11', 'fCUjyYWIH7LCtM++kX6xLExLYeiYrU5xYM/KSHyjxPM='),
	(6, 'Pietro', 'arianagrande@gmail.com', '000000', '00000000000', '(00) 000000000', '0000-00-00', 'lO3yjG1to4/TXXrVPkhTB/ifvq8SBIXI0XpD8yPe7nE='),
	(7, 'Laura Heloisa Cleveston', 'laura.cleveston@aluno.senai.br', 'rua 123', '9595959595', '18000000000', '0001-01-11', 'lq4wq6dTKjMm8jndFH3MFzp+wgWJQ3EFZqX/Ca76KIw=');

-- Copiando estrutura para tabela entrelacos.dicas
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Copiando dados para a tabela entrelacos.dicas: ~1 rows (aproximadamente)
DELETE FROM `dicas`;
INSERT INTO `dicas` (`id_dica`, `id_usuario`, `titulo`, `conteudo`, `categoria`, `imagem`, `data_publicacao`) VALUES
	(2, 6, 'Cuidados atualizados', 'Mais informações', 'Saúde', 'nova.jpg', '2026-03-19');

-- Copiando estrutura para tabela entrelacos.doacao
CREATE TABLE IF NOT EXISTS `doacao` (
  `id_doacao` int(11) NOT NULL AUTO_INCREMENT,
  `id_ong` int(11) NOT NULL,
  `tipo_doacao` varchar(50) NOT NULL,
  `descricao` text NOT NULL,
  `data_cadastro` date NOT NULL,
  PRIMARY KEY (`id_doacao`),
  KEY `fk_doacao_ong` (`id_ong`),
  CONSTRAINT `fk_doacao_ong` FOREIGN KEY (`id_ong`) REFERENCES `ong` (`id_ong`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Copiando dados para a tabela entrelacos.doacao: ~1 rows (aproximadamente)
DELETE FROM `doacao`;
INSERT INTO `doacao` (`id_doacao`, `id_ong`, `tipo_doacao`, `descricao`, `data_cadastro`) VALUES
	(1, 2, 'Dinheiro', 'R$200', '2026-03-19');

-- Copiando estrutura para tabela entrelacos.eventos
CREATE TABLE IF NOT EXISTS `eventos` (
  `id_evento` int(11) NOT NULL AUTO_INCREMENT,
  `id_ong` int(11) DEFAULT NULL,
  `nome_evento` varchar(100) DEFAULT NULL,
  `hora` varchar(20) DEFAULT NULL,
  `data` date DEFAULT NULL,
  `endereco` varchar(150) DEFAULT NULL,
  `categoria` varchar(100) DEFAULT NULL,
  `localizacao` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id_evento`),
  KEY `id_ong` (`id_ong`),
  CONSTRAINT `eventos_ibfk_1` FOREIGN KEY (`id_ong`) REFERENCES `ong` (`id_ong`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Copiando dados para a tabela entrelacos.eventos: ~2 rows (aproximadamente)
DELETE FROM `eventos`;
INSERT INTO `eventos` (`id_evento`, `id_ong`, `nome_evento`, `hora`, `data`, `endereco`, `categoria`, `localizacao`) VALUES
	(4, 2, 'Feira atualizada', '14:00', '2026-05-10', 'Parque novo', 'Adoção', 'São Paulo');

-- Copiando estrutura para tabela entrelacos.login
CREATE TABLE IF NOT EXISTS `login` (
  `id_login` int(11) NOT NULL AUTO_INCREMENT,
  `id_cadastro` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `senha` varchar(100) NOT NULL,
  PRIMARY KEY (`id_login`),
  KEY `fk_login_usuario` (`id_cadastro`),
  CONSTRAINT `fk_login_usuario` FOREIGN KEY (`id_cadastro`) REFERENCES `cadastro` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Copiando dados para a tabela entrelacos.login: ~1 rows (aproximadamente)
DELETE FROM `login`;
INSERT INTO `login` (`id_login`, `id_cadastro`, `email`, `senha`) VALUES
	(2, 5, 'novo@email.com', 'SB9swFERQ8zdfi0bG5T68KcAqLSc0Tkipwta4orKqMU=');

-- Copiando estrutura para tabela entrelacos.necessidades
CREATE TABLE IF NOT EXISTS `necessidades` (
  `id_necessidade` int(11) NOT NULL AUTO_INCREMENT,
  `id_animal` int(11) DEFAULT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `categoria` varchar(100) DEFAULT NULL,
  `grau_importancia` varchar(50) DEFAULT NULL,
  `descricao` text DEFAULT NULL,
  `botao` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_necessidade`),
  KEY `id_animal` (`id_animal`),
  CONSTRAINT `necessidades_ibfk_1` FOREIGN KEY (`id_animal`) REFERENCES `animais` (`id_animal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Copiando dados para a tabela entrelacos.necessidades: ~2 rows (aproximadamente)
DELETE FROM `necessidades`;
INSERT INTO `necessidades` (`id_necessidade`, `id_animal`, `nome`, `categoria`, `grau_importancia`, `descricao`, `botao`) VALUES
	(3, 6, 'Cirurgia urgente', 'Saúde', 'Alta', 'Animal precisa de cirurgia', 'Ajudar agora');

-- Copiando estrutura para tabela entrelacos.ong
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Copiando dados para a tabela entrelacos.ong: ~1 rows (aproximadamente)
DELETE FROM `ong`;
INSERT INTO `ong` (`id_ong`, `nome`, `telefone`, `endereco`, `cidade`, `estado`, `pix`, `trabalho_ofe`) VALUES
	(2, 'Patinhas Felizes Atualizada', '11977776666', 'Av. Brasil, 999', 'Campinas', 'SP', 'novo@pix.com', 'Resgate, vacinação e adoção responsável');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
