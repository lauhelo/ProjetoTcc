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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Copiando dados para a tabela entrelacos.animais: ~4 rows (aproximadamente)
DELETE FROM `animais`;
INSERT INTO `animais` (`id_animal`, `id_ong`, `nome`, `especie`, `raca`, `porte`, `idade`, `sexo`, `descricao`, `status`, `imagem`, `ong`, `cidade`, `estado`) VALUES
	(6, 2, 'Rex', 'Cachorro', 'Vira-lata', 'Médio', 3, 'Macho', 'Muito brincalhão e gosta de crianças', 'Disponível', 'https://exemplo.com/cachorro.jpg', 'Patinhas Felizes', 'Campinas', 'SP'),
	(11, 2, 'Bolinha', 'cachorro', 'Yorkshire', 'Pequeno', 2, 'macho', 'Muito carinhoso e dócil.', 'disponivel', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToAsYS-kBryHXZmYq6Gi6vwKbIMbDJwI8aLSNeSIMAmbqqBaAKnyU9GsyYywVkh3tH-7yKP_WDcCKE05zxBjB8qPyPzCs2gPTLGuYIGQ&s=10', 'ONG Amigos', 'São Paulo', 'SP'),
	(12, 2, 'Juju', 'cachorro', 'Border Colier', 'Grande', 5, 'fêmea', 'Muito carinhosa e dócil.', 'disponivel', 'https://saude.abril.com.br/wp-content/uploads/2018/12/cachorro.jpg?quality=50&strip=info&w=414&h=280&crop=1', 'ONG Amigos', 'São Paulo', 'SP'),
	(15, 2, 'Luna', 'cachorro', 'Poodle', 'pequeno', 2, 'fêmea', 'Carinhosa e tranquila', 'disponivel', 'https://premierpet.com.br/wp-content/uploads/2025/03/model-banner-poodle-mobile-v1-1024x1024.png', 'Amigos dos Animais', 'Campinas', 'SP');

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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Copiando dados para a tabela entrelacos.cadastro: ~24 rows (aproximadamente)
DELETE FROM `cadastro`;
INSERT INTO `cadastro` (`id_usuario`, `nome`, `email`, `cep`, `cpf`, `telefone`, `data_nascimento`, `senha`) VALUES
	(5, 'Laura', 'la@gmail.com', '1111111', '1111111111', '(11) 11111111', '1111-11-11', 'fCUjyYWIH7LCtM++kX6xLExLYeiYrU5xYM/KSHyjxPM='),
	(6, 'Pietro', 'arianagrande@gmail.com', '000000', '00000000000', '(00) 000000000', '0000-00-00', 'lO3yjG1to4/TXXrVPkhTB/ifvq8SBIXI0XpD8yPe7nE='),
	(8, 'Laura Heloisa Cleveston', 'laura.cleveston@aluno.senai.br', 'fff', 'fff', 'ffff', '6666-06-06', 'FeKw08M4keuw8e9gnsQZQgwg4yDOlMZfvIwzEkSOsiU='),
	(9, 'laura', '123456@gmail.com', '123456', '123456', '123456', '4566-03-12', 'jZae727K08KaOmKSgOaGzww/XVqGr/PKEgIMkjrcbJI='),
	(11, 'Lorena Caroline', 'Lo@gmail.com', 'rua 123', '49210071875', '18000000000', '0000-00-00', 'jZae727K08KaOmKSgOaGzww/XVqGr/PKEgIMkjrcbJI='),
	(12, 'laura', 'as@gmail.com', '1212121121212', '121.212.1212-12', '(12) 12212-1212', '1212-12-12', 'jZae727K08KaOmKSgOaGzww/XVqGr/PKEgIMkjrcbJI='),
	(13, 'dddddd', 'd@gmail.com', 'ddd', '444', '(44) 44444-44', '0000-00-00', 'efBvj94zNGFznyIAkKI8sqefbXFL7hANDktK8kkpRhk='),
	(14, 'Lorena Caroline ', 'Lo@gmail.com.br', '18027493', '789.456.123-54', '(19) 88374-56452', '0000-00-00', 'i7DPbrmxfQ99IrRW8SElfcElTh8BZlNwR2OD6ndt9BQ='),
	(15, 'laura', 'laura@gmail.com', '196548729', '198.754.897-97', '(64) 58787-9545', '0909-04-11', 'FeKw08M4keuw8e9gnsQZQgwg4yDOlMZfvIwzEkSOsiU='),
	(16, 'dd', 'd@gmail.com', '123456789', '123.456.789-98', '(12) 34567-899898', '9090-04-11', 'jZae727K08KaOmKSgOaGzww/XVqGr/PKEgIMkjrcbJI='),
	(17, 'laura heloisa cleveston', 'laura@gmail.com', '1234456789', '123.456.789-03', '(18) 94010-0000', '0001-01-01', 'FeKw08M4keuw8e9gnsQZQgwg4yDOlMZfvIwzEkSOsiU='),
	(18, 'lau', 'la@gmail.com', 'erererer', '232.323.231-23', '(22) 22222-2222', '2222-02-22', 'jZae727K08KaOmKSgOaGzww/XVqGr/PKEgIMkjrcbJI='),
	(19, 'lau', 'lau@gmail.com', 'erererer', '232.323.231-23', '(22) 22222-2222', '2222-02-22', 'jZae727K08KaOmKSgOaGzww/XVqGr/PKEgIMkjrcbJI='),
	(20, 'lau', 'laur@gmail.com', 'erererer', '232.323.231-23', '(22) 22222-2222', '2222-02-22', 'jZae727K08KaOmKSgOaGzww/XVqGr/PKEgIMkjrcbJI='),
	(21, 'lau', 'laur@gmail.com', 'erererer', '232.323.231-23', '(22) 22222-2222', '2222-02-22', 'jZae727K08KaOmKSgOaGzww/XVqGr/PKEgIMkjrcbJI='),
	(22, 'laura', 'aa@gmail.com', '12345678998', '123.456.789-00', '(01) 12345-6789', '3004-02-01', 'jZae727K08KaOmKSgOaGzww/XVqGr/PKEgIMkjrcbJI='),
	(23, 'ddd', 'dd@gmail.com', '1222222', '888.888.8', '(88) 88', '0888-08-08', 'jZae727K08KaOmKSgOaGzww/XVqGr/PKEgIMkjrcbJI='),
	(24, 'ee', 'a@gmail.com', '151515151515', '151.515.1515-15', '(15) 15151-5155', '1111-11-11', 'jZae727K08KaOmKSgOaGzww/XVqGr/PKEgIMkjrcbJI='),
	(25, 'cc', 'cc@gmail.comm', 'rrrr', '444.444.444', '(44) 4', '4444-04-04', 'jZae727K08KaOmKSgOaGzww/XVqGr/PKEgIMkjrcbJI='),
	(26, 'ff', 'ff@gmail.com', '444444', '444.444.444-4', '(44) 44', '4444-04-04', 'jZae727K08KaOmKSgOaGzww/XVqGr/PKEgIMkjrcbJI='),
	(27, 'ffd', 'dd@gmail.com', '45454545454545', '454.554.545-45', '(45) 45454-54545', '5454-04-05', 'jZae727K08KaOmKSgOaGzww/XVqGr/PKEgIMkjrcbJI='),
	(28, 'fff', 'fff@gmail.com', 'sss', '333.33', '(33) 333', '0333-03-31', 'jZae727K08KaOmKSgOaGzww/XVqGr/PKEgIMkjrcbJI='),
	(29, 'tt', 'tt@gmail.com', '545454545', '545.454.545-45', '(12) 34567-8998', '5555-05-11', 'jZae727K08KaOmKSgOaGzww/XVqGr/PKEgIMkjrcbJI='),
	(30, 'laura', 'laura@gmail.com', '12345678998', '123.456.789-98', '(12) 34567-8998', '4567-03-12', 'jZae727K08KaOmKSgOaGzww/XVqGr/PKEgIMkjrcbJI=');

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

-- Copiando dados para a tabela entrelacos.eventos: ~1 rows (aproximadamente)
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

-- Copiando dados para a tabela entrelacos.necessidades: ~1 rows (aproximadamente)
DELETE FROM `necessidades`;
INSERT INTO `necessidades` (`id_necessidade`, `id_animal`, `nome`, `categoria`, `grau_importancia`, `descricao`, `botao`) VALUES
	(3, 6, 'Cirurgia urgente', 'Saúde', 'Alta', 'Animal precisa de cirurgia', 'Ajudar agora');

-- Copiando estrutura para tabela entrelacos.ong
CREATE TABLE IF NOT EXISTS `ong` (
  `id_ong` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL,
  `telefone` varchar(20) NOT NULL,
  `endereco` varchar(200) NOT NULL,
  `cnpj` varchar(50) NOT NULL,
  `cidade` varchar(100) NOT NULL,
  `estado` char(2) NOT NULL,
  `pix` varchar(256) DEFAULT NULL,
  `trabalho_ofe` text NOT NULL,
  PRIMARY KEY (`id_ong`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Copiando dados para a tabela entrelacos.ong: ~23 rows (aproximadamente)
DELETE FROM `ong`;
INSERT INTO `ong` (`id_ong`, `nome`, `telefone`, `endereco`, `cnpj`, `cidade`, `estado`, `pix`, `trabalho_ofe`) VALUES
	(2, 'Patinhas Felizes Atualizada', '11977776666', 'Av. Brasil, 999', '0', 'Campinas', 'SP', 'novo@pix.com', 'Resgate, vacinação e adoção responsável'),
	(3, 'Amigos de Quatro Patas', '83987654321', 'Rua das Flores, 120', '0', 'João Pessoa', 'PB', 'amigos4patas@pix.com', 'Resgate, reabilitação e adoção de animais'),
	(4, 'Projeto Vida Animal', '11988887777', 'Av. Central, 450', '0', 'São Paulo', 'SP', 'vidaanimal@pix.com', 'Adoção responsável e campanhas de castração'),
	(5, 'patinhas da fernandinha', '18996547235', 'ru 1111', '0', 'sao paulo', 'SP', '000000000', 'dz,mfnbglakjshglksjdhlkajsfhdgljkhkc'),
	(6, 'ONG Patinhas', '83999999999', 'Rua A, 123', '12.345.678/0001-90', 'João Pessoa', 'PB', 'patinhas@pix.com', 'Resgate de animais'),
	(7, 'ONG Feliz', '00000000009', 'Rua A, 1023', '0000000000000000', 'Cuiabá', 'MT', 'patinhas@pix.com', 'Resgate de animais'),
	(8, 'lalalalaoalaal', '44444444444', '4444444444', '4444444', '444', '44', '444444', '44444444444444'),
	(9, 'ddd', 'dd', 'dd', 'dd', 'dd', 'dd', 'dd', 'dd'),
	(10, 'dd', 'dd', 'dd', 'dd', 'dd', 'dd', 'dd', 'dd'),
	(11, 'gg', 'gg', 'gg', 'gg', 'gg', 'gg', 'gg', 'gg'),
	(12, 'ee', 'ee', 'ee', 'ee', 'ee', 'ee', 'ee', 'ee'),
	(13, 'eee', 'eee', 'eee', 'eee', 'eee', 'ee', 'eee', 'eee'),
	(14, 'ttt', 'ttt', 'ttt', 'ttt', 'ttt', 'tt', 'ttt', 'ttt'),
	(15, 'ggg', 'gg', 'gg', 'gg', 'gg', 'gg', 'gg', 'gg'),
	(16, 'ff', 'ff', 'ff', 'ff', 'ff', 'ff', 'ff', 'ff'),
	(17, 'ff', 'ff', 'ff', 'ff', 'ff', 'ff', 'ff', 'ff'),
	(18, 'hh', 'hh', 'hh', 'hh', 'hh', 'hh', 'hh', 'hh'),
	(19, 'hh', 'hh', 'hh', 'hh', 'hh', 'hh', 'hh', 'hh'),
	(20, '123456789', '123456789', '123456789', '123456789', '123456789', '12', '1345689', '12345689'),
	(21, 'cccc', 'ccccccccccccccc', 'ccccccccccccccccc', 'ccccccccccc', 'ccccccccccccc', 'cc', 'ccccccccccccccc', 'cccccccccccccccccccccccccccccc'),
	(22, 'ff', 'ff', 'ff', 'ff', 'ff', 'ff', 'ff', 'fffffffff'),
	(23, 'ff', 'ff', 'ff', 'ff', 'fffffffffffffffffffffffffffffffffff', 'ff', 'ffffffffffffffffffffffff', 'fffffffffffffffffffffffffffffffffffffffffffffffffffffffff'),
	(24, 'hhh', 'hhhhhhhhhh', 'hhhhhhhhhhhhhhh', 'hh', 'hhhhhhhhhhhhhh', 'hh', 'hhhhhhhhhhhhhhh', 'hhhhhhhhhhhhhhhhhhhhhhhhhhh');

-- Copiando estrutura para tabela entrelacos.recusenha
CREATE TABLE IF NOT EXISTS `recusenha` (
  `id_recu` int(11) NOT NULL,
  `email` int(11) DEFAULT NULL,
  `senha` int(11) DEFAULT NULL,
  `confirmar_senha` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_recu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Copiando dados para a tabela entrelacos.recusenha: ~0 rows (aproximadamente)
DELETE FROM `recusenha`;

-- Copiando estrutura para tabela entrelacos.usuario_ong
CREATE TABLE IF NOT EXISTS `usuario_ong` (
  `id_usuario` int(11) NOT NULL,
  `id_ong` int(11) NOT NULL,
  PRIMARY KEY (`id_usuario`,`id_ong`),
  KEY `fk_ong` (`id_ong`),
  CONSTRAINT `fk_ong` FOREIGN KEY (`id_ong`) REFERENCES `ong` (`id_ong`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `cadastro` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Copiando dados para a tabela entrelacos.usuario_ong: ~21 rows (aproximadamente)
DELETE FROM `usuario_ong`;
INSERT INTO `usuario_ong` (`id_usuario`, `id_ong`) VALUES
	(5, 2),
	(8, 5),
	(8, 6),
	(8, 7),
	(9, 8),
	(23, 9),
	(24, 10),
	(24, 11),
	(25, 12),
	(26, 13),
	(27, 14),
	(27, 15),
	(29, 16),
	(29, 17),
	(29, 18),
	(29, 19),
	(30, 20),
	(30, 21),
	(30, 22),
	(30, 23),
	(30, 24);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
