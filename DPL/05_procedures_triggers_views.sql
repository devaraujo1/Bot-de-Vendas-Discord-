-- ====================================================================================
-- SCRIPT DPL: PROCEDURES, TRIGGERS, FUNCTIONS E VIEWS
-- Projeto: Bot de Vendas Discord — Parte 05
-- PostgreSQL
-- ====================================================================================

-- 0) DROP (ordem inversa de dependência)
DROP VIEW IF EXISTS ProdutosMaisPopulares;
DROP VIEW IF EXISTS TicketsPendentesModeracao;
DROP VIEW IF EXISTS DashboardVendasAtivas;

DROP TRIGGER IF EXISTS trg_verificar_bloqueio_usuario ON pedidos;
DROP TRIGGER IF EXISTS trg_auto_fechar_ticket ON mensagens_ticket;
DROP TRIGGER IF EXISTS trg_log_auditoria_produtos ON produtos;
DROP TRIGGER IF EXISTS trg_log_auditoria_permissoes ON permissoes;

DROP FUNCTION IF EXISTS fn_verificar_bloqueio_usuario();
DROP FUNCTION IF EXISTS fn_auto_fechar_ticket();
DROP FUNCTION IF EXISTS fn_log_auditoria_admin();

DROP FUNCTION IF EXISTS TempoMedioRespostaTicket();
DROP FUNCTION IF EXISTS TotalVendidoNoMes();
DROP FUNCTION IF EXISTS VerificarNivelAcesso(BIGINT, VARCHAR);

DROP PROCEDURE IF EXISTS AtribuirCargoAutomatico(BIGINT, INT);
DROP PROCEDURE IF EXISTS ProcessarReembolso(INT, TEXT, BIGINT);
DROP PROCEDURE IF EXISTS GerarVendaPix(BIGINT, INT);

-- 1) FUNCTIONS
CREATE OR REPLACE FUNCTION VerificarNivelAcesso(
    p_usuario_uid BIGINT,
    p_chave_permissao VARCHAR
)
RETURNS BOOLEAN
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN EXISTS (
        SELECT 1
        FROM utilizador_cargos uc
        INNER JOIN permissoes perm ON uc.cargo_codigo = perm.cargo_codigo
        WHERE uc.usuario_uid = p_usuario_uid
          AND perm.chave_permissao = p_chave_permissao
    );
END;
$$;

COMMENT ON FUNCTION VerificarNivelAcesso(BIGINT, VARCHAR) IS
'Retorna TRUE se o usuário possui a permissão informada via seus cargos.';

CREATE OR REPLACE FUNCTION TotalVendidoNoMes()
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    v_total INT;
BEGIN
    SELECT COALESCE(SUM(p.valor_final), 0)
    INTO v_total
    FROM pedidos p
    INNER JOIN pagamentos pag ON p.numero = pag.pedido_numero
    WHERE p.status_pedido = 'Pago'
      AND DATE_TRUNC('month', pag.data_atualizacao) = DATE_TRUNC('month', CURRENT_TIMESTAMP);

    RETURN v_total;
END;
$$;

COMMENT ON FUNCTION TotalVendidoNoMes() IS
'Soma o valor_final de todos os pedidos com status Pago no mês corrente.';

CREATE OR REPLACE FUNCTION TempoMedioRespostaTicket()
RETURNS INTERVAL
LANGUAGE plpgsql
AS $$
DECLARE
    v_media INTERVAL;
BEGIN
    SELECT AVG(data_fechamento - data_abertura)
    INTO v_media
    FROM tickets
    WHERE data_fechamento IS NOT NULL
      AND status_ticket IN ('FECHADO', 'Resolvido');

    RETURN COALESCE(v_media, INTERVAL '0');
END;
$$;

COMMENT ON FUNCTION TempoMedioRespostaTicket() IS
'Calcula a média de tempo entre abertura e fechamento dos tickets encerrados.';

-- 2)PROCEDURES


CREATE OR REPLACE PROCEDURE GerarVendaPix(
    p_comprador_uid BIGINT,
    p_valor_final INT,
    OUT p_pedido_numero INT,
    OUT p_codigo_transacao VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_forma_pix INT;
BEGIN
    SELECT codigo INTO v_forma_pix
    FROM formas_pagamento
    WHERE descricao_forma = 'PIX'
    LIMIT 1;

    INSERT INTO pedidos (comprador_uid, valor_final, status_pedido)
    VALUES (p_comprador_uid, p_valor_final, 'Pendente')
    RETURNING numero INTO p_pedido_numero;

    p_codigo_transacao := 'PIX-' || EXTRACT(EPOCH FROM NOW())::BIGINT;

    INSERT INTO pagamentos (pedido_numero, forma_codigo, codigo_transacao, status_pagamento)
    VALUES (p_pedido_numero, v_forma_pix, p_codigo_transacao, 'Pendente');
END;
$$;

COMMENT ON PROCEDURE GerarVendaPix(BIGINT, INT) IS
'Cria registro de venda pendente e gera código simulado de transação PIX.';


CREATE OR REPLACE PROCEDURE ProcessarReembolso(
    p_pedido_numero INT,
    p_motivo TEXT,
    p_admin_uid BIGINT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE pedidos
    SET status_pedido = 'Reembolsado'
    WHERE numero = p_pedido_numero;

    INSERT INTO reembolsos_revogacoes (pedido_numero, motivo_reembolso, status_reembolso)
    VALUES (p_pedido_numero, p_motivo, 'Aprovado')
    ON CONFLICT (pedido_numero) DO UPDATE
    SET motivo_reembolso = EXCLUDED.motivo_reembolso,
        status_reembolso = 'Aprovado';

    INSERT INTO logs_auditoria (admin_uid, tabela_afetada, registro_id, acao, detalhes)
    VALUES (
        p_admin_uid,
        'pedidos',
        p_pedido_numero,
        'REEMBOLSAR',
        'Reembolso processado: ' || p_motivo
    );
END;
$$;

COMMENT ON PROCEDURE ProcessarReembolso(INT, TEXT, BIGINT) IS
'Altera status do pedido para Reembolsado e registra auditoria da ação.';


CREATE OR REPLACE PROCEDURE AtribuirCargoAutomatico(
    p_usuario_uid BIGINT,
    p_pedido_numero INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_status VARCHAR(20);
    v_cargo_vip INT;
BEGIN
    SELECT status_pedido INTO v_status
    FROM pedidos
    WHERE numero = p_pedido_numero;

    IF v_status IS DISTINCT FROM 'Pago' THEN
        RAISE EXCEPTION 'Pedido % não está confirmado (status atual: %)', p_pedido_numero, v_status;
    END IF;

    SELECT codigo INTO v_cargo_vip
    FROM cargos
    WHERE nome_cargo = 'Comprador VIP'
    LIMIT 1;

    INSERT INTO utilizador_cargos (usuario_uid, cargo_codigo)
    VALUES (p_usuario_uid, v_cargo_vip)
    ON CONFLICT (usuario_uid, cargo_codigo) DO NOTHING;
END;
$$;

COMMENT ON PROCEDURE AtribuirCargoAutomatico(BIGINT, INT) IS
'Atribui cargo Comprador VIP ao usuário após confirmação de compra.';

