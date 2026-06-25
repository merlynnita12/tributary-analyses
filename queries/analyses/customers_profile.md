# Customer Base Profile — Geography & Risk

**Table:** `customers` (grain: one row per customer)
**Date:** 2026-06-24 · **Engine:** DuckDB

## Question
Before any customer analysis, who *are* our customers — where are
they, and how is risk distributed across the base?

## Why a senior analyst asks this
You can't interpret any downstream metric (fraud rate, volume,
churn) without knowing the shape of the base it sits on. Profiling
geography and risk first sets the baseline that makes later
anomalies legible — and surfaces data-quality issues before they
contaminate analysis.

## Approach
1. **Verify grain** — confirm `customer_id` is unique
   (`COUNT(*)` vs `COUNT(DISTINCT)`), so counts are trustworthy.
2. **Geography** — count by country, sorted, read as a share.
3. **Risk class** — distribution of the signup-time label.
4. **Risk score** — profile the range, then bin into a histogram.

## Result
- **Grain:** 50,000 rows = 50,000 unique IDs. One row per customer,
  no duplicates.
- **Geography:** ~69% of customers sit in five markets
  (NL, DE, FR, ES, IT); NL + DE alone ≈ a third. The remaining
  seven countries are a thin tail (DK, SE, PL ≈ 1,000 each).
- **Risk class:** ~63% low / 36% medium / 1% high (492 customers)
  — a risk pyramid, the expected shape.
- **Risk score:** ranges 0–83, mean 24.8 [median + histogram: TODO].

## Caveats (provenance)
- `initial_risk_class` is a **prediction frozen at signup**, not a
  verdict. 492 flagged-high vs 425 actual bad actors — the gap is
  false positives/negatives. Never report flagged-high as "bad."
- This is a **headcount** view — where customers *are*, not where
  volume or risk *is*. A small market by headcount may be large by
  transaction value.

## Follow-up questions
- Does risk concentrate in specific markets? (risk_class × country)
- How does the *predicted* risk_class compare to *actual* bad-actor
  outcomes — i.e. what's the scoring model's precision/recall?
- Do thin-tail markets (DK/SE/PL) have enough volume to analyse
  alone, or should they be bucketed?