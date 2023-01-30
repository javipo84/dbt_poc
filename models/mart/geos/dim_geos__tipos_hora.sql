WITH stg_tipos_hora AS (
    SELECT
        sk_tipos_hora,
        nk_tipos_hora,
        id_unidad_medida,
        codigo,
        codigo_pais,
        codigo_central,
        tipo_concepto,
        coste,
        reportar_rrhh,
        horario,
        tipo_proyecto,
        codigo_tipo_departamento,
        genera_descanso,
        consume_descanso,
        ausencia,
        abono,
        frecuencia,
        estado,
        contabiliza_horas,
        actual,
        fecha_insercion,
        fecha_modificacion,
        fecha_eliminacion,
        fecha_desde,
        fecha_hasta
    FROM {{ ref ('stg_geos__tipos_hora') }}
),

dim_tipos_hora AS (
    SELECT
        sk_tipos_hora,
        nk_tipos_hora,
        id_unidad_medida,
        codigo,
        codigo_pais,
        codigo_central,
        tipo_concepto,
        coste,
        reportar_rrhh,
        horario,
        tipo_proyecto,
        codigo_tipo_departamento,
        genera_descanso,
        consume_descanso,
        ausencia,
        abono,
        frecuencia,
        estado,
        contabiliza_horas,
        actual,
        fecha_insercion,
        fecha_modificacion,
        fecha_eliminacion,
        fecha_desde,
        fecha_hasta
    FROM stg_tipos_hora
)

SELECT * FROM dim_tipos_hora
