## ETL Decisions

### Decision 1 — Standardizing Date Formats
Problem: The raw file retail_transactions.csv contains dates in three
different formats: DD/MM/YYYY (e.g., 29/08/2023), DD-MM-YYYY
(e.g., 12-12-2023), and the standard YYYY-MM-DD (e.g., 2023-02-05).
This inconsistency makes it impossible to sort, filter, or compare
dates correctly in SQL queries.

Resolution: All dates were converted to the ISO standard format
YYYY-MM-DD before loading into dim_date. For example, 29/08/2023
became 2023-08-29 and 12-12-2023 became 2023-12-12. This ensures
all date comparisons and month-level grouping work correctly.

### Decision 2 — Standardizing Category Casing
Problem: The category column contains the same category written
in different cases across rows. For example, "electronics" and
"Electronics" both appear, and "Grocery" and "Groceries" refer to
the same category. This means GROUP BY queries would treat them as
separate categories and produce incorrect totals.

Resolution: All category values were standardized to title case
and consistent spelling before loading into dim_product. Specifically,
"electronics" was changed to "Electronics" and "Grocery" was changed
to "Groceries" to match the majority spelling in the dataset.

### Decision 3 — Computing total_revenue in the Fact Table
Problem: The raw data only stores units_sold and unit_price as
separate columns. There is no pre-calculated revenue column. Running
multiplication inside every analytical query adds complexity and
risks inconsistency if the formula is applied differently across
reports.

Resolution: A derived column total_revenue was calculated as
units_sold multiplied by unit_price during the ETL load step and
stored directly in the fact_sales table. This ensures all reports
use the same consistent revenue figure without recalculating it
every time.