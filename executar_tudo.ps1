# Script mestre - Bot de Vendas Discord (Windows)
# Ordem: DROP DB -> CREATE DB -> DDL -> DML -> DPL -> DQL
# Uso: .\executar_tudo.ps1

param(
    [string]$DbName = "bot_vendas_discord",
    [string]$DbUser = "postgres",
    [string]$DbHost = "localhost",
    [Parameter(Mandatory = $true)]
    [string]$DbPassword
)

$ErrorActionPreference = "Stop"
$env:PGPASSWORD = $DbPassword

$psql = Get-Command psql -ErrorAction SilentlyContinue
if (-not $psql) {
    $defaultPsql = "C:\Program Files\PostgreSQL\17\bin\psql.exe"
    if (Test-Path $defaultPsql) { $psql = $defaultPsql } else { throw "psql nao encontrado no PATH." }
} else {
    $psql = $psql.Source
}

$root = $PSScriptRoot

function Invoke-SqlFile {
    param([string]$Label, [string]$Pattern)
    $file = Get-ChildItem -Path $root -Recurse -Filter "*$Pattern" -File | Select-Object -First 1
    if (-not $file) { throw "Arquivo nao encontrado: $Pattern" }
    Write-Host "[${Label}] $($file.Name)"
    $tempSql = Join-Path $env:TEMP ("bot_vendas_" + $Pattern)
    Copy-Item -LiteralPath $file.FullName -Destination $tempSql -Force
    try {
        & $psql -U $DbUser -h $DbHost -d $DbName -f $tempSql -v ON_ERROR_STOP=1
        if ($LASTEXITCODE -ne 0) { throw "Falha ao executar $Pattern" }
    } finally {
        Remove-Item -LiteralPath $tempSql -Force -ErrorAction SilentlyContinue
    }
}

Write-Host "[DB] Recriando banco $DbName"
& $psql -U $DbUser -h $DbHost -c "DROP DATABASE IF EXISTS $DbName;"
if ($LASTEXITCODE -ne 0) { throw 'Falha no DROP DATABASE' }
& $psql -U $DbUser -h $DbHost -c "CREATE DATABASE $DbName;"
if ($LASTEXITCODE -ne 0) { throw 'Falha no CREATE DATABASE' }

Invoke-SqlFile '1/5 DDL' '01_criacao_tabelas.sql'
Invoke-SqlFile '2/5 DML' '02_insercao_dados.sql'
Invoke-SqlFile '3/5 DPL' '05_procedures_triggers_views.sql'
Invoke-SqlFile '4/5 DQL JOINs' '03_consultas_joins.sql'
Invoke-SqlFile '5/5 DQL Agregacao' '04_consultas_agregacao.sql'

Write-Host '[VALIDACAO] Contagens'
& $psql -U $DbUser -h $DbHost -d $DbName -c "SELECT 'pagamentos' AS tabela, COUNT(*)::int AS total FROM pagamentos UNION ALL SELECT 'blacklist', COUNT(*)::int FROM blacklist UNION ALL SELECT 'pedidos', COUNT(*)::int FROM pedidos;"

Write-Host '[OK] Execucao concluida com sucesso.'
