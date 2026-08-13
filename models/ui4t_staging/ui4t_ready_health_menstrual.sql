--DBT AUTOMATION has generated this model, please DO NOT EDIT 
--Please make sure you dont change the model name 

{{ config(materialized='table', schema='ui4t_staging') }}
WITH cte2 as (
SELECT
"age_raw",
"area",
"awareness_session_attended",
"batch_no",
"beneficiary_group",
"beneficiary_id",
"beneficiary_name",
"cluster",
"distribution_channel",
"distribution_date_text",
"distribution_id",
"distribution_unit",
"district",
"donor_or_program",
"field_worker_id",
"household_id",
"partner_ngo",
"product_type",
"products_distributed",
"receipt_acknowledgement",
"state",
"stockout_reported",
"ward",
CASE
    WHEN "distribution_date_text" = '01/03/2026' THEN '2026-03-01'
    WHEN "distribution_date_text" = '01/05/2026' THEN '2026-05-01'
    WHEN "distribution_date_text" = '01/06/2026' THEN '2026-06-01'
    WHEN "distribution_date_text" = '01/10/2026' THEN '2026-10-01'
    WHEN "distribution_date_text" = '01/16/2026' THEN '2026-01-16'
    WHEN "distribution_date_text" = '01/25/2026' THEN '2026-01-25'
    WHEN "distribution_date_text" = '02/01/2026' THEN '2026-01-02'
    WHEN "distribution_date_text" = '02/06/2026' THEN '2026-06-02'
    WHEN "distribution_date_text" = '02/10/2026' THEN '2026-10-02'
    WHEN "distribution_date_text" = '02/22/2026' THEN '2026-02-22'
    WHEN "distribution_date_text" = '03/12/2026' THEN '2026-12-03'
    WHEN "distribution_date_text" = '03/14/2026' THEN '2026-03-14'
    WHEN "distribution_date_text" = '03/16/2026' THEN '2026-03-16'
    WHEN "distribution_date_text" = '03/17/2026' THEN '2026-03-17'
    WHEN "distribution_date_text" = '03/19/2026' THEN '2026-03-19'
    WHEN "distribution_date_text" = '03/22/2026' THEN '2026-03-22'
    WHEN "distribution_date_text" = '03/23/2026' THEN '2026-03-23'
    WHEN "distribution_date_text" = '04/01/2026' THEN '2026-01-04'
    WHEN "distribution_date_text" = '04/02/2026' THEN '2026-02-04'
    WHEN "distribution_date_text" = '04-05-26' THEN '2026-05-04'
    WHEN "distribution_date_text" = '04/06/2026' THEN '2026-06-04'
    WHEN "distribution_date_text" = '04/14/2026' THEN '2026-04-14'
    WHEN "distribution_date_text" = '05/03/2026' THEN '2026-03-05'
    WHEN "distribution_date_text" = '05/05/2026' THEN '2026-05-05'
    WHEN "distribution_date_text" = '06/04/2026' THEN '2026-04-06'
    WHEN "distribution_date_text" = '06/05/2026' THEN '2026-05-06'
    WHEN "distribution_date_text" = '06/06/2026' THEN '2026-06-06'
    WHEN "distribution_date_text" = '07/01/2026' THEN '2026-01-07'
    WHEN "distribution_date_text" = '08/03/2026' THEN '2026-03-08'
    WHEN "distribution_date_text" = '08/06/2026' THEN '2026-06-08'
    WHEN "distribution_date_text" = '09/06/2026' THEN '2026-06-09'
    WHEN "distribution_date_text" = '10/01/2026' THEN '2026-01-10'
    WHEN "distribution_date_text" = '10/02/2026' THEN '2026-02-10'
    WHEN "distribution_date_text" = '11/04/2026' THEN '2026-04-11'
    WHEN "distribution_date_text" = '11-06-26' THEN '2026-06-11'
    WHEN "distribution_date_text" = '12/06/2026' THEN '2026-06-12'
    WHEN "distribution_date_text" = '13-04-26' THEN '2026-04-13'
    WHEN "distribution_date_text" = '14/01/2026' THEN '2026-01-14'
    WHEN "distribution_date_text" = '14/03/2026' THEN '2026-03-14'
    WHEN "distribution_date_text" = '14/04/2026' THEN '2026-04-14'
    WHEN "distribution_date_text" = '14/05/2026' THEN '2026-05-14'
    WHEN "distribution_date_text" = '15/01/2026' THEN '2026-01-15'
    WHEN "distribution_date_text" = '15-04-26' THEN '2026-04-15'
    WHEN "distribution_date_text" = '16/04/2026' THEN '2026-04-16'
    WHEN "distribution_date_text" = '17/04/2026' THEN '2026-04-17'
    WHEN "distribution_date_text" = '17/06/2026' THEN '2026-06-17'
    WHEN "distribution_date_text" = '18/03/2026' THEN '2026-03-18'
    WHEN "distribution_date_text" = '18/06/2026' THEN '2026-06-18'
    WHEN "distribution_date_text" = '19/02/2026' THEN '2026-02-19'
    WHEN "distribution_date_text" = '19/06/2026' THEN '2026-06-19'
    WHEN "distribution_date_text" = '20/01/2026' THEN '2026-01-20'
    WHEN "distribution_date_text" = '20-03-26' THEN '2026-03-20'
    WHEN "distribution_date_text" = '2026/01/19' THEN '2026-01-19'
    WHEN "distribution_date_text" = '2026/01/25' THEN '2026-01-25'
    WHEN "distribution_date_text" = '2026/02/12' THEN '2026-02-12'
    WHEN "distribution_date_text" = '2026/02/28' THEN '2026-02-28'
    WHEN "distribution_date_text" = '2026/03/04' THEN '2026-03-04'
    WHEN "distribution_date_text" = '2026/03/16' THEN '2026-03-16'
    WHEN "distribution_date_text" = '2026/03/24' THEN '2026-03-24'
    WHEN "distribution_date_text" = '2026/03/25' THEN '2026-03-25'
    WHEN "distribution_date_text" = '2026/03/28' THEN '2026-03-28'
    WHEN "distribution_date_text" = '2026/03/31' THEN '2026-03-31'
    WHEN "distribution_date_text" = '2026/04/07' THEN '2026-04-07'
    WHEN "distribution_date_text" = '2026/04/24' THEN '2026-04-24'
    WHEN "distribution_date_text" = '2026/04/30' THEN '2026-04-30'
    WHEN "distribution_date_text" = '2026/05/16' THEN '2026-05-16'
    WHEN "distribution_date_text" = '2026/05/19' THEN '2026-05-19'
    WHEN "distribution_date_text" = '2026/05/25' THEN '2026-05-25'
    WHEN "distribution_date_text" = '2026/05/26' THEN '2026-05-26'
    WHEN "distribution_date_text" = '2026/06/01' THEN '2026-06-01'
    WHEN "distribution_date_text" = '2026/06/15' THEN '2026-06-15'
    WHEN "distribution_date_text" = '2026/06/21' THEN '2026-06-21'
    WHEN "distribution_date_text" = '21/03/2026' THEN '2026-03-21'
    WHEN "distribution_date_text" = '21/04/2026' THEN '2026-04-21'
    WHEN "distribution_date_text" = '22/03/2026' THEN '2026-03-22'
    WHEN "distribution_date_text" = '22-04-26' THEN '2026-04-22'
    WHEN "distribution_date_text" = '22/05/2026' THEN '2026-05-22'
    WHEN "distribution_date_text" = '24-04-26' THEN '2026-04-24'
    WHEN "distribution_date_text" = '25/03/2026' THEN '2026-03-25'
    WHEN "distribution_date_text" = '25/06/2026' THEN '2026-06-25'
    WHEN "distribution_date_text" = '26/02/2026' THEN '2026-02-26'
    WHEN "distribution_date_text" = '26/06/2026' THEN '2026-06-26'
    WHEN "distribution_date_text" = '27/01/2026' THEN '2026-01-27'
    WHEN "distribution_date_text" = '27/05/2026' THEN '2026-05-27'
    WHEN "distribution_date_text" = '30-01-26' THEN '2026-01-30'
    WHEN "distribution_date_text" = 'Fri May 29 2026' THEN '2026-05-29'
    WHEN "distribution_date_text" = 'Mon Jun 15 2026' THEN '2026-06-15'
    WHEN "distribution_date_text" = 'NA' THEN '2026-01-15'
    WHEN "distribution_date_text" = 'not known' THEN '2026-01-15'
    WHEN "distribution_date_text" = 'pending' THEN '2026-01-15'
    WHEN "distribution_date_text" = 'Sat May 23 2026' THEN '2026-05-23'
    WHEN "distribution_date_text" = 'Thu Apr 16 2026' THEN '2026-04-16'
    WHEN "distribution_date_text" = 'Tue Apr 07 2026' THEN '2026-04-07'
    WHEN "distribution_date_text" = 'Tue Jan 13 2026' THEN '2026-01-13'
    WHEN "distribution_date_text" = 'Tue Jan 27 2026' THEN '2026-01-27'
    ELSE "distribution_date_text"
END AS "distribution_date_normalized"
FROM {{ref('ui4t_stage_health_menstrual')}}
) , cte1 as (
SELECT "age_raw", "area", "awareness_session_attended", "batch_no", "beneficiary_group", "beneficiary_id", "beneficiary_name", "cluster", "distribution_channel", "distribution_date_normalized", "distribution_date_text", "distribution_id", "distribution_unit", "district", "donor_or_program", "field_worker_id", "household_id", "partner_ngo", "product_type", "products_distributed", "receipt_acknowledgement", "state", "stockout_reported", "ward", TO_DATE("distribution_date_normalized", 'YYYY-MM-DD') AS distribution_date FROM cte2)
-- Final SELECT statement combining the outputs of all CTEs
SELECT *
FROM cte1