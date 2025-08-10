# mega_setup.ps1
# Script para configurar estructura de directorios del repositorio principal

# Configurar política de ejecución para la sesión actual (si es necesario)
try {
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force -ErrorAction SilentlyContinue
} catch {
    Write-Warning "No se pudo establecer la política de ejecución. Continúando..."
}

Write-Host "======================================" -ForegroundColor Cyan
Write-Host "Iniciando MEGA SETUP del repositorio" -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

# Ruta base
$basePath = "P:\Repositorio_Principal"

# Verificar si la unidad P: existe
if (-not (Test-Path "P:\")) {
    Write-Host "Error: La unidad P:\ no existe o no está accesible" -ForegroundColor Red
    Write-Host "Por favor, verifica que la unidad esté disponible antes de continuar." -ForegroundColor Yellow
    Read-Host "Presiona Enter para salir"
    exit 1
}

# Crear directorio base si no existe
if (-not (Test-Path $basePath)) {
    try {
        New-Item -Path $basePath -ItemType Directory -Force | Out-Null
        Write-Host "Directorio base creado: $basePath" -ForegroundColor Green
    } catch {
        Write-Host "Error creando directorio base: $($_.Exception.Message)" -ForegroundColor Red
        exit 1
    }
}

# Lista de carpetas a crear
$folders = @(
    "frontend\react-app",
    "frontend\angular-app", 
    "frontend\vue-app",
    "backend\python-api",
    "backend\java-api",
    "backend\cpp-services",
    "automation\n8n-workflows",
    "automation\scripts-python",
    "automation\scripts-bash",
    "robotics\ros2-packages",
    "Oracle_One_G9\data\raw",
    "Oracle_One_G9\data\processed",
    "Oracle_One_G9\notebooks",
    "Oracle_One_G9\scripts",
    "Oracle_One_G9\models",
    "Oracle_One_G9\docs",
    "docs",
    "tools\setup-scripts\global",
    "tools\setup-scripts\frontend",
    "tools\setup-scripts\backend",
    "tools\setup-scripts\automation",
    "tools\setup-scripts\oracle",
    "tools\setup-scripts\datascience",
    "tools\utilidades"
)

# Crear carpetas con manejo de errores
Write-Host "Creando estructura de directorios..." -ForegroundColor White
$createdCount = 0
$errorCount = 0

foreach ($folder in $folders) {
    $path = Join-Path $basePath $folder
    if (-not (Test-Path $path)) {
        try {
            New-Item -Path $path -ItemType Directory -Force | Out-Null
            Write-Host "Carpeta creada: $folder" -ForegroundColor Yellow
            $createdCount++
        } catch {
            Write-Host "Error creando carpeta $folder : $($_.Exception.Message)" -ForegroundColor Red
            $errorCount++
        }
    } else {
        Write-Host "Ya existe: $folder" -ForegroundColor Gray
    }
}

# Crear README.md en carpetas clave
Write-Host ""
Write-Host "Creando archivos README.md..." -ForegroundColor White

$readmeFolders = @(
    @{Path = ""; Name = "Repositorio Principal"},
    @{Path = "frontend"; Name = "Frontend"},
    @{Path = "backend"; Name = "Backend"},
    @{Path = "automation"; Name = "Automation"},
    @{Path = "robotics"; Name = "Robotics"},
    @{Path = "Oracle_One_G9"; Name = "Oracle One G9"},
    @{Path = "tools"; Name = "Tools"}
)

foreach ($rf in $readmeFolders) {
    $readmePath = Join-Path $basePath $rf.Path "README.md"
    if (-not (Test-Path $readmePath)) {
        try {
            $readmeContent = "# " + $rf.Name + "`n`n"
            $readmeContent += "Este directorio contiene los archivos y recursos relacionados con " + $rf.Name.ToLower() + ".`n`n"
            $readmeContent += "## Estructura`n`n"
            $readmeContent += "Descripción de la estructura de archivos y su propósito.`n`n"
            $readmeContent += "## Uso`n`n"
            $readmeContent += "Instrucciones para el uso de los recursos en este directorio.`n`n"
            $readmeContent += "---`n"
            $readmeContent += "Generado automáticamente por mega_setup.ps1"
            
            $readmeContent | Out-File -FilePath $readmePath -Encoding UTF8
            Write-Host "README.md creado en: $($rf.Path)" -ForegroundColor Cyan
        } catch {
            Write-Host "Error creando README en $($rf.Path): $($_.Exception.Message)" -ForegroundColor Red
            $errorCount++
        }
    } else {
        Write-Host "README.md ya existe en: $($rf.Path)" -ForegroundColor Gray
    }
}

# Crear .gitignore
Write-Host ""
Write-Host "Creando archivo .gitignore..." -ForegroundColor White
$gitignorePath = Join-Path $basePath ".gitignore"
if (-not (Test-Path $gitignorePath)) {
    try {
        $gitignoreContent = @"
# Node.js
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*
dist/
build/

# Python
__pycache__/
*.py[cod]
*.pyc
.Python
.venv/
venv/
env/
.env

# Java
target/
*.class
*.jar
*.war
*.ear

# C++
build/
*.exe
*.out
*.app
*.o
*.obj

# IDEs
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Logs
*.log
logs/

# Temporary files
*.tmp
*.temp
"@
        $gitignoreContent | Out-File -FilePath $gitignorePath -Encoding UTF8
        Write-Host ".gitignore creado" -ForegroundColor Magenta
    } catch {
        Write-Host "Error creando .gitignore: $($_.Exception.Message)" -ForegroundColor Red
        $errorCount++
    }
} else {
    Write-Host ".gitignore ya existe" -ForegroundColor Gray
}

# Crear archivo de configuración del proyecto
Write-Host ""
Write-Host "Creando archivo de configuracion..." -ForegroundColor White
$configPath = Join-Path $basePath "project-config.txt"
if (-not (Test-Path $configPath)) {
    try {
        $configContent = @"
Proyecto: Repositorio Principal
Version: 1.0.0
Creado: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')

Estructura:
- frontend: react-app, angular-app, vue-app
- backend: python-api, java-api, cpp-services  
- automation: n8n-workflows, scripts-python, scripts-bash
- robotics: ros2-packages
- oracle: Oracle_One_G9
- tools: setup-scripts, utilidades
"@
        $configContent | Out-File -FilePath $configPath -Encoding UTF8
        Write-Host "Archivo de configuracion creado" -ForegroundColor Green
    } catch {
        Write-Host "Error creando archivo de configuracion: $($_.Exception.Message)" -ForegroundColor Red
        $errorCount++
    }
}

# Mensaje final
Write-Host ""
Write-Host "======================================" -ForegroundColor Cyan
if ($errorCount -eq 0) {
    Write-Host "MEGA SETUP finalizado con exito" -ForegroundColor Green
    Write-Host "Estadisticas:" -ForegroundColor White
    Write-Host "   - Carpetas creadas: $createdCount" -ForegroundColor Yellow
    Write-Host "   - Archivos README: $($readmeFolders.Count)" -ForegroundColor Cyan
    Write-Host "   - Sin errores" -ForegroundColor Green
} else {
    Write-Host "MEGA SETUP finalizado con advertencias" -ForegroundColor Yellow
    Write-Host "Estadisticas:" -ForegroundColor White
    Write-Host "   - Carpetas creadas: $createdCount" -ForegroundColor Yellow
    Write-Host "   - Errores encontrados: $errorCount" -ForegroundColor Red
}

Write-Host ""
Write-Host "Siguiente paso recomendado:" -ForegroundColor White
Write-Host "   Ejecutar: .\tools\setup-scripts\setup_all.ps1" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan

# Pausa para revisar resultados
Write-Host ""
Read-Host "Presiona Enter para finalizar"