{% snapshot snapshot_geos__tipo_departamento_tareas %}

{{
    config(      
      target_schema='dbt_curated',
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
        'No Data' AS Codigo,
        'No Data' AS CodTipoDepartamento,
        0 AS Activo

{% endsnapshot %}
