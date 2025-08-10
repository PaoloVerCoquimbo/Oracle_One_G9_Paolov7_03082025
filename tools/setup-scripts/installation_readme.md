# 🚀 GUÍA COMPLETA DE INSTALACIÓN DEL ENTORNO DE DESARROLLO

> **Fecha de creación**: 20/08/2025 - Chile  
> **Propósito**: Configurar un entorno completo para desarrollo Full-Stack + Data Science  
> **Metodología**: Scripts automatizados con documentación detallada  

## 📋 ÍNDICE

- [Requisitos del Sistema](#-requisitos-del-sistema)
- [Instalación Rápida](#-instalación-rápida)
- [Instalación Detallada](#-instalación-detallada)
- [Estructura del Proyecto](#-estructura-del-proyecto)
- [Scripts Disponibles](#-scripts-disponibles)
- [Verificación de Instalación](#-verificación-de-instalación)
- [Troubleshooting](#-troubleshooting)
- [Próximos Pasos](#-próximos-pasos)

## 🖥️ REQUISITOS DEL SISTEMA

### Requisitos Mínimos
- **SO**: Windows 10/11 (64-bit)
- **RAM**: 8GB mínimo (16GB recomendado)
- **Espacio**: 10GB libres
- **Conexión**: Internet estable para descargas

### Requisitos de Permisos
- **Administrador**: Necesario para instalación inicial
- **PowerShell**: Versión 5.1 o superior
- **Política de ejecución**: Se configurará automáticamente

## ⚡ INSTALACIÓN RÁPIDA

### Opción 1: Script Todo-en-Uno (Recomendado)

```powershell
# 1. Abrir PowerShell como Administrador
# 2. Navegar a la carpeta del proyecto
cd P:\Repositorio_Principal

# 3. Ejecutar instalación completa
.\tools\setup-scripts\quick_setup.ps1
```

### Opción 2: Clonar desde GitHub

```bash
# Clonar repositorio
git clone https://github.com/tu-usuario/repositorio-principal.git
cd repositorio-principal

# Ejecutar setup
.\tools\setup-scripts\quick_setup.ps1
```

## 🔧 INSTALACIÓN DETALLADA

### PASO 1: Configuración Inicial del Sistema

**Función**: Configurar PowerShell y políticas de seguridad  
**Tiempo estimado**: 2-3 minutos

```powershell
# Abrir PowerShell como Administrador
# Tecla Windows + X, seleccionar "Windows PowerShell (Admin)"

# Verificar versión de PowerShell
$PSVersionTable.PSVersion

# Configurar política de ejecución
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

# Navegar a tu carpeta de trabajo
cd P:\
```

### PASO 2: Crear Estructura Base del Proyecto

**Función**: Generar toda la estructura de directorios y archivos base  
**Tiempo estimado**: 1-2 minutos

```powershell
# Ejecutar script de estructura base
.\tools\setup-scripts\mega_setup.ps1

# Verificar que se creó la estructura
ls P:\Repositorio_Principal
```

**Resultado esperado**:
```
P:\Repositorio_Principal\
├── frontend\          # Aplicaciones React, Angular, Vue
├── backend\           # APIs Python, Java, C++
├── automation\        # Scripts de automatización
├── robotics\          # Paquetes ROS2
├── Oracle_One_G9\     # Proyecto Data Science
├── docs\              # Documentación
└── tools\             # Herramientas y scripts
```

### PASO 3: Instalar Chocolatey (Gestor de Paquetes)

**Función**: Instalar gestor de paquetes para Windows  
**Tiempo estimado**: 3-5 minutos

```powershell
# Instalar Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Verificar instalación
choco --version

# Actualizar variables de entorno
refreshenv
```

**⚠️ IMPORTANTE**: Esperar a que Chocolatey termine completamente antes del siguiente paso.

### PASO 4: Instalar Herramientas de Desarrollo

**Función**: Instalar todas las herramientas necesarias para desarrollo  
**Tiempo estimado**: 10-15 minutos

```powershell
# Ejecutar script de instalación de herramientas básicas
.\tools\setup-scripts\install_basic_tools.ps1

# O manualmente:
choco install git nodejs python vscode 7zip postman googlechrome -y
```

### PASO 5: Configurar Herramientas Específicas

**Función**: Configurar VS Code, Git y herramientas adicionales  
**Tiempo estimado**: 5 minutos

```powershell
# Configurar VS Code con extensiones
.\tools\setup-scripts\configure_vscode.ps1

# Configurar Git (reemplazar con tus datos)
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"

# Configurar entorno Python
.\tools\setup-scripts\setup_python_env.ps1
```

### PASO 6: Instalar Frameworks Frontend

**Función**: Configurar React, Angular, Vue y Tailwind CSS  
**Tiempo estimado**: 5-10 minutos

```powershell
# Setup completo de frontend
.\tools\setup-scripts\setup_frontend.ps1

# O individualmente:
cd frontend\react-app
npx create-react-app . --template typescript
npm install -D tailwindcss@latest

cd ..\angular-app
npm install -g @angular/cli
ng new . --routing --style=scss

cd ..\vue-app
npm install -g @vue/cli
vue create .
```

## 📁 ESTRUCTURA DEL PROYECTO

### Directorios Principales

```
P:\Repositorio_Principal\
├── 📁 frontend\
│   ├── 📁 react-app\          # Aplicaciones React + Tailwind
│   ├── 📁 angular-app\        # Aplicaciones Angular
│   └── 📁 vue-app\            # Aplicaciones Vue.js
├── 📁 backend\
│   ├── 📁 python-api\         # APIs con FastAPI/Django
│   ├── 📁 java-api\           # APIs con Spring Boot
│   └── 📁 cpp-services\       # Servicios en C++
├── 📁 automation\
│   ├── 📁 n8n-workflows\      # Automatización visual
│   ├── 📁 scripts-python\     # Scripts de automatización
│   └── 📁 scripts-bash\       # Scripts para Linux/Mac
├── 📁 robotics\
│   └── 📁 ros2-packages\      # Paquetes de robótica
├── 📁 Oracle_One_G9\
│   ├── 📁 data\raw\           # Datos sin procesar
│   ├── 📁 data\processed\     # Datos procesados
│   ├── 📁 notebooks\          # Jupyter Notebooks
│   ├── 📁 scripts\            # Scripts de análisis
│   ├── 📁 models\             # Modelos ML guardados
│   └── 📁 docs\               # Documentación del proyecto
├── 📁 docs\                   # Documentación general
└── 📁 tools\
    ├── 📁 setup-scripts\       # Scripts de instalación
    │   ├── 📁 global\          # Scripts globales
    │   ├── 📁 frontend\        # Scripts de frontend
    │   ├── 📁 backend\         # Scripts de backend
    │   ├── 📁 automation\      # Scripts de automatización
    │   ├── 📁 oracle\          # Scripts de Oracle One G9
    │   └── 📁 datascience\     # Scripts de Data Science
    └── 📁 utilidades\          # Utilidades varias
```

### Archivos de Configuración Incluidos

- **`.gitignore`**: Configurado para Node, Python, Java, C++, IDEs
- **`package.json`**: Para cada proyecto frontend
- **`requirements.txt`**: Para proyectos Python
- **`pom.xml`**: Para proyectos Java
- **`CMakeLists.txt`**: Para proyectos C++
- **Notebooks ejemplo**: En Oracle_One_G9

## 📜 SCRIPTS DISPONIBLES

### Scripts de Instalación Principal

| Script | Función | Tiempo | Uso |
|--------|---------|--------|-----|
| `mega_setup.ps1` | Crear estructura base | 1-2 min | Una sola vez |
| `install_basic_tools.ps1` | Instalar herramientas | 10-15 min | Una sola vez |
| `setup_frontend.ps1` | Configurar frontend | 5-10 min | Una sola vez |
| `quick_setup.ps1` | Instalación completa | 15-20 min | **Recomendado** |

### Scripts de Configuración

| Script | Función | Cuándo usar |
|--------|---------|-------------|
| `configure_vscode.ps1` | Configurar VS Code + extensiones | Después de instalar VS Code |
| `configure_git.ps1` | Configurar Git con datos usuario | Después de instalar Git |
| `setup_python_env.ps1` | Crear entornos virtuales Python | Para proyectos Python |
| `setup_tailwind.ps1` | Configurar Tailwind CSS | Para proyectos frontend |

### Scripts de Utilidad

| Script | Función | Uso |
|--------|---------|-----|
| `backup_project.ps1` | Crear backup completo | Semanal |
| `update_all.ps1` | Actualizar todas las herramientas | Mensual |
| `verify_installation.ps1` | Verificar que todo funciona | Cuando hay problemas |
| `clean_project.ps1` | Limpiar archivos temporales | Cuando necesites espacio |

## ✅ VERIFICACIÓN DE INSTALACIÓN

### Verificación Automática

```powershell
# Ejecutar script de verificación completa
.\tools\setup-scripts\verify_installation.ps1
```

### Verificación Manual

**Función**: Confirmar que todas las herramientas funcionan correctamente

```powershell
# Verificar herramientas básicas
git --version
node --version  
npm --version
python --version
code --version

# Verificar Chocolatey
choco --version

# Verificar estructura del proyecto
ls P:\Repositorio_Principal
```

**Resultado esperado**: Todas las versiones deben mostrarse sin errores.

### Verificación de VS Code

```powershell
# Abrir VS Code desde terminal
code .

# Verificar extensiones instaladas (en VS Code):
# Ctrl + Shift + X para ver extensiones
```

**Extensiones que deberían estar instaladas**:
- ES7+ React/Redux/React-Native snippets
- Auto Rename Tag
- Live Server
- Tailwind CSS IntelliSense
- Python
- GitLens
- Prettier

## 🔧 TROUBLESHOOTING

### Problema: "No se puede ejecutar scripts"

**Error**: 
```
no se puede cargar el archivo... porque la ejecución de scripts está deshabilitada
```

**Solución**:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
```

### Problema: "Chocolatey no encontrado"

**Error**: 
```
'choco' no se reconoce como un comando interno o externo
```

**Solución**:
```powershell
# Cerrar y abrir PowerShell como Administrador
refreshenv
# O reinstalar Chocolatey siguiendo el PASO 3
```

### Problema: "Git no encontrado después de instalación"

**Solución**:
```powershell
refreshenv
# O cerrar y abrir PowerShell
# O agregar manualmente al PATH: C:\Program Files\Git\cmd
```

### Problema: "Node.js no encontrado"

**Solución**:
```powershell
# Verificar instalación
choco list nodejs
# Reinstalar si es necesario
choco install nodejs -y --force
refreshenv
```

### Problema: "Permisos de administrador"

**Función**: Algunos scripts necesitan permisos elevados

**Solución**:
1. Cerrar PowerShell
2. Tecla Windows + X
3. Seleccionar "Windows PowerShell (Admin)"
4. Volver a ejecutar el script

### Problema: "Espacio insuficiente"

**Solución**:
```powershell
# Verificar espacio disponible
Get-WmiObject -Class Win32_LogicalDisk | Select-Object Size,FreeSpace,DeviceID

# Limpiar archivos temporales
.\tools\setup-scripts\clean_project.ps1
```

## 🎯 PRÓXIMOS PASOS

### Después de la Instalación Exitosa

1. **Configurar Git con tus datos personales**:
```powershell
git config --global user.name "Tu Nombre Completo"
git config --global user.email "tu-email@ejemplo.com"
```

2. **Crear tu primer proyecto**:
```powershell
cd frontend\react-app
npx create-react-app mi-primer-app
cd mi-primer-app
npm install -D tailwindcss
```

3. **Inicializar repositorio Git**:
```powershell
git init
git add .
git commit -m "Initial commit - Setup completo del entorno"
```

4. **Configurar VS Code con tus preferencias**:
   - Abrir VS Code: `code .`
   - Instalar temas adicionales si deseas
   - Configurar snippets personalizados

### Rutina de Mantenimiento

**Semanal**:
```powershell
.\tools\setup-scripts\update_all.ps1
```

**Mensual**:
```powershell
.\tools\setup-scripts\backup_project.ps1
choco upgrade all -y
```

### Aprendizaje Sugerido

1. **Semana 1**: HTML/CSS básico + Tailwind CSS
2. **Semana 2**: JavaScript vanilla + DOM manipulation
3. **Semana 3**: React básico + componentes
4. **Semana 4**: APIs con Python FastAPI
5. **Semana 5**: Conexión Frontend-Backend

## 📞 SOPORTE

### Recursos de Ayuda

- **Documentación oficial**: Carpeta `docs\`
- **Logs de instalación**: `tools\logs\`
- **Scripts de diagnóstico**: `.\tools\setup-scripts\diagnose.ps1`

### Comandos de Diagnóstico

```powershell
# Generar reporte completo del sistema
.\tools\setup-scripts\system_report.ps1

# Verificar conectividad
Test-NetConnection chocolatey.org -Port 443

# Verificar variables de entorno
$env:PATH -split ';' | Where-Object { $_ -like "*choco*" -or $_ -like "*node*" -or $_ -like "*git*" }
```

---

**📝 Nota**: Este README se actualiza automáticamente con cada nueva versión de los scripts. Fecha de última actualización: 20/08/2025

**🎯 Metodología**: Todos los scripts siguen la convención de comentarios detallados indicando función, evento y fecha de creación para facilitar el mantenimiento y aprendizaje.

**🚀 ¡Tu entorno de desarrollo estará listo en menos de 30 minutos!**