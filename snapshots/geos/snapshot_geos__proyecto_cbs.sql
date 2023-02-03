{% snapshot snapshot_geos__proyecto_cbs %}

{{
    config(            
      unique_key='Id',
      strategy='timestamp',
      updated_at='ChangedAt',      
      invalidate_hard_deletes=True,
      dist='HASH(Id)',
    )
}}

    SELECT
        Id,
        IdProyecto,
        IdTipoDepartamentoEtiqueta,
        CodTipoCoste,
        CodigoPadre,
        Sufijo,
        EsAgregador,
        CodTipoCbs,
        ChangedAt
    FROM {{ source('geos', 'GEOS_ProyectoCBS') }}

    UNION ALL

    SELECT
        -1 AS Id,
        -1 AS IdProyecto,
        -1 AS IdTipoDepartamentoEtiqueta,
        'No Data' AS CodTipoCoste,
        'No Data' AS CodigoPadre,
        'No Data' AS Sufijo,
        0 AS EsAgregador,
        'No Data' AS CodTipoCbs,
        '9999-12-31' as ChangedAt

{% endsnapshot %}
