-- GymControl — Banco de dados básico (modelagem, sem conexão com o React)
-- Restrição individual: relacionamento 1:N entre setor e equipamento e entre equipamento e alteração de status.

CREATE TABLE setor (
  id INTEGER PRIMARY KEY,
  nome VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE equipamento (
  id INTEGER PRIMARY KEY,
  setor_id INTEGER NOT NULL,
  nome VARCHAR(100) NOT NULL,
  grupo_muscular VARCHAR(80) NOT NULL,
  localizacao VARCHAR(120) NOT NULL,
  status VARCHAR(20) NOT NULL CHECK (status IN ('Liberado', 'Em uso', 'Em manutenção')),
  motivo_manutencao VARCHAR(255),
  CONSTRAINT fk_equipamento_setor FOREIGN KEY (setor_id) REFERENCES setor(id)
);

CREATE TABLE alteracao_status (
  id INTEGER PRIMARY KEY,
  equipamento_id INTEGER NOT NULL,
  status_anterior VARCHAR(20),
  status_novo VARCHAR(20) NOT NULL CHECK (status_novo IN ('Liberado', 'Em uso', 'Em manutenção')),
  motivo VARCHAR(255),
  alterado_em TIMESTAMP NOT NULL,
  CONSTRAINT fk_alteracao_equipamento FOREIGN KEY (equipamento_id) REFERENCES equipamento(id)
);

-- Cardinalidades: setor 1:N equipamento; equipamento 1:N alteracao_status.

INSERT INTO setor (id, nome) VALUES
  (1, 'Sala de Musculação'),
  (2, 'Sala de Pernas'),
  (3, 'Área de Cardio');

INSERT INTO equipamento (id, setor_id, nome, grupo_muscular, localizacao, status, motivo_manutencao) VALUES
  (1, 1, 'Supino Reto', 'Peito', 'Sala de Musculação', 'Liberado', NULL),
  (2, 2, 'Leg Press 45°', 'Pernas', 'Sala de Pernas', 'Em uso', NULL),
  (3, 1, 'Puxada Alta', 'Costas', 'Sala de Musculação', 'Liberado', NULL),
  (4, 2, 'Cadeira Extensora', 'Quadríceps', 'Sala de Pernas', 'Em manutenção', 'Cabo de aço com desgaste'),
  (5, 1, 'Rosca Scott', 'Bíceps', 'Sala de Musculação', 'Liberado', NULL),
  (6, 1, 'Remada Baixa', 'Costas', 'Sala de Musculação', 'Em uso', NULL);

INSERT INTO alteracao_status (id, equipamento_id, status_anterior, status_novo, motivo, alterado_em) VALUES
  (1, 2, 'Liberado', 'Em uso', NULL, '2026-09-17 07:40:00'),
  (2, 4, 'Em uso', 'Em manutenção', 'Cabo de aço com desgaste', '2026-09-17 06:55:00'),
  (3, 6, 'Liberado', 'Em uso', NULL, '2026-09-17 07:50:00');
