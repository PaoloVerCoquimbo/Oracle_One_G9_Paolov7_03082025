# setup_all.ps1
# Script principal para configurar todo el entorno de desarrollo

param(
    [switch]$SkipPackageInstall,
    [switch]$OnlyStructure,
    [string]$Component = "all"
)

# Configurar política de ejecución
try {
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force -ErrorAction SilentlyContinue
} catch {
    Write-Warning "No se pudo establecer la política de ejecución. Continúando..."
}

Write-Host "======================================" -ForegroundColor Cyan
Write-Host "SETUP COMPLETO DEL REPOSITORIO" -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

$basePath = "P:\Repositorio_Principal"

# Verificar que la estructura base existe
if (-not (Test-Path $basePath)) {
    Write-Host "Error: No se encontró la estructura base. Ejecuta primero mega_setup.ps1" -ForegroundColor Red
    exit 1
}

# Función para verificar si un comando existe
function Test-Command($cmdname) {
    return [bool](Get-Command -Name $cmdname -ErrorAction SilentlyContinue)
}

# Función para instalar paquetes usando diferentes gestores
function Install-Package($manager, $package, $displayName) {
    Write-Host "Instalando $displayName..." -ForegroundColor Yellow
    try {
        switch ($manager) {
            "choco" { 
                if (Test-Command choco) {
                    & choco install $package -y
                } else {
                    Write-Host "Chocolatey no está instalado. Saltando $displayName" -ForegroundColor Yellow
                }
            }
            "npm" { 
                if (Test-Command npm) {
                    & npm install -g $package
                } else {
                    Write-Host "npm no está disponible. Saltando $displayName" -ForegroundColor Yellow
                }
            }
            "pip" { 
                if (Test-Command pip) {
                    & pip install $package
                } else {
                    Write-Host "pip no está disponible. Saltando $displayName" -ForegroundColor Yellow
                }
            }
        }
    } catch {
        Write-Host "Error instalando $displayName : $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Función para crear archivos de configuración
function New-ConfigFile($path, $content, $description) {
    try {
        if (-not (Test-Path $path)) {
            $content | Out-File -FilePath $path -Encoding UTF8
            Write-Host "Creado: $description" -ForegroundColor Green
        } else {
            Write-Host "Ya existe: $description" -ForegroundColor Gray
        }
    } catch {
        Write-Host "Error creando $description : $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Configuración Frontend
if ($Component -eq "all" -or $Component -eq "frontend") {
    Write-Host ""
    Write-Host "=== CONFIGURANDO FRONTEND ===" -ForegroundColor Magenta
    
    # React App
    $reactPath = Join-Path $basePath "frontend\react-app"
    $packageJsonReact = @"
{
  "name": "react-app",
  "version": "1.0.0",
  "private": true,
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-scripts": "5.0.1"
  },
  "scripts": {
    "start": "react-scripts start",
    "build": "react-scripts build",
    "test": "react-scripts test",
    "eject": "react-scripts eject"
  },
  "browserslist": {
    "production": [">0.2%", "not dead", "not op_mini all"],
    "development": ["last 1 chrome version", "last 1 firefox version", "last 1 safari version"]
  }
}
"@
    New-ConfigFile (Join-Path $reactPath "package.json") $packageJsonReact "package.json para React"

    # Angular App
    $angularPath = Join-Path $basePath "frontend\angular-app"
    $packageJsonAngular = @"
{
  "name": "angular-app",
  "version": "1.0.0",
  "scripts": {
    "ng": "ng",
    "start": "ng serve",
    "build": "ng build",
    "test": "ng test"
  },
  "dependencies": {
    "@angular/core": "^16.0.0",
    "@angular/common": "^16.0.0",
    "@angular/platform-browser": "^16.0.0",
    "@angular/cli": "^16.0.0"
  }
}
"@
    New-ConfigFile (Join-Path $angularPath "package.json") $packageJsonAngular "package.json para Angular"

    # Vue App
    $vuePath = Join-Path $basePath "frontend\vue-app"
    $packageJsonVue = @"
{
  "name": "vue-app",
  "version": "1.0.0",
  "scripts": {
    "serve": "vue-cli-service serve",
    "build": "vue-cli-service build",
    "lint": "vue-cli-service lint"
  },
  "dependencies": {
    "vue": "^3.3.0",
    "@vue/cli-service": "^5.0.0"
  }
}
"@
    New-ConfigFile (Join-Path $vuePath "package.json") $packageJsonVue "package.json para Vue"
}

# Configuración Backend
if ($Component -eq "all" -or $Component -eq "backend") {
    Write-Host ""
    Write-Host "=== CONFIGURANDO BACKEND ===" -ForegroundColor Magenta
    
    # Python API
    $pythonPath = Join-Path $basePath "backend\python-api"
    $requirementsTxt = @"
fastapi==0.104.1
uvicorn==0.24.0
pydantic==2.5.0
sqlalchemy==2.0.23
psycopg2-binary==2.9.9
python-dotenv==1.0.0
pytest==7.4.3
requests==2.31.0
"@
    New-ConfigFile (Join-Path $pythonPath "requirements.txt") $requirementsTxt "requirements.txt para Python API"

    $mainPy = @"
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(title="Python API", version="1.0.0")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
async def root():
    return {"message": "Python API funcionando correctamente"}

@app.get("/health")
async def health_check():
    return {"status": "healthy", "service": "python-api"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
"@
    New-ConfigFile (Join-Path $pythonPath "main.py") $mainPy "main.py para Python API"

    # Java API
    $javaPath = Join-Path $basePath "backend\java-api"
    $pomXml = @"
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.repositorio</groupId>
    <artifactId>java-api</artifactId>
    <version>1.0.0</version>
    <packaging>jar</packaging>
    
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <spring.boot.version>3.1.5</spring.boot.version>
    </properties>
    
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
            <version>\${spring.boot.version}</version>
        </dependency>
    </dependencies>
</project>
"@
    New-ConfigFile (Join-Path $javaPath "pom.xml") $pomXml "pom.xml para Java API"

    # C++ Services
    $cppPath = Join-Path $basePath "backend\cpp-services"
    $cmakeFile = "cmake_minimum_required(VERSION 3.16)`n" +
                 "project(cpp-services)`n`n" +
                 "set(CMAKE_CXX_STANDARD 17)`n" +
                 "set(CMAKE_CXX_STANDARD_REQUIRED ON)`n`n" +
                 "# Buscar dependencias`n" +
                 "find_package(Threads REQUIRED)`n`n" +
                 "# Ejecutable principal`n" +
                 "add_executable(cpp-service main.cpp)`n" +
                 "target_link_libraries(cpp-service Threads::Threads)`n`n" +
                 "# Configuracion de compilacion`n" +
                 "if(CMAKE_BUILD_TYPE STREQUAL `"Debug`")`n" +
                 "    target_compile_definitions(cpp-service PRIVATE DEBUG_MODE)`n" +
                 "endif()"
    New-ConfigFile (Join-Path $cppPath "CMakeLists.txt") $cmakeFile "CMakeLists.txt para C++ Services"

    $mainCpp = "#include <iostream>`n" +
               "#include <thread>`n" +
               "#include <chrono>`n`n" +
               "int main() {`n" +
               "    std::cout << `"C++ Service iniciado correctamente`" << std::endl;`n`n" +
               "    // Simular servicio ejecutandose`n" +
               "    while (true) {`n" +
               "        std::cout << `"Servicio funcionando... `"`n" +
               "                  << std::chrono::system_clock::now().time_since_epoch().count()`n" +
               "                  << std::endl;`n" +
               "        std::this_thread::sleep_for(std::chrono::seconds(30));`n" +
               "    }`n`n" +
               "    return 0;`n" +
               "}"
    New-ConfigFile (Join-Path $cppPath "main.cpp") $mainCpp "main.cpp para C++ Services"
}

# Configuración Automation
if ($Component -eq "all" -or $Component -eq "automation") {
    Write-Host ""
    Write-Host "=== CONFIGURANDO AUTOMATION ===" -ForegroundColor Magenta
    
    # Scripts Python
    $automationPythonPath = Join-Path $basePath "automation\scripts-python"
    $automationScript = "#!/usr/bin/env python3`n" +
                        "`"```"```"`n" +
                        "Script de automatizacion principal`n" +
                        "`"```"```"`n" +
                        "import os`n" +
                        "import sys`n" +
                        "import logging`n" +
                        "from datetime import datetime`n`n" +
                        "# Configurar logging`n" +
                        "logging.basicConfig(`n" +
                        "    level=logging.INFO,`n" +
                        "    format='%(asctime)s - %(levelname)s - %(message)s',`n" +
                        "    handlers=[`n" +
                        "        logging.FileHandler('automation.log'),`n" +
                        "        logging.StreamHandler(sys.stdout)`n" +
                        "    ]`n" +
                        ")`n`n" +
                        "def main():`n" +
                        "    `"```"```"Funcion principal de automatizacion`"```"```"`n" +
                        "    logging.info(`"Iniciando script de automatizacion`")`n" +
                        "    logging.info(f`"Directorio actual: {os.getcwd()}`")`n" +
                        "    logging.info(f`"Timestamp: {datetime.now().isoformat()}`")`n`n" +
                        "    # Aqui van las tareas de automatizacion`n" +
                        "    logging.info(`"Automatizacion completada exitosamente`")`n`n" +
                        "if __name__ == `"__main__`":`n" +
                        "    main()"
    New-ConfigFile (Join-Path $automationPythonPath "automation_main.py") $automationScript "Script principal de automatización"

    # Scripts Bash
    $automationBashPath = Join-Path $basePath "automation\scripts-bash"
    $bashScript = "#!/bin/bash`n" +
                  "# Script de automatizacion principal para sistemas Unix/Linux`n`n" +
                  "set -euo pipefail`n`n" +
                  "# Configuracion`n" +
                  "LOG_FILE=`"automation.log`"`n" +
                  "TIMESTAMP=`$(date '+%Y-%m-%d %H:%M:%S')`n`n" +
                  "# Funcion de logging`n" +
                  "log() {`n" +
                  "    echo `"[`$TIMESTAMP] `$1`" | tee -a `"`$LOG_FILE`"`n" +
                  "}`n`n" +
                  "# Funcion principal`n" +
                  "main() {`n" +
                  "    log `"Iniciando script de automatizacion bash`"`n" +
                  "    log `"Directorio actual: `$(pwd)`"`n`n" +
                  "    # Aqui van las tareas de automatizacion`n`n" +
                  "    log `"Automatizacion bash completada exitosamente`"`n" +
                  "}`n`n" +
                  "# Ejecutar funcion principal`n" +
                  "main `"`$@`""
    New-ConfigFile (Join-Path $automationBashPath "automation_main.sh") $bashScript "Script principal bash"
}

# Configuración Oracle One G9
if ($Component -eq "all" -or $Component -eq "oracle") {
    Write-Host ""
    Write-Host "=== CONFIGURANDO ORACLE ONE G9 ===" -ForegroundColor Magenta
    
    $oraclePath = Join-Path $basePath "Oracle_One_G9"
    $oracleConfig = @"
# Configuración Oracle One G9
Proyecto: Oracle One Generation 9
Fecha inicio: $(Get-Date -Format 'yyyy-MM-dd')

## Estructura de datos
- raw/: Datos sin procesar
- processed/: Datos procesados y limpios
- notebooks/: Jupyter notebooks para análisis
- scripts/: Scripts de procesamiento
- models/: Modelos entrenados
- docs/: Documentación del proyecto

## Herramientas recomendadas
- Python 3.9+
- Jupyter Lab
- Pandas, NumPy, Scikit-learn
- PostgreSQL
- Docker
"@
    New-ConfigFile (Join-Path $oraclePath "project_info.txt") $oracleConfig "Información del proyecto Oracle"

    # Crear notebook ejemplo
    $notebookPath = Join-Path $basePath "Oracle_One_G9\notebooks"
    $exampleNotebook = @"
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Oracle One G9 - Notebook de ejemplo\n",
    "\n",
    "Este es un notebook de ejemplo para el proyecto Oracle One Generation 9."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "import pandas as pd\n",
    "import numpy as np\n",
    "import matplotlib.pyplot as plt\n",
    "\n",
    "print('¡Entorno configurado correctamente!')"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3",
   "language": "python",
   "name": "python3"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 4
}
"@
    New-ConfigFile (Join-Path $notebookPath "ejemplo.ipynb") $exampleNotebook "Notebook de ejemplo"
}

# Instalar paquetes si no se especifica saltarlos
if (-not $SkipPackageInstall -and -not $OnlyStructure) {
    Write-Host ""
    Write-Host "=== INSTALANDO HERRAMIENTAS ===" -ForegroundColor Magenta
    Write-Host "Nota: Se requieren permisos de administrador para algunas instalaciones" -ForegroundColor Yellow
    
    # Verificar gestores de paquetes disponibles
    $hasChoco = Test-Command choco
    $hasNpm = Test-Command npm
    $hasPip = Test-Command pip
    
    Write-Host "Gestores disponibles:" -ForegroundColor White
    Write-Host "  - Chocolatey: $(if($hasChoco) {'Si'} else {'No'})" -ForegroundColor $(if($hasChoco) {'Green'} else {'Red'})
    Write-Host "  - npm: $(if($hasNpm) {'Si'} else {'No'})" -ForegroundColor $(if($hasNpm) {'Green'} else {'Red'})
    Write-Host "  - pip: $(if($hasPip) {'Si'} else {'No'})" -ForegroundColor $(if($hasPip) {'Green'} else {'Red'})
    
    if ($hasNpm) {
        Install-Package "npm" "@angular/cli" "Angular CLI"
        Install-Package "npm" "@vue/cli" "Vue CLI"
        Install-Package "npm" "create-react-app" "Create React App"
    }
    
    if ($hasPip) {
        Install-Package "pip" "jupyter" "Jupyter Lab"
        Install-Package "pip" "pandas" "Pandas"
        Install-Package "pip" "numpy" "NumPy"
        Install-Package "pip" "scikit-learn" "Scikit-learn"
    }
}

# Mensaje final
Write-Host ""
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "SETUP COMPLETO FINALIZADO" -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Cyan

Write-Host ""
Write-Host "Resumen de configuración:" -ForegroundColor White
Write-Host "- Estructura de directorios: Configurada" -ForegroundColor Green
Write-Host "- Archivos de configuración: Creados" -ForegroundColor Green
Write-Host "- Scripts de ejemplo: Implementados" -ForegroundColor Green

if ($SkipPackageInstall -or $OnlyStructure) {
    Write-Host "- Instalación de paquetes: Omitida" -ForegroundColor Yellow
} else {
    Write-Host "- Herramientas: Instalación intentada" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "Próximos pasos recomendados:" -ForegroundColor White
Write-Host "1. Revisar archivos de configuración creados" -ForegroundColor Cyan
Write-Host "2. Instalar dependencias específicas según necesidades" -ForegroundColor Cyan
Write-Host "3. Configurar entornos virtuales para Python" -ForegroundColor Cyan
Write-Host "4. Inicializar repositorios Git en subdirectorios si es necesario" -ForegroundColor Cyan

Write-Host ""
Write-Host "Uso del script:" -ForegroundColor White
Write-Host "  .\setup_all.ps1                    # Configuración completa" -ForegroundColor Gray
Write-Host "  .\setup_all.ps1 -SkipPackageInstall # Solo archivos, sin instalaciones" -ForegroundColor Gray
Write-Host "  .\setup_all.ps1 -Component frontend # Solo configurar frontend" -ForegroundColor Gray

Write-Host ""
Read-Host "Presiona Enter para finalizar"