with source as (

    select * from {{ source('staging_health', 'raw_chatbot_interactions') }}

),

cleaned as (

    select
        md5(concat_ws('||', coalesce(_airbyte_raw_id, ''), coalesce(source_row_id, ''))) as chatbot_interaction_row_sk,
        _airbyte_raw_id,
        _airbyte_extracted_at as source_loaded_at,
        _airbyte_generation_id,
        source_row_id,

        {{ clean_id('interaction_id_raw') }} as interaction_id,
        {{ clean_id('session_id_raw') }} as session_id,
        {{ clean_id('beneficiary_id_raw') }} as beneficiary_id,
        {{ clean_id('mother_id_raw') }} as mother_id,
        {{ clean_id('child_id_raw') }} as child_id,
        {{ clean_id('household_id_raw') }} as household_id,
        {{ clean_id('handoff_worker_id_raw') }} as handoff_worker_id,
        {{ clean_id('linked_record_id_raw') }} as linked_record_id,

        {{ parse_raw_date('interaction_ts_raw') }} as interaction_date,
        initcap({{ clean_label('channel_raw') }}) as channel,
        initcap({{ clean_label('language_raw') }}) as language,
        {{ clean_text('contact_last4_raw') }} as contact_last4,
        {{ bool_from_raw('consent_raw') }} as consent_given,

        replace({{ clean_label('intent_raw') }}, ' ', '_') as intent,
        case
            when {{ clean_text('intent_confidence_raw') }} like '%!%%' escape '!'
                then {{ first_numeric('intent_confidence_raw') }} / 100.0
            else {{ first_numeric('intent_confidence_raw') }}
        end as intent_confidence,

        case
            when {{ clean_label('message_count_raw') }} = 'one' then 1
            else {{ first_numeric('message_count_raw') }}::integer
        end as message_count,

        case
            when {{ clean_label('first_response_seconds_raw') }} like '<%' then {{ first_numeric('first_response_seconds_raw') }}
            when {{ clean_label('first_response_seconds_raw') }} = 'timeout' then null
            else {{ first_numeric('first_response_seconds_raw') }}
        end::integer as first_response_seconds,

        {{ bool_from_raw('escalated_to_human_raw') }} as escalated_to_human,
        case
            when {{ clean_label('escalation_reason_raw') }} in ('na', 'n/a') then null
            else {{ clean_label('escalation_reason_raw') }}
        end as escalation_reason,

        replace({{ clean_label('linked_record_type_raw') }}, ' ', '_') as linked_record_type,
        replace({{ clean_label('resolution_status_raw') }}, ' ', '_') as resolution_status,
        {{ clean_label('sentiment_raw') }} as sentiment,
        {{ clean_text('bot_version_raw') }} as bot_version,
        {{ clean_text('free_text_topic_raw') }} as free_text_topic,
        synthetic_record_flag

    from source

),

ranked as (

    select
        *,
        row_number() over (
            partition by interaction_id
            order by source_loaded_at desc, source_row_id desc, chatbot_interaction_row_sk asc
        ) as interaction_id_rank
    from cleaned

)

select
    *,
    interaction_id_rank > 1 as is_duplicate_interaction_id
from ranked
