--DBT AUTOMATION has generated this model, please DO NOT EDIT 
--Please make sure you dont change the model name 

{{ config(materialized='table', schema='ui4t_staging') }}
WITH cte5 as (
SELECT
"_airbyte_extracted_at",
"_airbyte_generation_id",
"_airbyte_meta",
"_airbyte_raw_id",
"action_taken_raw",
"age_raw",
"beneficiary_id_raw",
"child_id_raw",
"clinic_site_raw",
"diagnosis_or_concern_raw",
"district_raw",
"doctor_id_raw",
"doctor_name_raw",
"duration_mins_raw",
"encounter_id",
"entered_by",
"follow_up_date_raw",
"household_id_raw",
"last_updated_raw",
"meeting_date_raw",
"meeting_id_raw",
"meeting_start_time_raw",
"meeting_type_raw",
"notes_raw",
"partner_ngo_raw",
"patient_name_raw",
"reason_for_visit_raw",
"referral_source_raw",
"sex_raw",
"source_row_id",
"speciality_raw",
"state_raw",
"status_raw",
"synthetic_record_flag",
CASE
    WHEN "meeting_date_raw" = '01/03/2026' THEN '2026-03-01'
    WHEN "meeting_date_raw" = '01/16/2026' THEN '2026-01-16'
    WHEN "meeting_date_raw" = '02/04/2026' THEN '2026-04-02'
    WHEN "meeting_date_raw" = '03/10/2026' THEN '2026-10-03'
    WHEN "meeting_date_raw" = '03/26/2026' THEN '2026-03-26'
    WHEN "meeting_date_raw" = '03/31/2026' THEN '2026-03-31'
    WHEN "meeting_date_raw" = '04/02/2026' THEN '2026-02-04'
    WHEN "meeting_date_raw" = '04/05/2026' THEN '2026-05-04'
    WHEN "meeting_date_raw" = '04/09/2026' THEN '2026-09-04'
    WHEN "meeting_date_raw" = '04/23/2026' THEN '2026-04-23'
    WHEN "meeting_date_raw" = '05/02/2026' THEN '2026-02-05'
    WHEN "meeting_date_raw" = '05/03/2026' THEN '2026-03-05'
    WHEN "meeting_date_raw" = '05/05/2026' THEN '2026-05-05'
    WHEN "meeting_date_raw" = '05/11/2026' THEN '2026-11-05'
    WHEN "meeting_date_raw" = '05/18/2026' THEN '2026-05-18'
    WHEN "meeting_date_raw" = '06/07/2026' THEN '2026-07-06'
    WHEN "meeting_date_raw" = '06/27/2026' THEN '2026-06-27'
    WHEN "meeting_date_raw" = '08-01-26' THEN '2026-01-08'
    WHEN "meeting_date_raw" = '08/03/2026' THEN '2026-03-08'
    WHEN "meeting_date_raw" = '08/06/2026' THEN '2026-06-08'
    WHEN "meeting_date_raw" = '10/01/2026' THEN '2026-01-10'
    WHEN "meeting_date_raw" = '10/02/2026' THEN '2026-02-10'
    WHEN "meeting_date_raw" = '10/04/2026' THEN '2026-04-10'
    WHEN "meeting_date_raw" = '10/05/2026' THEN '2026-05-10'
    WHEN "meeting_date_raw" = '11/03/2026' THEN '2026-03-11'
    WHEN "meeting_date_raw" = '12/01/2026' THEN '2026-01-12'
    WHEN "meeting_date_raw" = '13/04/2026' THEN '2026-04-13'
    WHEN "meeting_date_raw" = '16/02/2026' THEN '2026-02-16'
    WHEN "meeting_date_raw" = '16/03/2026' THEN '2026-03-16'
    WHEN "meeting_date_raw" = '17/02/2026' THEN '2026-02-17'
    WHEN "meeting_date_raw" = '17/04/2026' THEN '2026-04-17'
    WHEN "meeting_date_raw" = '17/05/2026' THEN '2026-05-17'
    WHEN "meeting_date_raw" = '19/03/2026' THEN '2026-03-19'
    WHEN "meeting_date_raw" = '19/04/2026' THEN '2026-04-19'
    WHEN "meeting_date_raw" = '20/01/2026' THEN '2026-01-20'
    WHEN "meeting_date_raw" = '20-06-26' THEN '2026-06-20'
    WHEN "meeting_date_raw" = '2026/01/19' THEN '2026-01-19'
    WHEN "meeting_date_raw" = '2026/02/07' THEN '2026-02-07'
    WHEN "meeting_date_raw" = '2026/02/15' THEN '2026-02-15'
    WHEN "meeting_date_raw" = '2026/02/25' THEN '2026-02-25'
    WHEN "meeting_date_raw" = '2026/03/10' THEN '2026-03-10'
    WHEN "meeting_date_raw" = '2026/03/20' THEN '2026-03-20'
    WHEN "meeting_date_raw" = '2026/03/26' THEN '2026-03-26'
    WHEN "meeting_date_raw" = '2026/04/06' THEN '2026-04-06'
    WHEN "meeting_date_raw" = '2026/04/13' THEN '2026-04-13'
    WHEN "meeting_date_raw" = '2026/04/15' THEN '2026-04-15'
    WHEN "meeting_date_raw" = '2026/04/28' THEN '2026-04-28'
    WHEN "meeting_date_raw" = '2026/05/20' THEN '2026-05-20'
    WHEN "meeting_date_raw" = '2026/06/15' THEN '2026-06-15'
    WHEN "meeting_date_raw" = '2026/06/17' THEN '2026-06-17'
    WHEN "meeting_date_raw" = '22/06/2026' THEN '2026-06-22'
    WHEN "meeting_date_raw" = '23-01-26' THEN '2026-01-23'
    WHEN "meeting_date_raw" = '23/02/2026' THEN '2026-02-23'
    WHEN "meeting_date_raw" = '23/04/2026' THEN '2026-04-23'
    WHEN "meeting_date_raw" = '24/01/2026' THEN '2026-01-24'
    WHEN "meeting_date_raw" = '24/02/2026' THEN '2026-02-24'
    WHEN "meeting_date_raw" = '24/05/2026' THEN '2026-05-24'
    WHEN "meeting_date_raw" = '25/04/2026' THEN '2026-04-25'
    WHEN "meeting_date_raw" = '25/05/2026' THEN '2026-05-25'
    WHEN "meeting_date_raw" = '25-05-26' THEN '2026-05-25'
    WHEN "meeting_date_raw" = '27/06/2026' THEN '2026-06-27'
    WHEN "meeting_date_raw" = '28-03-26' THEN '2026-03-28'
    WHEN "meeting_date_raw" = 'Fri Apr 10 2026' THEN '2026-04-10'
    WHEN "meeting_date_raw" = 'Mon Jan 12 2026' THEN '2026-01-12'
    WHEN "meeting_date_raw" = 'NA' THEN '2026-01-15'
    WHEN "meeting_date_raw" = 'not known' THEN '2026-01-15'
    WHEN "meeting_date_raw" = 'pending' THEN '2026-01-15'
    WHEN "meeting_date_raw" = 'Sun Jun 07 2026' THEN '2026-06-07'
    WHEN "meeting_date_raw" = 'Thu Jan 08 2026' THEN '2026-01-08'
    WHEN "meeting_date_raw" = 'Tue Apr 28 2026' THEN '2026-04-28'
    ELSE "meeting_date_raw"
END AS "meeting_date_text"
FROM {{source('staging_health', 'raw_clinic_meetings')}}
) , cte4 as (
SELECT "_airbyte_extracted_at", "_airbyte_generation_id", "_airbyte_meta", "_airbyte_raw_id", "action_taken_raw", "age_raw", "child_id_raw", "diagnosis_or_concern_raw", "doctor_id_raw", "doctor_name_raw", "duration_mins_raw", "encounter_id", "entered_by", "household_id_raw", "last_updated_raw", "meeting_date_raw", "meeting_start_time_raw", "meeting_type_raw", "notes_raw", "partner_ngo_raw", "patient_name_raw", "reason_for_visit_raw", "referral_source_raw", "sex_raw", "source_row_id", "speciality_raw", "status_raw", "synthetic_record_flag", "meeting_date_text", "state_raw" AS "state", "district_raw" AS "district", "meeting_id_raw" AS "meeting_id", "clinic_site_raw" AS "clinic_site", "beneficiary_id_raw" AS "beneficiary_id", "follow_up_date_raw" AS "follow_up_date"
 FROM cte5
) , cte3 as (
SELECT
"_airbyte_extracted_at",
"_airbyte_generation_id",
"_airbyte_meta",
"_airbyte_raw_id",
"action_taken_raw",
"age_raw",
"beneficiary_id",
"child_id_raw",
"clinic_site",
"diagnosis_or_concern_raw",
"district",
"doctor_id_raw",
"doctor_name_raw",
"duration_mins_raw",
"encounter_id",
"entered_by",
"follow_up_date",
"household_id_raw",
"last_updated_raw",
"meeting_date_raw",
"meeting_date_text",
"meeting_id",
"meeting_start_time_raw",
"meeting_type_raw",
"notes_raw",
"partner_ngo_raw",
"patient_name_raw",
"reason_for_visit_raw",
"referral_source_raw",
"sex_raw",
"source_row_id",
"speciality_raw",
"state",
"status_raw",
"synthetic_record_flag",
CASE
    WHEN "sex_raw" = 'f' THEN 'Female'
    WHEN "sex_raw" = 'F' THEN 'Female'
    WHEN "sex_raw" = ' F' THEN 'Female'
    WHEN "sex_raw" = 'F ' THEN 'Female'
    WHEN "sex_raw" = 'Female' THEN 'Female'
    WHEN "sex_raw" = 'm' THEN 'Male'
    WHEN "sex_raw" = 'M' THEN 'Male'
    WHEN "sex_raw" = ' M' THEN 'Male'
    WHEN "sex_raw" = 'M ' THEN 'Male'
    WHEN "sex_raw" = 'Male' THEN 'Male'
    ELSE 'Unknown'
END AS "sex"
FROM cte4
) , cte2 as (
SELECT
"_airbyte_extracted_at",
"_airbyte_generation_id",
"_airbyte_meta",
"_airbyte_raw_id",
"action_taken_raw",
"age_raw",
"beneficiary_id",
"child_id_raw",
"clinic_site",
"diagnosis_or_concern_raw",
"district",
"doctor_id_raw",
"doctor_name_raw",
"duration_mins_raw",
"encounter_id",
"entered_by",
"follow_up_date",
"household_id_raw",
"last_updated_raw",
"meeting_date_raw",
"meeting_date_text",
"meeting_id",
"meeting_start_time_raw",
"meeting_type_raw",
"notes_raw",
"partner_ngo_raw",
"patient_name_raw",
"reason_for_visit_raw",
"referral_source_raw",
"sex",
"sex_raw",
"source_row_id",
"speciality_raw",
"state",
"status_raw",
"synthetic_record_flag",
CASE
    WHEN "status_raw" = 'cancelled' THEN 'Cancelled'
    WHEN "status_raw" = 'cancelled by family' THEN 'Cancelled'
    WHEN "status_raw" = 'CANCELLED BY FAMILY' THEN 'Cancelled'
    WHEN "status_raw" = 'completed' THEN 'Completed'
    WHEN "status_raw" = ' completed' THEN 'Completed'
    WHEN "status_raw" = 'completed ' THEN 'Completed'
    WHEN "status_raw" = 'COMPLETED' THEN 'Completed'
    WHEN "status_raw" = 'doctor unavailable' THEN 'Doctor Unavailable'
    WHEN "status_raw" = ' no show' THEN 'No Show'
    WHEN "status_raw" = 'no show' THEN 'No Show'
    WHEN "status_raw" = 'rescheduled' THEN 'Rescheduled'
    WHEN "status_raw" = 'rescheduled ' THEN 'Rescheduled'
    ELSE 'Other'
END AS "status"
FROM cte3
) , cte1 as (
SELECT
"_airbyte_extracted_at",
"_airbyte_generation_id",
"_airbyte_meta",
"_airbyte_raw_id",
"action_taken_raw",
"age_raw",
"beneficiary_id",
"child_id_raw",
"clinic_site",
"diagnosis_or_concern_raw",
"district",
"doctor_id_raw",
"doctor_name_raw",
"duration_mins_raw",
"encounter_id",
"entered_by",
"follow_up_date",
"household_id_raw",
"last_updated_raw",
"meeting_date_raw",
"meeting_date_text",
"meeting_id",
"meeting_start_time_raw",
"meeting_type_raw",
"notes_raw",
"partner_ngo_raw",
"patient_name_raw",
"reason_for_visit_raw",
"referral_source_raw",
"sex",
"sex_raw",
"source_row_id",
"speciality_raw",
"state",
"status",
"status_raw",
"synthetic_record_flag",
CASE
    WHEN "meeting_type_raw" = 'emergency referral' THEN 'Emergency Referral'
    WHEN "meeting_type_raw" = ' first visit' THEN 'First Visit'
    WHEN "meeting_type_raw" = 'first visit' THEN 'First Visit'
    WHEN "meeting_type_raw" = ' follow-up' THEN 'Follow Up'
    WHEN "meeting_type_raw" = 'follow up' THEN 'Follow Up'
    WHEN "meeting_type_raw" = 'follow-up' THEN 'Follow Up'
    WHEN "meeting_type_raw" = 'follow-up ' THEN 'Follow Up'
    WHEN "meeting_type_raw" = 'FOLLOW-UP' THEN 'Follow Up'
    WHEN "meeting_type_raw" = 'group clinic' THEN 'Group Clinic'
    WHEN "meeting_type_raw" = 'home visit review' THEN 'Home Visit Review'
    WHEN "meeting_type_raw" = 'referral review' THEN 'Referral Review'
    WHEN "meeting_type_raw" = 'teleconsult' THEN 'Teleconsult'
    WHEN "meeting_type_raw" = ' teleconsult' THEN 'Teleconsult'
    ELSE 'Other'
END AS "meeting_type"
FROM cte2
)
-- Final SELECT statement combining the outputs of all CTEs
SELECT *
FROM cte1