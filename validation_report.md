# Validation Report

## Dataset Summary

- Rows: 652
- Columns: 13
- Sheet: Sheet1
- Source file: dataset/Initial Public Offering (Updated).xlsx

### Columns
- Date
- IPO_Name
- Issue_Size(crores)
- QIB
- HNI
- RII
- Total
- Offer Price
- List Price
- Listing Gain
- CMP(BSE)
- CMP(NSE)
- Current Gains

### Data Types
- Date: datetime
- IPO_Name: text
- Numeric fields: float or integer

### Date Range
- Earliest date: 2010-01-04
- Latest date: 2026-05-14

### Missing Values
- QIB: 2
- HNI: 2
- RII: 2
- Total: 2
- Listing Gain: 2
- CMP(BSE): 2
- CMP(NSE): 10
- Current Gains: 3

### Duplicate Records
- Duplicate rows: 0

## SQL Validation

### Queries Verified
- Business queries were reviewed against the actual workbook columns and business logic.
- Thresholds were adjusted to be more data-driven where possible.

### Queries Modified
- Replaced a hardcoded return threshold with a comparison against the average return in the dataset.
- Replaced a hardcoded outlier-style threshold in the cleaning logic with a percentile-based check.

### Views Verified
- Existing views were retained and aligned with the validated schema.
- Added dashboard KPI and subscription summary views.

### Procedures Verified
- Existing procedures were retained and aligned with the validated schema.
- Added dashboard KPI and yearly IPO analysis procedures.

### Indexes Verified
- Kept only the indexes most relevant to the actual business queries.

## Assumptions Removed
- Removed reliance on arbitrary thresholds such as fixed subscription or gain cutoffs where the dataset distribution is more appropriate for relative comparisons.
- Kept the SQL aligned to the actual workbook columns rather than assumed or Excel-style names.
