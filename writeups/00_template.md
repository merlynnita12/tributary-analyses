# 00 — Baseline transaction volume

*This is a template. Delete once you have real writeups; it exists to show the pattern.*

## The question

What's the baseline shape of transaction activity over the 18-month window?

## Why a senior analyst asks this

Before any specific analysis, you need to know the shape of the data. Three reasons:

1. Sanity check. If the volume curve has a discontinuity, the data has a problem you need to find before any downstream analysis is trustworthy.
2. Context for everything else. When you later see an alert volume spike, you need to know whether it's proportional to transaction volume growth or actually anomalous.
3. Stakeholder vocabulary. The first question any executive will ask is "how many transactions, how many customers." Having that number ready means you spend the meeting on the analysis, not on basic descriptive stats.

The wrong move is to jump straight into fraud detection queries. Domain-specific analysis without a volume baseline is analysis floating in air.

## Approach

Monthly aggregation with three views: raw count, distinct active customers, and tx-per-customer rate. The rate matters because raw volume growth can come from either more customers or more activity per customer, and those are different stories.

## Result

(Fill in after running the query.)

## Followup questions

Suggested directions this opens up:
- Is the growth coming from new customer acquisition or existing customer expansion?
- Which countries or industries drive the most volume?
- Does the active-customer count match what we'd expect from the signup cohort sizes?
