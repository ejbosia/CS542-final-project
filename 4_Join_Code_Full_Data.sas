libname Proj '/usr4/cs542sp/bobbymcd/Documents/'; run;
libname netf '/projectnb/cs542sp/netflix_wrw2/CS542-final-project/data/'; run;
*Combine skeleton data with user and movie variables for model analysis for training data;
PROC SQL;
   CREATE TABLE WORK.NETFLIX_ANALYSIS_DATASET2 AS 
   SELECT t1.User_ID, 
          t1.Movie_ID, 
          t1.Year, 
          t1.Rated, 
          t2.COUNT_of_User_ID AS Ratings_for_Movie, 
          t2.Ratings_in_2005 AS Ratings_for_Movie_2005, 
          /* Netflix_Release_Year */
            (year(t2.MIN_of_Rating_Date)) AS Netflix_Release_Year,
		  (t2.MAX_of_Rating_Date-t2.MIN_of_Rating_Date)/365.25 AS Movie_Rating_Time,
		  t2.COUNT_of_User_ID/(t2.MAX_of_Rating_Date-t2.MIN_of_Rating_Date) AS Movie_Ratings_per_Day,
          t2.Release_Year, 
          t2.AVG_of_Rating AS AVG_Rating_for_Movie, 
          t3.COUNT_of_Movie_ID AS Ratings_from_User, 
          t3.Ratings_in_2005 AS Ratings_from_User_2005, 
          t3.AVG_of_Rating AS AVG_Rating_from_User, 
		  (t3.MAX_of_Rating_Date-t3.MIN_of_Rating_Date)/365.25 AS User_Rating_Time,
		  t3.COUNT_of_Movie_ID/(t3.MAX_of_Rating_Date-t3.MIN_of_Rating_Date) AS User_Ratings_per_Day,
          /* User_Entry_Year */
            (year(t3.MIN_of_Rating_Date)) AS User_Entry_Year
      FROM WORK.FULL_DATA_SKELETON t1
           LEFT JOIN WORK.COMBINED_NETFLIX_MOVIE_DATA t2 ON (t1.Movie_ID = t2.Movie_ID)
           LEFT JOIN WORK.COMBINED_NETFLIX_USER_DATA t3 ON (t1.User_ID = t3.User_ID);
QUIT;

*Combine test data with user and movie variables for model analysis for test data;
PROC SQL;
   CREATE TABLE WORK.Who_Rated_What_Ans_wVars AS 
   SELECT t1.User_ID, 
          t1.Movie_ID, 
          2006 as Year, 
          t1.Rated, 
          t2.COUNT_of_User_ID AS Ratings_for_Movie, 
          t2.Ratings_in_2005 AS Ratings_for_Movie_2005, 
          /* Netflix_Release_Year */
            (year(t2.MIN_of_Rating_Date)) AS Netflix_Release_Year,
		  (t2.MAX_of_Rating_Date-t2.MIN_of_Rating_Date)/365.25 AS Movie_Rating_Time,
		  t2.COUNT_of_User_ID/(t2.MAX_of_Rating_Date-t2.MIN_of_Rating_Date) AS Movie_Ratings_per_Day,
          t2.Release_Year, 
          t2.AVG_of_Rating AS AVG_Rating_for_Movie, 
          t3.COUNT_of_Movie_ID AS Ratings_from_User, 
          t3.Ratings_in_2005 AS Ratings_from_User_2005, 
          t3.AVG_of_Rating AS AVG_Rating_from_User, 
		  (t3.MAX_of_Rating_Date-t3.MIN_of_Rating_Date)/365.25 AS User_Rating_Time,
		  t3.COUNT_of_Movie_ID/(t3.MAX_of_Rating_Date-t3.MIN_of_Rating_Date) AS User_Ratings_per_Day,
          /* User_Entry_Year */
            (year(t3.MIN_of_Rating_Date)) AS User_Entry_Year
      FROM WORK.WHO_RATED_WHAT_2006_ANS_USE t1
           LEFT JOIN WORK.COMBINED_NETFLIX_MOVIE_DATA t2 ON (t1.Movie_ID = t2.Movie_ID)
           LEFT JOIN WORK.COMBINED_NETFLIX_USER_DATA t3 ON (t1.User_ID = t3.User_ID);
QUIT;

*Output to csv for ease of size on model analysis;
proc export data=work.NETFLIX_ANALYSIS_DATASET2
    outfile="/projectnb/cs542sp/netflix_wrw2/CS542-final-project/data/full_data2.csv"
    dbms=csv;
run;

proc export data=work.Who_Rated_What_Ans_wVars
    outfile="/projectnb/cs542sp/netflix_wrw2/CS542-final-project/data/test_data_wvars.csv"
    dbms=csv;
run;
