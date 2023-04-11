SELECT *
FROM titles

SELECT *
FROM credits

-- Number of TV Shows and Movies
SELECT 
	type,
	COUNT(*) AS 'movie_or_tv_show_count'
FROM titles
GROUP BY type
UNION
SELECT
	'total',
	COUNT(type) AS 'movie_or_tv_show_count'	
FROM titles

-- Checking of release year
SELECT 
	release_year,
	COUNT(release_year) AS 'num_of_movie_or_tv_show_per_year'
FROM titles
GROUP BY release_year
ORDER BY release_year DESC

-- Checking of age certification
SELECT
	age_certification,
	COUNT(age_certification) AS 'num_of_movie_or_tv_show_per_age_cert'
FROM titles
GROUP BY age_certification
ORDER BY 'num_of_movie_or_tv_show_per_age_cert' DESC

-- Updating null values in age_certification table
SELECT * 
FROM titles
WHERE age_certification IS NULL

UPDATE titles
SET age_certification = 'unknown'
WHERE age_certification IS NULL

SELECT *
FROM titles

-- Number of movies/tv shows based on runtime
SELECT 
	'Less than 60 minutes' AS 'length',
	COUNT(*) AS 'num_of_movie_or_tv_show_per_runtime'
FROM titles
WHERE runtime < 60
UNION
SELECT 
	'60 minutes or more' AS 'length',
	COUNT(*) AS 'num_of_movie_or_tv_show_per_runtime'
FROM titles

WHERE runtime >= 60

-- Replacing genre
ALTER TABLE titles
ADD genres_modified NVARCHAR(255)

UPDATE titles 
SET genres_modified = REPLACE(REPLACE(REPLACE(titles.genres, '''', ''), '[', ''), ']', ',')

SELECT genres, genres_modified
FROM titles

SELECT *
FROM titles