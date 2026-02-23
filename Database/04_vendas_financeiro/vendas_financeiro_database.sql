-- Módulo 04 – Vendas
-- SGBD: PostgreSQL


CREATE TABLE IF NOT EXISTS tb_cupons (
    id_cupom SERIAL PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL UNIQUE,
    percentual_desconto INT CHECK (percentual_desconto >= 0 AND percentual_desconto <= 100),
    data_validade DATE
);
