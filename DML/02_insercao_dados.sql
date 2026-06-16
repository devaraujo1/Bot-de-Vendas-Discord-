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

INSERT INTO categorias (nome_categoria, descricao_categoria) VALUES 
('VIPs e Cargos', 'Acesso a áreas exclusivas no servidor.'), 
('Economia e Moedas', 'Moedas virtuais para jogos internos.'), 
('Scripts FiveM', 'Scripts profissionais para servidores de RP.');

INSERT INTO tipos_ticket (nome_tipo, descricao_tipo) VALUES 
('Dúvida sobre Produto', 'Questões antes da compra'), 
('Suporte Técnico', 'Erro ao resgatar ou usar produto'), 
('Denúncia', 'Denunciar usuários no servidor');

INSERT INTO cupons (chave_cupom, percentual_desconto, data_validade) VALUES 
('NATAL20', 20, '2026-12-25'), ('BEMVINDO', 10, '2028-01-01'), ('BLACKFRIDAY', 50, '2026-11-28');

INSERT INTO permissoes (cargo_codigo, chave_permissao) VALUES 
(1, 'gerenciar_produtos'), (1, 'banir_membros'), (2, 'responder_tickets');


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
(100000000000000029, 'Xantares', '0015'), (100000000000000030, 'Ropz', '0016'),
(100000000000000031, 'Luken', '0031'), (100000000000000032, 'Aspas', '0032');

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

-- 4. Imagens dos Produtos
INSERT INTO produto_imagens (produto_codigo, url_imagem) VALUES
(1, 'https://cdn.discordapp.com/attachments/produtos/vip-mensal.png'),
(2, 'https://cdn.discordapp.com/attachments/produtos/vip-anual.png'),
(3, 'https://cdn.discordapp.com/attachments/produtos/cargo-custom.png'),
(4, 'https://cdn.discordapp.com/attachments/produtos/moedas-1m.png'),
(5, 'https://cdn.discordapp.com/attachments/produtos/moedas-5m.png'),
(6, 'https://cdn.discordapp.com/attachments/produtos/lootbox.png'),
(7, 'https://cdn.discordapp.com/attachments/produtos/script-hud.png'),
(8, 'https://cdn.discordapp.com/attachments/produtos/script-conc.png'),
(9, 'https://cdn.discordapp.com/attachments/produtos/script-banco.png'),
(10, 'https://cdn.discordapp.com/attachments/produtos/socio.png'),
(11, 'https://cdn.discordapp.com/attachments/produtos/moeda-premium.png'),
(12, 'https://cdn.discordapp.com/attachments/produtos/script-garagem.png'),
(13, 'https://cdn.discordapp.com/attachments/produtos/sala-vip.png'),
(14, 'https://cdn.discordapp.com/attachments/produtos/gema.png'),
(15, 'https://cdn.discordapp.com/attachments/produtos/empregos.png'),
(16, 'https://cdn.discordapp.com/attachments/produtos/tag-colorida.png'),
(17, 'https://cdn.discordapp.com/attachments/produtos/passe-batalha.png'),
(18, 'https://cdn.discordapp.com/attachments/produtos/hospital.png'),
(19, 'https://cdn.discordapp.com/attachments/produtos/booster-xp.png'),
(20, 'https://cdn.discordapp.com/attachments/produtos/chave-bau.png'),
(21, 'https://cdn.discordapp.com/attachments/produtos/policia.png'),
(22, 'https://cdn.discordapp.com/attachments/produtos/acesso-beta.png'),
(23, 'https://cdn.discordapp.com/attachments/produtos/roleta.png'),
(24, 'https://cdn.discordapp.com/attachments/produtos/cassino.png'),
(25, 'https://cdn.discordapp.com/attachments/produtos/desban.png'),
(26, 'https://cdn.discordapp.com/attachments/produtos/reset-status.png'),
(27, 'https://cdn.discordapp.com/attachments/produtos/prisao.png'),
(28, 'https://cdn.discordapp.com/attachments/produtos/fundador.png'),
(29, 'https://cdn.discordapp.com/attachments/produtos/pet.png'),
(30, 'https://cdn.discordapp.com/attachments/produtos/celular.png');

-- 5. Estoque Digital
INSERT INTO stock_digital (produto_codigo, conteudo_entrega, foi_vendido) VALUES 
(1, 'KEY-ACT-101', TRUE), (2, 'KEY-ACT-102', TRUE), (3, 'KEY-ACT-103', TRUE),
(4, 'KEY-ACT-104', TRUE), (5, 'KEY-ACT-105', TRUE), (6, 'KEY-ACT-106', TRUE),
(7, 'KEY-ACT-107', TRUE), (8, 'KEY-ACT-108', TRUE), (9, 'KEY-ACT-109', TRUE),
(10, 'KEY-ACT-110', TRUE), (11, 'KEY-ACT-111', TRUE), (12, 'KEY-ACT-112', TRUE),
(13, 'KEY-ACT-113', TRUE), (14, 'KEY-ACT-114', TRUE), (15, 'KEY-ACT-115', TRUE),
(16, 'KEY-ACT-116', TRUE), (17, 'KEY-ACT-117', TRUE), (18, 'KEY-ACT-118', TRUE),
(19, 'KEY-ACT-119', TRUE), (20, 'KEY-ACT-120', TRUE), (21, 'KEY-ACT-121', TRUE),
(22, 'KEY-ACT-122', TRUE), (23, 'KEY-ACT-123', TRUE), (24, 'KEY-ACT-124', TRUE),
(25, 'KEY-ACT-125', TRUE), (26, 'KEY-ACT-126', TRUE), (27, 'KEY-ACT-127', TRUE),
(28, 'KEY-ACT-128', TRUE), (29, 'KEY-ACT-129', TRUE), (30, 'KEY-ACT-130', TRUE);

-- Estoque reserva (disponível) para produtos que também possuem venda registrada
INSERT INTO stock_digital (produto_codigo, conteudo_entrega, foi_vendido) VALUES
(2, 'KEY-ACT-102-RES', FALSE), (4, 'KEY-ACT-104-RES', FALSE), (6, 'KEY-ACT-106-RES', FALSE),
(8, 'KEY-ACT-108-RES', FALSE), (10, 'KEY-ACT-110-RES', FALSE), (12, 'KEY-ACT-112-RES', FALSE),
(14, 'KEY-ACT-114-RES', FALSE), (16, 'KEY-ACT-116-RES', FALSE), (18, 'KEY-ACT-118-RES', FALSE),
(20, 'KEY-ACT-120-RES', FALSE), (22, 'KEY-ACT-122-RES', FALSE), (24, 'KEY-ACT-124-RES', FALSE),
(26, 'KEY-ACT-126-RES', FALSE), (28, 'KEY-ACT-128-RES', FALSE), (30, 'KEY-ACT-130-RES', FALSE);

-- 6. Tickets (com data_fechamento nos encerrados)
INSERT INTO tickets (canal_discord_uid, dono_uid, tipo_codigo, status_ticket, data_fechamento) VALUES 
(300000000000000001, 100000000000000001, 1, 'ABERTO', NULL), (300000000000000002, 100000000000000002, 2, 'EM ANÁLISE', NULL),
(300000000000000003, 100000000000000003, 3, 'FECHADO', '2026-01-10 14:30:00'), (300000000000000004, 100000000000000004, 1, 'ABERTO', NULL),
(300000000000000005, 100000000000000005, 2, 'EM ANÁLISE', NULL), (300000000000000006, 100000000000000006, 3, 'FECHADO', '2026-01-12 09:15:00'),
(300000000000000007, 100000000000000007, 1, 'ABERTO', NULL), (300000000000000008, 100000000000000008, 2, 'EM ANÁLISE', NULL),
(300000000000000009, 100000000000000009, 3, 'FECHADO', '2026-01-14 18:45:00'), (300000000000000010, 100000000000000010, 1, 'ABERTO', NULL),
(300000000000000011, 100000000000000011, 2, 'EM ANÁLISE', NULL), (300000000000000012, 100000000000000012, 3, 'FECHADO', '2026-01-16 11:20:00'),
(300000000000000013, 100000000000000013, 1, 'ABERTO', NULL), (300000000000000014, 100000000000000014, 2, 'EM ANÁLISE', NULL),
(300000000000000015, 100000000000000015, 3, 'FECHADO', '2026-01-18 16:00:00'), (300000000000000016, 100000000000000016, 1, 'ABERTO', NULL),
(300000000000000017, 100000000000000017, 2, 'EM ANÁLISE', NULL), (300000000000000018, 100000000000000018, 3, 'FECHADO', '2026-01-20 08:30:00'),
(300000000000000019, 100000000000000019, 1, 'ABERTO', NULL), (300000000000000020, 100000000000000020, 2, 'EM ANÁLISE', NULL),
(300000000000000021, 100000000000000021, 3, 'FECHADO', '2026-01-22 13:10:00'), (300000000000000022, 100000000000000022, 1, 'ABERTO', NULL),
(300000000000000023, 100000000000000023, 2, 'EM ANÁLISE', NULL), (300000000000000024, 100000000000000024, 3, 'FECHADO', '2026-01-24 17:55:00'),
(300000000000000025, 100000000000000025, 1, 'ABERTO', NULL), (300000000000000026, 100000000000000026, 2, 'EM ANÁLISE', NULL),
(300000000000000027, 100000000000000027, 3, 'FECHADO', '2026-01-26 10:40:00'), (300000000000000028, 100000000000000028, 1, 'ABERTO', NULL),
(300000000000000029, 100000000000000029, 2, 'EM ANÁLISE', NULL), (300000000000000030, 100000000000000030, 3, 'FECHADO', '2026-01-28 19:25:00');

-- 6. Mensagens
INSERT INTO mensagens_ticket (ticket_numero, autor_uid, conteudo_mensagem) VALUES 
(1, 100000000000000001, 'Qual a diferença entre VIP Mensal e Anual?'),
(2, 100000000000000002, 'Comprei o pacote de moedas e o saldo não atualizou.'),
(3, 100000000000000003, 'Usuário está vendendo produto fora do servidor.'),
(4, 100000000000000004, 'O cargo customizado inclui cor do nome no chat?'),
(5, 100000000000000005, 'Script da concessionária travou após o restart.'),
(6, 100000000000000006, 'Recebi mensagem suspeita pedindo pagamento via PIX externo.'),
(7, 100000000000000007, 'Lootbox lendária garante item raro?'),
(8, 100000000000000008, 'Key do Script HUD aparece como já utilizada.'),
(9, 100000000000000009, 'Membro está usando hack no evento do servidor.'),
(10, 100000000000000010, 'Posso transferir meu VIP para outra conta?'),
(11, 100000000000000011, 'Pagamento aprovado mas produto não foi entregue.'),
(12, 100000000000000012, 'Denúncia contra vendedor de conta compartilhada.'),
(13, 100000000000000013, 'Passe de batalha renova automaticamente?'),
(14, 100000000000000014, 'Erro 403 ao resgatar Script Garagem.'),
(15, 100000000000000015, 'Spam de convite em massa no canal geral.'),
(16, 100000000000000016, 'Membro fundador ainda tem vagas disponíveis?'),
(17, 100000000000000017, 'Cobrança duplicada no cartão para o mesmo pedido.'),
(18, 100000000000000018, 'Reportar golpe de falso suporte no privado.'),
(19, 100000000000000019, 'Tag colorida funciona em todos os canais?'),
(20, 100000000000000020, 'Script do hospital não inicia após atualização.'),
(21, 100000000000000021, 'Usuário ameaçou staff no ticket anterior.'),
(22, 100000000000000022, 'Cupom BLACKFRIDAY não está sendo aplicado.'),
(23, 100000000000000023, 'Link de download do Script Celular expirou.'),
(24, 100000000000000024, 'Conta clonada tentando vender keys roubadas.'),
(25, 100000000000000025, 'Booster de XP acumula com evento do servidor?'),
(26, 100000000000000026, 'Reembolso pendente há mais de uma semana.'),
(27, 100000000000000027, 'Jogador divulgando servidor rival no ticket.'),
(28, 100000000000000028, 'Acesso beta libera todos os scripts ou só um?'),
(29, 100000000000000029, 'PIX pago mas status do pedido continua pendente.'),
(30, 100000000000000030, 'Solicito revisão de banimento por engano.');

-- Respostas de moderadores (Admin/Suporte) em tickets de outros usuários
INSERT INTO mensagens_ticket (ticket_numero, autor_uid, conteudo_mensagem) VALUES
(1, 100000000000000002, 'Olá! Sou do Suporte, como posso ajudar?'),
(2, 100000000000000001, 'Verificando sua key no sistema.'),
(3, 100000000000000004, 'Denúncia recebida, vamos analisar.'),
(4, 100000000000000005, 'Pode detalhar sua dúvida sobre o produto?'),
(5, 100000000000000007, 'Reenviamos a key para seu e-mail.'),
(6, 100000000000000010, 'Caso registrado com prioridade alta.'),
(7, 100000000000000011, 'Aguarde, estou consultando o estoque.'),
(8, 100000000000000013, 'Key localizada, enviando agora.'),
(9, 100000000000000016, 'Moderador assumiu o atendimento.'),
(10, 100000000000000017, 'Pode informar o número do pedido?'),
(11, 100000000000000019, 'Problema resolvido, confira seu inventário.'),
(12, 100000000000000022, 'Obrigado pelo contato, ticket em análise.'),
(13, 100000000000000023, 'Suporte técnico a caminho.'),
(14, 100000000000000025, 'Verifique a pasta de spam.'),
(15, 100000000000000026, 'Denúncia encaminhada à equipe Admin.');

-- 7. Pedidos (com cupons nos primeiros 15 pedidos)
INSERT INTO pedidos (comprador_uid, cupom_codigo, valor_final, status_pedido) VALUES 
(100000000000000001, 1, 2500, 'Pago'), (100000000000000002, 2, 1500, 'Pendente'), 
(100000000000000003, 3, 5000, 'Pago'), (100000000000000004, 1, 3500, 'Cancelado'),
(100000000000000005, 2, 8000, 'Pago'), (100000000000000006, 3, 12000, 'Pendente'),
(100000000000000007, 1, 15000, 'Pago'), (100000000000000008, 2, 25000, 'Cancelado'),
(100000000000000009, 3, 3000, 'Pago'), (100000000000000010, 1, 4500, 'Pendente'),
(100000000000000011, 2, 2500, 'Pago'), (100000000000000012, 3, 1500, 'Pendente'),
(100000000000000013, 1, 5000, 'Pago'), (100000000000000014, 2, 3500, 'Cancelado'),
(100000000000000015, 3, 8000, 'Pago'), (100000000000000016, NULL, 12000, 'Pendente'),
(100000000000000017, NULL, 15000, 'Pago'), (100000000000000018, NULL, 25000, 'Cancelado'),
(100000000000000019, NULL, 3000, 'Pago'), (100000000000000020, NULL, 4500, 'Pendente'),
(100000000000000021, NULL, 2500, 'Pago'), (100000000000000022, NULL, 1500, 'Pendente'),
(100000000000000023, NULL, 5000, 'Pago'), (100000000000000024, NULL, 3500, 'Cancelado'),
(100000000000000025, NULL, 8000, 'Pago'), (100000000000000026, NULL, 12000, 'Pendente'),
(100000000000000027, NULL, 15000, 'Pago'), (100000000000000028, NULL, 25000, 'Cancelado'),
(100000000000000029, NULL, 3000, 'Pago'), (100000000000000030, NULL, 4500, 'Pendente'),
(100000000000000031, NULL, 2000, 'Pendente');

-- 8. Itens Pedido
INSERT INTO itens_pedido (pedido_numero, produto_codigo, quantidade_comprada) VALUES 
(1, 1, 1), (2, 2, 2), (3, 3, 1), (4, 4, 3), (5, 5, 1), (6, 6, 2),
(7, 7, 1), (8, 8, 1), (9, 9, 2), (10, 10, 1), (11, 11, 3), (12, 12, 1),
(13, 13, 1), (14, 14, 2), (15, 15, 1), (16, 16, 1), (17, 17, 3), (18, 18, 1),
(19, 19, 1), (20, 20, 2), (21, 21, 1), (22, 22, 1), (23, 23, 3), (24, 24, 1),
(25, 25, 1), (26, 26, 2), (27, 27, 1), (28, 28, 1), (29, 29, 3), (30, 30, 1),
(31, 1, 1);

-- 9. Pagamentos (30 registros; pedido 31 sem pagamento — RIGHT JOIN consulta 2)
INSERT INTO pagamentos (pedido_numero, forma_codigo, codigo_transacao, status_pagamento, data_atualizacao) VALUES 
(1, 1, 'TRX-101', 'Aprovado', '2026-01-15 10:00:00'),
(2, 2, 'TRX-102', 'Pendente', '2026-02-10 11:00:00'),
(3, 3, 'TRX-103', 'Aprovado', '2026-02-20 12:00:00'),
(4, 1, 'TRX-104', 'Recusado', '2026-03-05 09:00:00'),
(5, 2, 'TRX-105', 'Aprovado', '2026-03-18 14:00:00'),
(6, 3, 'TRX-106', 'Pendente', '2026-03-22 08:00:00'),
(7, 1, 'TRX-107', 'Aprovado', '2026-04-02 16:00:00'),
(8, 2, 'TRX-108', 'Recusado', '2026-04-11 10:30:00'),
(9, 3, 'TRX-109', 'Aprovado', '2026-04-25 13:00:00'),
(10, 1, 'TRX-110', 'Pendente', '2026-05-03 09:15:00'),
(11, 2, 'TRX-111', 'Aprovado', '2026-05-12 17:00:00'),
(12, 3, 'TRX-112', 'Pendente', '2026-05-20 11:45:00'),
(13, 1, 'TRX-113', 'Aprovado', '2026-01-28 15:00:00'),
(14, 2, 'TRX-114', 'Recusado', '2026-02-14 12:00:00'),
(15, 3, 'TRX-115', 'Aprovado', '2026-03-30 18:00:00'),
(16, 1, 'TRX-116', 'Pendente', '2026-04-08 10:00:00'),
(17, 2, 'TRX-117', 'Aprovado', '2026-05-01 14:30:00'),
(18, 3, 'TRX-118', 'Recusado', '2026-05-15 09:00:00'),
(19, 1, 'TRX-119', 'Aprovado', '2026-01-20 11:00:00'),
(20, 2, 'TRX-120', 'Pendente', '2026-02-25 16:00:00'),
(21, 3, 'TRX-121', 'Aprovado', '2026-03-12 13:30:00'),
(22, 1, 'TRX-122', 'Pendente', '2026-04-19 08:45:00'),
(23, 2, 'TRX-123', 'Aprovado', '2026-05-08 19:00:00'),
(24, 3, 'TRX-124', 'Recusado', '2026-05-22 10:00:00'),
(25, 1, 'TRX-125', 'Aprovado', '2026-02-05 12:00:00'),
(26, 2, 'TRX-126', 'Pendente', '2026-03-08 15:00:00'),
(27, 3, 'TRX-127', 'Aprovado', '2026-04-15 11:00:00'),
(28, 1, 'TRX-128', 'Recusado', '2026-05-10 14:00:00'),
(29, 2, 'TRX-129', 'Aprovado', '2026-05-25 17:30:00'),
(30, 3, 'TRX-130', 'Pendente', '2026-06-01 10:00:00');

-- 10. Avaliacoes (30 registros — um por ticket)
INSERT INTO avaliacoes_atendimento (ticket_numero, nota_avaliacao, comentario) VALUES 
(1, 4, 'Explicaram bem a diferença entre os VIPs.'),
(2, 3, 'Ainda aguardando confirmação do saldo.'),
(3, 5, 'Denúncia tratada com seriedade.'),
(4, 4, 'Resposta clara sobre o cargo customizado.'),
(5, 3, 'Demorou para reiniciar o script, mas resolveu.'),
(6, 4, 'Prioridade alta foi cumprida.'),
(7, 5, 'Tiraram minha dúvida sobre a lootbox na hora.'),
(8, 2, 'Key continua inválida após o suporte.'),
(9, 5, 'Hack reportado e equipe agiu rápido.'),
(10, 4, 'Orientaram sobre transferência de VIP.'),
(11, 3, 'Produto entregue, mas demorou mais que o esperado.'),
(12, 4, 'Denúncia encaminhada corretamente.'),
(13, 5, 'Passe de batalha explicado com detalhes.'),
(14, 4, 'Script Garagem funcionou após a correção.'),
(15, 5, 'Spam no canal foi resolvido.'),
(16, 3, 'Vagas de membro fundador ainda não ficaram claras.'),
(17, 4, 'Cobrança duplicada em análise, atendimento ok.'),
(18, 2, 'Golpe no privado não foi totalmente resolvido.'),
(19, 5, 'Tag colorida configurada sem problemas.'),
(20, 4, 'Hospital script voltou após atualização.'),
(21, 5, 'Ameaça ao staff foi registrada e tratada.'),
(22, 3, 'Cupom ainda não aplicado no checkout.'),
(23, 4, 'Novo link do Script Celular enviado.'),
(24, 5, 'Conta clonada identificada e bloqueada.'),
(25, 4, 'Booster de XP esclarecido com exemplos.'),
(26, 3, 'Reembolso segue pendente, suporte foi educado.'),
(27, 5, 'Divulgação de servidor rival foi advertida.'),
(28, 4, 'Acesso beta explicado item por item.'),
(29, 3, 'PIX reconhecido, mas pedido ainda pendente no painel.'),
(30, 1, 'Banimento não revisado, experiência muito ruim.');

-- 11. Blacklist (30 registros)
INSERT INTO blacklist (banido_uid, motivo_banimento) VALUES 
(100000000000000001, 'Spam em canais de venda'),
(100000000000000002, 'Tentativa de chargeback'),
(100000000000000003, 'Revenda não autorizada de keys'),
(100000000000000004, 'Fraude'),
(100000000000000005, 'Phishing via DM'),
(100000000000000006, 'Uso de múltiplas contas'),
(100000000000000007, 'Divulgação de servidor concorrente'),
(100000000000000008, 'Xingou o admin'),
(100000000000000009, 'Abuso do sistema de tickets'),
(100000000000000010, 'Compartilhamento de conta'),
(100000000000000011, 'Exploração de bug de pagamento'),
(100000000000000012, 'Conteúdo impróprio no servidor'),
(100000000000000013, 'Assédio a membros'),
(100000000000000014, 'Hack'),
(100000000000000015, 'Venda externa de produtos digitais'),
(100000000000000016, 'Falsificação de comprovante PIX'),
(100000000000000017, 'Tentativa de estorno indevido'),
(100000000000000018, 'Bot malicioso no perfil'),
(100000000000000019, 'Roubo de identidade'),
(100000000000000020, 'Discurso de ódio'),
(100000000000000021, 'Evadiu banimento anterior'),
(100000000000000022, 'Manipulação de avaliações'),
(100000000000000023, 'Distribuição de malware'),
(100000000000000024, 'Fraude em leilão interno'),
(100000000000000025, 'Violação repetida das regras'),
(100000000000000026, 'Conta comprometida'),
(100000000000000027, 'Golpe em novo membro'),
(100000000000000028, 'Abuso de cupom de desconto'),
(100000000000000029, 'Ameaça a moderadores'),
(100000000000000030, 'Uso de VPN para burlar região');

-- 12. Reembolsos
INSERT INTO reembolsos_revogacoes (pedido_numero, motivo_reembolso, status_reembolso) VALUES
(1, 'Produto duplicado', 'Aprovado'), (2, 'Desistência da compra', 'Pendente'),
(3, 'Erro na entrega', 'Aprovado'), (4, 'Cancelamento solicitado', 'Negado'),
(5, 'Produto não funcionou', 'Aprovado'), (6, 'Arrependimento', 'Pendente'),
(7, 'Cobrança indevida', 'Aprovado'), (8, 'Fraude detectada', 'Negado'),
(9, 'Key inválida', 'Aprovado'), (10, 'Aguardando análise', 'Pendente'),
(11, 'Produto errado', 'Aprovado'), (12, 'Desistência', 'Pendente'),
(13, 'Duplicidade', 'Aprovado'), (14, 'Violação de termos', 'Negado'),
(15, 'Defeito no script', 'Aprovado'), (16, 'Mudou de ideia', 'Pendente'),
(17, 'Não recebeu produto', 'Aprovado'), (18, 'Chargeback', 'Negado'),
(19, 'Produto expirado', 'Aprovado'), (20, 'Análise em andamento', 'Pendente'),
(21, 'Erro no pagamento', 'Aprovado'), (22, 'Desistência', 'Pendente'),
(23, 'Key já utilizada', 'Aprovado'), (24, 'Fraude', 'Negado'),
(25, 'Produto incompleto', 'Aprovado'), (26, 'Aguardando docs', 'Pendente'),
(27, 'Script com bug', 'Aprovado'), (28, 'Violação regras', 'Negado'),
(29, 'Entrega atrasada', 'Aprovado'), (30, 'Solicitação pendente', 'Pendente');

-- 13. Logs de Auditoria
INSERT INTO logs_auditoria (admin_uid, tabela_afetada, registro_id, acao, detalhes) VALUES
(100000000000000001, 'produtos', 1, 'EDITAR', 'Preço do VIP Mensal alterado'),
(100000000000000001, 'produtos', 2, 'EDITAR', 'Descrição do VIP Anual atualizada'),
(100000000000000004, 'permissoes', 1, 'EDITAR', 'Permissão gerenciar_produtos revisada'),
(100000000000000007, 'produtos', 5, 'CRIAR', 'Novo produto Lootbox cadastrado'),
(100000000000000010, 'blacklist', 4, 'CRIAR', 'Banimento por fraude registrado'),
(100000000000000013, 'produtos', 7, 'DESATIVAR', 'Script HUD temporariamente indisponível'),
(100000000000000016, 'permissoes', 2, 'EDITAR', 'Permissão banir_membros atualizada'),
(100000000000000019, 'produtos', 10, 'EDITAR', 'Preço Sócio do Servidor ajustado'),
(100000000000000022, 'reembolsos_revogacoes', 1, 'APROVAR', 'Reembolso do pedido 1 aprovado'),
(100000000000000025, 'produtos', 15, 'ATIVAR', 'Sistema de Empregos reativado'),
(100000000000000028, 'permissoes', 3, 'EDITAR', 'Permissão responder_tickets revisada'),
(100000000000000001, 'produtos', 20, 'EDITAR', 'Chave de Baú Raro — preço reduzido'),
(100000000000000004, 'produtos', 25, 'EDITAR', 'Desbanimento Conta — política atualizada'),
(100000000000000007, 'blacklist', 8, 'CRIAR', 'Banimento por ofensa a admin registrado'),
(100000000000000010, 'produtos', 30, 'CRIAR', 'Script Celular lançado'),
(100000000000000013, 'reembolsos_revogacoes', 5, 'APROVAR', 'Reembolso pedido 5 processado'),
(100000000000000016, 'produtos', 12, 'EDITAR', 'Script Garagem — correção de bug'),
(100000000000000019, 'permissoes', 1, 'CRIAR', 'Nova permissão adicionada ao Admin'),
(100000000000000022, 'produtos', 18, 'DESATIVAR', 'Script Hospital em manutenção'),
(100000000000000025, 'reembolsos_revogacoes', 9, 'NEGAR', 'Reembolso pedido 9 negado'),
(100000000000000028, 'produtos', 22, 'EDITAR', 'Acesso Beta — vagas limitadas'),
(100000000000000001, 'cupons', 1, 'EDITAR', 'Cupom NATAL20 estendido'),
(100000000000000004, 'produtos', 28, 'EDITAR', 'Membro Fundador — preço revisado'),
(100000000000000007, 'reembolsos_revogacoes', 13, 'APROVAR', 'Reembolso pedido 13 aprovado'),
(100000000000000010, 'permissoes', 2, 'REMOVER', 'Permissão obsoleta removida'),
(100000000000000013, 'produtos', 3, 'EDITAR', 'Cargo Customizado — novo preço'),
(100000000000000016, 'blacklist', 14, 'CRIAR', 'Banimento por hack registrado'),
(100000000000000019, 'produtos', 24, 'ATIVAR', 'Script Cassino disponível'),
(100000000000000022, 'reembolsos_revogacoes', 17, 'APROVAR', 'Reembolso pedido 17 concluído'),
(100000000000000025, 'produtos', 8, 'EDITAR', 'Script Concessionária atualizado'),
(100000000000000028, 'permissoes', 3, 'CRIAR', 'Nova permissão para Suporte');
