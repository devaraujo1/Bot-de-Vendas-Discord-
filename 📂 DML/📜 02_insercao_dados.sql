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
-- 1. Utilizadores
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

-- 2. Produtos
INSERT INTO produtos (categoria_codigo, nome_produto, preco_centavos) VALUES 
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

-- 3. Associativa: Utilizadores x Cargos
INSERT INTO utilizador_cargos (usuario_uid, cargo_codigo) VALUES --EU
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

-- 4. Estoque Digital
INSERT INTO stock_digital (produto_codigo, conteudo_entrega, foi_vendido) VALUES 
(1, 'KEY-ACT-101', TRUE), (2, 'KEY-ACT-102', FALSE), (3, 'KEY-ACT-103', TRUE),
(4, 'KEY-ACT-104', FALSE), (5, 'KEY-ACT-105', TRUE), (6, 'KEY-ACT-106', FALSE),
(7, 'KEY-ACT-107', TRUE), (8, 'KEY-ACT-108', FALSE), (9, 'KEY-ACT-109', TRUE),
(10, 'KEY-ACT-110', FALSE), (11, 'KEY-ACT-111', TRUE), (12, 'KEY-ACT-112', FALSE),
(13, 'KEY-ACT-113', TRUE), (14, 'KEY-ACT-114', FALSE), (15, 'KEY-ACT-115', TRUE),
(16, 'KEY-ACT-116', FALSE), (17, 'KEY-ACT-117', TRUE), (18, 'KEY-ACT-118', FALSE),
(19, 'KEY-ACT-119', TRUE), (20, 'KEY-ACT-120', FALSE), (21, 'KEY-ACT-121', TRUE),
(22, 'KEY-ACT-122', FALSE), (23, 'KEY-ACT-123', TRUE), (24, 'KEY-ACT-124', FALSE),
(25, 'KEY-ACT-125', TRUE), (26, 'KEY-ACT-126', FALSE), (27, 'KEY-ACT-127', TRUE),
(28, 'KEY-ACT-128', FALSE), (29, 'KEY-ACT-129', TRUE), (30, 'KEY-ACT-130', FALSE);

-- 5. Tickets
INSERT INTO tickets (canal_discord_uid, dono_uid, tipo_codigo, status_ticket) VALUES 
(300000000000000001, 100000000000000001, 1, 'ABERTO'), (300000000000000002, 100000000000000002, 2, 'EM ANÁLISE'),
(300000000000000003, 100000000000000003, 3, 'FECHADO'), (300000000000000004, 100000000000000004, 1, 'ABERTO'),
(300000000000000005, 100000000000000005, 2, 'EM ANÁLISE'), (300000000000000006, 100000000000000006, 3, 'FECHADO'),
(300000000000000007, 100000000000000007, 1, 'ABERTO'), (300000000000000008, 100000000000000008, 2, 'EM ANÁLISE'),
(300000000000000009, 100000000000000009, 3, 'FECHADO'), (300000000000000010, 100000000000000010, 1, 'ABERTO'),
(300000000000000011, 100000000000000011, 2, 'EM ANÁLISE'), (300000000000000012, 100000000000000012, 3, 'FECHADO'),
(300000000000000013, 100000000000000013, 1, 'ABERTO'), (300000000000000014, 100000000000000014, 2, 'EM ANÁLISE'),
(300000000000000015, 100000000000000015, 3, 'FECHADO'), (300000000000000016, 100000000000000016, 1, 'ABERTO'),
(300000000000000017, 100000000000000017, 2, 'EM ANÁLISE'), (300000000000000018, 100000000000000018, 3, 'FECHADO'),
(300000000000000019, 100000000000000019, 1, 'ABERTO'), (300000000000000020, 100000000000000020, 2, 'EM ANÁLISE'),
(300000000000000021, 100000000000000021, 3, 'FECHADO'), (300000000000000022, 100000000000000022, 1, 'ABERTO'),
(300000000000000023, 100000000000000023, 2, 'EM ANÁLISE'), (300000000000000024, 100000000000000024, 3, 'FECHADO'),
(300000000000000025, 100000000000000025, 1, 'ABERTO'), (300000000000000026, 100000000000000026, 2, 'EM ANÁLISE'),
(300000000000000027, 100000000000000027, 3, 'FECHADO'), (300000000000000028, 100000000000000028, 1, 'ABERTO'),
(300000000000000029, 100000000000000029, 2, 'EM ANÁLISE'), (300000000000000030, 100000000000000030, 3, 'FECHADO');

-- 6. Mensagens
INSERT INTO mensagens_ticket (ticket_numero, autor_uid, conteudo_mensagem) VALUES 
(1, 100000000000000001, 'Olá, estou com dúvida.'), (2, 100000000000000002, 'Minha key não chegou.'),
(3, 100000000000000003, 'Quero denunciar.'), (4, 100000000000000004, 'Olá, estou com dúvida.'),
(5, 100000000000000005, 'Minha key não chegou.'), (6, 100000000000000006, 'Quero denunciar.'),
(7, 100000000000000007, 'Olá, estou com dúvida.'), (8, 100000000000000008, 'Minha key não chegou.'),
(9, 100000000000000009, 'Quero denunciar.'), (10, 100000000000000010, 'Olá, estou com dúvida.'),
(11, 100000000000000011, 'Minha key não chegou.'), (12, 100000000000000012, 'Quero denunciar.'),
(13, 100000000000000013, 'Olá, estou com dúvida.'), (14, 100000000000000014, 'Minha key não chegou.'),
(15, 100000000000000015, 'Quero denunciar.'), (16, 100000000000000016, 'Olá, estou com dúvida.'),
(17, 100000000000000017, 'Minha key não chegou.'), (18, 100000000000000018, 'Quero denunciar.'),
(19, 100000000000000019, 'Olá, estou com dúvida.'), (20, 100000000000000020, 'Minha key não chegou.'),
(21, 100000000000000021, 'Quero denunciar.'), (22, 100000000000000022, 'Olá, estou com dúvida.'),
(23, 100000000000000023, 'Minha key não chegou.'), (24, 100000000000000024, 'Quero denunciar.'),
(25, 100000000000000025, 'Olá, estou com dúvida.'), (26, 100000000000000026, 'Minha key não chegou.'),
(27, 100000000000000027, 'Quero denunciar.'), (28, 100000000000000028, 'Olá, estou com dúvida.'),
(29, 100000000000000029, 'Minha key não chegou.'), (30, 100000000000000030, 'Quero denunciar.');

-- 7. Pedidos
INSERT INTO pedidos (comprador_uid, valor_final, status_pedido) VALUES 
(100000000000000001, 2500, 'Pago'), (100000000000000002, 1500, 'Pendente'), 
(100000000000000003, 5000, 'Pago'), (100000000000000004, 3500, 'Cancelado'),
(100000000000000005, 8000, 'Pago'), (100000000000000006, 12000, 'Pendente'),
(100000000000000007, 15000, 'Pago'), (100000000000000008, 25000, 'Cancelado'),
(100000000000000009, 3000, 'Pago'), (100000000000000010, 4500, 'Pendente'),
(100000000000000011, 2500, 'Pago'), (100000000000000012, 1500, 'Pendente'),
(100000000000000013, 5000, 'Pago'), (100000000000000014, 3500, 'Cancelado'),
(100000000000000015, 8000, 'Pago'), (100000000000000016, 12000, 'Pendente'),
(100000000000000017, 15000, 'Pago'), (100000000000000018, 25000, 'Cancelado'),
(100000000000000019, 3000, 'Pago'), (100000000000000020, 4500, 'Pendente'),
(100000000000000021, 2500, 'Pago'), (100000000000000022, 1500, 'Pendente'),
(100000000000000023, 5000, 'Pago'), (100000000000000024, 3500, 'Cancelado'),
(100000000000000025, 8000, 'Pago'), (100000000000000026, 12000, 'Pendente'),
(100000000000000027, 15000, 'Pago'), (100000000000000028, 25000, 'Cancelado'),
(100000000000000029, 3000, 'Pago'), (100000000000000030, 4500, 'Pendente');

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
