--DBT AUTOMATION has generated this model, please DO NOT EDIT 
--Please make sure you dont change the model name 

{{ config(materialized='table', schema='production') }}
WITH cte7 as (
SELECT "_airbyte_raw_id", "_airbyte_extracted_at", "_airbyte_meta", "_airbyte_generation_id", "intent_raw", "channel_raw", "consent_raw", "child_id_raw", "language_raw", "mother_id_raw", "sentiment_raw", "source_row_id", "session_id_raw", "bot_version_raw", "partner_ngo_raw", "household_id_raw", "contact_last4_raw", "message_count_raw", "free_text_topic_raw", "linked_record_id_raw", "escalation_reason_raw", "handoff_worker_id_raw", "intent_confidence_raw", "resolution_status_raw", "synthetic_record_flag", "escalated_to_human_raw", "linked_record_type_raw", "first_response_seconds_raw", "state_raw" AS "state", "district_raw" AS "district", "beneficiary_id_raw" AS "beneficiary_id", "interaction_id_raw" AS "interaction_id", "interaction_ts_raw" AS "interaction_timestamp"
 FROM {{source('staging_health', 'raw_chatbot_interactions')}}
) , cte6 as (
SELECT
"_airbyte_extracted_at",
"_airbyte_generation_id",
"_airbyte_meta",
"_airbyte_raw_id",
"beneficiary_id",
"bot_version_raw",
"channel_raw",
"child_id_raw",
"consent_raw",
"contact_last4_raw",
"district",
"escalated_to_human_raw",
"escalation_reason_raw",
"first_response_seconds_raw",
"free_text_topic_raw",
"handoff_worker_id_raw",
"household_id_raw",
"intent_confidence_raw",
"intent_raw",
"interaction_id",
"interaction_timestamp",
"language_raw",
"linked_record_id_raw",
"linked_record_type_raw",
"message_count_raw",
"mother_id_raw",
"partner_ngo_raw",
"resolution_status_raw",
"sentiment_raw",
"session_id_raw",
"source_row_id",
"state",
"synthetic_record_flag",
CASE
    WHEN "intent_raw" = ' ANC visit question' THEN 'ANC Visit Question'
    WHEN "intent_raw" = 'ANC visit question' THEN 'ANC Visit Question'
    WHEN "intent_raw" = 'ANC visit question ' THEN 'ANC Visit Question'
    WHEN "intent_raw" = 'ANC VISIT QUESTION' THEN 'ANC Visit Question'
    WHEN "intent_raw" = 'appointment reminder' THEN 'Appointment Reminder'
    WHEN "intent_raw" = 'APPOINTMENT REMINDER' THEN 'Appointment Reminder'
    WHEN "intent_raw" = ' child development screening' THEN 'Child Development Screening'
    WHEN "intent_raw" = 'child development screening' THEN 'Child Development Screening'
    WHEN "intent_raw" = 'child development screening ' THEN 'Child Development Screening'
    WHEN "intent_raw" = 'danger sign' THEN 'Danger Sign'
    WHEN "intent_raw" = 'emergency referral' THEN 'Emergency Referral'
    WHEN "intent_raw" = 'emergency referral ' THEN 'Emergency Referral'
    WHEN "intent_raw" = 'feedback' THEN 'Feedback'
    WHEN "intent_raw" = 'FEEDBACK' THEN 'Feedback'
    WHEN "intent_raw" = 'follow-up status' THEN 'Follow-Up Status'
    WHEN "intent_raw" = 'language change' THEN 'Language Change'
    WHEN "intent_raw" = 'LANGUAGE CHANGE' THEN 'Language Change'
    WHEN "intent_raw" = 'mental health support' THEN 'Mental Health Support'
    WHEN "intent_raw" = 'mental health support ' THEN 'Mental Health Support'
    WHEN "intent_raw" = 'nutrition advice' THEN 'Nutrition Advice'
    WHEN "intent_raw" = 'nutrition advice ' THEN 'Nutrition Advice'
    WHEN "intent_raw" = ' period product request' THEN 'Period Product Request'
    WHEN "intent_raw" = 'period product request' THEN 'Period Product Request'
    WHEN "intent_raw" = 'period product request ' THEN 'Period Product Request'
    WHEN "intent_raw" = ' pregnancy danger sign' THEN 'Pregnancy Danger Sign'
    WHEN "intent_raw" = 'pregnancy danger sign' THEN 'Pregnancy Danger Sign'
    WHEN "intent_raw" = ' program eligibility' THEN 'Program Eligibility'
    WHEN "intent_raw" = 'program eligibility' THEN 'Program Eligibility'
    WHEN "intent_raw" = 'PROGRAM ELIGIBILITY' THEN 'Program Eligibility'
    WHEN "intent_raw" = 'stockout report' THEN 'Stockout Report'
    WHEN "intent_raw" = ' therapy home activity' THEN 'Therapy Home Activity'
    WHEN "intent_raw" = 'therapy home activity' THEN 'Therapy Home Activity'
    ELSE 'Other'
END AS "intent"
FROM cte7
) , cte5 as (
SELECT
"_airbyte_extracted_at",
"_airbyte_generation_id",
"_airbyte_meta",
"_airbyte_raw_id",
"beneficiary_id",
"bot_version_raw",
"channel_raw",
"child_id_raw",
"consent_raw",
"contact_last4_raw",
"district",
"escalated_to_human_raw",
"escalation_reason_raw",
"first_response_seconds_raw",
"free_text_topic_raw",
"handoff_worker_id_raw",
"household_id_raw",
"intent",
"intent_confidence_raw",
"intent_raw",
"interaction_id",
"interaction_timestamp",
"language_raw",
"linked_record_id_raw",
"linked_record_type_raw",
"message_count_raw",
"mother_id_raw",
"partner_ngo_raw",
"resolution_status_raw",
"sentiment_raw",
"session_id_raw",
"source_row_id",
"state",
"synthetic_record_flag",
CASE
    WHEN "language_raw" = 'Assamese' THEN 'Assamese'
    WHEN "language_raw" = 'Bengali' THEN 'Bengali'
    WHEN "language_raw" = 'English' THEN 'English'
    WHEN "language_raw" = 'English ' THEN 'English'
    WHEN "language_raw" = 'ENGLISH' THEN 'English'
    WHEN "language_raw" = 'hindi' THEN 'Hindi'
    WHEN "language_raw" = 'Hindi' THEN 'Hindi'
    WHEN "language_raw" = ' Hindi' THEN 'Hindi'
    WHEN "language_raw" = 'Hindi ' THEN 'Hindi'
    WHEN "language_raw" = 'HINDI' THEN 'Hindi'
    WHEN "language_raw" = 'hinglish' THEN 'Hinglish'
    WHEN "language_raw" = 'Hinglish' THEN 'Hinglish'
    WHEN "language_raw" = ' Hinglish' THEN 'Hinglish'
    WHEN "language_raw" = 'Hinglish ' THEN 'Hinglish'
    WHEN "language_raw" = 'HINGLISH' THEN 'Hinglish'
    WHEN "language_raw" = 'Kannada' THEN 'Kannada'
    WHEN "language_raw" = 'marathi' THEN 'Marathi'
    WHEN "language_raw" = 'Marathi' THEN 'Marathi'
    WHEN "language_raw" = ' Marathi' THEN 'Marathi'
    WHEN "language_raw" = 'Marathi ' THEN 'Marathi'
    WHEN "language_raw" = 'Tamil' THEN 'Tamil'
    WHEN "language_raw" = 'Tamil ' THEN 'Tamil'
    WHEN "language_raw" = 'TAMIL' THEN 'Tamil'
    WHEN "language_raw" = 'Urdu' THEN 'Urdu'
    WHEN "language_raw" = ' Urdu' THEN 'Urdu'
    ELSE 'Other'
END AS "language"
FROM cte6
) , cte4 as (
SELECT
"_airbyte_extracted_at",
"_airbyte_generation_id",
"_airbyte_meta",
"_airbyte_raw_id",
"beneficiary_id",
"bot_version_raw",
"channel_raw",
"child_id_raw",
"consent_raw",
"contact_last4_raw",
"district",
"escalated_to_human_raw",
"escalation_reason_raw",
"first_response_seconds_raw",
"free_text_topic_raw",
"handoff_worker_id_raw",
"household_id_raw",
"intent",
"intent_confidence_raw",
"intent_raw",
"interaction_id",
"interaction_timestamp",
"language",
"language_raw",
"linked_record_id_raw",
"linked_record_type_raw",
"message_count_raw",
"mother_id_raw",
"partner_ngo_raw",
"resolution_status_raw",
"sentiment_raw",
"session_id_raw",
"source_row_id",
"state",
"synthetic_record_flag",
CASE
    WHEN "resolution_status_raw" = 'dropped' THEN 'Dropped'
    WHEN "resolution_status_raw" = ' dropped' THEN 'Dropped'
    WHEN "resolution_status_raw" = 'dropped ' THEN 'Dropped'
    WHEN "resolution_status_raw" = 'duplicate' THEN 'Duplicate'
    WHEN "resolution_status_raw" = 'DUPLICATE' THEN 'Duplicate'
    WHEN "resolution_status_raw" = ' human follow-up' THEN 'Human Follow-Up'
    WHEN "resolution_status_raw" = 'human follow up' THEN 'Human Follow-Up'
    WHEN "resolution_status_raw" = 'human follow-up' THEN 'Human Follow-Up'
    WHEN "resolution_status_raw" = 'human follow-up ' THEN 'Human Follow-Up'
    WHEN "resolution_status_raw" = 'HUMAN FOLLOW-UP' THEN 'Human Follow-Up'
    WHEN "resolution_status_raw" = 'pending' THEN 'Pending'
    WHEN "resolution_status_raw" = ' pending' THEN 'Pending'
    WHEN "resolution_status_raw" = 'pending ' THEN 'Pending'
    WHEN "resolution_status_raw" = 'PENDING' THEN 'Pending'
    WHEN "resolution_status_raw" = ' resolved by bot' THEN 'Resolved By Bot'
    WHEN "resolution_status_raw" = 'resolved by bot' THEN 'Resolved By Bot'
    WHEN "resolution_status_raw" = 'resolved by bot ' THEN 'Resolved By Bot'
    WHEN "resolution_status_raw" = 'RESOLVED BY BOT' THEN 'Resolved By Bot'
    WHEN "resolution_status_raw" = 'unknown' THEN 'Unknown'
    WHEN "resolution_status_raw" = ' unknown' THEN 'Unknown'
    ELSE 'Unknown'
END AS "resolution_status"
FROM cte5
) , cte3 as (
SELECT
"_airbyte_extracted_at",
"_airbyte_generation_id",
"_airbyte_meta",
"_airbyte_raw_id",
"beneficiary_id",
"bot_version_raw",
"channel_raw",
"child_id_raw",
"consent_raw",
"contact_last4_raw",
"district",
"escalated_to_human_raw",
"escalation_reason_raw",
"first_response_seconds_raw",
"free_text_topic_raw",
"handoff_worker_id_raw",
"household_id_raw",
"intent",
"intent_confidence_raw",
"intent_raw",
"interaction_id",
"interaction_timestamp",
"language",
"language_raw",
"linked_record_id_raw",
"linked_record_type_raw",
"message_count_raw",
"mother_id_raw",
"partner_ngo_raw",
"resolution_status",
"resolution_status_raw",
"sentiment_raw",
"session_id_raw",
"source_row_id",
"state",
"synthetic_record_flag",
CASE
    WHEN "escalated_to_human_raw" = 'N' THEN 'false'
    WHEN "escalated_to_human_raw" = 'no' THEN 'false'
    WHEN "escalated_to_human_raw" = 'No' THEN 'false'
    WHEN "escalated_to_human_raw" = ' No' THEN 'false'
    WHEN "escalated_to_human_raw" = 'No ' THEN 'false'
    WHEN "escalated_to_human_raw" = 'NO' THEN 'false'
    WHEN "escalated_to_human_raw" = 'Y' THEN 'true'
    WHEN "escalated_to_human_raw" = ' Y' THEN 'true'
    WHEN "escalated_to_human_raw" = 'yes' THEN 'true'
    WHEN "escalated_to_human_raw" = 'Yes' THEN 'true'
    WHEN "escalated_to_human_raw" = ' Yes' THEN 'true'
    WHEN "escalated_to_human_raw" = 'Yes ' THEN 'true'
    WHEN "escalated_to_human_raw" = 'YES' THEN 'true'
    ELSE 'false'
END AS "escalated_to_human"
FROM cte4
) , cte2 as (
SELECT
"_airbyte_extracted_at",
"_airbyte_generation_id",
"_airbyte_meta",
"_airbyte_raw_id",
"beneficiary_id",
"bot_version_raw",
"channel_raw",
"child_id_raw",
"consent_raw",
"contact_last4_raw",
"district",
"escalated_to_human",
"escalated_to_human_raw",
"escalation_reason_raw",
"first_response_seconds_raw",
"free_text_topic_raw",
"handoff_worker_id_raw",
"household_id_raw",
"intent",
"intent_confidence_raw",
"intent_raw",
"interaction_id",
"interaction_timestamp",
"language",
"language_raw",
"linked_record_id_raw",
"linked_record_type_raw",
"message_count_raw",
"mother_id_raw",
"partner_ngo_raw",
"resolution_status",
"resolution_status_raw",
"sentiment_raw",
"session_id_raw",
"source_row_id",
"state",
"synthetic_record_flag",
CASE
    WHEN "escalation_reason_raw" = 'danger sign' THEN 'Danger Sign'
    WHEN "escalation_reason_raw" = 'language issue' THEN 'Language Issue'
    WHEN "escalation_reason_raw" = 'low confidence' THEN 'Low Confidence'
    WHEN "escalation_reason_raw" = 'LOW CONFIDENCE' THEN 'Low Confidence'
    WHEN "escalation_reason_raw" = 'NA' THEN 'Not Applicable'
    WHEN "escalation_reason_raw" = 'N/A' THEN 'Not Applicable'
    WHEN "escalation_reason_raw" = 'not recorded' THEN 'Not Applicable'
    WHEN "escalation_reason_raw" = '__NULL__' THEN 'Not Applicable'
    WHEN "escalation_reason_raw" = 'possible emergency' THEN 'Possible Emergency'
    WHEN "escalation_reason_raw" = 'service delay' THEN 'Service Delay'
    WHEN "escalation_reason_raw" = 'user requested call' THEN 'User Requested Call'
    WHEN "escalation_reason_raw" = 'USER REQUESTED CALL' THEN 'User Requested Call'
    ELSE 'Not Applicable'
END AS "escalation_reason"
FROM cte3
) , cte1 as (
SELECT
"_airbyte_extracted_at",
"_airbyte_generation_id",
"_airbyte_meta",
"_airbyte_raw_id",
"beneficiary_id",
"bot_version_raw",
"channel_raw",
"child_id_raw",
"consent_raw",
"contact_last4_raw",
"district",
"escalated_to_human",
"escalated_to_human_raw",
"escalation_reason",
"escalation_reason_raw",
"first_response_seconds_raw",
"free_text_topic_raw",
"handoff_worker_id_raw",
"household_id_raw",
"intent",
"intent_confidence_raw",
"intent_raw",
"interaction_id",
"interaction_timestamp",
"language",
"language_raw",
"linked_record_id_raw",
"linked_record_type_raw",
"message_count_raw",
"mother_id_raw",
"partner_ngo_raw",
"resolution_status",
"resolution_status_raw",
"sentiment_raw",
"session_id_raw",
"source_row_id",
"state",
"synthetic_record_flag",
CASE
    WHEN "channel_raw" = 'field app' THEN 'Field App'
    WHEN "channel_raw" = ' Field app' THEN 'Field App'
    WHEN "channel_raw" = 'Field app' THEN 'Field App'
    WHEN "channel_raw" = 'Field app ' THEN 'Field App'
    WHEN "channel_raw" = 'IVR' THEN 'IVR'
    WHEN "channel_raw" = ' IVR' THEN 'IVR'
    WHEN "channel_raw" = 'IVR ' THEN 'IVR'
    WHEN "channel_raw" = 'sms' THEN 'SMS'
    WHEN "channel_raw" = 'SMS' THEN 'SMS'
    WHEN "channel_raw" = ' SMS' THEN 'SMS'
    WHEN "channel_raw" = 'SMS ' THEN 'SMS'
    WHEN "channel_raw" = 'web chat' THEN 'Web Chat'
    WHEN "channel_raw" = ' Web chat' THEN 'Web Chat'
    WHEN "channel_raw" = 'Web chat' THEN 'Web Chat'
    WHEN "channel_raw" = 'Web chat ' THEN 'Web Chat'
    WHEN "channel_raw" = 'WEB CHAT' THEN 'Web Chat'
    WHEN "channel_raw" = 'WhatsApp' THEN 'WhatsApp'
    WHEN "channel_raw" = ' WhatsApp' THEN 'WhatsApp'
    WHEN "channel_raw" = 'WhatsApp ' THEN 'WhatsApp'
    WHEN "channel_raw" = 'WHATSAPP' THEN 'WhatsApp'
    ELSE 'Other'
END AS "channel"
FROM cte2
)
-- Final SELECT statement combining the outputs of all CTEs
SELECT *
FROM cte1