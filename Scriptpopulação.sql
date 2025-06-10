SET FOREIGN_KEY_CHECKS = 0;
SET SQL_SAFE_UPDATES = 0;

USE md_dados3;


CREATE TABLE IF NOT EXISTS acidentes_temp (
    `NumeroOcorrencia` int NOT NULL,
    `NumeroDaFicha` varchar(100) default null,
    `Operador` varchar(100) DEFAULT NULL,
    `Classificacao` varchar(45) DEFAULT NULL,
    `DataOcorrencia` date DEFAULT NULL,
    `HoraOcorrencia` time DEFAULT NULL,
    `Municipio` varchar(100) DEFAULT NULL,
    `UF` varchar(45) NOT NULL,
    `Regiao` varchar(45) DEFAULT NULL,
    `Descricao` varchar(255) DEFAULT NULL,
    `ICAO` varchar(255) DEFAULT NULL,
    `TipoAerodromo` varchar(100) DEFAULT NULL,
    `Historico` varchar(3500) DEFAULT NULL,
    `Matricula` varchar(100) NOT NULL,
    `Categoria` varchar(100) DEFAULT NULL,
    `TipoOcorrencia` varchar(45) DEFAULT NULL,
    `FaseOperacao` varchar(150) DEFAULT NULL,
    `TipoOperacao` varchar(150) DEFAULT NULL,
    `DanosAeronave` varchar(255) DEFAULT NULL,
    `AerodromoDestino` varchar(45) DEFAULT NULL,
    `AerodromoOrigem` varchar(45) DEFAULT NULL,
    `LesoesFataisTripulantes` int DEFAULT NULL,
    `LesoesFataisPassageiros` int DEFAULT NULL,
    `LesoesFataisTerceiros` int DEFAULT NULL,
    `LesoesGravesTripulantes` int DEFAULT NULL,
    `LesoesGravesPassageiros` int DEFAULT NULL,
    `LesoesGravesTerceiros` int DEFAULT NULL,
    `LesoesLevesTripulantes` int DEFAULT NULL,
    `LesoesLevesPassageiros` int DEFAULT NULL,
    `LesoesLevesTerceiros` int DEFAULT NULL,
    `LesoesDesconhecidasTripulantes` int DEFAULT NULL,
    `LesoesDesconhecidasPassageiros` int DEFAULT NULL,
    `LesoesDesconhecidasTerceiros` int DEFAULT NULL,
    `IlesosTripulantes` int DEFAULT NULL,
    `IlesosPassageiros` int DEFAULT NULL,
    `Modelo` varchar(100) DEFAULT NULL,
    `Cls` varchar(45) DEFAULT NULL,
    `TipoICAO` varchar(45) DEFAULT NULL,
    `PMD` int DEFAULT NULL,
    `Assentos` int DEFAULT NULL,
    `Fabricante` varchar(100) DEFAULT NULL,
    `PSSO` tinyint DEFAULT NULL,
    `Aeronave_Matricula` varchar(100) NOT NULL,
    `Localidade_ID` int NOT NULL,
    `IDAerodromo` int DEFAULT NULL,
    `id_consequencia` int NOT NULL
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ocorrencias_atualizado.csv'
INTO TABLE acidentes_temp
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
  NumeroOcorrencia, NumeroDaFicha, Operador, Classificacao, DataOcorrencia,
  HoraOcorrencia, Municipio, UF, Regiao, Descricao, ICAO, TipoAerodromo,
  Historico, Matricula, Categoria, TipoOcorrencia, FaseOperacao, TipoOperacao,
  DanosAeronave, AerodromoDestino, AerodromoOrigem, LesoesFataisTripulantes,
  LesoesFataisPassageiros, LesoesFataisTerceiros, LesoesGravesTripulantes,
  LesoesGravesPassageiros, LesoesGravesTerceiros, LesoesLevesTripulantes,
  LesoesLevesPassageiros, LesoesLevesTerceiros, LesoesDesconhecidasTripulantes,
  LesoesDesconhecidasPassageiros, LesoesDesconhecidasTerceiros, IlesosTripulantes,
  IlesosPassageiros, Modelo, Cls, TipoICAO, PMD, Assentos, Fabricante, @PSSO,
  @Aeronave_Matricula, @Localidade_ID, @IDAerodromo, @id_consequencia
)
SET
  PSSO = NULLIF(@PSSO, ''),
  Aeronave_Matricula = NULLIF(@Aeronave_Matricula, ''),
  Localidade_ID = NULLIF(@Localidade_ID, ''),
  IDAerodromo = NULLIF(@IDAerodromo, ''),
  id_consequencia = NULLIF(@id_consequencia, '');



INSERT IGNORE INTO aeronave (Matricula, TipoOperacao, Modelo, Categoria, Cls, Fabricante, TipoICAO, PMD, Assentos)
SELECT DISTINCT Matricula, TipoOperacao, Modelo, Categoria, Cls, Fabricante, TipoICAO, PMD, Assentos FROM acidentes_temp;

INSERT IGNORE INTO localidade (UF, Regiao, Municipio)
SELECT DISTINCT UF, Regiao, Municipio FROM acidentes_temp;

INSERT IGNORE INTO aerodromo (ICAO, TipoAerodromo, AerodromoDestino, AerodromoOrigem)
SELECT DISTINCT ICAO, TipoAerodromo, AerodromoDestino, AerodromoOrigem FROM acidentes_temp;


UPDATE acidentes_temp at JOIN localidade l ON at.UF = l.UF AND at.Municipio = l.Municipio SET at.Localidade_ID = l.Localidade_ID;
UPDATE acidentes_temp at JOIN aerodromo a ON at.ICAO = a.ICAO SET at.IDAerodromo = a.IDAerodromo;


INSERT IGNORE INTO consequenciasdoacidente (
    Acidente_NumeroOcorrencia, DanosAeronave, IlesosPassageiros, IlesosTripulantes, LesoesDesconhecidasTerceiros,
    LesoesDesconhecidasPassageiros, LesoesDesconhecidasTripulantes, LesoesLevesTerceiros,
    LesoesLevesPassageiros, LesoesLevesTripulantes, LesoesGravesTerceiros,
    LesoesGravesPassageiros, LesoesGravesTripulantes, LesoesFataisTerceiros,
    LesoesFataisPassageiros, LesoesFataisTripulantes
)
SELECT DISTINCT 
    NumeroOcorrencia, DanosAeronave, IlesosPassageiros, IlesosTripulantes, LesoesDesconhecidasTerceiros,
    LesoesDesconhecidasPassageiros, LesoesDesconhecidasTripulantes, LesoesLevesTerceiros,
    LesoesLevesPassageiros, LesoesLevesTripulantes, LesoesGravesTerceiros,
    LesoesGravesPassageiros, LesoesGravesTripulantes, LesoesFataisTerceiros,
    LesoesFataisPassageiros, LesoesFataisTripulantes
FROM acidentes_temp;


INSERT IGNORE INTO acidente (
    NumeroOcorrencia, NumeroDaFicha, Operador, Classificacao, TipoOcorrencia,
    DataOcorrencia, HoraOcorrencia, Historico, TipoOperacao,
    FaseOperacao, PSSO, Descricao, Aeronave_Matricula,
    Localidade_ID, IDAerodromo
)
SELECT
    NumeroOcorrencia, NumeroDaFicha, Operador, Classificacao, TipoOcorrencia,
    DataOcorrencia, HoraOcorrencia, Historico, TipoOperacao,
    FaseOperacao, PSSO, Descricao, Matricula,
    Localidade_ID, IDAerodromo
FROM acidentes_temp;


UPDATE acidente ac
JOIN consequenciasdoacidente co ON ac.NumeroOcorrencia = co.Acidente_NumeroOcorrencia
SET ac.id_consequencia = co.id_consequencia;


SET SQL_SAFE_UPDATES = 1;
SET FOREIGN_KEY_CHECKS = 1;

DROP TABLE acidentes_temp;