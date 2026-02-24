CREATE TABLE tb_tipos_ticket (
    id_tipo SERIAL PRIMARY KEY,
    nome_tipo VARCHAR(100) NOT NULL,
    descricao VARCHAR(255)
);

CREATE TABLE tb_tickets (
    id_ticket SERIAL PRIMARY KEY,
    id_canal_discord BIGINT NOT NULL,
    id_dono_discord BIGINT NOT NULL,
    id_tipo INT NOT NULL,
    status VARCHAR(50) DEFAULT 'ABERTO',
    data_abertura TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_fechamento TIMESTAMP NULL,
    
    CONSTRAINT fk_tipo
        FOREIGN KEY (id_tipo)
        REFERENCES tb_tipos_ticket(id_tipo)
);

CREATE TABLE tb_mensagens_ticket (
    id_mensagem SERIAL PRIMARY KEY,
    id_ticket INT NOT NULL,
    id_autor_discord BIGINT NOT NULL,
    conteudo TEXT NOT NULL,
    data_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_ticket
        FOREIGN KEY (id_ticket)
        REFERENCES tb_tickets(id_ticket)
);

CREATE TABLE tb_avaliacoes_atendimento (
    id_avaliacao SERIAL PRIMARY KEY,
    id_ticket INT NOT NULL,
    nota INT CHECK (nota BETWEEN 1 AND 5),
    comentario TEXT,
    
    CONSTRAINT fk_ticket_avaliacao
        FOREIGN KEY (id_ticket)
        REFERENCES tb_tickets(id_ticket)
);
  
