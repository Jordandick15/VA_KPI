{{ config(materialized='table') }}

SELECT *
FROM {{ source('va', 'company_advanced_info_v2') }}