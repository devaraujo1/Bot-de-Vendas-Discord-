-- ======================================================================
-- Script mestre — Bot de Vendas Discord
-- SGBD: PostgreSQL
-- Ordem: DROP → CREATE → INSERT → DPL → DQL
-- ======================================================================
-- Uso (na raiz do projeto):
--   psql -U postgres -d bot_vendas_discord -f "00_executar_tudo.sql"
-- Windows: .\executar_tudo.ps1 -DbPassword "sua_senha"
-- ======================================================================

\echo '>>> 1/5 DDL — DROP + CREATE'
\ir 'DDL/01_criacao_tabelas.sql'

\echo '>>> 2/5 DML — INSERT'
\ir 'DML/02_insercao_dados.sql'

\echo '>>> 3/5 DPL — Procedures, Triggers, Functions, Views'
\ir 'DPL/05_procedures_triggers_views.sql'

\echo '>>> 4/5 DQL — Consultas JOIN (Parte 03)'
\ir 'DQL/03_consultas_joins.sql'

\echo '>>> 5/5 DQL — Consultas de Agregação (Parte 04)'
\ir 'DQL/04_consultas_agregacao.sql'

\echo '>>> Execução concluída.'
