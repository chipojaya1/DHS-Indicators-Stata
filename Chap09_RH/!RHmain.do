/*******************************************************************************************************************************
Program: 				RHmain.do
Purpose: 				Main file for the Reporductive Health Chapter. 
						The main file will call other do files that will produce the RH indicators and produce tables.
Data outputs:			coded variables and table output on screen and in excel tables.
Author: 				Shireen Assaf 
Date last modified:		Jan 9th by Shireen Assaf
Notes:					
*******************************************************************************************************************************/
set more off

*** User information for internal DHS use. Please disregard and adjust paths to your own. *** 

*local user 39585	//change employee id number to personalize path
local user 33697
cd "C:/Users//`user'//ICF/Analysis - Shared Resources/Code/DHS-Indicators-Stata/Chap09_RH"

global datapath "C:/Users//`user'//ICF/Analysis - Shared Resources/Data/DHSdata"

* select your survey

* IR Files
global irdata "AFIR70FL"
* MMIR71FL TJIR70FL UGIR60FL MWIR7HFL GHIR72FL 

* KR Files
global brdata "AFBR70FL"
* MMBR71FL TJBR70FL UGBR60FL MWBR7HFL GHBR72FL 
****************************

* IR file variables

* open dataset
use "$datapath//$irdata.dta", clear

gen file=substr("$irdata", 3, 2)

do "RH_age_period.do" 
*Purpose:	Compute the age variable and set the period for the analysis. Period currently set at 5 years.

*
do RH_ANC.do
*Purpose: 	Code ANC indicators

*
do RH_PNC.do
*Purpose: 	Code PNC indicators for mother and newborn

*
do RH_Probs.do
*Purpose: 	Code indicators for problems accessing health care 

*
do RH_tables.do
*Purpose: 	Produce tables for indicators computed from above do files. This will output 3 excel files for these indicators.
* Note:		This will drop any women not in 15-49 age range. You can change this selection. Please check the notes in the do file.

*/
*******************************************************************************************************************************
*******************************************************************************************************************************

* BR file variables

* open dataset
use "$datapath//$brdata.dta", clear

gen file=substr("$brdata", 3, 2)

do "RH_age_period.do" 
*Purpose:	Compute the age variable and set the period for the analysis. Period currently set at 5 years.

*
do RH_DEL.do
*Purpose: 	Code Delivery indicators

do RH_tables.do
*Purpose: 	Produce tables for indicators computed from above do files. This will output 2 excel files for these indicators.

*/
*******************************************************************************************************************************
*******************************************************************************************************************************

