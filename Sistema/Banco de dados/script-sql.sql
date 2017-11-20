-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema loja_aplicativos
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema loja_aplicativos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `loja_aplicativos` DEFAULT CHARACTER SET utf8 ;
USE `loja_aplicativos` ;

-- -----------------------------------------------------
-- Table `loja_aplicativos`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja_aplicativos`.`usuario` (
  `idUsuario` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(60) NOT NULL,
  `login` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE INDEX `login_UNIQUE` (`login` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `loja_aplicativos`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja_aplicativos`.`categoria` (
  `idCategoria` INT NOT NULL AUTO_INCREMENT,
  `categoria` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `loja_aplicativos`.`aplicativo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja_aplicativos`.`aplicativo` (
  `idAplicativo` INT(11) NOT NULL AUTO_INCREMENT,
  `idDesenvolvedor` INT(11) NOT NULL,
  `idCategoria` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `descricao` LONGTEXT NOT NULL,
  `qualificacao` DOUBLE NOT NULL DEFAULT '0',
  `qtdDownloads` INT(11) NOT NULL DEFAULT '0',
  `qtdQualificacoes` INT(11) NOT NULL DEFAULT '0',
  `preco` DOUBLE NOT NULL,
  `desconto` DOUBLE NOT NULL DEFAULT '0',
  `dataHora` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de desenvolvimento do app',
  PRIMARY KEY (`idAplicativo`),
  INDEX `fk_aplicativo_desenvolvedor1_idx` (`idDesenvolvedor` ASC),
  INDEX `fk_aplicativo_categoria1_idx` (`idCategoria` ASC),
  CONSTRAINT `fk_aplicativo_desenvolvedor1`
    FOREIGN KEY (`idDesenvolvedor`)
    REFERENCES `loja_aplicativos`.`usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_aplicativo_categoria1`
    FOREIGN KEY (`idCategoria`)
    REFERENCES `loja_aplicativos`.`categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `loja_aplicativos`.`compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja_aplicativos`.`compra` (
  `idCompra` INT(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` INT(11) NOT NULL,
  `idAplicativo` INT(11) NOT NULL,
  `dataHoraCompra` DATETIME NULL,
  `compraFinalizada` TINYINT(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idCompra`),
  INDEX `fk_usuario_has_aplicativo_aplicativo1_idx` (`idAplicativo` ASC),
  INDEX `fk_usuario_has_aplicativo_usuario1_idx` (`idUsuario` ASC),
  CONSTRAINT `fk_usuario_has_aplicativo_aplicativo1`
    FOREIGN KEY (`idAplicativo`)
    REFERENCES `loja_aplicativos`.`aplicativo` (`idAplicativo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_has_aplicativo_usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `loja_aplicativos`.`usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

USE `loja_aplicativos` ;

-- -----------------------------------------------------
-- Placeholder table for view `loja_aplicativos`.`vwCarrinho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja_aplicativos`.`vwCarrinho` (`idUsuario` INT, `usuario` INT, `aplicativo` INT, `preco` INT);

-- -----------------------------------------------------
-- Placeholder table for view `loja_aplicativos`.`vwAplicativosUsuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja_aplicativos`.`vwAplicativosUsuario` (`idUsuario` INT, `idAplicativo` INT, `aplicativo` INT);

-- -----------------------------------------------------
-- Placeholder table for view `loja_aplicativos`.`vwAplicativosSimples`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja_aplicativos`.`vwAplicativosSimples` (`idAplicativo` INT, `aplicativo` INT, `qualificacao` INT, `qtdQualificacoes` INT, `qtdDownloads` INT, `preco` INT, `desconto` INT, `desenvolvedor` INT, `categoria` INT);

-- -----------------------------------------------------
-- procedure procAlteraPrecoCarrinho
-- -----------------------------------------------------

DELIMITER $$
USE `loja_aplicativos`$$
CREATE PROCEDURE procAlteraPrecoCarrinho (
  IN varIdAplicativo INT,
  IN varPreco double,
  IN varDesconto double
)
BEGIN
    UPDATE compra
  SET preco = varPreco - varDesconto
  WHERE idAplicativo = varIdAplicativo
    AND compraFinalizada = FALSE;
END;$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure procIncrementaQtdQualificacoes
-- -----------------------------------------------------

DELIMITER $$
USE `loja_aplicativos`$$
CREATE PROCEDURE procIncrementaQtdQualificacoes (IN varIdAplicativo INT, IN varQualificacao INT)
BEGIN
  DECLARE varMediaQualificacao double;
  DECLARE varQtdQualificacoes int;
  DECLARE varQualificacaoTotal int;
    
    SELECT qualificacao, qtdQualificacoes
    INTO varMediaQualificacao, varQtdQualificacoes
    FROM aplicativo
    WHERE idAplicativo = varIdAplicativo;
    
    SET varQualificacaoTotal = (varMediaQualificacao * varQtdQualificacoes) + varQualificacao;
    SET varQtdQualificacoes = varQtdQualificacoes + 1;
    SET varMediaQualificacao = varQualificacaoTotal / varQtdQualificacoes;
    
  UPDATE aplicativo
    SET qtdQualificacoes = varQtdQualificacoes,
    qualificacao = varMediaQualificacao
    WHERE idAplicativo = varIdAplicativo;
END;$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure procIncrementaQtdDownloads
-- -----------------------------------------------------

DELIMITER $$
USE `loja_aplicativos`$$
CREATE PROCEDURE procIncrementaQtdDownloads (IN varIdAplicativo INT)
BEGIN
  DECLARE varQtdDownloads int;
    
    SELECT qtdDownloads
    INTO varQtdDownloads
    FROM aplicativo
    WHERE idAplicativo = varIdAplicativo;
    
    SET varQtdDownloads = varQtdDownloads + 1;
    
  UPDATE aplicativo
    SET qtdDownloads = varQtdDownloads
    WHERE idAplicativo = varIdAplicativo;
END;$$

DELIMITER ;

-- -----------------------------------------------------
-- function funcInsertPrecoCarrinho
-- -----------------------------------------------------

DELIMITER $$
USE `loja_aplicativos`$$
CREATE FUNCTION funcInsertPrecoCarrinho(varIdAplicativo INT)
RETURNS DOUBLE
BEGIN
  RETURN (
    SELECT TRUNCATE(preco - desconto, 2)
    FROM aplicativo
    WHERE idAplicativo = varIdAplicativo
    );
END;$$

DELIMITER ;

-- -----------------------------------------------------
-- View `loja_aplicativos`.`vwCarrinho`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `loja_aplicativos`.`vwCarrinho`;
USE `loja_aplicativos`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `loja_aplicativos`.`vwCarrinho` AS
SELECT
  `U`.`idUsuario` AS `idUsuario`,
  `U`.`nome` AS `usuario`,
  `A`.`nome` AS `aplicativo`,
  `A`.`preco` AS `preco`
FROM ((`loja_aplicativos`.`usuario` `U`
JOIN `loja_aplicativos`.`compra` `C`
ON((`U`.`idUsuario` = `C`.`idUsuario`)))
JOIN `loja_aplicativos`.`aplicativo` `A`
ON((`C`.`idAplicativo` = `A`.`idAplicativo`)))
WHERE (`C`.`compraFinalizada` = FALSE);

-- -----------------------------------------------------
-- View `loja_aplicativos`.`vwAplicativosUsuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `loja_aplicativos`.`vwAplicativosUsuario`;
USE `loja_aplicativos`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `loja_aplicativos`.`vwAplicativosUsuario` AS
SELECT
  `U`.`idUsuario` AS `idUsuario`,
  `A`.`idAplicativo`,
  `A`.`nome` AS `aplicativo`
FROM `usuario` AS `U`
JOIN `compra` AS `C`
ON `U`.`idUsuario` = `C`.`idUsuario`
JOIN `aplicativo` AS `A`
ON `C`.`idAplicativo` = `A`.`idAplicativo`
WHERE `C`.`compraFinalizada` = TRUE;

-- -----------------------------------------------------
-- View `loja_aplicativos`.`vwAplicativosSimples`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `loja_aplicativos`.`vwAplicativosSimples`;
USE `loja_aplicativos`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `loja_aplicativos`.`vwAplicativosSimples` AS
SELECT
  `A`.`idAplicativo` AS `idAplicativo`,
  `A`.`nome` AS `aplicativo`,
  `A`.`qualificacao` AS `qualificacao`,
  `A`.`qtdQualificacoes` AS `qtdQualificacoes`,
  `A`.`qtdDownloads` AS `qtdDownloads`,
  `A`.`preco`,
  `A`.`desconto`,
  `U`.`nome` AS `desenvolvedor`,
  `C`.`categoria`
FROM (`loja_aplicativos`.`aplicativo` `A`
  JOIN `loja_aplicativos`.`usuario` `U`
  ON `A`.`idDesenvolvedor` = `U`.`idUsuario`
    JOIN `loja_aplicativos`.`categoria` `C`
    ON `A`.`idCategoria` = `C`.`idCategoria`
);
USE `loja_aplicativos`;

DELIMITER $$
USE `loja_aplicativos`$$
CREATE DEFINER = CURRENT_USER TRIGGER `loja_aplicativos`.`tgIncrementaQtdDownloads` AFTER UPDATE ON `compra` FOR EACH ROW
BEGIN
  IF(OLD.compraFinalizada = false AND NEW.compraFinalizada = true) THEN
    CALL procIncrementaQtdDownloads(NEW.idAplicativo);
  END IF;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `loja_aplicativos`.`usuario`
-- -----------------------------------------------------
START TRANSACTION;
USE `loja_aplicativos`;
INSERT INTO `loja_aplicativos`.`usuario` (`idUsuario`, `nome`, `login`, `senha`) VALUES (1, 'Victor', 'victor', '202cb962ac59075b964b07152d234b70');
INSERT INTO `loja_aplicativos`.`usuario` (`idUsuario`, `nome`, `login`, `senha`) VALUES (2, 'Eduardo', 'eduardo', '202cb962ac59075b964b07152d234b70');
INSERT INTO `loja_aplicativos`.`usuario` (`idUsuario`, `nome`, `login`, `senha`) VALUES (3, 'Aldo', 'aldo', '202cb962ac59075b964b07152d234b70');

COMMIT;


-- -----------------------------------------------------
-- Data for table `loja_aplicativos`.`categoria`
-- -----------------------------------------------------
START TRANSACTION;
USE `loja_aplicativos`;
INSERT INTO `loja_aplicativos`.`categoria` (`idCategoria`, `categoria`) VALUES (1, 'Jogos');
INSERT INTO `loja_aplicativos`.`categoria` (`idCategoria`, `categoria`) VALUES (2, 'Educativos');
INSERT INTO `loja_aplicativos`.`categoria` (`idCategoria`, `categoria`) VALUES (3, 'Kids');

COMMIT;


-- -----------------------------------------------------
-- Data for table `loja_aplicativos`.`aplicativo`
-- -----------------------------------------------------
START TRANSACTION;
USE `loja_aplicativos`;
INSERT INTO `loja_aplicativos`.`aplicativo` (`idAplicativo`, `idDesenvolvedor`, `idCategoria`, `nome`, `descricao`, `qualificacao`, `qtdDownloads`, `qtdQualificacoes`, `preco`, `desconto`, `dataHora`) VALUES (1, 3, 1, 'Angry Birds', 'Jogo de Aventura', 5, 0, 1, 1.99, 0.4, CURRENT_TIMESTAMP);
INSERT INTO `loja_aplicativos`.`aplicativo` (`idAplicativo`, `idDesenvolvedor`, `idCategoria`, `nome`, `descricao`, `qualificacao`, `qtdDownloads`, `qtdQualificacoes`, `preco`, `desconto`, `dataHora`) VALUES (2, 3, 1, 'Plants vs Zombies', 'Jogo de Estratégia', 4.5, 0, 2, 1.49, 0, CURRENT_TIMESTAMP);
INSERT INTO `loja_aplicativos`.`aplicativo` (`idAplicativo`, `idDesenvolvedor`, `idCategoria`, `nome`, `descricao`, `qualificacao`, `qtdDownloads`, `qtdQualificacoes`, `preco`, `desconto`, `dataHora`) VALUES (3, 1, 2, 'Calculadora', 'Calculadora Simples', 0, 0, 0, 0.99, 0, CURRENT_TIMESTAMP);

COMMIT;


-- -----------------------------------------------------
-- Data for table `loja_aplicativos`.`compra`
-- -----------------------------------------------------
START TRANSACTION;
USE `loja_aplicativos`;
INSERT INTO `loja_aplicativos`.`compra` (`idCompra`, `idUsuario`, `idAplicativo`, `dataHoraCompra`, `compraFinalizada`) VALUES (1, 1, 2, CURRENT_TIMESTAMP, true);
INSERT INTO `loja_aplicativos`.`compra` (`idCompra`, `idUsuario`, `idAplicativo`, `dataHoraCompra`, `compraFinalizada`) VALUES (2, 2, 1, CURRENT_TIMESTAMP, true);
INSERT INTO `loja_aplicativos`.`compra` (`idCompra`, `idUsuario`, `idAplicativo`, `dataHoraCompra`, `compraFinalizada`) VALUES (3, 2, 2, CURRENT_TIMESTAMP, true);

COMMIT;