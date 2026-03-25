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

INSERT INTO produtos (id_categoria, nome, descricao, preco) VALUES
(1, 'Windows 11 Pro OEM', 'Licença digital do Windows 11 Pro OEM', 89.90),
(1, 'Windows 10 Pro OEM', 'Licença digital do Windows 10 Pro OEM', 79.90),
(1, 'Office 2021 Professional Plus', 'Pacote Office 2021 Professional Plus', 119.90),
(1, 'Office 2019 Professional Plus', 'Pacote Office 2019 Professional Plus', 99.90),
(1, 'Microsoft 365 Personal 1 Ano', 'Assinatura Microsoft 365 Personal por 1 ano', 149.90),
(2, 'Kaspersky Standard 1 Dispositivo', 'Antivírus Kaspersky Standard para 1 dispositivo', 59.90),
(2, 'Kaspersky Plus 3 Dispositivos', 'Antivírus Kaspersky Plus para 3 dispositivos', 99.90),
(2, 'ESET NOD32 1 Ano', 'Licença ESET NOD32 por 1 ano', 54.90),
(2, 'Avast Premium Security', 'Licença Avast Premium Security', 69.90),
(2, 'Bitdefender Total Security', 'Licença Bitdefender Total Security', 89.90),
(3, 'Minecraft Java Edition', 'Chave digital do jogo Minecraft Java Edition', 79.90),
(3, 'Minecraft Bedrock Edition', 'Chave digital do jogo Minecraft Bedrock Edition', 74.90),
(3, 'The Witcher 3 Complete Edition', 'Chave digital The Witcher 3 Complete Edition', 59.90),
(3, 'Elden Ring', 'Chave digital do jogo Elden Ring', 149.90),
(3, 'Red Dead Redemption 2', 'Chave digital Red Dead Redemption 2', 109.90),
(3, 'Cyberpunk 2077', 'Chave digital Cyberpunk 2077', 119.90),
(3, 'FIFA 24', 'Chave digital EA Sports FC 24', 159.90),
(3, 'GTA V Premium Edition', 'Chave digital GTA V Premium Edition', 69.90),
(4, 'Spotify Premium 3 Meses', 'Gift card Spotify Premium 3 meses', 49.90),
(4, 'Netflix Gift Card 1 Mês', 'Gift card Netflix equivalente a 1 mês', 39.90),
(4, 'Google Play Gift Card 50', 'Gift card Google Play saldo 50', 50.00),
(4, 'PlayStation Store 100', 'Gift card PlayStation Store saldo 100', 100.00),
(4, 'Xbox Gift Card 50', 'Gift card Xbox saldo 50', 50.00),
(4, 'Steam Gift Card 20', 'Gift card Steam saldo 20', 20.00),
(5, 'Canva Pro 1 Ano', 'Assinatura Canva Pro por 1 ano', 89.90),
(5, 'Adobe Photoshop 1 Mês', 'Assinatura Adobe Photoshop por 1 mês', 79.90),
(5, 'CapCut Pro 1 Ano', 'Assinatura CapCut Pro por 1 ano', 69.90),
(5, 'NordVPN 1 Ano', 'Assinatura NordVPN por 1 ano', 129.90),
(5, 'ChatGPT Plus 1 Mês', 'Acesso premium por 1 mês', 99.90),
(5, 'Curso Excel Completo', 'Acesso ao curso completo de Excel', 39.90);

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
