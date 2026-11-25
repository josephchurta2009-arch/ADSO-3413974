# 🏗️ Arquitectura del Sistema — SIGRES

**Proyecto:** Sistema Integral de Gestión para Restaurantes  
**Versión:** 1.0 | **Fecha:** Noviembre 2026

---

## 1. Visión General de la Arquitectura

SIGRES adopta una **arquitectura cliente-servidor de tres capas** (presentación, lógica de negocio y datos), expuesta mediante una **API REST** sobre HTTPS que permite la comunicación en tiempo real entre la app móvil, la plataforma web y el menú digital QR.

```
┌──────────────────────────────────────────────────────────────┐
│                     CAPA DE PRESENTACIÓN                      │
│                                                              │
│  ┌─────────────┐  ┌──────────────┐  ┌──────────────────────┐ │
│  │  App Móvil  │  │ Plataforma   │  │  Menú Digital QR     │ │
│  │ (Meseros)   │  │    Web       │  │  (Clientes - sin     │ │
│  │React Native │  │(Admin/Cajero │  │   autenticación)     │ │
│  │ /Flutter    │  │  /Gerente)   │  │   Web Responsive     │ │
│  │             │  │React/Vue.js  │  │                      │ │
│  └──────┬──────┘  └──────┬───────┘  └──────────┬───────────┘ │
└─────────┼────────────────┼─────────────────────┼─────────────┘
          │                │                     │
          └────────────────┼─────────────────────┘
                           │  HTTPS / REST / WebSockets
┌──────────────────────────▼───────────────────────────────────┐
│                   CAPA DE LÓGICA DE NEGOCIO                   │
│                                                              │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │                    API REST                             │ │
│  │             (Node.js + Express / Django)                │ │
│  │                                                         │ │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌───────────┐  │ │
│  │  │ Auth     │ │ Pedidos  │ │Inventario│ │Facturación│  │ │
│  │  │ Module   │ │ Module   │ │ Module   │ │  Module   │  │ │
│  │  └──────────┘ └──────────┘ └──────────┘ └───────────┘  │ │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌───────────┐  │ │
│  │  │  Mesas   │ │ Reportes │ │  Menú    │ │  QR Code  │  │ │
│  │  │  Module  │ │  Module  │ │  Module  │ │  Service  │  │ │
│  │  └──────────┘ └──────────┘ └──────────┘ └───────────┘  │ │
│  └─────────────────────────────────────────────────────────┘ │
└──────────────────────────┬───────────────────────────────────┘
                           │
┌──────────────────────────▼───────────────────────────────────┐
│                      CAPA DE DATOS                            │
│                                                              │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │          Base de Datos Relacional                       │ │
│  │               (MySQL / PostgreSQL)                      │ │
│  │                                                         │ │
│  │  Tablas: usuarios, roles, pedidos, productos,           │ │
│  │          categorías, inventario, mesas, facturas,       │ │
│  │          pagos, reportes, códigos_qr                    │ │
│  └─────────────────────────────────────────────────────────┘ │
└──────────────────────────────────────────────────────────────┘
```

---

## 2. Diagrama de Componentes

```
SIGRES
│
├── frontend-web/              ← Interfaz web (admin, cajero, gerente)
│   ├── auth/                  → Login, gestión de sesión
│   ├── dashboard/             → Panel principal con KPIs
│   ├── pedidos/               → Seguimiento de comandas
│   ├── menu/                  → CRUD de productos y categorías
│   ├── inventario/            → Control de insumos
│   ├── mesas/                 → Estado de mesas en tiempo real
│   ├── facturacion/           → Facturas y pagos
│   └── reportes/              → Visualización de estadísticas
│
├── mobile-app/                ← App móvil (meseros)
│   ├── auth/                  → Login de mesero
│   ├── mesas/                 → Selección y estado de mesas
│   ├── pedidos/               → Nueva comanda, seguimiento
│   └── menu/                  → Consulta del menú (solo lectura)
│
├── qr-web/                    ← Interfaz pública QR (clientes)
│   ├── menu/                  → Menú digital por categorías
│   └── consumo/               → Resumen de consumo de la mesa
│
└── backend/                   ← API REST
    ├── auth/                  → JWT, control de sesión y roles
    ├── usuarios/              → CRUD de usuarios
    ├── pedidos/               → Lógica de pedidos y comandas
    ├── productos/             → CRUD de menú e inventario
    ├── mesas/                 → Estado de mesas
    ├── facturacion/           → Facturación y pagos
    ├── reportes/              → Generación de reportes
    └── qr/                   → Generación y validación de QR
```

---

## 3. Flujo Principal: Ciclo completo de un pedido

```
MESERO                 SISTEMA                 COCINA                CAJERO
  │                       │                      │                      │
  │ 1. Selecciona mesa     │                      │                      │
  │──────────────────────►│                      │                      │
  │                       │ 2. Verifica mesa      │                      │
  │                       │    disponible         │                      │
  │ 3. Selecciona         │                      │                      │
  │    productos           │                      │                      │
  │──────────────────────►│                      │                      │
  │                       │ 4. Registra comanda  │                      │
  │                       │    (ID único)         │                      │
  │                       │──────────────────────►│                      │
  │                       │ 5. Notifica cocina    │                      │
  │                       │    (< 5 segundos)     │                      │
  │                       │                      │ 6. Prepara pedido    │
  │                       │                      │◄─────────────────────│
  │                       │ 7. Cocina actualiza   │                      │
  │                       │    estado             │                      │
  │◄──────────────────────│ 8. Mesero ve          │                      │
  │                       │    "En preparación"   │                      │
  │                       │                      │ 9. Pedido listo      │
  │◄──────────────────────│ 10. Notifica mesero   │                      │
  │                       │    "Listo"            │                      │
  │ 11. Entrega al        │                      │                      │
  │     cliente           │                      │                      │
  │                       │                      │                      │
  │                       │                      │  12. Cliente solicita│
  │                       │                      │      la cuenta       │
  │                       │                      │◄─────────────────────│
  │                       │◄─────────────────────────────────────────── │
  │                       │ 13. Genera factura    │                      │
  │                       │──────────────────────────────────────────── ►│
  │                       │ 14. Cajero procesa   │                      │
  │                       │     el pago           │                      │
  │                       │ 15. Mesa cambia a     │                      │
  │                       │     "Disponible"      │                      │
```

---

## 4. Modelo de Datos (Entidades principales)

| Entidad | Atributos clave | Relaciones |
|---|---|---|
| **Usuario** | id, nombre, email, password_hash, rol_id | → Rol, → Pedido (como mesero) |
| **Rol** | id, nombre, permisos | ← Usuario |
| **Mesa** | id, numero, estado, qr_code | → Pedido |
| **Pedido** | id, mesa_id, mesero_id, estado, fecha_hora | → Mesa, → Usuario, → DetallePedido |
| **DetallePedido** | id, pedido_id, producto_id, cantidad, notas | → Pedido, → Producto |
| **Producto** | id, nombre, precio, categoria_id, disponible, imagen | → Categoría, → Inventario |
| **Categoría** | id, nombre, descripción | ← Producto |
| **Inventario** | id, insumo_id, cantidad, stock_minimo | → Insumo |
| **Factura** | id, pedido_id, total, impuesto, fecha_hora | → Pedido, → Pago |
| **Pago** | id, factura_id, metodo, monto, fecha_hora | → Factura |

---

## 5. Requisitos no funcionales clave

| RNF | Descripción | Métrica |
|---|---|---|
| **Rendimiento** | Las comandas deben llegar a cocina en tiempo real | Máximo 5 segundos |
| **Seguridad** | Comunicación cifrada y autenticación por token | HTTPS + JWT |
| **Usabilidad** | Interfaz intuitiva para usuarios con bajo nivel técnico | Capacitación < 30 min |
| **Disponibilidad** | Sistema operativo durante horario del restaurante | 99% uptime |
| **Escalabilidad** | Soporte para múltiples mesas y usuarios simultáneos | Arquitectura modular |
| **Compatibilidad** | Funciona en Chrome, Firefox, Edge y dispositivos móviles | Responsive CSS |
