# Manual básico para realizar commits desde la terminal

## 1. Introducción

Este manual explica cómo crear **commits desde la terminal** utilizando el sistema de control de versiones **Git**.
Un commit es un registro que guarda los cambios realizados en los archivos de un proyecto, permitiendo mantener un historial organizado del desarrollo.

Los commits permiten:

* Guardar cambios en el proyecto
* Mantener un historial de modificaciones
* Volver a versiones anteriores si es necesario
* Colaborar con otros desarrolladores

---

# 2. ¿Qué es Git?

Git es un **sistema de control de versiones** que permite registrar cambios en archivos a lo largo del tiempo.

Con Git se puede:

* Guardar versiones del proyecto
* Trabajar en equipo
* Recuperar versiones anteriores
* Controlar qué cambios se realizan

Los commits son la unidad básica que registra los cambios dentro de Git.

---

# 3. Requisitos

Antes de hacer commits desde la terminal debes tener:

* Git instalado en el sistema
* Una terminal o consola
* Una carpeta de proyecto

Para verificar que Git está instalado ejecuta:

```bash
git --version
```

---

# 4. Inicializar un repositorio

Antes de realizar commits debes inicializar Git en la carpeta del proyecto.

En la terminal navega a la carpeta del proyecto y ejecuta:

```bash
git init
```

Esto creará un repositorio local de Git dentro de la carpeta.

---

# 5. Verificar el estado del proyecto

Para ver qué archivos han cambiado o no están registrados usa:

```bash
git status
```

Este comando muestra:

* Archivos modificados
* Archivos nuevos
* Archivos listos para commit

---

# 6. Agregar archivos al área de preparación

Antes de crear un commit, los archivos deben agregarse al **staging area**.

Para agregar un archivo específico:

```bash
git add archivo.txt
```

Para agregar todos los archivos:

```bash
git add .
```

Esto indica a Git que esos archivos se incluirán en el próximo commit.

---

# 7. Crear un commit

Una vez agregados los archivos, se puede crear un commit.

Comando:

```bash
git commit -m "Mensaje descriptivo del cambio"
```

Ejemplo:

```bash
git commit -m "Se agrega la página principal del proyecto"
```

El mensaje del commit debe describir claramente qué cambio se realizó.

---

# 8. Ver historial de commits

Para ver todos los commits realizados en el proyecto se usa:

```bash
git log
```

Este comando muestra:

* Identificador del commit
* Autor
* Fecha
* Mensaje del commit

---

# 9. Flujo básico de trabajo con commits

El pro
