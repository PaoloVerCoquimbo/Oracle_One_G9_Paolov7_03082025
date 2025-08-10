# setup_environment.ps1
# Script para configurar el entorno de desarrollo completo

param(
    [switch]$InstallChocolatey,
    [switch]$InstallTools,
    [switch]$ConfigureGit,
    [switch]$All
)

Write-Host "======================================" -ForegroundColor Cyan
Write-Host "CONFIGURACION COMPLETA DEL ENTORNO" -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

# Verificar si se ejecuta como administrador
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "⚠️  ATENCION: Este script debe ejecutarse como Administrador" -ForegroundColor Red
    Write-Host "Pasos para ejecutar como administrador:" -ForegroundColor Yellow
    Write-Host "1. Presiona Win + X" -ForegroundColor White
    Write-Host "2. Selecciona 'Terminal (Administrador)'" -ForegroundColor White
    Write-Host "3. Navega a este directorio y ejecuta el script nuevamente" -ForegroundColor White
    Write-Host ""
    
    $choice = Read-Host "¿Quieres intentar relanzar como administrador? (s/n)"
    if ($choice -eq 's' -or $choice -eq 'S') {
        Start-Process powershell -Verb RunAs -ArgumentList "-NoExit", "-File", $MyInvocation.MyCommand.Path
        exit
    } else {
        Write-Host "Saliendo... Ejecuta como administrador cuando estés listo." -ForegroundColor Yellow
        exit 1
    }
}

Write-Host "✓ Ejecutándose como Administrador" -ForegroundColor Green
Write-Host ""

# Función para verificar comandos
function Test-Command($cmdname) {
    return [bool](Get-Command -Name $cmdname -ErrorAction SilentlyContinue)
}

# Función para instalar Chocolatey
function Install-Chocolatey {
    Write-Host "=== INSTALANDO CHOCOLATEY ===" -ForegroundColor Magenta
    try {
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        Write-Host "✓ Chocolatey instalado correctamente" -ForegroundColor Green
        
        # Actualizar PATH
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
        
        return $true
    } catch {
        Write-Host "✗ Error instalando Chocolatey: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Función para instalar herramientas
function Install-DevelopmentTools {
    Write-Host "=== INSTALANDO HERRAMIENTAS DE DESARROLLO ===" -ForegroundColor Magenta
    
    $tools = @(
        @{Name="Git"; Package="git"; Description="Control de versiones"},
        @{Name="Node.js"; Package="nodejs"; Description="JavaScript runtime + npm"},
        @{Name="Python"; Package="python"; Description="Python + pip"},
        @{Name="Visual Studio Code"; Package="vscode"; Description="Editor de código"},
        @{Name="7-Zip"; Package="7zip"; Description="Herramienta de compresión"},
        @{Name="Google Chrome"; Package="googlechrome"; Description="Navegador web"},
        @{Name="Postman"; Package="postman"; Description="Herramienta API testing"}
    )
    
    $successful = @()
    $failed = @()
    
    foreach ($tool in $tools) {
        Write-Host ""
        Write-Host "Instalando $($tool.Name) - $($tool.Description)..." -ForegroundColor Yellow
        try {
            & choco install $tool.Package -y --no-progress
            Write-Host "✓ $($tool.Name) instalado correctamente" -ForegroundColor Green
            $successful += $tool.Name
        } catch {
            Write-Host "✗ Error instalando $($tool.Name): $($_.Exception.Message)" -ForegroundColor Red
            $failed += $tool.Name
        }
    }
    
    return @{Successful=$successful; Failed=$failed}
}

# Función para configurar Git
function Configure-Git {
    Write-Host "=== CONFIGURANDO GIT ===" -ForegroundColor Magenta
    
    if (-not (Test-Command git)) {
        Write-Host "⚠️  Git no está instalado. Instálalo primero." -ForegroundColor Yellow
        return $false
    }
    
    Write-Host "Configuración de Git:" -ForegroundColor White
    $gitName = Read-Host "Ingresa tu nombre completo"
    $gitEmail = Read-Host "Ingresa tu email"
    
    try {
        & git config --global user.name "$gitName"
        & git config --global user.email "$gitEmail"
        & git config --global init.defaultBranch main
        & git config --global core.autocrlf true
        
        Write-Host "✓ Git configurado correctamente" -ForegroundColor Green
        Write-Host "  Nombre: $gitName" -ForegroundColor Cyan
        Write-Host "  Email: $gitEmail" -ForegroundColor Cyan
        return $true
    } catch {
        Write-Host "✗ Error configurando Git: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Función para configurar PowerShell
function Configure-PowerShell {
    Write-Host "=== CONFIGURANDO POWERSHELL ===" -ForegroundColor Magenta
    try {
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine -Force
        Write-Host "✓ Política de ejecución configurada" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "✗ Error configurando PowerShell: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Menú principal si no se especifican parámetros
if (-not $InstallChocolatey -and -not $InstallTools -and -not $ConfigureGit -and -not $All) {
    Write-Host "Selecciona las acciones a realizar:" -ForegroundColor White
    Write-Host "1. Configuración completa (Todo)" -ForegroundColor Green
    Write-Host "2. Solo instalar Chocolatey" -ForegroundColor Yellow
    Write-Host "3. Solo instalar herramientas de desarrollo" -ForegroundColor Yellow
    Write-Host "4. Solo configurar Git" -ForegroundColor Yellow
    Write-Host "5. Configuración personalizada" -ForegroundColor Cyan
    Write-Host ""
    
    $choice = Read-Host "Ingresa tu opción (1-5)"
    
    switch ($choice) {
        "1" { $All = $true }
        "2" { $InstallChocolatey = $true }
        "3" { $InstallTools = $true }
        "4" { $ConfigureGit = $true }
        "5" {
            $InstallChocolatey = (Read-Host "¿Instalar Chocolatey? (s/n)") -eq 's'
            $InstallTools = (Read-Host "¿Instalar herramientas? (s/n)") -eq 's'
            $ConfigureGit = (Read-Host "¿Configurar Git? (s/n)") -eq 's'
        }
        default {
            Write-Host "Opción no válida. Ejecutando configuración completa." -ForegroundColor Yellow
            $All = $true
        }
    }
}

# Ejecutar acciones seleccionadas
$results = @{
    PowerShell = $false
    Chocolatey = $false
    Tools = @{Successful=@(); Failed=@()}
    Git = $false
}

# Configurar PowerShell siempre
$results.PowerShell = Configure-PowerShell

if ($All -or $InstallChocolatey) {
    if (-not (Test-Command choco)) {
        $results.Chocolatey = Install-Chocolatey
    } else {
        Write-Host "✓ Chocolatey ya está instalado" -ForegroundColor Green
        $results.Chocolatey = $true
    }
}

if ($All -or $InstallTools) {
    if (Test-Command choco) {
        $results.Tools = Install-DevelopmentTools
    } else {
        Write-Host "⚠️  Chocolatey no está disponible. Instálalo primero para instalar herramientas." -ForegroundColor Yellow
    }
}

if ($All -or $ConfigureGit) {
    $results.Git = Configure-Git
}

# Actualizar variables de entorno
Write-Host ""
Write-Host "Actualizando variables de entorno..." -ForegroundColor Yellow
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Resumen final
Write-Host ""
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "CONFIGURACION COMPLETADA" -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Cyan

Write-Host ""
Write-Host "Resumen de resultados:" -ForegroundColor White

Write-Host "📋 PowerShell: " -NoNewline
Write-Host $(if($results.PowerShell) {"✓ Configurado"} else {"✗ Error"}) -ForegroundColor $(if($results.PowerShell) {"Green"} else {"Red"})

Write-Host "📦 Chocolatey: " -NoNewline
Write-Host $(if($results.Chocolatey) {"✓ Instalado"} else {"✗ No instalado"}) -ForegroundColor $(if($results.Chocolatey) {"Green"} else {"Red"})

if ($results.Tools.Successful.Count -gt 0) {
    Write-Host "🛠️  Herramientas instaladas:" -ForegroundColor Green
    foreach ($tool in $results.Tools.Successful) {
        Write-Host "   ✓ $tool" -ForegroundColor Green
    }
}

if ($results.Tools.Failed.Count -gt 0) {
    Write-Host "⚠️  Herramientas fallidas:" -ForegroundColor Red
    foreach ($tool in $results.Tools.Failed) {
        Write-Host "   ✗ $tool" -ForegroundColor Red
    }
}

Write-Host "🔧 Git: " -NoNewline
Write-Host $(if($results.Git) {"✓ Configurado"} else {"✗ No configurado"}) -ForegroundColor $(if($results.Git) {"Green"} else {"Red"})

Write-Host ""
Write-Host "Próximos pasos:" -ForegroundColor White
Write-Host "1. Reinicia PowerShell para que los cambios tomen efecto" -ForegroundColor Cyan
Write-Host "2. Ejecuta: .\setup_all.ps1 para configurar tu proyecto" -ForegroundColor Cyan
Write-Host "3. Verifica las herramientas con:" -ForegroundColor Cyan
Write-Host "   node --version" -ForegroundColor Gray
Write-Host "   python --version" -ForegroundColor Gray
Write-Host "   git --version" -ForegroundColor Gray

Write-Host ""
Write-Host "¡Entorno de desarrollo listo para usar! 🚀" -ForegroundColor Green

Write-Host ""
Read-Host "Presiona Enter para finalizar"