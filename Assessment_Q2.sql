-- CTE to calculate the number of successful transactions per customer per month
WITH monthly_transactions AS (
    SELECT 
        s.owner_id,                                 -- Customer ID
        DATE_FORMAT(s.transaction_date, '%Y-%m') AS month_year,  -- Year and month of transaction
        COUNT(*) AS transaction_count               -- Count of successful transactions in the month
    FROM 
        savings_savingsaccount s
    WHERE 
        s.transaction_status = 'successful'         -- Only successful transactions
        AND s.transaction_date IS NOT NULL           -- Ensure transaction date exists
    GROUP BY 
        s.owner_id, month_year
),

-- CTE to calculate the average monthly transactions per customer
customer_avg_transactions AS (
    SELECT 
        owner_id,                                   -- Customer ID
        AVG(transaction_count) AS avg_transactions_per_month  -- Average transactions per month
    FROM 
        monthly_transactions
    GROUP BY 
        owner_id
)

-- Final query to categorize customers based on their average monthly transaction frequency
SELECT 
    CASE 
        WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
        WHEN avg_transactions_per_month >= 3 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,                      -- Frequency category label
    COUNT(*) AS customer_count,                      -- Number of customers in each category
    ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month  -- Average transactions for the category
FROM 
    customer_avg_transactions
GROUP BY 
    frequency_category
ORDER BY 
    CASE frequency_category                          -- Custom ordering of categories
        WHEN 'High Frequency' THEN 1
        WHEN 'Medium Frequency' THEN 2
        WHEN 'Low Frequency' THEN 3
    END;
