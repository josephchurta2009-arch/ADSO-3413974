# Entrega Producto 1 — Guia 1 · Modelo Conceptual

## 1. Datos de la entrega

- **Producto:** P1 plan de analisis y casos de uso
- **Usuario de GitHub del autor:** josephchurta2009-arch
- **Caso de estudio:** SIGRES — Sistema Integral de Gestion para Restaurantes
- **Trabajo en equipo del ano:** si (equipo del proyecto formativo SIGRES)

## 2. Que reutilice

| Artefacto | Ruta original en mi fork (semana) | Lo hice solo o en equipo? |
|---|---|---|
| Especificacion de Requisitos de Software (SRS - SIGRES) | Documento base del proyecto formativo (`SRS-SIGRES.docx`) | En equipo |

## 3. Que ajuste

| # | Artefacto | Que cambie y por que | Enlace al commit |
|---|---|---|---|
| 1 | Diagrama de casos de uso UML | Se agruparon operaciones CRUD en casos de uso cohesivos (CU-01, CU-07, CU-08, CU-15), se anadio frontera del sistema, actor generalizado `Usuario Autenticado` y actor secundario `Sistema de Cocina` (criterio C4). | [Pendiente de segundo commit](https://github.com/josephchurta2009-arch/ADSO-3413974/commits/main) |
| 2 | Relaciones del diagrama | Se definieron y justificaron las relaciones `<<include>>` y `<<extend>>` con la direccion correcta de flecha segun la seccion 7 de la rubrica (criterio C4). | [Pendiente de segundo commit](https://github.com/josephchurta2009-arch/ADSO-3413974/commits/main) |
| 3 | Matriz requisito a caso de uso | Se separaron explicitamente los 17 RF de los RNF del SRS para asegurar trazabilidad del 100 % sin mezclar atributos de calidad como casos de uso (criterio C3). | [Pendiente de segundo commit](https://github.com/josephchurta2009-arch/ADSO-3413974/commits/main) |

## 4. Que construi nuevo

- Caracterizacion de la solucion y comparacion de 4 metodologias (Scrum, RUP, XP, RAD) con seleccion justificada de Scrum.
- Plan de actividades de analisis organizado en 2 Sprints con 7 actividades, fechas y entregables.
- Fuente editable `.drawio` e imagen `.svg` del diagrama de casos de uso UML junto con su justificacion escrita.

## 5. Artefactos entregados

**Producto 1**

- [x] Caracterizacion de la solucion: [01-Caracterizacion-y-Metodologia.md](./01-Caracterizacion-y-Metodologia.md)
- [x] Comparacion de metodologias y seleccion justificada: [01-Caracterizacion-y-Metodologia.md](./01-Caracterizacion-y-Metodologia.md)
- [x] Plan de actividades, cronograma y entregables: [02-Plan-de-Actividades.md](./02-Plan-de-Actividades.md)
- [x] Diagrama de casos de uso (fuente editable): [diagrama-casos-de-uso.drawio](./diagrama-casos-de-uso.drawio)
- [x] Diagrama de casos de uso (imagen): [diagrama-casos-de-uso.svg](./diagrama-casos-de-uso.svg)
- [x] Matriz requisito -> caso de uso: [03-Matriz-Requisito-CU.md](./03-Matriz-Requisito-CU.md)
- [x] Justificacion de relaciones UML: [04-Justificacion-Diagrama-CU.md](./04-Justificacion-Diagrama-CU.md)

## 6. Declaracion de autoria

- [x] Declaro que el ajuste y lo construido nuevo en esta carpeta es **mi trabajo individual**.
- [x] Declaro que lo que tome de mi equipo o de otra fuente esta identificado en la seccion 2.
- [x] Entiendo que el sabado 28 de noviembre de 2026 el instructor me hara **3 preguntas orales** sobre mis productos (una del producto 1, una del producto 2 y una tercera a su eleccion) y que, si respondo bien menos de 2, el producto sobre el que falle queda con tope de 50.

Firma (usuario de GitHub y fecha): josephchurta2009-arch — 2026-11-25

## 7. Uso de inteligencia artificial

| Herramienta | Para que la use | Que verifique o corregi yo |
|---|---|---|
| Asistente de IA | Estructurar los documentos segun `Rubricas_G1.md` y generar el borrador del archivo `.drawio` y `.svg` | Verifique la cobertura del 100 % de los 17 RF del SRS, la direccion de las flechas `<<include>>` y `<<extend>>` y la coherencia de los actores. |

## 8. Autocontrol antes del push

- [ ] Hice commits propios en al menos 2 dias distintos entre la publicacion de la guia (sabado 21 de noviembre de 2026) y la entrega. *(Realizar un commit adicional el 26 o 27 de noviembre y actualizar los enlaces de la seccion 3).*
- [x] No subi el marco documental del instructor, plantillas sin diligenciar ni archivos de otras personas.
- [x] Hice `push` y comprobe en GitHub que la carpeta esta publicada.
