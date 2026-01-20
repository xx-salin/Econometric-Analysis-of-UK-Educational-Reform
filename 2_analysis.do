******************************** ASSUMPTIONS

///////////////////// Parallel trends

use "/Users/samsalin/Desktop/dataset/allyear4_cleaned.dta" 


********* Initial Tests for DiD


/// Spillover Effects 

keep if (COUNTRY == 1 & NATIDE11 == 1) | (COUNTRY == 0 & NATIDE11 != 1)



/////
* parallel trends ln_GRSSWK 2013
preserve 

keep if fileyear <= 2012

foreach y of numlist 2005/2012 {
    gen yeardum`y' = (fileyear == `y')
}

foreach y of numlist 2005/2012 {
    gen int_treat_`y' = COUNTRY * yeardum`y'
}

reg ln_GRSSWK int_treat_2005-int_treat_2012, robust
test int_treat_2005 int_treat_2006 int_treat_2007 int_treat_2008 int_treat_2009 int_treat_2010 int_treat_2011 int_treat_2012

reg ln_GRSSWK int_treat_2005-int_treat_2012 AGE SEX MARRIED i.fileyear i.COUNTRY, robust
test int_treat_2005 int_treat_2006 int_treat_2007 int_treat_2008 int_treat_2009 int_treat_2010 int_treat_2011 int_treat_2012




gen year = .
gen coef = .
gen lb = .
gen ub = .
local i = 1

foreach y of numlist 2005/2012 {
    replace year = `y' in `i'
    quietly reg ln_GRSSWK int_treat_2005-int_treat_2012 AGE SEX MARRIED, robust
    matrix b = e(b)
    matrix V = e(V)
    local coef = b[1,"int_treat_`y'"]
    local se = sqrt(V["int_treat_`y'","int_treat_`y'"])
    replace coef = `coef' in `i'
    replace lb = `coef' - 1.96*`se' in `i'
    replace ub = `coef' + 1.96*`se' in `i'
    local ++i
}

twoway (line coef year, sort lwidth(medthick)) (rarea ub lb year, sort color(gs12)) , yline(0, lpattern(dash))  title("Pre-Treatment Parallel Trends Test: ln_GRSSWK") xtitle("Year") ytitle("Effect on ln(GRSSWK)")



collapse (mean) ln_GRSSWK, by(fileyear COUNTRY)

label define countrylbl 0 "Control" 1 "England"
label values COUNTRY countrylbl

twoway (line ln_GRSSWK fileyear if COUNTRY==1, lcolor(blue) lpattern(solid)) (line ln_GRSSWK fileyear if COUNTRY==0, lcolor(red) lpattern(dash)), title("Log Earnings by Year: England vs Control") xtitle("Year") ytitle("Mean ln(GRSSWK)") legend(order(1 "England" 2 "Control"))


restore 



/////
* parallel trends UNEMP 2013

preserve 
keep if fileyear <= 2012

foreach y of numlist 2005/2012 {
    gen yeardum`y' = (fileyear == `y')
}


foreach y of numlist 2005/2012 {
    gen int_treat_`y' = COUNTRY * yeardum`y'
}

reg UNEMP int_treat_2005-int_treat_2012, robust
test int_treat_2005 int_treat_2006 int_treat_2007 int_treat_2008 int_treat_2009 int_treat_2010 int_treat_2011 int_treat_2012

reg UNEMP int_treat_2005-int_treat_2012 AGE SEX MARRIED i.fileyear i.COUNTRY, robust
test int_treat_2005 int_treat_2006 int_treat_2007 int_treat_2008 int_treat_2009 int_treat_2010 int_treat_2011 int_treat_2012

gen year = .
gen coef = .
gen lb = .
gen ub = .
local i = 1

foreach y of numlist 2005/2012 {
    replace year = `y' in `i'
    quietly reg UNEMP int_treat_2005-int_treat_2012 AGE SEX MARRIED, robust
    matrix b = e(b)
    matrix V = e(V)
    local coef = b[1,"int_treat_`y'"]
    local se = sqrt(V["int_treat_`y'","int_treat_`y'"])
    replace coef = `coef' in `i'
    replace lb = `coef' - 1.96*`se' in `i'
    replace ub = `coef' + 1.96*`se' in `i'
    local ++i
}

twoway (line coef year, sort lwidth(medthick)) (rarea ub lb year, sort color(gs12)) , yline(0, lpattern(dash)) title("Pre-Treatment Parallel Trends: UNEMP") xtitle("Year") ytitle("Effect on Unemployment (LPM)") 


collapse (mean) UNEMP, by(fileyear COUNTRY)

label define countrylbl 0 "Control" 1 "England"
label values COUNTRY countrylbl

twoway (line UNEMP fileyear if COUNTRY==1, lcolor(blue) lpattern(solid)) (line UNEMP fileyear if COUNTRY==0, lcolor(red) lpattern(dash)) , title("Unemployment Rate by Year: England vs Wales") xtitle("Year") ytitle("Mean Unemployment Rate") legend(order(1 "England" 2 "Control"))

restore












/////*** Matching Model Assumptions 

/// Selection on Observables 

* covariate choices     watch out for (post treatment bias)
birthyear SEX MARRIED 
LIMITK BENFTS

edu ENROLL 
FTPT INDE07M SC10MMJ PUBLICR 


* covariate balance check
ssc install psmatch2, replace
ssc install pstest, replace


gen treated = (birthyear >= 1997 & COUNTRY == 1 & fileyear >= 2013)
label define treatedlbl 0 "Control" 1 "Treated"
label values treated treatedlbl


psmatch2 treated (AGE SEX MARRIED LIMITK BENFTS), outcome(ln_GRSSWK) neighbor(1) caliper(0.05) noreplacement
pstest AGE SEX MARRIED LIMITK BENFTS, both graph

psmatch2 treated (AGE SEX MARRIED LIMITK BENFTS), outcome(UNEMP) neighbor(1) caliper(0.05) noreplacement
pstest AGE SEX MARRIED LIMITK BENFTS, both graph





/// Overlap / Common Support (of propensity scores)

logit treated AGE SEX MARRIED LIMITK BENFTS
predict pscore

twoway (kdensity pscore if treated == 1, lcolor(blue)) (kdensity pscore if treated == 0, lcolor(red)), legend(label(1 "Treated") label(2 "Control")) title("Propensity Score Distribution: Common Support Check")  xtitle("Propensity Score") ytitle("Density")

histogram pscore, by(treated) percent

sum pscore if treated == 1
sum pscore if treated == 0






//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////







*use "/Users/samsalin/Desktop/dataset/allyear4_cleaned.dta"



/// Spillover

keep if (COUNTRY == 1 & NATIDE11 == 1) | (COUNTRY == 0 & NATIDE11 != 1)



*for models, not initial parallel trends tests
keep if birthyear >= 1990 & birthyear <= 2005

save allyear5_cleaned.dta



* summary statistics table
ssc install estout, replace

gen treated = (birthyear >= 1997 & COUNTRY == 1 & fileyear >= 2013)
label define treatedlbl 0 "Control" 1 "Treated"
label values treated treatedlbl

estpost summarize ln_GRSSWK UNEMP COUNTRY treated birthyear fileyear AGE SEX MARRIED NATIDE11 LIMITK BENFTS FTPT INDE07M SC10MMJ GRSSWK ENROLL edu

esttab using "summary_stats.rtf", cells("mean(fmt(2)) sd(fmt(2)) min max") replace title("Summary Statistics")

estpost summarize ln_GRSSWK UNEMP COUNTRY treated birthyear fileyear AGE SEX MARRIED NATIDE11 LIMITK BENFTS FTPT INDE07M SC10MMJ GRSSWK ENROLL edu

esttab using "variable labels.rtf", cells("label mean") label replace title("Variable Labels")









*use "/Users/samsalin/Desktop/datasets/allyear5_cleaned.dta", clear


///// Matching Model

gen treated = (birthyear >= 1997 & COUNTRY == 1 & fileyear >= 2013)
label define treatedlbl 0 "Control" 1 "Treated"
label values treated treatedlbl


* overlap / common support 
logit treated AGE SEX MARRIED LIMITK BENFTS
predict pscore

histogram pscore, by(treated) percent

twoway (kdensity pscore if treated == 1, lcolor(blue)) (kdensity pscore if treated == 0, lcolor(red)), legend(label(1 "Treated") label(2 "Control")) title("Propensity Score Distribution: Common Support Check")  xtitle("Propensity Score") ytitle("Density")


sum pscore if treated == 1
sum pscore if treated == 0


* matched sample generation

psmatch2 treated (AGE SEX MARRIED LIMITK BENFTS), outcome(ln_GRSSWK) neighbor(1) caliper(0.05) noreplacement
pstest AGE SEX MARRIED LIMITK BENFTS, both graph

gen matched_wage = (_weight > 0)  
keep if matched_wage == 1
tabulate _weight if treated == 0



psmatch2 treated (AGE SEX MARRIED LIMITK BENFTS), outcome(UNEMP) neighbor(1) caliper(0.05) noreplacement
pstest AGE SEX MARRIED LIMITK BENFTS, both graph

gen matched_unemp = (_weight > 0)  
keep if matched_unemp == 1
tabulate _weight if treated == 0


* ATT estimation 

psmatch2 treated (AGE SEX MARRIED LIMITK BENFTS), outcome(ln_GRSSWK) neighbor(1) caliper(0.05) noreplacement
return list
display "ATT (ln_GRSSWK): " %6.4f r(att)
display "SE: " %6.4f r(seatt)


psmatch2 treated (AGE SEX MARRIED LIMITK BENFTS), outcome(UNEMP) neighbor(1) caliper(0.05) noreplacement
return list
display "ATT (ln_GRSSWK): " %6.4f r(att)
display "SE: " %6.4f r(seatt)














save allyear6_cleaned.dta, replace


*use "/Users/samsalin/Desktop/dataset/allyear6_cleaned.dta"








/// DiD reg, log earnings with OLS (#allyear6 start)



** Assumptions **
**             **
**             **


/// parallel trends 2

** ln_GRSSWK 2013
preserve 

keep if fileyear <= 2012

foreach y of numlist 2005/2012 {
    gen yeardum`y' = (fileyear == `y')
}

foreach y of numlist 2005/2012 {
    gen int_treat_`y' = COUNTRY * yeardum`y'
}

reg ln_GRSSWK int_treat_2005-int_treat_2012 AGE SEX MARRIED LIMITK BENFTS FTPT, robust
test int_treat_2005 int_treat_2006 int_treat_2007 int_treat_2008 int_treat_2009 int_treat_2010 int_treat_2011 int_treat_2012




gen year = .
gen coef = .
gen lb = .
gen ub = .
local i = 1

foreach y of numlist 2005/2012 {
    replace year = `y' in `i'
    quietly reg ln_GRSSWK int_treat_2005-int_treat_2012 AGE SEX MARRIED LIMITK BENFTS, robust
    matrix b = e(b)
    matrix V = e(V)
    local coef = b[1,"int_treat_`y'"]
    local se = sqrt(V["int_treat_`y'","int_treat_`y'"])
    replace coef = `coef' in `i'
    replace lb = `coef' - 1.96*`se' in `i'
    replace ub = `coef' + 1.96*`se' in `i'
    local ++i
}

twoway (line coef year, sort lwidth(medthick)) (rarea ub lb year, sort color(gs12)) , yline(0, lpattern(dash))  title("Pre-Treatment Parallel Trends Test: ln_GRSSWK") xtitle("Year") ytitle("Effect on ln(GRSSWK)")

restore 


*** ln_GRSSWK 2008 --> parallel trends holds
preserve 

keep if fileyear <= 2007

foreach y of numlist 2005/2007 {
    gen yeardum`y' = (fileyear == `y')
}

foreach y of numlist 2005/2007 {
    gen int_treat_`y' = COUNTRY * yeardum`y'
}

reg ln_GRSSWK int_treat_2005-int_treat_2007 AGE SEX MARRIED LIMITK BENFTS FTPT, robust
test int_treat_2005 int_treat_2006 int_treat_2007 



gen year = .
gen coef = .
gen lb = .
gen ub = .
local i = 1

foreach y of numlist 2005/2007 {
    replace year = `y' in `i'
    quietly reg ln_GRSSWK int_treat_2005-int_treat_2007 AGE SEX MARRIED LIMITK BENFTS FTPT, robust
    matrix b = e(b)
    matrix V = e(V)
    local coef = b[1,"int_treat_`y'"]
    local se = sqrt(V["int_treat_`y'","int_treat_`y'"])
    replace coef = `coef' in `i'
    replace lb = `coef' - 1.96*`se' in `i'
    replace ub = `coef' + 1.96*`se' in `i'
    local ++i
}

twoway (line coef year, sort lwidth(medthick)) (rarea ub lb year, sort color(gs12)) , yline(0, lpattern(dash))  title("Pre-Treatment Parallel Trends Test: ln_GRSSWK") xtitle("Year") ytitle("Effect on ln(GRSSWK)")

restore 



** UNEMP 2013

preserve 
keep if fileyear <= 2012

foreach y of numlist 2005/2012 {
    gen yeardum`y' = (fileyear == `y')
}


foreach y of numlist 2005/2012 {
    gen int_treat_`y' = COUNTRY * yeardum`y'
}


reg UNEMP int_treat_2005-int_treat_2012 AGE SEX MARRIED LIMITK BENFTS, robust
test int_treat_2005 int_treat_2006 int_treat_2007 int_treat_2008 int_treat_2009 int_treat_2010 int_treat_2011 int_treat_2012

gen year = .
gen coef = .
gen lb = .
gen ub = .
local i = 1

foreach y of numlist 2005/2012 {
    replace year = `y' in `i'
    quietly reg UNEMP int_treat_2005-int_treat_2012  AGE SEX MARRIED LIMITK BENFTS FTPT, robust
    matrix b = e(b)
    matrix V = e(V)
    local coef = b[1,"int_treat_`y'"]
    local se = sqrt(V["int_treat_`y'","int_treat_`y'"])
    replace coef = `coef' in `i'
    replace lb = `coef' - 1.96*`se' in `i'
    replace ub = `coef' + 1.96*`se' in `i'
    local ++i
}

twoway (line coef year, sort lwidth(medthick)) (rarea ub lb year, sort color(gs12)) , yline(0, lpattern(dash)) title("Pre-Treatment Parallel Trends: UNEMP") xtitle("Year") ytitle("Effect on Unemployment (LPM)") 

restore




*** UNEMP 2008
preserve 

keep if fileyear <= 2007

foreach y of numlist 2005/2007 {
    gen yeardum`y' = (fileyear == `y')
}

foreach y of numlist 2005/2007 {
    gen int_treat_`y' = COUNTRY * yeardum`y'
}

reg UNEMP int_treat_2005-int_treat_2007 AGE SEX MARRIED LIMITK BENFTS FTPT, robust
test int_treat_2005 int_treat_2006 int_treat_2007 



gen year = .
gen coef = .
gen lb = .
gen ub = .
local i = 1

foreach y of numlist 2005/2007 {
    replace year = `y' in `i'
    quietly reg UNEMP int_treat_2005-int_treat_2007 AGE SEX MARRIED LIMITK BENFTS FTPT, robust
    matrix b = e(b)
    matrix V = e(V)
    local coef = b[1,"int_treat_`y'"]
    local se = sqrt(V["int_treat_`y'","int_treat_`y'"])
    replace coef = `coef' in `i'
    replace lb = `coef' - 1.96*`se' in `i'
    replace ub = `coef' + 1.96*`se' in `i'
    local ++i
}

twoway (line coef year, sort lwidth(medthick)) (rarea ub lb year, sort color(gs12)) , yline(0, lpattern(dash))  title("Pre-Treatment Parallel Trends Test: UNEMP") xtitle("Year") ytitle("Effect on UNEMP")

restore 


* trend line ln_GRSSWK matching sample
preserve
collapse (mean) ln_GRSSWK, by(fileyear COUNTRY)

label define countrylbl 0 "Control" 1 "England"
label values COUNTRY countrylbl

twoway (line ln_GRSSWK fileyear if COUNTRY==1, lcolor(blue) lpattern(solid)) (line ln_GRSSWK fileyear if COUNTRY==0, lcolor(red) lpattern(dash)), title("Log Earnings by Year: England vs Control") xtitle("Year") ytitle("Mean ln(GRSSWK)") legend(order(1 "England" 2 "Control"))

restore 


* trend line UNEMP matching sample
preserve
collapse (mean) UNEMP, by(fileyear COUNTRY)

label define countrylbl 0 "Control" 1 "England"
label values COUNTRY countrylbl

twoway (line UNEMP fileyear if COUNTRY==1, lcolor(blue) lpattern(solid)) (line UNEMP fileyear if COUNTRY==0, lcolor(red) lpattern(dash)) , title("Unemployment Rate by Year: England vs Control") xtitle("Year") ytitle("Mean Unemployment Rate") legend(order(1 "England" 2 "Control"))

restore



* wage
gen event_time = fileyear - 2013 
gen event_time_shift = event_time + 10
reg ln_GRSSWK i.event_time_shift##i.treat AGE SEX MARRIED, robust
testparm 1.treat#1.event_time_shift 1.treat#2.event_time_shift 1.treat#3.event_time_shift 1.treat#4.event_time_shift 1.treat#5.event_time_shift

* unemp
gen event_time = fileyear - 2013 
gen event_time_shift = event_time + 10
reg UNEMP i.event_time_shift##i.treat AGE SEX MARRIED, robust
testparm 1.treat#1.event_time_shift 1.treat#2.event_time_shift 1.treat#3.event_time_shift 1.treat#4.event_time_shift 1.treat#5.event_time_shift


/// Anticipation


preserve

gen event_time = fileyear - 2013
gen event_time_shift = event_time + 10

* Wage outcome
reg ln_GRSSWK i.event_time_shift##i.COUNTRY AGE SEX MARRIED, robust
testparm 5.event_time_shift#1.COUNTRY 6.event_time_shift#1.COUNTRY 7.event_time_shift#1.COUNTRY 8.event_time_shift#1.COUNTRY 9.event_time_shift#1.COUNTRY

* Unemployment outcome
reg UNEMP i.event_time_shift##i.COUNTRY AGE SEX MARRIED, robust
testparm 5.event_time_shift#1.COUNTRY 6.event_time_shift#1.COUNTRY 7.event_time_shift#1.COUNTRY 8.event_time_shift#1.COUNTRY 9.event_time_shift#1.COUNTRY

restore

** Assumptions **
**             **
**             **






/// DiD reg, ln_GRSSWK with CLRM

gen post2013 = (fileyear >= 2013)
label variable post2013 "Post-Reform Period (2013 and later)"

gen post2015 = (fileyear >= 2015)
label variable post2013 "Post-Reform Period (2015 and later)"


psmatch2 treated (AGE SEX MARRIED LIMITK BENFTS), neighbor(1) caliper(0.05) noreplacement


reg ln_GRSSWK COUNTRY##post2013 i.fileyear SEX MARRIED LIMITK BENFTS if matched_wage == 1, robust
reg ln_GRSSWK COUNTRY##post2015 i.fileyear SEX MARRIED LIMITK BENFTS if matched_wage == 1, robust

reg ln_GRSSWK COUNTRY##post2013 COUNTRY##post2015 i.fileyear SEX MARRIED LIMITK BENFTS if matched_wage == 1, robust
eststo earnings


/// DiD reg, unemployment with logit


logit UNEMP COUNTRY##post2013 i.fileyear SEX MARRIED LIMITK BENFTS if matched_unemp == 1, robust
logit UNEMP COUNTRY##post2015 i.fileyear SEX MARRIED LIMITK BENFTS if matched_unemp == 1, robust


reg UNEMP COUNTRY##post2013 COUNTRY##post2015 i.fileyear SEX MARRIED LIMITK BENFTS if matched_unemp == 1, robust
eststo unemployment


esttab earnings unemployment using did_table.rtf, se star(* 0.10 ** 0.05 *** 0.01) b(3) se(3) title("Difference-in-Differences Estimates for Earnings and Unemployment") keep(1.post2013 1.COUNTRY#1.post2013 1.post2015 1.COUNTRY#1.post2015 SEX MARRIED LIMITK BENFTS _cons) replace



*** placebo test for robustness

preserve
keep if fileyear =< 2012

gen placebo_post2 = fileyear == 2011
gen placebo_post1 = fileyear == 2009
reg ln_GRSSWK COUNTRY##placebo_post1 COUNTRY##placebo_post2 i.fileyear SEX MARRIED LIMITK BENFTS if matched_wage == 1, robust

restore

/////////




















///////// Event Study

ssc install coefplot, replace
ssc install regsave, replace




/// Event Study, 2013
preserve

gen rel2013 = fileyear - 2012

gen e2013_m3 = (rel2013 == -3)
gen e2013_m2 = (rel2013 == -2)
gen e2013_m1 = (rel2013 == -1)

gen e2013_p1 = (rel2013 == 1)
gen e2013_p2 = (rel2013 == 2)
gen e2013_p3 = (rel2013 == 3)
gen e2013_p4 = (rel2013 == 4)
gen e2013_p5 = (rel2013 == 5)
gen e2013_p6 = (rel2013 == 6)
gen e2013_p7 = (rel2013 == 7)
gen e2013_p8 = (rel2013 == 8)
gen e2013_p9 = (rel2013 == 9)
gen e2013_p10 = (rel2013 == 10) 

* 11 = 2023


gen e2013_event_m3 = e2013_m3 * (COUNTRY == 1)
gen e2013_event_m2 = e2013_m2 * (COUNTRY == 1)
gen e2013_event_m1 = e2013_m1 * (COUNTRY == 1)

gen e2013_event_p1 = e2013_p1 * (COUNTRY == 1)
gen e2013_event_p2 = e2013_p2 * (COUNTRY == 1)
gen e2013_event_p3 = e2013_p3 * (COUNTRY == 1)
gen e2013_event_p4 = e2013_p4 * (COUNTRY == 1)
gen e2013_event_p5 = e2013_p5 * (COUNTRY == 1)
gen e2013_event_p6 = e2013_p6 * (COUNTRY == 1)
gen e2013_event_p7 = e2013_p7 * (COUNTRY == 1)
gen e2013_event_p8 = e2013_p8 * (COUNTRY == 1)
gen e2013_event_p9 = e2013_p9 * (COUNTRY == 1)
gen e2013_event_p10 = e2013_p10 * (COUNTRY == 1)




reg ln_GRSSWK e2013_event_* i.fileyear SEX MARRIED LIMITK BENFTS if matched_wage == 1, robust
estimates store event2013wage

coefplot event2013wage, keep(e2013_event_*) rename( e2013_event_m3 = "-3" e2013_event_m2 = "-2" e2013_event_m1 = "-1" e2013_event_p1 = "1" e2013_event_p2 = "2" e2013_event_p3 = "3" e2013_event_p4 = "4" e2013_event_p5 = "5" e2013_event_p6 = "6" e2013_event_p7 = "7" e2013_event_p8 = "8" e2013_event_p9 = "9" e2013_event_p10 = "10") vertical xline(3.5, lpattern(dash)) yline(0, lpattern(solid)) ciopts(recast(rcap)) ylabel(, angle(horizontal)) xlabel(, labsize(small)) title("Event Study: Wage Effect of 2013 Reform", size(medlarge)) xtitle("Years since reform", size(medsmall)) ytitle("Coefficient on ln_GRSSWK", size(medsmall))





reg UNEMP e2013_event_* i.fileyear SEX MARRIED LIMITK BENFTS if matched_wage == 1, robust
estimates store event2013unemp

coefplot event2013unemp, keep(e2013_event_*) rename( e2013_event_m3 = "-3" e2013_event_m2 = "-2" e2013_event_m1 = "-1" e2013_event_p1 = "1" e2013_event_p2 = "2" e2013_event_p3 = "3" e2013_event_p4 = "4" e2013_event_p5 = "5" e2013_event_p6 = "6" e2013_event_p7 = "7" e2013_event_p8 = "8" e2013_event_p9 = "9" e2013_event_p10 = "10") vertical xline(3.5, lpattern(dash)) yline(0, lpattern(solid)) ciopts(recast(rcap)) ylabel(, angle(horizontal)) xlabel(, labsize(small)) title("Event Study: Unemployment Effect of 2013 Reform", size(medlarge)) xtitle("Years since reform", size(medsmall)) ytitle("Coefficient on UNEMP", size(medsmall))



restore


/// Event Study, 2015
preserve

gen rel2015 = fileyear - 2014

gen e2015_m3 = (rel2015 == -3)
gen e2015_m2 = (rel2015 == -2)
gen e2015_m1 = (rel2015 == -1)

gen e2015_p1 = (rel2015 == 1)
gen e2015_p2 = (rel2015 == 2)
gen e2015_p3 = (rel2015 == 3)
gen e2015_p4 = (rel2015 == 4)
gen e2015_p5 = (rel2015 == 5)
gen e2015_p6 = (rel2015 == 6)
gen e2015_p7 = (rel2015 == 7)
gen e2015_p8 = (rel2015 == 8)

* 9 = 2023


gen e2015_event_m3 = e2015_m3 * (COUNTRY == 1)
gen e2015_event_m2 = e2015_m2 * (COUNTRY == 1)
gen e2015_event_m1 = e2015_m1 * (COUNTRY == 1)

gen e2015_event_p1 = e2015_p1 * (COUNTRY == 1)
gen e2015_event_p2 = e2015_p2 * (COUNTRY == 1)
gen e2015_event_p3 = e2015_p3 * (COUNTRY == 1)
gen e2015_event_p4 = e2015_p4 * (COUNTRY == 1)
gen e2015_event_p5 = e2015_p5 * (COUNTRY == 1)
gen e2015_event_p6 = e2015_p6 * (COUNTRY == 1)
gen e2015_event_p7 = e2015_p7 * (COUNTRY == 1)
gen e2015_event_p8 = e2015_p8 * (COUNTRY == 1)




reg ln_GRSSWK e2015_event_* i.fileyear SEX MARRIED LIMITK BENFTS if matched_wage == 1, robust
estimates store event2015wage

coefplot event2015wage, keep(e2015_event_*) rename( e2015_event_m3 = "-3" e2015_event_m2 = "-2" e2015_event_m1 = "-1" e2015_event_p1 = "1" e2015_event_p2 = "2" e2015_event_p3 = "3" e2015_event_p4 = "4" e2015_event_p5 = "5" e2015_event_p6 = "6" e2015_event_p7 = "7" e2015_event_p8 = "8") vertical xline(3.5, lpattern(dash)) yline(0, lpattern(solid)) ciopts(recast(rcap)) ylabel(, angle(horizontal)) xlabel(, labsize(small)) title("Event Study: Wage Effect of 2015 Reform", size(medlarge)) xtitle("Years since reform", size(medsmall)) ytitle("Coefficient on ln_GRSSWK", size(medsmall))






reg UNEMP e2015_event_* i.fileyear SEX MARRIED LIMITK BENFTS if matched_wage == 1, robust
estimates store event2015unemp

coefplot event2015unemp, keep(e2015_event_*) rename( e2015_event_m3 = "-3" e2015_event_m2 = "-2" e2015_event_m1 = "-1" e2015_event_p1 = "1" e2015_event_p2 = "2" e2015_event_p3 = "3" e2015_event_p4 = "4" e2015_event_p5 = "5" e2015_event_p6 = "6" e2015_event_p7 = "7" e2015_event_p8 = "8") vertical xline(3.5, lpattern(dash)) yline(0, lpattern(solid)) ciopts(recast(rcap)) ylabel(, angle(horizontal)) xlabel(, labsize(small)) title("Event Study: Unemployment Effect of 2015 Reform", size(medlarge)) xtitle("Years since reform", size(medsmall)) ytitle("Coefficient on UNEMP", size(medsmall))



restore





















