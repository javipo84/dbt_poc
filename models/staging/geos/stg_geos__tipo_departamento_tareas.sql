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
        dbt_valid_from AS fecha_insercion,
        dbt_updated_at AS fecha_modificacion,
        null AS fecha_eliminacion,
        dbt_valid_from AS fecha_desde,
        dbt_valid_to AS fecha_hasta,
        CASE WHEN dbt_valid_to IS NULL THEN 1 ELSE 0 END AS actual,
        {{ dbt_utils.generate_surrogate_key([
                'Codigo', 
                'CodTipoDepartamento',
                'Activo'
            ])
        }} as hash        

    FROM snapshot_tipo_departamento_tareas
  )

  SELECT * FROM rename_casted_stg_tipo_departamento_tareas

  {%- call statement('db_util_log', fetch_result=True) -%}
    {{ db_util_log('GEOS', 'curated', 'geos__tipo_departamento_tareas', 'Actualización origen') }}
  {%- endcall -%}
