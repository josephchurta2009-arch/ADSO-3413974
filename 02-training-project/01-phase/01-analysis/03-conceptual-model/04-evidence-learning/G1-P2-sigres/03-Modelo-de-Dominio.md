# Modelo de Dominio — SIGRES

El modelo de dominio representa los conceptos abstractos del negocio, sus atributos de negocio y sus asociaciones con multiplicidades. No incluye metodos, tipos de datos tecnicos ni claves foraneas.

- **Fuente editable:** [modelo-dominio.drawio](./modelo-dominio.drawio)
- **Imagen:** [modelo-dominio.svg](./modelo-dominio.svg)

---

## 1. Clases conceptuales (11 clases)

| Clase conceptual | Atributos de negocio |
|---|---|
| **Usuario** | nombre, estadoCuenta |
| **Rol** | nombreRol, descripcionPermisos |
| **Mesero** *(especializa a Usuario)* | codigoTurno, zonaAsignada |
| **Mesa** | numeroMesa, capacidad, estadoDisponibilidad |
| **Pedido** | numeroOrden, fechaHora, estadoPedido |
| **DetallePedido** *(clase de asociacion)* | cantidad, observaciones |
| **Producto** | nombre, descripcion, precioUnitario, disponible |
| **Categoria** | nombreCategoria, descripcion |
| **Insumo** | nombreInsumo, cantidadExistente, stockMinimo |
| **Factura** | numeroFactura, fechaEmision, subtotal, impuesto, total |
| **Pago** | metodoPago, montoRecibido, fechaPago |

---

## 2. Generalizacion y clase de asociacion

- **Generalizacion:** `Mesero` es una especializacion conceptual de `Usuario` que incorpora informacion operativa propia del servicio en salon (`codigoTurno`, `zonaAsignada`).
- **Clase de asociacion:** `DetallePedido` vincula a `Pedido` y `Producto`, almacenando la `cantidad` solicitada y las `observaciones` del comensal para cada item del pedido.
