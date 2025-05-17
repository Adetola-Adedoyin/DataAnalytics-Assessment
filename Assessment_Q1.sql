-- Query to find customers who have at least one active savings plan 
-- and one active investment plan, along with their total deposits.
-- Results are ordered by total deposits in descending order.

SELECT 
    u.id AS owner_id,                          -- Customer ID
    u.name,                                   -- Customer Name
    COUNT(CASE WHEN p.plan_type_id = 1 THEN 1 END) AS savings_count,      -- Number of active savings plans
    COUNT(CASE WHEN p.plan_type_id = 2 THEN 1 END) AS investment_count,  -- Number of active investment plans
    COALESCE(SUM(s.amount), 0) AS total_deposits                       -- Total deposit amount (0 if none)
FROM 
    users_customuser u
LEFT JOIN 
    plans_plan p 
    ON u.id = p.owner_id 
    AND p.status_id = 1                      -- Only consider active plans
LEFT JOIN 
    savings_savingsaccount s 
    ON p.id = s.plan_id
GROUP BY 
    u.id, u.name
HAVING 
    savings_count >= 1                      -- At least one savings plan
    AND investment_count >= 1               -- At least one investment plan
ORDER BY 
    total_deposits DESC;                    -- Sort by total deposits, highest first
