{% snapshot snapshot_geos__tipos_hora %}

{{
    config(      
      target_schema='dbt_curated',
      unique_key='Id',
      strategy='check',
      check_cols=['IdUnidadMedida','Codigo','CodPais','CodigoCentral','TipoConcepto','Coste','ReportarRRHH','Horario','TipoProyecto','CodTipoDepartamento'
                 ,'GeneraDescanso','ConsumeDescanso','Ausencia','Abono','Frecuencia','Estado','ContabilizaHoras'],      
      invalidate_hard_deletes=True,
      dist='HASH(Id)',
    )
}}

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
        ContabilizaHoras
    FROM {{ source('geos', 'GEOS_TiposHora') }}

    UNION ALL

    SELECT
        -1 AS Id,
        0 AS IdUnidadMedida,
        'No Data' AS Codigo,
        'No Data' AS CodPais,
        'No Data' AS CodigoCentral,
        0 AS TipoConcepto,
        0 AS Coste,
        0 AS ReportarRRHH,
        0 AS Horario,
        'No Data' AS TipoProyecto,
        'No Data' AS CodTipoDepartamento,
        0 AS GeneraDescanso,
        0 AS ConsumeDescanso,
        0 AS Ausencia,
        0 AS Abono,
        0 AS Frecuencia,
        0 AS Estado,
        0 AS ContabilizaHoras

{% endsnapshot %}
