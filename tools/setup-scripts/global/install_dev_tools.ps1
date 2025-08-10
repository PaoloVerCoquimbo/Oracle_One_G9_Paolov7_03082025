# install_dev_tools.ps1
Write-Host "🚀 Instalando herramientas de desarrollo esenciales..."

# Instalar herramientas con Chocolatey
choco install git nodejs python vscode 7zip -y

# Configurar Git (modifica con tus datos reales)
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"

# Verificar instalaciones
Write-Host "✅ Verificando versiones instaladas:"
git --version
node --version
python --version
code --version
7z --help | Select-String "7-Zip"

Write-Host "🚀 Instalación y configuración completadas."
