# 🔗 Matriz de Trazabilidad — Requisitos ↔ Casos de Uso

**Proyecto:** Sistema Integral de Gestión para Restaurantes (SIGRES)  
**Versión:** 1.0 | **Fecha:** Noviembre 2026  
**Documento base:** SRS-SIGRES v1.0

---

## 1. Matriz RF ↔ Casos de Uso

| RF | Nombre del Requisito | CU asociado | Actor | Prioridad | Criterio de aceptación verificado |
|---|---|---|---|---|---|
| RF01 | Registro de Usuarios | CU-01 | Administrador | Alta | ✅ Validación de correo único, campos obligatorios |
| RF02 | Inicio de Sesión | CU-02 | Todos los roles | Alta | ✅ Token JWT, panel según rol, registro de acceso |
| RF03 | Gestión de Roles y Permisos | CU-03 | Administrador | Alta | ✅ Cambios inmediatos, no elimina último admin |
| RF04 | Registrar Pedido (Comanda) | CU-04 | Mesero | Alta | ✅ ID único, envío automático a cocina, mesa "Ocupada" |
| RF05 | Enviar Pedido a Cocina | CU-05 | Sistema SIGRES | Alta | ✅ Llega en < 5 seg, diferenciado por mesa y hora |
| RF06 | Consultar Estado del Pedido | CU-06 | Mesero / Cajero | Alta | ✅ Estados claros: Pendiente / En preparación / Listo / Entregado |
| RF07 | Actualizar Estado del Pedido | CU-07 | Cocina / Sistema | Alta | ✅ Notificación en tiempo real al mesero |
| RF08 | Administrar Productos del Menú | CU-08 | Administrador | Alta | ✅ CRUD completo, validación de campos |
| RF09 | Gestionar Disponibilidad de Productos | CU-08 | Administrador | Alta | ✅ Productos inactivos no aparecen en la app |
| RF10 | Gestionar Categorías del Menú | CU-09 | Administrador | Media | ✅ CRUD de categorías, asociación con productos |
| RF11 | Control de Inventario | CU-10 | Administrador | Alta | ✅ Alertas de stock mínimo, registro de movimientos |
| RF12 | Generar Factura | CU-12 | Cajero / Admin | Alta | ✅ Total correcto, desglose de productos, impuestos |
| RF13 | Registrar Pago | CU-13 | Cajero | Alta | ✅ Múltiples métodos, confirmación del pago |
| RF14 | Cierre de Caja | CU-14 | Cajero / Admin | Alta | ✅ Resumen diario, totales por método de pago |
| RF15 | Generar Reportes de Ventas | CU-15 | Gerente / Admin | Alta | ✅ Filtros por fecha/producto/mesero, totales correctos |
| RF16 | Ver Menú Digital (QR) | CU-16 | Cliente | Alta | ✅ Sin login, responsive, productos actualizados en tiempo real |
| RF17 | Consultar Consumo Actual (QR) | CU-17 | Cliente | Media | ✅ Lista de productos pedidos, subtotal, estado de pedido |

---

## 2. Matriz RNF ↔ Mecanismo de verificación

| RNF | Categoría | Descripción | Cómo se verifica |
|---|---|---|---|
| RNF-01 | Seguridad | Comunicación cifrada (HTTPS) | Configuración del servidor con certificado SSL |
| RNF-02 | Seguridad | Contraseñas encriptadas (bcrypt) | Revisión de código: función hash en módulo de auth |
| RNF-03 | Seguridad | Autenticación por JWT | Token generado en login, validado en cada endpoint |
| RNF-04 | Seguridad | Control de acceso por rol | Prueba: usuario sin permiso intenta acceder → error 403 |
| RNF-05 | Rendimiento | Comandas llegan a cocina en < 5 seg | Prueba de tiempo: cronometrar envío → recepción |
| RNF-06 | Usabilidad | Interfaz responsiva | Prueba en Chrome / Firefox / Edge / móvil |
| RNF-07 | Usabilidad | Mensajes de error comprensibles | Revisión de todos los mensajes de error en el sistema |
| RNF-08 | Disponibilidad | 99% uptime en horario del restaurante | Monitorización del servidor (logs de disponibilidad) |
| RNF-09 | Escalabilidad | Soporte para múltiples usuarios simultáneos | Prueba de carga básica con múltiples sesiones |
| RNF-10 | Mantenibilidad | Código modular y documentado | Revisión de estructura de carpetas y comentarios |
| RNF-11 | Compatibilidad | Compatible con Chrome, Firefox, Edge | Prueba en los tres navegadores con las mismas funciones |
| RNF-12 | Compatibilidad | QR accesible desde cualquier móvil moderno | Prueba en Android e iOS |

---

## 3. Cobertura de requisitos

### RF cubiertos por casos de uso: **17/17 (100%)**

```
RF01 ──► CU-01 ✅
RF02 ──► CU-02 ✅
RF03 ──► CU-03 ✅
RF04 ──► CU-04 ✅
RF05 ──► CU-05 ✅
RF06 ──► CU-06 ✅
RF07 ──► CU-07 ✅
RF08 ──► CU-08 ✅
RF09 ──► CU-08 ✅ (mismo CU, diferente flujo)
RF10 ──► CU-09 ✅
RF11 ──► CU-10 ✅
RF12 ──► CU-12 ✅
RF13 ──► CU-13 ✅
RF14 ──► CU-14 ✅
RF15 ──► CU-15 ✅
RF16 ──► CU-16 ✅
RF17 ──► CU-17 ✅
```

### RNF con mecanismo de verificación definido: **12/12 (100%)**

---

## 4. Resumen de actores y CU por actor

| Actor | Cantidad de CU | Casos de uso |
|---|---|---|
| Administrador | 11 | CU-01, CU-02, CU-03, CU-08, CU-09, CU-10, CU-11, CU-12, CU-13, CU-14, CU-15 |
| Mesero | 5 | CU-02, CU-04, CU-05, CU-06, CU-11 |
| Cajero | 4 | CU-02, CU-12, CU-13, CU-14 |
| Gerente | 2 | CU-02, CU-15 |
| Cliente | 2 | CU-16, CU-17 |
| Sistema SIGRES | 3 | CU-05, CU-07, CU-10 (automatizados) |

**Total de casos de uso:** 17  
**Total de actores:** 6
