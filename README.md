# [SQL] Proyecto de creación de una base de datos, con triggers y consultas ejemplo

**Autor:** @Calotriton
**Descripción:** Proyecto de base de datos para la gestión de eventos culturales

## Tabla de contenidos
- [Descripción del Proyecto](#descripción-del-proyecto)
- [Estructura de la Base de Datos](#estructura-de-la-base-de-datos)
- [Requisitos](#requisitos)
- [Instrucciones de Uso](#instrucciones-de-uso)
- [Consultas de Ejemplo](#consultas-de-ejemplo)
- [Triggers](#triggers)
- [Inserciones de Datos](#inserciones-de-datos)


## Descripción del Proyecto

Este proyecto consiste en la creación de una base de datos relacional para gestionar información sobre eventos culturales organizados por ArteVida Cultural. La base de datos almacena información sobre actividades, artistas, ubicaciones, eventos y asistentes, y permite realizar consultas para analizar y gestionar estos elementos.

## Estructura de la Base de Datos

La base de datos `ArteVida` contiene las siguientes tablas:

- **ACTIVIDAD:** Almacena las actividades culturales y su costo total.
- **ARTISTA:** Contiene información sobre los artistas, incluyendo su biografía y caché.
- **UBICACION:** Define los lugares donde se realizan los eventos.
- **EVENTO:** Almacena los eventos programados, vinculando actividades con ubicaciones.
- **ASISTENTE:** Contiene los datos personales de los asistentes.
- **ASISTE:** Tabla de relación para gestionar la asistencia de los asistentes a los eventos.

## Requisitos

- MySQL o un sistema compatible con SQL.
- Conexión a una interfaz SQL, como MySQL Workbench, para ejecutar el código y realizar consultas.

## Instrucciones de Uso

1. Clona este repositorio o descarga los archivos del proyecto.
2. Abre tu interfaz SQL y carga el archivo SQL del proyecto.
3. Ejecuta el script completo para crear y poblar la base de datos `ArteVida`.
   ```sql
   DROP DATABASE IF EXISTS ArteVida;
   CREATE DATABASE ArteVida;
   USE ArteVida;
