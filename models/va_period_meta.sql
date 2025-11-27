{{ config(materialized='view') }}

SELECT
    *
FROM {{ source('va', 'period_meta_advanced_v2') }}