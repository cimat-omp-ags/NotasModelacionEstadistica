# Modelación Estadística — Notas del Curso

<div align="center">

![Logo CIMAT](imagenes/logo-cimat.png)

**Maestría en Optimización y Modelación de Procesos**  
Centro de Investigación en Matemáticas, A.C. — Unidad Aguascalientes

[![Publicar libro](https://github.com/mop-cimat-ags/NotasModelacionEstadistica/actions/workflows/publish.yml/badge.svg)](https://github.com/mop-cimat-ags/NotasModelacionEstadistica/actions/workflows/publish.yml)
[![Libro en línea](https://img.shields.io/badge/Libro-En%20l%C3%ADnea-7B2837)](https://mop-cimat-ags.github.io/NotasModelacionEstadistica)

</div>

---

## Descripción

Notas del curso **Modelación Estadística** de la Maestría OMP del CIMAT Aguascalientes, publicadas como libro interactivo con [Quarto](https://quarto.org). El libro está disponible en dos formatos:

- **HTML** (libro en línea): https://mop-cimat-ags.github.io/NotasModelacionEstadistica
- **PDF**: descargable desde la página de inicio del libro

---

## Catedráticos colaboradores

| Nombre | Correo |
|---|---|
| Dr. Sergio M. Nava Muñoz | nava@cimat.mx |
| Dr. Magín Zúñiga Estrada | magin.zuniga@cimat.mx |
| Dr. Humberto Martínez Bautista | humberto.martinez@cimat.mx |

**Compilación y edición del repositorio:** Vladimir Jiménez Pérez — vladimir.jimenez@cimat.mx

---

## Contenido del libro

### Parte I — Probabilidad, Variables Aleatorias y Distribuciones Muestrales

| Archivo | Tema |
|---|---|
| `cap01a-estadistica.qmd` | Estadística Descriptiva |
| `cap01b-probabilidad.qmd` | Introducción a la Probabilidad |
| `cap03-distribuciones.qmd` | Distribuciones de Probabilidad (discretas y continuas) |
| `cap04-conjunta.qmd` | Distribución Conjunta y Esperanza |
| `cap05-inferencia.qmd` | Introducción a la Inferencia Estadística |

### Parte II — Aplicaciones con Datos Reales

| Archivo | Tema |
|---|---|
| `cap05-casas.qmd` | Análisis de Regresión Lineal — Dataset Casas |
| `cap06-autos.qmd` | Análisis Exploratorio — Dataset Autos |
| `cap07-laringoscopia.qmd` | Caso de estudio clínico — Laringoscopia en obesidad mórbida |

### Apéndices

| Archivo | Contenido |
|---|---|
| `apendice-distribuciones.qmd` | Tabla de referencia de distribuciones de probabilidad |

---

## Estructura del proyecto

```
NotasModelacionEstadistica/
│
├── _quarto.yml                  # Configuración principal del libro
├── index.qmd                    # Página de inicio del libro
├── referencias.qmd              # Capítulo de bibliografía
├── referencias.bib              # Referencias BibTeX
├── estilos-cimat.css            # Estilos visuales (HTML)
├── GUIA_COLABORADORES.md        # Guía para catedráticos colaboradores
├── GUIA_COLABORADORES.pdf       # Guía en PDF
│
├── imagenes/
│   └── logo-cimat.png
│
├── latex/                       # Archivos para el formato PDF
│   ├── preamble.tex             # Preámbulo LaTeX (colores, macros, teoremas)
│   ├── portada.tex              # Portada del PDF
│   └── theorem-boxes.tex        # Cajas de color para teoremas
│
├── capitulos/
│   ├── parte1/                  # Parte I — Probabilidad y Distribuciones
│   │   ├── cap01a-estadistica.qmd
│   │   ├── cap01b-probabilidad.qmd
│   │   ├── cap03-distribuciones.qmd
│   │   ├── cap04-conjunta.qmd
│   │   └── cap05-inferencia.qmd
│   ├── parte2/                  # Parte II — Aplicaciones con Datos Reales
│   │   ├── cap05-casas.qmd
│   │   ├── cap06-autos.qmd
│   │   └── cap07-laringoscopia.qmd
│   └── apendice-distribuciones.qmd
│
├── libreria/                    # Paquete R: modelEstCIMAT
│   ├── DESCRIPTION
│   ├── NAMESPACE
│   ├── R/
│   │   ├── estadisticas.R       # Funciones descriptivas
│   │   ├── inferencia.R         # IC, pruebas de hipótesis, EMV
│   │   ├── simulacion.R         # Bootstrap, Monte Carlo
│   │   └── datos.R              # Documentación de datasets
│   ├── data/                    # Datasets compilados (.rda)
│   └── data-raw/
│       └── generar_datos.R      # Script para generar los datasets
│
├── ReporteFinal/                # Reporte de estancia (RMarkdown + LaTeX)
│   └── reporte_estancia_vladimir.Rmd
│
└── .github/workflows/
    └── publish.yml              # CI/CD — publica automáticamente en Pages
```

---

## Inicio rápido

### 1. Clonar el repositorio

```bash
git clone https://github.com/mop-cimat-ags/NotasModelacionEstadistica.git
cd NotasModelacionEstadistica
```

### 2. Instalar paquetes de R necesarios

```r
install.packages(c(
  "knitr", "rmarkdown", "devtools",
  "ggplot2", "dplyr", "tidyr", "forcats",
  "kableExtra", "gtsummary", "survival",
  "MASS", "car", "corrplot",
  "smd", "medicaldata", "broom"
), repos = "https://cloud.r-project.org")
```

### 3. Previsualizar el libro (HTML)

```bash
quarto preview
```

El libro se abre en `http://localhost:4848`. Cada archivo guardado actualiza la vista automáticamente.

### 4. Renderizar todos los formatos

```bash
quarto render
```

El resultado queda en `_book/` (HTML) y `_book/Modelacion-Estadistica.pdf`.

### 5. Renderizar un solo capítulo

```bash
quarto render capitulos/parte1/cap03-distribuciones.qmd
```

---

## Librería R: modelEstCIMAT

El proyecto incluye un paquete de R con funciones y datasets de apoyo para los capítulos del curso. Se carga sin necesidad de instalación:

```r
devtools::load_all("libreria")
```

### Funciones disponibles

```r
# Estadística descriptiva
resumen_estadistico(x)
tabla_frecuencias(x, k = 6)
curtosis(x)
asimetria(x)
coef_variacion(x)

# Inferencia
ic_media(x, nivel = 0.95)
ic_proporcion(x = 30, n = 100)
ic_varianza(x)
prueba_z(x, mu0 = 0, sigma = 1, alternativa = "bilateral")
emv_normal(x)
emv_exponencial(x)
emv_poisson(x)

# Simulación y gráficas
simular_distribucion("normal", n = 500, mean = 0, sd = 1)
simular_bootstrap(x, FUN = mean, B = 1000)
monte_carlo_integral(function(x) x^2, a = 0, b = 1)
graficar_densidad("t", df = 10, cola = "bilateral", alpha = 0.05)
```

### Datasets disponibles

```r
data(alturas_estudiantes)   # n = 80  — altura y peso de estudiantes
data(tiempos_falla)         # n = 60  — tiempos de falla (Exponencial)
data(calificaciones_curso)  # n = 35  — tres exámenes correlacionados
data(conteos_defectos)      # n = 50  — defectos por lote (Poisson)
data(temperaturas_mensual)  # n = 365 — temperaturas diarias Guanajuato
```

---

## Publicación automática

Cada `git push` a la rama `main` dispara GitHub Actions que:

1. Instala R, Quarto y dependencias del sistema
2. Renderiza el libro en HTML y PDF
3. Publica el HTML en GitHub Pages automáticamente en 2–3 minutos

Estado del último build: ver badge al inicio.  
Logs: https://github.com/mop-cimat-ags/NotasModelacionEstadistica/actions

---

## Cómo colaborar

Consulta la **[Guía para Colaboradores](GUIA_COLABORADORES.md)** (también disponible en [PDF](GUIA_COLABORADORES.pdf)), que cubre:

- Instalación de R, Quarto, Git y VS Code / RStudio
- Configurar Git y autenticarse en GitHub
- Clonar el repositorio y abrirlo en RStudio o VS Code
- Editar y crear capítulos en Quarto (`.qmd`)
- Sintaxis: ecuaciones, código R, figuras, teoremas, citas
- Agregar funciones y datasets a la librería `modelEstCIMAT`
- Flujo de trabajo con Git: Pull → editar → Commit → Push
- Trabajo con ramas (branches) y Pull Requests
- Resolución de conflictos

---

## Requisitos

| Herramienta | Versión mínima | Descarga |
|---|---|---|
| R | 4.1 | https://cran.r-project.org |
| Quarto | 1.4 | https://quarto.org/docs/get-started |
| Git | cualquiera | https://git-scm.com/download/win |
| RStudio (opcional) | 2023.x | https://posit.co/download/rstudio-desktop |
| TinyTeX (para PDF) | — | se instala automáticamente con Quarto |

---

## Licencia

MIT © Dr. Sergio M. Nava Muñoz, Dr. Magín Zúñiga Estrada, Dr. Humberto Martínez Bautista — Maestría OMP, CIMAT Unidad Aguascalientes
