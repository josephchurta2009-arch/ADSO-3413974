# Plan de Actividades de Analisis — SIGRES

**Metodologia seleccionada:** Scrum (adaptado a la fase de analisis)
**Tablero de seguimiento:** https://trello.com/b/vxo416JY/sigres
**Autor (GitHub):** josephchurta2009-arch

---

## 1. Estrategia de trabajo bajo Scrum

Dado que la guia corresponde a la fase de analisis (modelo conceptual), el trabajo se organiza en **2 Sprints cortos** dentro de la ventana del 21 al 28 de noviembre de 2026, priorizando primero los artefactos de planeacion y modelado funcional (Producto 1) y luego el modelado detallado y la verificacion (Producto 2).

---

## 2. Cronograma de actividades de analisis

| # | Sprint | Actividad | Responsable (GitHub) | Fecha limite | Entregable | Prioridad |
|---|---|---|---|---|---|---|
| 1 | Sprint 1 | Revision del SRS base, caracterizacion de la solucion y seleccion justificada de metodologia | josephchurta2009-arch | 2026-11-23 | `01-Caracterizacion-y-Metodologia.md` | Alta |
| 2 | Sprint 1 | Definicion del Product Backlog de analisis, cronograma y configuracion del tablero Kanban en Trello | josephchurta2009-arch | 2026-11-24 | `02-Plan-de-Actividades.md` y tablero Trello | Alta |
| 3 | Sprint 1 | Construccion de la matriz requisito funcional a caso de uso (distinguiendo RF y RNF) | josephchurta2009-arch | 2026-11-25 | `03-Matriz-Requisito-CU.md` | Alta |
| 4 | Sprint 1 | Refinamiento del diagrama de casos de uso UML (frontera, actores, include, extend, generalizacion) y justificacion de relaciones | josephchurta2009-arch | 2026-11-25 | `diagrama-casos-de-uso.drawio`, `.svg` y `04-Justificacion-Diagrama-CU.md` | Alta |
| 5 | Sprint 2 | Elaboracion de diagramas de actividades de casos criticos y 3 plantillas extendidas de casos de uso (Anexo A) | josephchurta2009-arch | 2026-11-26 | `01-Diagramas-de-Actividades.md` y `02-Plantillas-Extendidas-CU.md` | Alta |
| 6 | Sprint 2 | Construccion del modelo de dominio, modelo entidad-relacion (MER) y rotulacion del prototipo inicial | josephchurta2009-arch | 2026-11-26 | `03-Modelo-de-Dominio.md`, `04-Modelo-Entidad-Relacion.md` y `05-Prototipo-Inicial.md` | Alta |
| 7 | Sprint 2 | Aplicacion de lista de chequeo (Anexo B), registro de ajustes (Anexo D), matriz de trazabilidad (Anexo C) e informe final de analisis | josephchurta2009-arch | 2026-11-27 | `06-Lista-de-Chequeo.md`, `07-Registro-de-Ajustes.md`, `08-Informe-de-Analisis.md`, `09-Matriz-de-Trazabilidad.md` | Alta |

---

## 3. Ceremonias y control

- **Planificacion:** Priorizacion de los 17 RF del SRS segun criticidad operativa (Pedidos y Facturacion primero).
- **Revision (Sprint Review):** Verificacion de cobertura con la lista de chequeo (Anexo B) antes del cierre de cada bloque.
- **Control de versiones:** Commits distribuidos en al menos 2 dias calendario distintos en cada carpeta de entrega.
