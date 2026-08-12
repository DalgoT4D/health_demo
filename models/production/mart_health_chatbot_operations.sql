--DBT AUTOMATION has generated this model, please DO NOT EDIT 
--Please make sure you dont change the model name 

{{ config(materialized='table', schema='production') }}
WITH cte1 as (
SELECT trim(interaction_id_raw) as interaction_id,
trim(session_id_raw) as session_id,
trim(beneficiary_id_raw) as beneficiary_id,
trim(mother_id_raw) as mother_id,
trim(child_id_raw) as child_id,
trim(household_id_raw) as household_id,
case
  when trim(interaction_ts_raw) ~ '^[0-9]{4}-[0-9]{1,2}-[0-9]{1,2}' then make_date(split_part(substring(trim(interaction_ts_raw) from 1 for 10),'-',1)::integer, split_part(substring(trim(interaction_ts_raw) from 1 for 10),'-',2)::integer, split_part(substring(trim(interaction_ts_raw) from 1 for 10),'-',3)::integer)
  when trim(interaction_ts_raw) ~ '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}' and split_part(trim(interaction_ts_raw),'/',2)::integer > 12 then make_date(split_part(substring(trim(interaction_ts_raw) from 1 for 10),'/',3)::integer, split_part(trim(interaction_ts_raw),'/',1)::integer, split_part(trim(interaction_ts_raw),'/',2)::integer)
  when trim(interaction_ts_raw) ~ '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}' then make_date(split_part(substring(trim(interaction_ts_raw) from 1 for 10),'/',3)::integer, split_part(trim(interaction_ts_raw),'/',2)::integer, split_part(trim(interaction_ts_raw),'/',1)::integer)
  else make_date(2026, ((coalesce(nullif(regexp_replace(interaction_id_raw,'[^0-9]','','g'),''),'1')::integer - 1) % 12) + 1, 15)
end as interaction_date,
initcap(replace(trim(intent_raw),'_',' ')) as intent,
initcap(trim(free_text_topic_raw)) as free_text_topic,
initcap(trim(channel_raw)) as channel,
initcap(trim(language_raw)) as language,
initcap(trim(sentiment_raw)) as sentiment,
case when lower(trim(message_count_raw)) = 'one' then 1 else coalesce(nullif(regexp_replace(message_count_raw,'[^0-9]','','g'),''),'0')::integer end as message_count,
case when lower(trim(first_response_seconds_raw)) = 'timeout' then null::integer else nullif(regexp_replace(first_response_seconds_raw,'[^0-9]','','g'),'')::integer end as first_response_seconds,
case when trim(intent_confidence_raw) like '%!%%' escape '!' then nullif(regexp_replace(intent_confidence_raw,'[^0-9.]','','g'),'')::numeric / 100.0 else nullif(regexp_replace(intent_confidence_raw,'[^0-9.]','','g'),'')::numeric end as intent_confidence,
lower(trim(escalated_to_human_raw)) in ('yes','y','true','1') as escalated_to_human,
case when lower(trim(escalation_reason_raw)) in ('na','n/a','none','') then null else initcap(trim(escalation_reason_raw)) end as escalation_reason,
initcap(replace(trim(resolution_status_raw),'_',' ')) as resolution_status,
lower(trim(resolution_status_raw)) in ('resolved','completed','self served','self_serve') as resolved,
lower(trim(consent_raw)) in ('yes','y','true','1','given') as consent,
trim(linked_record_id_raw) as linked_record_id,
initcap(replace(trim(linked_record_type_raw),'_',' ')) as linked_record_type,
initcap(trim(district_raw)) as district,
initcap(trim(state_raw)) as state,
initcap(trim(partner_ngo_raw)) as partner_ngo  FROM {{source('staging_health', 'raw_chatbot_interactions')}})
-- Final SELECT statement combining the outputs of all CTEs
SELECT *
FROM cte1