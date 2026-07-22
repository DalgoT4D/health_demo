with source as (

    select * from {{ source('staging_health', 'raw_maternal_risk') }}

),

cleaned as (

    select
        md5(concat_ws('||', coalesce(_airbyte_raw_id, ''), coalesce(source_row_id, ''))) as maternal_risk_row_sk,
        _airbyte_raw_id,
        _airbyte_extracted_at as source_loaded_at,
        _airbyte_generation_id,
        source_row_id,

        {{ clean_id('pregnancy_id_raw') }} as pregnancy_id,
        {{ clean_id('visit_id_raw') }} as visit_id,
        {{ clean_id('mother_id_raw') }} as mother_id,
        {{ clean_id('beneficiary_id_raw') }} as beneficiary_id,
        {{ clean_id('household_id_raw') }} as household_id,
        {{ clean_id('field_worker_id_raw') }} as field_worker_id,

        initcap({{ clean_label('mother_name_raw') }}) as mother_name,
        {{ parse_raw_date('visit_date_raw') }} as visit_date,
        {{ parse_raw_date('lmp_date_raw') }} as lmp_date,
        {{ parse_raw_date('edd_raw') }} as estimated_delivery_date,
        {{ parse_raw_date('next_visit_date_raw') }} as next_visit_date,

        {{ india_district_name(clean_label('district_raw')) }} as district,
        {{ canonical_india_state(clean_text('state_raw'), clean_label('district_raw')) }} as state,
        {{ canonical_partner_ngo(clean_text('partner_ngo_raw'), clean_label('district_raw')) }} as partner_ngo,
        upper({{ clean_text('ward_raw') }}) as ward,
        initcap({{ clean_label('area_raw') }}) as area,

        {{ first_numeric('age_years_raw') }}::integer as age_years,
        {{ first_numeric('gravida_raw') }}::integer as gravida,
        {{ first_numeric('parity_raw') }}::integer as parity,
        {{ first_numeric('gestational_age_weeks_raw') }}::integer as gestational_age_weeks,
        {{ first_numeric('hemoglobin_g_dl_raw') }} as hemoglobin_g_dl,

        case
            when {{ clean_text('bp_systolic_raw') }} like '%/%'
                then split_part({{ clean_text('bp_systolic_raw') }}, '/', 1)::numeric
            else {{ first_numeric('bp_systolic_raw') }}
        end as bp_systolic,

        case
            when {{ clean_text('bp_systolic_raw') }} like '%/%'
                then split_part({{ clean_text('bp_systolic_raw') }}, '/', 2)::numeric
            else {{ first_numeric('bp_diastolic_raw') }}
        end as bp_diastolic,

        {{ first_numeric('bmi_raw') }} as bmi,
        {{ bool_from_raw('prior_c_section_raw') }} as prior_c_section,

        case
            when {{ clean_label('danger_signs_raw') }} in ('none', 'n/a') then null
            else {{ clean_label('danger_signs_raw') }}
        end as danger_signs,

        replace({{ clean_label('anemia_status_raw') }}, ' ', '_') as anemia_status,

        case
            when {{ clean_label('hypertension_flag_raw') }} in ('yes', 'y', 'high bp') then true
            when {{ clean_label('hypertension_flag_raw') }} in ('no', 'n', 'normal') then false
            else null
        end as hypertension_flag,

        case
            when {{ clean_label('risk_level_raw') }} in ('critical', 'high', 'moderate', 'low') then {{ clean_label('risk_level_raw') }}
            else null
        end as risk_level,

        case
            when {{ clean_label('referral_status_raw') }} like '%pending%' then 'referral_pending'
            when {{ clean_label('referral_status_raw') }} like '%refer%' then 'referred'
            when {{ clean_label('referral_status_raw') }} = 'accepted' then 'accepted'
            when {{ clean_label('referral_status_raw') }} = 'declined' then 'declined'
            when {{ clean_label('referral_status_raw') }} in ('not required', 'routine anc', 'counselled') then {{ clean_label('referral_status_raw') }}
            else null
        end as referral_status,

        initcap({{ clean_label('referred_facility_raw') }}) as referred_facility,
        case
            when {{ clean_label('transport_support_raw') }} in ('yes', 'y') then true
            when {{ clean_label('transport_support_raw') }} in ('no', 'n', 'not needed') then false
            else null
        end as transport_support,

        replace({{ clean_label('case_status_raw') }}, ' ', '_') as case_status,
        {{ clean_text('notes_raw') }} as notes,
        synthetic_record_flag

    from source

),

flagged as (

    select
        *,
        (
            risk_level in ('high', 'critical')
            or coalesce(hypertension_flag, false)
            or hemoglobin_g_dl < 10
            or age_years < 18
            or age_years > 35
            or danger_signs is not null
        ) as is_high_risk,
        referral_status in ('referred', 'referral_pending', 'accepted') as is_referred
    from cleaned

),

ranked as (

    select
        *,
        row_number() over (
            partition by visit_id
            order by source_loaded_at desc, source_row_id desc, maternal_risk_row_sk asc
        ) as visit_id_rank
    from flagged

)

select
    *,
    visit_id_rank > 1 as is_duplicate_visit_id
from ranked
