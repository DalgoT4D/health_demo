--DBT AUTOMATION has generated this model, please DO NOT EDIT 
--Please make sure you dont change the model name 

{{ config(materialized='table', schema='ui4t_staging') }}
WITH cte10 as (
SELECT "_airbyte_raw_id", "_airbyte_extracted_at", "_airbyte_meta", "_airbyte_generation_id", "notes_raw", "entered_by", "source_row_id", "assistive_device_raw", "synthetic_record_flag", "home_program_given_raw", "linked_clinic_meeting_id_raw", "sex_raw" AS "sex", "area_raw" AS "area", "ward_raw" AS "ward", "state_raw" AS "state", "child_id_raw" AS "child_id", "district_raw" AS "district", "severity_raw" AS "severity_source", "diagnosis_raw" AS "diagnosis_source", "mother_id_raw" AS "mother_id", "age_months_raw" AS "age_months_source", "child_name_raw" AS "child_name", "visit_date_raw" AS "visit_date_source", "case_status_raw" AS "case_status_source", "partner_ngo_raw" AS "partner_ngo", "tracking_id_raw" AS "tracking_id", "household_id_raw" AS "household_id", "social_score_raw" AS "social_score_source", "school_status_raw" AS "school_status_source", "screening_tool_raw" AS "screening_tool_source", "fine_motor_score_raw" AS "fine_motor_score_source", "next_review_date_raw" AS "next_review_date_source", "therapy_referred_raw" AS "therapy_referral_source", "gross_motor_score_raw" AS "gross_motor_score_source", "communication_score_raw" AS "communication_score_source", "caregiver_beneficiary_id_raw" AS "caregiver_beneficiary_id", "sessions_attended_last_month_raw" AS "sessions_attended_source"
 FROM {{source('staging_health', 'raw_child_dev_tracking')}}
) , cte9 as (
SELECT
"_airbyte_extracted_at",
"_airbyte_generation_id",
"_airbyte_meta",
"_airbyte_raw_id",
"age_months_source",
"area",
"assistive_device_raw",
"caregiver_beneficiary_id",
"case_status_source",
"child_id",
"child_name",
"communication_score_source",
"diagnosis_source",
"district",
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
"school_status_source",
"screening_tool_source",
"sessions_attended_source",
"severity_source",
"sex",
"social_score_source",
"source_row_id",
"state",
"synthetic_record_flag",
"therapy_referral_source",
"tracking_id",
"visit_date_source",
"ward",
CASE
    WHEN "sex" = 'F' THEN 'Female'
    WHEN "sex" = 'Female' THEN 'Female'
    WHEN "sex" = 'M' THEN 'Male'
    WHEN "sex" = 'Male' THEN 'Male'
    WHEN "sex" = 'f' THEN 'Female'
    WHEN "sex" = ' F' THEN 'Female'
    WHEN "sex" = 'F ' THEN 'Female'
    WHEN "sex" = 'm' THEN 'Male'
    WHEN "sex" = ' M' THEN 'Male'
    WHEN "sex" = 'M ' THEN 'Male'
    WHEN "sex" = ' Male' THEN 'Male'
    ELSE 'Unknown'
END AS "sex_clean"
FROM cte10
) , cte8 as (
SELECT
"_airbyte_extracted_at",
"_airbyte_generation_id",
"_airbyte_meta",
"_airbyte_raw_id",
"age_months_source",
"area",
"assistive_device_raw",
"caregiver_beneficiary_id",
"case_status_source",
"child_id",
"child_name",
"communication_score_source",
"diagnosis_source",
"district",
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
"school_status_source",
"screening_tool_source",
"sessions_attended_source",
"severity_source",
"sex",
"sex_clean",
"social_score_source",
"source_row_id",
"state",
"synthetic_record_flag",
"therapy_referral_source",
"tracking_id",
"visit_date_source",
"ward",
CASE
    WHEN "age_months_source" = '1 years' THEN '12'
    WHEN "age_months_source" = '2 years' THEN '24'
    WHEN "age_months_source" = '3 years' THEN '36'
    WHEN "age_months_source" = '4 years' THEN '48'
    WHEN "age_months_source" = '5 years' THEN '60'
    WHEN "age_months_source" = '6 years' THEN '72'
    WHEN "age_months_source" = '7 years' THEN '84'
    WHEN "age_months_source" = '8 years' THEN '96'
    WHEN "age_months_source" = '9 years' THEN '108'
    WHEN "age_months_source" = '10 years' THEN '120'
    WHEN "age_months_source" = '11 years' THEN '132'
    ELSE "age_months_source"
END AS "age_months_clean"
FROM cte9
) , cte7 as (
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
"case_status_source",
"child_id",
"child_name",
"communication_score_source",
"diagnosis_source",
"district",
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
"school_status_source",
"screening_tool_source",
"sessions_attended_source",
"severity_source",
"sex",
"sex_clean",
"social_score_source",
"source_row_id",
"state",
"synthetic_record_flag",
"therapy_referral_source",
"tracking_id",
"visit_date_source",
"ward",
CASE
    WHEN "severity_source" = ' at risk' THEN 'At Risk'
    WHEN "severity_source" = 'at risk' THEN 'At Risk'
    WHEN "severity_source" = 'at risk ' THEN 'At Risk'
    WHEN "severity_source" = 'mild' THEN 'Mild'
    WHEN "severity_source" = ' mild' THEN 'Mild'
    WHEN "severity_source" = 'moderate' THEN 'Moderate'
    WHEN "severity_source" = ' moderate' THEN 'Moderate'
    WHEN "severity_source" = 'MODERATE' THEN 'Moderate'
    WHEN "severity_source" = 'not assessed' THEN 'Not Assessed'
    WHEN "severity_source" = 'severe' THEN 'Severe'
    WHEN "severity_source" = 'severe ' THEN 'Severe'
    WHEN "severity_source" = 'SEVERE' THEN 'Severe'
    ELSE 'Not Assessed'
END AS "severity"
FROM cte8
) , cte6 as (
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
"case_status_source",
"child_id",
"child_name",
"communication_score_source",
"diagnosis_source",
"district",
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
"school_status_source",
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
"therapy_referral_source",
"tracking_id",
"visit_date_source",
"ward",
CASE
    WHEN "diagnosis_source" = 'autism risk' THEN 'Autism Risk'
    WHEN "diagnosis_source" = 'autism spectrum concern' THEN 'Autism Spectrum Concern'
    WHEN "diagnosis_source" = 'behavioral concern' THEN 'Behavioral Concern'
    WHEN "diagnosis_source" = 'BEHAVIORAL CONCERN' THEN 'Behavioral Concern'
    WHEN "diagnosis_source" = 'cerebral palsy' THEN 'Cerebral Palsy'
    WHEN "diagnosis_source" = 'cerebral palsy ' THEN 'Cerebral Palsy'
    WHEN "diagnosis_source" = 'developmental risk - prematurity' THEN 'Developmental Risk - Prematurity'
    WHEN "diagnosis_source" = ' global developmental delay' THEN 'Global Developmental Delay'
    WHEN "diagnosis_source" = 'global developmental delay' THEN 'Global Developmental Delay'
    WHEN "diagnosis_source" = 'hearing impairment' THEN 'Hearing Impairment'
    WHEN "diagnosis_source" = 'HEARING IMPAIRMENT' THEN 'Hearing Impairment'
    WHEN "diagnosis_source" = 'learning difficulty' THEN 'Learning Difficulty'
    WHEN "diagnosis_source" = 'learning difficulty ' THEN 'Learning Difficulty'
    WHEN "diagnosis_source" = 'motor delay' THEN 'Motor Delay'
    WHEN "diagnosis_source" = ' no formal diagnosis' THEN 'No Formal Diagnosis'
    WHEN "diagnosis_source" = 'no formal diagnosis' THEN 'No Formal Diagnosis'
    WHEN "diagnosis_source" = 'NO FORMAL DIAGNOSIS' THEN 'No Formal Diagnosis'
    WHEN "diagnosis_source" = 'speech and language delay' THEN 'Speech And Language Delay'
    WHEN "diagnosis_source" = 'speech delay' THEN 'Speech Delay'
    ELSE 'No Formal Diagnosis'
END AS "diagnosis"
FROM cte7
) , cte5 as (
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
"case_status_source",
"child_id",
"child_name",
"communication_score_source",
"diagnosis",
"diagnosis_source",
"district",
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
"school_status_source",
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
"therapy_referral_source",
"tracking_id",
"visit_date_source",
"ward",
CASE
    WHEN "therapy_referral_source" = 'multi-disciplinary' THEN 'Multi-Disciplinary'
    WHEN "therapy_referral_source" = 'multi-disciplinary ' THEN 'Multi-Disciplinary'
    WHEN "therapy_referral_source" = 'MULTI-DISCIPLINARY' THEN 'Multi-Disciplinary'
    WHEN "therapy_referral_source" = NULL THEN NULL
    WHEN "therapy_referral_source" = NULL THEN NULL
    WHEN "therapy_referral_source" = NULL THEN NULL
    WHEN "therapy_referral_source" = ' occupational therapy' THEN 'Occupational Therapy'
    WHEN "therapy_referral_source" = 'occupational therapy' THEN 'Occupational Therapy'
    WHEN "therapy_referral_source" = 'occupational therapy ' THEN 'Occupational Therapy'
    WHEN "therapy_referral_source" = 'physiotherapy' THEN 'Physiotherapy'
    WHEN "therapy_referral_source" = 'PHYSIOTHERAPY' THEN 'Physiotherapy'
    WHEN "therapy_referral_source" = 'psychology' THEN 'Psychology'
    WHEN "therapy_referral_source" = ' psychology' THEN 'Psychology'
    WHEN "therapy_referral_source" = ' speech therapy' THEN 'Speech Therapy'
    WHEN "therapy_referral_source" = 'speech therapy' THEN 'Speech Therapy'
    WHEN "therapy_referral_source" = 'speech therapy ' THEN 'Speech Therapy'
    ELSE NULL
END AS "therapy_referral"
FROM cte6
) , cte4 as (
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
"case_status_source",
"child_id",
"child_name",
"communication_score_source",
"diagnosis",
"diagnosis_source",
"district",
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
"school_status_source",
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
"tracking_id",
"visit_date_source",
"ward",
CASE
    WHEN "case_status_source" = 'active' THEN 'Active'
    WHEN "case_status_source" = ' active' THEN 'Active'
    WHEN "case_status_source" = 'active ' THEN 'Active'
    WHEN "case_status_source" = 'ACTIVE' THEN 'Active'
    WHEN "case_status_source" = 'closed' THEN 'Closed'
    WHEN "case_status_source" = 'lost to follow up' THEN 'Lost To Follow-Up'
    WHEN "case_status_source" = 'lost to follow-up' THEN 'Lost To Follow-Up'
    WHEN "case_status_source" = 'on hold' THEN 'On Hold'
    WHEN "case_status_source" = 'referred out' THEN 'Referred Out'
    ELSE 'Active'
END AS "case_status"
FROM cte5
) , cte3 as (
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
"district",
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
"school_status_source",
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
"tracking_id",
"visit_date_source",
"ward",
CASE
    WHEN "screening_tool_source" = 'asq-3' THEN 'ASQ-3'
    WHEN "screening_tool_source" = ' ASQ-3' THEN 'ASQ-3'
    WHEN "screening_tool_source" = 'ASQ 3' THEN 'ASQ-3'
    WHEN "screening_tool_source" = 'ASQ-3' THEN 'ASQ-3'
    WHEN "screening_tool_source" = 'ASQ-3 ' THEN 'ASQ-3'
    WHEN "screening_tool_source" = 'denver ii' THEN 'Denver II'
    WHEN "screening_tool_source" = 'Denver II' THEN 'Denver II'
    WHEN "screening_tool_source" = 'INCLEN' THEN 'INCLEN'
    WHEN "screening_tool_source" = 'INCLEN ' THEN 'INCLEN'
    WHEN "screening_tool_source" = 'M-CHAT-R' THEN 'M-CHAT-R'
    WHEN "screening_tool_source" = 'M-CHAT-R ' THEN 'M-CHAT-R'
    WHEN "screening_tool_source" = ' therapy progress checklist' THEN 'Therapy Progress Checklist'
    WHEN "screening_tool_source" = 'therapy progress checklist' THEN 'Therapy Progress Checklist'
    WHEN "screening_tool_source" = 'therapy progress checklist ' THEN 'Therapy Progress Checklist'
    ELSE 'Not Recorded'
END AS "screening_tool"
FROM cte4
) , cte2 as (
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
"district",
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
"tracking_id",
"visit_date_source",
"ward",
CASE
    WHEN "school_status_source" = 'anganwadi' THEN 'Anganwadi'
    WHEN "school_status_source" = 'ANGANWADI' THEN 'Anganwadi'
    WHEN "school_status_source" = 'dropped out' THEN 'Dropped Out'
    WHEN "school_status_source" = ' mainstream school' THEN 'Mainstream School'
    WHEN "school_status_source" = 'mainstream school' THEN 'Mainstream School'
    WHEN "school_status_source" = 'mainstream school ' THEN 'Mainstream School'
    WHEN "school_status_source" = 'MAINSTREAM SCHOOL' THEN 'Mainstream School'
    WHEN "school_status_source" = 'not enrolled' THEN 'Not Enrolled'
    WHEN "school_status_source" = ' not in school' THEN 'Not In School'
    WHEN "school_status_source" = 'not in school' THEN 'Not In School'
    WHEN "school_status_source" = 'not in school ' THEN 'Not In School'
    WHEN "school_status_source" = 'NOT IN SCHOOL' THEN 'Not In School'
    WHEN "school_status_source" = 'special school' THEN 'Special School'
    WHEN "school_status_source" = 'special school ' THEN 'Special School'
    WHEN "school_status_source" = ' too young' THEN 'Too Young'
    WHEN "school_status_source" = 'too young' THEN 'Too Young'
    WHEN "school_status_source" = 'TOO YOUNG' THEN 'Too Young'
    ELSE 'Not Recorded'
END AS "school_status"
FROM cte3
) , cte1 as (
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
"district",
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
"tracking_id",
"visit_date_source",
"ward",
CASE
    WHEN "therapy_referral" = NULL THEN 'false'
    ELSE 'true'
END AS "therapy_referred_text"
FROM cte2
)
-- Final SELECT statement combining the outputs of all CTEs
SELECT *
FROM cte1