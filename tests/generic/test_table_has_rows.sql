{% test table_has_rows(model, column_name) %}


with validation as (
    select
        count(*) AS total
    from {{ model }}
),

validation_errors as (

    select
        total
    from validation    
    where total = 0

)

select *
from validation_errors
    
{% endtest %}