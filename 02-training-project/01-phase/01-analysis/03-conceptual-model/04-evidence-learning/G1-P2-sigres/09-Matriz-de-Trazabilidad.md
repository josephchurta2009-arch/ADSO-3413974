# Matriz de Trazabilidad Requisito -> Artefactos — SIGRES (Anexo C)

Cobertura alcanzada: **17 / 17 Requisitos Funcionales (100 %)** trazados hasta clase de dominio, entidad del MER y pantalla del prototipo para los casos criticos.

| Requisito | Caso de uso | Diagrama de actividades | Plantilla | Clase de dominio | Entidad del MER | Pantalla |
|---|---|---|---|---|---|---|
| RF01 Registro de Usuarios | CU-01 Gestionar usuarios y roles | — | — | Usuario, Rol | USUARIO, ROL | Panel Admin (Web) |
| RF02 Inicio de Sesion | CU-02 Iniciar sesion | — | — | Usuario | USUARIO | Login (Web / Movil) |
| RF03 Gestion de Roles y Permisos | CU-01 Gestionar usuarios y roles | — | — | Rol, Usuario | ROL, USUARIO | Panel Admin (Web) |
| RF04 Registrar Pedido | CU-03 Registrar pedido | Diagrama 1 (CU-03) | Plantilla CU-03 | Pedido, DetallePedido, Mesa | PEDIDO, DETALLE_PEDIDO, MESA | Pantalla 1 (CU-03) |
| RF05 Enviar Pedido a Cocina | CU-04 Enviar comanda a cocina | Diagrama 1 (CU-03) | Plantilla CU-03 | Pedido | PEDIDO | Pantalla 1 (CU-03) |
| RF06 Consultar Estado del Pedido | CU-05 Consultar estado de pedido | — | — | Pedido | PEDIDO | Monitor Pedidos |
| RF07 Actualizar Estado del Pedido | CU-06 Actualizar estado de pedido | — | — | Pedido | PEDIDO | Pantalla Cocina |
| RF08 Administrar Productos del Menu | CU-07 Gestionar menu y categorias | — | — | Producto | PRODUCTO | Gestion Menu (Web) |
| RF09 Gestionar Disponibilidad | CU-07 Gestionar menu y categorias | Diagrama 1 (CU-03) | Plantilla CU-03 | Producto | PRODUCTO | Gestion Menu (Web) |
| RF10 Gestionar Categorias del Menu | CU-07 Gestionar menu y categorias | — | — | Categoria, Producto | CATEGORIA, PRODUCTO | Gestion Menu (Web) |
| RF11 Control de Inventario | CU-08 Controlar inventario de insumos | — | — | Insumo, Producto | PRODUCTO | Panel Inventario (Web) |
| RF12 Generar Factura | CU-09 Generar factura | Diagrama 2 (CU-09) | Plantilla CU-09 | Factura, Pedido | FACTURA, PEDIDO | Pantalla 2 (CU-09) |
| RF13 Registrar Pago | CU-10 Procesar pago | Diagrama 2 (CU-09) | Plantilla CU-09 | Pago, Factura | PAGO, FACTURA | Pantalla 2 (CU-09) |
| RF14 Cierre de Caja | CU-11 Realizar cierre de caja | — | — | Factura, Pago | FACTURA, PAGO | Cierre Caja (Web) |
| RF15 Generar Reportes de Ventas | CU-12 Generar reportes de ventas | — | — | Factura, Pedido | FACTURA, PEDIDO | Reportes (Web) |
| RF16 Ver Menu Digital QR | CU-13 Consultar menu digital QR | — | Plantilla CU-13 | Producto, Categoria, Mesa | PRODUCTO, CATEGORIA, MESA | Pantalla 3 (CU-13) |
| RF17 Consultar Consumo Actual QR | CU-14 Consultar consumo actual QR | — | Plantilla CU-13 | Pedido, DetallePedido, Mesa | PEDIDO, DETALLE_PEDIDO, MESA | Pantalla 3 (CU-13) |
