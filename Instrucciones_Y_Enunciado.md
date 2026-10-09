# 🏛️ Taller de Base de Datos Diurno (2-2026)
---
## Control 1 — Grupo 2: Base de Datos de Galerías de Arte

**Universidad de Santiago de Chile (USACH)**  
*Facultad de Ingeniería — Departamento de Ingeniería Informática*  
* **Profesor:** Matías Calderón  
* **Ayudantes:** Pablo Macuada, Fernando Solís Paz  
* **Integrantes:** Cristobal Godoy, Zhi Lu, Ándres Ordoñez, Jesús Torres, Nicolás Valdés.
---
## 1. Instrucciones Generales y Actividades
---
1. **Establecer las relaciones de las tablas:**   Definir claves primarias ($PK$), foráneas ($FK$) y cardinalidades basadas en el modelo base. Si desean refinar o normalizar el modelo pueden hacerlo, siempre y cuando la estructura resultante sea capaz de responder satisfactoriamente a todas las sentencias SQL solicitadas.

2. **Crear un repositorio de GitHub:** Debe contener toda la documentación y los scripts estandarizados descritos más abajo.

3. **Ejecutar y validar los scripts:** La solución debe ser verificable mediante una de las siguientes dos vías:

	- **Opción A (CLI):** Secuencia documentada de comandos por consola para ejecutar en orden la creación de tablas, la carga de datos y las consultas.
	
	- **Opción B (Video):** Grabación breve (máximo 5 minutos) sin formalidades, mostrando la ejecución secuencial de los tres scripts.
	
   >[!IMPORTANT] ⚠️ **IMPORTANTE:** 
   >Debe ser evidente que la solución no solo compila y corre, sino que los datos y resultados son correctos y consistentes.

---

## 2. Estructura del Repositorio de GitHub

El repositorio debe contener la siguiente estructura de archivos y nombres exactos:

```text
📁 repo-control1-grupo2/
│
├── 📄 README.md                 # Documentación general y comandos de ejecución
├── 📄 DER.pdf / DER.png          # Diagrama Entidad-Relación (con justificación de cambios si aplica)
├── 📄 diccionario_datos.md       # Diccionario de datos (tablas, campos, tipos, restricciones)
├── 💾 dbCreate.sql              # Script DDL: Creación de BD, tablas, PKs, FKs y restricciones
├── 💾 loadData.sql              # Script DML: Carga de datos de prueba válidos y representativos
└── 💾 runStatements.sql         # Script con las 10 consultas SQL del Grupo 2 numeradas
```

---

## 3. Modelo Conceptual del Grupo 2

### Entidades Identificadas en el Diagrama:
* `REGION`: Regiones geográficas.
* `COMUNA`: Comunas vinculadas a una región.
* `GALERIA`: Galería de arte (ubicada en una comuna).
* `LOCAL`: Locales o sucursales físicas (asociados a comuna/galería).
* `PRODUCTO`: Obras de arte comercializadas.
* `TIPO`: Categoría del producto (ejemplos explícitos: `'Escultura'`, `'Pintura'`).
* `EMPLEADO`: Personal contratado (con datos demográficos y sueldos).
* `VENDEDOR`: Especialización o rol del empleado vinculado a ventas.
* `CLIENTE`: Compradores de obras (asociados a una comuna).
* `VENTA`: Registro transaccional que relaciona al cliente, vendedor y producto(s).

---

## 4. Consideraciones de Diseño y Atributos Clave

Para que el script `loadData.sql` permita responder con éxito todas las sentencias de `runStatements.sql`, el diseño debe prever los siguientes atributos:

| Entidad / Tabla | Atributos Críticos Deducidos | Justificación según Sentencias |
| :--- | :--- | :--- |
| **`TIPO`** | `nombre_tipo` | Debe contener obligatoriamente `'Escultura'` y `'Pintura'` (Consultas 1, 2, 5, 8). |
| **`PRODUCTO`** | `precio`, `peso_kg` | Se requiere conocer el peso en kilogramos de las obras (Consulta 10) y sus valores unitarios (Consultas 1, 2, 7). |
| **`VENTA`** | `fecha_venta` / `created_at`, `monto_total` | Se requiere filtrar por 2019, 2021, último año y últimos 12 meses (Consultas 1, 2, 4, 5, 7, 8, 10). |
| **`EMPLEADO`** | `genero` (o `sexo`), `sueldo` | Obligatorio para desglosar promedios y cantidades de hombres y mujeres en los últimos 12 meses (Consulta 9). |
| **`COMUNA` / `REGION`** | Nombres reales | Jerarquía territorial requerida en la Consulta 6. |

---

## 5. Consultas SQL Requeridas (Checklist)

 Para verificar el avance de su archivo `runStatements.sql`:

- [ ] **1. Escultura más cara vendida por galería en el último mes.**  
  *Filtro por tipo 'Escultura', ventana de tiempo móvil de 30 días / mes calendario y agregación o partición por galería.*

- [ ] **2. Pintura más económica vendida el año pasado.**  
  *Filtro por tipo 'Pintura', rango de fechas correspondiente al año anterior y búsqueda del precio mínimo.*

- [ ] **3. Vendedor con más ventas por galería.**  
  *Agrupación por galería y vendedor; contabilización de transacciones o suma de ventas para extraer el primer lugar.*

- [ ] **4. Cliente que ha invertido más en arte por año.**  
  *Total de compras por cliente agrupado por año calendario, determinando el cliente líder de cada periodo.*

- [ ] **5. Tipo de arte más vendido por año.**  
  *Conteo o volumen total de ventas agrupado por `TIPO` y por año.*

- [ ] **6. Lista de regiones y sus galerías por comuna.**  
  *Consulta jerárquica uniendo `REGION`, `COMUNA` y `GALERIA`.*

- [ ] **7. Venta más cara por mes, por galería en el 2019.**  
  *Filtro estricto para el año 2019, agrupando o particionando por galería y mes.*

- [ ] **8. Cliente que ha comprado más pinturas entre 2019 y 2021.**  
  *Filtro de fecha (`2019-01-01` a `2021-12-31`) y de tipo `'Pintura'`, agrupado por cliente y ordenado por cantidad.*

- [ ] **9. Promedio de sueldos de hombres y mujeres mensual por galería, en los últimos 12 meses.**  
  *Debe reportar: galería, cantidad de hombres, cantidad de mujeres, sueldo promedio masculino y sueldo promedio femenino.*

- [ ] **10. Venta más pesada en kilogramos por mes en los últimos 12 meses.**  
  *Cálculo del peso total de la venta (suma de kilogramos de sus productos) agrupado por mes en el último año.*

---

## 6. Criterios de Evaluación y Entrega

* **Poblado de datos consistente:** Los datos de `loadData.sql` deben ser suficientes para que ninguna consulta retorne vacía por falta de casos de prueba (incluir ventas en 2019, 2020, 2021 y los últimos 12 meses).
* **Nombres de archivos estrictos:**
  * `dbCreate.sql`
  * `loadData.sql`
  * `runStatements.sql`
* **Plazo límite:** 19 de octubre de 2026, 23:59 hrs.