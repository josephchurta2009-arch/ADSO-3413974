# Diagramas de Actividades — Casos de Uso Criticos (SIGRES)

Se modelan dos casos de uso criticos del sistema en notacion UML de actividades, con calles (swimlanes) por actor, nodo inicial, nodo final, decisiones con guardas entre corchetes cubriendo todas las salidas y control de concurrencia.

---

## 1. Diagrama de Actividades 1: CU-03 Registrar pedido

- **Fuente editable:** [diagrama-actividades-pedido.drawio](./diagrama-actividades-pedido.drawio)
- **Imagen:** [diagrama-actividades-pedido.svg](./diagrama-actividades-pedido.svg)
- **Actores (calles):** Mesero, Sistema SIGRES, Sistema de Cocina.
- **Concurrencia:** Se utiliza barra de bifurcacion (fork) y union (join) cuando el sistema confirma el pedido, ya que en paralelo actualiza el estado de la mesa a «Ocupada» y envia la comanda a la pantalla de cocina.
- **Coherencia con plantilla extendida:** Todas las ramas alternas (`[producto no disponible]`) y de excepcion (`[sin conexion]`) estan documentadas en `02-Plantillas-Extendidas-CU.md`.

---

## 2. Diagrama de Actividades 2: CU-09 Generar factura y procesar pago

- **Fuente editable:** [diagrama-actividades-facturacion.drawio](./diagrama-actividades-facturacion.drawio)
- **Imagen:** [diagrama-actividades-facturacion.svg](./diagrama-actividades-facturacion.svg)
- **Actores (calles):** Cajero, Sistema SIGRES.
- **Concurrencia:** Este flujo no presenta concurrencia porque cada paso depende estrictamente del resultado anterior (validar consumo -> calcular total -> procesar pago -> liberar mesa).
- **Coherencia con plantilla extendida:** Las salidas con guarda (`[sin pedido activo]`, `[pago rechazado]`, `[pago aprobado]`) coinciden con los flujos alternos y excepciones de `CU-09` en `02-Plantillas-Extendidas-CU.md`.
