WITH stg_proyecto_cbs AS (
    SELECT
        sk_proyecto_cbs,
        nk_proyecto_cbs,
        id_proyecto,
        id_tipo_departamento_etiqueta,
        codigo_tipo_coste,
        codigo_padre,
        sufijo,
        es_agregador,
        codigo_tipo_cbs,
        actual,
        fecha_insercion,
        fecha_modificacion,
        fecha_eliminacion,
        fecha_desde,
        fecha_hasta
    FROM {{ ref ('stg_geos__proyecto_cbs') }}
),

dim_proyecto_cbs AS (
    SELECT
        sk_proyecto_cbs,
        nk_proyecto_cbs,
        id_proyecto,
        id_tipo_departamento_etiqueta,
        codigo_tipo_coste,
        codigo_padre,
        sufijo,
        es_agregador,
        codigo_tipo_cbs,
        actual,
        fecha_insercion,
        fecha_modificacion,
        fecha_eliminacion,
        fecha_desde,
        fecha_hasta
    FROM stg_proyecto_cbs
)

SELECT * FROM dim_proyecto_cbs
