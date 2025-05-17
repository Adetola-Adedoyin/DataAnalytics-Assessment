# Data Analytics Assessment

## Question 1
##High-Value Customers with Multiple Products
Scenario: The business wants to identify customers who have both a savings and an investment plan (cross-selling opportunity).
Task: Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits

**Approach:**  
To identify high-value customers with cross-selling potential, I focused on finding those who have at least one active savings plan and one active investment plan. By joining the customer, plan, and savings account data, I calculated the total deposits for each customer. Finally, I filtered to include only customers meeting both plan criteria and sorted the results by their total deposits to highlight the most valuable customers.

## Question 2
##Transaction Frequency Analysis
Scenario: The finance team wants to analyze how often customers transact to segment them (e.g., frequent vs. occasional users).
Task: Calculate the average number of transactions per customer per month and categorize them:
● "High Frequency" (≥10 transactions/month)
● "Medium Frequency" (3-9 transactions/month)
● "Low Frequency" (≤2 transactions/month)

**Approach:**  
To understand customer transaction behavior, I calculated the average number of successful transactions each customer makes per month. Using this average, I grouped customers into three segments—High, Medium, and Low Frequency—to help the finance team easily identify how often customers engage with their accounts. This segmentation supports targeted marketing and service strategies.

## Question 3
##Account Inactivity Alert
Scenario: The ops team wants to flag accounts with no inflow transactions for over one year.
Task: Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days).

**Approach:**  
To support the operations team in spotting inactive accounts, I identified all active (non-archived, non-deleted) savings or investment plans that haven’t had any inflow transactions in over a year—or have never had one. This helps flag dormant accounts for follow-up or re-engagement efforts.

## Question 4
##Customer Lifetime Value (CLV) Estimation
Scenario: Marketing wants to estimate CLV based on account tenure and transaction volume (simplified model).
Task: For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate:
● Account tenure (months since signup)
● Total transactions
● Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)
● Order by estimated CLV from highest to lowest

**Approach:**  
To help marketing estimate customer value, I calculated each customer's tenure in months, total successful transactions, and used a simplified CLV formula based on average monthly activity and a 0.1% profit rate per transaction. This allows the business to prioritize high-value customers based on their estimated lifetime contribution.
---

## Challenges
- At the start of the assessment, I assumed SQL Server would work just fine for running the queries. But after trying to execute some scripts, I realized the syntax was actually meant for MySQL. That set me back a bit, but I quickly adapted—I downloaded and installed MySQL, set it up on my system, and re-ran everything in the right environment. Once I made that switch, everything worked smoothly.
