CREATE SCHEMA IF NOT EXISTS `loja_aplicativos` DEFAULT CHARACTER
SET utf8 ;
USE `loja_aplicativos`;

-- -----------------------------------------------------
-- Tabela `marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `marca` (
  `idMarca` INT(11) NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idMarca`));


-- -----------------------------------------------------
-- Tabela `modelo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modelo` (
  `idModelo` INT(11) NOT NULL AUTO_INCREMENT,
  `idMarca` INT(11) NOT NULL,
  `modelo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idModelo`),
  INDEX `fk_modelo_marca1_idx` (`idMarca` ASC),
  CONSTRAINT `fk_modelo_marca1`
    FOREIGN KEY (`idMarca`)
    REFERENCES `marca` (`idMarca`));


-- -----------------------------------------------------
-- Tabela `usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `usuario` (
  `idUsuario` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(60) NOT NULL,
  `login` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE INDEX `login_UNIQUE` (`login` ASC));


-- -----------------------------------------------------
-- Tabela `aparelho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aparelho` (
  `idAparelho` INT(11) NOT NULL AUTO_INCREMENT,
  `idModelo` INT(11) NOT NULL,
  `idUsuario` INT(11) NOT NULL,
  `apelido` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAparelho`),
  INDEX `fk_aparelho_modelo1_idx` (`idModelo` ASC),
  INDEX `fk_aparelho_usuario1_idx` (`idUsuario` ASC),
  CONSTRAINT `fk_aparelho_modelo1`
    FOREIGN KEY (`idModelo`)
    REFERENCES `modelo` (`idModelo`),
  CONSTRAINT `fk_aparelho_usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `usuario` (`idUsuario`));


-- -----------------------------------------------------
-- Tabela `categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `categoria` (
  `idCategoria` INT NOT NULL AUTO_INCREMENT,
  `categoria` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`idCategoria`));


-- -----------------------------------------------------
-- Tabela `aplicativo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aplicativo` (
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
    REFERENCES `usuario` (`idUsuario`),
  CONSTRAINT `fk_aplicativo_categoria1`
    FOREIGN KEY (`idCategoria`)
    REFERENCES `categoria` (`idCategoria`));


-- -----------------------------------------------------
-- Tabela `comentario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comentario` (
  `idComentario` INT(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` INT(11) NOT NULL,
  `idAplicativo` INT(11) NOT NULL,
  `comentario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idComentario`),
  INDEX `fk_comentario_usuario1_idx` (`idUsuario` ASC),
  INDEX `fk_comentario_aplicativo1_idx` (`idAplicativo` ASC),
  CONSTRAINT `fk_comentario_aplicativo1`
    FOREIGN KEY (`idAplicativo`)
    REFERENCES `aplicativo` (`idAplicativo`),
  CONSTRAINT `fk_comentario_usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `usuario` (`idUsuario`));


-- -----------------------------------------------------
-- Tabela `compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `compra` (
  `idCompra` INT(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` INT(11) NOT NULL,
  `idAplicativo` INT(11) NOT NULL,
  `preco` DOUBLE NULL,
  `dataHoraCompra` DATETIME NULL,
  `compraFinalizada` TINYINT(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idCompra`),
  INDEX `fk_usuario_has_aplicativo_aplicativo1_idx` (`idAplicativo` ASC),
  INDEX `fk_usuario_has_aplicativo_usuario1_idx` (`idUsuario` ASC),
  CONSTRAINT `fk_usuario_has_aplicativo_aplicativo1`
    FOREIGN KEY (`idAplicativo`)
    REFERENCES `aplicativo` (`idAplicativo`),
  CONSTRAINT `fk_usuario_has_aplicativo_usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `usuario` (`idUsuario`));


-- -----------------------------------------------------
-- Tabela `login`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `login` (
  `idLogin` INT(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` INT(11) NOT NULL,
  `dataHora` DATETIME NOT NULL,
  PRIMARY KEY (`idLogin`),
  INDEX `fk_login_usuario1_idx` (`idUsuario` ASC),
  CONSTRAINT `fk_login_usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `usuario` (`idUsuario`));


-- -----------------------------------------------------
-- Tabela `qualificacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `qualificacao` (
  `idAplicativo` INT(11) NOT NULL,
  `idUsuario` INT(11) NOT NULL,
  `qualificacao` INT(11) NOT NULL,
  PRIMARY KEY (`idAplicativo`, `idUsuario`),
  INDEX `fk_qualificacao_aplicativo_idx` (`idAplicativo` ASC),
  INDEX `fk_qualificacao_usuario1_idx` (`idUsuario` ASC),
  CONSTRAINT `fk_qualificacao_aplicativo`
    FOREIGN KEY (`idAplicativo`)
    REFERENCES `aplicativo` (`idAplicativo`),
  CONSTRAINT `fk_qualificacao_usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `usuario` (`idUsuario`));

-- -----------------------------------------------------
-- View `vwCarrinho`
-- -----------------------------------------------------
CREATE  OR REPLACE VIEW `vwCarrinho` AS
SELECT
  `U`.`idUsuario` AS `idUsuario`,
  `U`.`nome` AS `usuario`,
  `A`.`nome` AS `aplicativo`,
  `A`.`preco` AS `preco`
FROM ((`usuario` `U`
JOIN `compra` `C`
ON((`U`.`idUsuario` = `C`.`idUsuario`)))
JOIN `aplicativo` `A`
ON((`C`.`idAplicativo` = `A`.`idAplicativo`)))
WHERE (`C`.`compraFinalizada` = FALSE);

-- -----------------------------------------------------
-- View `vwAplicativosUsuario`
-- -----------------------------------------------------
CREATE  OR REPLACE VIEW `vwAplicativosUsuario` AS
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
-- View `vwAplicativosSimples`
-- -----------------------------------------------------
CREATE  OR REPLACE VIEW `vwAplicativosSimples` AS
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
FROM (`aplicativo` `A`
  JOIN `usuario` `U`
  ON `A`.`idDesenvolvedor` = `U`.`idUsuario`
    JOIN `categoria` `C`
    ON `A`.`idCategoria` = `C`.`idCategoria`
);

-- -----------------------------------------------------
-- procedure procAlteraPrecoCarrinho
-- -----------------------------------------------------

DELIMITER $$
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

DELIMITER $$
CREATE DEFINER = CURRENT_USER TRIGGER `tgAlteraPrecoCarrinho` AFTER UPDATE ON `aplicativo` FOR EACH ROW
BEGIN
	IF(OLD.preco != NEW.preco OR OLD.desconto != NEW.desconto) THEN
    CALL procAlteraPrecoCarrinho(OLD.idAplicativo, NEW.preco, NEW.desconto);
  END IF;
END$$

CREATE DEFINER = CURRENT_USER TRIGGER `tgInsertPrecoCarrinho` BEFORE INSERT ON `compra` FOR EACH ROW
BEGIN
	DECLARE varPreco int;
	SET NEW.preco = funcInsertPrecoCarrinho(NEW.idAplicativo);
END$$

CREATE DEFINER = CURRENT_USER TRIGGER `tgIncrementaQtdDownloads` AFTER UPDATE ON `compra` FOR EACH ROW
BEGIN
  IF(OLD.compraFinalizada = false AND NEW.compraFinalizada = true) THEN
    CALL procIncrementaQtdDownloads(NEW.idAplicativo);
  END IF;
END$$

CREATE
DEFINER=`root`@`localhost`
TRIGGER `tgIncrementaQtdQualificacoes`
AFTER INSERT ON `qualificacao`
FOR EACH ROW
BEGIN
  CALL procIncrementaQtdQualificacoes(NEW.idAplicativo, NEW.qualificacao);
END$$


DELIMITER ;

-- -----------------------------------------------------
-- Dados para tabela `marca`
-- -----------------------------------------------------
INSERT INTO `marca` (`idMarca`, `marca`)
VALUES (1, 'Samsung');
INSERT INTO `marca` (`idMarca`, `marca`)
VALUES (2, 'Sony');
INSERT INTO `marca` (`idMarca`, `marca`)
VALUES (3, 'Asus');

-- -----------------------------------------------------
-- Dados para tabela `modelo`
-- -----------------------------------------------------
INSERT INTO `modelo` (`idModelo`, `idMarca`, `modelo`)
VALUES (1, 1, 'Galaxy S7');
INSERT INTO `modelo` (`idModelo`, `idMarca`, `modelo`)
VALUES (2, 1, 'Galaxy J5');
INSERT INTO `modelo` (`idModelo`, `idMarca`, `modelo`)
VALUES (3, 1, 'Galaxy Tab 10.1');

-- -----------------------------------------------------
-- Dados para tabela `usuario`
-- -----------------------------------------------------
INSERT INTO `usuario` (`idUsuario`, `nome`, `login`, `senha`)
VALUES (1, 'Victor', 'victor', '202cb962ac59075b964b07152d234b70');
INSERT INTO `usuario` (`idUsuario`, `nome`, `login`, `senha`)
VALUES (2, 'Eduardo', 'eduardo', '202cb962ac59075b964b07152d234b70');
INSERT INTO `usuario` (`idUsuario`, `nome`, `login`, `senha`)
VALUES (3, 'Aldo', 'aldo', '202cb962ac59075b964b07152d234b70');

-- -----------------------------------------------------
-- Dados para tabela `aparelho`
-- -----------------------------------------------------
INSERT INTO `aparelho` (`idAparelho`, `idModelo`, `idUsuario`, `apelido`)
VALUES (1, 1, 1, 'S7 Victor');
INSERT INTO `aparelho` (`idAparelho`, `idModelo`, `idUsuario`, `apelido`)
VALUES (2, 2, 2, 'Celular Eduardo');
INSERT INTO `aparelho` (`idAparelho`, `idModelo`, `idUsuario`, `apelido`)
VALUES (3, 3, 2, 'Tablet Eduardo');

-- -----------------------------------------------------
-- Dados para tabela `categoria`
-- -----------------------------------------------------
INSERT INTO `categoria` (`idCategoria`, `categoria`)
VALUES (1, 'Jogos');
INSERT INTO `categoria` (`idCategoria`, `categoria`)
VALUES (2, 'Educativos');
INSERT INTO `categoria` (`idCategoria`, `categoria`)
VALUES (3, 'Kids');

-- -----------------------------------------------------
-- Dados para tabela `aplicativo`
-- -----------------------------------------------------
INSERT INTO `aplicativo` (`idAplicativo`, `idDesenvolvedor`, `idCategoria`, `nome`, `descricao`, `qualificacao`, `qtdDownloads`, `qtdQualificacoes`, `preco`, `desconto`, `dataHora`)
VALUES (1, 3, 1, 'Angry Birds', 'Jogo de Aventura', 5, 0, 1, 1.99, 0.4, CURRENT_TIMESTAMP);
INSERT INTO `aplicativo` (`idAplicativo`, `idDesenvolvedor`, `idCategoria`, `nome`, `descricao`, `qualificacao`, `qtdDownloads`, `qtdQualificacoes`, `preco`, `desconto`, `dataHora`)
VALUES (2, 3, 1, 'Plants vs Zombies', 'Jogo de Estratégia', 4.5, 0, 2, 1.49, 0, CURRENT_TIMESTAMP);
INSERT INTO `aplicativo` (`idAplicativo`, `idDesenvolvedor`, `idCategoria`, `nome`, `descricao`, `qualificacao`, `qtdDownloads`, `qtdQualificacoes`, `preco`, `desconto`, `dataHora`)
VALUES (3, 1, 2, 'Calculadora', 'Calculadora Simples', 0, 0, 0, 0.99, 0, CURRENT_TIMESTAMP);

-- -----------------------------------------------------
-- Dados para tabela `comentario`
-- -----------------------------------------------------
INSERT INTO `comentario` (`idComentario`, `idUsuario`, `idAplicativo`, `comentario`)
VALUES (1, 1, 1, 'Muito bom esse jogo.');
INSERT INTO `comentario` (`idComentario`, `idUsuario`, `idAplicativo`, `comentario`)
VALUES (2, 2, 1, 'Muito legal, porém enjoativo.');
INSERT INTO `comentario` (`idComentario`, `idUsuario`, `idAplicativo`, `comentario`)
VALUES (3, 2, 2, 'Sensacional. Passei horas jogando!');

-- -----------------------------------------------------
-- Dados para tabela `compra`
-- -----------------------------------------------------
INSERT INTO `compra` (`idCompra`, `idUsuario`, `idAplicativo`, `preco`, `dataHoraCompra`, `compraFinalizada`)
VALUES (1, 1, 2, 1.49, CURRENT_TIMESTAMP, true);
INSERT INTO `compra` (`idCompra`, `idUsuario`, `idAplicativo`, `preco`, `dataHoraCompra`, `compraFinalizada`)
VALUES (2, 2, 1, 1.99, CURRENT_TIMESTAMP, true);
INSERT INTO `compra` (`idCompra`, `idUsuario`, `idAplicativo`, `preco`, `dataHoraCompra`, `compraFinalizada`)
VALUES (3, 2, 2, 1.49, CURRENT_TIMESTAMP, true);

-- -----------------------------------------------------
-- Dados para tabela `qualificacao`
-- -----------------------------------------------------
INSERT INTO `qualificacao` (`idAplicativo`, `idUsuario`, `qualificacao`)
VALUES (2, 1, 5);
INSERT INTO `qualificacao` (`idAplicativo`, `idUsuario`, `qualificacao`)
VALUES (2, 2, 4);
INSERT INTO `qualificacao` (`idAplicativo`, `idUsuario`, `qualificacao`)
VALUES (1, 2, 5);

-- -----------------------------------------------------
-- SELECTs
-- -----------------------------------------------------
SELECT A.nome AS aplicativo, A.descricao, TRUNCATE(A.preco - A.desconto, 2) AS precoFinal, U.nome as desenvolvedor, C.categoria
FROM aplicativo AS A
JOIN categoria AS C
ON A.idCategoria = C.idCategoria
JOIN usuario AS U
ON A.idDesenvolvedor = U.idUsuario;

SELECT A.nome AS aplicativo, A.descricao, A.preco, A.desconto
FROM aplicativo AS A
JOIN categoria AS C
ON A.idCategoria = C.idCategoria
WHERE C.categoria LIKE '%jogo%';

SELECT C.comentario, U.nome as usuario
FROM aplicativo AS A
JOIN comentario AS C
ON A.idAplicativo = C.idAplicativo
JOIN usuario as U
ON C.idUsuario = U.idUsuario
WHERE A.idAplicativo = 1;

SELECT U.nome AS usuario, A.nome AS aplicativo
FROM usuario AS U
LEFT JOIN compra AS C
ON U.idUsuario = C.idUsuario
LEFT JOIN aplicativo as A
ON C.idAplicativo = A.idAplicativo
WHERE U.idUsuario = 3;

SELECT Q.qualificacao, A.nome AS aplicativo
FROM qualificacao AS Q
RIGHT JOIN aplicativo AS A
ON A.idAplicativo = Q.idAplicativo;

SELECT COUNT(*) AS qtdComentarios, A.nome AS aplicativo
FROM aplicativo AS A
JOIN comentario AS C
ON A.idAplicativo = C.idAplicativo
GROUP BY A.idAplicativo;

SELECT TRUNCATE(AVG(Q.qualificacao), 2) as mediaQualificacao, A.nome AS aplicativo
FROM aplicativo AS A
JOIN qualificacao AS Q
ON A.idAplicativo = Q.idAplicativo
GROUP BY A.idAplicativo
ORDER BY mediaQualificacao DESC;

SELECT A.qualificacao AS mediaQualificacao, A.nome AS aplicativo
FROM aplicativo AS A
HAVING mediaQualificacao >= 4
ORDER BY aplicativo ASC;

-- -----------------------------------------------------
-- ALTER TABLE usuario
-- -----------------------------------------------------
ALTER TABLE usuario ADD email VARCHAR (100) NOT NULL;

-- -----------------------------------------------------
-- INSERTs
-- -----------------------------------------------------
INSERT INTO usuario (idUsuario, nome, login, senha, email)
VALUES
(4, 'João Batista', 'joao', '202cb962ac59075b964b07152d234b71', 'jaobat@gmail.com');

INSERT INTO categoria (idCategoria, categoria)
VALUES
(4, 'Financeiros'),
(5, 'Conversores'),
(6, 'Bancários');

INSERT INTO marca (idMarca, marca)
VALUES
(4, 'LG'),
(5, 'Motorola'),
(6, 'BLU');

-- -----------------------------------------------------
-- UPDATEs
-- -----------------------------------------------------
UPDATE usuario
SET nome = 'Victor Hugo'
WHERE idUsuario = 1;

UPDATE usuario
SET nome = 'Eduardo Mendes'
WHERE idUsuario = 2;

UPDATE usuario
SET nome = 'Aldo Henrique'
WHERE idUsuario = 3;

UPDATE usuario
SET email = 'victorlobo69@gmail.com'
WHERE idUsuario = 1;

UPDATE usuario
SET email = 'eduxmaster@gmail.com'
WHERE idUsuario = 2;

UPDATE usuario
SET email = 'aldohenrico@gmail.com'
WHERE idUsuario = 3;

UPDATE `aplicativo`
SET `desconto`='0.5'
WHERE `idAplicativo`='2';

UPDATE compra
SET preco = (
  SELECT preco - desconto
    FROM aplicativo
    WHERE idAplicativo = 2
)
WHERE compraFinalizada = FALSE;

-- -----------------------------------------------------
-- DELETEs
-- -----------------------------------------------------
DELETE
FROM compra
WHERE idUsuario = 2
AND idAplicativo = 2;

DELETE
FROM compra
WHERE idUsuario = 1
AND compraFinalizada = FALSE;

DELETE
FROM usuario
WHERE idUsuario = 4;

DELETE
FROM categoria
WHERE idCategoria NOT IN(
  SELECT idCategoria
  FROM aplicativo
  GROUP BY idCategoria
);

SELECT * FROM aplicativo;

/*Criação do BLOB*/

CREATE TABLE IF NOT EXISTS imagens_app(
id_image int auto_increment not null,
idAplicativo int not null,
nome varchar (30),
tipo varchar (20),
dados longblob,
primary key (id_image),
foreign key (idAplicativo) references aplicativo(idAplicativo)
);

INSERT INTO imagens_app (idAplicativo, nome, tipo, dados)
VALUES
	(1, 'Angry Birds', 'imagem png', load_file("C:\Users\Eduardo Mendes\Desktop\LojaDeAplicativosWebBD-master-b7e930808cef5584216602a2491df416e3925d0b\AngryBirdsiOS.png")),
	(2, 'Plants vs Zombies', 'imagem png', load_file("C:\Users\Eduardo Mendes\Desktop\LojaDeAplicativosWebBD-master-b7e930808cef5584216602a2491df416e3925d0b\PlantsndZombies.png")),
	(3, 'Calculadora Simples', 'imgagem png', load_file("C:\Users\Eduardo Mendes\Desktop\LojaDeAplicativosWebBD-master-b7e930808cef5584216602a2491df416e3925d0b\Calculadora Simples.png"));

SELECT A.*, IA.nome, IA.tipo, IA.dados
FROM imagens_app AS IA
JOIN aplicativo AS A
ON IA.idAplicativo = A.idAplicativo;

/*Criação de Índices*/
/*Índice criado para que possa ser consultado como estão as qualificações de cada aplicativo*/

CREATE INDEX idx_app_consulta_qualificacao ON 
aplicativo (nome, qualificacao, qtdQualificacoes);

/*Índice criado para que possa ser consultado como estão as compras finalizadas de cada aplicativo*/

CREATE INDEX idx_compra_finalizada ON 
compra (idAplicativo, preco, dataHoraCompra,compraFinalizada);

/*Índice criado para que possa ser consultado a quantidade de downloads de cada aplicativo*/

CREATE INDEX idx_app_qtdDownloads ON 
aplicativo (nome, qtdDownloads);