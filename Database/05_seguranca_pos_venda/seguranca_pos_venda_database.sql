-- Módulo 05 – Segurança e Pós-venda
-- SGBD: PostgreSQL


CREATE TABLE IF NOT EXISTS tb_reembolsos_revogacoes (
    id_reembolso SERIAL PRIMARY KEY,
    id_pedido INT NOT NULL,
    motivo TEXT,
    status_reembolso VARCHAR(20) NOT NULL CHECK (status_reembolso IN ('Aprovado', 'Negado', 'Pendente'))
);
