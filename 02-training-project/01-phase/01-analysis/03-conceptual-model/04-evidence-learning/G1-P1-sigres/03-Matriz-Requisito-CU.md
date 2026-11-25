# Matriz Requisito Funcional a Caso de Uso — SIGRES

**Documento base:** SRS - SIGRES (17 Requisitos Funcionales y 12 Requisitos No Funcionales)
**Cobertura alcanzada:** 17 / 17 Requisitos Funcionales (**100 %**)

---

## 1. Distincion entre Requisitos Funcionales (RF) y No Funcionales (RNF)

Para evitar mezclar comportamientos del sistema con restricciones de calidad en el diagrama de casos de uso, se separa explicitamente:

- **Requisitos Funcionales (RF01 a RF17):** Describen las funciones y servicios concretos que el sistema SIGRES debe ejecutar para los actores (ej. registrar pedido, generar factura, consultar menu QR). **Todos los RF se modelan mediante Casos de Uso.**
- **Requisitos No Funcionales (RNF):** Describen atributos de calidad y restricciones tecnicas u operativas (seguridad con HTTPS/JWT, rendimiento menor a 5 segundos en cocina, usabilidad responsiva, disponibilidad 99 %, compatibilidad con navegadores). **Los RNF no se modelan como casos de uso**, sino que restringen la ejecucion de los casos de uso y se verifican en la matriz de calidad y en el informe de analisis.

---

## 2. Matriz de cobertura RF -> Caso de Uso

| ID | Requisito Funcional (SRS) | Modulo SRS | Caso de Uso asociado | Actor(es) | Estado |
|---|---|---|---|---|---|
| RF01 | Registro de Usuarios | M1 Autenticacion | CU-01 Gestionar usuarios y roles | Administrador | Cubierto |
| RF02 | Inicio de Sesion | M1 Autenticacion | CU-02 Iniciar sesion | Usuario Autenticado (Admin, Mesero, Cajero, Gerente) | Cubierto |
| RF03 | Gestion de Roles y Permisos | M1 Autenticacion | CU-01 Gestionar usuarios y roles | Administrador | Cubierto |
| RF04 | Registrar Pedido (Comanda) | M2 Pedidos | CU-03 Registrar pedido | Mesero | Cubierto |
| RF05 | Enviar Pedido a Cocina | M2 Pedidos | CU-04 Enviar comanda a cocina | Mesero / Sistema de Cocina | Cubierto |
| RF06 | Consultar Estado del Pedido | M2 Pedidos | CU-05 Consultar estado de pedido | Mesero, Cajero | Cubierto |
| RF07 | Actualizar Estado del Pedido | M2 Pedidos | CU-06 Actualizar estado de pedido | Sistema de Cocina | Cubierto |
| RF08 | Administrar Productos del Menu | M3 Menu y Productos | CU-07 Gestionar menu y categorias | Administrador | Cubierto |
| RF09 | Gestionar Disponibilidad de Productos | M3 Menu y Productos | CU-07 Gestionar menu y categorias | Administrador | Cubierto |
| RF10 | Gestionar Categorias del Menu | M3 Menu y Productos | CU-07 Gestionar menu y categorias | Administrador | Cubierto |
| RF11 | Control de Inventario | M4 Inventario | CU-08 Controlar inventario de insumos | Administrador | Cubierto |
| RF12 | Generar Factura | M5 Facturacion y Caja | CU-09 Generar factura | Cajero, Administrador | Cubierto |
| RF13 | Registrar Pago | M5 Facturacion y Caja | CU-10 Procesar pago | Cajero | Cubierto |
| RF14 | Cierre de Caja | M5 Facturacion y Caja | CU-11 Realizar cierre de caja | Cajero, Administrador | Cubierto |
| RF15 | Generar Reportes de Ventas | M7 Reportes | CU-12 Generar reportes de ventas | Gerente, Administrador | Cubierto |
| RF16 | Ver Menu Digital (QR) | M8 Menu Digital QR | CU-13 Consultar menu digital QR | Cliente | Cubierto |
| RF17 | Consultar Consumo Actual (QR) | M8 Menu Digital QR | CU-14 Consultar consumo actual QR | Cliente | Cubierto |

*Nota sobre Gestion de Mesas (Modulo 6 del SRS):* Aunque en el documento SRS las fichas numeradas llegan a RF17 y el Modulo 6 describe el CRUD de mesas sin codigo RF numerado adicional, esta funcionalidad queda igualmente cubierta en el diagrama mediante **CU-15 Gestionar mesas** (Administrador / Mesero).

---

## 3. Requisitos No Funcionales identificados (fuera de casos de uso)

| Categoria | Ejemplos del SRS | Casos de uso que restringe |
|---|---|---|
| Seguridad | Cifrado HTTPS, contrasenas encriptadas, control de acceso basado en roles (JWT) | CU-01, CU-02, CU-09 a CU-12 |
| Rendimiento | Envio de comandas a cocina en maximo 5 segundos; carga fluida del menu QR | CU-03, CU-04, CU-06, CU-13 |
| Usabilidad | Interfaz responsiva, mensajes de error claros, validacion de formularios | Todos (CU-01 a CU-15) |
| Disponibilidad y Fiabilidad | Operacion continua en horario del restaurante, integridad transaccional (ACID) | CU-03, CU-09, CU-10, CU-11 |
| Compatibilidad | Navegadores modernos (Chrome, Firefox, Edge) y dispositivos moviles con camara QR | CU-02, CU-03, CU-13, CU-14 |
