-- ======================================================================
-- 1) DROP TABLES 
-- ======================================================================
DROP TABLE IF EXISTS reembolsos_revogacoes;
DROP TABLE IF EXISTS pagamentos_pix;
DROP TABLE IF EXISTS itens_pedido;
DROP TABLE IF EXISTS avaliacoes_atendimento;
DROP TABLE IF EXISTS mensagens_ticket;
DROP TABLE IF EXISTS stock_digital;
DROP TABLE IF EXISTS produto_imagens;
DROP TABLE IF EXISTS blacklist;
DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS produtos;
DROP TABLE IF EXISTS permissoes;
DROP TABLE IF EXISTS utilizador_cargos;
DROP TABLE IF EXISTS cupons;
DROP TABLE IF EXISTS tipos_ticket;
DROP TABLE IF EXISTS formas_pagamento;
DROP TABLE IF EXISTS categorias;
DROP TABLE IF EXISTS cargos;
DROP TABLE IF EXISTS utilizadores;

-- ======================================================================
-- 2) CREATE TABLES 
-- ======================================================================

CREATE TABLE utilizadores ( 
    discord_uid BIGINT PRIMARY KEY, 
    nome_usuario VARCHAR(100) NOT NULL, 
    tag_usuario VARCHAR(10) NOT NULL, 
    data_registo TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP 
);

CREATE TABLE cargos ( 
    codigo SERIAL PRIMARY KEY, 
    nome_cargo VARCHAR(50) NOT NULL UNIQUE, 
    discord_role_uid BIGINT NOT NULL UNIQUE
);

CREATE TABLE categorias (
    codigo SERIAL PRIMARY KEY, 
    nome_categoria VARCHAR(100) NOT NULL, 
    descricao_categoria TEXT 
);

CREATE TABLE formas_pagamento (
    codigo SERIAL PRIMARY KEY, 
    descricao_forma VARCHAR(50) NOT NULL UNIQUE 
);

CREATE TABLE tipos_ticket (
    codigo SERIAL PRIMARY KEY, 
    nome_tipo VARCHAR(100) NOT NULL, 
    descricao_tipo VARCHAR(255) 
);

CREATE TABLE cupons ( 
    codigo SERIAL PRIMARY KEY, 
    chave_cupom VARCHAR(50) NOT NULL UNIQUE, 
    percentual_desconto INT CHECK (percentual_desconto >= 0 AND percentual_desconto <= 100), 
    data_validade DATE 
);


CREATE TABLE permissoes ( 
    codigo SERIAL PRIMARY KEY, 
    cargo_codigo INTEGER NOT NULL, 
    chave_permissao VARCHAR(100) NOT NULL, 
    CONSTRAINT fk_perm_cargo FOREIGN KEY (cargo_codigo) REFERENCES cargos(codigo) ON DELETE CASCADE, 
    UNIQUE (cargo_codigo, chave_permissao) 
);

CREATE TABLE produtos ( 
    codigo SERIAL PRIMARY KEY, 
    categoria_codigo INT NOT NULL, 
    nome_produto VARCHAR(150) NOT NULL, 
    preco_centavos INT NOT NULL CHECK (preco_centavos > 0), 
    CONSTRAINT fk_produto_categoria FOREIGN KEY (categoria_codigo) REFERENCES categorias(codigo) ON DELETE RESTRICT 
);

CREATE TABLE utilizador_cargos ( 
    usuario_uid BIGINT NOT NULL, 
    cargo_codigo INTEGER NOT NULL, 
    PRIMARY KEY (usuario_uid, cargo_codigo), 
    CONSTRAINT fk_uc_usuario FOREIGN KEY (usuario_uid) REFERENCES utilizadores(discord_uid) ON DELETE CASCADE, 
    CONSTRAINT fk_uc_cargo FOREIGN KEY (cargo_codigo) REFERENCES cargos(codigo) ON DELETE CASCADE 
);

CREATE TABLE tickets ( 
    numero SERIAL PRIMARY KEY, 
    canal_discord_uid BIGINT NOT NULL UNIQUE, 
    dono_uid BIGINT NOT NULL, 
    tipo_codigo INT NOT NULL, 
    status_ticket VARCHAR(50) DEFAULT 'ABERTO' CHECK (status_ticket IN ('ABERTO', 'EM ANÁLISE', 'FECHADO')), 
    data_abertura TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    data_fechamento TIMESTAMP NULL, 
    CONSTRAINT fk_ticket_tipo FOREIGN KEY (tipo_codigo) REFERENCES tipos_ticket(codigo) ON DELETE RESTRICT, 
    CONSTRAINT fk_ticket_dono FOREIGN KEY (dono_uid) REFERENCES utilizadores(discord_uid) ON DELETE CASCADE 
);

CREATE TABLE pedidos ( 
    id_pedido SERIAL PRIMARY KEY, 
    id_comprador_discord BIGINT NOT NULL, 
    id_cupom INT, 
    valor_total INT NOT NULL, 
    status_pagamento VARCHAR(20) NOT NULL CHECK (status_pagamento IN ('Pendente', 'Pago', 'Cancelado')), 
    CONSTRAINT fk_pedido_comprador FOREIGN KEY (id_comprador_discord) REFERENCES utilizadores(id_discord) ON DELETE CASCADE, 
    CONSTRAINT fk_pedido_cupom FOREIGN KEY (id_cupom) REFERENCES cupons(id_cupom) ON DELETE SET NULL 
);

CREATE TABLE blacklist ( 
    id_blacklist SERIAL PRIMARY KEY, 
    id_discord_banido BIGINT NOT NULL UNIQUE, 
    motivo TEXT, 
    data_banimento TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    CONSTRAINT fk_blacklist_user FOREIGN KEY (id_discord_banido) REFERENCES utilizadores(id_discord) ON DELETE CASCADE 
);

CREATE TABLE produto_imagens ( 
    id_imagem SERIAL PRIMARY KEY, 
    id_produto INT NOT NULL, 
    url_imagem VARCHAR(255) NOT NULL, 
    CONSTRAINT fk_imagem_produto FOREIGN KEY (id_produto) REFERENCES produtos(id_produto) ON DELETE CASCADE 
);

CREATE TABLE stock_digital ( 
    id_item SERIAL PRIMARY KEY, 
    id_produto INT NOT NULL, 
    conteudo_entrega TEXT NOT NULL, 
    vendido BOOLEAN DEFAULT FALSE, 
    CONSTRAINT fk_stock_produto FOREIGN KEY (id_produto) REFERENCES produtos(id_produto) ON DELETE CASCADE 
);

CREATE TABLE mensagens_ticket (
    id_ticket INT NOT NULL,
    id_autor_discord BIGINT NOT NULL,
    conteudo TEXT NOT NULL,
    data_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_ticket, id_autor_discord, data_envio),
    FOREIGN KEY (id_ticket) REFERENCES tickets(id_ticket)
);


CREATE TABLE avaliacoes_atendimento (
    id_ticket INT NOT NULL,
    nota INT CHECK (nota BETWEEN 1 AND 5),
    comentario TEXT,
    PRIMARY KEY (id_ticket),
    FOREIGN KEY (id_ticket) REFERENCES tickets(id_ticket)
);

CREATE TABLE itens_pedido ( 
    id_item_pedido SERIAL PRIMARY KEY, 
    id_pedido INT NOT NULL, 
    id_produto INT NOT NULL, 
    quantidade INT NOT NULL CHECK (quantidade > 0), 
    CONSTRAINT fk_item_pedido FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido) ON DELETE CASCADE, 
    CONSTRAINT fk_item_produto FOREIGN KEY (id_produto) REFERENCES produtos(id_produto) ON DELETE RESTRICT 
);

CREATE TABLE pagamentos_pix ( 
    id_pagamento SERIAL PRIMARY KEY, 
    id_pedido INT NOT NULL UNIQUE, 
    codigo_copia_cola TEXT NOT NULL, 
    confirmado BOOLEAN DEFAULT FALSE, 
    txid VARCHAR(100) UNIQUE, 
    expiracao_pagamento TIMESTAMP, 
    id_cargo_recompensa INT, 
    CONSTRAINT fk_pix_pedido FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido) ON DELETE CASCADE, 
    CONSTRAINT fk_pix_cargo FOREIGN KEY (id_cargo_recompensa) REFERENCES cargos(id_cargo) ON DELETE SET NULL 
);

CREATE TABLE reembolsos_revogacoes ( 
    id_reembolso SERIAL PRIMARY KEY, 
    id_pedido INT NOT NULL, 
    motivo TEXT, 
    status_reembolso VARCHAR(20) NOT NULL CHECK (status_reembolso IN ('Aprovado', 'Negado', 'Pendente')), 
    CONSTRAINT fk_reembolso_pedido FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido) ON DELETE CASCADE 
);
