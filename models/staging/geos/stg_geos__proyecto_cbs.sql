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

  rename_casted_stg_proyecto_cbs AS (
    SELECT
        dbt_scd_id AS sk_proyecto_cbs,
        CAST(Id AS INT) AS nk_proyecto_cbs,
        CAST(IdProyecto AS INT) AS id_proyecto,
        CAST(IdTipoDepartamentoEtiqueta AS INT) AS id_tipo_departamento_etiqueta,
        CodTipoCoste AS codigo_tipo_coste,
        CodigoPadre AS codigo_padre,
        Sufijo AS sufijo,
        CAST(EsAgregador AS BIT) AS es_agregador,
        CodTipoCbs AS codigo_tipo_cbs,
        {{ generate_extra_columns_sc2() }},
        {{ dbt_utils.generate_surrogate_key([
                'Id', 
                'IdProyecto', 
                'IdTipoDepartamentoEtiqueta', 
                'CodTipoCoste', 
                'CodigoPadre', 
                'Sufijo', 
                'EsAgregador', 
                'CodTipoCbs'
            ])
        }} AS hash_code
    FROM snapshot_proyecto_cbs
  )

  SELECT * FROM rename_casted_stg_proyecto_cbs

  {%- call statement('db_util_log', fetch_result=True) -%}
    {{ db_util_log('GEOS', 'curated', 'geos__proyecto_cbs', 'Actualización origen') }}
  {%- endcall -%}