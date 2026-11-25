# Arquitectura del Sistema — SIGRES

**Proyecto:** Sistema Integral de Gestion para Restaurantes
**Version:** 1.0 | **Fecha:** Noviembre 2026

---

## 1. Vision general

SIGRES adopta una arquitectura cliente-servidor de tres capas (presentacion, logica de negocio y datos), expuesta mediante una API REST sobre HTTPS. Esta arquitectura permite la comunicacion en tiempo real entre la aplicacion movil, la plataforma web y el menu digital QR.

---

## 2. Diagrama de arquitectura general

```
+---------------------------------------------------------------------+
|                        CAPA DE PRESENTACION                         |
|                                                                     |
|  [ App Movil (Meseros) ]  [ Plataforma Web ]  [ Menu QR (Cliente)] |
|   React Native / Flutter   React / Vue.js      Web Responsive       |
+---------------------+-------------------+---------------------------+
                      |                   |
                      +-------------------+
                                |
                           HTTPS / REST
                                |
+-------------------------------+-------------------------------------+
|                      CAPA DE LOGICA DE NEGOCIO                      |
|                                                                     |
|                           API REST                                  |
|                   Node.js + Express / Django                        |
|                                                                     |
|  [ Auth ] [ Pedidos ] [ Inventario ] [ Facturacion ] [ Reportes ]   |
|  [ Mesas ] [ Menu ] [ QR Service ]                                  |
+-------------------------------+-------------------------------------+
                                |
+-------------------------------+-------------------------------------+
|                         CAPA DE DATOS                               |
|                                                                     |
|              Base de Datos Relacional (MySQL / PostgreSQL)          |
|                                                                     |
|  Tablas: usuarios, roles, pedidos, productos, categorias,           |
|          inventario, mesas, facturas, pagos, codigos_qr             |
+---------------------------------------------------------------------+
```

---

## 3. Diagrama de componentes

```
SIGRES
|
+-- frontend-web/
|   +-- auth/           Login y gestion de sesion
|   +-- dashboard/      Panel principal con indicadores
|   +-- pedidos/        Seguimiento de comandas
|   +-- menu/           CRUD de productos y categorias
|   +-- inventario/     Control de insumos
|   +-- mesas/          Estado de mesas en tiempo real
|   +-- facturacion/    Facturas y pagos
|   +-- reportes/       Visualizacion de estadisticas
|
+-- mobile-app/
|   +-- auth/           Inicio de sesion del mesero
|   +-- mesas/          Seleccion y estado de mesas
|   +-- pedidos/        Nueva comanda y seguimiento
|   +-- menu/           Consulta del menu (solo lectura)
|
+-- qr-web/
|   +-- menu/           Menu digital por categorias
|   +-- consumo/        Resumen de consumo de la mesa
|
+-- backend/
    +-- auth/           JWT, control de sesion y roles
    +-- usuarios/       CRUD de usuarios
    +-- pedidos/        Logica de pedidos y comandas
    +-- productos/      CRUD de menu e inventario
    +-- mesas/          Estado de mesas
    +-- facturacion/    Facturacion y pagos
    +-- reportes/       Generacion de reportes
    +-- qr/             Generacion y validacion de codigos QR
```

---

## 4. Flujo del ciclo completo de un pedido

```
MESERO              SISTEMA             COCINA              CAJERO
  |                    |                   |                   |
  | Selecciona mesa     |                   |                   |
  |------------------->|                   |                   |
  |                    | Verifica mesa     |                   |
  | Selecciona         |                   |                   |
  | productos          |                   |                   |
  |------------------->|                   |                   |
  |                    | Registra comanda  |                   |
  |                    | con ID unico      |                   |
  |                    |------------------>|                   |
  |                    | Notifica cocina   |                   |
  |                    | (< 5 segundos)    |                   |
  |                    |                   | Prepara pedido    |
  |                    | Cocina actualiza  |                   |
  |                    | estado            |                   |
  |<-------------------| "En preparacion"  |                   |
  |                    |                   | Pedido listo      |
  |<-------------------| Notifica mesero   |                   |
  |                    | "Listo"           |                   |
  | Entrega al         |                   |                   |
  | cliente            |                   |                   |
  |                    |                   | Cliente solicita  |
  |                    |                   | la cuenta         |
  |                    |<---------------------------------------------|
  |                    | Genera factura    |                   |
  |                    |---------------------------------------------->|
  |                    |                   |            Procesa pago   |
  |                    | Mesa cambia a     |                   |
  |                    | "Disponible"      |                   |
```

---

## 5. Modelo de datos — Entidades principales

| Entidad | Atributos clave | Relaciones |
|---|---|---|
| Usuario | id, nombre, email, password_hash, rol_id | Rol, Pedido |
| Rol | id, nombre, permisos | Usuario |
| Mesa | id, numero, estado, qr_code | Pedido |
| Pedido | id, mesa_id, mesero_id, estado, fecha_hora | Mesa, Usuario, DetallePedido |
| DetallePedido | id, pedido_id, producto_id, cantidad, notas | Pedido, Producto |
| Producto | id, nombre, precio, categoria_id, disponible | Categoria |
| Categoria | id, nombre, descripcion | Producto |
| Inventario | id, insumo_id, cantidad, stock_minimo | Insumo |
| Factura | id, pedido_id, total, impuesto, fecha_hora | Pedido, Pago |
| Pago | id, factura_id, metodo, monto, fecha_hora | Factura |

---

## 6. Requisitos no funcionales clave

| RNF | Descripcion | Metrica de verificacion |
|---|---|---|
| Rendimiento | Las comandas deben llegar a cocina en tiempo real | Maximo 5 segundos desde el registro |
| Seguridad | Comunicacion cifrada y autenticacion por token | HTTPS + JWT en todos los endpoints |
| Usabilidad | Interfaz usable por personal con conocimientos basicos | Capacitacion inferior a 30 minutos |
| Disponibilidad | Sistema operativo durante el horario del restaurante | 99% de uptime en produccion |
| Escalabilidad | Soporte para multiples mesas y usuarios simultaneos | Arquitectura modular y sin estado en backend |
| Compatibilidad | Compatible con Chrome, Firefox, Edge y dispositivos moviles | Diseno responsivo con CSS estandar |