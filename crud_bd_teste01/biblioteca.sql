DROP DATABASE IF EXISTS biblioteca;
CREATE DATABASE biblioteca;
USE biblioteca;

# Criando as tabelas
CREATE TABLE palavra (
	palavra_chave VARCHAR(20) NOT NULL PRIMARY KEY,
	`desc` VARCHAR(100) NOT NULL
);

CREATE TABLE area (
	cod INT NOT NULL PRIMARY KEY,
	area VARCHAR(50) NOT NULL
);

CREATE TABLE usuario (
	prontuario VARCHAR(9) NOT NULL PRIMARY KEY,
	nome VARCHAR(30) NOT NULL,
	sobrenome VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL
);

CREATE TABLE editora (
	nome VARCHAR(100) NOT NULL PRIMARY KEY,
	endereco VARCHAR(100) NOT NULL
);

CREATE TABLE livro (
	isbn CHAR(12) NOT NULL PRIMARY KEY,
	titulo VARCHAR(50) NOT NULL,
	edicao INT NOT NULL,
	editora VARCHAR(100) NOT NULL,
	FOREIGN KEY(editora) REFERENCES editora(nome) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE exemplar (
	numero INT NOT NULL,
	isbn CHAR(12) NOT NULL,
	corredor CHAR(1) NOT NULL,
	estante INT NOT NULL,
	PRIMARY KEY (numero, isbn),
	FOREIGN KEY (isbn) REFERENCES livro(isbn) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE emprestimo (
	data_retirada DATETIME NOT NULL,
	prontuario VARCHAR(9) NOT NULL,
	data_devolucao DATE NOT NULL,
	estado CHAR(20) NOT NULL,
	multa DECIMAL(9,2) NOT NULL,
	PRIMARY KEY(data_retirada, prontuario),
	FOREIGN KEY(prontuario) REFERENCES usuario(prontuario) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE autor (
	cod INT NOT NULL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	sobrenome VARCHAR(100) NOT NULL
);


# Tabelas Adicionais
CREATE TABLE livro_palavra (
	palavra VARCHAR(20) NOT NULL,
	isbn CHAR(12) NOT NULL,
	PRIMARY KEY(palavra, isbn),
	FOREIGN KEY(palavra) REFERENCES palavra(palavra_chave) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(isbn) REFERENCES livro(isbn) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE livro_autor (
	cod INT NOT NULL,
	isbn CHAR(12) NOT NULL,
	PRIMARY KEY(cod, isbn),
	FOREIGN KEY(cod) REFERENCES autor(cod) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(isbn) REFERENCES livro(isbn) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE livro_area (
	cod INT NOT NULL,
	isbn CHAR(12) NOT NULL,
	PRIMARY KEY(cod, isbn),
	FOREIGN KEY(cod) REFERENCES area(cod) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(isbn) REFERENCES livro(isbn) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE emprestimo_exemplar (
	`data` DATETIME NOT NULL,
	prontuario VARCHAR(9) NOT NULL,
	numero INT NOT NULL,
	isbn CHAR(12) NOT NULL,
	data_devolvido DATE,
	PRIMARY KEY(`data`, prontuario, numero, isbn),
	FOREIGN KEY (`data`) REFERENCES emprestimo(data_retirada) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (prontuario) REFERENCES emprestimo(prontuario) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (numero) REFERENCES exemplar(numero) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (isbn) REFERENCES exemplar(isbn) ON DELETE CASCADE ON UPDATE CASCADE
);


# Inserindo os valores
INSERT INTO palavra VALUES
(
	'Redes',
	'Redes de computadores'
),
(
	'Célula',
	'Citologia'
),
(
	'Triângulo',
	'Trigonometria'
),
(
	'Fórmulas',
	'Cálculo Estequiométrico'
);

INSERT INTO area VALUES
(
	1234,
    'Ciência da Computação'
),
(
	2928,
    'Biologia'
),
(
	154,
    'Matemática'
),
(
	4211,
    'Química'
);

INSERT INTO usuario VALUES
(
	'aq12345',
    'Orlando',
    'Norris',
    'norris@ig.com'
),
(
	'aq20054',
    'Felipe',
    'Santos',
    'felipe.s@ap.com'
),
(
	'aq00134',
    'José',
    'Silva',
    'jose.s@lag.com'
),
(
	'aq10028',
    'Polyana',
    'Machado',
    'polly.m@ma.com'
);

INSERT INTO editora VALUES
(
	'Ática',
    'Rua nove, 8 Itu-SP'
),
(
	'Estrela',
    'Av. Amazonas, 41 Salvador-BA'
),
(
	'Novo',
    'Rua palmares, 5 Sorocaba-SP'
),
(
	'Galo',
    'Rua jardins, 125 Araraquara-SP'
);

INSERT INTO livro VALUES
(
	'987456',
    'IOT',
    3,
    'Ática'
),
(
	'102996',
    'Procariontes e Eucariontes',
    1,
    'Estrela'
),
(
	'023015',
    'Ângulos',
    28,
    'Novo'
),
(
	'123098',
    'Cálculo Estequiométrico',
    3,
    'Galo'
);

INSERT INTO exemplar VALUES
(
	1,
    '987456',
    'C',
    4
),
(
	2,
    '102996',
    'A',
    1
),
(
	3,
    '023015',
    'B',
    9
),
(
	4,
    '123098',
    'C',
    7
);

INSERT INTO emprestimo VALUES
(
	'2021-05-15 08:00',
    'aq12345',
    '2021-06-08',
    'Pendente',
    25
),
(
	'2022-03-09 09:30',
    'aq20054',
    '2022-03-16',
    'Pendente',
    13
),
(
	'2021-04-11 13:00',
    'aq00134',
    '2021-05-11',
    'Devolvido',
    0.0
),
(
	'2021-11-01 06:00',
    'aq10028',
    '2021-11-08',
    'Devolvido',
    0.0
);

INSERT INTO autor VALUES
(
	258,
    'Charles',
    'Leclerq'
),
(
	14,
    'Max',
    'Plank'
),
(
	253,
    'Aristóteles',
    'de Atenas'
),
(
	989,
    'Matthew',
    'Willians'
);


# Inserindo os valores nas tabelas adicionais
INSERT INTO livro_palavra VALUES
(
	'Redes',
	'987456'
),
(
	'Célula',
	'102996'
),
(
	'Triângulo',
	'023015'
),
(
	'Fórmulas',
	'123098'
);

INSERT INTO livro_autor VALUES
(
	258,
    '987456'
),
(
	14,
    '102996'
),
(
	253,
    '023015'
),
(
	989,
    '123098'
);

INSERT INTO livro_area VALUES
(
	1234,
    '987456'
),
(
	2928,
    '102996'
),
(
	154,
    '023015'
),
(
	4211,
    '123098'
);

INSERT INTO emprestimo_exemplar VALUES
(
	'2021-05-15 08:00',
    'aq12345',
    1,
    '987456',
    NULL
),
(
	'2022-03-09 09:30',
    'aq20054',
    2,
    '102996',
    NULL
),
(
	'2021-04-11 13:00',
    'aq00134',
    3,
    '023015',
    '2021-05-15'
),
(
	'2021-11-01 06:00',
    'aq10028',
    4,
    '123098',
    '2021-11-08'
);