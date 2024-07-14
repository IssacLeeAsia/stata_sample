version 18
clear all
macro drop _all
set linesize 80
set more off
capture log close

* Merge years 2007 - 2019 into one dataset

cd  "data path"

clear
local first_year = 2007
local last_year = 2019

forvalues year = `first_year'/`last_year' {
    if `year' != 2017 {
        local filename "namcs`year'_lower.dta"
        if `year' == `first_year' {
            use `filename', clear
        }
        else {
			drop catproc1
            append using `filename', force
        }
    }
}
cd "output path"

save namcs2007-2019.dta , replace
