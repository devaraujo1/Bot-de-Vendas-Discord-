-- ====================================================================================
-- SCRIPT DQL: CONSULTAS RELACIONAIS 
-- Projeto: Bot de Vendas Discord
-- ====================================================================================

-- 1. Inner Join: Exiba o nome de usuário do Discord e o nome do cargo atribuído a ele.
SELECT 
    u.nome_usuario, 
    c.nome_cargo
FROM utilizadores u
INNER JOIN utilizador_cargos uc ON u.discord_uid = uc.usuario_uid
INNER JOIN cargos c ON uc.cargo_codigo = c.codigo;

-- 2. Right Join: Liste todos os pagamentos realizados e as vendas correspondentes, incluindo vendas pendentes sem pagamento.
SELECT 
    pag.codigo_transacao, 
    pag.status_pagamento AS status_financeiro,
    ped.numero AS numero_pedido, 
    ped.status_pedido AS status_da_venda
FROM pagamentos pag
RIGHT JOIN pedidos ped ON pag.pedido_numero = ped.numero;

-- 3. Left Join: Liste todos os usuários e os tickets de suporte que eles abriram, incluindo usuários que nunca precisaram de suporte.
SELECT 
    u.nome_usuario, 
    t.numero AS numero_ticket, 
    t.status_ticket
FROM utilizadores u
LEFT JOIN tickets t ON u.discord_uid = t.dono_uid;


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


-- 7. Inner Join: Exiba o ID do ticket de suporte e o nome do moderador que foi designado para resolvê-lo.
SELECT DISTINCT
    t.numero AS numero_ticket, 
    t.status_ticket,
    u.nome_usuario AS moderador_atuante
FROM tickets t
INNER JOIN mensagens_ticket m ON t.numero = m.ticket_numero
INNER JOIN utilizadores u ON m.autor_uid = u.discord_uid
INNER JOIN utilizador_cargos uc ON u.discord_uid = uc.usuario_uid
INNER JOIN cargos c ON uc.cargo_codigo = c.codigo
WHERE c.nome_cargo IN ('Admin', 'Suporte');

-- 8. Inner Join: Relacione a venda com o código de transação PIX gerado pelo sistema.
SELECT 
    ped.numero AS numero_pedido, 
    ped.valor_final, 
    fp.descricao_forma,
    pag.codigo_transacao
FROM pedidos ped
INNER JOIN pagamentos pag ON ped.numero = pag.pedido_numero
INNER JOIN formas_pagamento fp ON pag.forma_codigo = fp.codigo
WHERE fp.descricao_forma = 'PIX';

-- 9. Left Join: Mostre todos os produtos digitais e os logs de auditoria (histórico), incluindo produtos recém-lançados.
SELECT 
    prod.nome_produto, 
    est.codigo AS log_historico_id, 
    est.conteudo_entrega AS log_conteudo
FROM produtos prod
LEFT JOIN stock_digital est ON prod.codigo = est.produto_codigo;


-- 10. Inner Join: Exiba o nome do usuário e o motivo do bloqueio registrado na tabela de auditoria.
SELECT 
    u.nome_usuario, 
    b.motivo_banimento, 
    b.data_banimento
FROM utilizadores u
INNER JOIN blacklist b ON u.discord_uid = b.banido_uid;

-- 11. Inner Join: Relacione os cupons de desconto com as vendas onde eles foram aplicados.
SELECT 
    c.chave_cupom, 
    c.percentual_desconto, 
    ped.numero AS numero_pedido, 
    ped.valor_final
FROM cupons c
INNER JOIN pedidos ped ON c.codigo = ped.cupom_codigo;

-- 12. Right Join: Liste todas as ações administrativas cadastradas e o nome do administrador que as executou.
SELECT 
    p.chave_permissao AS acao_administrativa, 
    c.nome_cargo,
    u.nome_usuario AS administrador
FROM permissoes p
RIGHT JOIN cargos c ON p.cargo_codigo = c.codigo
RIGHT JOIN utilizador_cargos uc ON c.codigo = uc.cargo_codigo
RIGHT JOIN utilizadores u ON uc.usuario_uid = u.discord_uid
WHERE p.chave_permissao IS NOT NULL;
