-- 1. Get the id values of the first 5 clients from district_id with a value equals to 1.
select client_id from client where district_id = 1 limit 5;

-- 2. In the client table, get an id value of the last client where the district_id equals to 72.
select client_id from client where district_id = 72 order by client_id desc limit 1;

-- 3. Get the 3 lowest amounts in the loan table.
select amount from loan order by amount asc limit 3;

-- 4. What are the possible values for status, ordered alphabetically in ascending order in the loan table?
select distinct(status) from loan order by status asc;

-- 5. What is the loan_id of the highest payment received in the loan table?
select loan_id from loan order by payments desc limit 1; -- The exercise solution in GitHub is wrong because 6312 is the loan_id of the lowest payment and 6415 is the id of the highest.

-- 6. What is the loan amount of the lowest 5 account_ids in the loan table? Show the account_id and the corresponding amount
select account_id, amount from loan order by account_id asc limit 5;

-- 7. What are the account_ids with the lowest loan amount that have a loan duration of 60 in the loan table?
select account_id from loan where duration = 60 order by amount asc limit 5;

-- 8. What are the unique values of k_symbol in the order table?
select distinct(k_symbol) from `order`;

-- 9. In the order table, what are the order_ids of the client with the account_id 34?
select order_id from `order` where account_id = 34;

-- 10. In the order table, which account_ids were responsible for orders between order_id 29540 and order_id 29560 (inclusive)?
select distinct(account_id) from `order` where order_id between 29540 and 29560; 

-- 11. In the order table, what are the individual amounts that were sent to (account_to) id 30067122?
select amount from `order` where account_to = 30067122;

-- 12. In the trans table, show the trans_id, date, type and amount of the 10 first transactions from account_id 793 in chronological order, from newest to oldest.
select trans_id, date, type, amount from trans where account_id = 793 order by date desc limit 10;

-- 13. In the client table, of all districts with a district_id lower than 10, how many clients are from each district_id? Show the results sorted by the district_id in ascending order.
select district_id, count(client_id) from client where district_id < 10 group by district_id order by district_id asc;

-- 14. In the card table, how many cards exist for each type? Rank the result starting with the most frequent type.
select type, count(card_id) from card group by type order by count(card_id) desc;

-- 15. Using the loan table, print the top 10 account_ids based on the sum of all of their loan amounts.
select account_id, sum(amount) from loan group by account_id order by sum(amount) desc limit 10;

-- 16. In the loan table, retrieve the number of loans issued for each day, before (excl) 930907, ordered by date in descending order.
select date, count(loan_id) from loan where date < 930907 group by date order by date desc;

-- 17. In the loan table, for each day in December 1997, count the number of loans issued for each unique loan duration, ordered by date and duration, both in ascending order. You can ignore days without any loans in your output.
select date, duration, count(loan_id) from loan where date between 971200 and 971231 group by date, duration order by date asc; -- I am obtaining results until 31-12-1997, instead of 25-12-1997 as the soltuion of the exercise shows. 

-- 18. In the trans table, for account_id 396, sum the amount of transactions for each type (VYDAJ = Outgoing, PRIJEM = Incoming). Your output should have the account_id, the type and the sum of amount, named as total_amount. Sort alphabetically by type.
select account_id, type, sum(amount) as total_amount from trans where account_id = 396 group by type order by type asc;

-- 19. From the previous output, translate the values for type to English, rename the column to transaction_type, round total_amount down to an integer.
select account_id, case when type = 'PRIJEM' then 'INCOMING' else 'OUTGOING' end as transaction_type, round(sum(amount)) as total_amount from trans where account_id = 396 group by type order by type asc;

-- 20. From the previous result, modify your query so that it returns only one row, with a column for incoming amount, outgoing amount and the difference.
select account_id, round(sum(case when type = 'PRIJEM' then amount end)) as 'INCOMING', round(sum(case when type = 'VYDAJ' then amount end)) as 'OUTGOING', 
round(sum(case when type = 'PRIJEM' then amount end)) - round(sum(case when type = 'VYDAJ' then amount end))
from trans where account_id = 396 group by account_id;

-- 21. Continuing with the previous example, rank the top 10 account_ids based on their difference.
select account_id, round(sum(case when type = 'PRIJEM' then amount end)) - round(sum(case when type = 'VYDAJ' then amount end))
from trans group by account_id order by round(sum(case when type = 'PRIJEM' then amount end)) - round(sum(case when type = 'VYDAJ' then amount end)) desc limit 10;

