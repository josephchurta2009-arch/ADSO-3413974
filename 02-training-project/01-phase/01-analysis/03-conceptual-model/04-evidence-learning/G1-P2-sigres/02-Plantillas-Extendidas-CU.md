# Plantillas Extendidas de Casos de Uso — SIGRES (Anexo A)

Se presentan 3 plantillas extendidas de casos de uso criticos redactadas en lenguaje de negocio e intencion, sin detalles de implementacion tecnica.

---

## 1. CU-03 · Registrar pedido

| Campo | Contenido |
|---|---|
| **Identificador y nombre** | CU-03 · Registrar pedido |
| **Requisitos que atiende** | RF04, RF05 |
| **Actor primario / secundarios** | Mesero / Sistema de Cocina |
| **Objetivo del actor** | Registrar la orden de consumo de una mesa y enviarla a preparacion en cocina. |
| **Precondiciones** | El mesero ha iniciado sesion en el sistema; la mesa existe y esta habilitada para atencion. |
| **Disparador** | El mesero selecciona una mesa e inicia una nueva orden. |
| **Flujo principal** | 1. El mesero selecciona la mesa asignada en su vista operativa.<br>2. El sistema solicita la cantidad de comensales y muestra el catalogo de productos activos.<br>3. El mesero selecciona los productos, indica las cantidades y anade observaciones de preparacion.<br>4. El sistema verifica la disponibilidad de cada producto seleccionado.<br>5. El mesero revisa el resumen de la orden y confirma el registro.<br>6. El sistema asigna un identificador unico al pedido, cambia el estado de la mesa a «Ocupada» y envia la comanda al area de cocina. |
| **Flujos alternos** | 4a. Si el producto seleccionado figura como agotado, el sistema advierte al mesero y le permite sustituirlo por otro producto disponible antes de confirmar. |
| **Excepciones** | 6a. Si se interrumpe la comunicacion al confirmar la orden, el sistema informa que no fue posible registrar el pedido y solicita reintentar sin duplicar la comanda. |
| **Postcondiciones** | El pedido queda registrado con identificador unico, en estado «En preparacion», visible en cocina, y la mesa figura como «Ocupada». |
| **Reglas de negocio** | No se pueden confirmar ordenes vacias ni productos marcados como no disponibles. |
| **Pantalla del prototipo** | [Pantalla P1 — Toma de Pedido (CU-03)](./05-Prototipo-Inicial.md#pantalla-1--toma-de-pedido-cu-03) |

---

## 2. CU-09 · Generar factura y procesar pago

| Campo | Contenido |
|---|---|
| **Identificador y nombre** | CU-09 · Generar factura y procesar pago |
| **Requisitos que atiende** | RF12, RF13 |
| **Actor primario / secundarios** | Cajero / Cliente |
| **Objetivo del actor** | Emitir la cuenta detallada de consumo de una mesa, registrar el pago correspondiente y liberar la mesa. |
| **Precondiciones** | El cajero ha iniciado sesion y la mesa tiene al menos un pedido en estado entregado. |
| **Disparador** | El cajero selecciona la mesa para liquidar la cuenta a solicitud del cliente. |
| **Flujo principal** | 1. El cajero selecciona la mesa con consumo pendiente.<br>2. El sistema consulta los pedidos asociados y verifica que existan items facturables.<br>3. El sistema calcula el subtotal, los impuestos aplicables y el total a pagar, mostrando la factura preliminar.<br>4. El cajero confirma la emision de la factura e ingresa el metodo de pago y el monto recibido.<br>5. El sistema valida que el monto cubra el total de la cuenta.<br>6. El sistema registra el pago, marca la factura como pagada y cambia el estado de la mesa a «Disponible». |
| **Flujos alternos** | 4a. Si el cliente solicita dividir o revisar el detalle antes de pagar, el cajero entrega la pre-cuenta impresa y mantiene la factura abierta hasta recibir el pago. |
| **Excepciones** | 2a. Si la mesa seleccionada no tiene pedidos activos, el sistema muestra «No hay consumo registrado para esta mesa» y cancela la operacion.<br>5a. Si el monto ingresado es inferior al total de la factura, el sistema rechaza el registro y solicita completar el valor pendiente. |
| **Postcondiciones** | La factura queda emitida y saldada, el ingreso queda contabilizado para el cierre de caja y la mesa pasa a estado «Disponible». |
| **Reglas de negocio** | Toda factura pagada debe quedar asociada a un unico cierre de caja diario y no permite modificar los items ya facturados. |
| **Pantalla del prototipo** | [Pantalla P2 — Facturacion y Caja (CU-09)](./05-Prototipo-Inicial.md#pantalla-2--facturacion-y-caja-cu-09) |

---

## 3. CU-13 · Consultar menu digital QR

| Campo | Contenido |
|---|---|
| **Identificador y nombre** | CU-13 · Consultar menu digital QR |
| **Requisitos que atiende** | RF16, RF17 |
| **Actor primario / secundarios** | Cliente / Ninguno |
| **Objetivo del actor** | Visualizar los productos disponibles del restaurante y, si lo desea, verificar el consumo acumulado de su mesa sin requerir registro. |
| **Precondiciones** | El codigo QR asignado a la mesa esta vigente y el catalogo cuenta con productos activos. |
| **Disparador** | El cliente escanea el codigo QR ubicado en su mesa con la camara de su dispositivo movil. |
| **Flujo principal** | 1. El cliente realiza la lectura del codigo QR de la mesa.<br>2. El sistema valida el identificador de la mesa asociado al codigo.<br>3. El sistema presenta el catalogo digital organizado por categorias con nombres, descripciones, precios y estado de disponibilidad.<br>4. El cliente navega entre las categorias para revisar la oferta del restaurante.<br>5. Opcionalmente, el cliente selecciona la opcion de consultar su consumo actual.<br>6. El sistema muestra la lista de productos pedidos en la mesa, su estado de preparacion y el subtotal acumulado. |
| **Flujos alternos** | 5a. Si la mesa aun no tiene pedidos registrados al consultar el consumo, el sistema muestra un aviso informativo indicando que no hay consumo activo y mantiene visible el menu. |
| **Excepciones** | 2a. Si el codigo QR no corresponde a una mesa activa o esta danado, el sistema muestra un mensaje indicando que el codigo no es valido y sugiere solicitar ayuda al mesero. |
| **Postcondiciones** | El cliente obtiene informacion actualizada de la oferta y su consumo en tiempo real sin alterar ningun registro del sistema. |
| **Reglas de negocio** | El acceso es publico sin credenciales; el cliente unicamente puede consultar informacion y no tiene permitido enviar ordenes directamente desde esta vista. |
| **Pantalla del prototipo** | [Pantalla P3 — Menu Digital QR (CU-13)](./05-Prototipo-Inicial.md#pantalla-3--menu-digital-qr-cu-13) |
