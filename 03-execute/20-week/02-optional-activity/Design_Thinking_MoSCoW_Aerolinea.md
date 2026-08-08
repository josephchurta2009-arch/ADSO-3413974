# Design Thinking y MoSCoW — Venta y control de tiquetes aéreos

## 1. Design Thinking

### 1.1 Empatizar

El usuario principal del MVP es el **agente de la aerolínea**. Este usuario necesita gestionar reservas, tiquetes, vuelos, asignación de asientos, equipaje, pagos y embarques, además de consultar reportes.

También existe una necesidad importante de identificar a los pasajeros que compraron un tiquete pero no registraron su embarque (**no-show**).

### 1.2 Definir

**Problema:**

La aerolínea necesita organizar y controlar el proceso de venta y operación de tiquetes, manteniendo relacionadas correctamente la información de pasajeros, reservas, vuelos, aeronaves, asientos, equipaje, pagos y embarques.

**Pregunta de diseño:**

> ¿Cómo facilitar al agente de la aerolínea la gestión de reservas y tiquetes, manteniendo la información organizada y permitiendo controlar los vuelos, asientos, equipaje, pagos y embarques?

**Necesidades principales:**

- Registrar y consultar pasajeros.
- Crear reservas.
- Emitir tiquetes.
- Gestionar vuelos y aeronaves.
- Asignar asientos.
- Registrar equipaje y pagos.
- Registrar embarques.
- Consultar pasajeros con tiquete que no viajaron.

### 1.3 Idear

Se proponen las siguientes soluciones:

1. Módulo de pasajeros.
2. Módulo de reservas y tiquetes.
3. Gestión de vuelos y aeronaves.
4. Asignación de asientos relacionando pasajero, asiento y vuelo.
5. Registro de equipaje.
6. Registro opcional de pagos.
7. Registro de embarque.
8. Reporte de pasajeros no-show.
9. Regla para impedir que un asiento sea asignado dos veces en el mismo vuelo.
10. Aplicación web con backend, frontend y base de datos separados.

### 1.4 Prototipar

El prototipo puede organizarse en las siguientes áreas:

- Inicio de sesión
- Pasajeros
- Reservas
- Tiquetes
- Vuelos
- Aeronaves y asientos
- Equipaje
- Pagos
- Embarques
- Reporte de no-show

**Flujo principal:**

```text
Iniciar sesión
      ↓
Registrar pasajero
      ↓
Crear reserva
      ↓
Emitir tiquete
      ↓
Crear/seleccionar vuelo
      ↓
Asignar asiento
      ↓
Registrar equipaje y pago
      ↓
Registrar embarque
      ↓
Consultar no-show
```

### 1.5 Probar

Se debe comprobar el flujo principal:

1. El agente inicia sesión.
2. Crea un pasajero.
3. Crea una reserva.
4. Emite un tiquete.
5. Crea un vuelo con origen y destino diferentes.
6. Asigna una aeronave.
7. Asigna un asiento.
8. Registra equipaje y pago cuando corresponda.
9. Registra el embarque.
10. Consulta los pasajeros con tiquete que no registraron embarque.

También debe comprobarse que un asiento no pueda asignarse dos veces en el mismo vuelo.

---

# 2. Matriz MoSCoW

## 2.1 Must Have — Debe tener

Son los elementos indispensables para el MVP.

| ID | Requisito |
|---|---|
| RF01 | Inicio de sesión del agente con credenciales válidas. |
| RF02 | Crear y listar pasajeros. |
| RF03 | Crear reservas para un pasajero y consultar su estado. |
| RF04 | Emitir un tiquete a partir de una reserva. |
| RF05 | Crear vuelos con número, fecha, origen, destino y aeronave. |
| RF06 | Asignar un asiento a un pasajero con tiquete. |
| RF07 | Registrar equipaje y pagos asociados al tiquete. |
| RF08 | Registrar el embarque de un pasajero. |
| RF09 | Consultar pasajeros con tiquete que no registraron embarque (no-show). |
| RNF01 | Seguridad mediante token válido y contraseñas hasheadas. |
| RNF02 | Evitar la reasignación de un asiento en el mismo vuelo. |

**Justificación:** sin estos elementos no se puede completar correctamente el proceso principal de venta y control de tiquetes.

## 2.2 Should Have — Debería tener

Son importantes para la calidad del sistema.

| ID | Requisito |
|---|---|
| RNF03 | Consultas de listado inferiores a 500 ms para hasta 10.000 tiquetes. |
| RNF04 | Backend, frontend y base de datos como proyectos separados. |
| RNF05 | Mensajes en español y formatos locales para fechas y valores. |
| RNF06 | Operaciones atómicas para mejorar la confiabilidad. |

**Justificación:** estos requisitos mejoran rendimiento, mantenimiento, confiabilidad y usabilidad, pero no representan directamente una operación principal del negocio.

## 2.3 Could Have — Podría tener

El PRD **no especifica funcionalidades adicionales** para esta categoría.

Por lo tanto, no se agregan funcionalidades inventadas.

## 2.4 Won't Have — No tendrá en esta versión

El MVP define un único rol: **agente de la aerolínea**.

Por ello, quedan fuera del alcance de esta versión:

- Gestión de roles adicionales.
- Funcionalidades que no estén especificadas en el PRD actual.

---

# 3. Resumen de prioridades

| Prioridad | Contenido |
|---|---|
| **Must** | Autenticación, pasajeros, reservas, tiquetes, vuelos, aeronaves, asientos, equipaje, pagos, embarque y no-show. |
| **Should** | Rendimiento, seguridad, confiabilidad, mantenibilidad y usabilidad. |
| **Could** | No definido en el PRD actual. |
| **Won't** | Roles adicionales y funcionalidades fuera del alcance del MVP. |

# 4. Conclusión

El **Design Thinking** permite analizar las necesidades del agente de la aerolínea, definir el problema, proponer soluciones, plantear un prototipo y establecer cómo comprobar que la solución funciona.

La matriz **MoSCoW** permite priorizar los requisitos. Las funciones relacionadas directamente con la venta y control de tiquetes son indispensables para el MVP, mientras que los requisitos de calidad ayudan a garantizar un sistema seguro, confiable, mantenible y usable.

El **DER** realizado complementa estos entregables al representar las entidades y relaciones necesarias para soportar el funcionamiento del sistema.
