-- ====================================================================================
-- SCRIPT DQL: CONSULTAS RELACIONAIS 
-- Projeto: Bot de Vendas Discord
-- ====================================================================================

-- 1. Inner Join: Exiba o nome de usuário do Discord e o nome do cargo atribuído a ele.
SELECT 
    u.nome_utilizador, 
    c.nome_cargo
FROM utilizadores u
INNER JOIN utilizador_cargos uc ON u.id_discord = uc.id_discord
INNER JOIN cargos c ON uc.id_cargo = c.id_cargo;


-- 2. Right Join: Liste todos os pagamentos realizados e as vendas correspondentes, 
-- incluindo vendas pendentes sem pagamento.
SELECT 
    pix.txid AS transacao_pix, 
    pix.confirmado AS status_pix,
    ped.id_pedido, 
    ped.status_pagamento
FROM pagamentos_pix pix
RIGHT JOIN pedidos ped ON pix.id_pedido = ped.id_pedido;


-- 3. Left Join: Liste todos os usuários e os tickets de suporte que eles abriram, 
-- incluindo usuários que nunca precisaram de suporte.
SELECT 
    u.nome_utilizador, 
    t.id_ticket, 
    t.status AS status_ticket
FROM utilizadores u
LEFT JOIN tickets t ON u.id_discord = t.id_dono_discord;


-- 4. Inner Join: Mostre o nome do produto digital e a categoria à qual ele pertence.
SELECT 
    p.nome_produto, 
    c.nome_categoria
FROM produtos p
INNER JOIN categorias c ON p.categoria_codigo = c.codigo;


-- 5. Inner Join: Relacione a venda com o código do produto que foi entregue automaticamente.
SELECT 
    ped.numero AS numero_pedido, 
    prod.nome_produto, 
    est.conteudo_entrega AS chave_entregue
FROM pedidos ped
INNER JOIN itens_pedido ip ON ped.numero = ip.pedido_numero
INNER JOIN produtos prod ON ip.produto_codigo = prod.codigo
INNER JOIN stock_digital est ON prod.codigo = est.produto_codigo
WHERE est.foi_vendido = TRUE;


-- 6. Left Join: Liste todos os cargos/permissões do servidor e os usuários vinculados, 
-- incluindo cargos que estão vazios.
SELECT 
    c.nome_cargo, 
    p.chave_permissao, 
    u.nome_usuario
FROM cargos c
LEFT JOIN permissoes p ON c.codigo = p.cargo_codigo
LEFT JOIN utilizador_cargos uc ON c.codigo = uc.cargo_codigo
LEFT JOIN utilizadores u ON uc.usuario_uid = u.discord_uid;


-- 7. Inner Join: Exiba o ID do ticket de suporte e o nome do moderador designado.
SELECT DISTINCT
    t.id_ticket, 
    t.status,
    u.nome_utilizador AS moderador_atuante
FROM tickets t
INNER JOIN mensagens_ticket m ON t.id_ticket = m.id_ticket
INNER JOIN utilizadores u ON m.id_autor_discord = u.id_discord
INNER JOIN utilizador_cargos uc ON u.id_discord = uc.id_discord
INNER JOIN cargos c ON uc.id_cargo = c.id_cargo
WHERE c.nome_cargo IN ('Admin', 'Suporte');


-- 8. Inner Join: Relacione a venda com o código de transação PIX gerado pelo sistema.
SELECT 
    ped.id_pedido, 
    ped.valor_total, 
    pix.codigo_copia_cola, 
    pix.txid AS transacao_pix
FROM pedidos ped
INNER JOIN pagamentos_pix pix ON ped.id_pedido = pix.id_pedido;


-- 9. Left Join: Mostre todos os produtos digitais e os logs de auditoria (histórico), 
-- incluindo produtos recém-lançados sem logs.
SELECT 
    prod.nome AS produto_digital, 
    est.id_item AS log_historico_id, 
    est.conteudo_entrega AS log_conteudo
FROM produtos prod
LEFT JOIN stock_digital est ON prod.id_produto = est.id_produto;


-- 10. Inner Join: Exiba o nome do usuário e o motivo do bloqueio registrado na auditoria.
SELECT 
    u.nome_utilizador, 
    b.motivo AS motivo_bloqueio, 
    b.data_banimento
FROM utilizadores u
INNER JOIN blacklist b ON u.id_discord = b.id_discord_banido;


-- 11. Inner Join: Relacione os cupons de desconto com as vendas onde foram aplicados.
SELECT 
    c.codigo AS cupom_aplicado, 
    c.percentual_desconto, 
    ped.id_pedido, 
    ped.valor_total
FROM cupons c
INNER JOIN pedidos ped ON c.id_cupom = ped.id_cupom;


-- 12. Right Join: Liste todas as ações administrativas cadastradas e o admin que as executou.
SELECT 
    p.chave_permissao AS acao_administrativa, 
    c.nome_cargo,
    u.nome_utilizador AS administrador
FROM permissoes p
RIGHT JOIN cargos c ON p.id_cargo = c.id_cargo
RIGHT JOIN utilizador_cargos uc ON c.id_cargo = uc.id_cargo
RIGHT JOIN utilizadores u ON uc.id_discord = u.id_discord
WHERE p.chave_permissao IS NOT NULL;
