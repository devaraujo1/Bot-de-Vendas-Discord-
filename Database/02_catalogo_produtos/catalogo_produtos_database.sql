CREATE TABLE categorias (
    id_categoria SERIAL,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    CONSTRAINT pk_categorias PRIMARY KEY (id_categoria)
);

CREATE TABLE produtos (
    id_produto SERIAL,
    id_categoria INT NOT NULL,
    nome VARCHAR(150) NOT NULL,
    preco_centavos INT NOT NULL,
    CONSTRAINT pk_produtos PRIMARY KEY (id_produto),
    CONSTRAINT fk_produtos_categoria
        FOREIGN KEY (id_categoria)
        REFERENCES categorias(id_categoria)
);

CREATE TABLE produto_imagens (
    id_imagem SERIAL,
    id_produto INT NOT NULL,
    url_imagem VARCHAR(255) NOT NULL,
    CONSTRAINT pk_produto_imagens PRIMARY KEY (id_imagem),
    CONSTRAINT fk_produto_imagens_produto
        FOREIGN KEY (id_produto)
        REFERENCES produtos(id_produto)
);

CREATE TABLE stock_digital (
    id_item SERIAL,
    id_produto INT NOT NULL,
    conteudo_entrega TEXT NOT NULL,
    vendido BOOLEAN DEFAULT FALSE,
    CONSTRAINT pk_stock_digital PRIMARY KEY (id_item),
    CONSTRAINT fk_stock_digital_produto
        FOREIGN KEY (id_produto)
        REFERENCES produtos(id_produto)
);

CREATE TABLE usuarios_cargos (
    id_usuario INT NOT NULL,
    id_cargo INT NOT NULL,
    CONSTRAINT pk_usuarios_cargos PRIMARY KEY (id_usuario, id_cargo),
    CONSTRAINT fk_usuarios_cargos_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario),
    CONSTRAINT fk_usuarios_cargos_cargo
        FOREIGN KEY (id_cargo)
        REFERENCES cargos(id_cargo)
);
