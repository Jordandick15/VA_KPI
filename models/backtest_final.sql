{{ config(materialized='table') }}

SELECT
    *
FROM {{ ref('backtest_meta_parsed') }}
ORDER BY
    META_VATICKER,
    CALENDAR_QUARTER_END_DATE
