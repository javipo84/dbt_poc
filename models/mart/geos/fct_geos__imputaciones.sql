{{
  config(
    materialized='incremental',
    unique_key='Id'
  )
}}

WITH stg_geos_imputaciones AS (
    SELECT
        id,
        id_asignacion,
        id_tipo_hora,
        id_proyecto,
        id_proyecto_cbs,
        codigo_tipo_departamento_tarea,
        fecha_semana,
        comentarios,
        comentarios_aprobador,
        created_at
    FROM {{ ref ('stg_geos__imputaciones') }}
),

ref_dim_geos_tipo_departamento_tareas AS (
    SELECT
        nk_tipo_departamento_tareas,
        sk_tipo_departamento_tareas
    FROM {{ ref ('dim_geos__tipo_departamento_tareas') }}
    WHERE actual = 1
),

ref_dim_geos_proyecto_cbs AS (
    SELECT
        nk_proyecto_cbs,
        sk_proyecto_cbs
    FROM {{ ref ('dim_geos__proyecto_cbs') }}
    WHERE actual = 1
),

ref_dim_geos_tipos_hora AS (
    SELECT
        nk_tipos_hora,
        sk_tipos_hora
    FROM {{ ref ('dim_geos__tipos_hora') }}
    WHERE actual = 1
),

ref_dim_geos_proyecto AS (
    SELECT
        nk_proyecto,
        sk_proyecto
    FROM {{ ref ('dim_geos__proyecto') }}
    WHERE actual = 1
),

fct_imputaciones AS (
    SELECT
        stg_geos_imputaciones.id,
        stg_geos_imputaciones.id_asignacion,
        stg_geos_imputaciones.id_tipo_hora,
        ref_dim_geos_tipos_hora.sk_tipos_hora AS sk_tipos_hora,
        stg_geos_imputaciones.id_proyecto,
        ref_dim_geos_proyecto.sk_proyecto AS sk_proyecto,
        stg_geos_imputaciones.id_proyecto_cbs,
        ref_dim_geos_proyecto_cbs.sk_proyecto_cbs AS sk_proyecto_cbs,
        stg_geos_imputaciones.codigo_tipo_departamento_tarea,
        ref_dim_geos_tipo_departamento_tareas.sk_tipo_departamento_tareas AS sk_tipo_departamento_tareas,
        stg_geos_imputaciones.fecha_semana,
        stg_geos_imputaciones.comentarios,
        stg_geos_imputaciones.comentarios_aprobador,
        stg_geos_imputaciones.created_at
    FROM stg_geos_imputaciones
    LEFT JOIN ref_dim_geos_tipo_departamento_tareas ON ref_dim_geos_tipo_departamento_tareas.nk_tipo_departamento_tareas = stg_geos_imputaciones.codigo_tipo_departamento_tarea
    LEFT JOIN ref_dim_geos_proyecto_cbs ON ref_dim_geos_proyecto_cbs.nk_proyecto_cbs = stg_geos_imputaciones.id_proyecto_cbs
    LEFT JOIN ref_dim_geos_tipos_hora ON ref_dim_geos_tipos_hora.nk_tipos_hora = stg_geos_imputaciones.id_tipo_hora
    LEFT JOIN ref_dim_geos_proyecto ON ref_dim_geos_proyecto.nk_proyecto = stg_geos_imputaciones.id_proyecto
)

SELECT * FROM fct_imputaciones

    {% if is_incremental() %}

    WHERE created_at > (SELECT MAX(created_at) FROM {{ this }})

    {% endif %}

  {%- call statement('db_util_log', fetch_result=True) -%}
    {{ db_util_log('GEOS', 'analytics', 'fct_geos__imputaciones', 'Actualización incremental') }}
  {%- endcall -%}