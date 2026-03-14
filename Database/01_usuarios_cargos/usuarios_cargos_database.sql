CREATE TABLE utilizadores (
    id BIGINT PRIMARY KEY,
    nome_utilizador VARCHAR(100) NOT NULL,
    tag_discord VARCHAR(10) NOT NULL,
    data_registo TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE cargos (
    id SERIAL PRIMARY KEY,
    nome_cargo VARCHAR(50) NOT NULL UNIQUE,
    id_cargo_discord BIGINT NOT NULL
);

CREATE TABLE utilizador_cargos (
    id SERIAL PRIMARY KEY,
    utilizador_id BIGINT NOT NULL,
    cargo_id INTEGER NOT NULL,
    FOREIGN KEY (utilizador_id) REFERENCES utilizadores(id) ON DELETE CASCADE,
    FOREIGN KEY (cargo_id) REFERENCES cargos(id) ON DELETE CASCADE,
    UNIQUE (utilizador_id, cargo_id)
);

CREATE TABLE permissoes (
    id SERIAL PRIMARY KEY,
    cargo_id INTEGER NOT NULL,
    chave_permissao VARCHAR(100) NOT NULL,
    FOREIGN KEY (cargo_id) REFERENCES cargos(id) ON DELETE CASCADE,
    UNIQUE (cargo_id, chave_permissao)
);

INSERT INTO cargos (nome_cargo, id_cargo_discord)
VALUES ('Admin', 123456789);

INSERT INTO utilizadores (id, nome_utilizador, tag_discord)
VALUES (111111111111111111, 'Icaro', '1234');

INSERT INTO utilizador_cargos (utilizador_id, cargo_id)
VALUES (111111111111111111, 1); 

INSERT INTO permissoes (cargo_id, chave_permissao)
VALUES 
(1, 'gestao_utilizadores'),
(1, 'criar_produto'),
(1, 'fechar_ticket'),
(1, 'aplicar_reembolso');
