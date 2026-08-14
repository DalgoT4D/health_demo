--DBT AUTOMATION has generated this model, please DO NOT EDIT 
--Please make sure you dont change the model name 

{{ config(materialized='table', schema='production') }}
WITH cte1 as (
SELECT DISTINCT ON (meeting_id) meeting_id, beneficiary_id AS clinic_beneficiary_id, clinic_site AS linked_clinic_site, status AS linked_clinic_status, meeting_date AS linked_clinic_date  FROM {{ref('mart_health_clinic_delivery')}})
-- Final SELECT statement combining the outputs of all CTEs
SELECT *
FROM cte1