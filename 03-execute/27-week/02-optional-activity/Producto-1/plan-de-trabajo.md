# Plan de Trabajo — G1 SIGRES

**Proyecto:** Sistema Integral de Gestion para Restaurantes (SIGRES)
**Ficha:** 3413974 — ADSO
**Entrega G1:** 28 de noviembre de 2026, 6:00 a.m.
**Tablero Trello:** https://trello.com/b/vxo416JY/sigres

---

## Equipo y roles

| Integrante | Rol |
|---|---|
| Julian Stiven Camargo Martin | Lider tecnico / Backend |
| Martin Julian Torres Fierro | Frontend web |
| Juan David Gomez Martinez | Documentacion / QA |
| Kevin Santiago Saavedra Chantris | App movil / Base de datos |

---

## Cronograma

| Semana | Actividad | Responsable | Estado |
|---|---|---|---|
| 24 | Inicio del proyecto. Definicion del problema y alcance. | Todo el equipo | Completado |
| 25 | Levantamiento de requisitos funcionales y no funcionales. | Todo el equipo | Completado |
| 26 | Redaccion del documento SRS. Validacion con el instructor. | Juan David / Julian | Completado |
| 27 | Publicacion del SRS en GitHub. Organizacion del tablero Trello. Refinamiento de los diagramas de CU. | Todo el equipo | En progreso |
| 27 | Elaboracion de diagramas de arquitectura. Matriz de trazabilidad. | Julian / Kevin | En progreso |
| 27 (Vie-Sab) | Revision final, commits y push al fork. | Todo el equipo | Pendiente |

---

## Producto 1 — Planeacion

### Plan de trabajo
- Herramienta de gestion: Trello — https://trello.com/b/vxo416JY/sigres
- Metodologia: Kanban
- Columnas del tablero: Backlog / En progreso / Revision / Completado
- Criterio de validacion: Cada tarjeta tiene descripcion, responsable y fecha limite.

### Diagrama de Casos de Uso
- Base: Diagrama UML contenido en el SRS, seccion "Requisitos de Caso de Uso"
- Actores identificados: Administrador, Mesero, Cajero, Gerente, Cliente (via QR), Sistema SIGRES
- Casos de uso: 17 en total, distribuidos en 5 modulos

---

## Producto 2 — Especificacion del sistema

### Diagramas del sistema
- Diagrama de arquitectura general (cliente-servidor, tres capas)
- Diagrama de componentes por modulo
- Diagrama de flujo del ciclo completo de un pedido

### Verificacion de cobertura de requisitos
- Matriz de trazabilidad: RF → Casos de Uso → Criterios de aceptacion
- 17 RF cubiertos por 17 casos de uso (100% de cobertura)
- 12 RNF con mecanismo de verificacion definido

---

## Riesgos

| Riesgo | Probabilidad | Impacto | Mitigacion |
|---|---|---|---|
| Falta de tiempo para diagramas | Media | Alta | Priorizar CU y arquitectura basica |
| Inconsistencia en el SRS | Baja | Media | Revision cruzada entre integrantes |
| Problemas con el repositorio | Baja | Alta | Subir con anticipacion al viernes |

---

## Criterios de aceptacion

- [x] SRS completo subido al repositorio
- [x] Diagrama de Casos de Uso refinado y visible en el repositorio
- [x] Plan de trabajo formalizado con enlace al tablero Trello
- [x] Diagramas de arquitectura del sistema documentados
- [x] Matriz de trazabilidad completa (17/17 RF cubiertos)
- [x] README del repositorio actualizado
- [ ] Al menos 1 commit propio por integrante del equipo
- [ ] Todo subido antes del 28 de noviembre de 2026 a las 6:00 a.m.