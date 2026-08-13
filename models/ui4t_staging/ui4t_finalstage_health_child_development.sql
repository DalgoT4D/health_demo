--DBT AUTOMATION has generated this model, please DO NOT EDIT 
--Please make sure you dont change the model name 

{{ config(materialized='table', schema='ui4t_staging') }}
WITH cte14 as (
SELECT "_airbyte_raw_id", "_airbyte_extracted_at", "_airbyte_meta", "_airbyte_generation_id", "notes_raw", "entered_by", "source_row_id", "assistive_device_raw", "synthetic_record_flag", "home_program_given_raw", "linked_clinic_meeting_id_raw", "sex_raw" AS "sex", "area_raw" AS "area", "ward_raw" AS "ward", "state_raw" AS "state", "child_id_raw" AS "child_id", "district_raw" AS "district", "severity_raw" AS "severity_source", "diagnosis_raw" AS "diagnosis_source", "mother_id_raw" AS "mother_id", "age_months_raw" AS "age_months_source", "child_name_raw" AS "child_name", "visit_date_raw" AS "visit_date_source", "case_status_raw" AS "case_status_source", "partner_ngo_raw" AS "partner_ngo", "tracking_id_raw" AS "tracking_id", "household_id_raw" AS "household_id", "social_score_raw" AS "social_score_source", "school_status_raw" AS "school_status_source", "screening_tool_raw" AS "screening_tool_source", "fine_motor_score_raw" AS "fine_motor_score_source", "next_review_date_raw" AS "next_review_date_source", "therapy_referred_raw" AS "therapy_referral_source", "gross_motor_score_raw" AS "gross_motor_score_source", "communication_score_raw" AS "communication_score_source", "caregiver_beneficiary_id_raw" AS "caregiver_beneficiary_id", "sessions_attended_last_month_raw" AS "sessions_attended_source"
 FROM {{source('staging_health', 'raw_child_dev_tracking')}}
) , cte13 as (
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
FROM cte14
) , cte12 as (
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
FROM cte13
) , cte11 as (
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
FROM cte12
) , cte10 as (
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
FROM cte11
) , cte9 as (
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
FROM cte10
) , cte8 as (
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
FROM cte6
) , cte4 as (
SELECT "_airbyte_extracted_at", "_airbyte_generation_id", "_airbyte_meta", "_airbyte_raw_id", "age_months_clean", "age_months_source", "area", "assistive_device_raw", "caregiver_beneficiary_id", "case_status", "case_status_source", "child_id", "child_name", "communication_score_source", "diagnosis", "diagnosis_source", "district", "entered_by", "fine_motor_score_source", "gross_motor_score_source", "home_program_given_raw", "household_id", "linked_clinic_meeting_id_raw", "mother_id", "next_review_date_source", "notes_raw", "partner_ngo", "school_status", "school_status_source", "screening_tool", "screening_tool_source", "sessions_attended_source", "severity", "severity_source", "sex", "sex_clean", "social_score_source", "source_row_id", "state", "synthetic_record_flag", "therapy_referral", "therapy_referral_source", "therapy_referred_text", "tracking_id", "visit_date_source", "ward", SPLIT_PART("age_months_clean", 'm', '1') AS age_months_text FROM cte5) , cte3 as (
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
"therapy_referred_text",
"tracking_id",
"visit_date_source",
"ward",
CASE
    WHEN "visit_date_source" = '01-04-26' THEN '2026-04-01'
    WHEN "visit_date_source" = '02/03/2026' THEN '2026-03-02'
    WHEN "visit_date_source" = '02/07/2026' THEN '2026-07-02'
    WHEN "visit_date_source" = '02/13/2026' THEN '2026-02-13'
    WHEN "visit_date_source" = '02/14/2026' THEN '2026-02-14'
    WHEN "visit_date_source" = '03/31/2026' THEN '2026-03-31'
    WHEN "visit_date_source" = '04/03/2026' THEN '2026-03-04'
    WHEN "visit_date_source" = '04/13/2026' THEN '2026-04-13'
    WHEN "visit_date_source" = '04/17/2026' THEN '2026-04-17'
    WHEN "visit_date_source" = '05/02/2026' THEN '2026-02-05'
    WHEN "visit_date_source" = '05/03/2026' THEN '2026-03-05'
    WHEN "visit_date_source" = '05/15/2026' THEN '2026-05-15'
    WHEN "visit_date_source" = '05/16/2026' THEN '2026-05-16'
    WHEN "visit_date_source" = '06/04/2026' THEN '2026-04-06'
    WHEN "visit_date_source" = '06/05/2026' THEN '2026-05-06'
    WHEN "visit_date_source" = '06/14/2026' THEN '2026-06-14'
    WHEN "visit_date_source" = '07/03/2026' THEN '2026-03-07'
    WHEN "visit_date_source" = '08/02/2026' THEN '2026-02-08'
    WHEN "visit_date_source" = '09/05/2026' THEN '2026-05-09'
    WHEN "visit_date_source" = '10/02/2026' THEN '2026-02-10'
    WHEN "visit_date_source" = '10-03-26' THEN '2026-03-10'
    WHEN "visit_date_source" = '10/05/2026' THEN '2026-05-10'
    WHEN "visit_date_source" = '10/06/2026' THEN '2026-06-10'
    WHEN "visit_date_source" = '12-01-26' THEN '2026-01-12'
    WHEN "visit_date_source" = '12/04/2026' THEN '2026-04-12'
    WHEN "visit_date_source" = '12/06/2026' THEN '2026-06-12'
    WHEN "visit_date_source" = '16/03/2026' THEN '2026-03-16'
    WHEN "visit_date_source" = '16/04/2026' THEN '2026-04-16'
    WHEN "visit_date_source" = '16/05/2026' THEN '2026-05-16'
    WHEN "visit_date_source" = '17/02/2026' THEN '2026-02-17'
    WHEN "visit_date_source" = '2026/01/08' THEN '2026-01-08'
    WHEN "visit_date_source" = '2026/01/15' THEN '2026-01-15'
    WHEN "visit_date_source" = '2026/01/25' THEN '2026-01-25'
    WHEN "visit_date_source" = '2026/02/04' THEN '2026-02-04'
    WHEN "visit_date_source" = '2026/02/12' THEN '2026-02-12'
    WHEN "visit_date_source" = '2026/02/15' THEN '2026-02-15'
    ELSE "visit_date_source"
END AS "visit_date_clean1"
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
"visit_date_clean1",
"visit_date_source",
"ward",
CASE
    WHEN "visit_date_clean1" = '2026/03/16' THEN '2026-03-16'
    WHEN "visit_date_clean1" = '2026/03/27' THEN '2026-03-27'
    WHEN "visit_date_clean1" = '2026/04/13' THEN '2026-04-13'
    WHEN "visit_date_clean1" = '2026/05/02' THEN '2026-05-02'
    WHEN "visit_date_clean1" = '2026/05/14' THEN '2026-05-14'
    WHEN "visit_date_clean1" = '2026/05/23' THEN '2026-05-23'
    WHEN "visit_date_clean1" = '2026/06/12' THEN '2026-06-12'
    WHEN "visit_date_clean1" = '2026/06/13' THEN '2026-06-13'
    WHEN "visit_date_clean1" = '21/04/2026' THEN '2026-04-21'
    WHEN "visit_date_clean1" = '23/01/2026' THEN '2026-01-23'
    WHEN "visit_date_clean1" = '24/05/2026' THEN '2026-05-24'
    WHEN "visit_date_clean1" = '24-06-26' THEN '2026-06-24'
    WHEN "visit_date_clean1" = '25-01-26' THEN '2026-01-25'
    WHEN "visit_date_clean1" = '26-03-26' THEN '2026-03-26'
    WHEN "visit_date_clean1" = '26/06/2026' THEN '2026-06-26'
    WHEN "visit_date_clean1" = '27/03/2026' THEN '2026-03-27'
    WHEN "visit_date_clean1" = '28/02/2026' THEN '2026-02-28'
    WHEN "visit_date_clean1" = '28/05/2026' THEN '2026-05-28'
    WHEN "visit_date_clean1" = '29/03/2026' THEN '2026-03-29'
    WHEN "visit_date_clean1" = '29/05/2026' THEN '2026-05-29'
    WHEN "visit_date_clean1" = '30/03/2026' THEN '2026-03-30'
    WHEN "visit_date_clean1" = 'Mon Jan 26 2026' THEN '2026-01-26'
    WHEN "visit_date_clean1" = 'Mon Jun 08 2026' THEN '2026-06-08'
    WHEN "visit_date_clean1" = 'Mon Mar 09 2026' THEN '2026-03-09'
    WHEN "visit_date_clean1" = 'NA' THEN '2026-01-15'
    WHEN "visit_date_clean1" = 'not known' THEN '2026-01-15'
    WHEN "visit_date_clean1" = 'pending' THEN '2026-01-15'
    WHEN "visit_date_clean1" = 'Sat Apr 04 2026' THEN '2026-04-04'
    WHEN "visit_date_clean1" = 'Sat Mar 07 2026' THEN '2026-03-07'
    WHEN "visit_date_clean1" = 'Sat Mar 21 2026' THEN '2026-03-21'
    WHEN "visit_date_clean1" = 'Sat May 23 2026' THEN '2026-05-23'
    WHEN "visit_date_clean1" = 'Sun Feb 01 2026' THEN '2026-02-01'
    WHEN "visit_date_clean1" = 'Sun Feb 15 2026' THEN '2026-02-15'
    WHEN "visit_date_clean1" = 'Sun Jan 25 2026' THEN '2026-01-25'
    WHEN "visit_date_clean1" = 'Thu Jan 15 2026' THEN '2026-01-15'
    WHEN "visit_date_clean1" = 'Tue Jun 23 2026' THEN '2026-06-23'
    WHEN "visit_date_clean1" = 'Tue May 05 2026' THEN '2026-05-05'
    ELSE "visit_date_clean1"
END AS "visit_date_text"
FROM cte3
) , cte1 as (
SELECT "_airbyte_extracted_at", "_airbyte_generation_id", "_airbyte_meta", "_airbyte_raw_id", "age_months_clean", "age_months_source", "area", "assistive_device_raw", "caregiver_beneficiary_id", "case_status", "case_status_source", "child_id", "child_name", "communication_score_source", "diagnosis", "diagnosis_source", "district", "entered_by", "fine_motor_score_source", "gross_motor_score_source", "home_program_given_raw", "household_id", "linked_clinic_meeting_id_raw", "mother_id", "next_review_date_source", "notes_raw", "partner_ngo", "school_status", "school_status_source", "screening_tool", "screening_tool_source", "sessions_attended_source", "severity", "severity_source", "sex", "sex_clean", "social_score_source", "source_row_id", "state", "synthetic_record_flag", "therapy_referral", "therapy_referral_source", "therapy_referred_text", "tracking_id", "visit_date_clean1", "visit_date_source", "visit_date_text", "ward", TO_DATE("visit_date_text", 'YYYY-MM-DD') AS visit_date FROM cte2)
-- Final SELECT statement combining the outputs of all CTEs
SELECT *
FROM cte1