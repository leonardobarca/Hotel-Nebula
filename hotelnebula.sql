CREATE DATABASE hotelnebula;
USE hotelnebula;

#Parte 2: Montagem do Núcleo
#impletmentação física do banco relacional
CREATE TABLE hospede (
  id_hospede      INT AUTO_INCREMENT PRIMARY KEY,
  nome            VARCHAR(100) NOT NULL,
  cpf             VARCHAR(14) UNIQUE NOT NULL,
  email           VARCHAR(100) UNIQUE,
  telefone        VARCHAR(20),
  endereco        TEXT,
  data_nascimento DATE,
  criado_em       TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE funcionario (
  id_funcionario  INT AUTO_INCREMENT PRIMARY KEY,
  nome            VARCHAR(100) NOT NULL,
  cpf             VARCHAR(14) UNIQUE NOT NULL,
  cargo           VARCHAR(50) NOT NULL,
  email           VARCHAR(100),
  telefone        VARCHAR(20),
  salario         DECIMAL(10,2),
  data_admissao   DATE NOT NULL
);

CREATE TABLE quarto (
  id_quarto       INT AUTO_INCREMENT PRIMARY KEY,
  numero          VARCHAR(10) UNIQUE NOT NULL,
  tipo            VARCHAR(30) NOT NULL,
  preco_diaria    DECIMAL(10,2) NOT NULL,
  status          VARCHAR(20) DEFAULT 'disponivel',
  capacidade      INT NOT NULL DEFAULT 1,
  descricao       TEXT
);

CREATE TABLE reserva (
  id_reserva      INT AUTO_INCREMENT PRIMARY KEY,
  id_hospede      INT NOT NULL,
  id_quarto       INT NOT NULL,
  id_funcionario  INT,
  data_checkin    DATE NOT NULL,
  data_checkout   DATE NOT NULL,
  status          VARCHAR(20) DEFAULT 'confirmada',
  valor_total     DECIMAL(10,2),
  criado_em       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_hospede)     REFERENCES hospede(id_hospede),
  FOREIGN KEY (id_quarto)      REFERENCES quarto(id_quarto),
  FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario)
);

CREATE TABLE hospedagem (
  id_hospedagem   INT AUTO_INCREMENT PRIMARY KEY,
  id_reserva      INT UNIQUE NOT NULL,
  id_funcionario  INT,
  checkin_real    TIMESTAMP NOT NULL,
  checkout_real   TIMESTAMP,
  observacoes     TEXT,
  FOREIGN KEY (id_reserva)     REFERENCES reserva(id_reserva),
  FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario)
);

CREATE TABLE pagamento (
  id_pagamento    INT AUTO_INCREMENT PRIMARY KEY,
  id_hospedagem   INT NOT NULL,
  valor           DECIMAL(10,2) NOT NULL,
  metodo          VARCHAR(30) NOT NULL,
  status          VARCHAR(20) DEFAULT 'pendente',
  data_pagamento  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  comprovante     VARCHAR(255),
  FOREIGN KEY (id_hospedagem) REFERENCES hospedagem(id_hospedagem)
);

CREATE TABLE avaliacao (
  id_avaliacao    INT AUTO_INCREMENT PRIMARY KEY,
  id_hospedagem   INT UNIQUE NOT NULL,
  id_hospede      INT NOT NULL,
  nota            INT NOT NULL CHECK (nota BETWEEN 1 AND 5),
  comentario      TEXT,
  data_avaliacao  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_hospedagem) REFERENCES hospedagem(id_hospedagem),
  FOREIGN KEY (id_hospede)    REFERENCES hospede(id_hospede)
);

INSERT INTO hospede (nome, cpf, email, telefone, endereco, data_nascimento) VALUES
('Gabau',      '111.111.111-01', 'gabau@email.com','11991111111','Casa do Gabau - Bahia', '1990-05-14'),
('Gabareu',     '222.222.222-02', 'gabareu@email.com','11992222222', 'Casa do Gabareu - São Paulo', '1985-08-22'),
('Gabriel', '333.333.333-03', 'gabriel@email.com',  '11993333333','Casa do Gabriel- Tocantins', '1995-03-10'),
('Augusto',        '444.444.444-04', 'augusto@email.com','11994444444','Rua Bateu Preguiça Vou Usar IA nos VALUES - Ceará','2000-11-30'),
('Lindo da Silva',     '555.555.555-05', 'lindo@email.com',   '11995555555', 'Av. Brasil, 321 - Guarulhos/SP',      '1988-07-19');

INSERT INTO funcionario (nome, cpf, cargo, email, telefone, salario, data_admissao) VALUES
('Fernanda Rocha',  '666.666.666-06', 'Recepcionista', 'fernanda@hotel.com', '11996666666', 2500.00, '2022-01-10'),
('Ricardo Mendes',  '777.777.777-07', 'Gerente',       'ricardo@hotel.com',  '11997777777', 5000.00, '2020-03-15'),
('Juliana Alves',   '888.888.888-08', 'Recepcionista', 'juliana@hotel.com',  '11998888888', 2500.00, '2023-06-01');

INSERT INTO quarto (numero, tipo, preco_diaria, status, capacidade, descricao) VALUES
('101', 'Simples',  150.00, 'disponivel', 1, 'Quarto simples com cama de solteiro'),
('102', 'Duplo',    250.00, 'disponivel', 2, 'Quarto duplo com cama de casal'),
('201', 'Suite',    450.00, 'disponivel', 2, 'Suite com banheira e vista para o jardim'),
('202', 'Simples',  150.00, 'disponivel', 1, 'Quarto simples com cama de solteiro'),
('301', 'Duplo',    250.00, 'disponivel', 2, 'Quarto duplo com varanda');

INSERT INTO reserva (id_hospede, id_quarto, id_funcionario, data_checkin, data_checkout, status, valor_total) VALUES
(1, 1, 1, '2025-06-01', '2025-06-05', 'confirmada',  600.00),
(2, 2, 1, '2025-06-03', '2025-06-07', 'confirmada', 1000.00),
(3, 3, 2, '2025-06-10', '2025-06-12', 'confirmada',  900.00),
(4, 4, 3, '2025-06-15', '2025-06-16', 'confirmada',  150.00),
(5, 5, 3, '2025-06-20', '2025-06-25', 'confirmada', 1250.00);

INSERT INTO hospedagem (id_reserva, id_funcionario, checkin_real, checkout_real, observacoes) VALUES
(1, 1, '2025-06-01 14:00:00', '2025-06-05 12:00:00', 'Hóspede solicitou berço extra'),
(2, 1, '2025-06-03 15:30:00', '2025-06-07 11:00:00', 'Sem observações'),
(3, 2, '2025-06-10 13:00:00', '2025-06-12 10:00:00', 'Hóspede chegou mais cedo'),
(4, 3, '2025-06-15 16:00:00', '2025-06-16 12:00:00', 'Sem observações'),
(5, 3, '2025-06-20 14:00:00', '2025-06-25 11:00:00', 'Hóspede pediu quarto silencioso');

INSERT INTO pagamento (id_hospedagem, valor, metodo, status) VALUES
(1,  600.00, 'cartao',  'aprovado'),
(2, 1000.00, 'pix',     'aprovado'),
(3,  900.00, 'cartao',  'aprovado'),
(4,  150.00, 'dinheiro','aprovado'),
(5,  625.00, 'pix',     'aprovado'),
(5,  625.00, 'cartao',  'aprovado');
# o pagamento 5 tem 2 formas de pagamento para combinar com o diagrama (regra de negocio) (1..*)

INSERT INTO avaliacao (id_hospedagem, id_hospede, nota, comentario) VALUES
(1, 1, 5, 'Ótima estadia, equipe muito atenciosa!'),
(2, 2, 4, 'Quarto confortável, café da manhã poderia ser melhor.'),
(3, 3, 5, 'Adorei a suite, com certeza voltarei!'),
(4, 4, 3, 'Quarto pequeno mas limpo e organizado.'),
(5, 5, 5, 'Melhor hotel que já me hospedei, recomendo!');

#Parte 3: Radar de Comando
#consultas e extraçaõ de dados
SELECT * FROM quarto WHERE status = 'disponivel';

SELECT id_hospede, COUNT(*) AS total_reservas
FROM reserva
GROUP BY id_hospede
ORDER BY total_reservas DESC;

SELECT MONTH(data_pagamento) AS mes, SUM(valor) AS faturamento
FROM pagamento
GROUP BY mes;

SELECT id_quarto, AVG(nota) AS media_nota
FROM avaliacao
JOIN hospedagem ON avaliacao.id_hospedagem = hospedagem.id_hospedagem
JOIN reserva ON hospedagem.id_reserva = reserva.id_reserva
GROUP BY id_quarto
ORDER BY media_nota DESC;

SELECT * FROM reserva WHERE status = 'cancelada';

SELECT id_funcionario, COUNT(*) AS total_hospedagens
FROM hospedagem
GROUP BY id_funcionario
ORDER BY total_hospedagens DESC;