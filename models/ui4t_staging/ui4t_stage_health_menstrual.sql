--DBT AUTOMATION has generated this model, please DO NOT EDIT 
--Please make sure you dont change the model name 

{{ config(materialized='table', schema='ui4t_staging') }}
WITH cte6 as (
SELECT
"_airbyte_extracted_at",
"_airbyte_generation_id",
"_airbyte_meta",
"_airbyte_raw_id",
"age_raw",
"area_raw",
"awareness_session_attended_raw",
"batch_no_raw",
"beneficiary_group_raw",
"beneficiary_id_raw",
"beneficiary_name_raw",
"cluster_raw",
"distribution_channel_raw",
"distribution_date_raw",
"distribution_id_raw",
"district_raw",
"donor_or_program_raw",
"entered_by",
"field_worker_id_raw",
"household_id_raw",
"notes_raw",
"partner_ngo_raw",
"product_type_raw",
"quantity_raw",
"receipt_ack_raw",
"source_row_id",
"state_raw",
"stockout_reported_raw",
"synthetic_record_flag",
"unit_raw",
"ward_raw",
CASE
    WHEN "product_type_raw" = 'Sanitary pad packet' THEN 'Sanitary Pads'
    WHEN "product_type_raw" = 'sanitary pads pack' THEN 'Sanitary Pads'
    WHEN "product_type_raw" = 'reusable cloth pad kit' THEN 'Reusable Cloth Pad Kit'
    WHEN "product_type_raw" = 'period hygiene kit' THEN 'Period Hygiene Kit'
    WHEN "product_type_raw" = 'menstrual cup' THEN 'Menstrual Cup'
    WHEN "product_type_raw" = 'disposal bags' THEN 'Disposal Bags'
    WHEN "product_type_raw" = 'SANITARY PADS PACK' THEN 'Sanitary Pads'
    WHEN "product_type_raw" = 'REUSABLE CLOTH PAD KIT' THEN 'Reusable Cloth Pad Kit'
    WHEN "product_type_raw" = 'PERIOD HYGIENE KIT' THEN 'Period Hygiene Kit'
    WHEN "product_type_raw" = 'MENSTRUAL CUP' THEN 'Menstrual Cup'
    WHEN "product_type_raw" = ' Sanitary pad packet' THEN 'Sanitary Pads'
    WHEN "product_type_raw" = '  Sanitary pad packet' THEN 'Sanitary Pads'
    WHEN "product_type_raw" = ' reusable cloth pad kit' THEN 'Reusable Cloth Pad Kit'
    WHEN "product_type_raw" = ' sanitary pads pack' THEN 'Sanitary Pads'
    WHEN "product_type_raw" = 'sanitary pad packet' THEN 'Sanitary Pads'
    WHEN "product_type_raw" = 'sanitary pads pack ' THEN 'Sanitary Pads'
    WHEN "product_type_raw" = 'menstrual cup ' THEN 'Menstrual Cup'
    WHEN "product_type_raw" = 'Sanitary pad packet ' THEN 'Sanitary Pads'
    WHEN "product_type_raw" = 'reusable cloth pad kit ' THEN 'Reusable Cloth Pad Kit'
    ELSE 'Other'
END AS "product_type"
FROM {{source('staging_health', 'raw_sanitary_dist')}}
) , cte5 as (
SELECT
"_airbyte_extracted_at",
"_airbyte_generation_id",
"_airbyte_meta",
"_airbyte_raw_id",
"age_raw",
"area_raw",
"awareness_session_attended_raw",
"batch_no_raw",
"beneficiary_group_raw",
"beneficiary_id_raw",
"beneficiary_name_raw",
"cluster_raw",
"distribution_channel_raw",
"distribution_date_raw",
"distribution_id_raw",
"district_raw",
"donor_or_program_raw",
"entered_by",
"field_worker_id_raw",
"household_id_raw",
"notes_raw",
"partner_ngo_raw",
"product_type",
"product_type_raw",
"quantity_raw",
"receipt_ack_raw",
"source_row_id",
"state_raw",
"stockout_reported_raw",
"synthetic_record_flag",
"unit_raw",
"ward_raw",
CASE
    WHEN "quantity_raw" = '1' THEN '1'
    WHEN "quantity_raw" = '2' THEN '2'
    WHEN "quantity_raw" = '3' THEN '3'
    WHEN "quantity_raw" = '4' THEN '4'
    WHEN "quantity_raw" = '1 packs' THEN '1'
    WHEN "quantity_raw" = '1 pack' THEN '1'
    WHEN "quantity_raw" = '2 packs' THEN '2'
    WHEN "quantity_raw" = '2 pack' THEN '2'
    WHEN "quantity_raw" = '3 packs' THEN '3'
    WHEN "quantity_raw" = '3 pack' THEN '3'
    WHEN "quantity_raw" = '4 packs' THEN '4'
    WHEN "quantity_raw" = '4 pack' THEN '4'
    ELSE '0'
END AS "products_distributed"
FROM cte6
) , cte4 as (
SELECT "_airbyte_extracted_at", "_airbyte_generation_id", "_airbyte_meta", "_airbyte_raw_id", "age_raw", "awareness_session_attended_raw", "entered_by", "notes_raw", "product_type", "product_type_raw", "quantity_raw", "source_row_id", "stockout_reported_raw", "synthetic_record_flag", "products_distributed", "area_raw" AS "area", "unit_raw" AS "distribution_unit", "ward_raw" AS "ward", "state_raw" AS "state", "cluster_raw" AS "cluster", "batch_no_raw" AS "batch_no", "district_raw" AS "district", "partner_ngo_raw" AS "partner_ngo", "receipt_ack_raw" AS "receipt_acknowledgement", "household_id_raw" AS "household_id", "beneficiary_id_raw" AS "beneficiary_id", "distribution_id_raw" AS "distribution_id", "field_worker_id_raw" AS "field_worker_id", "beneficiary_name_raw" AS "beneficiary_name", "donor_or_program_raw" AS "donor_or_program", "beneficiary_group_raw" AS "beneficiary_group", "distribution_date_raw" AS "distribution_date_text", "distribution_channel_raw" AS "distribution_channel"
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
"distribution_date_text",
"distribution_id",
"distribution_unit",
"district",
"donor_or_program",
"entered_by",
"field_worker_id",
"household_id",
"notes_raw",
"partner_ngo",
"product_type",
"product_type_raw",
"products_distributed",
"quantity_raw",
"receipt_acknowledgement",
"source_row_id",
"state",
"stockout_reported_raw",
"synthetic_record_flag",
"ward",
CASE
    WHEN "stockout_reported_raw" = 'yes' THEN 'true'
    WHEN "stockout_reported_raw" = 'y' THEN 'true'
    WHEN "stockout_reported_raw" = 'true' THEN 'true'
    WHEN "stockout_reported_raw" = '1' THEN 'true'
    ELSE 'false'
END AS "stockout_reported"
FROM cte4
) , cte2 as (
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
"distribution_date_text",
"distribution_id",
"distribution_unit",
"district",
"donor_or_program",
"entered_by",
"field_worker_id",
"household_id",
"notes_raw",
"partner_ngo",
"product_type",
"product_type_raw",
"products_distributed",
"quantity_raw",
"receipt_acknowledgement",
"source_row_id",
"state",
"stockout_reported",
"stockout_reported_raw",
"synthetic_record_flag",
"ward",
CASE
    WHEN "awareness_session_attended_raw" = 'yes' THEN 'true'
    WHEN "awareness_session_attended_raw" = 'y' THEN 'true'
    WHEN "awareness_session_attended_raw" = 'true' THEN 'true'
    WHEN "awareness_session_attended_raw" = '1' THEN 'true'
    ELSE 'false'
END AS "awareness_session_attended"
FROM cte3
) , cte1 as (
SELECT "age_raw", "area", "batch_no", "beneficiary_group", "beneficiary_id", "beneficiary_name", "cluster", "distribution_channel", "distribution_date_text", "distribution_id", "distribution_unit", "district", "donor_or_program", "field_worker_id", "household_id", "partner_ngo", "product_type", "products_distributed", "receipt_acknowledgement", "state", "stockout_reported", "ward", "awareness_session_attended"
FROM cte2
)
-- Final SELECT statement combining the outputs of all CTEs
SELECT *
FROM cte1