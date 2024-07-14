version 18
clear all
macro drop _all
set linesize 80
set more off
capture log close

* Merge datasets for years 2007-2018
* Data for 2017 is missing
* Variable [region] is missing for 2018 and 2019

* Change to NAMCS directory
cd "data path"

clear

* Set up locals for looping through individual year datasets
local first_year = 2007
local last_year = 2019

* Convert all variable names to lower case
forvalues year = `first_year'/`last_year' {
    if `year' != 2017 {
        local filename "namcs`year'"
        use "`filename'.dta", clear
        // Convert variable names to lowercase
        capture rename * , lower
		
            }
        save "`filename'_lower.dta", replace
    }

	
* Change to .do files directory
cd ".do files path"

* Clean individual year datasets
do NAMCS_clean_year_vars

* below are codes to test if we include all variables of interest

* Change to NAMCS directory
// cd  "data path"

* Check that all years contain variables of interest and are labeled the same

* Set local for required variables
// local required_vars npnmw age ager sex racereth paytyper major anyimage mri xray primcare speccat cpsum patwt cstratm rfv1 rfv1 rfv3 rfv13d rfv23d rfv33d msa
//
// forvalues year = `first_year'/`last_year' {
//     if `year' != 2017 {
//         local filename "namcs`year'"
//         use "`filename'_lower.dta", clear
//         codebook `required_vars'
//     }
// }
