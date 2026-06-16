-- ====================================================================================
-- SCRIPT DQL: CONSULTAS DE AGREGAÇÃO (GROUP BY, UNION, INTERSECT)
-- Projeto: Bot de Vendas Discord — Parte 04
-- ====================================================================================

-- 1. Group By: Conte o total de tickets de suporte agrupados por status (Aberto/Fechado).
SELECT 
    status_ticket, 
    COUNT(*) AS total_tickets
FROM tickets
GROUP BY status_ticket
ORDER BY status_ticket;

-- 2. Group By: Calcule o valor total de vendas gerado por cada produto digital.
SELECT 
    p.nome_produto,
    SUM(p.preco_centavos * ip.quantidade_comprada) AS total_vendas_centavos
FROM itens_pedido ip
INNER JOIN produtos p ON ip.produto_codigo = p.codigo
GROUP BY p.nome_produto
ORDER BY total_vendas_centavos DESC;

-- 3. Group By: Liste a quantidade de usuários vinculados a cada cargo/permissão do servidor.
SELECT 
    c.nome_cargo,
    p.chave_permissao,
    COUNT(uc.usuario_uid) AS total_usuarios
FROM cargos c
LEFT JOIN permissoes p ON c.codigo = p.cargo_codigo
LEFT JOIN utilizador_cargos uc ON c.codigo = uc.cargo_codigo
GROUP BY c.nome_cargo, p.chave_permissao
ORDER BY c.nome_cargo, p.chave_permissao;

-- 4. Group By: Totalize os reembolsos processados agrupados por mês de ocorrência.
SELECT 
    TO_CHAR(pag.data_atualizacao, 'YYYY-MM') AS mes_ocorrencia,
    COUNT(r.codigo) AS total_reembolsos
FROM reembolsos_revogacoes r
INNER JOIN pagamentos pag ON r.pedido_numero = pag.pedido_numero
WHERE r.status_reembolso = 'Aprovado'
GROUP BY TO_CHAR(pag.data_atualizacao, 'YYYY-MM')
ORDER BY mes_ocorrencia;

-- 5. Union: Combine os usernames de usuários comuns e usernames de administradores em uma lista.
SELECT u.nome_usuario, 'Admin' AS tipo_usuario
FROM utilizadores u
INNER JOIN utilizador_cargos uc ON u.discord_uid = uc.usuario_uid
INNER JOIN cargos c ON uc.cargo_codigo = c.codigo
WHERE c.nome_cargo = 'Admin'

UNION

SELECT u.nome_usuario, 'Comum' AS tipo_usuario
FROM utilizadores u
WHERE u.discord_uid NOT IN (
    SELECT uc.usuario_uid
    FROM utilizador_cargos uc
    INNER JOIN cargos c ON uc.cargo_codigo = c.codigo
    WHERE c.nome_cargo = 'Admin'
);

-- 6. Union All: Liste todos os IDs de transação de vendas e todos os IDs de reembolsos.
SELECT codigo_transacao AS id_geral, 'Venda' AS origem
FROM pagamentos

UNION ALL

SELECT codigo::text AS id_geral, 'Reembolso' AS origem
FROM reembolsos_revogacoes;

-- 7. Intersect: Identifique usuários que realizaram uma compra e também abriram um ticket de suporte.
SELECT comprador_uid AS usuario_discord
FROM pedidos

INTERSECT

SELECT dono_uid AS usuario_discord
FROM tickets;

-- 8. Group By: Calcule a média de gastos por usuário nas transações PIX.
SELECT 
    p.comprador_uid AS usuario_discord,
    AVG(p.valor_final) AS media_gastos
FROM pedidos p
INNER JOIN pagamentos pg ON p.numero = pg.pedido_numero
INNER JOIN formas_pagamento f ON pg.forma_codigo = f.codigo
WHERE f.descricao_forma = 'PIX'
  AND pg.status_pagamento = 'Aprovado'
GROUP BY p.comprador_uid;

-- 9. Union: Liste os nomes dos produtos da "Categoria X" e da "Categoria Y" em uma única consulta.
SELECT p.nome_produto, c.nome_categoria
FROM produtos p
INNER JOIN categorias c ON p.categoria_codigo = c.codigo
WHERE c.nome_categoria = 'VIPs e Cargos'

UNION

SELECT p.nome_produto, c.nome_categoria
FROM produtos p
INNER JOIN categorias c ON p.categoria_codigo = c.codigo
WHERE c.nome_categoria = 'Scripts FiveM';

-- 10. Group By: Conte a quantidade de logs de auditoria para cada tipo de ação administrativa.
SELECT 
    acao AS acao_administrativa, 
    COUNT(codigo) AS total_logs
FROM logs_auditoria
GROUP BY acao
ORDER BY total_logs DESC;

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
