# SIGRES — Sistema Integral de Gestion para Restaurantes

**Semana:** 27 | **Actividad:** G1 — Analisis y Documentacion
**Ficha:** 3413974 — Tecnologo en Analisis y Desarrollo de Software
**Instructor:** Eddier Yair Liberato Cuenca — SENA
**Fecha limite:** 28 de noviembre de 2026, 6:00 a.m.

---

## Equipo

| Integrante | Rol |
|---|---|
| Julian Stiven Camargo Martin | Desarrollador FullStack |
| Martin Julian Torres Fierro | Desarrollador FullStack |
| Juan David Gomez Martinez | Desarrollador FullStack |
| Kevin Santiago Saavedra Chantris | Desarrollador FullStack |

---

## Descripcion del proyecto

SIGRES es una solucion tecnologica multiplataforma (web y movil) para digitalizar y centralizar los procesos operativos y administrativos de restaurantes de pequena y mediana escala.

El sistema cubre los siguientes procesos:
- Registro y seguimiento de pedidos en tiempo real entre meseros, cocina y caja
- Control de inventario de insumos y productos con alertas de stock minimo
- Facturacion automatizada y registro de pagos
- Gestion del estado de mesas
- Generacion de reportes de ventas y desempeno
- Menu digital accesible por codigo QR para clientes, sin necesidad de autenticacion

---

## Arquitectura general

```
[ App Movil (Meseros) ]   [ Plataforma Web (Admin / Cajero / Gerente) ]   [ Menu QR (Clientes) ]
           |                              |                                        |
           +------------------------------+----------------------------------------+
                                          |
                                     [ API REST ]
                                          |
                               [ Base de Datos Relacional ]
                                 (MySQL / PostgreSQL)
```

---

## Roles del sistema

| Rol | Plataforma | Acceso |
|---|---|---|
| Administrador | Web | Gestion total del sistema |
| Mesero | App movil | Registro de pedidos y mesas |
| Cajero | Web | Facturacion y pagos |
| Gerente | Web | Reportes e indicadores |
| Cliente | Movil via QR | Menu digital y consulta de consumo |

---

## Modulos

| Modulo | RF |
|---|---|
| M1 — Autenticacion y Usuarios | RF01-RF03 |
| M2 — Gestion de Pedidos | RF04-RF07 |
| M3 — Menu y Productos | RF08-RF10 |
| M4 — Inventario | RF11 |
| M5 — Facturacion y Caja | RF12-RF14 |
| M6 — Mesas | RF (Mesas) |
| M7 — Reportes y Analitica | RF15 |
| M8 — Menu Digital QR | RF16-RF17 |

---

## Estructura de la entrega

```
02-optional-activity/
├── README.md
├── Producto-1/
│   ├── SRS-SIGRES.docx
│   ├── plan-de-trabajo.md
│   └── diagrama-casos-de-uso.md
└── Producto-2/
    ├── arquitectura-del-sistema.md
    └── trazabilidad-requisitos.md
```

---

## Stack tecnologico propuesto

| Capa | Tecnologia |
|---|---|
| Frontend Web | React.js / Vue.js |
| App Movil | React Native / Flutter |
| Backend | Node.js + Express / Django |
| Base de datos | MySQL / PostgreSQL |
| Autenticacion | JWT |
| API | REST sobre HTTPS |

---

## Referencias

- Mockup del sistema: https://stitch.google.com/projects/12308260585995939873
- Tablero Trello: https://trello.com/b/vxo416JY/sigres
- IEEE 830-1998: https://doi.org/10.1109/IEEESTD.1998.88286
- ISO/IEC 25010:2011: https://www.iso.org/standard/35733.html