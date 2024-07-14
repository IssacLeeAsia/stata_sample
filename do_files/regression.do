* cd "dataset/path"

cd  "/Users/martinchin/Library/CloudStorage/OneDrive-NYULangoneHealth/RA_langone/health_utility_study"

use "data/namcs2007-2019_clean.dta", clear

set showbaselevels on

* using weights

svyset cpsum [pweight=patwt] , strata(cstratm)

* define variables of interests
local regress_vars_mri i.sex i.age_group i.racereth i.insurance i.speccat i.msa

local regress_vars_xray i.sex i.age_group i.racereth i.insurance i.speccat i.msa
* svy, subpop(if knee_pain==1): logistic mri `regress_vars' 


* svy, subpop(if hip_pain==1): logistic mri `regress_vars' 

* creating regression tables for MRI

* hip pain losigtic regression results, using survey weights 
* output rtf tables (with odds ratios) 
eststo clear

eststo hip_pain_mri, title ("hip pain"): svy, subpop(if hip_pain==1): logistic mri `regress_vars_mri'

esttab using "tables_n_figures/regression_hip_pain_mri.rtf", ///
	refcat(1.sex {Sex} 2.age_group {Age} 1.racereth {Race} 1.insurance {Insurance} 1.speccat {Specialty} 1.msa {MSA} 0.xray {X-ray}, nolabel)  ///
	cells("b(fmt(3)) ci(fmt(3) par) p(fmt(3))") ///
	gaps lines collabels(OR CI p) /// 
	title(Table 1. Odds ratios) eqlabel(none) ///
	se mtitles eform nonumber label replace
	

* knee pain losigtic regression results, using survey weights 
* output rtf tables (with odds ratios) 
eststo clear

eststo knee_pain_mri, title ("knee pain"): svy, subpop(if knee_pain==1): logistic mri `regress_vars_mri'

esttab using "tables_n_figures/regression_knee_pain_mri.rtf", ///
	refcat(1.sex {Sex} 2.age_group {Age} 1.racereth {Race} 1.insurance {Insurance} 1.speccat {Specialty} 1.msa {MSA} 0.xray {X-ray}, nolabel)  ///
	cells("b(fmt(3)) ci(fmt(3) par) p(fmt(3))") ///
	gaps lines collabels(OR CI p) /// 
	title(Table 1. Odds ratios) eqlabel(none) ///
	se mtitles eform nonumber label replace

* creating regression tables for X-Ray	
	
* hip pain results 
eststo clear

eststo hip_pain_xray, title ("hip pain"): svy, subpop(if hip_pain==1): logistic xray `regress_vars_xray'

esttab using "tables_n_figures/regression_hip_pain_xray.rtf", ///
	refcat(1.sex {Sex} 2.age_group {Age} 1.racereth {Race} 1.insurance {Insurance} 1.speccat {Specialty} 1.msa {MSA} 0.xray {X-ray}, nolabel)  ///
	cells("b(fmt(3)) ci(fmt(3) par) p(fmt(3))") ///
	gaps lines collabels(OR CI p) /// 
	title(Table 1. Odds ratios) eqlabel(none) ///
	se mtitles eform nonumber label replace
	
	
* knee pain results
eststo clear

eststo knee_pain_xray, title ("knee pain"): svy, subpop(if knee_pain==1): logistic xray `regress_vars_xray'

esttab using "tables_n_figures/regression_knee_pain_xray.rtf", ///
	refcat(1.sex {Sex} 2.age_group {Age} 1.racereth {Race} 1.insurance {Insurance} 1.speccat {Specialty} 1.msa {MSA} 0.xray {X-ray}, nolabel)  ///
	cells("b(fmt(3)) ci(fmt(3) par) p(fmt(3))") ///
	gaps lines collabels(OR CI p) /// 
	title(Table 1. Odds ratios) eqlabel(none) ///
	se mtitles eform nonumber label replace
