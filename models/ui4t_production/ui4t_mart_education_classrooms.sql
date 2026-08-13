--DBT AUTOMATION has generated this model, please DO NOT EDIT 
--Please make sure you dont change the model name 

{{ config(materialized='table', schema='ui4t_production') }}
WITH cte6 as (
SELECT
CAST("_airbyte_raw_id" AS character varying) AS "_airbyte_raw_id",
CAST("_airbyte_extracted_at" AS timestamp with time zone) AS "_airbyte_extracted_at",
CAST("_airbyte_meta" AS jsonb) AS "_airbyte_meta",
CAST("_airbyte_generation_id" AS bigint) AS "_airbyte_generation_id",
CAST("grade" AS character varying) AS "grade",
CAST("state" AS character varying) AS "state",
CAST("section" AS character varying) AS "section",
CAST("district" AS character varying) AS "district",
CAST("school_id" AS character varying) AS "school_id",
CAST("school_name" AS character varying) AS "school_name",
CAST("_airtable_id" AS character varying) AS "_airtable_id",
CAST("classroom_id" AS character varying) AS "classroom_id",
CAST("academic_year" AS character varying) AS "academic_year",
CAST("classroom_name" AS character varying) AS "classroom_name",
CAST("classroom_status" AS character varying) AS "classroom_status",
CAST("enrolled_students" AS integer) AS "enrolled_students",
CAST("school_management" AS character varying) AS "school_management",
CAST("classroom_capacity" AS integer) AS "classroom_capacity",
CAST("_airtable_table_name" AS character varying) AS "_airtable_table_name",
CAST("_airtable_created_time" AS character varying) AS "_airtable_created_time"
FROM {{source('staging', 'education_ngo_airtable_source_xlsx_raw_classrooms_tblb_61427117')}}
) , cte5 as (
SELECT "_airbyte_raw_id", "_airbyte_extracted_at", "_airbyte_meta", "_airbyte_generation_id", "grade", "state", "section", "district", "school_id", "school_name", "_airtable_id", "classroom_id", "academic_year", "classroom_name", "classroom_status", "enrolled_students", "school_management", "classroom_capacity", "_airtable_table_name", "_airtable_created_time",{{dbt_utils.safe_subtract(['"classroom_capacity"','"enrolled_students"'])}} AS "seats_available" 
 FROM cte6
) , cte4 as (
SELECT "grade", "state", "section", "district", "school_id", "school_name", "classroom_id", "academic_year", "classroom_name", "classroom_status", "enrolled_students", "school_management", "classroom_capacity", "seats_available"
FROM cte5
) , cte3 as (
SELECT "grade", "state", "section", "district", "school_id", "school_name", "classroom_id", "academic_year", "classroom_name", "classroom_status", "enrolled_students", "school_management", "classroom_capacity", "seats_available",{{dbt_utils.safe_divide('"enrolled_students"','"classroom_capacity"',)}} AS "utilization_ratio" 
 FROM cte4
) , cte2 as (
SELECT "grade", "state", "section", "district", "school_id", "school_name", "classroom_id", "academic_year", "classroom_name", "classroom_status", "enrolled_students", "school_management", "classroom_capacity", "seats_available", "utilization_ratio","utilization_ratio" * '100'  AS "utilization_rate" 
 FROM cte3
) , cte1 as (
SELECT "grade", "state", "section", "district", "school_id", "school_name", "classroom_id", "academic_year", "classroom_name", "classroom_status", "enrolled_students", "school_management", "classroom_capacity", "seats_available", "utilization_rate"
FROM cte2
)
-- Final SELECT statement combining the outputs of all CTEs
SELECT *
FROM cte1