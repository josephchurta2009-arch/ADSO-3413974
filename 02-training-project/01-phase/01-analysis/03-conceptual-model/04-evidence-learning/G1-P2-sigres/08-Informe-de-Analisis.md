# Informe de Analisis de Requisitos y Verificacion — SIGRES

**Proyecto:** Sistema Integral de Gestion para Restaurantes (SIGRES)
**Autor (GitHub):** josephchurta2009-arch
**Fecha:** 25 de noviembre de 2026

---

## 1. Interpretacion de requisitos (funcionales y no funcionales)

A partir de la Especificacion de Requisitos de Software (`SRS - SIGRES`), se analizaron **17 Requisitos Funcionales (RF01 a RF17)** distribuidos en ocho modulos operativos: autenticacion y roles, gestion de pedidos en salon y cocina, catalogo de menu, control de inventario, facturacion y cierre de caja, gestion de mesas, reportes de ventas y menu digital QR para clientes.

De forma complementaria, se separaron los **12 Requisitos No Funcionales (RNF)** en cinco categorias de calidad:
- **Seguridad:** Cifrado de comunicaciones mediante HTTPS, resguardo seguro de credenciales y control de acceso basado en roles.
- **Rendimiento:** Transmision de comandas hacia cocina en un tiempo maximo de 5 segundos.
- **Usabilidad:** Interfaces responsivas adaptadas a personal con nivel tecnico basico y mensajes claros ante errores.
- **Disponibilidad y fiabilidad:** Operacion estable en horario comercial con integridad en transacciones de facturacion.
- **Compatibilidad:** Operacion en navegadores modernos y dispositivos moviles con camara para lectura de codigos QR.

---

## 2. Enlaces a los modelos elaborados

- **Diagrama de Casos de Uso (Producto 1):** [diagrama-casos-de-uso.svg](../G1-P1-sigres/diagrama-casos-de-uso.svg) ([fuente .drawio](../G1-P1-sigres/diagrama-casos-de-uso.drawio))
- **Diagramas de Actividades (Producto 2):** [01-Diagramas-de-Actividades.md](./01-Diagramas-de-Actividades.md)
- **Plantillas Extendidas de CU (Anexo A):** [02-Plantillas-Extendidas-CU.md](./02-Plantillas-Extendidas-CU.md)
- **Modelo de Dominio:** [03-Modelo-de-Dominio.md](./03-Modelo-de-Dominio.md) ([imagen .svg](./modelo-dominio.svg))
- **Modelo Entidad-Relacion (MER):** [04-Modelo-Entidad-Relacion.md](./04-Modelo-Entidad-Relacion.md) ([imagen .svg](./modelo-er.svg))
- **Prototipo Inicial (Mockup):** [05-Prototipo-Inicial.md](./05-Prototipo-Inicial.md)
- **Matriz de Trazabilidad (Anexo C):** [09-Matriz-de-Trazabilidad.md](./09-Matriz-de-Trazabilidad.md)

---

## 3. Resultado de la verificacion

Al aplicar la lista de chequeo de **16 criterios verificables** ([06-Lista-de-Chequeo.md](./06-Lista-de-Chequeo.md)), inicialmente **11 criterios cumplieron** de forma directa y se detectaron **5 hallazgos** en aspectos de notacion y trazabilidad:
1. Direccion invertida en las flechas `<<extend>>` del diagrama de casos de uso.
2. Ausencia de una guarda negativa en el diagrama de actividades de pedido.
3. Presencia de terminos tecnicos de implementacion dentro de una plantilla extendida.
4. Inclusion de claves foraneas tecnicas dentro del modelo de dominio conceptual.
5. Trazabilidad incompleta en la matriz inicial (faltaban clase de dominio y entidad del MER).

---

## 4. Ajustes realizados y conclusion

Los 5 hallazgos fueron corregidos y documentados en el registro de ajustes ([07-Registro-de-Ajustes.md](./07-Registro-de-Ajustes.md)), ejecutando una segunda verificacion donde **los 16 criterios pasaron a estado «Si»**. Con ello se garantiza una cobertura del **100 % (17/17 RF)** consistente entre el SRS, los casos de uso, los diagramas de comportamiento, el modelo de dominio, el MER y las pantallas criticas del prototipo.
