select
    interaction_month,
    coalesce(district, 'Unknown') as district,
    coalesce(ward, 'Unknown') as ward,
    coalesce(area, 'Unknown') as area,
    coalesce(channel, 'Unknown') as channel,
    coalesce(language, 'Unknown') as language,
    coalesce(intent, 'Unknown') as intent,
    coalesce(linked_record_type, 'Unknown') as linked_record_type,
    coalesce(escalation_reason, 'None') as escalation_reason,
    coalesce(resolution_status, 'Unknown') as resolution_status,
    coalesce(sentiment, 'Unknown') as sentiment,
    coalesce(bot_version, 'Unknown') as bot_version,

    count(*) as interaction_count,
    count(distinct session_id) filter (where session_id is not null) as session_count,
    count(distinct beneficiary_id) filter (where beneficiary_id is not null) as unique_beneficiaries,
    count(distinct child_id) filter (where child_id is not null) as linked_children,
    count(distinct mother_id) filter (where mother_id is not null) as linked_mothers,
    sum(coalesce(escalated_to_human, false)::integer) as human_escalations,
    sum((sentiment = 'urgent')::integer) as urgent_interactions,
    sum((resolution_status = 'human_follow_up')::integer) as human_followups,
    sum((resolution_status = 'dropped')::integer) as dropped_interactions,
    sum((linked_record_id is not null)::integer) as linked_record_count,
    round(avg(intent_confidence), 3) as avg_intent_confidence,
    round(avg(first_response_seconds), 1) as avg_first_response_seconds,
    round(avg(message_count), 1) as avg_message_count
from {{ ref('fct_health_chatbot_interactions') }}
where interaction_month is not null
group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
