DROP TABLE IF EXISTS permissoes;
DROP TABLE IF EXISTS utilizador_cargos;
DROP TABLE IF EXISTS cargos;
DROP TABLE IF EXISTS utilizadores;

CREATE TABLE utilizadores ( 
    id SERIAL PRIMARY KEY, 
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
    id_discord BIGINT NOT NULL,
    id_cargo INTEGER NOT NULL,
    PRIMARY KEY (id_discord, id_cargo),  
    CONSTRAINT fk_uc_utilizador FOREIGN KEY (id_discord) REFERENCES utilizadores(id_discord) ON DELETE CASCADE, 
    CONSTRAINT fk_uc_cargo FOREIGN KEY (id_cargo) REFERENCES cargos(id) ON DELETE CASCADE
    UNIQUE (id_doscprd, id_cargo)
);

CREATE TABLE permissoes ( 
    id SERIAL PRIMARY KEY, 
    id_cargo INTEGER NOT NULL, 
    chave_permissao VARCHAR(100) NOT NULL, 
    CONSTRAINT fk_perm_cargo FOREIGN KEY (id_cargo) REFERENCES cargos(id) ON DELETE CASCADE, 
    UNIQUE (id_cargo, chave_permissao) 
);

-- ======================================================================
-- INSERTS: MÓDULO 01
-- ======================================================================

-- 3 Cargos (Tabela Auxiliar)
INSERT INTO cargos (nome_cargo, id_cargo_discord) VALUES 
('Admin', 900000000000000001), 
('Suporte', 900000000000000002), 
('Comprador VIP', 900000000000000003);

-- 30 Utilizadores (Tabela Core)
INSERT INTO utilizadores (id_discord, nome_utilizador, tag_discord) 
SELECT (100000000000000000 + gs)::bigint, 'Usuario ' || gs, lpad((gs % 9999 + 1)::text, 4, '0') 
FROM generate_series(1, 30) AS gs;

-- 30 Atribuições de Cargos
INSERT INTO utilizador_cargos (id_discord, id_cargo)
SELECT (100000000000000000 + gs)::bigint, ((gs % 3) + 1)::int 
FROM generate_series(1, 30) AS gs;

-- 3 Permissões (Tabela Auxiliar)
INSERT INTO permissoes (id_cargo, chave_permissao) VALUES 
(1, 'banir_utilizador'), 
(1, 'criar_produto'), 
(2, 'fechar_ticket');
