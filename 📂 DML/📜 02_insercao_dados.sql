-- ======================================================================
-- SCRIPT DML: INSERÇÃO DE DADOS 
-- ======================================================================

-- 📌 1) TABELAS AUXILIARES 
INSERT INTO cargos (nome_cargo, discord_role_uid) VALUES 
('Admin', 900000000000000001), 
('Suporte', 900000000000000002), 
('Comprador VIP', 900000000000000003);

INSERT INTO formas_pagamento (descricao_forma) VALUES  
('PIX'), ('Cartão de Crédito'), ('Saldo na Loja Discord');

INSERT INTO categorias (nome, descricao) VALUES 
('Scripts', 'Scripts de automação e utilitários.'), 
('Skins', 'Customização de personagens e veículos.'), 
('Moedas', 'Moedas virtuais para a economia in-game.');

INSERT INTO tipos_ticket (nome_tipo, descricao_tipo) VALUES 
('Dúvida sobre Produto', 'Questões antes da compra'), 
('Suporte Técnico', 'Erro ao resgatar ou usar produto'), 
('Denúncia', 'Denunciar usuários no servidor');


INSERT INTO cupons (chave_cupom, percentual_desconto, data_validade) VALUES 
('NATAL20', 20, '2026-12-25'), ('BEMVINDO', 10, '2028-01-01'), ('BLACKFRIDAY', 50, '2026-11-28');

INSERT INTO permissoes (id_cargo, chave_permissao) VALUES 
(1, 'banir_utilizador'), 
(1, 'criar_produto'), 
(2, 'fechar_ticket');

-- 📌 2) TABELAS CORE
INSERT INTO utilizadores (discord_uid, nome_usuario, tag_usuario) VALUES    
(100000000000000001, 'NinjaGamer', '0001'), (100000000000000002, 'FakerBr', '9999'), 
(100000000000000003, 'FallenCS', '1337'), (100000000000000004, 'Gaules', '5555'), 
(100000000000000005, 'Alanzoka', '2020'), (100000000000000006, 'Coringa', '7777'),
(100000000000000007, 'Yoda', '1010'), (100000000000000008, 'Jukes', '8888'), 
(100000000000000009, 'Nobru', '0000'), (100000000000000010, 'Cerol', '1111'), 
(100000000000000011, 'Piuzinho', '2222'), (100000000000000012, 'PlayHard', '3333'),
(100000000000000013, 'Bida', '4444'), (100000000000000014, 'Mch', '6666'), 
(100000000000000015, 'Apoka', '1212'), (100000000000000016, 'S1mple', '0002'), 
(100000000000000017, 'ZywOo', '0003'), (100000000000000018, 'Niko', '0004'),
(100000000000000019, 'Coldzera', '0005'), (100000000000000020, 'Taco', '0006'), 
(100000000000000021, 'Fer', '0007'), (100000000000000022, 'Fnx', '0008'), 
(100000000000000023, 'Boltz', '0009'), (100000000000000024, 'Kscerato', '0010'),
(100000000000000025, 'Yuurih', '0011'), (100000000000000026, 'ArT', '0012'), 
(100000000000000027, 'Vini', '0013'), (100000000000000028, 'Galle', '0014'), 
(100000000000000029, 'Xantares', '0015'), (100000000000000030, 'Ropz', '0016');

INSERT INTO utilizador_cargos (usuario_uid, cargo_codigo) VALUES 
(100000000000000001, 1), (100000000000000002, 2), (100000000000000003, 3),
(100000000000000004, 1), (100000000000000005, 2), (100000000000000006, 3),
(100000000000000007, 1), (100000000000000008, 2), (100000000000000009, 3),
(100000000000000010, 1), (100000000000000011, 2), (100000000000000012, 3),
(100000000000000013, 1), (100000000000000014, 2), (100000000000000015, 3),
(100000000000000016, 1), (100000000000000017, 2), (100000000000000018, 3),
(100000000000000019, 1), (100000000000000020, 2), (100000000000000021, 3),
(100000000000000022, 1), (100000000000000023, 2), (100000000000000024, 3),
(100000000000000025, 1), (100000000000000026, 2), (100000000000000027, 3),
(100000000000000028, 1), (100000000000000029, 2), (100000000000000030, 3);


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

-- 8. Itens Pedido
INSERT INTO itens_pedido (pedido_numero, produto_codigo, quantidade_comprada) VALUES 
(1, 1, 1), (2, 2, 2), (3, 3, 1), (4, 4, 3), (5, 5, 1), (6, 6, 2),
(7, 7, 1), (8, 8, 1), (9, 9, 2), (10, 10, 1), (11, 11, 3), (12, 12, 1),
(13, 13, 1), (14, 14, 2), (15, 15, 1), (16, 16, 1), (17, 17, 3), (18, 18, 1),
(19, 19, 1), (20, 20, 2), (21, 21, 1), (22, 22, 1), (23, 23, 3), (24, 24, 1),
(25, 25, 1), (26, 26, 2), (27, 27, 1), (28, 28, 1), (29, 29, 3), (30, 30, 1);

-- 9. Pagamentos (Vinculado a Formas de Pagamento e Pedidos)
INSERT INTO pagamentos (pedido_numero, forma_codigo, codigo_transacao, status_pagamento) VALUES 
(1, 1, 'TRX-101', 'Aprovado'), (2, 2, 'TRX-102', 'Pendente'), (3, 3, 'TRX-103', 'Aprovado'),
(4, 1, 'TRX-104', 'Recusado'), (5, 2, 'TRX-105', 'Aprovado'), (6, 3, 'TRX-106', 'Pendente'),
(7, 1, 'TRX-107', 'Aprovado'), (8, 2, 'TRX-108', 'Recusado'), (9, 3, 'TRX-109', 'Aprovado'),
(10, 1, 'TRX-110', 'Pendente'), (11, 2, 'TRX-111', 'Aprovado'), (12, 3, 'TRX-112', 'Pendente'),
(13, 1, 'TRX-113', 'Aprovado'), (14, 2, 'TRX-114', 'Recusado'), (15, 3, 'TRX-115', 'Aprovado'),
(16, 1, 'TRX-116', 'Pendente'), (17, 2, 'TRX-117', 'Aprovado'), (18, 3, 'TRX-118', 'Recusado'),
(19, 1, 'TRX-119', 'Aprovado'), (20, 2, 'TRX-120', 'Pendente'), (21, 3, 'TRX-121', 'Aprovado'),
(22, 1, 'TRX-122', 'Pendente'), (23, 2, 'TRX-123', 'Aprovado'), (24, 3, 'TRX-124', 'Recusado'),
(25, 1, 'TRX-125', 'Aprovado'), (26, 2, 'TRX-126', 'Pendente'), (27, 3, 'TRX-127', 'Aprovado'),
(28, 1, 'TRX-128', 'Recusado'), (29, 2, 'TRX-129', 'Aprovado'), (30, 3, 'TRX-130', 'Pendente');

-- 10. Avaliacoes
INSERT INTO avaliacoes_atendimento (ticket_numero, nota_avaliacao, comentario) VALUES 
(3, 5, 'Ótimo atendimento!'), (6, 4, 'Muito bom.'), (9, 5, 'Resolveu rápido.'),
(12, 3, 'Demorou um pouco.'), (15, 5, 'Perfeito.'), (18, 2, 'Não resolveu tudo.'),
(21, 5, 'Excelente!'), (24, 4, 'Bom atendimento.'), (27, 5, 'Recomendo.'),
(30, 1, 'Péssimo suporte.');

-- 11. Blacklist (A regra do professor é um mínimo de registros inseridos)
INSERT INTO blacklist (banido_uid, motivo_banimento) VALUES 
(100000000000000004, 'Fraude'), (100000000000000008, 'Xingou o admin'), (100000000000000014, 'Hack');
