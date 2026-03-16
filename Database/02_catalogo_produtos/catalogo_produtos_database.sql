CREATE TABLE categorias (
    id_categoria SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT
);

CREATE TABLE produtos (
    id_produto SERIAL PRIMARY KEY,
    id_categoria INT NOT NULL,
    nome VARCHAR(150) NOT NULL,
    preco_centavos INT NOT NULL,
    CONSTRAINT fk_categoria_produto
        FOREIGN KEY (id_categoria)
        REFERENCES categorias(id_categoria)
);

CREATE TABLE produto_imagens (
    id_imagem SERIAL PRIMARY KEY,
    id_produto INT NOT NULL,
    url_imagem VARCHAR(255) NOT NULL,
    CONSTRAINT fk_imagem_produto
        FOREIGN KEY (id_produto)
        REFERENCES produtos(id_produto)
);

CREATE TABLE stock_digital (
    id_item SERIAL PRIMARY KEY,
    id_produto INT NOT NULL,
    conteudo_entrega TEXT NOT NULL,
    vendido BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_stock_produto
        FOREIGN KEY (id_produto)
        REFERENCES produtos(id_produto)
);

SELECT u.nome_discord, c.nome_cargo
FROM usuarios u
INNER JOIN usuarios_cargos uc ON u.id_usuario = uc.id_usuario
INNER JOIN cargos c ON uc.id_cargo = c.id_cargo;

SELECT v.id_venda, p.id_pagamento, p.valor
FROM vendas v
RIGHT JOIN pagamentos p ON p.id_venda = v.id_venda;

SELECT u.nome_discord, t.id_ticket
FROM usuarios u
LEFT JOIN tickets_suporte t ON u.id_usuario = t.id_usuario;

SELECT p.nome, c.nome
FROM produtos p
INNER JOIN categorias c ON p.id_categoria = c.id_categoria;

SELECT v.id_venda, s.conteudo_entrega
FROM vendas v
INNER JOIN stock_digital s ON v.id_item = s.id_item;

SELECT c.nome_cargo, u.nome_discord
FROM cargos c
LEFT JOIN usuarios_cargos uc ON c.id_cargo = uc.id_cargo
LEFT JOIN usuarios u ON uc.id_usuario = u.id_usuario;

SELECT t.id_ticket, u.nome_discord
FROM tickets_suporte t
INNER JOIN usuarios u ON t.id_moderador = u.id_usuario;

SELECT v.id_venda, pix.codigo_transacao
FROM vendas v
INNER JOIN transacoes_pix pix ON v.id_venda = pix.id_venda;

SELECT p.nome, a.acao
FROM produtos p
LEFT JOIN auditoria a ON p.id_produto = a.id_produto;

SELECT u.nome_discord, a.motivo
FROM usuarios u
INNER JOIN auditoria a ON u.id_usuario = a.id_usuario
WHERE a.tipo = 'bloqueio';

SELECT c.codigo_cupom, v.id_venda
FROM cupons c
INNER JOIN vendas v ON c.id_cupom = v.id_cupom;

SELECT a.nome_acao, u.nome_discord
FROM usuarios u
RIGHT JOIN acoes_admin a ON u.id_usuario = a.id_admin;
