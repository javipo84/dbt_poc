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

  rename_stg_tipos_hora AS (
    SELECT
        dbt_scd_id AS sk_tipos_hora,
        Id AS nk_tipos_hora,
        IdUnidadMedida AS id_unidad_medida,
        Codigo AS codigo,
        CodPais AS codigo_pais,
        CodigoCentral AS codigo_central,
        TipoConcepto AS tipo_concepto,
        Coste AS coste,
        ReportarRRHH AS reportar_rrhh,
        Horario AS horario,
        TipoProyecto AS tipo_proyecto,
        CodTipoDepartamento AS codigo_tipo_departamento,
        GeneraDescanso AS genera_descanso,
        ConsumeDescanso AS consume_descanso,
        Ausencia AS ausencia,
        Abono AS abono,
        Frecuencia AS frecuencia,
        Estado AS estado,
        ContabilizaHoras AS contabiliza_horas,
        dbt_valid_from AS fecha_insercion,
        dbt_updated_at AS fecha_modificacion,
        null AS fecha_eliminacion,
        dbt_valid_from AS fecha_desde,
        dbt_valid_to AS fecha_hasta,
        CASE WHEN dbt_valid_to IS NULL THEN 1 ELSE 0 END AS actual
    FROM snapshot_tipos_hora
  )

  SELECT * FROM rename_stg_tipos_hora
