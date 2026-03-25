-- ======================================================================
-- 1) DROP TABLES 
-- ======================================================================
DROP TABLE IF EXISTS reembolsos_revogacoes;
DROP TABLE IF EXISTS pagamentos;
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



CREATE TABLE cupons ( 
    codigo SERIAL PRIMARY KEY, 
    chave_cupom VARCHAR(50) NOT NULL UNIQUE, 
    percentual_desconto INT CHECK (percentual_desconto >= 0 AND percentual_desconto <= 100), 
    data_validade DATE 
);

CREATE TABLE utilizador_cargos ( 
    usuario_uid BIGINT NOT NULL, 
    cargo_codigo INTEGER NOT NULL, 
    PRIMARY KEY (usuario_uid, cargo_codigo), 
    CONSTRAINT fk_uc_usuario FOREIGN KEY (usuario_uid) REFERENCES utilizadores(discord_uid) ON DELETE CASCADE, 
    CONSTRAINT fk_uc_cargo FOREIGN KEY (cargo_codigo) REFERENCES cargos(codigo) ON DELETE CASCADE 
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
    numero SERIAL PRIMARY KEY, 
    comprador_uid BIGINT NOT NULL, 
    cupom_codigo INT, 
    valor_final INT NOT NULL, 
    status_pedido VARCHAR(20) NOT NULL CHECK (status_pedido IN ('Pendente', 'Pago', 'Cancelado')), 
    CONSTRAINT fk_pedido_comprador FOREIGN KEY (comprador_uid) REFERENCES utilizadores(discord_uid) ON DELETE CASCADE, 
    CONSTRAINT fk_pedido_cupom FOREIGN KEY (cupom_codigo) REFERENCES cupons(codigo) ON DELETE SET NULL 
);

CREATE TABLE blacklist ( 
    codigo SERIAL PRIMARY KEY, 
    banido_uid BIGINT NOT NULL UNIQUE, 
    motivo_banimento TEXT, 
    data_banimento TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    CONSTRAINT fk_blacklist_user FOREIGN KEY (banido_uid) REFERENCES utilizadores(discord_uid) ON DELETE CASCADE 
);

CREATE TABLE produto_imagens ( 
    codigo SERIAL PRIMARY KEY, 
    produto_codigo INT NOT NULL, 
    url_imagem VARCHAR(255) NOT NULL, 
    CONSTRAINT fk_imagem_produto FOREIGN KEY (produto_codigo) REFERENCES produtos(codigo) ON DELETE CASCADE 
);

CREATE TABLE stock_digital ( 
    codigo SERIAL PRIMARY KEY, 
    produto_codigo INT NOT NULL, 
    conteudo_entrega TEXT NOT NULL, 
    foi_vendido BOOLEAN DEFAULT FALSE, 
    CONSTRAINT fk_stock_produto FOREIGN KEY (produto_codigo) REFERENCES produtos(codigo) ON DELETE CASCADE 
);

CREATE TABLE mensagens_ticket ( 
    codigo SERIAL PRIMARY KEY, 
    ticket_numero INT NOT NULL, 
    autor_uid BIGINT NOT NULL, 
    conteudo_mensagem TEXT NOT NULL, 
    data_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    CONSTRAINT fk_mensagem_ticket FOREIGN KEY (ticket_numero) REFERENCES tickets(numero) ON DELETE CASCADE, 
    CONSTRAINT fk_mensagem_autor FOREIGN KEY (autor_uid) REFERENCES utilizadores(discord_uid) ON DELETE CASCADE 
);


CREATE TABLE avaliacoes_atendimento ( 
    codigo SERIAL PRIMARY KEY, 
    ticket_numero INT NOT NULL UNIQUE, 
    nota_avaliacao INT CHECK (nota_avaliacao BETWEEN 1 AND 5), 
    comentario TEXT, 
    CONSTRAINT fk_ticket_avaliacao FOREIGN KEY (ticket_numero) REFERENCES tickets(numero) ON DELETE CASCADE 
);

CREATE TABLE itens_pedido ( 
    codigo SERIAL PRIMARY KEY, 
    pedido_numero INT NOT NULL, 
    produto_codigo INT NOT NULL, 
    quantidade_comprada INT NOT NULL CHECK (quantidade_comprada > 0), 
    CONSTRAINT fk_item_pedido FOREIGN KEY (pedido_numero) REFERENCES pedidos(numero) ON DELETE CASCADE, 
    CONSTRAINT fk_item_produto FOREIGN KEY (produto_codigo) REFERENCES produtos(codigo) ON DELETE RESTRICT 
);

CREATE TABLE pagamentos ( 
    codigo SERIAL PRIMARY KEY, 
    pedido_numero INT NOT NULL UNIQUE, 
    forma_codigo INT NOT NULL, 
    codigo_transacao VARCHAR(100) UNIQUE, 
    status_pagamento VARCHAR(20) DEFAULT 'Pendente' CHECK (status_pagamento IN ('Pendente', 'Aprovado', 'Recusado')), 
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    CONSTRAINT fk_pagamento_pedido FOREIGN KEY (pedido_numero) REFERENCES pedidos(numero) ON DELETE CASCADE,
    CONSTRAINT fk_pagamento_forma FOREIGN KEY (forma_codigo) REFERENCES formas_pagamento(codigo) ON DELETE RESTRICT
);

CREATE TABLE reembolsos_revogacoes ( 
    codigo SERIAL PRIMARY KEY, 
    pedido_numero INT NOT NULL UNIQUE, 
    motivo_reembolso TEXT, 
    status_reembolso VARCHAR(20) NOT NULL CHECK (status_reembolso IN ('Aprovado', 'Negado', 'Pendente')), 
    CONSTRAINT fk_reembolso_pedido FOREIGN KEY (pedido_numero) REFERENCES pedidos(numero) ON DELETE CASCADE 
);
