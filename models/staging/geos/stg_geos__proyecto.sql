{{
  config(
    materialized='view'
  )
}}

  WITH snapshot_proyecto AS (
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
        JefeAdministracion,
        dbt_scd_id,
        dbt_updated_at,
        dbt_valid_from,
        dbt_valid_to
    FROM {{ ref('snapshot_geos__proyecto') }}
  ),

  rename_stg_proyecto AS (
    SELECT
        dbt_scd_id AS sk_proyecto,
        CAST(Id AS INT) AS nk_proyecto,
        CAST(IdEstadoProyecto AS INT) AS id_estado_proyecto,
        CAST(IdAgrupacionEstados AS INT) AS id_agrupacion_estados,
        CodTipoProyecto AS codigo_tipo_proyecto,
        IdUnidadMedidaDefecto AS id_unidad_medida_defecto,
        Codigo AS codigo,
        CodPais AS codigo_pais,
        CodMoneda AS codigo_moneda,
        Descripcion AS descripcion,
        CodTipoEstructuraSocietaria AS codigo_tipo_estructura_societaria,
        CodModoTrabajoPresupuesto AS codigo_modo_trabajo_presupuesto,
        CodTipoDepartamento AS codigo_tipo_departamento,
        TransferenciaCoste AS transferencia_coste,
        GestorProyecto AS gestor_proyecto,
        CAST(DiasPlazoPeriodo AS INT) AS dias_plazo_periodo,
        LimiteTramo AS limite_tramo,
        CAST(DiaInicio AS INT) AS dia_inicio,
        CAST(DiaFin AS INT) AS dia_fin,
        CAST(Activo AS BIT) AS activo,
        CAST(SistemaRrhhExterno AS BIT) AS sistema_rrhh_externo,
        CAST(ImportacionNominaExterna AS BIT) AS importacion_nomina_externa,
        CAST(TieneRegistroProduccion AS BIT) AS tiene_registro_produccion,
        CAST(DesviacionesHorario AS INT) AS desviaciones_horarios,
        CodContabilidad AS codigo_contabilidad,
        CodLimiteConsumo AS codigo_limite_consumo,
        CAST(Tolerancia AS FLOAT) AS tolerancia,
        CAST(Tasas AS FLOAT) AS tasas,
        CAST(ProvisionFinObra AS FLOAT) AS provision_fin_obra,
        CAST(FechaBaja AS DATETIME) AS fecha_baja,
        CAST(NoCertificacionAdicionalPdt AS BIT) AS no_certificacion_adicional_pdt,
        CAST(EnviarProvision AS BIT) AS enviar_provision,
        CAST(Comprometido AS BIT) AS comprometido,
        CAST(EsDepartamento AS BIT) AS es_departamento,
        CAST(PrecierreCentralizado AS BIT) AS precierre_centralizado,
        CAST(Ofertas AS BIT) AS ofertas,
        IdGrupoProyecto AS id_grupo_proyecto,
        NoSeleccionablePermisos AS no_seleccionable_permisos,
        CodSubtipoObra AS codigo_subtipo_obra,
        ResponsablePais AS responsable_pais,
        Delegado AS delegado,
        Delegacion AS delegacion,
        JefeAdministracion AS jefe_administracion,
        {{ generate_extra_columns_sc2() }},
        {{ dbt_utils.generate_surrogate_key([
                'Id', 
                'IdEstadoProyecto',
                'IdAgrupacionEstados',
                'CodTipoProyecto',
                'IdUnidadMedidaDefecto',
                'Codigo',
                'CodPais',
                'CodMoneda',
                'Descripcion',
                'CodTipoEstructuraSocietaria',
                'CodModoTrabajoPresupuesto',
                'CodTipoDepartamento'
            ])
        }} AS hash_code
    FROM snapshot_proyecto
  )

  SELECT * FROM rename_stg_proyecto

  {%- call statement('db_util_log', fetch_result=True) -%}
    {{ db_util_log('GEOS', 'curated', 'geos__proyecto', 'Actualizaci??n origen') }}
  {%- endcall -%}
