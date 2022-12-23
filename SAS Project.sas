/*import data */
proc import datafile="/home/epolver/EPG194/data/NEXTGENSTATS (5).xlsx" dbms=xlsx
	out = nextgenstats replace;
run;





/* Accessing Data*/
/*This data comes from nextgenstats.nfl.com. I accessed this data as
I have been curious to learn if there's been a noteable difference
in the QB's style and tendencies over the past several years. */

/* Exploring/Validating Data*/
/*While there is a plethora of great data in from this website, 
I'm mainly concerned with the tracking data. First, because the sample
for each season isn't quite large, I decided to take all data from the
tracking numbers were recorded. After that, I had to determine which 
variables to keep. */

/* proc print dataset */
proc print data=nextgenstats;
run;


/*Preparing Data */
/* First, I dropped all variables that weren't relevant to this study.
So basic statistics like attempts and touchdowns were removed. Even though
it would've be interesting to examine how teams and QBs differ in their
techniques and tendencies, I felt like it would lead to a small sample and
I was even able to get the names from the website, so I removed the teams
column. Lastly, with 10 measurements of advanced tackings, I felt like
I could narrow down the options as some stats either helped captured what
the other stats were doing and some felt they weren't really going to be
relevant to my study. That left me with six variables: year, tt, ayd, agg,
ayts and cpae. Since the dataset was very clean, there were only simple changes
that needed to be made. I used the data command to create a new dataset,
 I used the keep function to select the variables needed for this study,
and I converted the year from numeric to character, as it's being used as a
class variable and wouldn't make sense to be numeric.*/
data ngs;
	set nextgenstats;
	keep YEAR TT CAY IAY AGG AYTS CPAE;
	character = input(YEAR, best5.);
run;




/* use proc print to observe first 20 observations*/
proc print data=ngs(obs=20);
run;

/* use proc contents to check data is correct */
proc contents data=ngs;
run;

/*Analyzing and Reporting Data*/
/* My question of interest is whether QB styles and tendencies changed 
throughout the last several years. I'll start with an exploratory analysis
where I'll look at summary statistics and plots to get an idea of what
the data illustrates. Then, I perform an ANOVA test on each variable by year
to determine changes, if any, in the way QB's and offenses perform.  */



ods graphics on;
ods noproctitle;

ods rtf file="/home/epolver/EPG194/output/stats_by_year.rtf" style=FestivalPrinter;
/*Analyzing and Reporting Data*/
/*I used summary statistics including mean, median, min, max and 
standard deviation to notice any patterns in the data.
Next, I created boxplots to visualize the data. Then, I created QQ plots
to test for normality before perofrming ANOVA tests.*/
title "Average Time to Throw Summary Statistics By Year";

/*use proc means to get summary stats on each variable to be tested, by year,
and create labels*/
proc means data=ngs mean median min max std;
 var TT;
	class YEAR;
		label TT="Time to Throw" 
;
footnote "Data from completed seasons and when data was first tracked";
run;


title "Average Completed Air Yards Summary Statistics By Year";
proc means data=ngs mean median min max std;
 var CAY;
	class YEAR;
		label CAY="Completed Air Yards" 
;
footnote "Data from completed seasons and when data was first tracked";
run;

title "Average Intended Air Yards Summary Statistics By Year";
proc means data=ngs mean median min max std;
 var IAY;
	class YEAR;
		label IAY="Intended Air Yards" 
;
footnote "Data from completed seasons and when data was first tracked";
run;

title "Aggressivness Percentage Summary Statistics By Year";
proc means data=ngs mean median min max std;
 var AGG;
	class YEAR;
		label AGG="Aggressiveness"

;
footnote "Data from completed seasons and when data was first tracked";
run;

title "Air Yards to the Sticks Summary Statistics By Year";
proc means data=ngs mean median min max std;
 var AYTS;
	class YEAR;
		label AYTS="Air Yards to the Sticks"

;
footnote "Data from completed seasons and when data was first tracked";
run;



title "Completion % Above Expectation Summary Statistics By Year";
proc means data=ngs mean median min max std;
 var CPAE;
	class YEAR;
		label CPAE="Completion % Above Expectation"
;
footnote "Data from completed seasons and when data was first tracked";
run;





/* Use sgplot to create boxplots of each variable by year and add labels*/
proc sgplot data=ngs;
	HBOX TT / category=YEAR;
	TITLE 'Average Time to Throw By Year';
	label TT='Time to Throw';
run;


proc sgplot data=ngs;
	HBOX CAY / category=YEAR;
	TITLE 'Average Completed Air Yards By Year';
	label CAY='Average Completed Air Yards';
run;

proc sgplot data=ngs;
	HBOX IAY / category=YEAR;
	TITLE 'Average Intended Air Yards By Year';
	label CAY='Average Intended Air Yards';
run;

proc sgplot data=ngs;
	HBOX AGG / category=YEAR;
	TITLE 'Aggresiveness Percentage By Year';
	label AGG='Aggresiveness Percentage';
run;

proc sgplot data=ngs;
	HBOX AYTS / category=YEAR;
	TITLE 'Average Air Yards to the Sticks By Year';
	label TT='Time to Throw';
run;


proc sgplot data=ngs;
	HBOX CPAE / category=YEAR;
	TITLE 'Average Completion Percentage Above Expectation By Year';
	label CPAE='Completion Percentage Above Expectation';
run;

/* Create QQ plots to test for normality for ANOVA test*/
proc univariate normal plot data=ngs; VAR TT;
run;

proc univariate normal plot data=ngs; VAR CAY;
run;

proc univariate normal plot data=ngs; VAR IAY;
run;

proc univariate normal plot data=ngs; VAR AGG;
run;

proc univariate normal plot data=ngs; VAR AYTS;
run;

proc univariate normal plot data=ngs; VAR CPAE;
run;


/* Perform ANOVA test using proc glm and data from ngs, for each variable and
year as the class. Add tukey for Tukey HSD table.*/
proc glm data=ngs;
	class YEAR;
	model TT = YEAR;
	lsmeans YEAR / adjust=tukey;
	title "ANOVA Test For Time to Throw Differences By Year";
run;

proc glm data=ngs;
	class YEAR;
	model CAY = YEAR;
	lsmeans YEAR / adjust=tukey;
	title "ANOVA Test For Completed Air Yards By Year";
run;

proc glm data=ngs;
	class YEAR;
	model IAY = YEAR;
	lsmeans YEAR / adjust=tukey;
	title "ANOVA Test Average Intended Air Yards Differences By Year";
run;

proc glm data=ngs;
	class YEAR;
	model AGG = YEAR;
	lsmeans YEAR / adjust=tukey;
	title "ANOVA Test For Aggressiveness Average Differences By Year";
run;

proc glm data=ngs;
	class YEAR;
	model AYTS = YEAR;
	lsmeans YEAR / adjust=tukey;
	title "ANOVA Test For Air Yards to Sticks Differences By Year";
run;

proc glm data=ngs;
	class YEAR;
	model CPAE = YEAR;
	lsmeans YEAR / adjust=tukey;
	title "ANOVA Test For Completion Percentage Above Expectation Differences By Year";
run;

/* I exported the results through the ods rtf code you suggested. This worked
perfectly and I was able to export the output to word. */


ods rtf close;



