-- DDL (Data Definition Language)

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


-- DML (Data Manipulation Language)

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


-- DQL (Data Query Language)

-- INNER JOIN: Exibir o nome do usuário e o cargo atribuído
SELECT 
    u.nome_utilizador,
    c.nome_cargo
FROM utilizadores u
INNER JOIN utilizador_cargos uc 
    ON u.id = uc.utilizador_id
INNER JOIN cargos c 
    ON uc.cargo_id = c.id;


-- LEFT JOIN: Listar todos os cargos e os usuários vinculados (incluindo cargos vazios)
SELECT 
    c.nome_cargo,
    u.nome_utilizador
FROM cargos c
LEFT JOIN utilizador_cargos uc 
    ON c.id = uc.cargo_id
LEFT JOIN utilizadores u 
    ON uc.utilizador_id = u.id;


-- RIGHT JOIN: Mostrar todos os cargos e os usuários associados (incluindo usuários sem cargo)
SELECT 
    u.nome_utilizador,
    c.nome_cargo
FROM utilizadores u
RIGHT JOIN utilizador_cargos uc 
    ON u.id = uc.utilizador_id
RIGHT JOIN cargos c 
    ON uc.cargo_id = c.id;


-- INNER JOIN: Relacionar cargos com suas permissões
SELECT 
    c.nome_cargo,
    p.chave_permissao
FROM cargos c
INNER JOIN permissoes p 
    ON c.id = p.cargo_id;
