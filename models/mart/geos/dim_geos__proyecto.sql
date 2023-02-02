WITH stg_proyecto AS (
    SELECT
        sk_proyecto,
        nk_proyecto,
        id_estado_proyecto,
        id_agrupacion_estados,
        codigo_tipo_proyecto,
        id_unidad_medida_defecto,
        codigo,
        codigo_pais,
        codigo_moneda,
        descripcion,
        codigo_tipo_estructura_societaria,
        codigo_modo_trabajo_presupuesto,
        codigo_tipo_departamento,
        transferencia_coste,
        gestor_proyecto,
        dias_plazo_periodo,
        limite_tramo,
        dia_inicio,
        dia_fin,
        activo,
        sistema_rrhh_externo,
        importacion_nomina_externa,
        tiene_registro_produccion,
        desviaciones_horarios,
        codigo_contabilidad,
        codigo_limite_consumo,
        tolerancia,
        tasas,
        provision_fin_obra,
        fecha_baja,
        no_certificacion_adicional_pdt,
        enviar_provision,
        comprometido,
        es_departamento,
        precierre_centralizado,
        ofertas,
        id_grupo_proyecto,
        no_seleccionable_permisos,
        codigo_subtipo_obra,
        responsable_pais,
        delegado,
        delegacion,
        jefe_administracion,
        actual,
        fecha_insercion,
        fecha_modificacion,
        fecha_eliminacion,
        fecha_desde,
        fecha_hasta
    FROM {{ ref ('stg_geos__proyecto') }}
),

dim_proyecto AS (
    SELECT
        sk_proyecto,
        nk_proyecto,
        id_estado_proyecto,
        id_agrupacion_estados,
        codigo_tipo_proyecto,
        id_unidad_medida_defecto,
        codigo,
        codigo_pais,
        codigo_moneda,
        descripcion,
        codigo_tipo_estructura_societaria,
        codigo_modo_trabajo_presupuesto,
        codigo_tipo_departamento,
        transferencia_coste,
        gestor_proyecto,
        dias_plazo_periodo,
        limite_tramo,
        dia_inicio,
        dia_fin,
        activo,
        sistema_rrhh_externo,
        importacion_nomina_externa,
        tiene_registro_produccion,
        desviaciones_horarios,
        codigo_contabilidad,
        codigo_limite_consumo,
        tolerancia,
        tasas,
        provision_fin_obra,
        fecha_baja,
        no_certificacion_adicional_pdt,
        enviar_provision,
        comprometido,
        es_departamento,
        precierre_centralizado,
        ofertas,
        id_grupo_proyecto,
        no_seleccionable_permisos,
        codigo_subtipo_obra,
        responsable_pais,
        delegado,
        delegacion,
        jefe_administracion,
        actual,
        fecha_insercion,
        fecha_modificacion,
        fecha_eliminacion,
        fecha_desde,
        fecha_hasta
    FROM stg_proyecto
)

SELECT * FROM dim_proyecto

  {%- call statement('db_util_log', fetch_result=True) -%}
    {{ db_util_log('GEOS', 'analytics', 'dim_geos__proyecto', 'Actualización SCD2') }}
  {%- endcall -%}
