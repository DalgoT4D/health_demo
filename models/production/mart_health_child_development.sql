--DBT AUTOMATION has generated this model, please DO NOT EDIT 
--Please make sure you dont change the model name 

{{ config(materialized='table', schema='production') }}
WITH cte2 as (
SELECT "_airbyte_extracted_at", "_airbyte_generation_id", "_airbyte_meta", "_airbyte_raw_id", "age_months_clean", "age_months_source", "area", "assistive_device_raw", "caregiver_beneficiary_id", "case_status", "case_status_source", "child_id", "child_name", "communication_score_source", "diagnosis", "diagnosis_source", "district", "entered_by", "fine_motor_score_source", "gross_motor_score_source", "home_program_given_raw", "household_id", "linked_clinic_meeting_id_raw", "mother_id", "next_review_date_source", "notes_raw", "partner_ngo", "school_status", "school_status_source", "screening_tool", "screening_tool_source", "sessions_attended_source", "severity", "severity_source", "sex", "sex_clean", "social_score_source", "source_row_id", "state", "synthetic_record_flag", "therapy_referral", "therapy_referral_source", "therapy_referred_text", "tracking_id", "visit_date_clean1", "visit_date_source", "visit_date_text", "ward", TO_DATE("visit_date_text", 'YYYY-MM-DD') AS visit_date FROM {{ref('ui4t_finalstage_health_child_development')}}) , cte1 as (
SELECT
"_airbyte_extracted_at",
"_airbyte_generation_id",
"_airbyte_meta",
"_airbyte_raw_id",
"age_months_clean",
"age_months_source",
"area",
"assistive_device_raw",
"caregiver_beneficiary_id",
"case_status",
"case_status_source",
"child_id",
"child_name",
"communication_score_source",
"diagnosis",
"diagnosis_source",
"entered_by",
"fine_motor_score_source",
"gross_motor_score_source",
"home_program_given_raw",
"household_id",
"linked_clinic_meeting_id_raw",
"mother_id",
"next_review_date_source",
"notes_raw",
"partner_ngo",
"school_status",
"school_status_source",
"screening_tool",
"screening_tool_source",
"sessions_attended_source",
"severity",
"severity_source",
"sex",
"sex_clean",
"social_score_source",
"source_row_id",
"state",
"synthetic_record_flag",
"therapy_referral",
"therapy_referral_source",
"therapy_referred_text",
"tracking_id",
"visit_date",
"visit_date_clean1",
"visit_date_source",
"visit_date_text",
"ward",
REPLACE("district", 'THANE', 'Thane') AS "district"
FROM cte2
)
-- Final SELECT statement combining the outputs of all CTEs
SELECT *
FROM cte1