{% macro db_util_log(p_proyecto, p_esquema, p_tabla, p_descripcion) %}

    declare @variable datetime = SYSDATETIME()
    insert into dbt_metadata.CargaSQLLOG (Proyecto,Esquema,Tabla,Descripcion,Error,Fecha) values ('{{p_proyecto}}','{{p_esquema}}','{{p_tabla}}','{{p_descripcion}}',null,@variable)

{%- endmacro %}