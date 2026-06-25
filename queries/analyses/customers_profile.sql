-- ============================================================
-- Analysis: Customer base profile (grain, geography, risk)
-- Table:    customers (grain: one row per customer)
-- Author:   Nitu | Date: 2026-06-24
-- Engine:   DuckDB | DB: tributary.db
-- Purpose:  First descriptive pass on the customer base —
--           verify grain, then profile geography and risk.
-- ============================================================

-- 1. GRAIN CHECK — confirm one row per customer (assert-then-verify).
--    If these two numbers match, customer_id is unique => safe to count.
SELECT COUNT(*)                  AS rows,
       COUNT(DISTINCT customer_id) AS unique_ids
FROM customers;
-- Result: 50,000 = 50,000. Grain confirmed.

-- 2. GEOGRAPHY — customer count by country, sorted, for concentration.
SELECT country,
       COUNT(*) AS customer_count
FROM customers
GROUP BY country
ORDER BY customer_count DESC;
-- Result: NL 8,992 · DE 7,990 · FR 6,947 · ES 5,549 · IT 4,975
--         BE 3,402 · PT 3,122 · AT 2,475 · IE 2,472 · PL 1,985
--         SE 1,070 · DK 1,021
-- Read: top 5 markets ≈ 34,453 / 50,000 ≈ 69% of customers.

-- 3. RISK CLASS — distribution of the signup-time risk label.
SELECT initial_risk_class,
       COUNT(*) AS n
FROM customers
GROUP BY initial_risk_class
ORDER BY n DESC;
-- Result: low 31,464 (≈63%) · medium 18,044 (≈36%) · high 492 (≈1%).
-- Note: initial_risk_class is a PREDICTION frozen at signup,
--       not ground truth. 492 flagged-high vs 425 actual bad actors.

-- 4. RISK SCORE — range first (always, before binning).
SELECT MIN(initial_risk_score) AS min_score,
       MAX(initial_risk_score) AS max_score,
       AVG(initial_risk_score) AS mean_score,
       MEDIAN(initial_risk_score) AS median_score   -- run to confirm
FROM customers;
-- Result: min 0 · max 83 · mean 24.83 · median <TODO: paste>.

-- 5. RISK SCORE HISTOGRAM — bin width 10 (chosen from the 0–83 range).
SELECT FLOOR(initial_risk_score / 10) * 10 AS risk_band,
       COUNT(*) AS num_customers
FROM customers
GROUP BY risk_band
ORDER BY risk_band;
-- Result: <TODO: paste binned counts>.