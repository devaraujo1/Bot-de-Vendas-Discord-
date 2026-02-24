# 🧩 Projeto: Bot de Vendas e Suporte (Discord)

## 📌 Visão Geral

Este projeto tem como objetivo a **modelagem e estruturação de um banco de dados relacional**, desenvolvido para suportar um **bot de vendas digitais e atendimento ao cliente** integrado à plataforma **:contentReference[oaicite:0]{index=0}**.

O foco do trabalho está na **organização dos dados**, **definição das entidades**, **relacionamentos**, **permissões** e **fluxos operacionais**, utilizando exclusivamente **SQL (DDL/DML)**, conforme o escopo acadêmico da disciplina de Banco de Dados / Estrutura de Dados.

Não há implementação de bot ou código de aplicação — apenas **modelagem e scripts SQL**.

---

## 🎯 Objetivos do Projeto

- Modelar um banco de dados relacional modular e escalável  
- Representar um sistema real de e-commerce digital  
- Organizar dados de usuários, produtos, vendas e suporte  
- Aplicar boas práticas de modelagem e normalização  
- Facilitar manutenção, leitura e correção acadêmica  

---

## 🧠 Domínio do Sistema

O sistema foi idealizado para dar suporte a um bot multifuncional capaz de:

- Gerenciar utilizadores e cargos  
- Controlar permissões por nível de acesso  
- Automatizar vendas de produtos digitais  
- Gerar e controlar pagamentos via PIX  
- Organizar atendimentos por sistema de tickets  
- Registrar auditorias, reembolsos e bloqueios  

A arquitetura prioriza **integridade referencial**, **clareza nos relacionamentos** e **facilidade de expansão futura**.

---

## 🧱 Organização do Projeto

O projeto está organizado de forma **modular**, onde cada módulo representa uma área funcional do sistema.  

### 📂 Estrutura de pastas

```text
Bot-de-Vendas-Discord
│
├── README.md
│
├── database/
│   │
│   ├── entidades_atributos.md
│   │
│   ├── modulo_01_usuarios_cargos/
│   │   └── usuarios_cargos_database.sql
│   │
│   ├── modulo_02_catalogo_produtos/
│   │   └── catalogo_produtos_database.sql
│   │
│   ├── modulo_03_tickets_atendimento/
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
│   │   └── tickets_atendimento_database.sql
│   │
│   ├── modulo_04_vendas_financeiro/
│   │   └── vendas_financeiro_database.sql
│   │
│   └── modulo_05_seguranca_pos_venda/
│       └── seguranca_pos_venda_database.sql
│ 
└── LICENSE

