# Projeto: Bot de Vendas e Suporte (Discord)

## Visão Geral

Este projeto modela um **banco de dados relacional** para suportar um **bot de vendas digitais e atendimento ao cliente** integrado à plataforma **Discord**.

O escopo é exclusivamente **SQL** (DDL, DML, DQL e DPL) — não há implementação do bot ou código de aplicação.

**SGBD:** PostgreSQL

---

## Objetivos

- Modelar um banco relacional modular para e-commerce digital
- Organizar dados de usuários, produtos, vendas, tickets e auditoria
- Aplicar integridade referencial, normalização e boas práticas de modelagem
- Entregar as Partes 02 a 05 conforme [`Instruções.md`](Instruções.md)

--

## Estrutura do Repositório

```text
Bot-de-Vendas-Discord/
│
├── README.md
├── Instruções.md
├── DATABASE_SCHEMA.md
│
├── DDL/
│   └── 01_criacao_tabelas.sql       Parte 02 — DROP + CREATE
│
├── DML/
│   └── 02_insercao_dados.sql         Parte 02 — INSERT
│
├── DQL/
│   ├── 03_consultas_joins.sql        Parte 03 — 12 JOINs
│   └── 04_consultas_agregacao.sql    Parte 04 — 12 agregações
│
└── DPL/
    └── 05_procedures_triggers_views.sql  Parte 05 — DPL
```

Documentação detalhada das tabelas: [`DATABASE_SCHEMA.md`](DATABASE_SCHEMA.md)

## Domínio do Sistema

O modelo cobre:

- Utilizadores, cargos e permissões do servidor Discord
- Catálogo de produtos digitais e estoque (keys/links)
- Tickets de suporte e avaliações
- Pedidos, pagamentos (PIX), cupons e reembolsos
- Blacklist e logs de auditoria administrativa
