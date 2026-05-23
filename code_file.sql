
USE movies;
-- Before you proceed to solve the assignment, it is a good practice to know what the data values in each table are.
-- Similarly, Write queries to see data values from all tables 
--selecting all cloumns  from movie1 table
select*from [dbo].[movie1];
--selecting all columns from genre
select*from [dbo].[genre1];
--selecting all colums from director_mapping
select*from [dbo].[director_mapping];
--selecting all columns from ratings
select*from [dbo].[ratings1];
--selecting all columns from role_mapping
select*from [dbo].[role_mapping1];
--selecting all columns from names
select*from [dbo].[names1];

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------------------------------


/* To begin with, it is beneficial to know the shape of the tables and whether any column has null values.
 Further in this segment, you will take a look at 'movie' and 'genre' tables. */

-- Segment 1:

-- Q1. Find the total number of rows in each table of the schema?
-- Type your code below:
SELECT 
    COUNT(*) AS movie_row_count
FROM
    movie1;    --movie table count

 SELECT 
    COUNT(*) AS names_row_count
FROM
    names1;  --names table count
    
 SELECT 
    COUNT(*) AS director_mapping_row_count
FROM
    director_mapping;  --Direct_Mapping_count 
select 
  count(*) as role_mappng_count
from 
    role_mapping1;   --role_mapping_count
select 
  count(*) as genre_count 
from genre1;           --genre_count
select 
  count(*) as ratings_count
from ratings1;          --ratings_count

-- ------------------------------------------------------------------------------------------------------------------------------------------------

-- Q2. Which columns in the 'movie' table have null values?
-- Type your code below:

-- Solution 1
--select title column nulls from movie table
SELECT 
    COUNT(*) AS title_nulls
FROM
    movie1
WHERE title IS NULL;
--select count of year column null values from movie table
SELECT 
    COUNT(*) AS year_nullss
FROM
    movie1
WHERE year IS NULL;
--select  count of  date_published  column null values from movie table
SELECT 
    COUNT(*) AS date_published_nulls
FROM
    movie1
WHERE date_published IS NULL;
--select  count of  duration column null values from movie table
SELECT 
    COUNT(*) AS duration_nulls
FROM
    movie1
WHERE duration IS NULL;
--select  count of  worldwide_gross_income column null values from movie table

SELECT 
    COUNT(*) As worldwide_gross_income_nulls
FROM
    movie1
WHERE  worlwide_gross_income IS NULL;
--select  count of  country column null values from movie table
SELECT 
    COUNT(*) AS country_nulls
FROM
    movie1
WHERE country IS NULL;
--select  count of  languages column null values from movie table
SELECT 
    COUNT(*) AS languages_nulls
FROM
    movie1
WHERE languages IS NULL;  --select  count of  production column null values from movie table
SELECT 
    COUNT(*) AS production_company_nulls
FROM
    movie1
WHERE production_company IS NULL;



-- Similarly, write queries to find the null values of remaining columns in 'movie' table 
--count all null values in movie1 table using case statement

-- Solution 2
SELECT 
    COUNT(CASE
        WHEN title IS NULL THEN id
    END) AS title_nulls,
    COUNT(CASE
        WHEN year IS NULL THEN id
    END) AS year_nulls,
     count(case 
     when duration is null then id
    end) as duration_nulls,
     count(case when  country is null then id
    end) as country_nulls,
      count(case when date_published is null then  id
    end) as date_pulished_nulls,
    count(case when worlwide_gross_income  is null then  id
    end) as worlwide_gross_income_nulls,
   count(case when languages  is null then  id
    end) as languages_nulls,
    count(case when production_company  is null then  id
    end) as production_nulls
FROM 
    movie1;
    
/* In Solution 2 above, id in each case statement has been used as a counter to count the number of null values. Whenever a value
   is null for a column, the id increments by 1. */

/* There are 20 nulls in country; 3724 nulls in worlwide_gross_income; 194 nulls in languages; 528 nulls in production_company.
   Notice that we do not need to check for null values in the 'id' column as it is a primary key.

-- As you can see, four columns of the 'movie' table have null values. Let's look at the movies released in each year. */

-- ----------------------------------------------------------------------------------------------------------------------------------------------

-- Q3.1 Find the total number of movies released in each year.
 
/* Output format

+---------------+-------------------+
| Year			|	number_of_movies|
+-------------------+----------------
|	2017		|	   2134			|
|	2018		|		.			|
|	2019		|		.			|
+---------------+-------------------+ */


-- Hint: Utilize the COUNT(*) function to count the number of movies.
-- Hint: Use the GROUP BY clause to group the results by the 'year' column.

-- Type your code below:

select year,count(*) as number_of_movies from movie1 group by year;


-- Q3.2 How does the trend look month-wise? (Output expected) 
/* Output format :
+---------------+-------------------+
|	month_num	|	number_of_movies|
+---------------+----------------
|	  1			|	    134			|
|	  2			|	    231			|
|	  .			|		 .			|
+---------------+-------------------+ */

-- Type your code below:

SELECT 
    MONTH(date_published) AS month_num,
   COUNT(*) AS number_of_movies
FROM 
    movie1
GROUP BY 
    MONTH(date_published)
ORDER BY 
    month_num;


--select month (date_published) as month_num ,title from movie1  group by month_num , order by month_num;

/* The highest number of movies is produced in the month of March.
So, now that you have understood the month-wise trend of movies, let’s take a look at the other details in the
'movies' table. 
We know that USA and India produce a huge number of movies each year. Lets find the number of movies produced by USA
or India in the last year. */
  
  -- ---------------------------------------------------------------------------------------------------------------------------------------------------
  


  
-- Q4. How many movies were produced in the USA or India in the year 2019?
-- Hint: Use the LIKE operator to filter countries containing 'USA' or 'India'.

/* Output format

+---------------+
|number_of_movies|
+---------------+
|	  -		     |  */

-- Type your code below:


SELECT 
    COUNT(*) AS number_of_movies 
FROM 
    movie1  
WHERE 
    year = 2019 
    AND (
        country LIKE '%USA%' 
        OR country LIKE '%India%'
    );


/* USA and India produced more than a thousand movies (you know the exact number!) in the year 2019.
Exploring the table 'genre' will be fun, too.
Let’s find out the different genres in the dataset. */

-- -----------------------------------------------------------------------------------------------------------------------------------------------

-- Q5. Find the unique list of the genres present in the data set?

/* Output format
+---------------+
|genre|
+-----+
|  -  |
|  -  |
|  -  |  */

-- Type your code below:

select distinct genre from genre1;


/* So, RSVP Movies plans to make a movie on one of these genres.
Now, don't you want to know in which genre were the highest number of movies produced?
Combining both the 'movie' and the 'genre' table can give us interesting insights. */

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q6.Which genre had the highest number of movies produced overall?

-- Hint: Utilize the COUNT() function to count the occurrences of movie IDs for each genre.
-- Hint: Group the results by the 'genre' column using the GROUP BY clause.
-- Hint: Order the results by the count of movie IDs in descending order using the ORDER BY clause.
-- Hint: Use the LIMIT clause to restrict the result to only the top genre with the highest movie count.


/* Output format
+-----------+--------------+
|	genre	|	movie_count|
+-----------+---------------
|	  -		|	    -	   |

+---------------+----------+ */

-- Type your code below:

select top 1
genre,count(movie_id) as movie_count 
from genre1 
group by genre
order by movie_count desc ;



/* So, based on the insight that you just drew, RSVP Movies should focus on the ‘Drama’ genre. 
But wait, it is too early to decide. A movie can belong to two or more genres. 
So, let’s find out the count of movies that belong to only one genre.*/

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q7. How many movies belong to only one genre?

-- Hint: Utilize a Common Table Expression (CTE) named 'movie_genre_summary' to summarize genre counts per movie.
-- Hint: Use the COUNT() function along with GROUP BY to count the number of genres for each movie.
-- Hint: Employ COUNT(DISTINCT) to count movies with only one genre.

/* Output format
+------------------------+
|single_genre_movie_count|
+------------------------+
|           -            |*/

-- Type your code below:


with movie_genre_summary as(
select count(*) as single_genre_movie_count 
from genre1  group by genre )
select 
 single_genre_movie_count from movie_genre_summary;

    

/* There are more than three thousand movies which have only one genre associated with them.
This is a significant number.
Now, let's find out the ideal duration for RSVP Movies’ next project.*/

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q8.What is the average duration of movies in each genre? 
-- (Note: The same movie can belong to multiple genres.)

-- Hint: Utilize a LEFT JOIN to combine the 'genre' and 'movie' tables based on the 'movie_id'.
-- Hint: Specify table aliases for clarity, such as 'g' for 'genre' and 'm' for 'movie'.
-- Hint: Employ the AVG() function to calculate the average duration for each genre.
-- Hint: GROUP BY the 'genre' column to calculate averages for each genre.


/* Output format:

+---------------+-------------------+
| genre			|	avg_duration	|
+-------------------+----------------
|	Thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

select g.genre ,
avg(cast( m.duration as int)) as avg_duration
--AVG(TRY_CAST(m.duration AS INT)) AS avg_duration
from genre1 as g left join movie1 as m on g.movie_id=m.id
group by g.genre;

/* Note that using an outer join is important as we are dealing with a large number of null values. Using
   an inner join will slow down query processing. */

/* Now you know that movies of genre 'Drama' (produced highest in number in 2019) have an average duration of
106.77 mins.
Let's find where the movies of genre 'thriller' lie on the basis of number of movies.*/

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------


    
-- Q9.What is the rank of the ‘thriller’ genre of movies among all the genres in terms of number of movies produced? 

-- Hint: Use a Common Table Expression (CTE) named 'summary' to aggregate counts of movie IDs for each genre.
-- Hint: Utilize the COUNT() function along with GROUP BY to count the number of movie IDs for each genre.
-- Hint: Implement the RANK() function to assign a rank to each genre based on movie count.
-- Hint: Employ LOWER() function to ensure case-insensitive comparison.


/* Output format:
+---------------+-------------------+---------------------+
|   genre		|	 movie_count	|		genre_rank    |	
+---------------+-------------------+---------------------+
|   -	    	|	   -			|			-		  |
+---------------+-------------------+---------------------+*/

-- Type your code below:

with summary as(
select genre , count(movie_id) as movie_count from genre1 group by genre 
)
select s.genre, s.movie_count , rank() over( order by s.movie_count desc) as genre_rank from  summary as s where genre='thriller';


-- Thriller movies are in the top 3 among all genres in terms of the number of movies.

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* In the previous segment, you analysed the 'movie' and the 'genre' tables. 
   In this segment, you will analyse the 'ratings' table as well.
   To start with, let's get the minimum and maximum values of different columns in the table */

-- Segment 2:

-- Q10.  Find the minimum and maximum values for each column of the 'ratings' table except the movie_id column.

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
| min_avg_rating|	max_avg_rating	|	min_total_votes   |	max_total_votes 	 |min_median_rating|max_median_rating|
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
|		0		|			5		|	       177		  |	   2000	    		 |		0	       |	8			 |
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+*/

-- Type your code below:
select min(avg_rating) as min_avg_rating ,max(avg_rating) as max_avg_rating,min(total_votes)as min_total_values,max(total_votes)as max_total_values
,min(median_rating)as min_median_rating,max(median_rating) as max_median_rating from ratings1 ;

    -- Type your code below to display remaining columns
   
 WITH details AS (
  SELECT 
    MIN(avg_rating) AS min_avg_rating,
    MAX(avg_rating) AS max_avg_rating,
    MIN(total_votes) AS min_total_votes,
    MAX(total_votes) AS max_total_votes,
    MIN(median_rating) AS min_median_rating,
    MAX(median_rating) AS max_median_rating
  FROM ratings1
)

SELECT 
  r.*, 
  d.min_avg_rating, d.max_avg_rating,
  d.min_total_votes, d.max_total_votes,
  d.min_median_rating, d.max_median_rating
FROM ratings1 AS r
CROSS JOIN details AS d;

/* So, the minimum and maximum values in each column of the ratings table are in the expected range. 
This implies there are no outliers in the table. 
Now, let’s find out the top 10 movies based on average rating. */

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
--11

-- Hint: Use a Common Table Expression (CTE) named 'top_movies' to calculate the average rating for each movie and assign a rank.
-- Hint: Utilize a LEFT JOIN to combine the 'movie' and 'ratings' tables based on 'id' and 'movie_id' respectively.
-- Hint: Implement the AVG() function to calculate the average rating for each movie.
-- Hint: Use the ROW_NUMBER() function along with ORDER BY to assign ranks to movies based on average rating, ordered in descending order.

/* Output format:
+---------------+-------------------+---------------------+
|     title		|		avg_rating	|		movie_rank    |
+---------------+-------------------+---------------------+
|     Fan		|		9.6			|			5	  	  |
|	  .			|		 .			|			.		  |
|	  .			|		 .			|			.		  |
|	  .			|		 .			|			.		  |
+---------------+-------------------+---------------------+*/

-- Type your code below:

WITH top_movies AS (
    SELECT
        m.title,
        AVG(r.avg_rating) AS avg_rating,
        ROW_NUMBER() OVER (ORDER BY AVG(r.avg_rating) DESC) AS movie_rank
    FROM movie1 m
    LEFT JOIN ratings1 r ON m.id = r.movie_id
    GROUP BY m.title
)
SELECT title, avg_rating, movie_rank
FROM top_movies

ORDER BY movie_rank;

-- It's okay to use RANK() or DENSE_RANK() as well.

/* Do you find the movie 'Fan' in the top 10 movies with an average rating of 9.6? If not, please check your code
again.
So, now that you know the top 10 movies, do you think character actors and filler actors can be from these movies?
Summarising the ratings table based on the movie counts by median rating can give an excellent insight. */

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q12. Summarise the ratings table based on the movie counts by median ratings.(order by median_rating)

/* Output format:
+---------------+-------------------+
| median_rating	|	movie_count		|
+-------------------+----------------
|	1			|		105			|
|	.			|		.			|

|	.			|		.			|
+---------------+-------------------+ */

-- Type your code below:

select median_rating ,count(*) as movie_count  
 from ratings1 group by median_rating order by median_rating;


/* Movies with a median rating of 7 are the highest in number. 
Now, let's find out the production house with which RSVP Movies should look to partner with for its next project.*/

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------




-- Q13. Which production house has produced the most number of hit movies (average rating > 8)?

-- Hint: Use a Common Table Expression (CTE) named 'top_prod' to find the top production companies based on movie count.
-- Hint: Utilize a LEFT JOIN to combine the 'movie' and 'ratings' tables based on 'id' and 'movie_id' respectively.
-- Hint: Exclude NULL production company values using IS NOT NULL in the WHERE clause.


/* Output format:
+------------------+-------------------+----------------------+
|production_company|    movie_count	   |    prod_company_rank |
+------------------+-------------------+----------------------+
|           	   |		 		   |			 	  	  |
+------------------+-------------------+----------------------+*/

-- Type your code below:
SELECT*FROM  RATINGS1;
SELECT*FROM movie1;

WITH  TOP_PROD AS(
select top 1  m.production_company,count( r.movie_id) as movie_count ,
  rank() over(order by count(r.movie_id) asc) as prod_company_rank from movie1 as m left join ratings1 as r on m.id=r.movie_id 
  where production_company is not null and   r.avg_rating>8 group by m.production_company
  )

select * from top_prod;

-- It's okay to use RANK() or DENSE_RANK() as well.
-- The answer can be either Dream Warrior Pictures or National Theatre Live or both.

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q14. How many movies released in each genre in March 2017 in the USA had more than 1,000 votes?(Split the question into parts and try to understand it.)

-- Hint: Utilize INNER JOINs to combine the 'genre', 'movie', and 'ratings' tables based on their relationships.
-- Hint: Use the WHERE clause to apply filtering conditions based on year, month, country, and total votes.
-- Hint: Extract the month from the 'date_published' column using the MONTH() function.
-- Hint: Employ LOWER() function for case-insensitive comparison of country names.
-- Hint: Utilize COUNT() function along with GROUP BY to count movies in each genre.


/* Output format:

+---------------+-------------------+
| genre			|	movie_count		|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */


-- Type your code below:


select lower(g.genre) as genre, count(m.title) as movie_count 
from genre1 as g inner join movie1 as m on 
g.movie_id =m.id  
inner join ratings1 as r on g.movie_id=r.movie_id 
where  month(m.date_published)=3 and m.year=2017 and r.total_votes >1000 group by g.genre;
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Lets try analysing the 'imdb' database using a unique problem statement.

-- Q15. Find the movies in each genre that start with the characters ‘The’ and have an average rating > 8.

-- Hint: Utilize INNER JOINs to combine the 'movie', 'genre', and 'ratings' tables based on their relationships.
-- Hint: Apply filtering conditions in the WHERE clause using the LIKE operator for the 'title' column and a condition for 'avg_rating'.
-- Hint: Use the '%' wildcard appropriately with the LIKE operator for pattern matching.


/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		genre	      |
+---------------+-------------------+---------------------+
| Theeran		|		8.3			|		Thriller	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/

-- Type your code below:


select m.title ,r.avg_rating ,g.genre  from movie1 as m inner join genre1 as g 
on m.id=g.movie_id inner join ratings1 as r  on m.id=r.movie_id where  m.title like 'the%' and r.avg_rating>8;



-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- You should also try out the same for median rating and check whether the ‘median rating’ column gives any
-- significant insights.

-- Q16. Of the movies released between 1 April 2018 and 1 April 2019, how many were given a median rating of 8?

-- Hint: Use an INNER JOIN to combine the 'movie' and 'ratings' tables based on their relationship.
-- Hint: Pay attention to the date format for the BETWEEN operator and ensure it matches the format of the 'date_published' column.

/* Output format
+---------------+
|movie_count|
+-----------+
|     -     |  */

-- Type your code below:
SELECT COUNT(m.TITLE)as movie_count from movie1 as m inner join ratings1 as r on m.id=r.movie_id where  date_published
between '2018-04-01' and '2019-04-01' and r.median_rating =8;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Now, let's see the popularity of movies in different languages.


-- Q17. Do German movies get more votes than Italian movies? 
-- Hint: Here you have to find the total number of votes for both German and Italian movies.

/* Output format:
+---------------------------+---------------------------+
| german_votes_per_movie	|	italian_votes_per_movie	|
+---------------------------+----------------------------
|	-	                    |		    -   			|
|	.			            |		.	        		|
+---------------------------+---------------------------+ */

-- Type your code below:

WITH cte AS (
    SELECT COUNT(languages) AS german_votes_per_movie
    FROM movie1  
    WHERE languages = 'german'
),
cte2 AS (
    SELECT COUNT(languages) AS italian_votes_per_movie
    FROM movie1  
    WHERE languages = 'italian'
)
SELECT 
    c.german_votes_per_movie,
    i.italian_votes_per_movie
FROM cte AS c
 cross JOIN cte2 AS i;


-- Answer is Yes


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------


/* Now that you have analysed the 'movie', 'genre' and 'ratings' tables, let us analyse another table - the 'names'
table. 
Let’s begin by searching for null values in the table. */

-- Segment 3:

-- Q18. Find the number of null values in each column of the 'names' table, except for the 'id' column.

/* Hint: You can find the number of null values for individual columns or follow below output format

+---------------+-------------------+---------------------+----------------------+
| name_nulls	|	height_nulls	|date_of_birth_nulls  |known_for_movies_nulls|
+---------------+-------------------+---------------------+----------------------+
|		0		|			123		|	       1234		  |	   12345	    	 |
+---------------+-------------------+---------------------+----------------------+*/

-- Type your code below:

SELECT 
  COUNT(*)- COUNT(name) AS name_nulls,
  COUNT(*) - COUNT(height) AS height_nulls,                         --count(*) count  all rows ,regarless nulls  ,count(*) count  only non_values
  COUNT(*) - COUNT(date_of_birth) AS date_of_birth_nulls,
  COUNT(*) - COUNT(known_for_movies) AS known_for_movies_nulls
FROM names1;

-- Solution 2
-- use case statements to write the query to find null values of each column in names table
-- Hint: Refer question 2

-- Type your code below 


SELECT 
  SUM(CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS name_nulls,
  SUM(CASE WHEN height IS NULL THEN 1 ELSE 0 END) AS height_nulls,
  SUM(CASE WHEN date_of_birth IS NULL THEN 1 ELSE 0 END) AS date_of_birth_nulls,
  SUM(CASE WHEN known_for_movies IS NULL THEN 1 ELSE 0 END) AS known_for_movies_nulls
FROM names1;


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

/* The director is the most important person in a movie crew. 
   Let’s find out the top three directors each in the top three genres who can be hired by RSVP Movies. */

-- Q19. Who are the top three directors in each of the top three genres whose movies have an average rating > 8?
-- (Hint: The top three genres would have the most number of movies with an average rating > 8.)

/* Output format:
+---------------+-------------------+
| director_name	|	movie_count		|
+---------------+-------------------|
|James Mangold	|		4			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */

-- Type your code below:

WITH top_genres AS (
    SELECT top 3  genre, COUNT(*) AS movie_count
    FROM movie1
    WHERE average_rating > 8
    GROUP BY genre
    ORDER BY movie_count DESC
    
),
director_ranking AS (
    SELECT
        m.genre,
        d.director_name,
        COUNT(*) AS superhit_movie_count,
        ROW_NUMBER() OVER (PARTITION BY m.genre ORDER BY COUNT(*) DESC) AS rn
    FROM movie1 m
    JOIN  d ON m.director_id = d.director_id
    WHERE m.average_rating > 8
      AND m.genre IN (SELECT genre FROM top_genres)
    GROUP BY m.genre, d.director_name
)

SELECT genre, director_name, superhit_movie_count
FROM director_ranking
WHERE rn <= 3
ORDER BY genre, superhit_movie_count DESC;



-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q20. Who are the top two actors whose movies have a median rating >= 8?

-- Hint: Utilize INNER JOINs to combine the 'names', 'role_mapping', 'movie', and 'ratings' tables based on their relationships.
-- Hint: Apply filtering conditions in the WHERE clause using logical conditions for median rating and category.
-- Hint: Group the results by the actor's name using GROUP BY.
-- Hint: Utilize aggregate functions such as COUNT() to count the number of movies each actor has participated in.


/* Output format:
+---------------+-------------------+
| actor_name	|	movie_count		|
+-------------------+----------------
|Christian Bale	|		10			|
|	.			|		.			|
+---------------+-------------------+ */

 with c_t_e as (select top 2  n.name as actor_name  , count(m.title) as movie_count
from names1 as n
inner join role_mapping1 as r on
  n.id=r.name_id
inner join ratings1 as r1  on r.movie_id=r1.movie_id
inner join movie1 as m  on m.id= r1.movie_id where r1.median_rating>=8 group by n.name order by movie_count desc )
select *from c_t_e  ;

/* Did you find the actor 'Mohanlal' in the list? If no, please check your code again. 
RSVP Movies plans to partner with other global production houses. 
Let’s find out the top three production houses in the world.*/

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q21. Which are the top three production houses based on the number of votes received by their movies?
-- Hint: Use a Common Table Expression (CTE) named 'top_prod' to find the top production companies based on total votes.
-- Hint: Utilize a LEFT JOIN to combine the 'movie' and 'ratings' tables based on 'id' and 'movie_id' respectively.
-- Hint: Filter out NULL production company values using IS NOT NULL in the WHERE clause.
-- Hint: Utilize the SUM() function to calculate the total votes for each production company.
-- Hint: Implement the ROW_NUMBER() function along with ORDER BY to assign ranks to production companies based on total votes, ordered in descending order.
-- Hint: Limit the number of results to the top 3 using ROW_NUMBER() and WHERE clause.


/* Output format:
+-------------------+-------------------+---------------------+
|production_company |   vote_count		|	prod_comp_rank    |
+-------------------+-------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|		.		      |
|	.				|		.			|		.		  	  |
+-------------------+-------------------+---------------------+*/

-- Type your code below:
WITH top_prod AS (
    SELECT
        m.production_company,
        SUM(r.total_votes) AS vote_count,
        ROW_NUMBER() OVER (ORDER BY SUM(r.total_votes) DESC) AS prod_comp_rank
    FROM movie1 m
    LEFT JOIN ratings1 r ON m.id = r.movie_id
    WHERE m.production_company IS NOT NULL
    GROUP BY m.production_company
)
SELECT production_company, vote_count, prod_comp_rank
FROM top_prod
WHERE prod_comp_rank <= 3
ORDER BY prod_comp_rank;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q22. Rank actors with movies released in India based on their average ratings. Which actor is at the top of the
-- list?
-- Note: The actor should have acted in at least five Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes
-- should act as the tie breaker.)

/* Output format:
+---------------+---------------+---------------------+----------------------+-----------------+
| actor_name	|	total_votes	|	movie_count		  |	actor_avg_rating 	 |actor_rank	   |
+---------------+---------------+---------------------+----------------------+-----------------+
|	Yogi Babu	|		3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|		.		|	       .		  |	   .	    		 |		.	       |
|		.		|		.		|	       .		  |	   .	    		 |		.	       |
+---------------+---------------+---------------------+----------------------+-----------------+*/

-- Type your code below:
WITH actor_stats AS (
    SELECT 
        n.name AS actor_name,
        COUNT(m.id) AS movie_count,
        SUM(r.avg_rating * r.total_votes) / SUM(r.total_votes) AS weighted_avg_rating,
        SUM(r.total_votes) AS total_votes
    FROM names1 AS n
    JOIN role_mapping1 AS rm ON n.id = rm.name_id                --  Vijay Sethupathi has acted in 5 Indian movies, 
      --AND m.country = 'India'                                   -- with a weighted average rating of 8.4 and a total of 23,114 votes.  
    JOIN movie1 AS m ON m.id = rm.movie_id                       -- --Based on these metrics, he ranks as the top-rated actor.. 
    JOIN ratings1 AS r ON r.movie_id = m.id
    WHERE rm.category = 'actor' AND m.country = 'India'  
    GROUP BY n.name
    HAVING COUNT(m.id) >= 5     
),
ranked_actors AS (
    SELECT *,
           RANK() OVER (
               ORDER BY weighted_avg_rating DESC, total_votes DESC
           ) AS actor_rank
    FROM actor_stats
)
SELECT *
FROM ranked_actors
WHERE actor_rank = 1;






-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q23.Find the top five actresses in Hindi movies released in India based on their average ratings.
-- Note: The actresses should have acted in at least three Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes
-- should act as the tie breaker.)

-- Hint: Utilize a Common Table Expression (CTE) named 'actress_ratings' to aggregate data for actresses based on specific criteria.
-- Hint: Use INNER JOINs to combine the 'names', 'role_mapping', 'movie', and 'ratings' tables based on their relationships.
-- Hint: Consider which columns are necessary for the output and ensure they are selected in the SELECT clause.
-- Hint: Apply filtering conditions in the WHERE clause using logical conditions for category and language.
-- Hint: Utilize aggregate functions such as SUM() and COUNT() to calculate total votes, movie count, and average rating for each actress.
-- Hint: Use GROUP BY to group the results by actress name.
-- Hint: Implement the ROW_NUMBER() function along with ORDER BY to assign ranks to actresses based on average rating and total votes, ordered in descending order.
-- Hint: Specify the condition for selecting actresses with at least 3 movies using a WHERE clause.
-- Hint: Limit the number of results to the top 5 using LIMIT.


/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |	actress_avg_rating 	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Tabu		|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/

-- Type your code below:
with actress_rating as(
SELECT
n.name as actress_name,
sum(ra.total_votes) as total_votes,
count(r.movie_id) as movie_count,
avg(ra.avg_rating) as actress_avg_rating,
rank() over(order by avg(ra.avg_rating) desc) as actress_rank
FROM 
 names1 as n INNER JOIN role_mapping1 as r 
ON n.id=r.name_id INNER JOIN movie1 as m
ON r.movie_id=m.id INNER JOIN ratings1 as ra
ON m.id=ra.movie_id 
WHERE
r.category='actress' and m.languages='hindi' and country='india'
group by n.name
having
count(r.movie_id)>=3
)
select * from actress_rating
where actress_rank<=5;                          

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Now let us divide all the thriller movies in the following categories and find out their numbers.
/* Q24. Consider thriller movies having at least 25,000 votes. Classify them according to their average ratings in
   the following categories: 
			Rating > 8: Superhit
			Rating between 7 and 8: Hit
			Rating between 5 and 7: One-time-watch
			Rating < 5: Flop   */
            
-- Hint: Utilize LEFT JOINs to combine the 'movie', 'ratings', and 'genre' tables based on their relationships.
-- Hint: Use the CASE statement to categorize movies based on their average rating into 'Superhit', 'Hit', 'One time watch', and 'Flop'.
-- Hint: Implement logical conditions within the CASE statement to define the movie categories based on rating ranges.
-- Hint: Apply filtering conditions in the WHERE clause to select movies with a specific genre ('thriller') and a total vote count exceeding 25000.
-- Hint: Utilize the LOWER() function to ensure case-insensitive comparison of genre names.

/* Output format :

+-------------------+-------------------+
|   movie_name	    |	movie_category  |
+-------------------+--------------------
|	Pet Sematary	|	One time watch	|
|       -       	|		.			|
|	    -   		|		.			|
+---------------+-------------------+ */


-- Type your code below:
SELECT                                                          -- '77' thriller movies having at least 25,000 votes. Classify them according to their average ratings in
    m.title AS movie_name,                                           -- the following categories:  
    CASE                                                                             --Rating > 8: Superhit
        WHEN r.avg_rating > 8 THEN 'Superhit'                                        --Rating between 7 and 8: Hit
        WHEN r.avg_rating BETWEEN 7 AND 8 THEN 'Hit'                                 --Rating between 5 and 7: One-time-watch
        WHEN r.avg_rating BETWEEN 5 AND 7 THEN 'One time watch'                       --Rating < 5: Flop 
        WHEN r.avg_rating < 5 THEN 'Flop'
    END AS movie_category
FROM movie1 AS m
LEFT JOIN ratings1 AS r ON m.id = r.movie_id
LEFT JOIN genre1 AS g ON m.id = g.movie_id
WHERE LOWER(g.genre) = 'thriller'
  AND r.total_votes > 25000;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* Until now, you have analysed various tables of the data set. 
Now, you will perform some tasks that will give you a broader understanding of the data in this segment. */

-- Segment 4:

    
-- Q25. What is the genre-wise running total and moving average of the average movie duration? 
-- (Note: You need to get the output according to the output format given below.)

-- Hint: Utilize a Common Table Expression (CTE) named 'genre_summary' to calculate the average duration for each genre.
-- Hint: Use a LEFT JOIN to combine the 'genre' and 'movie' tables based on the 'movie_id' and 'id' respectively.
-- Hint: Implement the ROUND() function to round the average duration to two decimal places.
-- Hint: Utilize the AVG() function along with GROUP BY to calculate the average duration for each genre.
-- Hint: In the main query, use the SUM() and AVG() window functions to compute the running total duration and moving average duration respectively.
-- Hint: Utilize the ROWS UNBOUNDED PRECEDING option to include all rows from the beginning of the partition.


/* Output format:
+---------------+-------------------+----------------------+----------------------+
| genre			|	avg_duration	|running_total_duration|moving_avg_duration   |
+---------------+-------------------+----------------------+----------------------+
|	comedy		|			145		|	       106.2	   |	   128.42	      |
|		.		|			.		|	       .		   |	   .	    	  |
|		.		|			.		|	       .		   |	   .	    	  |
|		.		|			.		|	       .		   |	   .	    	  |
+---------------+-------------------+----------------------+----------------------+*/

-- Type your code below:
WITH genre_summary AS (
    SELECT                                                           
       g.genre,
        ROUND(avg(cast(m.duration as int)), 2) AS avg_duration
    FROM
        genre1 AS g                                        --this querey is used to calculate the avg_duration,
    LEFT JOIN                                             --running_total_duration and moving_avg_duration
        movie1 AS m ON g.movie_id = m.id                   --of each genre
    GROUP BY
        g.genre
)
SELECT
genre,
    avg_duration,
    ROUND(
        SUM(avg_duration) OVER (
            ORDER BY genre
            ROWS UNBOUNDED PRECEDING ),2)
            AS running_total_duration,
    ROUND(
        AVG(avg_duration) OVER (
            ORDER BY genre
            ROWS UNBOUNDED PRECEDING),2)
            AS moving_avg_duration
FROM genre_summary;
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Let us find the top 5 movies for each year with the top 3 genres.

-- Q26. Which are the five highest-grossing movies in each year for each of the top three genres?
-- (Note: The top 3 genres would have the most number of movies.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| genre			|	year			|	movie_name		  |worldwide_gross_income|movie_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	comedy		|			2017	|	       indian	  |	   $103244842	     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/

-- Type your code below:
with top_movies as(
Select top 3
   g.genre,
   m.year,
   m.title as movie_name,
   max(m.worlwide_gross_income) as worldwide_gross_income,
   rank() over(partition by g.genre order by m.worlwide_gross_income desc)
   as movie_rank                                                              --This query provides a genre-wise breakdown of the top 5 highest-earning movies,
from                                                                          --helping us understand which films were the biggest box office successes in their respective categories.
    genre1 as g INNER JOIN movie1 as m                                          -- It’s useful for analyzing trends in audience preferences, financial performance,
    ON g.movie_id=m.id                                                        -- and genre popularity over time.
    WHERE
    m.worlwide_gross_income IS NOT NULL
    group by g.genre,m.year,m.title,m.worlwide_gross_income
    )
    select * from top_movies where  movie_rank<=5 ;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* Finally, let’s find out the names of the top two production houses that have produced the highest number of hits
   among multilingual movies.
   
Q27. What are the top two production houses that have produced the highest number of hits (median rating >= 8) among
multilingual movies? */
-- Hint: Utilize a Common Table Expression (CTE) named 'top_prod' to find the top production companies based on movie count.
-- Hint: Use a LEFT JOIN to combine the 'movie' and 'ratings' tables based on their relationship.
-- Hint: Apply filtering conditions in the WHERE clause using logical conditions for median rating, production company existence, and language specification.
-- Hint: Utilize aggregate functions such as COUNT() to count the number of movies for each production company.
-- Hint: Implement the ROW_NUMBER() function along with ORDER BY to assign ranks to production companies based on movie count, ordered in descending order.
-- Hint: Apply filtering conditions in the WHERE clause using logical conditions for median rating, production company existence, and language specification.
-- Hint: Limit the number of results to the top 2 using ROW_NUMBER() and WHERE clause.
-- Multilingual is the important piece in the above question. It was created using POSITION(',' IN languages)>0.
-- If there is a comma, that means the movie is of more than one language.


/* Output format:
+-------------------+-------------------+---------------------+
|production_company |movie_count		|		prod_comp_rank|
+-------------------+-------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/

-- Type your code below:


with top_prod as(
SELECT
    m.production_company,
    count(r.movie_id) as movie_count,
    row_number() over(order by count(r.movie_id) desc) as prod_comp_rank
FROM
    movie1 as m LEFT JOIN ratings1 as r                  --This query highlights the top 2 production companies that consistently produce high-quality,  
    ON m.id=r.movie_id                                 --critically acclaimed films across multiple languages.
WHERE                                                  --These companies not only dominate in terms of quantity 
    m.production_company IS NOT NULL                   --but also show a commitment to diverse and well-received content.
    and r.median_rating >= 8
GROUP BY
    m.production_company
HAVING
    count( distinct m.languages)>=2
)
SELECT * from top_prod
WHERE prod_comp_rank<=2;


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q28. Who are the top 3 actresses based on the number of Super Hit movies (average rating > 8) in 'drama' genre?

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |actress_avg_rating	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Laura Dern	|			1016	|	       1		  |	   9.60			     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/

-- Type your code below:

WITH drama_actresses AS (
    SELECT 
        n.name AS actress_name,
        COUNT(m.id) AS movie_count,
        SUM(r.total_votes) AS total_votes,
        -SUM(r.avg_rating * r.total_votes) / SUM(r.total_votes) AS actress_avg_rating
FROM names1 AS n
    JOIN role_mapping1 AS rm ON n.id = rm.name_id                   --This query identifies the top 3 drama actresses  
    JOIN movie1 AS m ON m.id = rm.movie_id                          --who consistently star in critically acclaimed, 
    JOIN ratings1 AS r ON r.movie_id = m.id                        --highly rated films. By using a weighted average, 
    JOIN genre1 AS g ON g.movie_id = m.id                          --it ensures that popularity (via vote count) is factored into the ranking,
    WHERE rm.category= 'actress'                                 -- not just raw ratings. 
      AND g.genre = 'drama'                                      --These actresses stand out for both quality and audience impact
      AND r.avg_rating > 8                                       --in the drama genre.
    GROUP BY n.name
),
ranked_actresses AS (
    SELECT *,
           RANK() OVER (ORDER BY actress_avg_rating DESC,
           total_votes DESC) AS actress_rank
    FROM drama_actresses
)
SELECT
    TOP 3 actress_name, 
    movie_count, 
    total_votes, 
    actress_avg_rating,
    actress_rank
FROM
    ranked_actresses;


-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* Q29. Get the following details for top 9 directors (based on number of movies):

Director id
Name
Number of movies
Average inter movie duration in days
Average movie ratings
Total votes
Min rating
Max rating
Total movie duration

Format:
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
| director_id	|	director_name	|	number_of_movies  |	avg_inter_movie_days |	avg_rating	| total_votes  | min_rating	| max_rating | total_duration |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
|nm1777967		|	A.L. Vijay		|			5		  |	       177			 |	   5.65	    |	1754	   |	3.7		|	6.9		 |		613		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+

--------------------------------------------------------------------------------------------*/

-- Type your code below:
WITH direct AS (
    SELECT top 9
        d.name_id AS director_id,
        n.name AS director_name,
        COUNT(d.movie_id) AS number_of_movies,                         --This query highlights directors with a compact portfolio (≤ 9 films),    
        AVG(cast(m.duration as int)) AS avg_inter_movie_days,          --offering a nuanced view of their artistic consistency,
        AVG(r.avg_rating) AS avg_rating,                               -- audience reception, and productivity.
        SUM(r.total_votes) AS total_votes,                             --It’s ideal for identifying rising talents,
        MIN(r.avg_rating) AS min_rating,                              -- selective auteurs, or directors with high-impact but limited output.
        MAX(r.avg_rating) AS max_rating,
        SUM(cast(m.duration as int)) AS total_duration
  FROM 
    names1 AS n
    JOIN director_mapping AS d ON n.id = d.name_id
    JOIN movie1 AS m ON d.movie_id = m.id
    JOIN ratings1 AS r ON m.id = r.movie_id
Group By
    d.name_id,n.name
 ORDER BY
    number_of_movies desc
)
SELECT *
FROM direct;


