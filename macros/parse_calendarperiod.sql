{% macro parse_calendarperiod(col) %}

CASE
    /* ===============================
       Quarterly formats: 1QCY-2025
       =============================== */
    WHEN REGEXP_LIKE({{ col }}, '^[1-4]Q(CY|FY)-[0-9]{4}$') THEN
        -- Extract quarter and year
        DATEADD(
            month,
            CASE SUBSTR({{ col }}, 1, 1)
                WHEN '1' THEN 2  -- March
                WHEN '2' THEN 5  -- June
                WHEN '3' THEN 8  -- September
                WHEN '4' THEN 11 -- December
            END,
            TO_DATE(REGEXP_SUBSTR({{ col }}, '[0-9]{4}$') || '-01-01')
        )

    /* ===============================
       Annual formats: CY-2025
       =============================== */
    WHEN REGEXP_LIKE({{ col }}, '^(CY|FY)-[0-9]{4}$') THEN
        DATEADD(
            month,
            11,   -- December
            TO_DATE(REGEXP_SUBSTR({{ col }}, '[0-9]{4}$') || '-01-01')
        )

    ELSE NULL
END

{% endmacro %}

