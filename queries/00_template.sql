-- 00_template.sql
--
-- This is a template showing the structure each query file should follow.
-- Delete this file once you have real queries; it exists to show the pattern.
--
-- Conventions:
--   - Each file starts with a comment block: title, date, one-line description
--   - Use CTEs (WITH clauses) for readability rather than nested subqueries where possible
--   - Comment any non-obvious business logic inline
--   - End with a comment noting what the result tells us

-- Title: Baseline transaction volume by month
-- Date: 2026-05-XX
-- Description: Establishes the rough shape of activity over the 18-month window

WITH monthly_volume AS (
    SELECT
        DATE_TRUNC('month', timestamp::DATE) AS month,
        COUNT(*) AS transaction_count,
        COUNT(DISTINCT customer_id) AS active_customers,
        SUM(amount) AS total_amount
    FROM transactions
    WHERE status = 'completed'
    GROUP BY 1
)
SELECT
    month,
    transaction_count,
    active_customers,
    ROUND(transaction_count::FLOAT / active_customers, 2) AS tx_per_active_customer,
    ROUND(total_amount, 2) AS total_amount_eur_equivalent
FROM monthly_volume
ORDER BY month;

-- Result tells us: rough activity baseline, seasonal patterns if any,
-- whether growth or decay is happening, and a sanity check that the
-- synthetic data behaves like real PSP data would.
