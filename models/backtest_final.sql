{{ config(materialized='table') }}

SELECT
    -- ======================
    -- 1. CLEAN TICKER SYMBOL
    -- ======================
    COALESCE(
        NULLIF(SPLIT_PART(META_BLOOMBERG_TICKER, ' ', 1), ''),
        META_BLOOMBERG_TICKER
    ) AS BT_SYMBOL,

    -- =============================
    -- 2. CREATE QUARTER MAPPING
    -- Input examples:
    --   '3QFY-2025'
    --   '2QFY-2016'
    --   '4QCY-2022'
    -- We convert all to '2025Q3'
    -- =============================
    REGEXP_REPLACE(CALENDARPERIOD, '.*?(\\d)Q\\w+-(\\d{4}).*', '\\2Q\\1')
        AS CALENDAR_QUARTER_MAPPING,

    -- Keep raw column for inspection
    CALENDARPERIOD AS CALENDARPERIOD_RAW,

    -- Keep everything else from your parsed VA meta table
    *
FROM {{ ref('backtest_meta_parsed') }}
WHERE CALENDARPERIOD ILIKE '%Q%'   -- only quarterly periods
ORDER BY BT_SYMBOL, CALENDARPERIOD

