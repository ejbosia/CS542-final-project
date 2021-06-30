libname Data 'C:\Users\bobby\Documents\From Laptop\CS542\Project\Data'; run;

Data work.who_rated_what_2006;
infile 'C:\Users\bobby\Documents\From Laptop\CS542\Project\Data\who_rated_what_2006.txt'
delimiter=','; Input User_ID Movie_ID; run;

Data work.who_rated_what_2006_ans;
infile 'C:\Users\bobby\Documents\From Laptop\CS542\Project\Data\who_rated_what_2006_ans.txt'
delimiter=','; Input User_ID Movie_ID Rating; run;
*Data is set oddly so had to do some manipulation to get movie id in the right spot and carry it down
Also need to set the time information in the right way
This is with the slight change from the instructions page to the data. Is easier in SAS EG but not as many people use that;
Data combined_data_1;
infile 'C:\Users\bobby\Documents\From Laptop\CS542\Project\Data\combined_data_1.txt'
delimiter=','; Input F1 $ F2 $ F3 $10.; run;

data combined_data_1_set; set work.combined_data_1;
retain Movie_ID; if F2=input(F2,8.)=. and F3=input(F3,8.)=. then Movie_ID=input(F1,8.);
User_ID=input(F1,8.); Rating=input(F2,1.); 
Rating_Date=mdy(input(substr(F3,6,2),8.),input(substr(F3,9,2),8.),input(substr(F3,1,4),8.));
keep Movie_ID User_ID Rating Rating_Date;
format Rating_Date MMDDYY10.; run;

Data combined_data_2;
infile 'C:\Users\bobby\Documents\From Laptop\CS542\Project\Data\combined_data_2.txt'
delimiter=','; Input F1 $ F2 $ F3 $10.; run;

data combined_data_2_set; set work.combined_data_2;
retain Movie_ID; if F2=input(F2,8.)=. and F3=input(F3,8.)=. then Movie_ID=input(F1,8.);
User_ID=input(F1,8.); Rating=input(F2,1.); 
Rating_Date=mdy(input(substr(F3,6,2),8.),input(substr(F3,9,2),8.),input(substr(F3,1,4),8.));
keep Movie_ID User_ID Rating Rating_Date;
format Rating_Date MMDDYY10.; run;

Data combined_data_3;
infile 'C:\Users\bobby\Documents\From Laptop\CS542\Project\Data\combined_data_3.txt'
delimiter=','; Input F1 $ F2 $ F3 $10.; run;

data combined_data_3_set; set work.combined_data_3;
retain Movie_ID; if F2=input(F2,8.)=. and F3=input(F3,8.)=. then Movie_ID=input(F1,8.);
User_ID=input(F1,8.); Rating=input(F2,1.); 
Rating_Date=mdy(input(substr(F3,6,2),8.),input(substr(F3,9,2),8.),input(substr(F3,1,4),8.));
keep Movie_ID User_ID Rating Rating_Date;
format Rating_Date MMDDYY10.; run;

Data combined_data_4;
infile 'C:\Users\bobby\Documents\From Laptop\CS542\Project\Data\combined_data_4.txt'
delimiter=','; Input F1 $ F2 $ F3 $10.; run;

data combined_data_4_set; set work.combined_data_4;
retain Movie_ID; if F2=input(F2,8.)=. and F3=input(F3,8.)=. then Movie_ID=input(F1,8.);
User_ID=input(F1,8.); Rating=input(F2,1.); 
Rating_Date=mdy(input(substr(F3,6,2),8.),input(substr(F3,9,2),8.),input(substr(F3,1,4),8.));
keep Movie_ID User_ID Rating Rating_Date;
format Rating_Date MMDDYY10.; run;

data Combined_Netflix_Data; 
set combined_data_1_set combined_data_2_set combined_data_3_set combined_data_4_set;
if Rating ne .; run;

*Set in movies, has a lot of commas in titles so had to pull it back;
PROC IMPORT OUT= WORK.MOVIE_TITLES 
            DATAFILE= "C:\Users\bobby\Documents\From Laptop\CS542\Project\Data\movie_titles.csv" 
            DBMS=CSV REPLACE; GUESSINGROWS=17700; GETNAMES=NO; DATAROW=1 ; 
RUN;

data Movie_Titles_Named; set MOVIE_TITLES;
Movie_ID=VAR1; Release_Year=VAR2;
Movie_Name=ifc(VAR4="",VAR3,ifc(VAR5="",cats(VAR3,",",VAR4),ifc(VAR6="",cats(VAR3,",",VAR4,",",VAR5),
cats(VAR3,",",VAR4,",",VAR5,",",VAR6))));
drop VAR1 VAR2 VAR3 VAR4 VAR5 VAR6; run;
