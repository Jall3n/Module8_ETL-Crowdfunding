-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT c.cf_id,
c.backer_counts
INTO backer_cf_id
FROM campaign as c
WHERE (c.outcome = 'live')
ORDER BY c.backer_counts DESC;

SELECT * FROM backer_cf_id;

-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT COUNT (bk.cf_id), bk.cf_id
FROM backers as bk
GROUP BY bk.cf_id
ORDER BY COUNT(bk.cf_id) DESC;



-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
SELECT co.first_name,
    co.last_name,
    co.email,
    (ca.goal - ca.pledged) as "Goal Amount Remaining"
INTO email_goal_amount
FROM campaign as cam
LEFT JOIN contacts as co
    ON (co.contact_id = ca.contact_id)
    WHERE (ca.outcome = 'live')
ORDER BY "Goal Amount Remaining" DESC;

-- Check the table
SELECT*FROM email_goal_amount;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 
SELECT b.email,
    b.first_name,
    b.last_name,
    ca.cf_id,
    ca.company_name,
    ca.description,
    ca.end_date,
    (ca.goal - ca.pledged) as "Left of Goal"
INTO email_backers_remaining_goal_amount
FROM backers as b
LEFT JOIN campaign as ca
    ON (ca.cf_id = b.cf_id)
    WHERE (ca.outcome = 'live')
ORDER BY b.last_name, b.email ASC;


-- Check the table
SELECT * FROM email_backers_remaining_goal_amount;

