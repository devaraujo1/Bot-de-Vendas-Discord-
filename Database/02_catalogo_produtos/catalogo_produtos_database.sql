CREATE TABLE tb_categorias (
    id_categoria SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT
);

CREATE TABLE tb_produtos (
    id_produto SERIAL PRIMARY KEY,
    id_categoria INT NOT NULL,
    nome VARCHAR(150) NOT NULL,
    preco_centavos INT NOT NULL,
    CONSTRAINT fk_categoria_produto
        FOREIGN KEY (id_categoria)
        REFERENCES tb_categorias(id_categoria)
);

CREATE TABLE tb_produto_imagens (
    id_imagem SERIAL PRIMARY KEY,
    id_produto INT NOT NULL,
    url_imagem VARCHAR(255) NOT NULL,
    CONSTRAINT fk_imagem_produto
        FOREIGN KEY (id_produto)
        REFERENCES tb_produtos(id_produto)
);

CREATE TABLE tb_stock_digital (
    id_item SERIAL PRIMARY KEY,
    id_produto INT NOT NULL,
    conteudo_entrega TEXT NOT NULL,
    vendido BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_stock_produto
        FOREIGN KEY (id_produto)
        REFERENCES tb_produtos(id_produto)
);
