{{
  config(
    materialized='view'
  )
}}

  WITH snapshot_tipos_hora AS (
    SELECT
        Id,
        IdUnidadMedida,
        Codigo,
        CodPais,
        CodigoCentral,
        TipoConcepto,
        Coste,
        ReportarRRHH,
        Horario,
        TipoProyecto,
        CodTipoDepartamento,
        GeneraDescanso,
        ConsumeDescanso,
        Ausencia,
        Abono,
        Frecuencia,
        Estado,
        ContabilizaHoras,
        dbt_scd_id,
        dbt_updated_at,
        dbt_valid_from,
        dbt_valid_to
    FROM {{ ref('snapshot_geos__tipos_hora') }}
  ),

  rename_casted_stg_tipos_hora AS (
    SELECT
        dbt_scd_id AS sk_tipos_hora,
        CAST(Id AS INT) AS nk_tipos_hora,
        CAST(IdUnidadMedida AS INT) AS id_unidad_medida,
        Codigo AS codigo,
        CodPais AS codigo_pais,
        CodigoCentral AS codigo_central,
        CAST(TipoConcepto AS INT) AS tipo_concepto,
        CAST(Coste AS BIT) AS coste,
        CAST(ReportarRRHH AS BIT) AS reportar_rrhh,
        CAST(Horario AS BIT) AS horario,
        TipoProyecto AS tipo_proyecto,
        CodTipoDepartamento AS codigo_tipo_departamento,
        CAST(GeneraDescanso AS BIT) AS genera_descanso,
        CAST(ConsumeDescanso AS BIT) AS consume_descanso,
        CAST(Ausencia AS BIT) AS ausencia,
        CAST(Abono AS BIT) AS abono,
        CAST(Frecuencia AS BIT) AS frecuencia,
        CAST(Estado AS BIT) AS estado,
        CAST(ContabilizaHoras AS BIT) AS contabiliza_horas,
        dbt_valid_from AS fecha_insercion,
        dbt_updated_at AS fecha_modificacion,
        null AS fecha_eliminacion,
        dbt_valid_from AS fecha_desde,
        dbt_valid_to AS fecha_hasta,
        CASE WHEN dbt_valid_to IS NULL THEN 1 ELSE 0 END AS actual,
        {{ dbt_utils.generate_surrogate_key([
                'Id', 
                'IdUnidadMedida',
                'Codigo',
                'CodPais',
                'CodigoCentral',
                'TipoConcepto',
                'Coste',
                'ReportarRRHH',
                'Horario',
                'TipoProyecto',
                'CodTipoDepartamento',
                'GeneraDescanso'
            ])
        }} as hash        
    FROM snapshot_tipos_hora
  )

  SELECT * FROM rename_casted_stg_tipos_hora

  {%- call statement('db_util_log', fetch_result=True) -%}
    {{ db_util_log('GEOS', 'curated', 'geos__tipos_hora', 'Actualización origen') }}
  {%- endcall -%}