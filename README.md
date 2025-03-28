# Business Operations Analytics Platform

A data analytics platform built with dbt and Snowflake that transforms business operations data into insights.

## Project Overview

This project creates analytics models for business operations data, including:
- Procurement and purchasing
- Vendor performance tracking
- Project management
- Resource allocation

The platform transforms raw operational data into analytics-ready models for better business decision-making.

## Data Model

The project follows the Kimball dimensional modeling approach with:

**Dimension Tables**
- Vendors
- Departments
- Projects
- Materials
- Locations
- Date

**Fact Tables**
- Purchases
- Vendor Performance
- Project Milestones
- Resource Allocation

## WAP Pattern Implementation

This project follows the Write, Audit, Publish (WAP) pattern:

- **Write**: Transform raw data into structured, consistent formats
- **Audit**: Test data quality and validate business rules
- **Publish**: Create optimized models for business users

## Key Features

- Dimensional modeling for business analysis
- Incremental data processing for efficiency
- Historical tracking with snapshots
- Data quality testing
- Reusable SQL components

## Setup Guide

### Prerequisites
- Snowflake account
- dbt installed
- Git

### Quick Start

1. Clone the repository
```bash
git clone https://github.com/yourusername/business_ops_analytics.git
cd business_ops_analytics
```

2. Update your dbt profile
```yaml
# ~/.dbt/profiles.yml
business_ops:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: your_account
      user: your_username
      password: your_password
      role: your_role
      database: your_database
      warehouse: your_warehouse
      schema: analytics
      threads: 4
```

3. Run the models
```bash
dbt build
```

## Technologies Used

- dbt
- Snowflake
- SQL
- Git

## Business Insights

- Procurement spend analysis
- Vendor performance metrics
- Project budget tracking
- Resource utilization
