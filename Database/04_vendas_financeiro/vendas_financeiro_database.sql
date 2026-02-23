-- Módulo 04 – Vendas
-- SGBD: PostgreSQL

-- Tabela: tb_cupons
CREATE TABLE IF NOT EXISTS tb_cupons (
    id_cupom SERIAL PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL UNIQUE,
    percentual_desconto INT CHECK (percentual_desconto >= 0 AND percentual_desconto <= 100),
    data_validade DATE
);

--Tabela: tb_pedidos
CREATE TABLE IF NOT EXISTS tb_pedidos (
    id_pedido SERIAL PRIMARY KEY,
    id_comprador_discord BIGINT NOT NULL,
    id_cupom INT,
    valor_total INT NOT NULL,
    status_pagamento VARCHAR(20) NOT NULL CHECK (status_pagamento IN ('Pendente', 'Pago', 'Cancelado'))
);

--Tabela: tb_itens_pedido
CREATE TABLE IF NOT EXISTS tb_itens_pedido (
    id_item_pedido SERIAL PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL CHECK (quantidade > 0)
);


--Tabela: tb_pagamentos_pix
CREATE TABLE IF NOT EXISTS tb_pagamentos_pix (
    id_pagamento SERIAL PRIMARY KEY,
    id_pedido INT NOT NULL UNIQUE,
    codigo_copia_cola TEXT NOT NULL,
    confirmado BOOLEAN DEFAULT FALSE,
    txid VARCHAR(100) UNIQUE,
    expiracao_pagamento TIMESTAMP,
    id_cargo_recompensa INT
);
