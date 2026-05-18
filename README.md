# Tributary Analyses

SQL analyses on the Tributary synthetic fincrime dataset, organized as the kinds of questions a senior data analyst would ask when joining a European PSP.

This is not a SQL tutorial repo. It's a working notebook of analyses where each query has a writeup explaining what business question it answers and what the result means. The framing — "what would a senior analyst ask" — is as important as the SQL itself.

## How this repo is organized

```
queries/
  01_baseline_volume.sql
  02_alert_false_positive_rate.sql
  ...
writeups/
  01_baseline_volume.md
  02_alert_false_positive_rate.md
  ...
```

Each query lives in `queries/` numbered by sequence. Each query has a corresponding writeup in `writeups/` with the same number and name.

Writeups follow a consistent structure:
- **Question.** The business question in plain English.
- **Why a senior analyst asks this.** The framing — why this is the right question to ask before any data is queried.
- **Approach.** How the query answers it (without restating the SQL).
- **Result.** What the data showed.
- **Followup questions.** What this surfaces that needs deeper analysis.

## How to run the queries

These queries assume Tributary data is loaded into a database. Two paths:

### Option A: Local DuckDB (fastest, no setup)

```bash
# In the tributary-data repo:
python load.py  # decompresses transactions.csv.gz

# Then in DuckDB:
duckdb tributary.db
CREATE TABLE customers AS SELECT * FROM read_csv_auto('path/to/customers.csv');
CREATE TABLE transactions AS SELECT * FROM read_csv_auto('path/to/transactions.csv');
CREATE TABLE chargebacks AS SELECT * FROM read_csv_auto('path/to/chargebacks.csv');
CREATE TABLE kyc_events AS SELECT * FROM read_csv_auto('path/to/kyc_events.csv');
CREATE TABLE compliance_alerts AS SELECT * FROM read_csv_auto('path/to/compliance_alerts.csv');
```

### Option B: Snowflake (matches what dbt project uses)

Load CSVs via Snowflake's COPY INTO from a stage. See the `tributary-dbt` repo for the schema setup.

## Current analyses

(This list grows as analyses are added. Initial template included as `00_template`.)

## License

[License TBD]
