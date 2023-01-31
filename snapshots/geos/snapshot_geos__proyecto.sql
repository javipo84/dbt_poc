{% snapshot snapshot_geos__proyecto %}

{{
    config(            
      unique_key='Id',
      strategy='check',
      check_cols=['IdEstadoProyecto', 'IdAgrupacionEstados','CodTipoProyecto','IdUnidadMedidaDefecto','Codigo','CodPais','CodMoneda','Descripcion'
                 ,'CodTipoEstructuraSocietaria','CodModoTrabajoPresupuesto','CodTipoDepartamento','TransferenciaCoste','GestorProyecto'
                 ,'DiasPlazoPeriodo','LimiteTramo'],      
      invalidate_hard_deletes=True,
      dist='HASH(Id)',
    )	
}}

    SELECT
        Id,
        IdEstadoProyecto,
        IdAgrupacionEstados,
        CodTipoProyecto,
        IdUnidadMedidaDefecto,
        Codigo,
        CodPais,
        CodMoneda,
        Descripcion,
        CodTipoEstructuraSocietaria,
        CodModoTrabajoPresupuesto,
        CodTipoDepartamento,
        TransferenciaCoste,
        GestorProyecto,
        DiasPlazoPeriodo,
        LimiteTramo,
        DiaInicio,
        DiaFin,
        Activo,
        SistemaRrhhExterno,
        ImportacionNominaExterna,
        TieneRegistroProduccion,
        DesviacionesHorario,
        CodContabilidad,
        CodLimiteConsumo,
        Tolerancia,
        Tasas,
        ProvisionFinObra,
        FechaBaja,
        NoCertificacionAdicionalPdt,
        EnviarProvision,
        Comprometido,
        EsDepartamento,
        PrecierreCentralizado,
        Ofertas,
        IdGrupoProyecto,
        NoSeleccionablePermisos,
        CodSubtipoObra,
        ResponsablePais,
        Delegado,
        Delegacion,
        JefeAdministracion
    FROM {{ source('geos', 'GEOS_Proyectos') }}

    UNION ALL

    SELECT
        -1 AS Id,
        0 AS IdEstadoProyecto,
        0 AS IdAgrupacionEstados,
        'No Data' AS CodTipoProyecto,
        'No Data' AS IdUnidadMedidaDefecto,
        'No Data' AS Codigo,
        'No Data' AS CodPais,
        'No Data' AS CodMoneda,
        'No Data' AS Descripcion,
        'No Data' AS CodTipoEstructuraSocietaria,
        'No Data' AS CodModoTrabajoPresupuesto,
        'No Data' AS CodTipoDepartamento,
        'No Data' AS TransferenciaCoste,
        'No Data' AS GestorProyecto,
        0 AS DiasPlazoPeriodo,
        '00:00:00' AS LimiteTramo,
        0 AS DiaInicio,
        0 AS DiaFin,
        0 AS Activo,
        0 AS SistemaRrhhExterno,
        0 AS ImportacionNominaExterna,
        0 AS TieneRegistroProduccion,
        0 AS DesviacionesHorario,
        'No Data' AS CodContabilidad,
        'No Data' AS CodLimiteConsumo,
        0 AS Tolerancia,
        0 AS Tasas,
        0 AS ProvisionFinObra,
        '9999-12-31' AS FechaBaja,
        0 AS NoCertificacionAdicionalPdt,
        0 AS EnviarProvision,
        0 AS Comprometido,
        0 AS EsDepartamento,
        0 AS PrecierreCentralizado,
        0 AS Ofertas,
        'No Data' AS IdGrupoProyecto,
        0 AS NoSeleccionablePermisos,
        'No Data' AS CodSubtipoObra,
        'No Data' AS ResponsablePais,
        'No Data' AS Delegado,
        'No Data' AS Delegacion,
        'No Data' AS JefeAdministracion

{% endsnapshot %}
