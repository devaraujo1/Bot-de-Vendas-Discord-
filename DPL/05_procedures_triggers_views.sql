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


