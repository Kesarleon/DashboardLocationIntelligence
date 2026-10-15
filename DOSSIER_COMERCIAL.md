# DOSSIER COMERCIAL: PLATAFORMA DE INTELIGENCIA GEOANALÍTICA Y PREDICCIÓN DE DEMANDA EN SALUD

---

## 1. RESUMEN EJECUTIVO

En un mercado altamente competitivo, la expansión de una **cadena nacional de laboratorios clínicos y centros de diagnóstico** requiere decisiones fundamentadas en datos geográficos y predictivos de alta precisión. La **Plataforma de Inteligencia Geoanalítica** es una solución tecnológica integral diseñada para optimizar la toma de decisiones estratégicas en selección de sitios (*site selection*), dimensionamiento de oferta médica y estimación del potencial de mercado a nivel localidad.

A través de la integración de **geolocalización avanzada, datos oficiales de infraestructura económica (INEGI DENUE) y modelos algorítmicos de predicción de demanda**, la herramienta transforma la planificación territorial en un proceso ágil, visual y estadísticamente riguroso.

---

## 2. PROPUESTA DE VALOR COMERCIAL

* **Maximización del Retorno de Inversión (ROI) en CAPEX:** Minimiza el riesgo financiero al aperturar nuevas unidades, validando la demanda potencial antes de realizar inversiones en infraestructura o equipamiento médico de alto costo.
* **Identificación de Oportunidades de Mercado (*White Spaces*):** Detecta zonas geográficas con alta demanda proyectada y baja presencia competitiva.
* **Comprensión Completa del Ecosistema de Salud:** Analiza en tiempo real la concentración de consultorios médicos, clínicas, hospitales y competidores directos en radios de influencia configurables.
* **Agilidad para Comités de Expansión:** Genera proyecciones inmediatas y exportables en formatos ejecutivos (Excel, PDF, CSV) para acelerar la aprobación de proyectos de inversión.

---

## 3. DESGLOSE DE COMPONENTES Y VALOR ESTRATÉGICO POR SECCIÓN

### 3.1. Panel de Selección y Filtros Territoriales

**Descripción Funcional:**
Ubicado en la barra lateral interactiva, permite definir el alcance geográfico de análisis, el portafolio de estudios a evaluar, el radio de cobertura operativa y los actores del entorno competitivo/médico a monitorear.

**Valor Comercial:**
* **Segmentación Granular:** Filtra de forma jerárquica por Estado, Municipio y Localidad, adaptándose a estrategias de expansión nacional, regional o local.
* **Definición de Áreas de Captación (*Catchment Areas*):** Ajuste fino del radio de influencia (desde 100 metros hasta 5,000 metros) alrededor de los centroides de población para simular tiempos de traslado y zonas de cobertura peatonal o vehicular de los pacientes.
* **Personalización del Entorno de Competencia:** Permite seleccionar y categorizar tipos de negocios relevantes (Consultorios de medicina, Clínicas, Hospitales, Laboratorios competidores, Ópticas, Farmacias u otros giros personalizados mediante consulta dinámica a INEGI).

---

### 3.2. Módulo de Inteligencia Geoespacial Visiva (Mapa Interactivo)

**Descripción Funcional:**
Visualizador cartográfico interactivo basado en la tecnología Leaflet que integra centroides de población, radios de cobertura y la ubicación exacta de negocios o competidores consultados en tiempo real mediante la API del DENUE (INEGI).

**Valor Comercial:**
* **Análisis de Densidad Competitiva:** Muestra la distribución geográfica exacta de competidores y médicos referenciadores dentro del radio de influencia definido.
* **Leyendas y Capas Dinámicas:** Agrupa y diferencia visualmente los giros de negocio con simbología de colores profesional, permitiendo encender/apagar capas para evaluaciones focalizadas.
* **Detección de Médicos Prescriptores:** Facilita la identificación de clusters de consultorios independientes o clínicas en la zona que actúan como principal fuente de referencia de estudios de laboratorio e imagenología.

---

### 3.3. Módulo Predictivo de Demanda (Modelos Geoanalíticos)

**Descripción Funcional:**
Matriz analítica de proyecciones que calcula el volumen promedio esperado de estudios mensuales por localidad y tipo de prueba diagnóstica, impulsada por modelos estadísticos previamente ajustados (`.rds`).

**Portafolio de Estudios Soportado:**
1. **Laboratorio Clínico**
2. **Mastografía**
3. **Rayos X**
4. **Ultrasonido General**
5. **Ultrasonido 4D**
6. **Tomografía**
7. **Resonancia Magnética**
8. **Electrocardiograma**
9. **Densitometría Ósea**
10. **Papanicolaou**
11. **Optometría**

**Valor Comercial:**
* **Estimación de Capacidad Instalada y Equipamiento:** Proporciona proyecciones cuantificables por tipo de estudio para decidir qué equipamiento instalar en cada sucursal (ej. si una localidad justifica un Tomógrafo o solo equipo de Laboratorio y Rayos X).
* **Barras de Rendimiento Visual:** Incluye formato condicional con barras de contraste de volumen que facilitan la comparación rápida entre distintas localidades analizadas.
* **Exportación Directa:** Descarga de tablas consolidadas en CSV, Excel o PDF lista para integrar en planes de negocio y presentaciones ejecutivas.

---

## 4. CASOS DE USO ESTRATÉGICOS PARA UNA CADENA NACIONAL DE LABORATORIOS

### Caso 1: Validación de Ubicación para Nuevas Sucursales (*Site Selection*)
* **Reto:** Decidir entre dos o más terrenos/locales candidatos dentro de un municipio.
* **Solución:** La herramienta evalúa el radio de alcance de cada alternativa, contabiliza los consultorios médicos prescriptores en los alrededores y calcula la demanda mensual proyectada.
* **Resultado:** Elección del sitio con mayor potencial de captura de pacientes y menor saturación competitiva.

### Caso 2: Definición del Portafolio de Servicios por Sucursal (*Service Mix Optimization*)
* **Reto:** Evitar el sobrecosto de instalar portafolios completos en sucursales donde la demanda de ciertos estudios especializados es baja.
* **Solución:** El modelo proyecta la demanda específica por tipo de examen (ej. Resonancia vs. Laboratorio rutinario) para la localidad.
* **Resultado:** Configuración eficiente de sucursales (ej. Sucursal Tipo A con Imagenología Completa vs. Sucursal Tipo B solo Toma de Muestras).

### Caso 3: Estrategia de Medios y Fuerza de Ventas Médico-Comercial
* **Reto:** Optimizar las rutas de los representantes médicos que visitan a profesionales de la salud para promover los servicios del laboratorio.
* **Solución:** Visualización cartográfica exacta de todos los consultorios médicos y clínicas dentro de la zona de influencia de la sucursal.
* **Resultado:** Ruteo eficiente y prospección dirigida a zonas con alta concentración de médicos generales y especialistas.

### Caso 4: Planificación de Campañas Preventivas y Marketing Localizado
* **Reto:** Diseñar campañas de salud focalizadas con alto impacto en ventas (ej. Mastografías en Mes Rosa, Densitometría en adultos mayores).
* **Solución:** Identificación de localidades con alto volumen proyectado para estudios específicos.
* **Resultado:** Asignación inteligente del presupuesto de marketing digital y campo en geofrenos específicos.

---

## 5. RESUMEN TÉCNICO Y ARQUITECTURA DE DATOS

* **Plataforma:** Desarrollada en R con framework Shiny para un desempeño interactivo y reactivo de alta velocidad.
* **Motor Geoespacial:** Paquetes `leaflet`, `rgdal`, `rgeos` y capas cartográficas vectoriales en formato Shapefile (`.rds`).
* **Integración de Datos de Terceros:** Conexión vía API REST directa con el **DENUE (Directorios de Unidades Económicas de INEGI)** para información actualizada de establecimientos.
* **Modelos de Aprendizaje Estadístico:** Algoritmos multivariados ajustados por género, demografía y variables territoriales para predecir volúmenes esperados de atención mensual.

---

*Documento preparado como dossier descriptivo y comercial de la solución geoanalítica.*
