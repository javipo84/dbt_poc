{% snapshot snapshot_geos__tipo_departamento_tareas %}

{{
    config(            
      unique_key='Codigo',
      strategy='check',
      check_cols=['CodTipoDepartamento', 'Activo'],      
      invalidate_hard_deletes=True,
      dist='HASH(Codigo)',
    )
}}

    SELECT
        Codigo,
        CodTipoDepartamento,
        Activo
    FROM {{ source('geos', 'GEOS_TipoDepartamentoTareas') }}

    UNION ALL

    SELECT
        -1 AS Codigo,
        -1 AS CodTipoDepartamento,
        0 AS Activo

{% endsnapshot %}
