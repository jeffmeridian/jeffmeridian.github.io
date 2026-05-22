# Preguntas y Respuestas para Entrevistas de QA

*Conjunto de 180 preguntas seleccionadas para entrevistas de QA / Test Manager con respuestas sugeridas.*

---

## Conceptos Básicos de QA (1–20)

| # | Pregunta | Respuesta Propuesta |
|---|---|---|
| 1 | ¿Cuál es la diferencia entre Quality Assurance (QA) y Quality Control (QC)? | QA es orientado a procesos (evitar errores). QC es orientado a productos (detectar errores). |
| 2 | ¿Cuáles son las fases del Ciclo de Vida de Pruebas de Software (STLC)? | Análisis de requisitos, planificación de pruebas, diseño de casos de prueba, configuración del entorno, ejecución, seguimiento de errores y cierre. |
| 3 | ¿Cómo decide qué probar? | Análisis de requisitos, riesgo comercial, impacto en el usuario y datos históricos de errores para definir un plan de cobertura priorizado. |
| 4 | ¿Qué hace que un caso de prueba sea bueno? | Debe ser claro, conciso, repetible y verificar un requisito o comportamiento específico con resultados esperados mesurables. |
| 5 | Explique el Análisis de Valores Límite (Boundary Value Analysis). | Probar entradas justo en/fuera de los límites para detectar errores comunes en los bordes. |
| 6 | Explique la Partición de Equivalencia (Equivalence Partitioning). | División de los datos de entrada en particiones válidas e inválidas para reducir la redundancia manteniendo una alta cobertura. |
| 7 | ¿Cuál es la diferencia entre pruebas de regresión y re-testing? | La regresión verifica áreas no afectadas por estabilidad; el re-testing verifica correcciones de errores específicas. |
| 8 | ¿Cómo aborda las pruebas negativas? | Diseñar escenarios que utilicen intencionalmente entradas o acciones inválidas para asegurar un manejo de errores robusto. |
| 9 | ¿Qué significan Severidad y Prioridad en la gestión de errores? | Severidad = impacto técnico; Prioridad = urgencia comercial de la corrección. |
| 10 | ¿Cómo define una métrica de cobertura de pruebas? | Relación entre casos de prueba ejecutados y total de requisitos asignados, expresada como porcentaje. |
| 11 | ¿Cómo asegura la trazabilidad de los requisitos? | Manteniendo una matriz de trazabilidad (RTM) que vincule: Requisitos → Casos de prueba → Errores → Resultados. |
| 12 | ¿Qué son las pruebas exploratorias? | Pruebas ad-hoc, pero estructuradas, para descubrir errores desconocidos mediante la creatividad del tester. |
| 13 | ¿Cómo valida la integridad de los datos después de una migración? | Usando conteos de filas, sumas de verificación (checksums) y muestreo aleatorio entre bases de datos fuente y destino. |
| 14 | ¿Cómo maneja los requisitos incompletos? | Aclarar suposiciones, crear pruebas para reglas comerciales conocidas y alinear iterativamente con los stakeholders. |
| 15 | ¿Qué niveles de prueba existen en el SDLC? | Unitarias, integración, sistema, aceptación, humo (smoke), regresión y pruebas no funcionales. |
| 16 | ¿Cómo establece los criterios de finalización de pruebas? | Basados en el plan definido: objetivos de cobertura, densidad de errores y umbrales de tasa de aprobación. |
| 17 | ¿Cómo gestiona los riesgos en las pruebas? | Identificar riesgos (requisitos, tecnología, recursos), evaluar por impacto × probabilidad y priorizar las pruebas en consecuencia. |
| 18 | Explique el Shift-Left Testing. | Integración temprana de las pruebas en el SDLC: revisiones, análisis estático y automatización temprana. |
| 19 | ¿Cuáles son los documentos de prueba comunes? | Estrategia de pruebas, plan de pruebas, casos de prueba, datos de prueba, informes resumidos y documentación de cierre. |
| 20 | ¿Cuál es la ventaja principal de la automatización de pruebas? | Velocidad, consistencia y fiabilidad de regresión con menor esfuerzo manual a largo plazo. |

---

## Automatización y Herramientas (21–40)

| # | Pregunta | Respuesta Propuesta |
|---|---|---|
| 21 | ¿Qué herramientas ha utilizado para automatización? | Selenium, Playwright, Cypress, Postman, k6 e integración en pipelines de Azure DevOps. |
| 22 | ¿Cómo diseña pruebas automatizadas mantenibles? | Abstracción con Page Objects, funciones reutilizables, selectores estables y limpieza limpia de datos (setup/teardown). |
| 23 | ¿Qué diseño de framework prefiere? | Híbrido, modular y basado en datos: combina parametrización con bibliotecas reutilizables. |
| 24 | ¿Cómo maneja elementos dinámicos en la automatización? | Esperas explícitas (Explicit Waits), selectores inteligentes (CSS/XPath) y mecanismos de reintento. |
| 25 | ¿Cómo integra la automatización en pipelines CI/CD? | Configurar disparadores en commits/merges, publicar informes HTML y bloquear builds en fallos críticos. |
| 26 | ¿Cómo aborda las pruebas de APIs? | Validación de códigos de respuesta, esquemas, límites y encadenamiento de escenarios; herramientas: Postman, REST Assured. |
| 27 | ¿Cuáles son los beneficios de BDD (Behavior-Driven Development)? | Mejora la colaboración y legibilidad; usa sintaxis Gherkin (Given/When/Then). |
| 28 | ¿Cómo gestiona los datos de prueba para automatización? | Uso de conjuntos de datos dedicados, generadores aleatorios o frameworks de datos sintéticos. |
| 29 | ¿Cómo mide el ROI de la automatización de pruebas? | Comparando el esfuerzo ahorrado frente al costo de ejecución manual; seguimiento de cobertura y frecuencia de uso. |
| 30 | ¿Qué tipos de pruebas NO deberían automatizarse? | UIs de cambios rápidos, validaciones únicas y escenarios con bajo ROI. |
| 31 | ¿Cómo maneja las pruebas inestables (Flaky Tests)? | Identificar causas raíz, estabilizar dependencias de tiempo/datos, aislar en cuarentena y refactorizar. |
| 32 | ¿Cómo utiliza el control de versiones en las pruebas? | Almacenar scripts en Git, usar Pull Requests y revisiones de código para cambios en las pruebas. |
| 33 | ¿Qué herramientas de reporte ha utilizado? | Allure, ExtentReports, Azure Test Plans, Power BI Dashboards. |
| 34 | ¿Cómo verifica la estabilidad de la CI? | Monitoreo de tasa de éxito de builds, análisis de logs de pipelines y reducción de cuellos de botella. |
| 35 | ¿Qué son los Test Doubles? | Stubs, Mocks y Fakes usados para aislar componentes durante pruebas de integración. |
| 36 | ¿Cómo prueba APIs con autenticación? | Uso de autenticación basada en tokens en Postman/scripts; validar acceso exitoso y no autorizado. |
| 37 | ¿Por qué utilizar Data-Driven Testing? | Reutilizar lógica para múltiples conjuntos de datos y entradas, maximizando la cobertura eficientemente. |
| 38 | ¿Qué es Continuous Testing? | Ejecución automática de pruebas durante todo el ciclo de vida SDLC y CI/CD. |
| 39 | ¿Cuál es su estrategia de automatización para Microservicios? | Pruebas a nivel de API, validación de contratos y flujos de integración end-to-end. |
| 40 | ¿Qué es un Test de Humo (Smoke) en automatización? | Conjunto de comprobaciones mínimas para verificar funcionalidades clave antes de pruebas más profundas. |

---

## Ágil, DevOps y Colaboración (41–60)

| # | Pregunta | Respuesta Propuesta |
|---|---|---|
| 41 | ¿Cuál es su rol como QA en Ágil? | Colaborador, no guardián: ayudar a definir criterios de aceptación, automatización y asegurar calidad integrada. |
| 42 | ¿Cómo escribe User Stories testeables? | Incluir criterios de aceptación claros y resultados mesurables. |
| 43 | Diferencia entre Scrum y Kanban. | Scrum: Sprints con tiempo fijo; Kanban: flujo continuo optimizando límites WIP (Work in Progress). |
| 44 | ¿Cómo colabora con desarrolladores durante el Sprint? | Syncs diarios, Pair-Testing y feedback temprano sobre historias antes de integrar (merge). |
| 45 | ¿Cómo apoya QA la adopción de CI/CD? | Creando Quality Gates automáticos y monitoreando métricas post-despliegue. |
| 46 | ¿Cómo asegura ciclos de feedback rápidos? | Suites de prueba cortas, entornos de Staging y Dashboards de alertas. |
| 47 | ¿Qué es la Definition of Done (DoD)? | Lista de verificación compartida que asegura que cada historia cumpla con los estándares de calidad y entrega. |
| 48 | ¿Cómo maneja historias bloqueadas por problemas de entorno? | Escalar temprano, retomar otras tareas y reportar bloqueos en el Stand-up. |
| 49 | ¿Cómo estima el esfuerzo de prueba en Ágil? | Uso de Story Points o tallas de camisetas, alineado con capacidad del equipo y velocidad histórica. |
| 50 | ¿Cómo planifica las pruebas en Ágil? | Planeación continua (Rolling-Wave) en cada sprint, actualizando riesgos y alcance según refinamiento del Backlog. |
| 51 | ¿Cómo maneja errores descubiertos en medio del Sprint? | Registrar inmediatamente, colaborar con devs para corregir en el Sprint actual, si no, reprogramar. |
| 52 | ¿Cómo mantiene métricas de calidad en Ágil? | Seguimiento de errores escapados, tasa de éxito de automatización, cobertura y feedback en retrospectivas. |
| 53 | ¿Cómo usa métricas CI/CD para evaluar salud de calidad? | Tasa de éxito de build, tiempo de corrección, frecuencia de despliegue y MTTR. |
| 54 | ¿Cómo evalúa la preparación para release en DevOps? | Validando pruebas y evidencias de despliegue, pruebas de rollback y criterios de preparación en el Release Board. |
| 55 | ¿Cómo construye colaboración entre zonas horarias? | Documentación compartida, actualizaciones asíncronas y listas de verificación de traspaso flexibles. |
| 56 | ¿Qué cuellos de botella de QA ha eliminado en la CI? | Reducción de tiempo de regresión mediante paralelización y selección dinámica de pruebas. |
| 57 | ¿Cómo promueve una cultura de calidad? | Métricas basadas en datos, demostración del impacto de QA y visibilidad positiva de resultados. |
| 58 | ¿Qué es el Shift-Right Testing? | Pruebas en producción: monitoreo sintético, validación de despliegues Canary y feedback basado en telemetría. |
| 59 | ¿Cómo monitorea la calidad en producción? | Análisis de logs, tendencias de errores y KPIs de clientes; retroalimentación al diseño de pruebas. |
| 60 | ¿Cómo anima a devs a escribir mejores pruebas? | Foco en cobertura unitaria en revisiones de código, Pair-Programming y responsabilidad compartida. |

---

## Rendimiento, Seguridad y Cumplimiento (61–80)

| # | Pregunta | Respuesta Propuesta |
|---|---|---|
| 61 | Tipos comunes de pruebas de rendimiento. | Carga, estrés, resistencia (endurance), picos (spike) y escalabilidad. |
| 62 | Herramientas para pruebas de rendimiento. | k6, JMeter, Gatling y Azure Load Testing. |
| 63 | Métricas importantes en pruebas de carga. | Tiempo de respuesta, rendimiento (throughput), tasa de error y uso de recursos. |
| 64 | ¿Cómo identifica cuellos de botella? | Analizando logs, dashboards APM y métricas del sistema correlacionadas con datos de prueba. |
| 65 | ¿Cómo aborda auditorías de seguridad en QA? | Lista de chequeo OWASP, escaneo de vulnerabilidades, validación de entradas y principio de mínimo privilegio. |
| 66 | ¿Cómo prueba seguridad de autenticación? | Comprobar tokens expirados, resistencia a fuerza bruta y cifrado correcto. |
| 67 | ¿Cómo asegura pruebas de cumplimiento (ej. GDPR)? | Validar anonimización de datos, flujos de consentimiento de usuario y logs de auditoría. |
| 68 | ¿Cómo prueba resistencia de APIs bajo carga? | Aumentar paralelismo gradualmente, medir latencia y monitorear umbrales de error. |
| 69 | ¿Cómo maneja benchmarks de rendimiento fallidos? | Perfilando componentes, optimizando consultas, cachés seguros y re-pruebas iterativas. |
| 70 | ¿Cómo asegura entornos de prueba? | Aislamiento de producción, anonimización de datos y cumplimiento de controles de acceso. |
| 71 | ¿Cómo gestiona regresiones de seguridad? | Integrar escaneos (SAST, DAST) en CI/CD; análisis de tendencias y triaje por severidad. |
| 72 | ¿Cómo prueba robustez de cifrado? | Verificar algoritmos, rotación de claves y políticas seguras de gestión. |
| 73 | ¿Qué es Fuzz Testing? | Enviar datos aleatorios/inválidos para probar robustez y manejo de excepciones. |
| 74 | ¿Cómo reduce falsos positivos en escaneos de seguridad? | Ajustando reglas de escaneo y validación manual antes de evaluar riesgo. |
| 75 | ¿Cómo prueba tiempos de espera (timeouts) de sesión? | Simular inactividad y verificar que la terminación cumpla políticas. |
| 76 | ¿Qué frameworks de seguridad sigue? | OWASP Top 10, NIST 800-53, CIS Benchmarks. |
| 77 | ¿Cómo asegura preparación para auditorías? | Manteniendo artefactos de prueba trazables, protocolos de evidencia e informes repetibles. |
| 78 | Plan para pruebas no funcionales en Sprints. | Definir historias NFR, pruebas de sanidad livianas en cada sprint, suite completa antes de releases grandes. |
| 79 | ¿Cómo trabaja con InfoSec? | Compartiendo evidencia de pruebas, alineando priorización de riesgos y responsabilidad compartida en SLAs de corrección. |
| 80 | ¿Cómo mantiene actualizada la documentación de cumplimiento? | Automatizando generación de evidencia y vinculando con controles en Power BI o Confluence. |

---

## Liderazgo y Gestión (81–100)

| # | Pregunta | Respuesta Propuesta |
|---|---|---|
| 81 | ¿Cómo mide el desempeño del equipo QA? | Predictibilidad de entrega, mejora de cobertura y reducción de riesgo comercial. |
| 82 | ¿Qué hace exitoso a un Test Manager? | Visión, comunicación, competencia en riesgos y adaptabilidad de procesos. |
| 83 | ¿Cómo motiva a los testers? | Reconociendo contribuciones, seguimiento de logros, crecimiento de habilidades y rotación de tareas desafiantes. |
| 84 | ¿Cómo mejora precisión de estimaciones? | Análisis de datos históricos, estimación basada en historias, búfer para imprevistos. |
| 85 | ¿Cómo alinea OKRs de QA con metas de empresa? | Mapeo a métricas estratégicas como estabilidad de releases y satisfacción del cliente. |
| 86 | ¿Cómo mentoriza a un QA junior? | Acompañando en planificación, fomentando autonomía y dando feedback detallado en diseño de pruebas. |
| 87 | ¿Cómo resuelve conflictos QA-Desarrollo? | Fomentando discusiones basadas en datos, foco en impacto en lugar de culpas. |
| 88 | ¿Cómo integra a nuevos miembros? | Plan estructurado de 30-60-90 días cubriendo herramientas, flujos y cultura. |
| 89 | ¿Cómo maneja prioridades cambiantes? | Repriorización transparente del backlog y escalación temprana. |
| 90 | ¿Cómo reporta impacto de QA a ejecutivos? | Dashboard semanal que conecta métricas con KPIs de negocio y perfil de riesgo. |
| 91 | ¿Cómo escala QA con el crecimiento? | Mentalidad Automation-First, estandarización de frameworks y transferencia de responsabilidad. |
| 92 | ¿Cómo asegura consistencia en equipos distribuidos? | Plantillas de gobernanza, dashboards compartidos y syncs de calidad regulares. |
| 93 | ¿Cómo evalúa madurez de QA en un proyecto? | Evaluación de cobertura, automatización, métricas y alineación de procesos. |
| 94 | ¿Qué herramientas usa para visualizar métricas? | Power BI, Grafana y Azure Dashboards. |
| 95 | ¿Cómo comunica malas noticias efectivamente? | Reporte neutral orientado al impacto, proponiendo escenarios de mitigación. |
| 96 | ¿Cómo controla costos en pruebas? | Optimizando entornos, uso de escalado en nube y evitando esfuerzos redundantes. |
| 97 | ¿Cómo asegura continuidad ante rotación de personal? | Capacitación cruzada, documentación de procesos y respaldo de scripts/versiones. |
| 98 | ¿Cómo balancea innovación vs. estandarización? | Estandarizar procesos clave, permitir innovación en herramientas/métodos según contexto. |
| 99 | ¿Cómo se prepara para evaluaciones desempeño? | Usando datos empíricos (métricas, iniciativas, resultados) para mostrar impacto mesurable. |
| 100 | ¿Cuál es su filosofía sobre calidad? | La calidad es responsabilidad de todos, guiada por visibilidad, automatización y aprendizaje continuo. |
