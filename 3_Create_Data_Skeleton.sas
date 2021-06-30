*Creates skeleton of negative results to add to data for model analysis;
*Datapairs is to lookup to see if simulated result occured in model;
PROC SQL;
   CREATE TABLE WORK.DATA_PAIRS AS 
   SELECT t1.Movie_ID, t1.User_ID, t1.Rating, (1) AS Rated, 
            (year(t1.Rating_Date)) AS Year, 
            (cats(t1.User_ID,"_",t1.Movie_ID)) AS Lookup
      FROM WORK.COMBINED_NETFLIX_DATA t1;
QUIT;


%macro MakeNegatives;
*I for year endings 2000 to 2005;
%do I = 0 %to 5;
*Segment data by year to keep movie and users together in time if that later becomes important;
PROC SQL;
   CREATE TABLE WORK.COMBINED_NETFLIX_200&I._RATINGS AS 
   SELECT t1.Movie_ID, t1.User_ID, t1.Rating, t1.Rating_Date,
		 (1) AS Rated, (200&I.) AS Year
      FROM WORK.COMBINED_NETFLIX_DATA t1
      WHERE year(t1.Rating_Date) =200&I.;
QUIT;

data Movies_200&I.; set COMBINED_NETFLIX_200&I._RATINGS;
keep Movie_ID; run;

data Users_200&I.; set COMBINED_NETFLIX_200&I._RATINGS;
keep User_ID; run;
*J for 2 runs of the data to create enough negative values;
%do j=0 %to 1;
*Randomly sort data;
data User_Pick_200&I._&j.; set Users_200&I.; 
call streaminit(123+&j.);
Pick=rand('Uniform');
proc sort; by Pick; run;

data Movie_Pick_200&I._&j.; set Movies_200&I.; 
call streaminit(321-&j.);
Pick=rand('Uniform');
proc sort; by Pick;  run;
*Rejoin together;
data Pair_Finder_200&I._&j.; merge User_Pick_200&I._&j. Movie_Pick_200&I._&j.;
Lookup=cats(User_ID,"_",Movie_ID);
keep Movie_ID User_ID Lookup; run;
*Join to active data to check if random pick had occured;
PROC SQL;
   CREATE TABLE HAS_RATING_200&I._&j. AS 
   SELECT t1.User_ID, 
          t1.Movie_ID, 
          t1.Lookup, 
          t2.Rating
      FROM WORK.PAIR_FINDER_200&I._&j. t1
           LEFT JOIN WORK.DATA_PAIRS t2 ON (t1.Lookup = t2.Lookup);
QUIT;
*Output results that are true negative;
Data Send_Pair_200&I._&j.; set HAS_RATING_200&I._&j.; 
if rating=. then output Send_Pair_200&I._&j.;
delete; run;

%End;

Data Send_Pair_200&I._Picks; set Send_Pair_200&I._0 Send_Pair_200&I._1;
Year=200&I.; Rated=0; run;

%End;
%mend;

%MakeNegatives;
*Join all years of negatives together and then combine with true data;
data Negative_Values; set SEND_PAIR_2000_PICKS SEND_PAIR_2001_PICKS
SEND_PAIR_2002_PICKS SEND_PAIR_2003_PICKS SEND_PAIR_2004_PICKS SEND_PAIR_2005_PICKS/**/
; run;


Data Full_Data_Skeleton; Set Negative_Values DATA_PAIRS; run;
