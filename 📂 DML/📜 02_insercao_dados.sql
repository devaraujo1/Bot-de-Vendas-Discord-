-- ======================================================================
-- SCRIPT DML: INSERÇÃO DE DADOS 
-- ======================================================================

-- 📌 1) TABELAS AUXILIARES 
INSERT INTO cargos (nome_cargo, id_cargo_discord) VALUES 
('Admin', 900000000000000001), 
('Suporte', 900000000000000002), 
('Comprador VIP', 900000000000000003);

INSERT INTO categorias (nome, descricao) VALUES 
('Scripts', 'Scripts de automação e utilitários.'), 
('Skins', 'Customização de personagens e veículos.'), 
('Moedas', 'Moedas virtuais para a economia in-game.');

INSERT INTO tipos_ticket (nome_tipo, descricao) VALUES 
('Suporte Técnico', 'Problemas técnicos no sistema'), 
('Denúncia', 'Denúncia de comportamento inadequado'), 
('Dúvida', 'Dúvidas gerais sobre regras');

INSERT INTO cupons (codigo, percentual_desconto, data_validade) VALUES 
('BEMVINDO', 10, CURRENT_DATE + INTERVAL '30 days'), 
('VIP20', 20, CURRENT_DATE + INTERVAL '60 days'), 
('BLACKFRIDAY', 50, CURRENT_DATE + INTERVAL '120 days');

INSERT INTO permissoes (id_cargo, chave_permissao) VALUES 
(1, 'banir_utilizador'), 
(1, 'criar_produto'), 
(2, 'fechar_ticket');

-- 📌 2) TABELAS CORE (Mínimo de 30 registros usando generate_series)
INSERT INTO utilizadores (id_discord, nome_utilizador, tag_discord) 
SELECT (100000000000000000 + gs)::bigint, 'Usuario ' || gs, lpad((gs % 9999 + 1)::text, 4, '0') 
FROM generate_series(1, 30) AS gs;

INSERT INTO utilizador_cargos (id_discord, id_cargo) 
SELECT (100000000000000000 + gs)::bigint, ((gs % 3) + 1)::int 
FROM generate_series(1, 30) AS gs;

INSERT INTO produtos (id_categoria, nome, preco_centavos) 
SELECT ((gs % 3) + 1)::int, 'Produto Digital ' || gs, ((gs * 100) + 500)::int 
FROM generate_series(1, 30) AS gs;

INSERT INTO produto_imagens (id_produto, url_imagem) 
SELECT gs, 'https://cdn.discordapp.com/img' || gs || '.png' 
FROM generate_series(1, 30) AS gs;

INSERT INTO stock_digital (id_produto, conteudo_entrega, vendido) 
SELECT gs, 'KEY-' || gs || '-' || md5(gs::text), (gs % 2 = 0) 
FROM generate_series(1, 30) AS gs;

INSERT INTO tickets (id_canal_discord, id_dono_discord, id_tipo, status) 
SELECT (300000000000000000 + gs)::bigint, (100000000000000000 + gs)::bigint, ((gs % 3) + 1)::int, 'ABERTO' 
FROM generate_series(1, 30) AS gs;

INSERT INTO mensagens_ticket (id_ticket, id_autor_discord, conteudo) 
SELECT gs, (100000000000000000 + gs)::bigint, 'Mensagem automática de suporte nº ' || gs 
FROM generate_series(1, 30) AS gs;

INSERT INTO avaliacoes_atendimento (id_ticket, nota, comentario) 
SELECT gs, ((gs % 5) + 1)::int, 'Avaliação rápida: ' || gs 
FROM generate_series(1, 30) AS gs;

INSERT INTO pedidos (id_comprador_discord, id_cupom, valor_total, status_pagamento) 
SELECT (100000000000000000 + gs)::bigint, ((gs % 3) + 1)::int, ((gs * 100) + 1500)::int, 
       CASE WHEN gs % 2 = 0 THEN 'Pago' ELSE 'Pendente' END 
FROM generate_series(1, 30) AS gs;

INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) 
SELECT gs, ((gs % 30) + 1)::int, ((gs % 5) + 1)::int 
FROM generate_series(1, 30) AS gs;

INSERT INTO pagamentos_pix (id_pedido, codigo_copia_cola, confirmado, txid) 
SELECT gs, '00020101021126580014br.gov.bcb.pix0136' || gs, (gs % 2 = 0), 'TXID' || gs 
FROM generate_series(1, 30) AS gs;

INSERT INTO reembolsos_revogacoes (id_pedido, motivo, status_reembolso) 
SELECT gs, 'Solicitação de devolução nº ' || gs, 'Pendente' 
FROM generate_series(1, 30) AS gs;

INSERT INTO blacklist (id_discord_banido, motivo) 
SELECT (100000000000000000 + gs)::bigint, 'Violação de Termos nº ' || gs 
FROM generate_series(1, 30) AS gs;
