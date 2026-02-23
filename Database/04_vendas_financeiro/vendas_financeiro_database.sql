-- Módulo 04 – Vendas
-- SGBD: PostgreSQL


CREATE TABLE IF NOT EXISTS tb_cupons (
    id_cupom SERIAL PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL UNIQUE,
    percentual_desconto INT CHECK (percentual_desconto >= 0 AND percentual_desconto <= 100),
    data_validade DATE
);

CREATE TABLE IF NOT EXISTS tb_pedidos (
    id_pedido SERIAL PRIMARY KEY,
    id_comprador_discord BIGINT NOT NULL,
    id_cupom INT,
    valor_total INT NOT NULL,
    status_pagamento VARCHAR(20) NOT NULL CHECK (status_pagamento IN ('Pendente', 'Pago', 'Cancelado'))
);


CREATE TABLE IF NOT EXISTS tb_itens_pedido (
    id_item_pedido SERIAL PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL CHECK (quantidade > 0)
);
