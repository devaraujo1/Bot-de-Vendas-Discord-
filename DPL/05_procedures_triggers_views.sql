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

-- VerificarNivelAcesso: retorna se o usuário tem permissão para executar determinada ação.
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

-- TotalVendidoNoMes: soma vendas confirmadas no mês atual.
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

-- TempoMedioRespostaTicket: média entre abertura e fechamento dos atendimentos.
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

-- 2) PROCEDURES

-- GerarVendaPix: cria pedido pendente e gera código simulado de transação PIX.
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

-- ProcessarReembolso: altera status da venda e registra auditoria.
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

-- AtribuirCargoAutomatico: vincula Comprador VIP após compra confirmada.
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


-- 3) TRIGGERS

-- LogAuditoriaAdmin: registra alterações em produtos e permissões feitas por admin.
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

-- AutoFecharTicket: fecha ticket como Resolvido após 7 dias sem interação.
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

-- VerificarBloqueioUsuario: impede compra de usuário banido.
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


-- 4) VIEWS

-- DashboardVendasAtivas: vendas concluídas recentemente com usernames.
CREATE OR REPLACE VIEW DashboardVendasAtivas AS
SELECT 
    ped.numero AS numero_pedido,
    u.nome_usuario,
    ped.valor_final,
    ped.status_pedido,
    pag.codigo_transacao,
    pag.data_atualizacao AS data_confirmacao
FROM pedidos ped
INNER JOIN utilizadores u ON ped.comprador_uid = u.discord_uid
LEFT JOIN pagamentos pag ON ped.numero = pag.pedido_numero
WHERE ped.status_pedido = 'Pago'
ORDER BY pag.data_atualizacao DESC NULLS LAST;

COMMENT ON VIEW DashboardVendasAtivas IS
'Lista vendas concluídas (Pago) com username do comprador e transação.';

-- TicketsPendentesModeracao: atendimentos sem resposta de moderador.
CREATE OR REPLACE VIEW TicketsPendentesModeracao AS
SELECT 
    t.numero AS numero_ticket,
    t.status_ticket,
    u.nome_usuario AS solicitante,
    t.data_abertura
FROM tickets t
INNER JOIN utilizadores u ON t.dono_uid = u.discord_uid
WHERE t.status_ticket IN ('ABERTO', 'EM ANÁLISE')
  AND NOT EXISTS (
      SELECT 1
      FROM mensagens_ticket mt
      INNER JOIN utilizador_cargos uc ON mt.autor_uid = uc.usuario_uid
      INNER JOIN cargos c ON uc.cargo_codigo = c.codigo
      WHERE mt.ticket_numero = t.numero
        AND c.nome_cargo IN ('Admin', 'Suporte')
  )
ORDER BY t.data_abertura;

COMMENT ON VIEW TicketsPendentesModeracao IS
'Tickets abertos/em análise que ainda não receberam mensagem de Admin ou Suporte.';

-- ProdutosMaisPopulares: ranking de produtos mais adquiridos.
CREATE OR REPLACE VIEW ProdutosMaisPopulares AS
SELECT 
    p.codigo AS produto_codigo,
    p.nome_produto,
    SUM(ip.quantidade_comprada) AS total_unidades_vendidas,
    COUNT(DISTINCT ip.pedido_numero) AS total_pedidos,
    RANK() OVER (ORDER BY SUM(ip.quantidade_comprada) DESC) AS ranking
FROM produtos p
INNER JOIN itens_pedido ip ON p.codigo = ip.produto_codigo
GROUP BY p.codigo, p.nome_produto
ORDER BY total_unidades_vendidas DESC;

COMMENT ON VIEW ProdutosMaisPopulares IS
'Ranking de produtos digitais por quantidade total vendida.';
