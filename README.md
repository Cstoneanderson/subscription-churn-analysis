# Subscription Churn Analysis by Segment

**Author:** Chelsea Stone  
**Project Type:** SQL Query / Data Analysis  
**Tools Used:** SQLite, Visual Studio Code

## 🧠 Project Overview

This project analyzes subscription churn rates across two customer segments (87 and 30) over a 3-month period (January–March 2017). It was built as part of a SQL learning program and demonstrates how to calculate and compare churn using raw subscription data.

## 🔍 Objective

To calculate monthly churn rates for customer segments 87 and 30, identifying which group has higher volatility and when churn tends to occur.

## 📊 Dataset Description

The dataset includes the following columns:

- `id`: Unique user ID  
- `subscription_start`: Date when the subscription began  
- `subscription_end`: Date when the subscription was canceled or NULL if still active  
- `segment`: Customer segment (87 or 30)

## 🔧 Key Techniques Used

- **CTEs (Common Table Expressions)** to break the analysis into modular steps
- **CROSS JOIN** to evaluate user activity across defined time windows
- **CASE statements** to determine user status (active vs. canceled)
- **Aggregate functions** (`SUM`) to tally activity
- **Calculated columns** to derive churn rates

## 🗓️ Churn Rate Formula

```sql
Churn Rate = Number of Cancellations / Number of Active Users
