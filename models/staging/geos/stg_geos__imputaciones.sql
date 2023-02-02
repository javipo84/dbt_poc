{{
  config(
    materialized='incremental',
    unique_key='Id'
  )
}}

WITH src_geos_imputaciones AS (
    SELECT
        Id,
        IdAsignacion,
        IdTipoHora,
        IdProyecto,
        IdProyectoCbs,
        CodTipoDepartamentoTarea,
        FechaSemana,
        Comentarios,
        ComentariosAprobador,
        CreatedBy,
        CreatedAt,
        ChangedBy
    FROM {{ source('geos', 'GEOS_Imputaciones') }}
),

rename_stg_geos_imputaciones AS (
    SELECT
        Id AS id,
        IdAsignacion AS id_asignacion,
        IdTipoHora AS id_tipo_hora,
        IdProyecto AS id_proyecto,
        IdProyectoCbs AS id_proyecto_cbs,
        CodTipoDepartamentoTarea AS codigo_tipo_departamento_tarea,
        FechaSemana AS fecha_semana,
        Comentarios AS comentarios,
        ComentariosAprobador AS comentarios_aprobador,
        CreatedBy AS created_by,
        CreatedAt AS created_at,
        ChangedBy AS changed_by
    FROM src_geos_imputaciones
)

SELECT * FROM rename_stg_geos_imputaciones

    {% if is_incremental() %}

    WHERE created_at > (SELECT MAX(created_at) FROM {{ this }})

    {% endif %}

  {%- call statement('db_util_log', fetch_result=True) -%}
    {{ db_util_log('GEOS', 'curated', 'geos__imputaciones', 'Actualización origen') }}
  {%- endcall -%}