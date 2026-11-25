# Prototipo Inicial (Mockup) — SIGRES

**Enlace al prototipo interactivo en Google Stitch:** https://stitch.google.com/projects/12308260585995939873

Cada pantalla del prototipo atiende directamente a uno de los casos de uso criticos modelados en el analisis.

---

## Pantalla 1 · Toma de Pedido (`CU-03 Registrar pedido`)

- **Caso de uso que atiende:** `CU-03 · Registrar pedido` (RF04, RF05).
- **Actor:** Mesero (aplicacion movil).
- **Elementos clave de la interfaz:**
  - Selector de mesa con indicador visual de estado (Disponible / Ocupada).
  - Buscador y pestanas de categorias del menu.
  - Lista de productos con indicador de disponibilidad (bloqueo visual si esta agotado).
  - Campo de observaciones por producto y resumen de comanda antes de confirmar el envio a cocina.

---

## Pantalla 2 · Facturacion y Caja (`CU-09 Generar factura y procesar pago`)

- **Caso de uso que atiende:** `CU-09 · Generar factura y procesar pago` (RF12, RF13).
- **Actor:** Cajero (plataforma web).
- **Elementos clave de la interfaz:**
  - Listado de mesas con consumo activo listas para liquidar.
  - Desglose automatico de productos, cantidades, subtotal, impuestos y total.
  - Selector de metodo de pago (efectivo, tarjeta, transferencia) y campo de monto recibido con validacion de saldo.
  - Boton de emision de factura y liberacion de mesa.

---

## Pantalla 3 · Menu Digital QR (`CU-13 Consultar menu digital QR`)

- **Caso de uso que atiende:** `CU-13 · Consultar menu digital QR` (RF16, RF17).
- **Actor:** Cliente (navegador movil sin autenticacion).
- **Elementos clave de la interfaz:**
  - Encabezado con identificacion de la mesa escaneada.
  - Catalogo visual por categorias con fotografia, descripcion, precio e indicador de «No disponible» para productos agotados.
  - Boton de acceso a «Ver mi consumo» para consultar en tiempo real el estado de los pedidos realizados en la mesa (solo lectura).
