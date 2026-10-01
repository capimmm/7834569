<#
.SYNOPSIS
    Abre um site 10 vezes no navegador padrão do usuário.

.DESCRIPTION
    Script simples em PowerShell que inicia o navegador padrão 10 vezes
    com a URL definida abaixo. Útil para testes de carga leve, stress
    de abas ou apenas para demonstrar automação.

.EXAMPLE
    .\abrir-site.ps1
#>

# ===== CONFIGURAÇÃO =====
$url        = "https://github.com/capimmm/7834569"  # Troque pela URL que quiser
$quantidade = 10                                    # Quantas vezes abrir
# ========================

Write-Host "Abrindo '$url' $quantidade vezes..." -ForegroundColor Cyan

for ($i = 1; $i -le $quantidade; $i++) {
    Start-Process $url
    Write-Host "  [$i/$quantidade] Aberto" -ForegroundColor Green
    Start-Sleep -Milliseconds 300   # Pequena pausa pra não travar o PC
}

Write-Host "Concluído! $quantidade abas abertas." -ForegroundColor Yellow
