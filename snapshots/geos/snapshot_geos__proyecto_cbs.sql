{% snapshot snapshot_geos__proyecto_cbs %}

{{
    config(            
      unique_key='Id',
      strategy='check',
      check_cols=['IdProyecto','IdTipoDepartamentoEtiqueta','CodTipoCoste','CodigoPadre','Sufijo','EsAgregador','CodTipoCbs'],      
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
        CodTipoCbs
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
        'No Data' AS CodTipoCbs

{% endsnapshot %}
