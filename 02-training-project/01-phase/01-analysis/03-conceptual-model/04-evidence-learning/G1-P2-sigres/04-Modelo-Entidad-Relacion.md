# Modelo Entidad-Relacion (MER) — SIGRES

- **Notacion declarada:** Pata de Gallo (Crow's Foot).
- **Fuente editable:** [modelo-er.drawio](./modelo-er.drawio)
- **Imagen:** [modelo-er.svg](./modelo-er.svg)

---

## 1. Entidades (9 entidades)

| Entidad | Identificador (PK) | Claves foraneas (FK) | Atributos clave |
|---|---|---|---|
| **ROL** | `id_rol` | — | `nombre`, `permisos` |
| **USUARIO** | `id_usuario` | `id_rol` | `nombre`, `correo`, `password_hash`, `activo` |
| **MESA** | `id_mesa` | — | `numero`, `capacidad`, `estado`, `codigo_qr` |
| **PEDIDO** | `id_pedido` | `id_mesa`, `id_mesero` | `fecha_hora`, `estado` |
| **DETALLE_PEDIDO** *(asociativa)* | `id_detalle` | `id_pedido`, `id_producto` | `cantidad`, `precio_unitario`, `observaciones` |
| **PRODUCTO** | `id_producto` | `id_categoria` | `nombre`, `precio`, `disponible` |
| **CATEGORIA** | `id_categoria` | — | `nombre`, `descripcion` |
| **FACTURA** | `id_factura` | `id_pedido`, `id_cajero` | `fecha_emision`, `subtotal`, `impuesto`, `total` |
| **PAGO** *(entidad debil)* | `id_pago` | `id_factura` | `metodo_pago`, `monto`, `fecha_pago` |

---

## 2. Resolucion de cardinalidades especiales

- **Relacion N:M resuelta:** La relacion muchos a muchos entre `PEDIDO` y `PRODUCTO` se resuelve mediante la entidad asociativa **`DETALLE_PEDIDO`**, la cual incorpora atributos propios de la transaccion (`cantidad`, `precio_unitario` historico al momento de la venta y `observaciones`).
- **Entidad debil:** **`PAGO`** es una entidad debil dependiente de **`FACTURA`**, ya que un pago no puede existir en el sistema sin una factura emitida asociada (participacion total de `PAGO` hacia `FACTURA`).
