﻿CREATE DATABASE ATIVIDADE_ESTUDO_DE_CASO_BD_II;

--SEXO = {CODSEXO, NOMESEXO}
CREATE TABLE SEXO(
    COD_SEXO SERIAL PRIMARY KEY,
    NOME_SEXO VARCHAR(9) NOT NULL UNIQUE 
);

--RUA = {CODRUA, NOMERUA}
CREATE TABLE RUA(
    COD_RUA SERIAL PRIMARY KEY,
    NOME_RUA VARCHAR(80) NOT NULL UNIQUE
);

--BAIRRO = {CODBAIRRO, NOMEBAIRRO}
CREATE TABLE BAIRRO(
    COD_BAIRRO SERIAL PRIMARY KEY,
    NOME_BAIRRO VARCHAR(80) NOT NULL UNIQUE
);

--CEP = {CODCEP, NUMEROCEP}
CREATE TABLE CEP(
    COD_CEP SERIAL PRIMARY KEY,
    NOME_CEP CHAR(9) NOT NULL UNIQUE
);

--CIDADE = {COD_CIDADE, NOME_CIDADE, COD_UF_FK}
CREATE TABLE CIDADE(
    COD_CIDADE SERIAL PRIMARY KEY,
    NOME_CIDADE VARCHAR(80) NOT NULL UNIQUE
);
---ADCIONE UMA COLUNA CHAMADA COD_UF_FK COMO CHAVE ESTRANGEIRA

ALTER TABLE CIDADE ADD
COLUMN COD_UF_FK INTEGER REFERENCES UF(COD_UF)
	MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE;
	
SELECT * FROM CIDADE;


--UF = {COD_UF, NOME_UF, SIGLA}
CREATE TABLE UF(
    COD_UF SERIAL PRIMARY KEY,
    NOME_UF VARCHAR(80) NOT NULL UNIQUE,
    SIGLA CHAR(2) NOT NULL UNIQUE
);

--TRABALHO = {COD_TRABALHO, NOME_TRABALHO}
CREATE TABLE TRABALHO(
    COD_TRABALHO SERIAL PRIMARY KEY,
    NOME_TRABALHO VARCHAR(80) NOT NULL UNIQUE
);

--OPERADORA = {CODPERADORA, NOMEOPERADORA}
Create table OPERADORA(
COD_OPERADORA SERIAL PRIMARY KEY,
NOME_OPERADORA VARCHAR(80) NOT NULL UNIQUE
);
--
--
--TELEFONE = {COD_TELEFONE, NUMERO, COD_OPERADORA_FK}
CREATE TABLE TELEFONE(
    COD_TELEFONE SERIAL PRIMARY KEY,
    NUMERO VARCHAR(15) NOT NULL UNIQUE,

    COD_OPERADORA_FK INTEGER REFERENCES OPERADORA(COD_OPERADORA)
    MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE
);
-- ALTER TABLE <NOME TABELA> ALTER COLUMN TIPO;
-- ALTERAR O TIPO DE UMA COLUNA
ALTER TABLE TELEFONE
ALTER COLUMN NUMERO 
TYPE VARCHAR(19);

--
--CLIENTE = {COD_CLIENTE, NOME_CLIENTE, FOTO_CLIENTE,
--           DATANASC_CLIENTE, COD_SEXO_FK, COD_RUA_FK,
--           COD_BAIRRO_FK, COD_CEP_FK, COD_CIDADE_FK,
--           COD_TRABALHO_FK, SALARIO_CLIENTE, NUMEROCASA}
CREATE TABLE CLIENTE(
    COD_CLIENTE SERIAL PRIMARY KEY,
    NOME_CLIENTE VARCHAR(80) NOT NULL,
    FOTO_CLIENTE BYTEA,
    DATANASC_CLIENTE DATE,

    COD_SEXO_FK INTEGER REFERENCES SEXO(COD_SEXO)
    MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
    COD_RUA_FK INTEGER REFERENCES RUA(COD_RUA)
    MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
    COD_BAIRRO_FK INTEGER REFERENCES BAIRRO(COD_BAIRRO)
    MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
    COD_CEP_FK INTEGER REFERENCES CEP(COD_CEP)
    MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
    COD_CIDADE_FK INTEGER REFERENCES CIDADE(COD_CIDADE)
    MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
    COD_TRABALHO_FK INTEGER REFERENCES TRABALHO(COD_TRABALHO)
    MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,

    SALARIO_CLIENTE NUMERIC(10,2) NOT NULL,
    NUMEROCASA VARCHAR(16) NOT NULL
);



--ITENS_TEL_CLI = {COD_TELEFONE_FK, COD_CLIENTE_FK}
CREATE TABLE ITENS_TEL_CLI(
COD_TELEFONE_FK INTEGER REFERENCES TELEFONE(COD_TELEFONE)
MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
COD_CLIENTE_FK INTEGER REFERENCES CLIENTE(COD_CLIENTE)
MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,

PRIMARY KEY(COD_TELEFONE_FK, COD_CLIENTE_FK)
);

--ALTER TABLE ITENS_TEL_CLI
--ALTER COLUMN PRIMAR KEY
--SET SERIAL

--ITENS_TEL_TRA = {COD_TRABALHO_FK, COD_TELEFONE_FK}
CREATE TABLE ITENS_TEL_TRA(
COD_TRABALHO_FK INTEGER REFERENCES TRABALHO(COD_TRABALHO)
MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
COD_TELEFONE_FK INTEGER REFERENCES TELEFONE(COD_TELEFONE)
MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,

PRIMARY KEY(COD_TRABALHO_FK, COD_TELEFONE_FK)
);

--FUNCAO = {COD_FUNCAO, NOME_FUNCAO}
CREATE TABLE FUNCAO(
    COD_FUNCAO SERIAL PRIMARY KEY,
    NOME_FUNCAO VARCHAR(80) NOT NULL UNIQUE
);

--LOJA = {COD_LOJA, NOME_LOJA, CNPJ, NOME_FANTASIA, RAZAOSOCIAL}
CREATE TABLE LOJA(
    COD_LOJA SERIAL PRIMARY KEY,
    NOME_LOJA VARCHAR(80) NOT NULL UNIQUE,
    CNPJ VARCHAR(80) NOT NULL UNIQUE,
    NOME_FANTASIA VARCHAR(80) NOT NULL UNIQUE,
    RAZAOSOCIAL VARCHAR(80) NOT NULL UNIQUE
);
--
--FUNCIONARIOS = {COD_FUNCIONARIO, NOME_FUNCIONARIO, NUMEROCASA,
--COD_RUA_FK, COD_BAIRRO_FK, COD_CEP_FK, COD_CIDADE_FK, COD_FUNCAO_FK,
-- SALARIO, COD_LOJA_FK}
CREATE TABLE FUNCIONARIOS(
    COD_FUNCIONARIO SERIAL PRIMARY KEY,
    NOME_FUNCIONARIO VARCHAR(80) NOT NULL,
    NUMEROCASA VARCHAR(9) NOT NULL,

    COD_RUA_FK INTEGER REFERENCES RUA(COD_RUA)
    MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
    COD_BAIRRO_FK INTEGER REFERENCES BAIRRO(COD_BAIRRO)
    MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
    COD_CEP_FK INTEGER REFERENCES CEP(COD_CEP)
    MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
    COD_CIDADE_FK INTEGER REFERENCES CIDADE(COD_CIDADE)
    MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
    COD_FUNCAO_FK INTEGER REFERENCES FUNCAO(COD_FUNCAO)
    MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
    COD_LOJA_FK INTEGER REFERENCES LOJA(COD_LOJA)
    MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,

    SALARIO NUMERIC(10,2) NOT NULL
);

-- ITENS_TEL_FUN = {COD_FUNCIONARIO_FK, COD_TELEFONE_FK}
CREATE TABLE ITENS_TEL_FUN(
    COD_FUNCIONARIO_FK INTEGER REFERENCES FUNCIONARIOS(COD_FUNCIONARIO)
    MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
    COD_TELEFONE_FK INTEGER REFERENCES TELEFONE(COD_TELEFONE)
    MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,

    PRIMARY KEY(COD_FUNCIONARIO_FK, COD_TELEFONE_FK)
);

--LOGIN = {COD_LOGIN, USUARIO, SENHA, COD_FUNCIONARIO_FK}
CREATE TABLE LOGINS(
    COD_LOGINS SERIAL PRIMARY KEY,
    USUARIO VARCHAR(80) NOT NULL UNIQUE,
    SENHA VARCHAR(80) NOT NULL UNIQUE,

    COD_FUNCIONARIO_FK INTEGER REFERENCES FUNCIONARIOS(COD_FUNCIONARIO)
    MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE
);

-- CONTROLE_LOGSISTEMA = {COD_CONTROLE, COD_LOGINS_FK, DATA, HORA}
CREATE TABLE CONTROLE_LOGSISTEMA(
    COD_CONTROLE SERIAL PRIMARY KEY,
    
    COD_LOGINS_FK INTEGER REFERENCES LOGINS(COD_LOGINS)
    MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,

    DATAS DATE NOT NULL,
    HORA TIME NOT NULL
);

--ACESSO = {COD_ACESSO, NOME_ACESSO}
CREATE TABLE ACESSO(
    COD_ACESSO SERIAL PRIMARY KEY,
    NOME_ACESSO VARCHAR(80) NOT NULL UNIQUE
);

--ITENS_ACESSOLOGIN = {COD_ACESSO_FK, COD_LOGIN_FK}
CREATE TABLE ITENS_ACESSOLOGIN(
    COD_ACESSO_FK INTEGER REFERENCES ACESSO(COD_ACESSO)
    MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
    COD_LOGIN_FK INTEGER REFERENCES LOGINS(COD_LOGINS)
    MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,

    PRIMARY KEY(COD_ACESSO_FK, COD_LOGIN_FK)
);

--ITENS_TEL_LOJA={COD_LOJA_FK, COD_TELEFONE_FK}
CREATE TABLE ITENS_TEL_LOJA(
    COD_LOJA_FK INTEGER REFERENCES LOJA(COD_LOJA)
    MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
    COD_TELEFONE_FK INTEGER REFERENCES TELEFONE(COD_TELEFONE)
    MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,

    PRIMARY KEY(COD_LOJA_FK, COD_TELEFONE_FK)
);

-- MARCA={COD_MARCA, NOME_MARCA}
CREATE TABLE MARCA(
    COD_MARCA SERIAL PRIMARY KEY,
    NOME_MARCA VARCHAR(80) NOT NULL UNIQUE
);

-- TIPO={COD_TIPO, NOME_TIPO}
CREATE TABLE TIPO(
    COD_TIPO SERIAL PRIMARY KEY,
    NOME_TIPO VARCHAR(80) NOT NULL UNIQUE
);

--PRODUTO = {COD_PRODUTO, NOME_PRODUTO, QUANTIDADE, 
--VALOR, COD_MARCA_FK, COD_TIPO_FK}
CREATE TABLE PRODUTO(
    COD_PRODUTO SERIAL PRIMARY KEY,
    NOME_PRODUTO VARCHAR(80) NOT NULL,
    QUANTIDADE NUMERIC(10) NOT NULL,
    VALOR NUMERIC(10, 2) NOT NULL,
    
    COD_MARCA_FK INTEGER REFERENCES MARCA(COD_MARCA)
    MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE, 
    COD_TIPO_FK INTEGER REFERENCES TIPO(COD_TIPO)
    MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE
);

--FORNECEDOR={COD_FORNECEDOR, NOME_FORNECEDOR, NUMEROCASA, COD_RUA_FK, 
--COD_BAIRRO_FK, COD_CEP_FK, COD_CIDADE_FK}
CREATE TABLE FORNECEDOR(
    COD_FORNECEDOR SERIAL PRIMARY KEY,
    NOME_FORNECEDOR VARCHAR(80) NOT NULL UNIQUE,
    NUMEROCASA VARCHAR(9) NOT NULL,

    COD_RUA_FK INTEGER REFERENCES RUA(COD_RUA)
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
    COD_BAIRRO_FK INTEGER REFERENCES BAIRRO(COD_BAIRRO)
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
    COD_CEP_FK INTEGER REFERENCES CEP(COD_CEP)
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
    COD_CIDADE_FK INTEGER REFERENCES CIDADE(COD_CIDADE)
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE
);

--ITENS_TEL_FOR={COD_TELEFONE_FK, COD_FORNECEDOR_FK}
CREATE TABLE ITENS_TEL_FOR(
    COD_TELEFONE_FK INTEGER REFERENCES TELEFONE(COD_TELEFONE)
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
    COD_FORNECEDOR_FK INTEGER REFERENCES FORNECEDOR(COD_FORNECEDOR)
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,

    PRIMARY KEY(COD_TELEFONE_FK, COD_FORNECEDOR_FK)
);

--COMPRAPRODUTO = {COD_COMPRA, DATA_COMPRA, COD_FORNECEDOR_FK, 
--COD_FUNCIONARIO_FK}
CREATE TABLE COMPRAPRODUTO(
    COD_COMPRA SERIAL PRIMARY KEY,
    DATA_COMPRA DATE NOT NULL,
    
    COD_FORNECEDOR_FK INTEGER REFERENCES FORNECEDOR(COD_FORNECEDOR)
    MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
    COD_FUNCIONARIO_FK INTEGER REFERENCES FUNCIONARIOS(COD_FUNCIONARIO)
    MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE
);

--ITENS_COMPRA_PRODUTO = {COD_COMPRA_FK, COD_PRODUTO_FK, QUANTIDADE, VALORC}
CREATE TABLE ITENS_COMPRA_PRODUTO(
    COD_COMPRA_FK INTEGER REFERENCES COMPRAPRODUTO(COD_COMPRA)
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
    COD_PRODUTO_FK INTEGER REFERENCES PRODUTO(COD_PRODUTO)
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,

    QUANTIDADE NUMERIC(12) NOT NULL,
    VALOC NUMERIC(10,2) NOT NULL,

    PRIMARY KEY (COD_COMPRA_FK, COD_PRODUTO_FK)
);

--PARCELACOMPRA = {COD_PARCELACOMPRA, DATA_VENCIMENTO, VALOR, 
--COD_SITUACAO, COD_COMPRA}
CREATE TABLE PARCELACOMPRA(
    COD_PARCELACOMPRA SERIAL PRIMARY KEY,
    DATA_VENCIMENTO DATE NOT NULL,
    VALOR NUMERIC(10,2) NOT NULL,

    COD_SITUACAO_FK INTEGER REFERENCES SITUACAO(COD_SITUACAO)
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
    COD_COMPRA_FK INTEGER REFERENCES COMPRAPRODUTO(COD_COMPRA)
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE
);

--SITUACAO = (COD_SITUACAO, NOME_SITUACAO)
CREATE TABLE SITUACAO(
    COD_SITUACAO SERIAL PRIMARY KEY,
    NOME_SITUACAO VARCHAR(80) NOT NULL UNIQUE
);

-- VENDAPRODUTO = {COD_VENDA, DATAVENDA, COD_CLIENTE_FK, COD_FUNCIONARIO_FK}
CREATE TABLE VENDAPRODUTO(
    COD_VENDA SERIAL PRIMARY KEY,
    DATAVENDA DATE NOT NULL,

    COD_CLIENTE_FK INTEGER REFERENCES CLIENTE(COD_CLIENTE) 
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
    COD_FUNCIONARIO_FK INTEGER REFERENCES FUNCIONARIOS(COD_FUNCIONARIO)
     MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE
);

-- ITENS_VENDAPRODUTO = {COD_VENDA_FK,COD_PRODUTO_FK, QUANTIDADE, VALOR}
CREATE TABLE ITENS_VENDAPRODUTO(
    COD_VENDA_FK INTEGER REFERENCES VENDAPRODUTO(COD_VENDA)
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
    COD_PRODUTO_FK INTEGER REFERENCES PRODUTO(COD_PRODUTO)
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,

    QUANTIDADE NUMERIC(12) NOT NULL,
    VALOR NUMERIC(10,2) NOT NULL,

    PRIMARY KEY (COD_VENDA_FK, COD_PRODUTO_FK)
);

-- PAR_CELAVENDA={COD_PARCELA, DATA_VENCIMENTO, VALOR, COD_SITUACAO_FK, COD_VENDA_FK}
CREATE TABLE PAR_CELAVENDA(
    COD_PARCELA SERIAL PRIMARY KEY,
    DATA_VENCIMENTO DATE NOT NULL,
    VALOR NUMERIC(10,2) NOT NULL,

    COD_SITUACAO_FK INTEGER REFERENCES SITUACAO(COD_SITUACAO)
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
    COD_VENDA_FK INTEGER REFERENCES VENDAPRODUTO(COD_VENDA)
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE
);

--  IMAGENS={COD_IMAGENS, IMAGEM, DESCRICAO, COD_PRODUTO_FK}
CREATE TABLE IMAGENS(
    COD_IMAGENS SERIAL PRIMARY KEY,
    IMAGEM BYTEA NOT NULL,
    DESCRICAO VARCHAR(200),

    COD_PRODUTO_FK INTEGER REFERENCES PRODUTO(COD_PRODUTO)
    MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE
);








INSERT INTO SEXO(NOME_SEXO) VALUES('FEMININO');
INSERT INTO SEXO(NOME_SEXO) VALUES('MASCULINO');
SELECT * FROM SEXO;
--   1;"FEMININO"
--   2;"MASCULINO"

INSERT INTO RUA(NOME_RUA) VALUES('RUA UM');
INSERT INTO RUA(NOME_RUA) VALUES('RUA DOIS');
INSERT INTO RUA(NOME_RUA) VALUES('RUA TRÊS');
INSERT INTO RUA(NOME_RUA) VALUES('RUA QUATRO');
INSERT INTO RUA(NOME_RUA) VALUES('RUA CINCO');
SELECT * FROM RUA;
--    1;"RUA UM"
--    2;"RUA DOIS"
--    3;"RUA TRÊS"
--    4;"RUA QUATRO"
--    5;"RUA CINCO"

INSERT INTO BAIRRO(NOME_BAIRRO) VALUES('LIBERDADE');
INSERT INTO BAIRRO(NOME_BAIRRO) VALUES('ITAIM BIBI');
INSERT INTO BAIRRO(NOME_BAIRRO) VALUES('BAIXO AUGUSTA');
INSERT INTO BAIRRO(NOME_BAIRRO) VALUES('CENTRO');
INSERT INTO BAIRRO(NOME_BAIRRO) VALUES('BELA VISTA');
SELECT * FROM BAIRRO;
--    1;"LIBERDADE"
--    2;"ITAIM BIBI"
--    3;"BAIXO AUGUSTA"
--    4;"CENTRO"
--    5;"BELA VISTA"

INSERT INTO CEP(NOME_CEP) VALUES('01010-904');
INSERT INTO CEP(NOME_CEP) VALUES('20031-900');
INSERT INTO CEP(NOME_CEP) VALUES('55641-715');
INSERT INTO CEP(NOME_CEP) VALUES('11608-545');
INSERT INTO CEP(NOME_CEP) VALUES('11325-000');
SELECT * FROM CEP;
--	1;"01010-904"
--	2;"20031-900"
--	3;"55641-715"
--	4;"11608-545"
--	5;"11325-000"

INSERT INTO UF(NOME_UF, SIGLA) VALUES('SÃO PAULO', 'SP');
INSERT INTO UF(NOME_UF, SIGLA) VALUES('RIO DE JANEIRO', 'RJ');
INSERT INTO UF(NOME_UF, SIGLA) VALUES('AMAZONAS', 'AM');
INSERT INTO UF(NOME_UF, SIGLA) VALUES('MATO GROSSO', 'MT');
INSERT INTO UF(NOME_UF, SIGLA) VALUES('BAHIA', 'BA');
SELECT * FROM UF;
--	1;"SÃO PAULO";"SP"
--	2;"RIO DE JANEIRO";"RJ"
--	3;"AMAZONAS";"AM"
--	4;"MATO GROSSO";"MT"
--	5;"BAHIA";"BA"

INSERT INTO CIDADE(NOME_CIDADE, COD_UF_FK) VALUES('SÃO PAULO', 1);
INSERT INTO CIDADE(NOME_CIDADE, COD_UF_FK) VALUES('RIO DE JANEIRO', 2);
INSERT INTO CIDADE(NOME_CIDADE, COD_UF_FK) VALUES('BRASÍLIA', 1);
INSERT INTO CIDADE(NOME_CIDADE, COD_UF_FK) VALUES('CAMPINAS', 1);
INSERT INTO CIDADE(NOME_CIDADE, COD_UF_FK) VALUES('PRAIA GRANDE', 1);
SELECT * FROM CIDADE;
--	1;"SÃO PAULO";1
--	2;"RIO DE JANEIRO";2
--	3;"BRASÍLIA";1
--	4;"CAMPINAS";1
--	5;"PRAIA GRANDE";1

INSERT INTO TRABALHO(NOME_TRABALHO) VALUES('AGRONOMIA');
INSERT INTO TRABALHO(NOME_TRABALHO) VALUES('BIOMEDICINA');
INSERT INTO TRABALHO(NOME_TRABALHO) VALUES('NUTRIÇÃO');
INSERT INTO TRABALHO(NOME_TRABALHO) VALUES('ANÁLISE E DESENVOLVIMENTO DE SISTEMAS');
INSERT INTO TRABALHO(NOME_TRABALHO) VALUES('RECURSOS HUMANOS');
SELECT * FROM TRABALHO;
--	2;"AGRONOMIA"
--	3;"BIOMEDICINA"
--	4;"NUTRIÇÃO"
--	5;"ANÁLISE E DESENVOLVIMENTO DE SISTEMAS"
--	6;"RECURSOS HUMANOS"

INSERT INTO OPERADORA(NOME_OPERADORA) VALUES('VIVO');
INSERT INTO OPERADORA(NOME_OPERADORA) VALUES('CLARO');
INSERT INTO OPERADORA(NOME_OPERADORA) VALUES('TIM');
INSERT INTO OPERADORA(NOME_OPERADORA) VALUES('OI');
INSERT INTO OPERADORA(NOME_OPERADORA) VALUES('ALGAR');
SELECT * FROM OPERADORA;
--	1;"VIVO"
--	2;"CLARO"
--	3;"TIM"
--	4;"OI"
--	5;"ALGAR"

INSERT INTO TELEFONE(NUMERO, COD_OPERADORA_FK) VALUES('+(55) 11 99398-4015', 1);
INSERT INTO TELEFONE(NUMERO, COD_OPERADORA_FK) VALUES('+(55) 12 99398-4015', 2);
INSERT INTO TELEFONE(NUMERO, COD_OPERADORA_FK) VALUES('+(55) 13 99398-4015', 3);
INSERT INTO TELEFONE(NUMERO, COD_OPERADORA_FK) VALUES('+(55) 14 99398-4015', 4);
INSERT INTO TELEFONE(NUMERO, COD_OPERADORA_FK) VALUES('+(55) 17 99398-4015', 5);
SELECT * FROM TELEFONE;
--	1;"+(55) 11 99398-4015";1
--	2;"+(55) 12 99398-4015";2
--	3;"+(55) 13 99398-4015";3
--	4;"+(55) 14 99398-4015";4
--	5;"+(55) 17 99398-4015";5
--
--
--CLIENTE = {COD_CLIENTE, NOME_CLIENTE, FOTO_CLIENTE,
--           DATANASC_CLIENTE, COD_SEXO_FK, COD_RUA_FK,
--           COD_BAIRRO_FK, COD_CEP_FK, COD_CIDADE_FK,
--           COD_TRABALHO_FK, SALARIO_CLIENTE, NUMEROCASA}

INSERT INTO CLIENTE(NOME_CLIENTE, FOTO_CLIENTE, DATANASC_CLIENTE,
		COD_SEXO_FK, COD_RUA_FK,COD_BAIRRO_FK,
		COD_CEP_FK, COD_CIDADE_FK, COD_TRABALHO_FK,
		SALARIO_CLIENTE, NUMEROCASA)
		VALUES
		('MIGUEL',NULL, '01/07/2000',
		 2, 3, 5,
		 3, 1, 5,
		 3000, 01);
		 
---ATUALIZE O SALARIO DO CAMPOS NESTA TABELA;
--UPDATE CLIENTE SET SALARIO_CLIENTE = 3000
--WHERE SALARIO_CLIENTE = 3.00;

--UPDATE CLIENTE SET SALARIO_CLIENTE = 3000
--WHERE COD_TRABALHO_FK = 5;

INSERT INTO CLIENTE(NOME_CLIENTE, FOTO_CLIENTE, DATANASC_CLIENTE,
		COD_SEXO_FK, COD_RUA_FK,COD_BAIRRO_FK,
		COD_CEP_FK, COD_CIDADE_FK, COD_TRABALHO_FK,
		SALARIO_CLIENTE, NUMEROCASA)
		VALUES
		('ARTHUR', NULL, '04/05/2002',
		2, 5, 2,
		1, 1, 4,
		1400, 2);

INSERT INTO CLIENTE(NOME_CLIENTE, FOTO_CLIENTE, DATANASC_CLIENTE,
		COD_SEXO_FK, COD_RUA_FK,COD_BAIRRO_FK,
		COD_CEP_FK, COD_CIDADE_FK, COD_TRABALHO_FK,
		SALARIO_CLIENTE, NUMEROCASA)
		VALUES
		('HEITOR', NULL, '23/10/2003',
		2, 3, 1,
		5, 1, 6,
		1400, 3);

INSERT INTO CLIENTE(NOME_CLIENTE, FOTO_CLIENTE, DATANASC_CLIENTE,
		COD_SEXO_FK, COD_RUA_FK,COD_BAIRRO_FK,
		COD_CEP_FK, COD_CIDADE_FK, COD_TRABALHO_FK,
		SALARIO_CLIENTE, NUMEROCASA)
		VALUES
		('ALICE', NULL, '11/08/2001',
		2, 3, 1,
		5, 5, 5,
		2400, 4);

INSERT INTO CLIENTE(NOME_CLIENTE, FOTO_CLIENTE, DATANASC_CLIENTE,
		COD_SEXO_FK, COD_RUA_FK,COD_BAIRRO_FK,
		COD_CEP_FK, COD_CIDADE_FK, COD_TRABALHO_FK,
		SALARIO_CLIENTE, NUMEROCASA)
		VALUES
		('GERMANO', NULL, '02/07/2004',
		2, 1, 1,
		1, 1, 5,
		1300, 5);
INSERT INTO CLIENTE(NOME_CLIENTE, FOTO_CLIENTE, DATANASC_CLIENTE,
		COD_SEXO_FK, COD_RUA_FK,COD_BAIRRO_FK,
		COD_CEP_FK, COD_CIDADE_FK, COD_TRABALHO_FK,
		SALARIO_CLIENTE, NUMEROCASA)
		VALUES
		('MARIANA', NULL, '02/07/2013',
		1, 1, 1,
		1, 1, 5,
		1300, 5);

--UPDATE CLIENTE SET COD_CLIENTE = 5
--WHERE COD_CLIENTE = 6;

SELECT C.COD_CLIENTE, C.NOME_CLIENTE, S.NOME_SEXO, R.NOME_RUA, B.NOME_BAIRRO, CEP.NOME_CEP, CID.NOME_CIDADE, T.NOME_TRABALHO, C.SALARIO_CLIENTE, C.NUMEROCASA
FROM CLIENTE C, SEXO S, RUA R, BAIRRO B, CEP, CIDADE CID, TRABALHO T
WHERE S.COD_SEXO = C.COD_SEXO_FK
AND R.COD_RUA = C.COD_RUA_FK
AND B.COD_BAIRRO = C.COD_BAIRRO_FK
AND CEP.COD_CEP = C.COD_CEP_FK
AND CID.COD_CIDADE = C.COD_CIDADE_FK
AND T.COD_TRABALHO = C.COD_TRABALHO_FK;
--	1;"MIGUEL";"MASCULINO";"RUA TRÊS";"BELA VISTA";"55641-715";"SÃO PAULO";"ANÁLISE E DESENVOLVIMENTO DE SISTEMAS";3000.00;"1"
--	2;"ARTHUR";"MASCULINO";"RUA CINCO";"ITAIM BIBI";"01010-904";"SÃO PAULO";"NUTRIÇÃO";1400.00;"2"
--	3;"HEITOR";"MASCULINO";"RUA TRÊS";"LIBERDADE";"11325-000";"SÃO PAULO";"RECURSOS HUMANOS";1400.00;"3"
--	4;"ALICE";"MASCULINO";"RUA TRÊS";"LIBERDADE";"11325-000";"PRAIA GRANDE";"ANÁLISE E DESENVOLVIMENTO DE SISTEMAS";2400.00;"4"
--	5;"GERMANO";"MASCULINO";"RUA UM";"LIBERDADE";"01010-904";"SÃO PAULO";"ANÁLISE E DESENVOLVIMENTO DE SISTEMAS";1300.00;"5"


INSERT INTO ITENS_TEL_CLI(COD_TELEFONE_FK, COD_CLIENTE_FK)
VALUES (1,1);
INSERT INTO ITENS_TEL_CLI(COD_TELEFONE_FK, COD_CLIENTE_FK)
VALUES (2,2);
INSERT INTO ITENS_TEL_CLI(COD_TELEFONE_FK, COD_CLIENTE_FK)
VALUES (3,3);
INSERT INTO ITENS_TEL_CLI(COD_TELEFONE_FK, COD_CLIENTE_FK)
VALUES (4,4);
INSERT INTO ITENS_TEL_CLI(COD_TELEFONE_FK, COD_CLIENTE_FK)
VALUES (5,5);

SELECT C.NOME_CLIENTE, T.NUMERO
FROM CLIENTE C, TELEFONE T, ITENS_TEL_CLI I
WHERE C.COD_CLIENTE = I.COD_CLIENTE_FK
AND T.COD_TELEFONE = I.COD_TELEFONE_FK;
--	"MIGUEL";"+(55) 11 99398-4015"
--	"ARTHUR";"+(55) 12 99398-4015"
--	"HEITOR";"+(55) 13 99398-4015"
--	"ALICE";"+(55) 14 99398-4015"
--	"GERMANO";"+(55) 17 99398-4015"


INSERT INTO ITENS_TEL_TRA(COD_TELEFONE_FK, COD_TRABALHO_FK)
VALUES (1,2);
INSERT INTO ITENS_TEL_TRA(COD_TELEFONE_FK, COD_TRABALHO_FK)
VALUES (2,3);
INSERT INTO ITENS_TEL_TRA(COD_TELEFONE_FK, COD_TRABALHO_FK)
VALUES (3,4);
INSERT INTO ITENS_TEL_TRA(COD_TELEFONE_FK, COD_TRABALHO_FK)
VALUES (4,5);
INSERT INTO ITENS_TEL_TRA(COD_TELEFONE_FK, COD_TRABALHO_FK)
VALUES (5,6);

SELECT TRA.NOME_TRABALHO, T.NUMERO
FROM TRABALHO TRA, TELEFONE T, ITENS_TEL_TRA I
WHERE TRA.COD_TRABALHO = I.COD_TRABALHO_FK
AND T.COD_TELEFONE = I.COD_TELEFONE_FK;
--	"AGRONOMIA";"+(55) 11 99398-4015"
--	"BIOMEDICINA";"+(55) 12 99398-4015"
--	"NUTRIÇÃO";"+(55) 13 99398-4015"
--	"ANÁLISE E DESENVOLVIMENTO DE SISTEMAS";"+(55) 14 99398-4015"
--	"RECURSOS HUMANOS";"+(55) 17 99398-4015"


INSERT INTO FUNCAO(NOME_FUNCAO)
VALUES('ESTAGIÁRIO');
INSERT INTO FUNCAO(NOME_FUNCAO)
VALUES('FUNCIONARIO');
INSERT INTO FUNCAO(NOME_FUNCAO)
VALUES('SUB-CHEFE');
INSERT INTO FUNCAO(NOME_FUNCAO)
VALUES('CHEFE');
INSERT INTO FUNCAO(NOME_FUNCAO)
VALUES('DONO');
SELECT * FROM FUNCAO;
--	1;"ESTAGIÁRIO"
--	2;"FUNCIONARIO"
--	3;"SUB-CHEFE"
--	4;"CHEFE"
--	5;"DONO

INSERT INTO LOJA(NOME_LOJA, CNPJ, NOME_FANTASIA, RAZAOSOCIAL)
VALUES (' LOJAUNIFUNEC2023', 001, 'UNIFUNEC', 'CENTRO DOCENTE DE SANTA FÉ DO SUL UNIFUNEC');
select * from LOJA;

UPDATE LOJA
SET NOME_LOJA = 'LOJAUNIFUNEC2023'
WHERE NOME_LOJA = ' LOJAUNIFUNEC2023';

--	1;"LOJAUNIFUNEC2023";"1";"UNIFUNEC";"CENTRO DOCENTE DE SANTA FÉ DO SUL UNIFUNEC"

INSERT INTO FUNCIONARIOS(NOME_FUNCIONARIO, NUMEROCASA, COD_RUA_FK, COD_BAIRRO_FK, COD_CEP_FK, COD_CIDADE_FK, COD_FUNCAO_FK, COD_LOJA_fk, SALARIO)
VALUES('GERMANO', 262, 4, 3, 2, 3, 1, 1, 1000);
INSERT INTO FUNCIONARIOS(NOME_FUNCIONARIO, NUMEROCASA, COD_RUA_FK, COD_BAIRRO_FK, COD_CEP_FK, COD_CIDADE_FK, COD_FUNCAO_FK, COD_LOJA_fk, SALARIO)
VALUES('FABRICIO', 232, 3, 4, 2, 3, 1, 1, 3000);
INSERT INTO FUNCIONARIOS(NOME_FUNCIONARIO, NUMEROCASA, COD_RUA_FK, COD_BAIRRO_FK, COD_CEP_FK, COD_CIDADE_FK, COD_FUNCAO_FK, COD_LOJA_fk, SALARIO)
VALUES('ANDREA', 132, 2, 5, 3, 3, 1, 1, 6000);

SELECT F.NOME_FUNCIONARIO, F.NUMEROCASA, R.NOME_RUA, B.NOME_BAIRRO, CEP.NOME_CEP, CID.NOME_CIDADE, FUN.NOME_FUNCAO, L.NOME_LOJA,F.SALARIO
FROM FUNCIONARIOS F, RUA R, BAIRRO B, CEP, CIDADE CID, FUNCAO FUN, LOJA L
WHERE F.COD_RUA_FK = R.COD_RUA
AND   F.COD_BAIRRO_FK = B.COD_BAIRRO
AND   F.COD_CEP_FK = CEP.COD_CEP
AND   F.COD_CIDADE_FK = CID.COD_CIDADE
AND   F.COD_FUNCAO_FK = FUN.COD_FUNCAO
AND   F.COD_LOJA_FK = L.COD_LOJA;
--	"GERMANO";"262";"RUA QUATRO";"BAIXO AUGUSTA";"20031-900";"BRASÍLIA";"ESTAGIÁRIO";"LOJAUNIFUNEC2023";1000.00

INSERT INTO MARCA(NOME_MARCA)
VALUES('COMIDA BOA');

INSERT INTO TIPO(NOME_TIPO)
VALUES('ALIMENTICIO');

INSERT INTO PRODUTO(NOME_PRODUTO, QUANTIDADE, 
		    VALOR, COD_MARCA_FK, 
		    COD_TIPO_FK)
VALUES ('ARROZ', 100000, 25.50, 1, 1);

INSERT INTO PRODUTO(NOME_PRODUTO, QUANTIDADE, 
		    VALOR, COD_MARCA_FK, 
		    COD_TIPO_FK)
VALUES ('FEIJAO', 4000, 10.10, 1, 1);



INSERT INTO FORNECEDOR(NOME_FORNECEDOR, NUMEROCASA, COD_RUA_FK, COD_BAIRRO_FK, COD_CEP_FK, COD_CIDADE_FK)
VALUES ('JOÃO', 001, 1, 2, 3, 4);
SELECT * FROM FORNECEDOR;


INSERT INTO COMPRAPRODUTO(DATA_COMPRA, COD_FORNECEDOR_FK, COD_FUNCIONARIO_FK)
VALUES('30/03/2023', 1, 2);
SELECT * FROM COMPRAPRODUTO;

INSERT INTO ITENS_COMPRA_PRODUTO(COD_COMPRA_FK, COD_PRODUTO_FK, QUANTIDADE, VALOC)
VALUES (3, 1, 1, 30);
SELECT * FROM ITENS_COMPRA_PRODUTO;

--------------------------------------------------------------------------------------------------
--LISTE A QUANTIDADE DE FUNCIONÁRIOS DA LOJAUNIFUNEC2020.
SELECT COUNT(COD_LOJA_FK) 
FROM FUNCIONARIOS, LOJA
WHERE LOJA.NOME_LOJA = 'LOJAUNIFUNEC2023';


--LISTE QUANTOS CLIENTES A LOJA UNIFUNEC POSSUI.
SELECT COUNT(NOME_CLIENTE)
FROM CLIENTE;


--INFORME O VALOR DO MAIOR SALÁRIO DO FUNCIONÁRIO DA LOJA.
SELECT MAX(SALARIO)
FROM FUNCIONARIOS;


--INFORME O MAIOR E MENOR CÓDIGO DAS CIDADES DO CADASTRADAS NO BANCO DE DADOS.
SELECT MAX(COD_CIDADE)
FROM CIDADE;

SELECT MIN(COD_CIDADE)
FROM CIDADE;


--INFORME A SOMA DE TODOS OS SALÁRIOS DOS FUNCIONÁRIOS DA LOJA.
SELECT SUM(SALARIO)
AS SOMA_DOS_SALARIOS
FROM FUNCIONARIOS;



--IMPRIMA A MÉDIA DE TODOS OS SALÁRIOS DA LOJA.
SELECT AVG(SALARIO)
AS MEDIA
FROM FUNCIONARIOS;


--IMPRIMA O SUBTOTAL (QUANTIDADE * VALOR) DE TODOS OS PRODUTOS DA LOJA.

SELECT (SELECT SUM(QUANTIDADE)
AS TOTAL
FROM PRODUTO)
*
(SELECT SUM(VALOR)
FROM PRODUTO);


-- IMPRIMA O VALOR TOTAL NO ESTOQUE DA LOJA
SELECT SUM(QUANTIDADE)
AS TOTAL
FROM PRODUTO;


-- IMPRIMA OS DADOS DE TODOS OS CLIENTES DA LOJA.
SELECT * FROM CLIENTE;


--  IMPRIMA OS DADOS DE TODAS AS CIDADES DA LOJA.
 SELECT * FROM CIDADE;


-- IMPRIMA OS DADOS DE TODAS AS CIDADES COM A SIGLA DO ESTADO A QUE ESTE PERTENCE.
SELECT C.NOME_CIDADE, UF.SIGLA
FROM CIDADE C, UF
WHERE C.COD_UF_FK = UF.COD_UF; 

-- IMPRIMA A QUANTIDADE DE CLIENTES QUE MORAM NA CIDADE DE “SÃO PAULO”.
SELECT COUNT(NOME_CLIENTE)
FROM CLIENTE, CIDADE
WHERE CLIENTE.COD_CIDADE_FK = CIDADE.COD_CIDADE
AND CIDADE.NOME_CIDADE = 'SÃO PAULO';


-- ) IMPRIMA A QUANTIDADE DE CLIENTES QUE MORAM EM CIDADES QUE COMEÇAM PELA LETRA “P”
SELECT COUNT(NOME_CLIENTE)
FROM CLIENTE CLI, CIDADE C
WHERE C.NOME_CIDADE LIKE 'P%'
AND CLI.COD_CIDADE_FK = C.COD_CIDADE;


-- IMPRIMA A QUANTIDADE DE CLIENTES QUE MORAM EM CIDADES QUE TERMINEM COM A LETRA “O”
SELECT COUNT(NOME_CLIENTE)
FROM CLIENTE CLI, CIDADE C
WHERE C.NOME_CIDADE LIKE '%O'
AND CLI.COD_CIDADE_FK = C.COD_CIDADE;


-- IMPRIMA A QUANTIDADE DE CLIENTES QUE SÃO DO SEXO FEMININO.
SELECT COUNT(NOME_CLIENTE)
FROM CLIENTE CLI, SEXO S
WHERE CLI.COD_SEXO_FK = S.COD_SEXO
AND   S.NOME_SEXO = 'FEMININO';


-- IMPRIMA OS DADOS DOS CLIENTES QUE SÃO DO SEXO FEMININO E QUE MORAM NA CIDADE DE SÃO PAULO”
SELECT *
FROM CLIENTE CLI, CIDADE C, SEXO S
WHERE CLI.COD_SEXO_FK = S.COD_SEXO
AND   CLI.COD_CIDADE_FK = C.COD_CIDADE
AND   S.NOME_SEXO = 'FEMININO'
AND   C.NOME_CIDADE = 'SÃO PAULO';


--  IMPRIMA A QUANTIDADE DE CLIENTES QUE POSSUEM O MESMO TELEFONE.





--	IMPRIMA OS DADOS DOS CLIENTES DE FORMA QUE SE SUBSTITUA AS CHAVES 
--	ESTRANGEIRAS PELO VALORES CONCRETOS DA CHAVE. EXEMPLO: SUBSTITUA 
--	CODCIDADE PELO NOME DA CIDADE.
SELECT C.COD_CLIENTE, C.NOME_CLIENTE, S.NOME_SEXO, R.NOME_RUA, B.NOME_BAIRRO, CEP.NOME_CEP, CID.NOME_CIDADE, T.NOME_TRABALHO, C.SALARIO_CLIENTE, C.NUMEROCASA
FROM CLIENTE C, SEXO S, RUA R, BAIRRO B, CEP, CIDADE CID, TRABALHO T
WHERE S.COD_SEXO = C.COD_SEXO_FK
AND R.COD_RUA = C.COD_RUA_FK
AND B.COD_BAIRRO = C.COD_BAIRRO_FK
AND CEP.COD_CEP = C.COD_CEP_FK
AND CID.COD_CIDADE = C.COD_CIDADE_FK
AND T.COD_TRABALHO = C.COD_TRABALHO_FK;


--  IMPRIMA O VALOR TOTAL DE UMA VENDA ESPECÍFICA.


SELECT VALOC
FROM ITENS_COMPRA_PRODUTO
WHERE COD_COMPRA_FK = 3;


--  IMPRIMA O VALOR TOTAL DAS VENDAS OCORRIDAS NAS DATA ATUAL. UTILIZE A FUNÇÃO NOW().
SELECT TELEFONE COUNT(*) 
FROM CLIENTE, telefone 
GROUP BY TELEFONE 
HAVING COUNT() > 1;
--  ) IMPRIMA A QUANTIDADE DE PARCELAS DE UMA DETERMINADA VENDA.
SELECT CLIENTES.*, CIDADES.NOME 
AS CIDADE_NOME, ESTADOS.SIGLA 
FROM CLIENTES 
JOIN CIDADES ON CLIENTES.CIDADE = CIDADES.ID 
JOIN ESTADOS ON CIDADES.ESTADO = ESTADOS.ID;

--) IMPRIMA A QUANTDADE DE PARCELAS EM ATRASO DO CLIENTE “MARCOS 
--ANTONIO ESTREMOTE”.
SELECT SUM(QUANTIDADE * VALOR) 
AS TOTAL 
FROM VENDAS_PRODUTOS 
WHERE VENDA = 1234;


SELECT SUM(QUANTIDADE * VALOR) AS TOTAL FROM VENDAS_PRODUTOS JOIN VENDAS ON VENDAS_PRODUTOS.VENDA = VENDAS.ID WHERE VENDAS.DATA = NOW();

SELECT COUNT(*) FROM PARCELAS WHERE VENDA = 1234;

SELECT COUNT(*) FROM PARCELAS JOIN CLIENTES ON PARCELAS.CLIENTE = CLIENTES.ID WHERE CLIENTES.NOME = 'MARCOS ANTONIO ESTREMOTE' AND PARCELAS.VENCIMENTO < DATE_SUB(NOW(), INTERVAL 30 DAY);

SELECT ACESSOS.PARTE_SISTEMA FROM FUNCIONARIOS JOIN ACESSOS ON FUNCIONARIOS.CARGO = ACESSOS.CARGO WHERE FUNCIONARIOS.NOME = 'JOÃO DA SILVA';

SELECT SUM(QUANTIDADE) FROM PRODUTOS JOIN FORNECEDORES ON PRODUTOS.FORNECEDOR = FORNECEDORES.ID WHERE PRODUTOS.MARCA = 'ARISCO' AND PRODUTOS.TIPO = 'ALIMENTÍCIO';

SELECT * FROM FORNECEDORES;

SELECT COUNT(*) FROM fornecedores
WHERE nome LIKE 'X%' AND codcidade = (SELECT codcidade FROM cidades WHERE nome = 'SANTA FÉ DO SUL');

SELECT * FROM clientes
WHERE telefone LIKE '%TIM%';

SELECT *FROM funcionarios
WHERE funcao = 'PROGRAMADOR DE COMPUTADORES';

SELECT *FROM acessos
WHERE login_func = 'ALEX TRINDADE' AND permitido = false;

SELECT *FROM clientes
WHERE sexo = 'M' AND bairro = 'CENTRO' AND codcidade <> (SELECT codcidade FROM cidades WHERE nome = 'ILHA SOLTEIRA')
AND EXISTS (SELECT *FROM vendas
WHERE vendas.codcliente = clientes.codcliente
AND DATEDIFF(NOW(), vendas.data_venda) > 30
AND EXISTS (SELECT *
FROM parcelasWHERE parcelas.codvenda = vendas.codvenda
AND parcelas.data_vencimento < NOW()
AND parcelas.pago = false));





