# Lista de Chequeo de Validacion de Analisis — SIGRES (Anexo B)

Se aplicaron **16 criterios verificables** (respuesta Si/No con evidencia), incluyendo **4 criterios especificos de cobertura y trazabilidad** (criterios 1, 14, 15 y 16).

| # | Criterio verificable (responde si o no) | Artefacto | Cumple? | Evidencia (enlace o cita) | Hallazgo |
|---|---|---|---|---|---|
| 1 | Cada requisito funcional del SRS (RF01-RF17) aparece en al menos un caso de uso | Matriz RF->CU (P1) | Si | `G1-P1-sigres/03-Matriz-Requisito-CU.md` (17/17 cubiertos) | Ninguno |
| 2 | Los requisitos no funcionales estan separados de los casos de uso | Matriz RF->CU (P1) | Si | Seccion 3 de `03-Matriz-Requisito-CU.md` | Ninguno |
| 3 | El diagrama de casos de uso cuenta con frontera del sistema y actores fuera de ella | Diagrama CU (P1) | Si | `G1-P1-sigres/diagrama-casos-de-uso.svg` | Ninguno |
| 4 | Las relaciones `<<include>>` y `<<extend>>` tienen la direccion correcta de flecha y justificacion | Diagrama CU (P1) | Si | `04-Justificacion-Diagrama-CU.md` | H-01 detectado en revision inicial (corregido en registro de ajustes) |
| 5 | Los diagramas de actividades presentan calles por actor, inicio, fin y guardas en todas las salidas | Diagramas de actividades | Si | `01-Diagramas-de-Actividades.md` y `.svg` | H-02 detectado en revision inicial (corregido) |
| 6 | Cada rama alterna o de excepcion del diagrama de actividades aparece en la plantilla del mismo caso | Actividades y plantillas | Si | `CU-03` y `CU-09` en `02-Plantillas-Extendidas-CU.md` | Ninguno |
| 7 | Las 3 plantillas extendidas tienen flujo principal de 6 o mas pasos en orden actor-sistema | Plantillas extendidas | Si | `02-Plantillas-Extendidas-CU.md` (6 pasos cada una) | Ninguno |
| 8 | Las plantillas extendidas carecen de detalles de implementacion (SQL, tablas, endpoints) | Plantillas extendidas | Si | `02-Plantillas-Extendidas-CU.md` | H-03 detectado en borrador inicial (corregido) |
| 9 | El modelo de dominio contiene 8 o mas clases conceptuales sin metodos ni claves foraneas | Modelo de dominio | Si | `03-Modelo-de-Dominio.md` (11 clases conceptuales) | H-04 detectado en revision inicial (corregido) |
| 10 | Al menos 5 clases del modelo de dominio tienen 2 o mas atributos de negocio | Modelo de dominio | Si | `03-Modelo-de-Dominio.md` (11/11 clases con >=2 atributos) | Ninguno |
| 11 | El MER declara la notacion utilizada (Pata de Gallo) y tiene 6 o mas entidades | MER | Si | `04-Modelo-Entidad-Relacion.md` (9 entidades) | Ninguno |
| 12 | La relacion N:M del MER se resuelve mediante entidad asociativa con atributos propios | MER | Si | Entidad `DETALLE_PEDIDO` en `modelo-er.svg` | Ninguno |
| 13 | Las 3 pantallas del prototipo estan rotuladas con el caso de uso que atienden | Prototipo inicial | Si | `05-Prototipo-Inicial.md` | Ninguno |
| 14 | Todo concepto usado en las plantillas extendidas existe en el modelo de dominio | Dominio y plantillas | Si | `Mesa`, `Pedido`, `Producto`, `Factura`, `Pago` en `modelo-dominio.svg` | Ninguno |
| 15 | Al menos el 90 % de los RF estan trazados desde requisito hasta clase de dominio y entidad del MER | Matriz de trazabilidad | Si | `09-Matriz-de-Trazabilidad.md` (17/17 = 100 %) | H-05 detectado en revision inicial (corregido) |
| 16 | Los casos criticos trazan hasta su pantalla correspondiente del prototipo | Matriz y prototipo | Si | Filas RF04, RF12, RF16 en `09-Matriz-de-Trazabilidad.md` | Ninguno |
