# Matriz de Trazabilidad — Requisitos y Casos de Uso

**Proyecto:** Sistema Integral de Gestion para Restaurantes (SIGRES)
**Version:** 1.0 | **Fecha:** Noviembre 2026
**Documento base:** SRS-SIGRES v1.0

---

## 1. Matriz RF — Casos de Uso

| RF | Nombre del Requisito | CU asociado | Actor | Prioridad | Criterio de aceptacion verificado |
|---|---|---|---|---|---|
| RF01 | Registro de Usuarios | CU-01 | Administrador | Alta | Validacion de correo unico, campos obligatorios |
| RF02 | Inicio de Sesion | CU-02 | Todos los roles | Alta | Token JWT generado, panel segun rol, registro de acceso |
| RF03 | Gestion de Roles y Permisos | CU-03 | Administrador | Alta | Cambios inmediatos, no permite eliminar el unico administrador |
| RF04 | Registrar Pedido | CU-04 | Mesero | Alta | ID unico generado, envio automatico a cocina, mesa en "Ocupada" |
| RF05 | Enviar Pedido a Cocina | CU-05 | Sistema SIGRES | Alta | Llega en menos de 5 segundos, diferenciado por mesa y hora |
| RF06 | Consultar Estado del Pedido | CU-06 | Mesero / Cajero | Alta | Estados claros: Pendiente / En preparacion / Listo / Entregado |
| RF07 | Actualizar Estado del Pedido | CU-07 | Cocina / Sistema | Alta | Notificacion en tiempo real al mesero |
| RF08 | Administrar Productos del Menu | CU-08 | Administrador | Alta | CRUD completo, validacion de campos requeridos |
| RF09 | Gestionar Disponibilidad de Productos | CU-08 | Administrador | Alta | Productos inactivos no aparecen en la aplicacion |
| RF10 | Gestionar Categorias del Menu | CU-09 | Administrador | Media | CRUD de categorias con asociacion a productos |
| RF11 | Control de Inventario | CU-10 | Administrador | Alta | Alertas de stock minimo, registro de movimientos |
| RF12 | Generar Factura | CU-12 | Cajero / Admin | Alta | Total correcto, desglose de productos e impuestos |
| RF13 | Registrar Pago | CU-13 | Cajero | Alta | Multiples metodos de pago, confirmacion visible |
| RF14 | Cierre de Caja | CU-14 | Cajero / Admin | Alta | Resumen diario, totales por metodo de pago |
| RF15 | Generar Reportes de Ventas | CU-15 | Gerente / Admin | Alta | Filtros por fecha, producto y mesero; totales correctos |
| RF16 | Ver Menu Digital QR | CU-16 | Cliente | Alta | Sin autenticacion, diseno responsivo, productos actualizados en tiempo real |
| RF17 | Consultar Consumo Actual QR | CU-17 | Cliente | Media | Lista de productos pedidos, subtotal y estado del pedido |

---

## 2. Matriz RNF — Mecanismo de verificacion

| RNF | Categoria | Descripcion | Como se verifica |
|---|---|---|---|
| RNF-01 | Seguridad | Comunicacion cifrada mediante HTTPS | Configuracion del servidor con certificado SSL |
| RNF-02 | Seguridad | Contrasenas encriptadas (bcrypt) | Revision de codigo: funcion hash en el modulo de autenticacion |
| RNF-03 | Seguridad | Autenticacion mediante JWT | Token generado en el inicio de sesion y validado en cada endpoint |
| RNF-04 | Seguridad | Control de acceso por rol | Prueba: usuario sin permiso intenta acceder y recibe error 403 |
| RNF-05 | Rendimiento | Comandas enviadas a cocina en menos de 5 segundos | Prueba cronometrada desde el registro hasta la recepcion en cocina |
| RNF-06 | Usabilidad | Interfaz responsiva | Prueba en Chrome, Firefox, Edge y dispositivos moviles |
| RNF-07 | Usabilidad | Mensajes de error comprensibles | Revision de todos los mensajes de error definidos en el sistema |
| RNF-08 | Disponibilidad | 99% de uptime en horario operativo | Monitoreo del servidor mediante registros de disponibilidad |
| RNF-09 | Escalabilidad | Soporte para multiples usuarios simultaneos | Prueba de carga basica con sesiones concurrentes |
| RNF-10 | Mantenibilidad | Codigo modular y documentado | Revision de estructura de carpetas y comentarios en el codigo |
| RNF-11 | Compatibilidad | Compatible con Chrome, Firefox y Edge | Prueba funcional en los tres navegadores |
| RNF-12 | Compatibilidad | Interfaz QR accesible desde cualquier movil moderno | Prueba en dispositivos Android e iOS |

---

## 3. Resumen de cobertura

### Requisitos funcionales cubiertos por casos de uso: 17 de 17

```
RF01 --> CU-01
RF02 --> CU-02
RF03 --> CU-03
RF04 --> CU-04
RF05 --> CU-05
RF06 --> CU-06
RF07 --> CU-07
RF08 --> CU-08
RF09 --> CU-08 (flujo alternativo)
RF10 --> CU-09
RF11 --> CU-10
RF12 --> CU-12
RF13 --> CU-13
RF14 --> CU-14
RF15 --> CU-15
RF16 --> CU-16
RF17 --> CU-17
```

### Requisitos no funcionales con mecanismo de verificacion definido: 12 de 12

---

## 4. Actores y casos de uso por actor

| Actor | Cantidad de CU | Casos de uso |
|---|---|---|
| Administrador | 11 | CU-01, CU-02, CU-03, CU-08, CU-09, CU-10, CU-11, CU-12, CU-13, CU-14, CU-15 |
| Mesero | 4 | CU-02, CU-04, CU-06, CU-11 |
| Cajero | 4 | CU-02, CU-12, CU-13, CU-14 |
| Gerente | 2 | CU-02, CU-15 |
| Cliente | 2 | CU-16, CU-17 |
| Sistema SIGRES | 3 | CU-05, CU-07, CU-10 (automatizados) |

Total de casos de uso: 17 | Total de actores: 6