# Credit Risk Analysis & Default Prediction

## 1. Project Summary  
This project analyzes **2.26M+ historical loan records** to understand **why borrowers default, which segments are riskiest,** and **where financial losses are concentrated.**

Using **SQL, Power BI, and Python,** I built a complete credit risk analysis workflow that includes business-focused insights, an interactive dashboard, and an explainable **default prediction model.**

### Key Results
- Analyzed **2.26M+ loans** using **SQL** and **Python**
- Identified key drivers of loan default and financial risk
- Showed why **default exposure matters more than default rate**
- Built an interpretable model with **~67% recall for defaulters**
- Created a **Power BI dashboard** for portfolio-level risk analysis

## 2. Business Problem
**Lenders need to answer questions like:**
- Which borrowers are most likely to default?
- Which segments cause the biggest financial losses?
- How can risk be identified early and explained clearly?

This project addresses these questions using real loan data and business-friendly analysis.

## 3. Dataset Overview
- **Source:** Lending Club Loan Data [(Kaggle)](https://www.kaggle.com/datasets/adarshsng/lending-club-loan-data-csv)
- **Size:** 2,260,668 loan records
- **Target:** `loan_default` (derived from loan status)
- **Integrity:** Used only **approval-time features** (demographics, credit history, loan terms) to prevent data leakage from post-loan information and ensure real-world applicability.

## 4. Methodology
### Data Prepapration
- Cleaned and standardized raw data
- Converted text fields (term, interest rate) into numeric values
- Handled missing values while preserving business meaning
- Created derived features such as credit history length

**Separate datasets were maintained for different purposes:**
- `loan_df_raw` → Original dataset
- `loan_df_clean` → Standardized base dataset
- `loan_df_analytics` → SQL and Power BI analysis
- `loan_df_model` → Predictive modeling

### SQL Analysis
Loaded the analytics dataset into **MySQL**
Used SQL to analyze default patterns by:
- Interest rate
- Income and employment length
- Credit history and utilization  

Compared **default rate vs default exposure** to identify financial risk

### Visualization
Built a one-page **Power BI dashboard** showing:
- Portfolio-level KPIs (default rate, exposure, loan volume)
- Key default drivers (grade, income, employment, credit history, interest rate)
- High-risk borrower segments

### Modeling
- Built an explainable **logistic regression model**
- Used approval-time data only
- Focused on identifying defaulters (recall > accuracy)
- Interpreted coefficients to explain risk drivers

Prioritized **recall** to ensure the majority of defaulters are caught during the application stage.

## 5. Business Insights and Impact
- Borrowers with **high debt and high credit utilization** default more often
- **Short or unstable credit history** increases risk
- **High default rate ≠ highest financial risk**
- **Medium-risk** borrowers often cause the **largest losses** due to higher loan volumes
- Exposure-based analysis helps prioritize risk management decisions

**Key takeaway:** **Default exposure** provides a more accurate view of portfolio risk than **default rate** alone and helps prioritize risk management decisions.

## 6. Model Interpretation & Performance
An explainable **logistic regression model** was built using **approval-time features** only.  
The model achieved a **ROC-AUC of ~0.72** and identified approximately **67% of defaulters,** prioritizing recall over raw accuracy to align with credit risk objectives.

### Key Interpretations
- **Credit grade** and **sub-grade** emerged as the strongest predictors of default, confirming the expected credit risk hierarchy.
- Higher **debt-to-income ratios** and elevated **credit utilization** significantly increased default likelihood, acting as clear financial stress indicators.
- Borrowers with **lower income** and **shorter credit histories** showed higher default propensity.
- Model coefficients followed intuitive credit logic, reinforcing trust and explainability.

Overall, the model behavior aligns well with **real-world lending practices** and provides transparent insights suitable for risk-based decision-making.

## 7. Skills Demonstrated
- **Data Analysis & Cleaning:** Python (pandas, NumPy)
- **SQL Analytics:** MySQL, conditional aggregation, risk segmentation
- **Data Visualization:** Power BI, KPI design, business storytelling
- **Predictive Modeling:** Logistic Regression, scikit-learn
- **Business Analytics:** Credit risk analysis, exposure modeling, decision support

## 8. Next Steps
- Optimize probability thresholds to balance recall and precision for credit decisioning
- Compare results with tree-based models for rule extraction
- Perform time-based model validation
- Extend insights to support risk-based pricing and monitoring alerts

## Repository Guide
- [data_cleaning](/data_cleaning.ipynb) → Cleaned datasets used for analysis and modeling
- [sql_analysis](sql_analysis.sql) → SQL queries used for credit risk analysis and segmentation
- [dashboard](dashboard.pbix) → Power BI dashboard file
- [modeling](modeling.ipynb) → Jupyter notebook for credit risk modeling

## Final Note
This project demonstrates my ability to analyze large datasets, extract business-relevant insights, and build explainable models suitable for real-world credit risk decisions.
