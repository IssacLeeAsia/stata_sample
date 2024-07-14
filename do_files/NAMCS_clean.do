version 18
clear all
macro drop _all
set linesize 80
set more off
capture log close

* Verify and clean merged dataset and survey set the dataset

cd  "data path"

use "namcs2007-2019.dta"
svyset cpsum [pweight=patwt] , strata(cstratm)

*CLEAN PAYTYPER VARIABLE
gen insurance = 6
label var insurance "Source of payment"
replace insurance = 1 if paytyper==1
replace insurance = 2 if paytyper==2
replace insurance = 3 if paytyper==3
replace insurance = 4 if paytyper==4
replace insurance = 5 if paytyper==5 | paytyper==6
label define insurance_label 1 "Private Insurance" 2 "Medicare" 3 "Medicaid" 4 "Worker's Comp." 5 "Uninsured" 6 "Unknown/other"
label values insurance insurance_label
tab2 insurance paytyper

* Create age groups
* Adjust age into categorical variable per our criteria
recode age (0/49=1) (50/59=2) (60/69=3) (70/79=4) (80/max=5), gen(age_group)
label define age_group 1 " <50" 2 "50-59" 3 "60-69" 4 "70-79" 5 ">=80"
label values age_group age_group
label variable age_group "Age Group"

* Create variable for knee pain over 50

* labelbook RFVF , assess values

local values 19250 19251 19252 19253 19254 19255

foreach val in `values' {
    count if rfv1 == `val'
}

* By far most popular value appears to be 19250 "knee symptoms" and 19251 "Knee pain, ache, soreness, discomfort"
* We will use these to define our population

gen knee_pain = 0
label var knee_pain "Atraumatic Knee Pain over 50"
replace knee_pain = 1 if rfv1==19251 | rfv1==19250 // all knee pain conditions
replace knee_pain = 0 if age_group==1 | injury == 1
label define yes_no 0 "No" 1 "Yes"
label values knee_pain yes_no

* Create variable for hip pain
local valuelist 19150 19151 19152 19153 19154 19155 19156 // all possible reasons for visit regarding hip pain

foreach val in `valuelist' {
    count if rfv1 == `val'
}

gen hip_pain = 0
label var hip_pain "Atraumatic Hip Pain over 50"
replace hip_pain = 1 if rfv1==19150 | rfv1==19151
replace hip_pain = 0 if age_group==1  | injury == 1
label values hip_pain yes_no

* Relabel RACERETH

label var racereth "Race/Ethnicity"
label define race_label 1 "White" 2 "Black" 3 "Hispanic" 4 "Asian or other race"
label values racereth race_label

cd "output path"

save namcs2007-2019_clean.dta , replace
