clear all
macro drop _all
set linesize 80
set more off
capture log close

* Change to NAMCS directory
cd  "data path"

* In 2007 and 2008, race/ethnicity was alised as "racereth." We rename this variable with the name of race/ethnicity in following years.

* Create racereth variable for 2007 and 2008

use namcs2007_lower.dta

* Rename paytype to paytyper
capture rename paytype paytyper

* Create a new variable racereth based on raceeth
capture gen racereth = raceeth

* Consolidate categories 4-7 into category 4
replace racereth = 4 if raceeth >= 4 & raceeth <= 7

save namcs2007_lower.dta , replace

use namcs2008_lower.dta

* Create a new variable racereth based on raceeth
capture gen racereth = raceeth

* Consolidate categories 4-7 into category 4
replace racereth = 4 if raceeth >= 4 & raceeth <= 7

save namcs2008_lower.dta , replace


* Based on the NAMCS codebook file, we know the "region" variable was named "regionoff" from 2012 to 2016
* Rename regionoff to region for affected years 2012-2016

local f_year = 2012
local l_year = 2016

forvalues year = `f_year'/`l_year' {
    local filename "namcs`year'_lower.dta"
    use "`filename'", clear
    capture rename regionoff region
    save "`filename'", replace
}




