USE portfolioproject;
-- // Tasks and Concepts//--

-- Part 1: Basics:

-- 1. Loading and Exploring Data:
-- a. Explore the structure and first 10 rows of each table:
DESCRIBE badges;
SELECT * FROM badges LIMIT 10;

DESCRIBE comments;
SELECT * FROM comments LIMIT 10;

DESCRIBE post_history;
Select * FROM post_history LIMIT 10;

DESCRIBE post_links;
Select * FROM post_links LIMIT 10;

DESCRIBE posts_answers;
Select * FROM posts_answers LIMIT 10;

DESCRIBE tags;
Select * FROM tags LIMIT 10;

DESCRIBE users;
Select * FROM users LIMIT 10;

DESCRIBE votes;
Select * FROM votes LIMIT 10;

DESCRIBE posts;
Select * FROM posts LIMIT 10;

-- b. Identify the total number of records in each table:
-- Total records in badges:

SELECT COUNT(*) AS total_records FROM badges;
SELECT COUNT(*) AS total_records FROM comments;
SELECT COUNT(*) AS total_records FROM post_history;
SELECT COUNT(*) AS total_records FROM post_links;
SELECT COUNT(*) AS total_records FROM posts_answers;
SELECT COUNT(*) AS total_records FROM tags;
SELECT COUNT(*) AS total_records FROM users;
SELECT COUNT(*) AS total_records FROM votes;
SELECT COUNT(*) AS total_records FROM posts;

-- 2. Filtering and Sorting:
-- a. Find all posts with a view_count greater than 100:

SELECT * FROM posts
WHERE view_count > 100;

SELECT * FROM posts_answers
WHERE view_count > 100;

-- b. Display comments made in 2005, sorted by creation_date:

SELECT * FROM comments
WHERE YEAR(creation_date) = 2005
ORDER BY creation_date;

-- 3. Simple Aggregations:
-- a. Count the total number of badges (badges table):   

SELECT COUNT(*) AS total_badges
FROM badges;

-- b. Calculate the average score of posts grouped by post_type_id (posts_answers table):

SELECT post_type_id, AVG(score) AS average_score
FROM posts_answers
GROUP BY post_type_id;

-- Part 2: Joins:
-- 1. Basic Joins:

-- a. Combine the post_history and posts tables to display the title of posts and the corresponding changes made in the post history:

SELECT title, text AS change_description
FROM post_history
JOIN posts ON post_history.post_id = posts.id;

-- b. Join the users table with badges to find the total badges earned by each:

SELECT users.display_name, COUNT(badges.id) AS total_badges
FROM users
JOIN badges ON users.id = badges.user_id
GROUP BY users.display_name;

-- 2. Multi-Table Joins:
-- a. Fetch the titles of posts, their comments, and the users who made those comments: 

SELECT title, text, display_name
FROM posts
JOIN comments ON posts.id = comments.post_id
JOIN users ON comments.user_id = users.id;

-- b. Combine post_links with posts to list related questions:

SELECT b.id AS link_id, a.title AS original_post, p_related.title AS related_post
FROM posts a
INNER JOIN post_links b ON a.id = b.post_id
INNER JOIN posts p_related ON b.related_post_id = p_related.id;


-- c. Join users, badges, and comments tables to find the users who have earned badges and made comments:

SELECT u.display_name, COUNT(b.id) AS total_badges, COUNT(c.id) AS total_comments
FROM users u
LEFT JOIN badges b ON u.id = b.user_id
LEFT JOIN comments c ON u.id = c.user_id
GROUP BY u.display_name;

-- 3: Subqueries:
-- 1. Single-Row Subqueries:

-- a. Find the user with the highest reputation (users table):

SELECT display_name, reputation
FROM users
WHERE reputation = (SELECT MAX(reputation) FROM users);

-- b. Retrieve posts with the highest score in each post_type_id (posts table):

SELECT id, post_type_id, score
FROM posts p1
WHERE score = (SELECT MAX(score) FROM posts p2 WHERE p1.post_type_id = p2.post_type_id);

-- 2. Correlated Subqueries:
-- a. For each post, fetch the number of related posts from post_links:

select * from posts;
select * from post_links;
SELECT p.id AS post_id, 
       (SELECT COUNT(*) FROM post_links pl WHERE pl.post_id = p.id) AS related_posts_count
FROM posts p;

-- 4: Common Table Expressions (CTEs):

-- 1. Non-Recursive CTE:
-- a.Create a CTE to calculate the average score of posts by each user and use it to: List users with an average score above 50. Rank users based on their average post score:

with ranking_avg_score as ( select owner_user_id,
round(avg(score),2) as avg_score  
from posts
group by owner_user_id )
select owner_user_id as user_id, avg_score , 
Rank () over (ORDER BY avg_score asc) as ranking
from ranking_avg_score
where avg_score> 50
order by user_id asc;

-- 2. Recursive CTE:
-- a.Simulate a hierarchy of linked posts using the post_links table:

with recursive post_hierarchy as ( select 
post_id , link_type_id, related_post_id,
1 as level
from post_links
union all
select pl.post_id , 
pl.link_type_id, 
pl.related_post_id,
ph.level + 1 AS level
from post_links pl
inner join post_hierarchy ph on ph.post_id = ph.related_post_id)
select * from post_hierarchy;


-- 5: Advanced Queries:
-- 1. Window Functions:

-- a.Rank posts based on their score within each year (posts table):

SELECT id, title, score, YEAR(creation_date) AS post_year, 
       RANK() OVER (PARTITION BY YEAR(creation_date) ORDER BY score DESC) AS rank_within_year
FROM posts
ORDER BY post_year, rank_within_year;


-- b. Calculate the running total of badges earned by users (badges table):

SELECT user_id, name, date, 
       SUM(1) OVER (PARTITION BY user_id ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total 
FROM badges;


-- New Insights and Questions:
-- a.Which users have contributed the most in terms of comments, edits, and votes?

SELECT u.display_name, 
       COUNT(DISTINCT c.id) AS total_comments, 
       COUNT(DISTINCT ph.id) AS total_edits, 
       COUNT(DISTINCT v.id) AS total_votes
FROM users u
LEFT JOIN comments c ON u.id = c.user_id
LEFT JOIN post_history ph ON u.id = ph.user_id AND ph.post_history_type_id = 2
LEFT JOIN votes v ON u.id = (SELECT p.owner_user_id FROM posts p WHERE p.id = v.post_id)
GROUP BY u.display_name
ORDER BY total_comments DESC, total_edits DESC, total_votes DESC;

select count(`text`) as comments, 
user_id
from comments
group by user_id;


 -- b. What types of badges are most commonly earned, and which users are the top earners?
 
SELECT COUNT(id) AS no_of_badges, name
FROM badges
GROUP BY name;

-- Which users are the top earners?

SELECT COUNT(`name`) AS top_earner, user_id
FROM badges
GROUP BY user_id;


-- c. Which tags are associated with the highest-scoring posts?

select  title, post_type_id, score
from posts
where score = (select max(score) from posts);

-- d. How often are related questions linked, and what does this say about knowledge sharing?

SELECT post_id, title,
       COUNT(related_post_id) AS linked_question 
FROM post_links a
JOIN posts b ON a.post_id = b.id
GROUP BY post_id, title;

select* from votes;
select* from users;
select * from posts;
select * from tags;
select * from  post_links;