with source as (

    select * from {{ source('staging_health', 'raw_child_dev_tracking') }}

),

cleaned as (

    select
        md5(concat_ws('||', coalesce(_airbyte_raw_id, ''), coalesce(source_row_id, ''))) as child_development_row_sk,
        _airbyte_raw_id,
        _airbyte_extracted_at as source_loaded_at,
        _airbyte_generation_id,
        source_row_id,

        {{ clean_id('tracking_id_raw') }} as tracking_id,
        {{ clean_id('child_id_raw') }} as child_id,
        {{ clean_id('caregiver_beneficiary_id_raw') }} as caregiver_beneficiary_id,
        {{ clean_id('mother_id_raw') }} as mother_id,
        {{ clean_id('household_id_raw') }} as household_id,
        {{ clean_id('linked_clinic_meeting_id_raw') }} as linked_clinic_meeting_id,

        initcap({{ clean_label('child_name_raw') }}) as child_name,
        {{ parse_raw_date('visit_date_raw') }} as visit_date,
        {{ parse_raw_date('next_review_date_raw') }} as next_review_date,

        case
            when {{ clean_label('age_months_raw') }} like '%year%' or {{ clean_label('age_months_raw') }} like '%yr%'
                then ({{ first_numeric('age_months_raw') }} * 12)::integer
            else {{ first_numeric('age_months_raw') }}::integer
        end as age_months,

        case
            when {{ clean_label('sex_raw') }} in ('f', 'female') then 'female'
            when {{ clean_label('sex_raw') }} in ('m', 'male') then 'male'
            else null
        end as sex,

        initcap({{ clean_label('district_raw') }}) as district,
        upper({{ clean_text('ward_raw') }}) as ward,
        initcap({{ clean_label('area_raw') }}) as area,

        case
            when {{ clean_label('screening_tool_raw') }} in ('asq 3', 'asq-3') then 'ASQ-3'
            when {{ clean_label('screening_tool_raw') }} in ('m chat r', 'm-chat-r') then 'M-CHAT-R'
            when {{ clean_label('screening_tool_raw') }} like '%therapy%' then 'therapy_progress_checklist'
            else upper({{ clean_label('screening_tool_raw') }})
        end as screening_tool,

        {{ clean_label('diagnosis_raw') }} as diagnosis,
        case
            when {{ clean_label('severity_raw') }} in ('mild', 'moderate', 'severe', 'at risk') then replace({{ clean_label('severity_raw') }}, ' ', '_')
            else null
        end as severity,

        {{ first_numeric('gross_motor_score_raw') }}::integer as gross_motor_score,
        {{ first_numeric('fine_motor_score_raw') }}::integer as fine_motor_score,
        {{ first_numeric('communication_score_raw') }}::integer as communication_score,
        {{ first_numeric('social_score_raw') }}::integer as social_score,

        (
            {{ clean_label('gross_motor_score_raw') }} like '%below%'
            or {{ clean_label('communication_score_raw') }} like '%below%'
            or {{ first_numeric('gross_motor_score_raw') }} < 35
            or {{ first_numeric('fine_motor_score_raw') }} < 35
            or {{ first_numeric('communication_score_raw') }} < 35
            or {{ first_numeric('social_score_raw') }} < 35
        ) as has_below_cutoff_score,

        case
            when {{ clean_label('therapy_referred_raw') }} like '%speech%' then 'speech_therapy'
            when {{ clean_label('therapy_referred_raw') }} like '%occupation%' then 'occupational_therapy'
            when {{ clean_label('therapy_referred_raw') }} like '%physio%' then 'physiotherapy'
            when {{ clean_label('therapy_referred_raw') }} like '%psychology%' then 'psychology'
            when {{ clean_label('therapy_referred_raw') }} like '%multi%' then 'multi_disciplinary'
            when {{ clean_label('therapy_referred_raw') }} = 'none' then 'none'
            else {{ clean_label('therapy_referred_raw') }}
        end as therapy_referred,

        {{ first_numeric('sessions_attended_last_month_raw') }}::integer as sessions_attended_last_month,
        replace({{ clean_label('school_status_raw') }}, ' ', '_') as school_status,
        replace({{ clean_label('assistive_device_raw') }}, ' ', '_') as assistive_device,
        {{ bool_from_raw('home_program_given_raw') }} as home_program_given,
        replace({{ clean_label('case_status_raw') }}, ' ', '_') as case_status,
        {{ clean_text('entered_by') }} as entered_by,
        {{ clean_text('notes_raw') }} as notes,
        synthetic_record_flag

    from source

),

ranked as (

    select
        *,
        row_number() over (
            partition by tracking_id
            order by source_loaded_at desc, source_row_id desc, child_development_row_sk asc
        ) as tracking_id_rank
    from cleaned

)

select
    *,
    tracking_id_rank > 1 as is_duplicate_tracking_id,
    case_status = 'active' as is_active_case
from ranked
