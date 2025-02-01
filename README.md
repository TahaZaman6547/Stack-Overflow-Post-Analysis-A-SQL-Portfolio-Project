# Stack-Overflow-Post-Analysis-A-SQL-Portfolio-Project
This project analyzes Stack Overflow post history using SQL to understand user activity and content trends. Key findings include top contributors, popular badges, and post linking patterns. These insights help improve user engagement and content quality on platforms like Stack Overflow.

## 📌 Project Overview  
This project analyzes Stack Overflow post history to understand user activity and content evolution using SQL. It focuses on:  
- Identifying top contributors (comments, edits, and votes).  
- Analyzing badge distributions and top earners.  
- Finding tags associated with high-scoring posts.  
- Examining post-linking patterns for knowledge sharing.  

## 📂 Dataset  
The dataset is sourced from [Kaggle](https://www.kaggle.com/datasets/stackoverflow/stackoverflow/data?select=post_history) and includes:  
- **Badges** (tracks badges earned by users).  
- **Comments** (contains user comments on posts).  
- **Post History** (records edits, comments, and modifications).  
- **Post Links** (links between related posts).  
- **Posts & Answers** (questions, answers, scores, and view counts).  
- **Tags** (topic tags associated with posts).  
- **Users** (user details and reputation).  
- **Votes** (tracks voting activity).  

## 🎯 Project Goals  
- Use **SQL queries** to extract insights from Stack Overflow data.  
- Apply **Joins, Aggregations, Subqueries, CTEs, and Window Functions**.  
- Improve understanding of **user behavior, badge distribution, and post linking trends**.  

## 🛠️ Methodology  
1. **Data Exploration:** Understand table structures and relationships.  
2. **Filtering & Sorting:** Identify popular posts and engagement patterns.  
3. **Aggregations:** Count badges, votes, and user activity.  
4. **Joins:** Combine tables to analyze relationships between users, posts, and interactions.  
5. **Subqueries & CTEs:** Find top contributors and rank users based on engagement.  
6. **Window Functions:** Track trends in badge distribution over time.  
7. **Insights & Recommendations:** Suggest improvements for user engagement on Stack Overflow.  

## 🔍 Key Findings  
✅ **Top Contributors:** Users **1001 & 1002** contributed the most comments.  
✅ **Most Common Badge:** "Gold Contributor" was the most frequently earned badge.  
✅ **High-Scoring Tags:** Direct relationships between posts and tags were not present.  
✅ **Post Linking Patterns:** 5 post IDs had at least 2 related questions, indicating strong knowledge-sharing.  

## 📊 Data Visualization  
- **Bar Chart:** Top 10 users by activity.  
- **Pie Chart:** Most common badges earned.  

## 💡 Recommendations  
🚀 **Recognize Top Contributors:** Launch a **“Top Contributor of the Month”** program.  
🏅 **Optimize Badge System:** Introduce **“Most Helpful Comment”** badge to boost engagement.  
🔗 **Enhance Content Organization:** Improve **related questions linking** for better navigation.  

## 📜 Report  
A detailed report with SQL scripts and insights is available in the [SQL Portfolio Project Report.pdf](./SQL%20Portfolio%20Project%20Report.pdf).  

## 🏆 Technologies Used  
- **Database:** MySQL  
- **Query Language:** SQL  
- **Platform:** Kaggle  

## 🔗 Reference  
[Stack Overflow Post Analysis: A SQL Portfolio Project](https://www.kaggle.com/datasets/stackoverflow/stackoverflow/data?select=post_history)  
