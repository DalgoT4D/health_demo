--DBT AUTOMATION has generated this model, please DO NOT EDIT 
--Please make sure you dont change the model name 

{{ config(materialized='table', schema='ui4t_staging') }}
WITH cte4 as (
SELECT
"_airbyte_extracted_at",
"_airbyte_generation_id",
"_airbyte_meta",
"_airbyte_raw_id",
"age_years_raw",
"anemia_status_raw",
"area_raw",
"beneficiary_id_raw",
"bmi_raw",
"bp_diastolic_raw",
"bp_systolic_raw",
"case_status_raw",
"danger_signs_raw",
"district_raw",
"edd_raw",
"field_worker_id_raw",
"gestational_age_weeks_raw",
"gravida_raw",
"hemoglobin_g_dl_raw",
"household_id_raw",
"hypertension_flag_raw",
"lmp_date_raw",
"mother_id_raw",
"mother_name_raw",
"next_visit_date_raw",
"notes_raw",
"parity_raw",
"partner_ngo_raw",
"pregnancy_id_raw",
"prior_c_section_raw",
"referral_status_raw",
"referred_facility_raw",
"risk_level_raw",
"source_row_id",
"state_raw",
"synthetic_record_flag",
"transport_support_raw",
"visit_date_raw",
"visit_id_raw",
"ward_raw",
CASE
    WHEN "visit_date_raw" = '01/02/2026' THEN '2026-02-01'
    WHEN "visit_date_raw" = '01/10/2026' THEN '2026-10-01'
    WHEN "visit_date_raw" = '01/12/2025' THEN '2025-12-01'
    WHEN "visit_date_raw" = '01/28/2026' THEN '2026-01-28'
    WHEN "visit_date_raw" = '02/05/2026' THEN '2026-05-02'
    WHEN "visit_date_raw" = '02/17/2026' THEN '2026-02-17'
    WHEN "visit_date_raw" = '03/03/2026' THEN '2026-03-03'
    WHEN "visit_date_raw" = '03/21/2026' THEN '2026-03-21'
    WHEN "visit_date_raw" = '03/31/2026' THEN '2026-03-31'
    WHEN "visit_date_raw" = '04-04-26' THEN '2026-04-04'
    WHEN "visit_date_raw" = '04/26/2026' THEN '2026-04-26'
    WHEN "visit_date_raw" = '05/06/2026' THEN '2026-06-05'
    WHEN "visit_date_raw" = '05/10/2026' THEN '2026-10-05'
    WHEN "visit_date_raw" = '05/13/2026' THEN '2026-05-13'
    WHEN "visit_date_raw" = '05/17/2026' THEN '2026-05-17'
    WHEN "visit_date_raw" = '05/18/2026' THEN '2026-05-18'
    WHEN "visit_date_raw" = '06/01/2026' THEN '2026-01-06'
    WHEN "visit_date_raw" = '06/02/2026' THEN '2026-02-06'
    WHEN "visit_date_raw" = '06/11/2025' THEN '2025-11-06'
    WHEN "visit_date_raw" = '07/02/2026' THEN '2026-02-07'
    WHEN "visit_date_raw" = '07/17/2026' THEN '2026-07-17'
    WHEN "visit_date_raw" = '07/18/2026' THEN '2026-07-18'
    WHEN "visit_date_raw" = '07/24/2026' THEN '2026-07-24'
    WHEN "visit_date_raw" = '08/01/2026' THEN '2026-01-08'
    WHEN "visit_date_raw" = '08/03/2026' THEN '2026-03-08'
    WHEN "visit_date_raw" = '08/05/2026' THEN '2026-05-08'
    WHEN "visit_date_raw" = '08/06/2026' THEN '2026-06-08'
    WHEN "visit_date_raw" = '08/10/2025' THEN '2025-10-08'
    WHEN "visit_date_raw" = '08/11/2026' THEN '2026-11-08'
    WHEN "visit_date_raw" = '09/05/2026' THEN '2026-05-09'
    WHEN "visit_date_raw" = '09/29/2026' THEN '2026-09-29'
    WHEN "visit_date_raw" = '10/01/2026' THEN '2026-01-10'
    WHEN "visit_date_raw" = '10/12/2025' THEN '2025-12-10'
    WHEN "visit_date_raw" = '10/30/2025' THEN '2025-10-30'
    WHEN "visit_date_raw" = '11/08/2026' THEN '2026-08-11'
    WHEN "visit_date_raw" = '12/16/2025' THEN '2025-12-16'
    WHEN "visit_date_raw" = '14-04-26' THEN '2026-04-14'
    WHEN "visit_date_raw" = '14/05/2026' THEN '2026-05-14'
    WHEN "visit_date_raw" = '15/04/2026' THEN '2026-04-15'
    WHEN "visit_date_raw" = '16/03/2026' THEN '2026-03-16'
    WHEN "visit_date_raw" = '16/11/2025' THEN '2025-11-16'
    WHEN "visit_date_raw" = '17/03/2026' THEN '2026-03-17'
    WHEN "visit_date_raw" = '17-03-26' THEN '2026-03-17'
    WHEN "visit_date_raw" = '18-03-26' THEN '2026-03-18'
    WHEN "visit_date_raw" = '19/05/2026' THEN '2026-05-19'
    WHEN "visit_date_raw" = '19/10/2025' THEN '2025-10-19'
    WHEN "visit_date_raw" = '20/03/2026' THEN '2026-03-20'
    WHEN "visit_date_raw" = '2025/11/18' THEN '2025-11-18'
    WHEN "visit_date_raw" = '2025/12/07' THEN '2025-12-07'
    WHEN "visit_date_raw" = '2026/01/19' THEN '2026-01-19'
    WHEN "visit_date_raw" = '2026/02/09' THEN '2026-02-09'
    WHEN "visit_date_raw" = '2026/02/18' THEN '2026-02-18'
    WHEN "visit_date_raw" = '2026/02/24' THEN '2026-02-24'
    WHEN "visit_date_raw" = '2026/02/26' THEN '2026-02-26'
    WHEN "visit_date_raw" = '2026/03/10' THEN '2026-03-10'
    WHEN "visit_date_raw" = '2026/03/11' THEN '2026-03-11'
    WHEN "visit_date_raw" = '2026/04/02' THEN '2026-04-02'
    WHEN "visit_date_raw" = '2026/04/08' THEN '2026-04-08'
    WHEN "visit_date_raw" = '2026/04/29' THEN '2026-04-29'
    WHEN "visit_date_raw" = '2026/05/03' THEN '2026-05-03'
    WHEN "visit_date_raw" = '2026/05/14' THEN '2026-05-14'
    WHEN "visit_date_raw" = '2026/05/16' THEN '2026-05-16'
    WHEN "visit_date_raw" = '2026/06/10' THEN '2026-06-10'
    WHEN "visit_date_raw" = '2026/06/18' THEN '2026-06-18'
    WHEN "visit_date_raw" = '2026/06/22' THEN '2026-06-22'
    WHEN "visit_date_raw" = '2026/07/16' THEN '2026-07-16'
    WHEN "visit_date_raw" = '2026/07/24' THEN '2026-07-24'
    WHEN "visit_date_raw" = '2026/08/01' THEN '2026-08-01'
    WHEN "visit_date_raw" = '2026/08/04' THEN '2026-08-04'
    WHEN "visit_date_raw" = '2026/08/16' THEN '2026-08-16'
    WHEN "visit_date_raw" = '2026/10/10' THEN '2026-10-10'
    WHEN "visit_date_raw" = '21-01-26' THEN '2026-01-21'
    WHEN "visit_date_raw" = '21/02/2026' THEN '2026-02-21'
    WHEN "visit_date_raw" = '25/01/2026' THEN '2026-01-25'
    WHEN "visit_date_raw" = '26/05/2026' THEN '2026-05-26'
    WHEN "visit_date_raw" = '26-05-26' THEN '2026-05-26'
    WHEN "visit_date_raw" = '26/07/2026' THEN '2026-07-26'
    WHEN "visit_date_raw" = '27/02/2026' THEN '2026-02-27'
    WHEN "visit_date_raw" = '27/04/2026' THEN '2026-04-27'
    WHEN "visit_date_raw" = '27/09/2026' THEN '2026-09-27'
    WHEN "visit_date_raw" = '29/06/2026' THEN '2026-06-29'
    WHEN "visit_date_raw" = '29/07/2026' THEN '2026-07-29'
    WHEN "visit_date_raw" = '30/03/2026' THEN '2026-03-30'
    WHEN "visit_date_raw" = '31/01/2026' THEN '2026-01-31'
    WHEN "visit_date_raw" = '31/05/2026' THEN '2026-05-31'
    WHEN "visit_date_raw" = 'Fri Apr 10 2026' THEN '2026-04-10'
    WHEN "visit_date_raw" = 'pending' THEN '2026-01-15'
    WHEN "visit_date_raw" = 'Sat Oct 03 2026' THEN '2026-10-03'
    WHEN "visit_date_raw" = 'Sun Apr 26 2026' THEN '2026-04-26'
    WHEN "visit_date_raw" = 'Sun Mar 22 2026' THEN '2026-03-22'
    WHEN "visit_date_raw" = 'Sun May 24 2026' THEN '2026-05-24'
    WHEN "visit_date_raw" = 'Thu Apr 30 2026' THEN '2026-04-30'
    WHEN "visit_date_raw" = 'Thu Oct 23 2025' THEN '2025-10-23'
    WHEN "visit_date_raw" = 'Wed Oct 07 2026' THEN '2026-10-07'
    ELSE "visit_date_raw"
END AS "visit_date_text"
FROM {{source('staging_health', 'raw_maternal_risk')}}
) , cte3 as (
SELECT "_airbyte_extracted_at", "_airbyte_generation_id", "_airbyte_meta", "_airbyte_raw_id", "age_years_raw", "anemia_status_raw", "area_raw", "bmi_raw", "bp_diastolic_raw", "bp_systolic_raw", "case_status_raw", "danger_signs_raw", "edd_raw", "field_worker_id_raw", "gestational_age_weeks_raw", "gravida_raw", "hemoglobin_g_dl_raw", "household_id_raw", "hypertension_flag_raw", "lmp_date_raw", "mother_name_raw", "next_visit_date_raw", "notes_raw", "parity_raw", "partner_ngo_raw", "pregnancy_id_raw", "prior_c_section_raw", "referral_status_raw", "risk_level_raw", "source_row_id", "synthetic_record_flag", "transport_support_raw", "visit_date_raw", "ward_raw", "visit_date_text", "state_raw" AS "state", "district_raw" AS "district", "visit_id_raw" AS "visit_id", "mother_id_raw" AS "mother_id", "beneficiary_id_raw" AS "beneficiary_id", "referred_facility_raw" AS "referred_facility"
 FROM cte4
) , cte2 as (
SELECT
"_airbyte_extracted_at",
"_airbyte_generation_id",
"_airbyte_meta",
"_airbyte_raw_id",
"age_years_raw",
"anemia_status_raw",
"area_raw",
"beneficiary_id",
"bmi_raw",
"bp_diastolic_raw",
"bp_systolic_raw",
"case_status_raw",
"danger_signs_raw",
"district",
"edd_raw",
"field_worker_id_raw",
"gestational_age_weeks_raw",
"gravida_raw",
"hemoglobin_g_dl_raw",
"household_id_raw",
"hypertension_flag_raw",
"lmp_date_raw",
"mother_id",
"mother_name_raw",
"next_visit_date_raw",
"notes_raw",
"parity_raw",
"partner_ngo_raw",
"pregnancy_id_raw",
"prior_c_section_raw",
"referral_status_raw",
"referred_facility",
"risk_level_raw",
"source_row_id",
"state",
"synthetic_record_flag",
"transport_support_raw",
"visit_date_raw",
"visit_date_text",
"visit_id",
"ward_raw",
CASE
    WHEN "risk_level_raw" = 'critical' THEN 'Critical'
    WHEN "risk_level_raw" = ' critical' THEN 'Critical'
    WHEN "risk_level_raw" = 'critical ' THEN 'Critical'
    WHEN "risk_level_raw" = 'high' THEN 'High'
    WHEN "risk_level_raw" = ' high' THEN 'High'
    WHEN "risk_level_raw" = 'high ' THEN 'High'
    WHEN "risk_level_raw" = 'HIGH' THEN 'High'
    WHEN "risk_level_raw" = 'low' THEN 'Low'
    WHEN "risk_level_raw" = ' low' THEN 'Low'
    WHEN "risk_level_raw" = 'low ' THEN 'Low'
    WHEN "risk_level_raw" = 'LOW' THEN 'Low'
    WHEN "risk_level_raw" = 'moderate' THEN 'Moderate'
    WHEN "risk_level_raw" = ' moderate' THEN 'Moderate'
    WHEN "risk_level_raw" = 'moderate ' THEN 'Moderate'
    WHEN "risk_level_raw" = 'MODERATE' THEN 'Moderate'
    ELSE 'Unknown'
END AS "risk_level"
FROM cte3
) , cte1 as (
SELECT
"_airbyte_extracted_at",
"_airbyte_generation_id",
"_airbyte_meta",
"_airbyte_raw_id",
"age_years_raw",
"anemia_status_raw",
"area_raw",
"beneficiary_id",
"bmi_raw",
"bp_diastolic_raw",
"bp_systolic_raw",
"case_status_raw",
"danger_signs_raw",
"district",
"edd_raw",
"field_worker_id_raw",
"gestational_age_weeks_raw",
"gravida_raw",
"hemoglobin_g_dl_raw",
"household_id_raw",
"hypertension_flag_raw",
"lmp_date_raw",
"mother_id",
"mother_name_raw",
"next_visit_date_raw",
"notes_raw",
"parity_raw",
"partner_ngo_raw",
"pregnancy_id_raw",
"prior_c_section_raw",
"referral_status_raw",
"referred_facility",
"risk_level",
"risk_level_raw",
"source_row_id",
"state",
"synthetic_record_flag",
"transport_support_raw",
"visit_date_raw",
"visit_date_text",
"visit_id",
"ward_raw",
CASE
    WHEN "referral_status_raw" = 'accepted' THEN 'Accepted'
    WHEN "referral_status_raw" = 'accepted ' THEN 'Accepted'
    WHEN "referral_status_raw" = 'ACCEPTED' THEN 'Accepted'
    WHEN "referral_status_raw" = 'counselled' THEN 'Counselled'
    WHEN "referral_status_raw" = ' counselled' THEN 'Counselled'
    WHEN "referral_status_raw" = 'counselled ' THEN 'Counselled'
    WHEN "referral_status_raw" = 'declined' THEN 'Declined'
    WHEN "referral_status_raw" = 'DECLINED' THEN 'Declined'
    WHEN "referral_status_raw" = 'not documented' THEN 'Not Documented'
    WHEN "referral_status_raw" = 'not documented ' THEN 'Not Documented'
    WHEN "referral_status_raw" = 'NOT DOCUMENTED' THEN 'Not Documented'
    WHEN "referral_status_raw" = 'not required' THEN 'Not Required'
    WHEN "referral_status_raw" = 'not required ' THEN 'Not Required'
    WHEN "referral_status_raw" = 'NOT REQUIRED' THEN 'Not Required'
    WHEN "referral_status_raw" = ' referral pending' THEN 'Referral Pending'
    WHEN "referral_status_raw" = 'referral pending' THEN 'Referral Pending'
    WHEN "referral_status_raw" = 'REFERRAL PENDING' THEN 'Referral Pending'
    WHEN "referral_status_raw" = ' referred' THEN 'Referred'
    WHEN "referral_status_raw" = 'referred' THEN 'Referred'
    WHEN "referral_status_raw" = 'referred ' THEN 'Referred'
    WHEN "referral_status_raw" = 'REFERRED' THEN 'Referred'
    WHEN "referral_status_raw" = 'routine ANC' THEN 'Routine ANC'
    WHEN "referral_status_raw" = 'routine ANC ' THEN 'Routine ANC'
    ELSE 'Other'
END AS "referral_status"
FROM cte2
)
-- Final SELECT statement combining the outputs of all CTEs
SELECT *
FROM cte1