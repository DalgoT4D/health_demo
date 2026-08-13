--DBT AUTOMATION has generated this model, please DO NOT EDIT 
--Please make sure you dont change the model name 

{{ config(materialized='table', schema='production') }}
WITH cte1 as (
SELECT "age_raw", "area", "awareness_session_attended", "batch_no", "beneficiary_group", "beneficiary_id", "beneficiary_name", "cluster", "distribution_channel", "distribution_date_text", "distribution_id", "distribution_unit", "district", "donor_or_program", "field_worker_id", "household_id", "partner_ngo", "product_type", "products_distributed", "receipt_acknowledgement", "state", "stockout_reported", "ward", TO_NUMBER("products_distributed", '999') AS products_distributed_numeric FROM {{ref('ui4t_stage_health_menstrual')}})
-- Final SELECT statement combining the outputs of all CTEs
SELECT *
FROM cte1