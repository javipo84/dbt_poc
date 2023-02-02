# PoC dbt - synapse

Prueba de concepto para comprobar el funcionamiento y la forma de trabajo entre dbt y synapse. Puntos a validar:

- Construcción pipeline de transformación de datos
- Calidad del dato
- Orquestación y Monitorización
- Documentación automática
- Linaje
- Versionado
- CI/CD


![image](https://user-images.githubusercontent.com/51535157/216360944-379234a4-8836-4a59-82a8-46f90de0778f.png)



## Configuración Inicial

A continuación se describen los pasos necesarios para instalar y ejecutar este proyecto

### 1 - Python

Descargar e instalar la versión de [Python 3.10.6 64 bits](https://www.python.org/downloads/release/python-3106/)

Una vez instalado python, es recomendable realizar una actualización para asegurarnos de tener las últimas versiones de `pip`y `setuptools`.

```pip
python -m pip install --upgrade pip wheel setuptools
```

### 2 - dbt

Para instalar `dbt-core` y el adaptador para `synapse`, usaremos `pip`.

```pip
pip install dbt-core==1.3.2
pip install dbt-synapse==1.3.0
```

Trabajaremos con estas dos versiones específicas, que son estables. Podemos encontrar más información sobre esta instalación en la web del [adaptador de synapse para dbt](https://docs.getdbt.com/reference/warehouse-setups/azuresynapse-setup)

### 3 - ODBC 17

El adaptador de synapse necesitar este componente para comunicarse con el data warehouse del cloud. Desde este [enlace](https://learn.microsoft.com/en-us/sql/connect/odbc/download-odbc-driver-for-sql-server?view=sql-server-ver16#version-17) podremos encontrar la información y descargar la versión de 64 bits.

### 4 - sqlfluff

Utilizaremos este paquete como linter para nuestro código sql. Para instalarlo usaremos pip

```pip
pip install sqlfluff
pip install sqlfluff-templater-dbt
```
Podemos encontrar más información sobre este paquete [aquí](https://docs.sqlfluff.com/en/stable/index.html)


### Recursos:
- Aprende más sobre dbt [en los documentos](https://docs.getdbt.com/docs/introduction)
