# 📊 Diagrama de Casos de Uso — SIGRES

**Proyecto:** Sistema Integral de Gestión para Restaurantes  
**Versión:** 1.0 | **Fecha:** Noviembre 2026  
**Basado en:** SRS-SIGRES v1.0 (sección "Requisitos de Caso de Uso")

---

## 🎭 Actores del sistema

| Actor | Tipo | Descripción |
|---|---|---|
| **Administrador** | Principal | Gestión total del sistema. Accede por web. |
| **Mesero** | Principal | Registra pedidos y gestiona mesas. Accede por app móvil. |
| **Cajero** | Principal | Procesa pagos y genera facturas. Accede por web. |
| **Gerente** | Principal | Consulta reportes e indicadores. Accede por web. |
| **Cliente** | Principal | Consulta menú digital y consumo via QR. Sin login. |
| **Sistema SIGRES** | Secundario | Actor interno que ejecuta lógica de negocio automática. |

---

## 📋 Diagrama UML de Casos de Uso (representación textual)

```
┌──────────────────────────────────────────────────────────────────────────┐
│                        Sistema SIGRES                                     │
│                                                                           │
│  ┌─────────────────────────────────────────────────────────────────────┐ │
│  │ MÓDULO 1 — Autenticación y Usuarios                                 │ │
│  │   ○ CU-01: Registrar usuario                                        │ │
│  │   ○ CU-02: Iniciar sesión                                           │ │
│  │   ○ CU-03: Gestionar roles y permisos                               │ │
│  └─────────────────────────────────────────────────────────────────────┘ │
│                                                                           │
│  ┌─────────────────────────────────────────────────────────────────────┐ │
│  │ MÓDULO 2 — Gestión de Pedidos                                       │ │
│  │   ○ CU-04: Registrar pedido (comanda)                               │ │
│  │   ○ CU-05: Enviar pedido a cocina                                   │ │
│  │   ○ CU-06: Consultar estado del pedido                              │ │
│  │   ○ CU-07: Actualizar estado del pedido                             │ │
│  └─────────────────────────────────────────────────────────────────────┘ │
│                                                                           │
│  ┌─────────────────────────────────────────────────────────────────────┐ │
│  │ MÓDULO 3 — Menú, Inventario y Mesas                                 │ │
│  │   ○ CU-08: Administrar productos del menú (CRUD)                    │ │
│  │   ○ CU-09: Gestionar categorías del menú                            │ │
│  │   ○ CU-10: Controlar inventario de insumos                          │ │
│  │   ○ CU-11: Gestionar mesas                                          │ │
│  └─────────────────────────────────────────────────────────────────────┘ │
│                                                                           │
│  ┌─────────────────────────────────────────────────────────────────────┐ │
│  │ MÓDULO 4 — Facturación y Caja                                       │ │
│  │   ○ CU-12: Generar factura                                          │ │
│  │   ○ CU-13: Procesar pago                                            │ │
│  │   ○ CU-14: Realizar cierre de caja                                  │ │
│  └─────────────────────────────────────────────────────────────────────┘ │
│                                                                           │
│  ┌─────────────────────────────────────────────────────────────────────┐ │
│  │ MÓDULO 5 — Reportes y Menú Digital QR                               │ │
│  │   ○ CU-15: Generar reportes de ventas                               │ │
│  │   ○ CU-16: Ver menú digital (QR)                                    │ │
│  │   ○ CU-17: Consultar consumo actual (QR)                            │ │
│  └─────────────────────────────────────────────────────────────────────┘ │
│                                                                           │
└──────────────────────────────────────────────────────────────────────────┘

Actores y sus casos de uso:

[Administrador] ──── CU-01, CU-02, CU-03, CU-08, CU-09, CU-10, CU-11,
                      CU-12, CU-13, CU-14, CU-15

[Mesero]        ──── CU-02, CU-04, CU-05, CU-06, CU-11

[Cajero]        ──── CU-02, CU-12, CU-13, CU-14

[Gerente]       ──── CU-02, CU-15

[Cliente]       ──── CU-16, CU-17  (sin autenticación)

[Sistema SIGRES] ─── CU-05 (envío automático a cocina)
                      CU-07 (actualización automática de estados)
                      CU-10 (alertas automáticas de stock)
```

---

## 📝 Caracterización de Casos de Uso

### Grupo 1 — Autenticación y Gestión de Usuarios

---

#### CU-01: Registrar Usuario

| Campo | Detalle |
|---|---|
| **Identificador** | CU-01 |
| **Nombre** | Registrar Usuario |
| **Actor principal** | Administrador |
| **RF asociado** | RF01 |
| **Prioridad** | Alta |
| **Precondiciones** | El Administrador debe estar autenticado en el sistema. |
| **Postcondiciones** | El usuario queda registrado con el rol asignado y puede iniciar sesión. |

**Flujo principal:**
1. El Administrador accede al módulo de gestión de usuarios.
2. Selecciona "Registrar nuevo usuario".
3. Ingresa nombre, correo, contraseña y rol.
4. El sistema valida los datos e impide correos duplicados.
5. Se crea el usuario y se confirma el registro.

**Flujos alternativos:**
- FA-1: El correo ya existe → el sistema muestra advertencia y no crea el usuario.

**Manejo de errores:**
- ME-1: Campos incompletos → "Complete todos los campos requeridos."
- ME-2: Correo inválido → "Ingrese un correo electrónico válido."

---

#### CU-02: Iniciar Sesión

| Campo | Detalle |
|---|---|
| **Identificador** | CU-02 |
| **Nombre** | Iniciar Sesión |
| **Actor principal** | Administrador / Mesero / Cajero / Gerente |
| **RF asociado** | RF02 |
| **Prioridad** | Alta |
| **Precondiciones** | El usuario debe estar registrado en el sistema con credenciales activas. |
| **Postcondiciones** | El usuario accede al panel correspondiente a su rol. |

**Flujo principal:**
1. El usuario ingresa correo y contraseña.
2. El sistema valida las credenciales.
3. Se genera un token de sesión (JWT).
4. El sistema redirige al panel según el rol.

**Manejo de errores:**
- ME-1: Credenciales incorrectas → "Correo o contraseña inválidos."
- ME-2: Cuenta inactiva → "Su cuenta está desactivada."

---

### Grupo 2 — Gestión de Pedidos

---

#### CU-04: Registrar Pedido (Comanda)

| Campo | Detalle |
|---|---|
| **Identificador** | CU-04 |
| **Nombre** | Registrar Pedido (Comanda) |
| **Actor principal** | Mesero |
| **RF asociado** | RF04 |
| **Prioridad** | Alta |
| **Precondiciones** | El mesero debe estar autenticado. La mesa debe existir. Los productos deben estar disponibles. |
| **Postcondiciones** | El pedido queda registrado, la comanda llega a cocina y la mesa cambia a "Ocupada". |

**Flujo principal:**
1. El mesero selecciona la mesa desde la app móvil.
2. Selecciona los productos con cantidades y observaciones.
3. Confirma el pedido.
4. El sistema registra la comanda con ID único y la envía a cocina.
5. La mesa se marca como "Ocupada".

**Flujos alternativos:**
- FA-1: Producto no disponible → el sistema lo marca y no lo agrega al pedido.

**Manejo de errores:**
- ME-1: Sin conexión → "No fue posible registrar el pedido. Verifique su conexión."

---

### Grupo 3 — Inventario y Facturación

---

#### CU-12: Generar Factura

| Campo | Detalle |
|---|---|
| **Identificador** | CU-12 |
| **Nombre** | Generar Factura |
| **Actor principal** | Cajero / Administrador |
| **RF asociado** | RF12 |
| **Prioridad** | Alta |
| **Precondiciones** | Debe existir un pedido entregado asociado a la mesa. |
| **Postcondiciones** | Se genera la factura con el detalle de consumo y el total a pagar. |

**Flujo principal:**
1. El cajero selecciona la mesa o el pedido.
2. El sistema calcula el total con impuestos aplicables.
3. Se genera la factura con los datos del pedido y el total.
4. El cajero entrega la factura al cliente (impresa o digital).

**Manejo de errores:**
- ME-1: Sin pedido activo → "No hay consumo registrado para esta mesa."

---

### Grupo 4 — Reportes y Menú Digital QR

---

#### CU-16: Ver Menú Digital (QR)

| Campo | Detalle |
|---|---|
| **Identificador** | CU-16 |
| **Nombre** | Ver Menú Digital (QR) |
| **Actor principal** | Cliente |
| **RF asociado** | RF16 |
| **Prioridad** | Alta |
| **Precondiciones** | El QR de la mesa debe estar activo. El menú debe tener productos disponibles. El cliente tiene cámara e internet. |
| **Postcondiciones** | El cliente visualiza el menú completo en su dispositivo. No se realizan cambios en el sistema. |

**Flujo principal:**
1. El cliente escanea el QR de su mesa.
2. El sistema valida el QR e identifica la mesa.
3. Se muestra la interfaz web con el menú organizado por categorías.
4. El cliente navega por los productos (imágenes, precios, disponibilidad).
5. Opcionalmente, el cliente selecciona "Ver mi consumo".

**Reglas de negocio:**
- RN-01: El cliente NO puede realizar pedidos desde el QR.
- RN-02: Los productos agotados se marcan como "No disponible".
- RN-03: No requiere autenticación ni registro.

**Manejo de errores:**
- ME-1: QR inválido → "El código QR no es válido. Solicite al mesero asistencia."
- ME-2: Sin productos → "No hay productos disponibles en este momento."

---

## 🔗 Relaciones entre casos de uso

| CU | Incluye (<<include>>) | Extiende (<<extend>>) |
|---|---|---|
| CU-04 Registrar pedido | CU-05 Enviar a cocina | — |
| CU-04 Registrar pedido | — | CU-06 Consultar estado |
| CU-12 Generar factura | — | CU-13 Procesar pago |
| CU-16 Ver menú QR | — | CU-17 Consultar consumo |
| CU-02 Iniciar sesión | — | CU-03 Gestionar roles |
