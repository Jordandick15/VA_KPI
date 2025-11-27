{{ config(materialized='table') }}

SELECT
    bmp.*,
    {{ parse_calendarperiod("CALENDARPERIOD") }} AS CALENDAR_QUARTER_END_DATE
FROM {{ ref('backtest_meta') }} bmp
