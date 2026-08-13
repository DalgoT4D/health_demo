--DBT AUTOMATION has generated this model, please DO NOT EDIT 
--Please make sure you dont change the model name 

{{ config(materialized='table', schema='ui4t_staging') }}
WITH cte7 as (
SELECT "_airbyte_raw_id", "_airbyte_extracted_at", "_airbyte_meta", "_airbyte_generation_id", "age_raw", "notes_raw", "entered_by", "quantity_raw", "source_row_id", "product_type_raw", "distribution_date_raw", "stockout_reported_raw", "synthetic_record_flag", "awareness_session_attended_raw", "area_raw" AS "area", "unit_raw" AS "distribution_unit", "ward_raw" AS "ward", "state_raw" AS "state", "cluster_raw" AS "cluster", "batch_no_raw" AS "batch_no", "district_raw" AS "district", "partner_ngo_raw" AS "partner_ngo", "receipt_ack_raw" AS "receipt_acknowledgement", "household_id_raw" AS "household_id", "beneficiary_id_raw" AS "beneficiary_id", "distribution_id_raw" AS "distribution_id", "field_worker_id_raw" AS "field_worker_id", "beneficiary_name_raw" AS "beneficiary_name", "donor_or_program_raw" AS "donor_or_program", "beneficiary_group_raw" AS "beneficiary_group", "distribution_channel_raw" AS "distribution_channel"
 FROM {{source('staging_health', 'raw_sanitary_dist')}}
) , cte6 as (
SELECT "_airbyte_extracted_at", "_airbyte_generation_id", "_airbyte_meta", "_airbyte_raw_id", "age_raw", "area", "awareness_session_attended_raw", "batch_no", "beneficiary_group", "beneficiary_id", "beneficiary_name", "cluster", "distribution_channel", "distribution_date_raw", "distribution_id", "distribution_unit", "district", "donor_or_program", "entered_by", "field_worker_id", "household_id", "notes_raw", "partner_ngo", "product_type_raw", "quantity_raw", "receipt_acknowledgement", "source_row_id", "state", "stockout_reported_raw", "synthetic_record_flag", "ward", TRIM("product_type_raw") AS product_type_clean FROM cte7) , cte5 as (
SELECT "_airbyte_extracted_at", "_airbyte_generation_id", "_airbyte_meta", "_airbyte_raw_id", "age_raw", "area", "awareness_session_attended_raw", "batch_no", "beneficiary_group", "beneficiary_id", "beneficiary_name", "cluster", "distribution_channel", "distribution_date_raw", "distribution_id", "distribution_unit", "district", "donor_or_program", "entered_by", "field_worker_id", "household_id", "notes_raw", "partner_ngo", "product_type_raw", "quantity_raw", "receipt_acknowledgement", "source_row_id", "state", "stockout_reported_raw", "synthetic_record_flag", "ward", LOWER("product_type_raw") AS product_type_key FROM cte6) , cte4 as (
SELECT
"_airbyte_extracted_at",
"_airbyte_generation_id",
"_airbyte_meta",
"_airbyte_raw_id",
"age_raw",
"area",
"awareness_session_attended_raw",
"batch_no",
"beneficiary_group",
"beneficiary_id",
"beneficiary_name",
"cluster",
"distribution_channel",
"distribution_date_raw",
"distribution_id",
"distribution_unit",
"district",
"donor_or_program",
"entered_by",
"field_worker_id",
"household_id",
"notes_raw",
"partner_ngo",
"quantity_raw",
"receipt_acknowledgement",
"source_row_id",
"state",
"stockout_reported_raw",
"synthetic_record_flag",
"ward",
REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE("product_type_raw", 'Sanitary pad packet', 'Sanitary Pads'), 'sanitary pads pack', 'Sanitary Pads'), 'reusable cloth pad kit', 'Reusable Cloth Pad Kit'), 'period hygiene kit', 'Period Hygiene Kit'), 'menstrual cup', 'Menstrual Cup'), 'disposal bags', 'Disposal Bags'), 'SANITARY PADS PACK', 'Sanitary Pads'), 'REUSABLE CLOTH PAD KIT', 'Reusable Cloth Pad Kit'), 'PERIOD HYGIENE KIT', 'Period Hygiene Kit'), 'MENSTRUAL CUP', 'Menstrual Cup'), ' Sanitary pad packet', 'Sanitary Pads'), '  Sanitary pad packet', 'Sanitary Pads'), ' reusable cloth pad kit', 'Reusable Cloth Pad Kit'), ' sanitary pads pack', 'Sanitary Pads') AS "product_type_raw"
FROM cte5
) , cte3 as (
SELECT
"_airbyte_extracted_at",
"_airbyte_generation_id",
"_airbyte_meta",
"_airbyte_raw_id",
"age_raw",
"area",
"awareness_session_attended_raw",
"batch_no",
"beneficiary_group",
"beneficiary_id",
"beneficiary_name",
"cluster",
"distribution_channel",
"distribution_date_raw",
"distribution_id",
"distribution_unit",
"district",
"donor_or_program",
"entered_by",
"field_worker_id",
"household_id",
"notes_raw",
"partner_ngo",
"product_type_raw",
"receipt_acknowledgement",
"source_row_id",
"state",
"stockout_reported_raw",
"synthetic_record_flag",
"ward",
"product_type_raw",
REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE("quantity_raw", 'NA', '0'), '1 packs', '1'), '1 pack', '1'), '2 packs', '2'), '2 pack', '2'), '3 packs', '3'), '3 pack', '3'), '4 packs', '4'), '4 pack', '4') AS "quantity_raw"
FROM cte4
) , cte2 as (
SELECT "_airbyte_extracted_at", "_airbyte_generation_id", "_airbyte_meta", "_airbyte_raw_id", "age_raw", "area", "awareness_session_attended_raw", "batch_no", "beneficiary_group", "beneficiary_id", "beneficiary_name", "cluster", "distribution_channel", "distribution_date_raw", "distribution_id", "distribution_unit", "district", "donor_or_program", "entered_by", "field_worker_id", "household_id", "notes_raw", "partner_ngo", "receipt_acknowledgement", "source_row_id", "state", "stockout_reported_raw", "synthetic_record_flag", "ward", "quantity_raw" AS "products_distributed", "product_type_raw" AS "product_type"
 FROM cte3
) , cte1 as (
SELECT "age_raw", "area", "awareness_session_attended_raw", "batch_no", "beneficiary_group", "beneficiary_id", "beneficiary_name", "cluster", "distribution_channel", "distribution_date_raw", "distribution_id", "distribution_unit", "district", "donor_or_program", "field_worker_id", "household_id", "partner_ngo", "receipt_acknowledgement", "state", "stockout_reported_raw", "ward", "product_type", "products_distributed"
FROM cte2
)
-- Final SELECT statement combining the outputs of all CTEs
SELECT *
FROM cte1