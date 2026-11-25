# Planeacion G1 — SIGRES

**Proyecto:** Sistema Integral de Gestion para Restaurantes (SIGRES)
**Ficha:** 3413974 - ADSO
**Entrega G1:** Sabado 28 de noviembre de 2026, 6:00 a.m.
**Tablero Trello:** https://trello.com/b/vxo416JY/sigres

---

## Equipo y roles

| Integrante | Rol en el proyecto |
|---|---|
| Julian Stiven Camargo Martin | Lider tecnico / Backend |
| Martin Julian Torres Fierro | Frontend web |
| Juan David Gomez Martinez | Documentacion / QA |
| Kevin Santiago Saavedra Chantris | App movil / Base de datos |

---

## Cronograma de actividades (G1)

| Semana | Actividad | Responsable | Estado |
|---|---|---|---|
| **Semana 24** | Inicio del proyecto. Definicion del problema y alcance. | Todo el equipo | Completado |
| **Semana 25** | Levantamiento de requisitos funcionales y no funcionales. | Todo el equipo | Completado |
| **Semana 26** | Redaccion del documento SRS. Validacion con el instructor. | Juan David / Julian | Completado |
| **Semana 27** | Publicacion del SRS en GitHub. Organizacion del tablero Trello. Pulir diagramas de CU. | Todo el equipo | En progreso |
| **Semana 27** | Elaboracion de diagramas de arquitectura. Matriz de trazabilidad. | Julian / Kevin | En progreso |
| **Sem 27 (Vie-Sab)** | Revision final, commits y push al fork. Verificacion del README. | Todo el equipo | Pendiente |

---

## Producto 1 — Planeacion

### 1.1 Plan de trabajo
- **Herramienta de gestion:** Trello — https://trello.com/b/vxo416JY/sigres
- **Metodologia:** Kanban adaptado
- **Columnas del tablero:** Backlog / En progreso / Revision / Completado
- **Criterio de validacion:** Cada tarjeta tiene descripcion, responsable y fecha limite

### 1.2 Diagrama de Casos de Uso
- **Base:** Diagrama UML contenido en el SRS (seccion "Requisitos de Caso de Uso")
- **Actores identificados:**
  - Administrador
  - Mesero
  - Cajero
  - Gerente
  - Cliente (via QR)
  - Sistema SIGRES (actor interno)
- **Casos de uso principales por modulo:**
  - CU-01 al CU-03: Autenticacion y gestion de usuarios
  - CU-04 al CU-07: Gestion de pedidos
  - CU-08 al CU-11: Menu, inventario y mesas
  - CU-12 al CU-14: Facturacion y caja
  - CU-15: Reportes
  - CU-16 al CU-17: Menu digital QR (clientes sin login)

---

## Producto 2 — Especificacion del sistema

### 2.1 Diagramas del sistema
- Diagrama de arquitectura general (cliente-servidor)
- Diagrama de componentes por modulo
- Diagrama de flujo principal (pedido completo: mesero → cocina → caja → cliente)

### 2.2 Verificacion de cobertura de requisitos
- Matriz de trazabilidad: RF → Casos de Uso → Criterios de aceptacion
- 17 RF cubiertos por 17 casos de uso (100% de cobertura)
- 12 RNF con mecanismo de verificacion definido

---

## Riesgos identificados

| Riesgo | Probabilidad | Impacto | Mitigacion |
|---|---|---|---|
| Falta de tiempo para diagramas | Media | Alta | Priorizar CU y arquitectura basica |
| Inconsistencia en el SRS | Baja | Media | Revision cruzada entre integrantes |
| Problemas con el fork de GitHub | Baja | Alta | Subir con anticipacion (antes del viernes) |

---

## Criterios de aceptacion de la G1

- [x] SRS completo subido al fork (Producto-1/SRS-SIGRES.docx)
- [x] Diagrama de Casos de Uso pulido y visible en el repositorio
- [x] Plan de trabajo formalizado (este documento + Trello)
- [x] Diagramas de arquitectura en Producto-2/
- [x] Matriz de trazabilidad completa (17/17 RF cubiertos)
- [x] README del proyecto actualizado
- [ ] Minimo 1 commit propio por integrante del equipo
- [ ] Todo subido antes del sabado 28/11/2026 a las 6:00 a.m.