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

-- 📌 2) TABELAS CORE
INSERT INTO utilizadores (id_discord, nome_utilizador, tag_discord) 
SELECT (100000000000000000 + gs)::bigint, 'Usuario ' || gs, lpad((gs % 9999 + 1)::text, 4, '0') 
FROM generate_series(1, 30) AS gs;

INSERT INTO utilizador_cargos (id_utilizador, id_cargo) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 2),
(5, 4),
(6, 3),
(7, 2),
(8, 4),
(9, 3),
(10, 2);

SERT INTO produtos (categoria_codigo, nome_produto, preco_centavos) VALUES 
(1, 'VIP Mensal (Roleplay)', 2500), (1, 'VIP Anual', 20000), (1, 'Cargo Customizado', 5000),
(2, 'Pacote 1M Moedas', 1500), (2, 'Pacote 5M Moedas', 6000), (2, 'Lootbox Lendária', 3500),
(3, 'Script HUD', 8000), (3, 'Script Concessionária', 15000), (3, 'Script Banco', 25000),
(1, 'Sócio do Servidor', 50000), (2, 'Moeda Premium', 3000), (3, 'Script Garagem', 12000),
(1, 'Acesso Sala VIP', 1000), (2, 'Gema de Evolução', 500), (3, 'Sistema de Empregos', 9000),
(1, 'Tag Colorida', 800), (2, 'Passe de Batalha', 4500), (3, 'Script Hospital', 18000),
(1, 'Booster XP 7 Dias', 1200), (2, 'Chave de Baú Raro', 250), (3, 'Script Polícia', 30000),
(1, 'Acesso Beta', 8500), (2, 'Ticket de Roleta', 150), (3, 'Script Cassino', 45000),
(1, 'Desbanimento Conta', 15000), (2, 'Reset de Status', 2000), (3, 'Script Prisão', 14000),
(1, 'Membro Fundador', 99900), (2, 'Pet Virtual', 3500), (3, 'Script Celular', 60000);

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
