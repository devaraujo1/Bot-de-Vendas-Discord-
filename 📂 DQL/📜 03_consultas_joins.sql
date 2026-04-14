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




-- ====================================================================================
-- SCRIPT DQL: CONSULTAS RELACIONAIS (GROUP BY, UNION, INTERSECT)
-- ====================================================================================

-- 1. Group By: Conte o total de tickets de suporte agrupados por status (Aberto/Fechado).




-- 2. Group By: Calcule o valor total de vendas gerado por cada produto digital.




-- 3. Group By: Liste a quantidade de usuários vinculados a cada cargo/permissão do servidor.



-- 4. Group By: Totalize os reembolsos processados agrupados por mês de ocorrência.



-- 5. Union: Combine os usernames de usuários comuns e usernames de administradores em uma lista.



-- 6. Union All: Liste todos os IDs de transação de vendas e todos os IDs de reembolsos.




-- 7. Intersect: Identifique usuários que realizaram uma compra e também abriram um ticket de suporte.



-- 8. Group By: Calcule a média de gastos por usuário nas transações PIX.



-- 9. Union: Liste os nomes dos produtos da "Categoria X" e da "Categoria Y" em uma única consulta.




-- 10. Group By: Conte a quantidade de logs de auditoria para cada tipo de ação administrativa.
SELECT 
    motivo_banimento AS acao_administrativa, 
    COUNT(codigo) AS total_logs
FROM blacklist
GROUP BY motivo_banimento;


-- 11. Intersect: Encontre IDs de produtos que estão "Disponíveis" e que possuem registro de venda.
SELECT produto_codigo 
FROM stock_digital 
WHERE foi_vendido = FALSE

INTERSECT

SELECT produto_codigo 
FROM itens_pedido;


-- 12. Group By: Calcule o total de cupons de desconto utilizados agrupados por código do cupom.
SELECT 
    c.chave_cupom, 
    COUNT(ped.numero) AS total_utilizacoes
FROM cupons c
INNER JOIN pedidos ped ON c.codigo = ped.cupom_codigo
GROUP BY c.chave_cupom
ORDER BY total_utilizacoes DESC;


-- 13. Group By: Conte o total de tickets de suporte agrupados por status (Aberto/Fechado).
SELECT 
    status_ticket, 
    COUNT(*) AS total_tickets
FROM tickets
GROUP BY status_ticket;

-- 14. Group By: Calcule o valor total de vendas gerado por cada produto digital.
SELECT 
    p.nome_produto,
    SUM(p.preco_centavos * ip.quantidade_comprada) AS total_vendas_centavos
FROM itens_pedido ip
INNER JOIN produtos p ON ip.produto_codigo = p.codigo
GROUP BY p.nome_produto
ORDER BY total_vendas_centavos DESC;

-- 15. Group By: Liste a quantidade de usuários vinculados a cada cargo/permissão do servidor.
SELECT 
    c.nome_cargo,
    COUNT(uc.usuario_uid) AS total_usuarios
FROM cargos c
INNER JOIN utilizador_cargos uc ON c.codigo = uc.cargo_codigo
GROUP BY c.nome_cargo
ORDER BY total_usuarios DESC;
