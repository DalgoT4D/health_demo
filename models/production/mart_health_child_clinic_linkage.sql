--DBT AUTOMATION has generated this model, please DO NOT EDIT 
--Please make sure you dont change the model name 

{{ config(materialized='table', schema='production') }}
WITH cte1 as (

SELECT "t1"."_airbyte_extracted_at",
"t1"."_airbyte_generation_id",
"t1"."_airbyte_meta",
"t1"."_airbyte_raw_id",
"t1"."age_months_clean",
"t1"."age_months_source",
"t1"."area",
"t1"."assistive_device_raw",
"t1"."caregiver_beneficiary_id",
"t1"."case_status",
"t1"."case_status_source",
"t1"."child_id",
"t1"."child_name",
"t1"."communication_score_source",
"t1"."diagnosis",
"t1"."diagnosis_source",
"t1"."entered_by",
"t1"."fine_motor_score_source",
"t1"."gross_motor_score_source",
"t1"."home_program_given_raw",
"t1"."household_id",
"t1"."linked_clinic_meeting_id_raw",
"t1"."mother_id",
"t1"."next_review_date_source",
"t1"."notes_raw",
"t1"."partner_ngo",
"t1"."school_status",
"t1"."school_status_source",
"t1"."screening_tool",
"t1"."screening_tool_source",
"t1"."sessions_attended_source",
"t1"."severity",
"t1"."severity_source",
"t1"."sex",
"t1"."sex_clean",
"t1"."social_score_source",
"t1"."source_row_id",
"t1"."state",
"t1"."synthetic_record_flag",
"t1"."therapy_referral",
"t1"."therapy_referral_source",
"t1"."therapy_referred_text",
"t1"."tracking_id",
"t1"."visit_date",
"t1"."visit_date_clean1",
"t1"."visit_date_source",
"t1"."visit_date_text",
"t1"."ward",
"t1"."district"
 FROM {{ref('mart_health_child_development')}} t1
 LEFT JOIN {{ref('ui4t_health_clinic_meetings_unique')}} t2
 ON "t1"."linked_clinic_meeting_id_raw" = "t2"."meeting_id"
)
-- Final SELECT statement combining the outputs of all CTEs
SELECT *
FROM cte1