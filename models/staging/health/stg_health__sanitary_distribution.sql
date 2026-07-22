with source as (

    select * from {{ source('staging_health', 'raw_sanitary_dist') }}

),

cleaned as (

    select
        md5(concat_ws('||', coalesce(_airbyte_raw_id, ''), coalesce(source_row_id, ''))) as sanitary_distribution_row_sk,
        _airbyte_raw_id,
        _airbyte_extracted_at as source_loaded_at,
        _airbyte_generation_id,
        source_row_id,

        {{ clean_id('distribution_id_raw') }} as distribution_id,
        {{ clean_id('beneficiary_id_raw') }} as beneficiary_id,
        {{ clean_id('household_id_raw') }} as household_id,
        {{ clean_id('field_worker_id_raw') }} as field_worker_id,

        {{ parse_raw_date('distribution_date_raw') }} as distribution_date,
        initcap({{ clean_label('beneficiary_name_raw') }}) as beneficiary_name,
        {{ first_numeric('age_raw') }}::integer as age_years,

        {{ india_district_name(clean_label('district_raw')) }} as district,
        {{ canonical_india_state(clean_text('state_raw'), clean_label('district_raw')) }} as state,
        {{ canonical_partner_ngo(clean_text('partner_ngo_raw'), clean_label('district_raw')) }} as partner_ngo,
        upper({{ clean_text('ward_raw') }}) as ward,
        initcap({{ clean_label('area_raw') }}) as area,
        initcap({{ clean_label('cluster_raw') }}) as cluster,

        case
            when {{ clean_label('beneficiary_group_raw') }} like '%adolescent%' then 'adolescent_girl'
            when {{ clean_label('beneficiary_group_raw') }} like '%pregnant%' then 'pregnant_woman'
            when {{ clean_label('beneficiary_group_raw') }} like '%lactating%' then 'lactating_mother'
            when {{ clean_label('beneficiary_group_raw') }} like '%school%' then 'school_student'
            when {{ clean_label('beneficiary_group_raw') }} like '%community%' then 'community_woman'
            else {{ clean_label('beneficiary_group_raw') }}
        end as beneficiary_group,

        case
            when {{ clean_label('product_type_raw') }} like '%reusable%' then 'reusable_cloth_pad_kit'
            when {{ clean_label('product_type_raw') }} like '%cup%' then 'menstrual_cup'
            when {{ clean_label('product_type_raw') }} like '%disposal%' then 'disposal_bags'
            when {{ clean_label('product_type_raw') }} like '%hygiene kit%' then 'period_hygiene_kit'
            when {{ clean_label('product_type_raw') }} like '%pad%' then 'sanitary_pads_pack'
            else {{ clean_label('product_type_raw') }}
        end as product_type,

        {{ first_numeric('quantity_raw') }}::integer as quantity,

        case
            when {{ clean_label('unit_raw') }} like '%kit%' then 'kit'
            when {{ clean_label('unit_raw') }} like '%piece%' then 'piece'
            when {{ clean_label('unit_raw') }} like '%pack%' then 'pack'
            else {{ clean_label('unit_raw') }}
        end as unit,

        {{ clean_text('batch_no_raw') }} as batch_no,
        {{ clean_label('donor_or_program_raw') }} as donor_or_program,
        {{ clean_label('distribution_channel_raw') }} as distribution_channel,
        {{ bool_from_raw('awareness_session_attended_raw') }} as awareness_session_attended,

        case
            when {{ clean_label('stockout_reported_raw') }} in ('yes', 'y', 'true') then true
            when {{ clean_label('stockout_reported_raw') }} in ('no', 'n', 'false', 'n/a') then false
            else null
        end as stockout_reported,

        case
            when {{ clean_label('receipt_ack_raw') }} in ('signed', 'thumbprint', 'verbal') then {{ clean_label('receipt_ack_raw') }}
            else null
        end as receipt_acknowledgement,

        {{ clean_text('entered_by') }} as entered_by,
        {{ clean_text('notes_raw') }} as notes,
        synthetic_record_flag

    from source

),

ranked as (

    select
        *,
        row_number() over (
            partition by distribution_id
            order by source_loaded_at desc, source_row_id desc, sanitary_distribution_row_sk asc
        ) as distribution_id_rank
    from cleaned

)

select
    *,
    distribution_id_rank > 1 as is_duplicate_distribution_id
from ranked
