DROP TABLE IF EXISTS avaliacoes_atendimento;
DROP TABLE IF EXISTS mensagens_ticket;
DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS tipos_ticket;

CREATE TABLE tipos_ticket (
    id_tipo SERIAL PRIMARY KEY,
    nome_tipo VARCHAR(100) NOT NULL,
    descricao VARCHAR(255)
);

CREATE TABLE tickets (
    id_ticket SERIAL PRIMARY KEY,
    id_canal_discord BIGINT NOT NULL,
    id_dono_discord BIGINT NOT NULL,
    id_tipo INT NOT NULL,
    status VARCHAR(50) DEFAULT 'ABERTO',
    data_abertura TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_fechamento TIMESTAMP NULL,
    CONSTRAINT fk_tipo
        FOREIGN KEY (id_tipo)
        REFERENCES tipos_ticket(id_tipo)
);

CREATE TABLE mensagens_ticket (
    id_mensagem SERIAL PRIMARY KEY,
    id_ticket INT NOT NULL,
    id_autor_discord BIGINT NOT NULL,
    conteudo TEXT NOT NULL,
    data_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_ticket
        FOREIGN KEY (id_ticket)
        REFERENCES tickets(id_ticket)
);

CREATE TABLE avaliacoes_atendimento (
    id_avaliacao SERIAL PRIMARY KEY,
    id_ticket INT NOT NULL,
    nota INT CHECK (nota BETWEEN 1 AND 5),
    comentario TEXT,
    CONSTRAINT fk_ticket_avaliacao
        FOREIGN KEY (id_ticket)
        REFERENCES tickets(id_ticket)
);

INSERT INTO tipos_ticket (nome_tipo, descricao) VALUES
('Suporte Técnico', 'Problemas técnicos no sistema'),
('Denúncia', 'Denúncia de comportamento inadequado'),
('Dúvida', 'Dúvidas gerais sobre o servidor');

INSERT INTO tickets (id_canal_discord, id_dono_discord, id_tipo, status) VALUES
(1001,5001,1,'ABERTO'),
(1002,5002,2,'ABERTO'),
(1003,5003,3,'FECHADO'),
(1004,5004,1,'ABERTO'),
(1005,5005,2,'ABERTO'),
(1006,5006,3,'FECHADO'),
(1007,5007,1,'ABERTO'),
(1008,5008,2,'ABERTO'),
(1009,5009,3,'ABERTO'),
(1010,5010,1,'FECHADO'),
(1011,5011,2,'ABERTO'),
(1012,5012,3,'ABERTO'),
(1013,5013,1,'ABERTO'),
(1014,5014,2,'FECHADO'),
(1015,5015,3,'ABERTO'),
(1016,5016,1,'ABERTO'),
(1017,5017,2,'ABERTO'),
(1018,5018,3,'FECHADO'),
(1019,5019,1,'ABERTO'),
(1020,5020,2,'ABERTO'),
(1021,5021,3,'ABERTO'),
(1022,5022,1,'FECHADO'),
(1023,5023,2,'ABERTO'),
(1024,5024,3,'ABERTO'),
(1025,5025,1,'ABERTO'),
(1026,5026,2,'FECHADO'),
(1027,5027,3,'ABERTO'),
(1028,5028,1,'ABERTO'),
(1029,5029,2,'ABERTO'),
(1030,5030,3,'FECHADO');

INSERT INTO mensagens_ticket (id_ticket, id_autor_discord, conteudo) VALUES
(1,5001,'Preciso de ajuda com erro no bot'),
(2,5002,'Quero denunciar um usuário'),
(3,5003,'Tenho dúvida sobre as regras'),
(4,5004,'Sistema apresentou erro'),
(5,5005,'Usuário enviando spam'),
(6,5006,'Como funciona o sistema de cargos?'),
(7,5007,'Erro ao abrir ticket'),
(8,5008,'Comportamento ofensivo'),
(9,5009,'Dúvida sobre eventos'),
(10,5010,'Bug encontrado no bot'),
(11,5011,'Denúncia de flood'),
(12,5012,'Pergunta sobre permissões'),
(13,5013,'Erro ao enviar mensagem'),
(14,5014,'Denúncia de insultos'),
(15,5015,'Dúvida sobre canais'),
(16,5016,'Sistema travando'),
(17,5017,'Usuário desrespeitando regras'),
(18,5018,'Pergunta sobre moderação'),
(19,5019,'Problema ao logar'),
(20,5020,'Denúncia de spam'),
(21,5021,'Dúvida sobre cargos'),
(22,5022,'Erro no sistema'),
(23,5023,'Denúncia de comportamento tóxico'),
(24,5024,'Pergunta sobre comandos'),
(25,5025,'Bug em comando'),
(26,5026,'Usuário abusando do chat'),
(27,5027,'Dúvida sobre regras'),
(28,5028,'Erro ao abrir canal'),
(29,5029,'Denúncia de ofensas'),
(30,5030,'Pergunta sobre suporte');

INSERT INTO avaliacoes_atendimento (id_ticket, nota, comentario) VALUES
(3,5,'Atendimento excelente'),
(6,4,'Resolveu meu problema'),
(10,3,'Demorou um pouco'),
(14,5,'Muito bom'),
(18,4,'Bom atendimento'),
(22,2,'Poderia ser melhor'),
(26,5,'Perfeito'),
(30,4,'Satisfeito');
