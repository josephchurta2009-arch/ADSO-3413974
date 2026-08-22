# BPMN As-Is — Sistema de Gestión de Horarios (Joseph)

Cobertura por rol, basada en los "Flujograma Principal" documentados en Analisis.md (mockup de 53 pantallas):

1. `auth-shell.bpmn` — Login, recuperación de contraseña, carga de App Shell y notificaciones globales.
2. `aprendiz.bpmn` — Consulta de horario, detalle de clase, notificaciones.
3. `instructor.bpmn` — Horario, disponibilidad, excepciones, seguimiento de ficha.
4. `coordinador.bpmn` — Dashboard, creación/edición de horario, conflictos, publicación, fichas.
5. `administrador.bpmn` — Indicadores/KPI, gestión de usuarios, asignación de roles, parámetros.
6. `back-office.bpmn` — Documentos, plantillas, generación de documento, auditoría, catálogos.
7. `parametrizacion.bpmn` — Hub de parametrización, configuración de componentes, historial de cambios.
8. `global-colaborativo.bpmn` — Flujo integrado de las 7 vistas (Parametrización → Planeación → Validación → Publicación → Comunicación → Ejecución → Seguimiento → Monitoreo), con fork/join paralelo para la ejecución concurrente de Aprendiz, Instructor y Back-office tras la publicación.

Todos usan `isExecutable="true"` y Service Tasks con tipos Zeebe (preparación para Camunda 8), igual que los BPMN de horarios ya entregados.

Validado: XML bien formado, referencias sourceRef/targetRef existentes, cobertura completa del laneSet, nodos alcanzables sin callejones sin salida, gateways exclusivos con ambas ramas etiquetadas, gateway paralelo (fork/join) balanceado, y DI completo (shape/edge por cada nodo/flujo).
