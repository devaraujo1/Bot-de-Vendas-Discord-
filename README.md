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

---

## Estrutura do Repositório

```text
Bot-de-Vendas-Discord/
│
├── README.md
├── Instruções.md
├── DATABASE_SCHEMA.md
├── 00_executar_tudo.sql
├── executar_tudo.ps1
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

---

## Como Executar

### Pré-requisitos

- PostgreSQL 14+ instalado
- Cliente `psql` no PATH

### Criar o banco (uma vez)

```bash
psql -U postgres -c "CREATE DATABASE bot_vendas_discord;"
```

Defina a senha do PostgreSQL:

```bash
# Linux/macOS
export PGPASSWORD="sua_senha"

# Windows PowerShell
$env:PGPASSWORD = "sua_senha"
```

### Opção A — Script mestre (recomendado)

```powershell
.\executar_tudo.ps1 -DbPassword "sua_senha"
```

Ou no Linux/macOS:

```bash
psql -U postgres -d bot_vendas_discord -f "00_executar_tudo.sql"
```

### Opção B — Arquivos individuais (ordem obrigatória)

```bash
psql -U postgres -d bot_vendas_discord -f "DDL/01_criacao_tabelas.sql"
psql -U postgres -d bot_vendas_discord -f "DML/02_insercao_dados.sql"
psql -U postgres -d bot_vendas_discord -f "DPL/05_procedures_triggers_views.sql"
psql -U postgres -d bot_vendas_discord -f "DQL/03_consultas_joins.sql"
psql -U postgres -d bot_vendas_discord -f "DQL/04_consultas_agregacao.sql"
```

A sequência respeita: **DROP → CREATE → INSERT → DPL → DQL**.

---

## Entregas por Parte

| Parte | Conteúdo | Arquivo |
|-------|----------|---------|
| 02 | DDL (DROP, CREATE, PK/FK/NOT NULL/UNIQUE) | `DDL/01_criacao_tabelas.sql` |
| 02 | DML (auxiliares ≥3, core ≥30 registros) | `DML/02_insercao_dados.sql` |
| 03 | 12 consultas INNER / LEFT / RIGHT JOIN | `DQL/03_consultas_joins.sql` |
| 04 | 12 consultas GROUP BY / UNION / INTERSECT | `DQL/04_consultas_agregacao.sql` |
| 05 | 3 procedures, 3 triggers, 3 functions, 3 views | `DPL/05_procedures_triggers_views.sql` |

---

## Notas sobre DPL

- `GerarVendaPix` e novos `INSERT` em `pedidos` exigem utilizador **fora da `blacklist`** (trigger `VerificarBloqueioUsuario`).
- `LogAuditoriaAdmin` requer `SET app.admin_uid = '...'` antes de `UPDATE`/`DELETE` em `produtos` ou `permissoes`.
- Utilizadores **31** e **32** não estão banidos — use-os nos testes manuais das procedures.

---

## Testes

**Validado em:** PostgreSQL 17 (Windows) — junho/2026

Execução completa (`01 → 02 → 05 → 03 → 04`) via `executar_tudo.ps1` **sem erros** de FK ou de ordem.

| Verificação | Resultado |
|-------------|-----------|
| `pagamentos` | 30 registros |
| `blacklist` | 30 registros |
| `pedidos` | 31 registros (pedido 31 sem pagamento para RIGHT JOIN) |
| Consulta 10 (Parte 03) | 3 banimentos com logs coerentes (códigos 4, 8, 14) |
| Views DPL | `DashboardVendasAtivas`, `TicketsPendentesModeracao`, `ProdutosMaisPopulares` |
| DQL Partes 03 e 04 | 24 consultas executadas com retorno |

Para revalidar:

```powershell
.\executar_tudo.ps1 -DbPassword "sua_senha"
```

Consultas de exemplo após a carga:

```sql
SELECT COUNT(*) FROM pagamentos;
SELECT COUNT(*) FROM blacklist;
SELECT * FROM DashboardVendasAtivas LIMIT 5;
```

---

## Domínio do Sistema

O modelo cobre:

- Utilizadores, cargos e permissões do servidor Discord
- Catálogo de produtos digitais e estoque (keys/links)
- Tickets de suporte e avaliações
- Pedidos, pagamentos (PIX), cupons e reembolsos
- Blacklist e logs de auditoria administrativa
