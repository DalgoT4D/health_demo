--DBT AUTOMATION has generated this model, please DO NOT EDIT 
--Please make sure you dont change the model name 

{{ config(materialized='table', schema='production') }}
WITH cte1 as (
SELECT "_airbyte_extracted_at", "_airbyte_generation_id", "_airbyte_meta", "_airbyte_raw_id", "age_years_raw", "anemia_status_raw", "area_raw", "beneficiary_id", "bmi_raw", "bp_diastolic_raw", "bp_systolic_raw", "case_status_raw", "danger_signs_raw", "district", "edd_raw", "field_worker_id_raw", "gestational_age_weeks_raw", "gravida_raw", "hemoglobin_g_dl_raw", "household_id_raw", "hypertension_flag_raw", "lmp_date_raw", "mother_id", "mother_name_raw", "next_visit_date_raw", "notes_raw", "parity_raw", "partner_ngo_raw", "pregnancy_id_raw", "prior_c_section_raw", "referral_status", "referral_status_raw", "referred_facility", "risk_level", "risk_level_raw", "source_row_id", "state", "synthetic_record_flag", "transport_support_raw", "visit_date_raw", "visit_date_text", "visit_id", "ward_raw", TO_DATE("visit_date_text", 'YYYY-MM-DD') AS visit_date FROM {{ref('ui4t_stage_health_maternal')}})
-- Final SELECT statement combining the outputs of all CTEs
SELECT *
FROM cte1