{{
  config(
    materialized='view'
  )
}}

  WITH snapshot_proyecto_cbs AS (
    SELECT
        Id,
        IdProyecto,
        IdTipoDepartamentoEtiqueta,
        CodTipoCoste,
        CodigoPadre,
        Sufijo,
        EsAgregador,
        CodTipoCbs,
        dbt_scd_id,
        dbt_updated_at,
        dbt_valid_from,
        dbt_valid_to
    FROM {{ ref('snapshot_geos__proyecto_cbs') }}
  ),

  rename_stg_proyecto_cbs AS (
    SELECT
        dbt_scd_id AS sk_proyecto_cbs,
        Id AS nk_proyecto_cbs,
        IdProyecto AS id_proyecto,
        IdTipoDepartamentoEtiqueta AS id_tipo_departamento_etiqueta,
        CodTipoCoste AS codigo_tipo_coste,
        CodigoPadre AS codigo_padre,
        Sufijo AS sufijo,
        EsAgregador AS es_agregador,
        CodTipoCbs AS codigo_tipo_cbs,
        dbt_valid_from AS fecha_insercion,
        dbt_updated_at AS fecha_modificacion,
        null AS fecha_eliminacion,
        dbt_valid_from AS fecha_desde,
        dbt_valid_to AS fecha_hasta,
        CASE WHEN dbt_valid_to IS NULL THEN 1 ELSE 0 END AS actual
    FROM snapshot_proyecto_cbs
  )

  SELECT * FROM rename_stg_proyecto_cbs
