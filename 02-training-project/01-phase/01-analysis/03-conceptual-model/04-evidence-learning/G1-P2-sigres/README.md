# Entrega Producto 2 — Guia 1 · Modelo Conceptual

## 1. Datos de la entrega

- **Producto:** P2 modelo de analisis y verificacion
- **Usuario de GitHub del autor:** josephchurta2009-arch
- **Caso de estudio:** SIGRES — Sistema Integral de Gestion para Restaurantes
- **Trabajo en equipo del ano:** si (equipo del proyecto formativo SIGRES)

## 2. Que reutilice

| Artefacto | Ruta original en mi fork (semana) | Lo hice solo o en equipo? |
|---|---|---|
| Especificacion de Requisitos de Software (SRS - SIGRES) | Documento base del proyecto formativo (`SRS-SIGRES.docx`) | En equipo |
| Prototipo inicial en Google Stitch | https://stitch.google.com/projects/12308260585995939873 | En equipo |

## 3. Que ajuste

| # | Artefacto | Que cambie y por que | Enlace al commit |
|---|---|---|---|
| 1 | Plantillas extendidas de CU | Se reestructuraron las descripciones del SRS al formato Anexo A eliminando referencias tecnicas (JWT, SQL) (criterio C2). | [255e4e5](https://github.com/josephchurta2009-arch/ADSO-3413974/commit/255e4e56b989caa9c6b897bf15eb203b9485fec7) |
| 2 | Modelo de dominio | Se depuraron los identificadores tecnicos (`id`) para mantener unicamente conceptos y atributos de negocio sin metodos (criterio C3). | [2685bad](https://github.com/josephchurta2009-arch/ADSO-3413974/commit/2685bade50128ad035628d773c9b0c797c807be2) |
| 3 | Diagrama de actividades y trazabilidad | Se agregaron guardas completas en decisiones alternas y se completo la matriz Anexo C hasta clase, entidad y pantalla (criterios C1 y C8). | [5889cc4](https://github.com/josephchurta2009-arch/ADSO-3413974/commit/5889cc4b36347a3a6e6e543c1ddc4f49bab009de) |

## 4. Que construi nuevo

- 2 diagramas de actividades UML en formato `.drawio` y `.svg` (`CU-03` y `CU-09`).
- Modelo de dominio (11 clases conceptuales) y Modelo Entidad-Relacion en notacion Pata de Gallo (9 entidades, con asociativa `DETALLE_PEDIDO` y entidad debil `PAGO`).
- Lista de chequeo diligenciada (16 criterios), registro de ajustes (5 hallazgos verificados), matriz de trazabilidad Anexo C e informe final de analisis.

## 5. Artefactos entregados

**Producto 2**

- [x] Diagramas de actividades (2 o mas): [01-Diagramas-de-Actividades.md](./01-Diagramas-de-Actividades.md)
- [x] Plantillas extendidas de casos de uso (3 o mas): [02-Plantillas-Extendidas-CU.md](./02-Plantillas-Extendidas-CU.md)
- [x] Modelo de dominio: [03-Modelo-de-Dominio.md](./03-Modelo-de-Dominio.md)
- [x] Modelo entidad-relacion: [04-Modelo-Entidad-Relacion.md](./04-Modelo-Entidad-Relacion.md)
- [x] Prototipo inicial (3 o mas pantallas): [05-Prototipo-Inicial.md](./05-Prototipo-Inicial.md)
- [x] Lista de chequeo diligenciada (15 o mas criterios): [06-Lista-de-Chequeo.md](./06-Lista-de-Chequeo.md)
- [x] Registro de ajustes y segunda verificacion: [07-Registro-de-Ajustes.md](./07-Registro-de-Ajustes.md)
- [x] Informe de analisis: [08-Informe-de-Analisis.md](./08-Informe-de-Analisis.md)
- [x] Matriz de trazabilidad (Anexo C): [09-Matriz-de-Trazabilidad.md](./09-Matriz-de-Trazabilidad.md)

## 6. Declaracion de autoria

- [x] Declaro que el ajuste y lo construido nuevo en esta carpeta es **mi trabajo individual**.
- [x] Declaro que lo que tome de mi equipo o de otra fuente esta identificado en la seccion 2.
- [x] Entiendo que el sabado 28 de noviembre de 2026 el instructor me hara **3 preguntas orales** sobre mis productos (una del producto 1, una del producto 2 y una tercera a su eleccion) y que, si respondo bien menos de 2, el producto sobre el que falle queda con tope de 50.

Firma (usuario de GitHub y fecha): josephchurta2009-arch — 2026-11-27

## 7. Uso de inteligencia artificial

| Herramienta | Para que la use | Que verifique o corregi yo |
|---|---|---|
| Asistente de IA | Estructurar los documentos segun `Rubricas_G1.md` y generar borradores `.drawio` y `.svg` | Verifique la consistencia entre flujos de actividades y plantillas extendidas, la ausencia de detalles tecnicos en dominio/plantillas y la cobertura del 100 % en la matriz Anexo C. |

## 8. Autocontrol antes del push

- [x] Hice commits propios en al menos 2 dias distintos entre la publicacion de la guia (sabado 21 de noviembre de 2026) y la entrega (25 y 27 de noviembre de 2026).
- [x] No subi el marco documental del instructor, plantillas sin diligenciar ni archivos de otras personas.
- [x] Hice `push` y comprobe en GitHub que la carpeta esta publicada.