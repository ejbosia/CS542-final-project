
PROC SQL;
   CREATE TABLE WORK.COMBINED_NETFLIX_USER_DATA AS 
   SELECT t1.User_ID, 
            (COUNT(t1.Movie_ID)) AS COUNT_of_Movie_ID, 
            (AVG(t1.Rating)) AS AVG_of_Rating, 
            (MIN(t1.Rating_Date)) FORMAT=MMDDYY10. AS MIN_of_Rating_Date, 
            (MAX(t1.Rating_Date)) FORMAT=MMDDYY10. AS MAX_of_Rating_Date, 
            (SUM(ifn(year(t1.Rating_Date)=2005,1,0))) AS Ratings_in_2005
      FROM WORK.COMBINED_NETFLIX_DATA t1
      GROUP BY t1.User_ID;
QUIT;


PROC SQL;
   CREATE TABLE WORK.COMBINED_NETFLIX_MOVIE_DATA AS 
   SELECT DISTINCT t1.Movie_ID,
            (COUNT(t1.User_ID)) AS COUNT_of_User_ID, 
            (MIN(t1.Rating_Date)) FORMAT=MMDDYY10. AS MIN_of_Rating_Date, 
            (MAX(t1.Rating_Date)) FORMAT=MMDDYY10. AS MAX_of_Rating_Date, 
            t2.Release_Year AS Release_Year, 
            t2.Movie_Name,
            (SUM(ifn(year(t1.Rating_Date)=2005,1,0))) AS Ratings_in_2005, 
            (AVG(t1.Rating)) AS AVG_of_Rating
      FROM WORK.COMBINED_NETFLIX_DATA t1
           INNER JOIN Work.MOVIE_TITLES_NAMED t2 ON (t1.Movie_ID = t2.Movie_ID)
      GROUP BY t1.Movie_ID;
QUIT;
