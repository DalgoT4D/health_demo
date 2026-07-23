{% macro india_state_from_district(district_expression) -%}
    (
        case
            when {{ district_expression }} is null then null
            when lower(regexp_replace(trim({{ district_expression }}::text), '[_-]+', ' ', 'g')) in (
                'mumbai',
                'mumbai city',
                'mumbai suburban',
                'thane'
            ) then 'Maharashtra'
            else null
        end
    )
{%- endmacro %}

{% macro canonical_india_state(state_expression, district_expression) -%}
    (
        case
            when {{ state_expression }} is not null
                and lower(regexp_replace(trim({{ state_expression }}::text), '[_-]+', ' ', 'g')) in (
                    'maharashtra',
                    'mh'
                ) then 'Maharashtra'
            when {{ state_expression }} is not null
                then initcap(regexp_replace(trim({{ state_expression }}::text), '\s+', ' ', 'g'))
            else {{ india_state_from_district(district_expression) }}
        end
    )
{%- endmacro %}

{% macro india_district_name(district_expression) -%}
    (
        case
            when {{ district_expression }} is null then null
            when lower(regexp_replace(trim({{ district_expression }}::text), '[_-]+', ' ', 'g')) in (
                'mumbai city',
                'mumbai',
                'bombay',
                'mumbai suburban',
                'mumbai suburb',
                'suburban mumbai'
            ) then 'Mumbai'
            when lower(regexp_replace(trim({{ district_expression }}::text), '[_-]+', ' ', 'g')) = 'thane' then 'Thane'
            else initcap(regexp_replace(trim({{ district_expression }}::text), '\s+', ' ', 'g'))
        end
    )
{%- endmacro %}

{% macro canonical_partner_ngo(partner_expression, district_expression) -%}
    (
        case
            when {{ partner_expression }} is not null
                and lower(trim({{ partner_expression }}::text)) in (
                    'aarogya saathi foundation',
                    'aarogya saathi'
                ) then 'Aarogya Saathi Foundation'
            when {{ partner_expression }} is not null
                and lower(trim({{ partner_expression }}::text)) in (
                    'swasthya setu trust',
                    'swasthya setu'
                ) then 'Swasthya Setu Trust'
            when {{ partner_expression }} is not null
                and lower(trim({{ partner_expression }}::text)) in (
                    'janani vikas collective',
                    'janani vikas'
                ) then 'Janani Vikas Collective'
            when {{ partner_expression }} is not null
                then initcap(regexp_replace(trim({{ partner_expression }}::text), '\s+', ' ', 'g'))
            when {{ india_district_name(district_expression) }} = 'Mumbai' then 'Aarogya Saathi Foundation'
            when {{ india_district_name(district_expression) }} = 'Thane' then 'Janani Vikas Collective'
            else 'Unassigned Partner'
        end
    )
{%- endmacro %}
