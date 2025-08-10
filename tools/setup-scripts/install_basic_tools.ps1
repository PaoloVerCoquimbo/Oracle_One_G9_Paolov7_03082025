# =====================================================
# SCRIPT DE INSTALACIÓN DE HERRAMIENTAS BÁSICAS
# Función: Instalar todas las herramientas necesarias para desarrollo
# Evento: Se ejecuta después de que Chocolatey esté completamente instalado
# Fecha: 20/08/2025 - Chile
# Autor: Configuración de Entorno de Desarrollo
# =====================================================

Write-Host "🔍 VERIFICANDO ESTADO DE CHOCOLATEY..." -ForegroundColor Yellow

# Función: Verificar si Chocolatey está instalado y funcionando
# Evento: Al inicio del script para confirmar que podemos proceder
try {
    $chocoVersion = choco --version
    Write-Host "✅ Chocolatey instalado: $chocoVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ ERROR: Chocolatey no está disponible" -ForegroundColor Red
    Write-Host "Por favor, espera a que termine la instalación de Chocolatey" -ForegroundColor Yellow
    exit 1
}

Write-Host "🚀 INICIANDO INSTALACIÓN DE HERRAMIENTAS ESENCIALES..." -ForegroundColor Cyan

# Función: Actualizar variables de entorno antes de instalar
# Evento: Para asegurar que Chocolatey funcione correctamente
Write-Host "🔄 Actualizando variables de entorno..." -ForegroundColor Yellow
refreshenv

# TIER 1 - HERRAMIENTAS ESENCIALES PARA DESARROLLO
Write-Host "📦 TIER 1: Instalando herramientas básicas..." -ForegroundColor Magenta

# Función: Instalar Git para control de versiones
# Evento: Necesario para clonar repos y manejar código
Write-Host "  🔧 Instalando Git..." -ForegroundColor White
choco install git -y

# Función: Instalar Node.js para desarrollo frontend y herramientas JS
# Evento: Necesario para npm, React, Vue, Angular
Write-Host "  🔧 Instalando Node.js..." -ForegroundColor White
choco install nodejs -y

# Función: Instalar Python para backend y data science
# Evento: Necesario para FastAPI, Jupyter, pandas, etc.
Write-Host "  🔧 Instalando Python..." -ForegroundColor White
choco install python -y

# Función: Instalar Visual Studio Code como editor principal
# Evento: IDE principal para todo el desarrollo
Write-Host "  🔧 Instalando Visual Studio Code..." -ForegroundColor White
choco install vscode -y

Write-Host "⏳ Esperando a que las instalaciones se completen..." -ForegroundColor Yellow
Start-Sleep -Seconds 10

# TIER 2 - HERRAMIENTAS DE PRODUCTIVIDAD
Write-Host "📦 TIER 2: Instalando herramientas de productividad..." -ForegroundColor Magenta

# Función: Instalar 7zip para manejo de archivos comprimidos
# Evento: Útil para descargar y descomprimir librerías
Write-Host "  🔧 Instalando 7zip..." -ForegroundColor White
choco install 7zip -y

# Función: Instalar Postman para testing de APIs
# Evento: Necesario para probar APIs que desarrolles
Write-Host "  🔧 Instalando Postman..." -ForegroundColor White
choco install postman -y

# Función: Instalar Google Chrome para testing y desarrollo
# Evento: Browser con mejores DevTools para desarrollo
Write-Host "  🔧 Instalando Google Chrome..." -ForegroundColor White
choco install googlechrome -y

Write-Host "🔄 Actualizando PATH y variables de entorno..." -ForegroundColor Yellow
refreshenv

Write-Host "✅ INSTALACIÓN COMPLETADA - VERIFICANDO HERRAMIENTAS..." -ForegroundColor Green

# Función: Verificar que todas las herramientas se instalaron correctamente
# Evento: Al final del script para confirmar que todo funciona
Write-Host "🧪 Verificando instalaciones:" -ForegroundColor Cyan

try {
    $gitVersion = git --version
    Write-Host "  ✅ Git: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "  ❌ Git no encontrado" -ForegroundColor Red
}

try {
    $nodeVersion = node --version
    Write-Host "  ✅ Node.js: $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "  ❌ Node.js no encontrado" -ForegroundColor Red
}

try {
    $pythonVersion = python --version
    Write-Host "  ✅ Python: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "  ❌ Python no encontrado" -ForegroundColor Red
}

try {
    $codeVersion = code --version
    Write-Host "  ✅ VS Code instalado correctamente" -ForegroundColor Green
} catch {
    Write-Host "  ❌ VS Code no encontrado" -ForegroundColor Red
}

Write-Host "🎉 INSTALACIÓN DE HERRAMIENTAS BÁSICAS COMPLETADA" -ForegroundColor Green
Write-Host "📝 SIGUIENTE PASO: Configurar VS Code con extensiones para tu metodología" -ForegroundColor Yellow
Write-Host "🚀 SIGUIENTE PASO: Instalar Tailwind CSS en tu proyecto" -ForegroundColor Yellow

# Función: Mostrar comandos siguientes para el usuario
# Evento: Para guiar los próximos pasos del setup
Write-Host "`n📋 COMANDOS PARA EJECUTAR A CONTINUACIÓN:" -ForegroundColor Cyan
Write-Host "1. .\tools\setup-scripts\configure_vscode.ps1" -ForegroundColor White
Write-Host "2. .\tools\setup-scripts\setup_tailwind.ps1" -ForegroundColor White
Write-Host "3. .\tools\setup-scripts\configure_git.ps1" -ForegroundColor White