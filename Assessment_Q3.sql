-- Query to identify inactive plans based on last transaction date
SELECT 
    p.id AS plan_id,                          -- Unique plan identifier
    p.owner_id,                               -- Owner (customer) ID
    CASE 
        WHEN p.plan_type_id = 1 THEN 'Savings'      -- Plan type label
        WHEN p.plan_type_id = 2 THEN 'Investment'
        ELSE 'Other'
    END AS type,
    MAX(s.transaction_date) AS last_transaction_date,   -- Most recent transaction date for the plan
    DATEDIFF(CURRENT_DATE(), MAX(s.transaction_date)) AS inactivity_days  -- Days since last transaction
FROM 
    plans_plan p
LEFT JOIN 
    savings_savingsaccount s ON p.id = s.plan_id       -- Join transactions related to each plan
WHERE 
    p.status_id = 1                   -- Only active plans
    AND p.is_deleted = 0             -- Exclude deleted plans
    AND p.is_archived = 0            -- Exclude archived plans
GROUP BY 
    p.id, p.owner_id, p.plan_type_id
HAVING 
    -- Include plans with no transactions or last transaction older than 365 days
    MAX(s.transaction_date) IS NULL 
    OR MAX(s.transaction_date) < DATE_SUB(CURRENT_DATE(), INTERVAL 365 DAY)
ORDER BY 
    inactivity_days DESC;             -- Order by longest inactivity first
