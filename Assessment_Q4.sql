-- Query to calculate estimated Customer Lifetime Value (CLV) for active customers
SELECT 
    u.id AS customer_id,  -- Unique customer identifier
    u.name,               -- Customer name
    TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE()) AS tenure_months,  -- Number of months since customer joined
    COUNT(s.id) AS total_transactions,  -- Total successful transactions by the customer
    ROUND(
        (COUNT(s.id) / TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE())) * 12 *  -- Normalize transaction frequency to annual
        (SUM(s.amount) * 0.001), 2) AS estimated_clv  -- Estimated CLV scaled and rounded to 2 decimal places
FROM 
    users_customuser u
LEFT JOIN 
    savings_savingsaccount s ON u.id = s.owner_id  -- Join customer transactions
WHERE 
    s.transaction_status = 'successful'  -- Consider only successful transactions
    AND u.date_joined IS NOT NULL        -- Exclude customers without a join date
    AND u.is_active = 1                  -- Include only active customers
GROUP BY 
    u.id, u.name, u.date_joined
HAVING 
    tenure_months > 0  -- Avoid division by zero by excluding customers with zero tenure
ORDER BY 
    estimated_clv DESC;  -- Sort customers by estimated CLV in descending order
