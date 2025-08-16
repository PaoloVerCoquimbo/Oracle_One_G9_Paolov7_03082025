# Changelog
Este archivo sigue el formato [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/) y documenta todos los cambios relevantes del repositorio educativo.

> ℹ️ Nota: Este repositorio es exclusivamente para **aprendizaje**.  
> Los proyectos reales o con potencial de patente están en repositorios privados.

---

## [2025-08-14] - Revisión y documentación inicial
### Added
- **Explicación del uso de los diferentes tipos de archivos del repositorio**:
  - **Scripts (`.ps1`, `.sh`, `.bat`)**
    - **Qué son:** Archivos de comandos que automatizan tareas como instalación de software o configuración de entornos.
    - **Para qué sirven:** Reducen el tiempo y errores al configurar el entorno de trabajo.
    - **Cuándo se usan:**  
      1. Primera instalación de herramientas (por ejemplo, `setup_tools.ps1`).  
      2. Configuración repetible en múltiples equipos o máquinas virtuales.  
      3. Automatización de tareas repetitivas.
  - **Notebooks (`.ipynb`)**
    - **Qué son:** Archivos ejecutables en Jupyter Notebook que combinan texto, código y resultados.
    - **Para qué sirven:** Documentar y enseñar conceptos de programación, análisis de datos y automatización.
    - **Cuándo se usan:**  
      1. Para explicar un flujo de trabajo paso a paso.  
      2. En cursos o talleres donde se combina teoría y práctica en un mismo archivo.  
      3. Para pruebas rápidas de código y visualización de datos.
  - **Documentación (`.md`)**
    - **Qué son:** Archivos de texto en formato Markdown, fáciles de leer en GitHub.
    - **Para qué sirven:** Explicar uso, instalación, teoría o pasos de un proyecto/ejemplo.
    - **Cuándo se usan:**  
      1. En el README principal para explicar el repositorio.  
      2. En guías de uso, tutoriales o referencia rápida.
  - **Archivos de configuración (`.json`, `.yaml`, `.env`)**
    - **Qué son:** Archivos que definen parámetros para que un script o programa funcione.
    - **Para qué sirven:** Mantener variables separadas del código, facilitando cambios sin modificar la lógica.
    - **Cuándo se usan:**  
      1. Configurar una API o conexión sin tocar el código principal.  
      2. Mantener ajustes personalizados para cada entorno.
  - **Recursos (`/assets`, `/img`, `/data`)**
    - **Qué son:** Carpetas con imágenes, datos de prueba y otros recursos.
    - **Para qué sirven:** Centralizar archivos no ejecutables que soportan los ejemplos.
    - **Cuándo se usan:**  
      1. En tutoriales que usan datos reales o gráficos.  
      2. Para ejemplos visuales en notebooks o Markdown.

### Reviewed
- **Script `setup_tools.ps1`**:
  - Confirmado: No contiene contraseñas, tokens ni credenciales.
  - Advertencia: Los scripts referenciados (`configure_vscode.ps1`, `setup_tailwind.ps1`, `configure_git.ps1`) deben revisarse antes de subirlos.
  - Función: Instalar herramientas básicas como Git, Node.js, Python, VS Code, 7zip, Postman y Google Chrome usando Chocolatey.

---

## [2025-08-09] - Estructura inicial del repositorio
### Added
- Carpeta `tools/setup-scripts` para centralizar scripts de instalación y configuración.
- Carpeta `tools/utilidades` para scripts y programas de apoyo.
- Establecida convención de carpetas y tipos de archivo para mantener el repositorio limpio y entendible.

---

## Notas generales
- Antes de subir cualquier script, verificar que:
  1. No incluya datos personales o credenciales.
  2. Sea compatible con el sistema operativo objetivo.
  3. Tenga comentarios explicativos para uso educativo.
- Los ejemplos reales de negocio, algoritmos patentables o integraciones sensibles deben ir **solo en repositorios privados**.
