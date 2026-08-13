--DBT AUTOMATION has generated this model, please DO NOT EDIT 
--Please make sure you dont change the model name 

{{ config(materialized='table', schema='production') }}
WITH cte1 as (
SELECT "_airbyte_extracted_at", "_airbyte_generation_id", "_airbyte_meta", "_airbyte_raw_id", "action_taken_raw", "age_raw", "beneficiary_id", "child_id_raw", "clinic_site", "diagnosis_or_concern_raw", "district", "doctor_id_raw", "doctor_name_raw", "duration_mins_raw", "encounter_id", "entered_by", "follow_up_date", "household_id_raw", "last_updated_raw", "meeting_date_raw", "meeting_date_text", "meeting_id", "meeting_start_time_raw", "meeting_type", "meeting_type_raw", "notes_raw", "partner_ngo_raw", "patient_name_raw", "reason_for_visit_raw", "referral_source_raw", "sex", "sex_raw", "source_row_id", "speciality_raw", "state", "status", "status_raw", "synthetic_record_flag", TO_DATE("meeting_date_text", 'YYYY-MM-DD') AS meeting_date FROM {{ref('ui4t_stage_health_clinic')}})
-- Final SELECT statement combining the outputs of all CTEs
SELECT *
FROM cte1