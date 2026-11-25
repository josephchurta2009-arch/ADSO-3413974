# Justificacion del Diagrama de Casos de Uso UML — SIGRES

**Diagrama fuente editable:** [diagrama-casos-de-uso.drawio](./diagrama-casos-de-uso.drawio)
**Imagen del diagrama:** [diagrama-casos-de-uso.svg](./diagrama-casos-de-uso.svg)

---

## 1. Decisiones de modelado y agrupacion (criterio CRUD)

Siguiendo la regla de arbitraje de la rubrica (un caso de uso representa un objetivo del actor y no operaciones tecnicas aisladas), las operaciones CRUD del SRS se agruparon en casos de uso cohesivos:
- **CU-01 Gestionar usuarios y roles** agrupa RF01 (registro) y RF03 (permisos), ya que ambos responden al objetivo administrativo de controlar cuentas de acceso.
- **CU-07 Gestionar menu y categorias** agrupa RF08, RF09 y RF10 (crear/editar productos, cambiar disponibilidad y gestionar categorias).
- **CU-08 Controlar inventario de insumos** y **CU-15 Gestionar mesas** agrupan sus respectivas operaciones de mantenimiento sin fragmentar en Crear/Leer/Actualizar/Eliminar.

---

## 2. Justificacion de actores y generalizacion

- **Generalizacion de actores (`Usuario Autenticado`):** `Administrador`, `Mesero`, `Cajero` y `Gerente` heredan de `Usuario Autenticado` porque todos requieren autenticarse mediante `CU-02 Iniciar sesion` antes de operar sus modulos; el `Cliente` queda fuera de esta generalizacion porque accede al menu QR sin autenticacion.
- **Actor secundario (`Sistema de Cocina / Pantalla Comandas`):** Se ubica a la derecha fuera de la frontera porque recibe las comandas enviadas y actualiza su estado de preparacion.

---

## 3. Justificacion de relaciones `<<include>>` y `<<extend>>`

| Relacion | Tipo | Direccion de la flecha | Justificacion (1 linea) |
|---|---|---|---|
| `CU-03 Registrar pedido` -> `CU-04 Enviar comanda a cocina` | `<<include>>` | Del caso base (`CU-03`) al incluido (`CU-04`) | Todo pedido confirmado por el mesero debe enviarse obligatoriamente a la cocina para su preparacion. |
| `CU-09 Generar factura` -> `CU-05 Consultar estado de pedido` | `<<include>>` | Del caso base (`CU-09`) al incluido (`CU-05`) | Para emitir una factura, el sistema siempre verifica el estado y detalle de los pedidos de la mesa. |
| `CU-10 Procesar pago` -> `CU-09 Generar factura` | `<<extend>>` | Del caso que extiende (`CU-10`) al caso base (`CU-09`) | El procesamiento inmediato del pago es condicional/opcional al momento de generar la cuenta (puede entregarse la pre-cuenta primero). |
| `CU-14 Consultar consumo actual QR` -> `CU-13 Consultar menu digital QR` | `<<extend>>` | Del caso que extiende (`CU-14`) al caso base (`CU-13`) | Al escanear el QR para ver el menu, el cliente puede opcionalmente consultar su consumo si la mesa tiene un pedido activo. |
