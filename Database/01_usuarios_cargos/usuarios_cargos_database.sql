CREATE TABLE tb_utilizadores (
    id_discord BIGINT PRIMARY KEY,
    nome_utilizador VARCHAR(100) NOT NULL,
    tag_discord VARCHAR(10) NOT NULL,
    data_registo TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tb_cargos (
    id_cargo SERIAL PRIMARY KEY,
    nome_cargo VARCHAR(50) NOT NULL UNIQUE,
    id_cargo_discord BIGINT NOT NULL
);

CREATE TABLE tb_utilizador_cargos (
    id_discord BIGINT NOT NULL,
    id_cargo INTEGER NOT NULL,
    PRIMARY KEY (id_discord, id_cargo),
    FOREIGN KEY (id_discord)
        REFERENCES tb_utilizadores(id_discord)
        ON DELETE CASCADE,
    FOREIGN KEY (id_cargo)
        REFERENCES tb_cargos(id_cargo)
        ON DELETE CASCADE
);

CREATE TABLE tb_permissoes (
    id_permissao SERIAL PRIMARY KEY,
    id_cargo INTEGER NOT NULL,
    chave_permissao VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_cargo)
        REFERENCES tb_cargos(id_cargo)
        ON DELETE CASCADE,
    UNIQUE (id_cargo, chave_permissao)
);

INSERT INTO tb_cargos (nome_cargo, id_cargo_discord)
VALUES ('Admin', 123456789);

INSERT INTO tb_utilizadores (id_discord, nome_utilizador, tag_discord)
VALUES (111111111111111111, 'Icaro', '1234');

INSERT INTO tb_utilizador_cargos (id_discord, id_cargo)
VALUES (111111111111111111, 2);

INSERT INTO tb_permissoes (id_cargo, chave_permissao)
VALUES 
(2, 'gestao_utilizadores'),
(2, 'criar_produto'),
(2, 'fechar_ticket'),
(2, 'aplicar_reembolso');

SELECT p.chave_permissao
FROM tb_utilizadores u
JOIN tb_utilizador_cargos uc ON u.id_discord = uc.id_discord
JOIN tb_cargos c ON uc.id_cargo = c.id_cargo
JOIN tb_permissoes p ON c.id_cargo = p.id_cargo
WHERE u.id_discord = 111111111111111111;

SELECT 1
FROM tb_utilizador_cargos uc
JOIN tb_permissoes p ON uc.id_cargo = p.id_cargo
WHERE uc.id_discord = 111111111111111111
AND p.chave_permissao = 'aplicar_reembolso';
