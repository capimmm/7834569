# abrir.ps1
# Script simples para abrir programas e sites no Windows

Write-Host "Iniciando os aplicativos..." -ForegroundColor Cyan

# 1. Abre o Bloco de Notas (exemplo de programa local)
Start-Process -FilePath "notepad.exe"

# 2. Abre o seu repositório no GitHub no navegador padrão
Start-Process "https://github.com/capimmm/7834569"

Write-Host "Aplicativos abertos com sucesso!" -ForegroundColor Green
