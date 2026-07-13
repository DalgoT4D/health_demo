with household_mentions as (

    select
        household_id,
        district,
        ward,
        area,
        cluster,
        'sanitary_distribution' as source_model
    from {{ ref('stg_health__sanitary_distribution') }}
    where household_id is not null

    union all

    select
        household_id,
        district,
        ward,
        area,
        null as cluster,
        'child_development_tracking' as source_model
    from {{ ref('stg_health__child_development_tracking') }}
    where household_id is not null

    union all

    select
        household_id,
        district,
        ward,
        area,
        null as cluster,
        'maternal_mortality_risk' as source_model
    from {{ ref('stg_health__maternal_mortality_risk') }}
    where household_id is not null

    union all

    select
        household_id,
        null as district,
        null as ward,
        null as area,
        null as cluster,
        'clinic_meetings' as source_model
    from {{ ref('stg_health__clinic_meetings') }}
    where household_id is not null

    union all

    select
        household_id,
        null as district,
        null as ward,
        null as area,
        null as cluster,
        'chatbot_interactions' as source_model
    from {{ ref('stg_health__chatbot_interactions') }}
    where household_id is not null

),

ranked as (

    select
        *,
        count(*) over (partition by household_id) as source_record_count,
        row_number() over (
            partition by household_id
            order by
                (district is null)::integer asc,
                (ward is null)::integer asc,
                (area is null)::integer asc,
                source_model asc
        ) as household_rank
    from household_mentions

)

select
    household_id,
    district,
    ward,
    area,
    cluster,
    source_record_count
from ranked
where household_rank = 1
