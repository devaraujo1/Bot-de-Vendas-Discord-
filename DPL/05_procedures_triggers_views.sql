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

-- 2) TRIGGERS
CREATE OR REPLACE FUNCTION fn_log_auditoria_admin()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_admin_uid BIGINT;
    v_acao VARCHAR(50);
    v_registro_id INT;
    v_detalhes TEXT;
BEGIN
    BEGIN
        v_admin_uid := current_setting('app.admin_uid', true)::BIGINT;
    EXCEPTION WHEN OTHERS THEN
        RETURN COALESCE(NEW, OLD);
    END;

    IF v_admin_uid IS NULL THEN
        RETURN COALESCE(NEW, OLD);
    END IF;

    IF TG_OP = 'UPDATE' THEN
        v_acao := 'EDITAR';
        v_registro_id := NEW.codigo;
        v_detalhes := 'Registro atualizado na tabela ' || TG_TABLE_NAME;
    ELSIF TG_OP = 'DELETE' THEN
        v_acao := 'REMOVER';
        v_registro_id := OLD.codigo;
        v_detalhes := 'Registro removido da tabela ' || TG_TABLE_NAME;
    ELSE
        RETURN COALESCE(NEW, OLD);
    END IF;

    IF VerificarNivelAcesso(v_admin_uid, 'gerenciar_produtos')
       OR EXISTS (
           SELECT 1 FROM utilizador_cargos uc
           INNER JOIN cargos c ON uc.cargo_codigo = c.codigo
           WHERE uc.usuario_uid = v_admin_uid AND c.nome_cargo = 'Admin'
       ) THEN
        INSERT INTO logs_auditoria (admin_uid, tabela_afetada, registro_id, acao, detalhes)
        VALUES (v_admin_uid, TG_TABLE_NAME, v_registro_id, v_acao, v_detalhes);
    END IF;

    RETURN COALESCE(NEW, OLD);
END;
$$;

CREATE TRIGGER trg_log_auditoria_produtos
    AFTER UPDATE OR DELETE ON produtos
    FOR EACH ROW EXECUTE PROCEDURE fn_log_auditoria_admin();

CREATE TRIGGER trg_log_auditoria_permissoes
    AFTER UPDATE OR DELETE ON permissoes
    FOR EACH ROW EXECUTE PROCEDURE fn_log_auditoria_admin();


CREATE OR REPLACE FUNCTION fn_auto_fechar_ticket()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_ultima_interacao TIMESTAMP;
BEGIN
    SELECT GREATEST(
        COALESCE(MAX(m.data_envio), '1970-01-01'::TIMESTAMP),
        COALESCE(t.data_abertura, '1970-01-01'::TIMESTAMP)
    )
    INTO v_ultima_interacao
    FROM tickets t
    LEFT JOIN mensagens_ticket m ON m.ticket_numero = t.numero
    WHERE t.numero = NEW.ticket_numero
    GROUP BY t.data_abertura;

    IF v_ultima_interacao < NOW() - INTERVAL '7 days' THEN
        UPDATE tickets
        SET status_ticket = 'Resolvido',
            data_fechamento = COALESCE(data_fechamento, NOW())
        WHERE numero = NEW.ticket_numero
          AND status_ticket NOT IN ('FECHADO', 'Resolvido');
    END IF;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_auto_fechar_ticket
    BEFORE INSERT ON mensagens_ticket
    FOR EACH ROW EXECUTE PROCEDURE fn_auto_fechar_ticket();


CREATE OR REPLACE FUNCTION fn_verificar_bloqueio_usuario()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM blacklist WHERE banido_uid = NEW.comprador_uid
    ) THEN
        RAISE EXCEPTION 'Usuário % está banido e não pode realizar compras.', NEW.comprador_uid;
    END IF;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_verificar_bloqueio_usuario
    BEFORE INSERT ON pedidos
    FOR EACH ROW EXECUTE PROCEDURE fn_verificar_bloqueio_usuario();
