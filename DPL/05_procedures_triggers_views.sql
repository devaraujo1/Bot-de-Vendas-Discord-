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
