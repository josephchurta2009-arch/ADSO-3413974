# 📅 Plan de Trabajo — G1 SIGRES

**Proyecto:** Sistema Integral de Gestión para Restaurantes (SIGRES)  
**Ficha:** 3413974 — ADSO  
**Entrega G1:** Sábado 28 de noviembre de 2026, 6:00 a.m.  
**Tablero Trello:** *(agregar enlace al tablero)*

---

## 👥 Equipo y roles

| Integrante | Rol en el proyecto |
|---|---|
| Julián Stiven Camargo Martin | Lider técnico / Backend |
| Martin Julián Torres Fierro | Frontend web |
| Juan David Gómez Martínez | Documentación / QA |
| Kevin Santiago Saavedra Chantris | App móvil / Base de datos |

---

## 🗓️ Cronograma de actividades (G1)

| Semana | Actividad | Responsable | Estado |
|---|---|---|---|
| **Semana 24** | Inicio del proyecto. Definición del problema y alcance. | Todo el equipo | ✅ Completado |
| **Semana 25** | Levantamiento de requisitos funcionales y no funcionales. | Todo el equipo | ✅ Completado |
| **Semana 26** | Redacción del documento SRS. Validación con el instructor. | Juan David / Julián | ✅ Completado |
| **Semana 27** | Publicación del SRS en GitHub. Organización del tablero Trello. Pulir diagramas de CU. | Todo el equipo | 🔄 En progreso |
| **Semana 27** | Elaboración de diagramas de arquitectura. Matriz de trazabilidad. | Julián / Kevin | 🔄 En progreso |
| **Sem 27 (Vie-Sáb)** | Revisión final, commits y push al fork. Verificación del README. | Todo el equipo | ⏳ Pendiente |

---

## 📦 Producto 1 — Planeación

### 1.1 Plan de trabajo
- **Herramienta de gestión:** Trello
- **Metodología:** Kanban adaptado
- **Columnas del tablero:** Backlog → En progreso → Revisión → Completado
- **Criterio de validación:** Cada tarjeta tiene descripción, responsable y fecha límite

### 1.2 Diagrama de Casos de Uso
- **Base:** Diagrama UML contenido en el SRS (sección "Requisitos de Caso de Uso")
- **Actores identificados:**
  - Administrador
  - Mesero
  - Cajero
  - Gerente
  - Cliente (vía QR)
  - Sistema SIGRES (actor interno)
- **Casos de uso principales por módulo:**
  - CU-01: Registrar usuario / Iniciar sesión / Gestionar roles
  - CU-02: Registrar pedido / Enviar a cocina / Consultar estado / Actualizar estado
  - CU-03: Administrar menú / Gestionar inventario
  - CU-04: Generar factura / Procesar pago / Cerrar caja
  - CU-05: Gestionar mesas
  - CU-06: Generar reportes
  - CU-07: Ver menú QR / Consultar consumo (sin login)

---

## 📦 Producto 2 — Especificación del sistema

### 2.1 Diagramas del sistema
- Diagrama de arquitectura general (cliente-servidor)
- Diagrama de componentes por módulo
- Diagrama de flujo principal (pedido completo: mesero → cocina → caja → cliente)

### 2.2 Verificación de cobertura de requisitos
- Matriz de trazabilidad: RF ↔ Casos de Uso ↔ Criterios de aceptación
- Revisión de los 17 RF contra sus fichas de CU
- Revisión de los 7 RNF contra restricciones del sistema

---

## ⚠️ Riesgos identificados

| Riesgo | Probabilidad | Impacto | Mitigación |
|---|---|---|---|
| Falta de tiempo para diagramas | Media | Alta | Priorizar CU y arquitectura básica |
| Inconsistencia en el SRS | Baja | Media | Revisión cruzada entre integrantes |
| Problemas con el fork de GitHub | Baja | Alta | Subir con anticipación (antes del viernes) |

---

## ✅ Criterios de aceptación de la G1

- [ ] SRS completo subido al fork (carpeta `02-training-project/G1/Producto-1/`)
- [ ] Diagrama de Casos de Uso pulido y visible en el repositorio
- [ ] Plan de trabajo formalizado (este documento + Trello)
- [ ] Diagramas de arquitectura en carpeta `Producto-2/`
- [ ] Matriz de trazabilidad completa
- [ ] README del proyecto actualizado
- [ ] Mínimo 1 commit propio por integrante
- [ ] Todo subido antes del sábado 28/11/2026 a las 6:00 a.m.
