# IPO Analysis Dashboard

## Project Overview

This project combines an existing Power BI dashboard with a MySQL 8 SQL layer to create a recruiter-ready IPO analysis portfolio. The dashboard remains unchanged, while the SQL assets demonstrate data cleaning, data modeling, business analysis, reusable views, stored procedures, and performance optimization.

## Dataset

The source data comes from [Initial Public Offering (Updated).xlsx](Initial%20Public%20Offering%20(Updated).xlsx). The SQL layer is designed around the business fields in that workbook and does not alter the dataset.

## Technology Stack

- MySQL 8
- SQL for schema design, querying, views, procedures, indexing, and validation
- Power BI for dashboard visualization

## SQL Features

- Relational schema for IPO performance and subscription data
- Business-focused analysis queries for portfolio storytelling
- Reusable views for KPI reporting and analysis
- Stored procedures for common analytical workflows
- Indexes for faster reporting on high-use filters and metrics
- Data quality checks for missing values, duplicates, and invalid ranges

## Power BI Dashboard

The existing Power BI dashboard in [IndianIpoAnalysis.pbix](IndianIpoAnalysis.pbix) remains the presentation layer. The SQL component complements it by providing a structured data layer and analytical depth that supports reporting and recruiter discussion.

## Business Insights

The SQL queries focus on realistic analyst use cases such as:

- Top-performing IPOs
- Premium and discount listings
- High and low subscription patterns
- Investor participation by segment
- Current winners and losers
- Performance ranking and comparative analysis

A validation report based on the actual Excel workbook is available in [validation_report.md](validation_report.md).

## Project Workflow

```text
Excel Dataset
      ↓
Data Cleaning (SQL)
      ↓
MySQL Database
      ↓
SQL Analysis
      ↓
Power BI Dashboard
      ↓
Business Insights
```

## Repository Structure

- [sql/01_schema.sql](sql/01_schema.sql) - Database and table schema
- [sql/02_business_queries.sql](sql/02_business_queries.sql) - Business and portfolio-focused SQL analysis
- [sql/03_views.sql](sql/03_views.sql) - Reusable analytical views
- [sql/04_procedures.sql](sql/04_procedures.sql) - Stored procedures for recurring analysis
- [sql/05_indexes.sql](sql/05_indexes.sql) - Performance indexes for common filters and metrics
- [sql/06_data_cleaning.sql](sql/06_data_cleaning.sql) - Data validation and quality checks
