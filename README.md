[![version](https://img.shields.io/badge/version-1.0.0-blue)](https://github.com/ibarram/ProcesosEstocasticos/)
[![GitHub commit activity (branch)](https://img.shields.io/github/commit-activity/w/ibarram/ProcesosEstocasticos)](https://github.com/ibarram/ProcesosEstocasticos/)
[![GitHub discussions](https://img.shields.io/github/discussions/ibarram/ProcesosEstocasticos)](https://github.com/ibarram/ProcesosEstocasticos/discussions)
[![GitHub issues](https://img.shields.io/github/issues/ibarram/ProcesosEstocasticos)](https://github.com/ibarram/ProcesosEstocasticos/issues)
![Programming Languages](https://img.shields.io/badge/MATLAB-0076A8?logo=mathworks&logoColor=white)
![Programming Languages](https://img.shields.io/badge/R-276DC3?logo=r&logoColor=white)
![Programming Languages](https://img.shields.io/badge/C-00599C?logo=c&logoColor=white)
![GitHub License](https://img.shields.io/github/license/ibarram/ProcesosEstocasticos)

<br />
<div align="center">
  <a href="https://github.com/ibarram/ProcesosEstocasticos/">
    <img src="doc/img/UG_DICIS.png" alt="Logo" width="276" height="235">
  </a>

  <h3 align="center">Procesos Estocásticos (GE03.04)</h3>

  <p align="center">
    Doctorado en Ingeniería Eléctrica <br />
    División de Ingenierías, Campus Irapuato-Salamanca <br />
    Universidad de Guanajuato <br />
    <a href="https://github.com/ibarram/ProcesosEstocasticos"><strong>Explorar la documentación »</strong></a>
    <br />
    <br />
    <a href="https://github.com/ibarram/ProcesosEstocasticos">Ver Demo</a>
    ·
    <a href="https://github.co m/ibarram/ProcesosEstocasticos/issues">Reportar Bug</a>
    ·
    <a href="https://github.com/ibarram/ProcesosEstocasticos/issues">Requiere Modificaciones</a>
  </p>
</div>

<details><summary>Tabla de contenidos</summary><p>

- [Introducción](#introducción)
- [Datos generales](#datos-generales)
- [Competencia de la UDA](#competencia-de-la-uda)
- [Contenido](#contenido)
- [Entregas y evaluación](#entregas-y-evaluación)
  - [Portafolio de evidencias](#portafolio-de-evidencias)
  - [Exámenes parciales](#exámenes-parciales)
  - [Examen final](#examen-final)
  - [Proyecto integrador](#proyecto-integrador)
  - [Elementos mínimos de los reportes](#elementos-mínimos-de-los-reportes)
- [Repositorio y plataformas](#repositorio-y-plataformas)
- [Entornos de cómputo](#entornos-de-cómputo)
- [Documentación del código (Doxygen)](#documentación-del-código-doxygen)
- [Estructura sugerida del repositorio](#estructura-sugerida-del-repositorio)
- [Código de ética y conducta profesional](#código-de-ética-y-conducta-profesional)
- [Bibliografía](#bibliografía)
- [Contacto](#contacto)
- [Licencia](#licencia)

</p></details>

## Introducción

Esta Unidad de Aprendizaje (UDA) es una materia disciplinaria del **Área Básica** del Doctorado en Ingeniería Eléctrica (clave GE03.04). Desarrolla las bases matemáticas y computacionales para modelar, analizar y simular sistemas gobernados por la aleatoriedad, con énfasis en:

- Fundamentos de probabilidad y variables aleatorias,
- Caracterización estadística de procesos estocásticos,
- Análisis espectral y respuesta de sistemas lineales,
- Simulación numérica en **MATLAB**, **R** y **C**.

> Nota: Este repositorio concentra materiales, código, guías y entregables de la UDA.

## Datos generales

- **UDA:** Procesos Estocásticos
- **Clave:** GE03.04
- **Programa:** Doctorado en Ingeniería Eléctrica
- **Créditos:** 4 (100 horas totales: 42 con profesor + 58 autónomas)
- **Horas semana/cuatrimestre:** 4
- **Prerrequisito normativo:** Ninguno
- **Prerrequisito recomendable:** Métodos Matemáticos (GE01.04)
- **Imparte:** Dr. Mario Alberto Ibarra Manzano

## Competencia de la UDA

**Capacidad para la resolución de los problemas matemáticos que puedan plantearse en la Ingeniería; así como aptitud para el estudio de la modelización de fenómenos aleatorios; aplicando correctamente los resultados obtenidos a la resolución de problemas de naturaleza estocástica.**

## Contenido

El [temario](/doc/slide/0_Introduccion.pdf) se organiza en los siguientes ejes temáticos:

1. [**Conceptos básicos de la teoría de la probabilidad**](doc/slide/1_Conceptos.pdf)
   - Experimentos aleatorios, espacio muestral y axiomas
   - Probabilidad condicional, independencia, Bayes
   - Análisis combinatorio e interpretaciones de la probabilidad

2. **Variables aleatorias**
   - Función de distribución acumulada y función de densidad (o masa)
   - Esperanza, varianza, momentos y función generadora de momentos
   - Distribuciones discretas: Bernoulli, Binomial, Poisson, Geométrica
   - Distribuciones continuas: Uniforme, Exponencial, Gaussiana
   - Transformación de variables aleatorias

3. **Variables aleatorias múltiples**
   - Variable aleatoria bidimensional: distribuciones conjuntas, marginales y condicionales
   - Esperanzas conjuntas, covarianza y coeficiente de correlación
   - Vector aleatorio gaussiano y matriz de covarianza

4. **Sumas de variables aleatorias**
   - Esperanza y varianza de sumas; convolución y funciones características
   - Ley de los grandes números (débil y fuerte)
   - Teorema del límite central e introducción al método de Monte Carlo

5. **Procesos aleatorios**
   - Definición, clasificación y caracterización estadística
   - Estacionariedad (WSS) y ergodicidad
   - Procesos gaussianos, ruido blanco y ruido coloreado
   - Procesos de Markov y de Poisson

6. **Análisis y procesamiento de señales aleatorias**
   - Funciones de correlación y covarianza de señales aleatorias
   - Operaciones sobre señales aleatorias; introducción al filtrado

7. **Respuesta de sistemas lineales con entradas estocásticas**
   - Relaciones entrada-salida para la media y la autocorrelación
   - Densidad espectral de potencia; planteamiento del filtro de Wiener

8. **Análisis espectral y aplicaciones**
   - Densidad espectral de potencia y teorema de Wiener-Khinchin
   - Estimación espectral: métodos paramétricos (AR, MA, ARMA) y no paramétricos (periodograma)
   - Estudio de caso integrador: modelado y simulación de un proceso estocástico aplicado

## Entregas y evaluación

### Ponderaciones

| Componente | Descripción | Porcentaje |
|---|---|---:|
| Portafolio de evidencias electrónico | Problemas, tareas y reportes de cómputo en MATLAB y R | 15 % |
| Exámenes parciales | Dos exámenes escritos sobre fundamentos teóricos | 25 % |
| Examen final | Examen escrito integrador de la UDA | 30 % |
| Proyecto integrador | Modelado y simulación en MATLAB, R o C; reporte y presentación | 30 % |
| **Total** | | **100 %** |

### Portafolio de evidencias

- **Entrega por correo:** `mibarram@ugto.mx`
- **Asunto:** `PE_20262_PE_NUA_Apellidos`
- **Formato:** reporte **PDF** con desarrollo teórico, código y resultados
- **Restricción:** **no** entregar ejecutables; **solo** código fuente y reporte
- **Fecha de entrega:** 1 semana a partir de la asignación

### Exámenes parciales

- Dos evaluaciones escritas distribuidas a lo largo del cuatrimestre
- Cubren los fundamentos teóricos de los temas 1–4 (primer parcial) y 5–7 (segundo parcial)

### Examen final

- Evaluación escrita integradora que cubre la totalidad del temario

### Proyecto integrador

- **Entrega por correo:** `mibarram@ugto.mx`
- **Asunto:** `PE_20262_Py##_NUA Apellidos`
- **Lenguajes preferentes:** MATLAB, R y C
- **Entregables:**
  - Reporte **PDF** (introducción, desarrollo, resultados, análisis y conclusiones)
  - **Código fuente** comentado
  - **Presentación oral** con sesión de preguntas y respuestas

### Elementos mínimos de los reportes

1. **Introducción**
2. **Objetivos**
3. **Marco teórico**
4. **Procedimiento (Algoritmo + descripción del modelo)**
5. **Resultados y análisis**
6. **Tablas y figuras comparativas** (cuando aplique)
7. **Conclusiones**
8. **Bibliografía**

## Repositorio y plataformas

- **Repositorio oficial (GitHub):** https://github.com/ibarram/ProcesosEstocasticos/

Plataformas de práctica recomendadas:
- MATLAB Online, GNU Octave, RStudio, Google Colab (R/Python)

## Entornos de cómputo

En esta UDA se trabajará preferentemente con **MATLAB**, **R** y **C**. A continuación se indican los pasos básicos de verificación para cada entorno.

### MATLAB / GNU Octave

```matlab
% Verificar versión
version

% Ejemplo mínimo: generar muestras gaussianas
mu = 0; sigma = 1;
x = mu + sigma * randn(1000, 1);
histogram(x, 30);
title('Distribución Gaussiana');
```

### R

```r
# Verificar versión
R.version.string

# Ejemplo mínimo: generar muestras gaussianas
x <- rnorm(1000, mean = 0, sd = 1)
hist(x, breaks = 30, main = "Distribución Gaussiana", xlab = "x")
```

### C (con soporte matemático)

```bash
# Compilar con biblioteca matemática
gcc simulacion.c -o simulacion -lm

# Ejecutar
./simulacion
```

> Si se requieren bibliotecas adicionales (GSL, FFTW), se especificarán en la práctica correspondiente.

## Documentación del código (Doxygen)

Este repositorio incluye ejemplos documentados con comentarios estilo **Doxygen**.

### Requisitos

- **Doxygen**
- **Graphviz** (recomendado para grafos de llamadas)

Instalación típica:

- **Ubuntu/Debian:** `sudo apt-get install doxygen graphviz`
- **macOS (Homebrew):** `brew install doxygen graphviz`
- **openSUSE:** `sudo zypper install doxygen graphviz`

### Generar documentación

```bash
make docs
make docs-pdf
```

## Estructura sugerida del repositorio

```
.
├─ doc/
│  ├─ pdf/          # Temario, carta descriptiva, guías
│  ├─ slide/        # Presentaciones (PDF)
│  ├─ img/          # Imágenes (escudo, figuras)
│  └─ markdown/     # Notas y guías (Markdown)
├─ src/
│  ├─ matlab/       # Scripts y funciones en MATLAB/Octave
│  ├─ R/            # Scripts en R
│  ├─ C/            # Programas en C
│  └─ templates/    # Plantillas de reporte
├─ data/            # Archivos de entrada/salida y datos de ejemplo
└─ LICENSE
```

## Código de ética y conducta profesional

- El código debe ser **original** y debidamente **referenciado**.
- Se penaliza el **plagio** (copiar sin atribución) y la **suplantación**.
- Se fomenta la colaboración cuando esté permitida, respetando las reglas de autoría.
- El uso de herramientas de apoyo (incluida IA) debe reflejarse con **transparencia** en el reporte: qué se usó y cómo.

## Bibliografía

- Papoulis, A. y Pillai, S. U. (2002). *Probability, Random Variables and Stochastic Processes* (4.ª ed.). McGraw-Hill.
- Stark, H. y Woods, J. W. (2002). *Probability and Random Processes with Applications to Signal Processing* (3.ª ed.). Prentice-Hall.
- Leon-Garcia, A. (1994). *Probability and Random Processes for Electrical Engineering*. Addison-Wesley.
- Yates, R. D. y Goodman, D. J. (2004). *Probability and Stochastic Processes*. John Wiley & Sons.
- Hsu, H. (2014). *Schaum's Outline of Probability, Random Variables, and Random Processes* (3.ª ed.). McGraw-Hill.
- Hajek, B. (2015). *Random Processes for Engineers*. Cambridge University Press.
- Ibarra-Manzano, M. A. (2026). *ProcesosEstocasticos* [Código fuente]. GitHub. https://github.com/ibarram/ProcesosEstocasticos/

## Contacto

[Dr. Mario Alberto Ibarra Manzano](mailto:mibarram@ugto.mx?subject=[GitHub]%20ProcesosEstocasticos) — [DICIS-UG](http://www.posgrados.ugto.mx/) — [ORCID: 0000-0003-4317-0248](https://orcid.org/0000-0003-4317-0248)

Unidad de Aprendizaje: [Procesos Estocásticos GE03.04](https://github.com/ibarram/ProcesosEstocasticos/)

## Licencia

Este repositorio se distribuye bajo **GNU General Public License v3.0**. Consulta el archivo `LICENSE`.