{% macro clean_text(expression) -%}
    (
        case
            when {{ expression }} is null then null
            when lower(trim({{ expression }}::text)) in (
                '', 'na', 'n/a', 'null', 'not recorded', 'not captured',
                'not known', 'not available'
            ) then null
            else trim({{ expression }}::text)
        end
    )
{%- endmacro %}

{% macro clean_id(expression) -%}
    (
        case
            when {{ clean_text(expression) }} is null then null
            else upper(regexp_replace({{ clean_text(expression) }}, '[^A-Za-z0-9_]', '', 'g'))
        end
    )
{%- endmacro %}

{% macro clean_label(expression) -%}
    (
        case
            when {{ clean_text(expression) }} is null then null
            else regexp_replace(lower({{ clean_text(expression) }}), '\s+', ' ', 'g')
        end
    )
{%- endmacro %}

{% macro first_numeric(expression) -%}
    (
        ((regexp_match({{ clean_text(expression) }}, '[-+]?[0-9]+[.]?[0-9]*'))[1])::numeric
    )
{%- endmacro %}

{% macro int_from_raw(expression) -%}
    (
        round({{ first_numeric(expression) }})::integer
    )
{%- endmacro %}

{% macro bool_from_raw(expression) -%}
    (
        case
            when {{ clean_label(expression) }} in ('yes', 'y', 'true', '1', 'signed', 'thumbprint') then true
            when {{ clean_label(expression) }} in ('no', 'n', 'false', '0') then false
            else null
        end
    )
{%- endmacro %}

{% macro parse_raw_date(expression) -%}
    (
        case
            when {{ clean_text(expression) }} is null then null::date
            when {{ clean_label(expression) }} in (
                'pending', 'unknown', 'not sure', 'not measured', 'not done',
                'see systolic col'
            ) then null::date

            when {{ clean_text(expression) }} ~ '^\d{4}-\d{1,2}-\d{1,2}'
                then to_date(left({{ clean_text(expression) }}, 10), 'YYYY-MM-DD')

            when {{ clean_text(expression) }} ~ '^\d{4}/\d{1,2}/\d{1,2}$'
                then to_date({{ clean_text(expression) }}, 'YYYY/MM/DD')

            when {{ clean_text(expression) }} ~ '^\d{1,2}/\d{1,2}/\d{4}'
                and split_part(substring({{ clean_text(expression) }} from '^\d{1,2}/\d{1,2}/\d{4}'), '/', 1)::integer > 12
                then to_date(substring({{ clean_text(expression) }} from '^\d{1,2}/\d{1,2}/\d{4}'), 'DD/MM/YYYY')

            when {{ clean_text(expression) }} ~ '^\d{1,2}/\d{1,2}/\d{4}'
                and split_part(substring({{ clean_text(expression) }} from '^\d{1,2}/\d{1,2}/\d{4}'), '/', 2)::integer > 12
                then to_date(substring({{ clean_text(expression) }} from '^\d{1,2}/\d{1,2}/\d{4}'), 'MM/DD/YYYY')

            when {{ clean_text(expression) }} ~ '^\d{1,2}/\d{1,2}/\d{4}'
                then to_date(substring({{ clean_text(expression) }} from '^\d{1,2}/\d{1,2}/\d{4}'), 'DD/MM/YYYY')

            when {{ clean_text(expression) }} ~ '^\d{1,2}-\d{1,2}-\d{2}$'
                then to_date({{ clean_text(expression) }}, 'DD-MM-YY')

            when {{ clean_text(expression) }} ~ '^\d{1,2}-\d{1,2}-\d{4}$'
                then to_date({{ clean_text(expression) }}, 'DD-MM-YYYY')

            when {{ clean_text(expression) }} ~ '^[A-Z][a-z]{2} [A-Z][a-z]{2} +\d{1,2} +\d{4}$'
                then to_date({{ clean_text(expression) }}, 'Dy Mon DD YYYY')

            else null::date
        end
    )
{%- endmacro %}
