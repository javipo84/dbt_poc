{{
  config(
    materialized='view'
  )
}}

  WITH snapshot_tipo_departamento_tareas AS (
    SELECT
        Codigo,
        CodTipoDepartamento,
        Activo,
        dbt_scd_id,
        dbt_updated_at,
        dbt_valid_from,
        dbt_valid_to
    FROM {{ ref('snapshot_geos__tipo_departamento_tareas') }}
  ),

  rename_casted_stg_tipo_departamento_tareas AS (
    SELECT
        dbt_scd_id AS sk_tipo_departamento_tareas,
        CAST(Codigo AS INT) AS nk_tipo_departamento_tareas,
        CAST(Codigo AS INT) AS codigo,
        CAST(CodTipoDepartamento AS INT) AS codigo_tipo_departamento,
        CAST(Activo AS BIT) AS activo,
        {{ generate_extra_columns_sc2() }},
        {{ dbt_utils.generate_surrogate_key ([
            'Codigo',             
            'Activo'
          ])
        }} AS hash_code
    FROM snapshot_tipo_departamento_tareas
  )

  SELECT * FROM rename_casted_stg_tipo_departamento_tareas

  {%- call statement('db_util_log', fetch_result=True) -%}
    {{ db_util_log('GEOS', 'curated', 'geos__tipo_departamento_tareas', 'Actualización origen') }}
  {%- endcall -%}
