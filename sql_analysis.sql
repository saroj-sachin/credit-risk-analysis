-- SECTION 1: Portfolio Overview

-- 1. What is the overall default rate of the loan portfolio?
SELECT 
	ROUND(SUM(loan_default) / COUNT(*) * 100, 2) AS default_rate_pct
FROM loan_df_analytics;

-- 2. How many total loans and total loan amount are in the portfolio?
SELECT
	COUNT(*) AS total_loans,
    SUM(loan_amnt) AS total_loan_amnt
FROM loan_df_analytics;

-- 3. What percentage of loans are 36-month vs 60-month loans?
SELECT 
	term, 
    ROUND((COUNT(term) * 100) / (SELECT COUNT(*) FROM loan_df_analytics), 2) AS percentage
FROM loan_df_analytics
GROUP BY term;

-- 4. What is the average interest rate for defaulted vs non-defaulted loans?
SELECT
	loan_default,
    ROUND(AVG(int_rate), 2) AS avg_int_rate
FROM loan_df_analytics
GROUP BY loan_default;

-- 5. What is the average loan amount for defaulters?
SELECT
	loan_default,
	AVG(loan_amnt)
FROM loan_df_analytics
GROUP BY loan_default;


-- SECTION 2: Risk by Loan Characteristics

-- 6. Which loan term has a higher default rate?
SELECT
	term,
    COUNT(*) AS total_loans,
    SUM(loan_default) AS defaulted_loans,
    ROUND(SUM(loan_default) / COUNT(*) * 100, 2) AS default_rate_pct
FROM loan_df_analytics
GROUP BY term;

-- 7. How does default rate vary by loan grade?
SELECT
	grade,
    COUNT(*) AS total_loans,
    SUM(loan_default) AS defaulted_loans,
    ROUND(SUM(loan_default) / COUNT(*) * 100, 2) AS default_rate_pct
FROM loan_df_analytics
GROUP BY grade
ORDER BY default_rate_pct DESC;

-- 8. Which sub-grades show the highest risk?
SELECT
	sub_grade,
    COUNT(*) AS total_loans,
    SUM(loan_default) AS defaulted_loans,
    ROUND(SUM(loan_default) / COUNT(*) * 100, 2) AS default_rate_pct
FROM loan_df_analytics
GROUP BY sub_grade
ORDER BY default_rate_pct DESC
LIMIT 5;

-- 9. Which loan purposes have the highest default rate?
SELECT
	purpose,
    COUNT(*) AS total_loans,
    SUM(loan_default) AS defaulted_loans,
    ROUND(SUM(loan_default) / COUNT(*) * 100, 2) AS default_rate_pct
FROM loan_df_analytics
GROUP BY purpose
ORDER BY default_rate_pct DESC;

-- 10. Are higher interest rate loans more likely to default?
SELECT
	CASE
        WHEN int_rate < 10 THEN "Low (<10%)"
        WHEN int_rate BETWEEN 10 AND 15 THEN "Medium (10-15%)"
        WHEN int_rate BETWEEN 15 AND 20 THEN "High (15-20%)"
        ELSE "Very Hight (>20%)"
	END AS int_rate_bucket,
    COUNT(*) AS total_loans,
    SUM(loan_default) AS defaulted_loans,
    ROUND(SUM(loan_default) / COUNT(*) * 100, 2) AS default_rate_pct
FROM loan_df_analytics
GROUP BY int_rate_bucket
ORDER BY default_rate_pct;


-- SECTION 3: Borrower Profile Risk

-- 11. How does default rate vary by employment length?
SELECT
	CASE
		WHEN emp_length = -1 THEN "Unknown"
		WHEN emp_length < 2 THEN "< 2 years"
        WHEN emp_length BETWEEN 2 AND 5 THEN "2-5 years"
        WHEN emp_length BETWEEN 6 AND 9 THEN "6-9 years"
        ELSE "10+ years"
	END AS emp_length_bucket,
    COUNT(*) AS total_loans,
    SUM(loan_default) AS defaulted_loans,
    ROUND(SUM(loan_default) / COUNT(*) * 100, 2) AS default_rate_pct
FROM loan_df_analytics
GROUP BY emp_length_bucket
ORDER BY default_rate_pct DESC;

-- 12. Are borrowers with unverified income riskier?
SELECT 
	verification_status,
    COUNT(*) AS total_loans,
    SUM(loan_default) AS defaulted_loans,
    ROUND(SUM(loan_default) / COUNT(*) * 100, 2) AS default_rate_pct
FROM loan_df_analytics
GROUP BY verification_status;

-- 13. How does home ownership affect default probability?
SELECT
	home_ownership,
    COUNT(*) AS total_loans,
    SUM(loan_default) AS defaulted_loans,
    ROUND(SUM(loan_default) / COUNT(*) * 100, 2) AS default_rate_pct
FROM loan_df_analytics
GROUP BY home_ownership
ORDER BY default_rate_pct DESC;

-- 14. Which income ranges have the highest default rates?
SELECT
	CASE
		WHEN annual_inc < 30000 THEN "< 30K"
        WHEN annual_inc BETWEEN 30000 AND 60000 THEN '30K–60K'
        WHEN annual_inc BETWEEN 60000 AND 100000 THEN '60K–100K'
        WHEN annual_inc BETWEEN 100000 AND 150000 THEN '100K–150K'
        ELSE '> 150K'
	END AS income_bucket,
    COUNT(*) AS total_loans,
    SUM(loan_default) AS defaulted_loans,
    ROUND(SUM(loan_default) / COUNT(*) * 100, 2) AS default_rate_pct
FROM loan_df_analytics
GROUP BY income_bucket
ORDER BY default_rate_pct DESC;

-- 15. Does a high DTI ratio correlate with defaults?
SELECT
	CASE
		WHEN dti < 10 THEN "Very Low (< 10)"
        WHEN dti BETWEEN 11 AND 20 THEN "Low (11-20)"
        WHEN dti BETWEEN 21 AND 30 THEN "Medium (21-30)"
        WHEN dti BETWEEN 31 AND 40 THEN "High (31-40)"
        ELSE "Very High (> 40)"
	END AS dti_bucket,
    COUNT(*) AS total_loans,
    SUM(loan_default) AS defaulted_loans,
    ROUND(SUM(loan_default) / COUNT(*) * 100, 2) AS default_rate_pct
FROM loan_df_analytics
GROUP BY dti_bucket
ORDER BY default_rate_pct DESC;


-- SECTION 4: Credit History & Behavior

-- 16. Do borrowers with shorter credit history default more?
SELECT
    CASE
		WHEN credit_history_years < 3 THEN "< 3 years"
        WHEN credit_history_years BETWEEN 3 AND 7 THEN '3–7 years'
        WHEN credit_history_years BETWEEN 8 AND 15 THEN '8–15 years'
        ELSE '> 15 years'
    END AS credit_history_bucket,
    COUNT(*) AS total_loans,
    SUM(loan_default) AS defaulted_loans,
    ROUND(SUM(loan_default) / COUNT(*) * 100, 2) AS default_rate_pct
FROM loan_df_analytics
GROUP BY credit_history_bucket
ORDER BY default_rate_pct DESC;

-- 17. How does default rate change with number of open accounts?
SELECT
    CASE
		WHEN open_acc <= 2 THEN '0–2 accounts'
        WHEN open_acc BETWEEN 3 AND 5 THEN '3–5 accounts'
        WHEN open_acc BETWEEN 6 AND 10 THEN '6–10 accounts'
        ELSE '> 10 accounts'
    END AS open_accounts_bucket,
    COUNT(*) AS total_loans,
    SUM(loan_default) AS defaulted_loans,
    ROUND(SUM(loan_default) / COUNT(*) * 100, 2) AS default_rate_pct
FROM loan_df_analytics
GROUP BY open_accounts_bucket
ORDER BY default_rate_pct DESC;

-- 18. Are borrowers with recent inquiries riskier?
SELECT
    CASE
		WHEN inq_last_6mths = 0 THEN '0 inquiries'
        WHEN inq_last_6mths BETWEEN 1 AND 2 THEN '1–2 inquiries'
        WHEN inq_last_6mths BETWEEN 3 AND 5 THEN '3–5 inquiries'
        ELSE '6+ inquiries'
    END AS inquiry_bucket,
    COUNT(*) AS total_loans,
    SUM(loan_default) AS defaulted_loans,
    ROUND(SUM(loan_default) / COUNT(*) * 100, 2) AS default_rate_pct
FROM loan_df_analytics
GROUP BY inquiry_bucket
ORDER BY default_rate_pct DESC;

-- 19. How do past delinquencies affect default probability?
SELECT
    CASE
		WHEN delinq_2yrs = 0 THEN 'No delinquencies'
        WHEN delinq_2yrs = 1 THEN '1 delinquency'
        ELSE '2+ delinquencies'
    END AS delinquency_bucket,
    COUNT(*) AS total_loans,
    SUM(loan_default) AS defaulted_loans,
    ROUND(SUM(loan_default) / COUNT(*) * 100, 2) AS default_rate_pct
FROM loan_df_analytics
GROUP BY delinquency_bucket
ORDER BY default_rate_pct DESC;

-- 20. Do borrowers with public records default more often?
SELECT
    CASE
		WHEN pub_rec = 0 THEN "No Public Records"
        ELSE "Has Public Records"
	END AS public_record_status,
    COUNT(*) AS total_loans,
    SUM(loan_default) AS defaulted_loans,
    ROUND(SUM(loan_default) / COUNT(*) * 100, 2) AS default_rate_pct
FROM loan_df_analytics
GROUP BY public_record_status
ORDER BY default_rate_pct DESC;


-- SECTION 5: Utilization & Exposure Risk

-- 21. Is higher revolving utilization associated with higher defaults?
SELECT
	CASE
        WHEN revol_util <= 25 THEN "Low (0 - 25)"
        WHEN revol_util BETWEEN 26 AND 50 THEN "Moderate (26 - 50)"
        WHEN revol_util BETWEEN 51 AND 75 THEN "High (51 - 75)"
        ELSE "Very High (76 - 100)"
	END AS utilization_bucket,
    COUNT(*) AS total_loans,
    SUM(loan_default) AS defaulted_loans,
    ROUND(SUM(loan_default) / COUNT(*) * 100, 2) AS default_rate_pct
FROM loan_df_analytics
GROUP BY utilization_bucket
ORDER BY default_rate_pct DESC;

-- 22. Do borrowers with >75% credit card utilization default more?
SELECT
	CASE
        WHEN percent_bc_gt_75 = 0 THEN "No cards >75% utilization"
        ELSE "Has cards >75% utilization"
	END AS high_utilization_flag,
    COUNT(*) AS total_loans,
    SUM(loan_default) AS defaulted_loans,
    ROUND(SUM(loan_default) / COUNT(*) * 100, 2) AS default_rate_pct
FROM loan_df_analytics
GROUP BY high_utilization_flag
ORDER BY default_rate_pct DESC;

-- 23. How does default rate vary by bc_util buckets?
SELECT
	CASE
        WHEN bc_util <= 25 THEN "Low (0 - 25)"
        WHEN bc_util BETWEEN 26 AND 50 THEN "Medium (26 - 50)"
        WHEN bc_util BETWEEN 51 AND 75 THEN "High (51 - 75)"
        ELSE "Very High (76 - 100)"
	END AS bc_util_bucket,
    COUNT(*) AS total_loans,
    SUM(loan_default) AS defaulted_loans,
    ROUND(SUM(loan_default) / COUNT(*) * 100, 2) AS default_rate_pct
FROM loan_df_analytics
GROUP BY bc_util_bucket
ORDER BY default_rate_pct DESC;

-- 24. Are borrowers with multiple past 120-day delinquencies riskier?
SELECT
	CASE
        WHEN num_accts_ever_120_pd = 0 THEN "No past delinquencies"
        ELSE "With past delinquencies"
	END AS 120d_dilinquencies,
    COUNT(*) AS total_loans,
    SUM(loan_default) AS defaulted_loans,
    ROUND(SUM(loan_default) / COUNT(*) * 100, 2) AS default_rate_pct
FROM loan_df_analytics
GROUP BY 120d_dilinquencies
ORDER BY default_rate_pct DESC;

-- 25. Which utilization segment contributes the most default exposure?
SELECT
	CASE
        WHEN revol_util <= 25 THEN "Low (0 - 25)"
        WHEN revol_util BETWEEN 26 AND 50 THEN "Moderate (26 - 50)"
        WHEN revol_util BETWEEN 51 AND 75 THEN "High (51 - 75)"
        ELSE "Very High (76 - 100)"
	END AS utilization_bucket,
    COUNT(*) AS total_loans,
    SUM(loan_default) AS defaulted_loans,
    SUM(CASE WHEN loan_default = 1 THEN loan_amnt ELSE 0 END) AS default_exposure,
    ROUND(SUM(CASE WHEN loan_default = 1 THEN loan_amnt ELSE 0 END) / SUM(loan_amnt) * 100, 2) AS exposure_ratio_pct
FROM loan_df_analytics
GROUP BY utilization_bucket
ORDER BY default_exposure DESC;


-- SECTION 6: High-Risk Segmentation

-- 26. Identify high-risk borrower segments (combine income, DTI, and utilization).
SELECT
	CASE
		WHEN annual_inc < 60000
			AND dti > 35
            AND revol_util > 60
		THEN "High Risk"
        
        WHEN annual_inc < 60000
			OR dti > 35
            OR revol_util > 60
		THEN "Medium Risk"
        
        ELSE "Low Risk"
	END AS risk_segment,
    COUNT(*) AS total_loans,
    SUM(loan_default) AS defaulted_loans,
    ROUND(SUM(loan_default) / COUNT(*) * 100, 2) AS default_rate_pct,
    SUM(loan_amnt) AS total_exposure,
    SUM(CASE WHEN loan_default = 1 THEN loan_amnt ELSE 0 END) AS default_exposure
FROM loan_df_analytics
WHERE annual_inc IS NOT NULL
	AND dti IS NOT NULL
    AND revol_util IS NOT NULL
GROUP BY risk_segment
ORDER BY default_rate_pct DESC;