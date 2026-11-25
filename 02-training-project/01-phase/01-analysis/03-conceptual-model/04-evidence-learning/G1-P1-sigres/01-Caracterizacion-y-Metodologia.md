# Caracterizacion de la Solucion y Seleccion de Metodologia — SIGRES

**Proyecto:** Sistema Integral de Gestion para Restaurantes (SIGRES)
**Autor (GitHub):** josephchurta2009-arch
**Base:** SRS - SIGRES (documento de requisitos del proyecto formativo)

---

## 1. Caracterizacion de la solucion

| Aspecto | Descripcion en SIGRES |
|---|---|
| **Tipo de proyecto** | Sistema de informacion multiplataforma (aplicacion web para administracion, caja y gerencia; aplicacion movil para meseros; interfaz web responsiva por codigo QR para clientes) con base de datos relacional centralizada. |
| **Tamano del equipo** | Equipo pequeno de **4 integrantes** con roles multidisciplinarios (analisis, frontend web, movil, backend y pruebas). |
| **Estabilidad de requisitos** | **Media-alta.** El sistema cuenta con 17 requisitos funcionales y 12 requisitos no funcionales especificados en el SRS base, aunque pueden surgir ajustes menores en reglas de facturacion, inventario o flujos de cocina al validar con el restaurante. |
| **Disponibilidad del cliente** | **Moderada / parcial.** Los stakeholders del restaurante tienen disponibilidad limitada durante la operacion diaria, por lo que las validaciones se concentran en revisiones puntuales al cierre de cada iteracion. |

---

## 2. Comparacion de metodologias de desarrollo

Se comparan las 4 metodologias solicitadas (**Scrum**, **RUP**, **XP** y **RAD**) evaluadas con criterios derivados directamente de las caracteristicas del proyecto:

| Criterio (desde caracterizacion) | Scrum | RUP | XP (Extreme Programming) | RAD |
|---|---|---|---|---|
| **Adecuacion al tamano del equipo (4 personas)** | Alta: disenado para equipos pequenos y autoorganizados (3 a 9 personas). | Baja-media: orientado a equipos medianos/grandes con roles muy especializados y alta carga documental. | Alta: ideal para equipos pequenos (2 a 12 desarrolladores) con comunicacion directa. | Media: funciona en equipos pequenos, pero exige alta disponibilidad de usuarios expertos. |
| **Manejo de estabilidad de requisitos (media-alta con ajustes)** | Alta: trabaja con Product Backlog priorizado e iteraciones cortas (Sprints) que absorben cambios sin rehacer todo el plan. | Media: gestiona cambios mediante fases formales (Inicio, Elaboracion, Construccion, Transicion), menos agil ante ajustes rapidos. | Muy alta: optimizado para requisitos muy cambiantes, aunque requiere pruebas automatizadas estrictas desde el inicio. | Media-alta: permite prototipado rapido, pero puede perder control arquitectonico si cambian reglas de negocio criticas. |
| **Dependencia de disponibilidad del cliente (moderada)** | Alta compatibilidad: el cliente o Product Owner solo necesita participar en la definicion del backlog y en la Sprint Review al final de cada iteracion. | Media: requiere validaciones formales al cierre de cada fase. | Baja compatibilidad: exige cliente presencial o disponible de forma continua (On-site Customer). | Baja compatibilidad: requiere participacion intensiva del usuario durante el diseno conjunto (JAD). |
| **Trazabilidad y soporte para analisis multiplataforma** | Alta: permite dividir modulos (pedidos, inventario, QR, caja) en incrementos funcionales claros. | Muy alta: fuerte en modelado UML y artefactos formales en la fase de Elaboracion. | Media: prioriza codigo sobre documentacion formal de analisis. | Media: enfocado en interfaz rapida mas que en trazabilidad documental. |

---

## 3. Metodologia seleccionada y justificacion

**Metodologia seleccionada:** **Scrum** (complementada con modelado UML ligero para los artefactos de analisis).

**Justificacion:**
1. **Tamano del equipo (4 integrantes):** Scrum se adapta de forma natural a un equipo pequeno de 4 personas, evitando la sobrecarga burocratica de RUP.
2. **Disponibilidad moderada del cliente:** A diferencia de XP o RAD, Scrum no exige la presencia continua del cliente todos los dias; basta con su participacion en la validacion de entregables al cierre de cada iteracion (Sprint Review).
3. **Estabilidad media-alta de requisitos:** Permite consolidar los 8 modulos del SRS en un Product Backlog priorizado, entregando primero el analisis de los flujos criticos (pedidos, cocina, facturacion) y ajustando detalles en iteraciones cortas.
4. **Coherencia con el cronograma academico:** Permite organizar las actividades de analisis y verificacion en bloques semanales medibles con entregables concretos.
