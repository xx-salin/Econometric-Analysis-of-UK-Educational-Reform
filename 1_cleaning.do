
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Data compiling


*** cleaning each year seperately before appending together

ds
display wordcount("`r(varlist)'")


* 2011
use "/Users/samsalin/Desktop/APS 2004-2023/2011 UKDA-7059/stata/stata13/apsp_jd11_eul_pwta14.dta"
rename _all, upper
rename PWTA14 PWTA
keep AGE EVERWK INCSUP PUBLICR QUAL_9 QUAL_24 TOTUS1 BENFTS FTPT INDE07M PWTA QUAL_10 QUAL_25 UNDEMP COUNTRY GRSSWK LIMITA QRTR QUAL_13 QUAL_26 CURED8 HEALIM LIMITK QUAL_1 QUAL_14 QUAL_28 NATIDE11 DURUN2 HEALYL LKFTPA QUAL_2 QUAL_15 QUAL_29 NATIDW11 EMPLEN HEALYR MARCHK QUAL_3 QUAL_18 QUAL_31 ENROLL HOURLY MARSTA QUAL_7 QUAL_21 SEX ETH11EW ILODEFR NETWK QUAL_8 QUAL_23 THISQTR SC10MMJ
gen fileyear = 2011
save 2011a.dta, replace

* 2012
use "/Users/samsalin/Desktop/APS 2004-2023/2012 UKDA-7274/stata/stata13/apsp_jd12_eul_pwta18.dta"
rename PWTA18 PWTA
keep AGE EVERWK INCSUP PUBLICR QUAL_9 QUAL_24 TOTUS1 BENFTS FTPT INDE07M PWTA QUAL_10 QUAL_25 UNDEMP COUNTRY GRSSWK LIMITA QRTR QUAL_13 QUAL_26 CURED8 HEALIM LIMITK QUAL_1 QUAL_14 QUAL_28 NATIDE11 DURUN2 HEALYL LKFTPA QUAL_2 QUAL_15 QUAL_29 NATIDW11 EMPLEN HEALYR MARCHK QUAL_3 QUAL_18 QUAL_31 ENROLL HOURLY MARSTA QUAL_7 QUAL_21 SEX ETH11EW ILODEFR NETWK QUAL_8 QUAL_23 THISQTR SC10MMJ
gen fileyear = 2012
save 2012a.dta, replace

* 2013/15
use "/Users/samsalin/Desktop/APS 2004-2023/2013:2015 UKDA-8173/stata11/aps_3yr_jan13dec15_eul_withwellbeingvars.dta"
rename PWTA16C PWTA
keep AGE EVERWK INCSUP PUBLICR QUAL_9 QUAL_24 TOTUS1 BENFTS FTPT INDE07M PWTA QUAL_10 QUAL_25 UNDEMP COUNTRY GRSSWK LIMITA QRTR QUAL_13 QUAL_26 CURED8 HEALIM LIMITK QUAL_1 QUAL_14 QUAL_28 NATIDE11 DURUN2 HEALYL LKFTPA QUAL_2 QUAL_15 QUAL_29 NATIDW11 EMPLEN HEALYR MARCHK QUAL_3 QUAL_18 QUAL_31 ENROLL HOURLY MARSTA QUAL_7 QUAL_21 SEX ETH11EW ILODEFR NETWK QUAL_8 QUAL_23 THISQTR SC10MMJ fileyear
save 2013_15a.dta, replace

* 2016/18
use "/Users/samsalin/Desktop/APS 2004-2023/2016:2018 UKDA-8489/stata/stata11/aps_3yr_jan16dec18_eul.dta"
rename LIMACT HEALIM
rename PWTA18C PWTA
keep AGE EVERWK INCSUP PUBLICR QUAL_9 QUAL_24 TOTUS1 BENFTS FTPT INDE07M PWTA QUAL_10 QUAL_25 UNDEMP COUNTRY GRSSWK LIMITA QRTR QUAL_13 QUAL_26 CURED8 HEALIM LIMITK QUAL_1 QUAL_14 QUAL_28 NATIDE11 DURUN2 HEALYL LKFTPA QUAL_2 QUAL_15 QUAL_29 NATIDW11 EMPLEN HEALYR MARCHK QUAL_3 QUAL_18 QUAL_31 ENROLL HOURLY MARSTA QUAL_7 QUAL_21 SEX ETH11EW ILODEFR NETWK QUAL_8 QUAL_23 THISQTR SC10MMJ fileyear
save 2016_18a.dta, replace

* 2019/21
use "/Users/samsalin/Desktop/APS 2004-2023/2019:2021 UKDA-9006/stata/stata13/aps_3yr_jan19dec21_eul.dta"
rename LIMACT HEALIM
rename PWTA22C PWTA
keep AGE EVERWK INCSUP PUBLICR QUAL_9 QUAL_24 TOTUS1 BENFTS FTPT INDE07M PWTA QUAL_10 QUAL_25 UNDEMP COUNTRY GRSSWK LIMITA QRTR QUAL_13 QUAL_26 CURED8 HEALIM LIMITK QUAL_1 QUAL_14 QUAL_28 NATIDE11 DURUN2 HEALYL LKFTPA QUAL_2 QUAL_15 QUAL_29 NATIDW11 EMPLEN HEALYR MARCHK QUAL_3 QUAL_18 QUAL_31 ENROLL HOURLY MARSTA QUAL_7 QUAL_21 SEX ETH11EW ILODEFR NETWK QUAL_8 QUAL_23 THISQTR SC10MMJ fileyear
save 2019_21a.dta, replace

* 2022
use "/Users/samsalin/Desktop/APS 2004-2023/2022 UKDA-9069/stata/stata13/apsp_jd22_eul_pwta22.dta"
rename LIMACT HEALIM
rename PWTA22 PWTA
keep AGE EVERWK INCSUP PUBLICR QUAL_9 QUAL_24 TOTUS1 BENFTS FTPT INDE07M PWTA QUAL_10 QUAL_25 UNDEMP COUNTRY GRSSWK LIMITA QRTR QUAL_13 QUAL_26 CURED8 HEALIM LIMITK QUAL_1 QUAL_14 QUAL_28 NATIDE11 DURUN2 HEALYL LKFTPA QUAL_2 QUAL_15 QUAL_29 NATIDW11 EMPLEN HEALYR MARCHK QUAL_3 QUAL_18 QUAL_31 ENROLL HOURLY MARSTA QUAL_7 QUAL_21 SEX ETH11EW ILODEFR NETWK QUAL_8 QUAL_23 THISQTR SC10MMJ
gen fileyear = 2022
save 2022a.dta, replace

* 2023
use "/Users/samsalin/Desktop/APS 2004-2023/2023 UKDA-9248/stata/stata13/apsp_jd23_eul_pwta22.dta"
rename LIMACT HEALIM
rename PWTA22 PWTA
rename SC20MMJ SC10MMJ
rename QUAL21_9 QUAL_9
rename QUAL21_24 QUAL_24
rename QUAL21_10 QUAL_10
rename QUAL21_25 QUAL_25
rename QUAL21_13 QUAL_13
rename QUAL21_26 QUAL_26
rename QUAL21_1 QUAL_1
rename QUAL21_14 QUAL_14
rename QUAL21_28 QUAL_28
rename QUAL21_2 QUAL_2 
rename QUAL21_15 QUAL_15 
rename QUAL21_29 QUAL_29
rename QUAL21_3 QUAL_3 
rename QUAL21_18 QUAL_18 
rename QUAL21_31 QUAL_31
rename QUAL21_7 QUAL_7 
rename QUAL21_21 QUAL_21
rename QUAL21_8 QUAL_8 
rename QUAL21_23 QUAL_23
keep AGE EVERWK INCSUP PUBLICR QUAL_9 QUAL_24 TOTUS1 BENFTS FTPT INDE07M PWTA QUAL_10 QUAL_25 UNDEMP COUNTRY GRSSWK LIMITA QRTR QUAL_13 QUAL_26 CURED8 HEALIM LIMITK QUAL_1 QUAL_14 QUAL_28 NATIDE11 DURUN2 HEALYL LKFTPA QUAL_2 QUAL_15 QUAL_29 NATIDW11 EMPLEN HEALYR MARCHK QUAL_3 QUAL_18 QUAL_31 ENROLL HOURLY MARSTA QUAL_7 QUAL_21 SEX ETH11EW ILODEFR NETWK QUAL_8 QUAL_23 THISQTR SC10MMJ
gen fileyear = 2023
save 2023a.dta, replace


****

use /Users/samsalin/Desktop/years_a/2011a.dta, clear
append using /Users/samsalin/Desktop/years_a/2012a.dta
append using /Users/samsalin/Desktop/years_a/2013_15a.dta
append using /Users/samsalin/Desktop/years_a/2016_18a.dta
append using /Users/samsalin/Desktop/years_a/2019_21a.dta
append using /Users/samsalin/Desktop/years_a/2022a.dta
append using /Users/samsalin/Desktop/years_a/2023a.dta
save allyear_a.dta, replace




////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/// dataset 2008-2023 for parallel trends

ds
display wordcount("`r(varlist)'")


* 2010
use "/Users/samsalin/Desktop/APS 2004-2023/NA/2010 UKDA-6809/stata11/apsp_jd10_eul_inclu_smoking.dta"
rename _all, upper
rename PWTA14 PWTA
rename NATIDE NATIDE11
rename NATIDW NATIDW11
rename SC2K10MMJ SC10MMJ
keep AGE EVERWK INCSUP PUBLICR TOTUS1 BENFTS FTPT PWTA UNDEMP COUNTRY GRSSWK LIMITA QRTR CURED8 HEALIM LIMITK NATIDE11 DURUN2 HEALYL LKFTPA NATIDW11 EMPLEN HEALYR MARCHK ENROLL HOURLY MARSTA SEX ILODEFR NETWK SC10MMJ
gen fileyear = 2010
save 2010b.dta, replace



* 2009 
use "/Users/samsalin/Desktop/APS 2004-2023/NA/2009 UKDA-6514/stata11/apsp_jd09_eul.dta"
rename _all, upper
rename PWTA14 PWTA
rename NATIDE NATIDE11
rename NATIDW NATIDW11
rename SC2KMMJ SC10MMJ
keep AGE EVERWK INCSUP PUBLICR TOTUS1 BENFTS FTPT PWTA UNDEMP COUNTRY GRSSWK LIMITA QRTR CURED8 HEALIM LIMITK NATIDE11 DURUN2 HEALYL LKFTPA NATIDW11 EMPLEN HEALYR MARCHK ENROLL HOURLY MARSTA SEX ILODEFR NETWK SC10MMJ
gen fileyear = 2009
save 2009b.dta, replace

* 2008
use "/Users/samsalin/Desktop/APS 2004-2023/NA/2008 UKDA-6280/stata11/apsp_jd08_eul.dta"
rename _all, upper
rename PWTA14 PWTA
rename NATIDE NATIDE11
rename NATIDW NATIDW11
rename SC2KMMJ SC10MMJ
keep AGE EVERWK INCSUP PUBLICR TOTUS1 BENFTS FTPT PWTA UNDEMP COUNTRY GRSSWK LIMITA QRTR CURED8 HEALIM LIMITK NATIDE11 DURUN2 HEALYL LKFTPA NATIDW11 EMPLEN HEALYR MARCHK ENROLL HOURLY MARSTA SEX ILODEFR NETWK SC10MMJ
gen fileyear = 2008
save 2008b.dta, replace

* 2007
use "/Users/samsalin/Desktop/APS 2004-2023/NA/2007 UKDA-5989/stata11/apsp_jd07_eul.dta"
rename _all, upper
rename PWTA14 PWTA
rename NATIDE NATIDE11
rename NATIDW NATIDW11
rename SC2KMMJ SC10MMJ
rename CURED CURED8
keep AGE EVERWK INCSUP PUBLICR TOTUS1 BENFTS FTPT PWTA UNDEMP COUNTRY GRSSWK LIMITA QRTR CURED8 HEALIM LIMITK NATIDE11 DURUN2 HEALYL LKFTPA NATIDW11 EMPLEN HEALYR MARCHK ENROLL HOURLY MARSTA SEX ILODEFR NETWK SC10MMJ
gen fileyear = 2007
save 2007b.dta, replace

* 2006 
use "/Users/samsalin/Desktop/APS 2004-2023/NA/2006 UKDA-5685/stata11/apsp_jd06_eul.dta"
rename _all, upper
rename PWTA14 PWTA
rename NATIDE NATIDE11
rename NATIDW NATIDW11
rename SC2KMMJ SC10MMJ
rename CURED CURED8
keep AGE EVERWK INCSUP PUBLICR TOTUS1 BENFTS FTPT PWTA UNDEMP COUNTRY GRSSWK LIMITA QRTR CURED8 HEALIM LIMITK NATIDE11 DURUN2 HEALYL LKFTPA NATIDW11 EMPLEN HEALYR MARCHK ENROLL HOURLY MARSTA SEX ILODEFR NETWK SC10MMJ
gen fileyear = 2006
save 2006b.dta, replace

* 2005
use "/Users/samsalin/Desktop/APS 2004-2023/NA/2005 UKDA-5395/stata11/apsp_jd05_eul.dta"
rename _all, upper
rename PWAPSA14 PWTA
rename NATIDE NATIDE11
rename NATIDW NATIDW11
rename SC2KMMJ SC10MMJ
rename CURED CURED8
keep AGE EVERWK INCSUP PUBLICR TOTUS1 BENFTS FTPT PWTA UNDEMP COUNTRY GRSSWK LIMITA QRTR CURED8 HEALIM LIMITK NATIDE11 DURUN2 HEALYL LKFTPA NATIDW11 EMPLEN HEALYR MARCHK ENROLL HOURLY MARSTA SEX ILODEFR NETWK SC10MMJ
gen fileyear = 2005
save 2005b.dta, replace

* 2004
use "/Users/samsalin/Desktop/APS 2004-2023/NA/2004 UKDA-5334/stata11/apsp_jd04_eul.dta"
rename _all, upper
rename PWAPSA14 PWTA
rename NATIDE NATIDE11
rename NATIDW NATIDW11
rename SC2KMMJ SC10MMJ
rename CURED CURED8
rename MARSTT MARSTA
keep AGE EVERWK INCSUP PUBLICR TOTUS1 BENFTS FTPT PWTA UNDEMP COUNTRY GRSSWK LIMITA QRTR CURED8 HEALIM LIMITK NATIDE11 DURUN2 HEALYL LKFTPA NATIDW11 EMPLEN HEALYR MARCHK ENROLL HOURLY MARSTA SEX ILODEFR NETWK SC10MMJ
gen fileyear = 2004
save 2004b.dta, replace

* 2011-2023
use "/Users/samsalin/Desktop/Final_Datasets/allyear_a.dta"
keep AGE EVERWK INCSUP PUBLICR TOTUS1 BENFTS FTPT PWTA UNDEMP COUNTRY GRSSWK LIMITA QRTR CURED8 HEALIM LIMITK NATIDE11 DURUN2 HEALYL LKFTPA NATIDW11 EMPLEN HEALYR MARCHK ENROLL HOURLY MARSTA SEX ILODEFR NETWK SC10MMJ fileyear
save 2011_23b.dta, replace

****

use /Users/samsalin/Desktop/years_b/2004b.dta, clear
append using /Users/samsalin/Desktop/years_b/2005b.dta
append using /Users/samsalin/Desktop/years_b/2006b.dta
append using /Users/samsalin/Desktop/years_b/2007b.dta
append using /Users/samsalin/Desktop/years_b/2008b.dta
append using /Users/samsalin/Desktop/years_b/2009b.dta
append using /Users/samsalin/Desktop/years_b/2010b.dta
append using /Users/samsalin/Desktop/years_b/2011_23b.dta
save allyear_b.dta, replace


use "/Users/samsalin/Desktop/Final_Datasets/allyear_a.dta"

* log gross weekly income 
gen ln_GRSSWK = log(GRSSWK)

* gen unemployment 
gen UNEMP = (ILODEFR == 2) if ILODEFR > 0
label variable UNEMP "Unemployment Indicator (1 = Unemployed, 0 = Employed)"
label define unemploy_lbl 0 "Employed" 1 "Unemployed"
label values UNEMP unemploy_lbl

* marital status binary
gen MARRIED = .
replace MARRIED = 1 if MARCHK == 1
replace MARRIED = 0 if inlist(MARCHK, 2, -9)
drop MARSTA


* gen variables for DiD


gen post2013 = (fileyear >= 2013)
label variable post2013 "Post-2013 Reform Indicator (1 = 2013 and later, 0 = Before 2013)"

gen post2015 = (fileyear >= 2015)
label variable post2015 "Post-2015 Reform Indicator (1 = 2015 and later, 0 = Before 2015)"



** drop irrelevant countries 


replace COUNTRY = (COUNTRY == 1)
label define countrylbl 0 "Other" 1 "England"
label values COUNTRY countrylbl


* drop missing values
drop if missing(UNEMP)
drop if missing(ln_GRSSWK) & UNEMP == 0







// for 2011-2023 only 
* grouping edu (as ordered categorical)
gen below_lower_secondary = (QUAL_28 == 1 | QUAL_29 == 1)
gen lower_secondary = (QUAL_21 == 1 | QUAL_14 == 1 | QUAL_15 == 1 | QUAL_26 == 1)
gen upper_secondary = (QUAL_10 == 1 | QUAL_13 == 1 | QUAL_18 == 1 | QUAL_23 == 1 | QUAL_31 == 1 | QUAL_24 == 1 | QUAL_25 == 1)
gen undergraduate = (QUAL_1 == 1 | QUAL_2 == 1 | QUAL_3 == 1 | QUAL_9 == 1 | QUAL_7 == 1 | QUAL_8 == 1)

gen edu = .

replace edu = 0 if below_lower_secondary == 1
replace edu = 1 if lower_secondary == 1
replace edu = 2 if upper_secondary == 1
replace edu = 3 if undergraduate == 1

label define edu_labels 0 "Below Lower Secondary" 1 "Lower Secondary" 2 "Upper Secondary" 3 "Undergraduate"
label values edu edu_labels

//


save allyear_a.dta, replace


use "/Users/samsalin/Desktop/Final_Datasets/allyear_b.dta"

* log gross weekly income 
gen ln_GRSSWK = log(GRSSWK)

* gen unemployment 
gen UNEMP = (ILODEFR == 2) if ILODEFR > 0
label variable UNEMP "Unemployment Indicator (1 = Unemployed, 0 = Employed)"
label define unemploy_lbl 0 "Employed" 1 "Unemployed"
label values UNEMP unemploy_lbl

* marital status binary
gen MARRIED = .
replace MARRIED = 1 if MARCHK == 1
replace MARRIED = 0 if inlist(MARCHK, 2, -9)
drop MARSTA


* gen variables for DiD


gen post2013 = (fileyear >= 2013)
label variable post2013 "Post-2013 Reform Indicator (1 = 2013 and later, 0 = Before 2013)"

gen post2015 = (fileyear >= 2015)
label variable post2015 "Post-2015 Reform Indicator (1 = 2015 and later, 0 = Before 2015)"



** drop irrelevant countries 


replace COUNTRY = (COUNTRY == 1)
label define countrylbl 0 "Other" 1 "England"
label values COUNTRY countrylbl


* drop missing values
drop if missing(UNEMP)
drop if missing(ln_GRSSWK) & UNEMP == 0

save allyear_b.dta, replace





* one dataset
use "/Users/samsalin/Desktop/Final_Datasets/allyear_b.dta"
keep if fileyear < 2011
save allyear_2004_2010.dta, replace

use "/Users/samsalin/Desktop/datasets/allyear_a.dta", clear
append using /Users/samsalin/Desktop/allyear_2004_2010.dta
save allyear4.dta, replace




use "/Users/samsalin/Desktop/datasets/allyear4.dta", clear

drop QUAL_* lower_secondary undergraduate upper_secondary below_lower_secondary MARCHK ILODEFR
drop treat post2013 post2015 THISQTR QRTR PWTA
drop NETWK CURED8 UNDEMP LIMITA INCSUP HOURLY HEALIM HEALYL HEALYR EVERWK EMPLEN DURUN2



set seed 331


////////////////////////////////////

* benefits 
replace BENFTS = (BENFTS == 1)
label define benftslbl 0 "no" 1 "yes"
label values BENFTS benftslbl

* enroll 
replace ENROLL = (ENROLL == 1)
label define ENROLLlbl 0 "no" 1 "yes"
label values ENROLL ENROLLlbl


* birthyear
gen birthyear = fileyear - AGE



save allyear4_cleaned.dta, replace






