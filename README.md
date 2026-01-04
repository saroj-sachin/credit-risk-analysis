# Credit Risk Analysis & Default Prediction

## 1. Project Summary  
This project presents an end-to-end **credit risk analytics and default prediction solution** built on a large-scale historical loan dataset containing **2,260,668 records.**  

The goal was to identify the key drivers of loan defaults, quantify portfolio risk using **default exposure** (not just default rates), and build an **explainable predictive model** using only approval-time information.  

The project mirrors real-world credit risk workflows by combining **SQL-based analysis**, an **interactive Power BI dashboard**, and an **interpretable logistic regression model.**

### Key Outcomes
- Analyzed **2.25M+ loan records** using SQL, Python, and Power BI
- Identified borrower characteristics most strongly associated with **default risk**
- Demonstrated why **default exposure** is more informative than default rate alone
- Built an explainable credit risk model with **~67% recall for defaulters**
- Delivered a **business-ready dashboard** highlighting risk concentration and exposure

## 2. Problem Statement
Loan default analysis often focuses on overall default rates without answering critical business questions such as:
- Which borrower characteristics truly drive default risk?
- Where is the **financial impact** of defaults concentrated?
- How can risk be identified early using interpretable signals?

This project aims to address these gaps by answering:
- *Who is likely to default and why?*
- *Which borrower segments pose the greatest financial risk?*
- *Can risk be quantified and explained in a way suitable for real lending decisions?*

## 3. Dataset Overview
The dataset consists of **2,260,668 historical loan records,** including borrower demographics, loan attributes, and credit behavior indicators.
- Source: **Lending Club Loan Data** [(Kaggle)](https://www.kaggle.com/datasets/adarshsng/lending-club-loan-data-csv)

Key characteristics:
- Binary target variable: `loan_default` (derived from loan status)
- Highly imbalanced outcome (~13% defaults)
- Mix of numeric and categorical variables
- Presence of meaningful missing and “unknown” values

Only approval-time features were used to ensure data integrity and avoid leakage from post-loan information.

## 4. Methodology
### Data Prepapration
Raw data was standardized into a clean base dataset (`loan_df_clean`) by:
- Converting text-based numeric fields (e.g., loan term, interest rate)
- Preserving business meaning in missing values (e.g., unknown employment length)
- Creating derived features such as credit history length

Separate datasets were maintained for different purposes:
- `loan_df_raw` → Original dataset
- `loan_df_clean` → Standardized base dataset
- `loan_df_analytics` → SQL and Power BI analysis
- `loan_df_model` → Predictive modeling

### SQL Analysis
The analytics dataset was loaded into **MySQL** to perform business-driven analysis using:
- `CASE WHEN` bucketing of continuous variables
- Conditional aggregation
- Default rate vs default exposure comparisons

SQL analysis was used to identify default drivers and quantify financial risk across borrower segments.

### Visualization
A single-page **Credit Risk Dashboard** was built in **Power BI** to provide:
- Portfolio-level KPIs (default rate, exposure, loan volume)
- Clear visualization of default drivers (grade, income, employment, credit history, interest rate)
- Rule-based borrower risk segmentation (Low / Medium / High Risk)

Insight-driven titles and minimal clutter were used to emphasize decision-making.

### Modeling
An explainable **Logistic Regression** model was developed using:
- Approval-time features only
- Stratified train-test split to handle class imbalance
- Balanced class weights
- End-to-end preprocessing pipelines (imputation, scaling, encoding)

The modeling approach prioritized **interpretability and recall for defaulters** over raw accuracy.

## 5. Model Summary
Model: Logistic Regression (binary classification)

Performance:
- **ROC-AUC ≈ 0.72** (realistic and credible for credit risk)
- **Recall for defaulters ≈ 67%**

Strongest predictors identified:
- Credit grade and sub-grade
- High debt-to-income (DTI) ratios
- High revolving and bankcard utilization
- Lower income levels
- Shorter credit histories

The model’s behavior aligns closely with domain expectations, reinforcing trust and explainability.

## 6. Business Insights and Impact
### Executive Summary
- Credit risk is strongly driven by borrower stability and financial stress indicators such as income, DTI, credit history, and utilization.
- High credit utilization and debt burden act as early warning signals for repayment stress.
- **High default rate does not always imply highest financial risk**—medium-risk borrowers often contribute the largest share of default exposure due to higher loan volumes.
- Exposure-based analysis provides a more accurate framework for prioritizing risk management efforts.
- Rule-based, explainable borrower segmentation supports transparent underwriting and portfolio decisions.
- The SQL- and BI-driven framework is scalable for large credit portfolios.

## 7. Skills Demonstrated
- **Data Analysis & Cleaning:** pandas, NumPy
- **SQL Analytics:** MySQL, conditional aggregation, risk segmentation
- **Data Visualization:** Power BI, KPI design, business storytelling
- **Predictive Modeling:** Logistic Regression, scikit-learn
- **Business Analytics:** Credit risk analysis, exposure modeling, decision support

## 8. Next Steps
- Optimize probability thresholds to balance recall and precision for credit decisioning
- Compare results with tree-based models for rule extraction
- Perform time-based model validation
- Extend insights to support risk-based pricing and monitoring alerts
