WITH stg_tipo_departamento_tareas AS (
    SELECT
        sk_tipo_departamento_tareas,
        nk_tipo_departamento_tareas,
        codigo,
        codigo_tipo_departamento,
        activo,
        actual,
        fecha_insercion,
        fecha_modificacion,
        fecha_eliminacion,
        fecha_desde,
        fecha_hasta
    FROM {{ ref ('stg_geos__tipo_departamento_tareas') }}
),

dim_tipo_departamento_tareas AS (
    SELECT
        sk_tipo_departamento_tareas,
        nk_tipo_departamento_tareas,
        codigo,
        codigo_tipo_departamento,
        activo,
        actual,
        fecha_insercion,
        fecha_modificacion,
        fecha_eliminacion,
        fecha_desde,
        fecha_hasta
    FROM stg_tipo_departamento_tareas
)

SELECT * FROM dim_tipo_departamento_tareas
