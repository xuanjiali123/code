clear
set more off
cd"C:\Users\86157\Desktop\论文研究数据dta"

use 地方政府债务.dta
*城投债虚拟变量
cap drop _merge
merge m:1 city year using 城投债虚拟变量.dta
drop if _merge==2
replace issue =0 if issue==.
//生成0-1虚拟变量
gen dummy = 0
replace dummy=1 if 负债率宽口径 <60
rename issue D
*----------------------------------
*增加控制变量
*----------------------------------3
//城市层面控制变量
gen GDP万元 = GDP亿元*10000
gen loggdp1 = log(GDP亿元)
gen l人均GDP元 = log(人均GDP元)
gen l城镇居民人均可支配收入元 = log(城镇居民人均可支配收入元)
gen l一般公共预算支出亿元 = log(一般公共预算支出亿元)
gen l一般公共预算收入亿元 = log(一般公共预算收入亿元)
gen l工业增加值亿元 = log(工业增加值亿元)
gen l第一产业增加值亿元 = log(第一产业增加值亿元)
gen l第二产业增加值亿元 = log(第二产业增加值亿元)
gen l第三产业增加值亿元 = log(第三产业增加值亿元)
gen l工业总产值亿元 = log(工业总产值亿元)
gen l人口万人 = log(人口万人)
*控制变量滞后一期
gen n = _n
encode city,generate(city_code)
tsset city_code year
gen 负债率宽口径_1 = L.负债率宽口径
gen dummy_1 = L.dummy
gen loggdp1_1 = L.loggdp1
gen l人均GDP元_1 = L.l人均GDP元
gen lGDP增速_1 = L.GDP增速
gen l城镇居民人均可支配收入元_1 = L.l城镇居民人均可支配收入元
gen l第一产业增加值亿元_1 = L.l第一产业增加值亿元
gen l第二产业增加值亿元_1 = L.l第二产业增加值亿元
gen l第三产业增加值亿元_1 = L.l第三产业增加值亿元
gen l工业增加值亿元_1 = L.l工业增加值亿元
gen l工业总产值亿元_1 = L.l工业总产值亿元
gen 财政自给率_1 = L.财政自给率
gen l人口万人_1 = L.人口万人
gen dummy_1 = L.dummy
//缩尾处理//
  local vv  l人均GDP元_1  l人口万人_1 lGDP增速_1  l城镇居民人均可支配收入元_1 l工业增加值亿元_1 财政自给率_1
  foreach v of varlist `vv'{
    local a: var lab `v'
    winsor `v', p(0.01) gen(`v'_x)
    drop `v'
    rename `v'_x `v'
    label var `v' "`a'"
  } 
//
preserve
keep if year>=2010&year<=2019
reg D dummy_1  l人均GDP元_1  l人口万人_1 lGDP增速_1  l城镇居民人均可支配收入元_1 l工业增加值亿元_1 财政自给率_1 if year>=2010&year<=2019,r 
outreg2 using 断点回归结果.doc,replace  bdec(3)  ctitle(D) addtext(year FE, YES)
reg D dummy_1  l人均GDP元_1  l人口万人_1 lGDP增速_1  l城镇居民人均可支配收入元_1 l工业增加值亿元_1 财政自给率_1 if year>=2010&year<=2019,r 
outreg2 using 断点回归结果.doc,replace  bdec(3)  ctitle(D) addtext(year FE, YES)

restore


reg D dummy_1  l人均GDP元_1  l人口万人_1 lGDP增速_1  l城镇居民人均可支配收入元_1 l工业增加值亿元_1 财政自给率_1 if year==2010,r 
outreg2 using 断点回归.doc,replace  bdec(3)  ctitle(D) addtext(year FE, YES)
reg D dummy_1  l人均GDP元_1  l人口万人_1 lGDP增速_1  l城镇居民人均可支配收入元_1 l工业增加值亿元_1 财政自给率_1 if year==2011,r
outreg2 using 断点回归.doc,append  bdec(3)  ctitle(D) addtext(year FE, YES) 
reg D dummy_1  l人均GDP元_1  l人口万人_1 lGDP增速_1  l城镇居民人均可支配收入元_1 l工业增加值亿元_1 财政自给率_1 if year==2012,r 
outreg2 using 断点回归.doc,append  bdec(3)  ctitle(D) addtext(year FE, YES)
reg D dummy_1  l人均GDP元_1  l人口万人_1 lGDP增速_1  l城镇居民人均可支配收入元_1 l工业增加值亿元_1 财政自给率_1 if year==2013,r
outreg2 using 断点回归.doc,append  bdec(3)  ctitle(D) addtext(year FE, YES)
reg D dummy_1  l人均GDP元_1  l人口万人_1 lGDP增速_1  l城镇居民人均可支配收入元_1 l工业增加值亿元_1 财政自给率_1 if year==2014,r 
outreg2 using 断点回归.doc,append  bdec(3)  ctitle(D) addtext(year FE, YES)
reg D dummy_1  l人均GDP元_1  l人口万人_1 lGDP增速_1  l城镇居民人均可支配收入元_1 l工业增加值亿元_1 财政自给率_1 if year==2015,r 
outreg2 using 断点回归.doc,append  bdec(3)  ctitle(D) addtext(year FE, YES)
reg D dummy_1  l人均GDP元_1  l人口万人_1 lGDP增速_1  l城镇居民人均可支配收入元_1 l工业增加值亿元_1 财政自给率_1 if year==2016,r
outreg2 using 断点回归.doc,append  bdec(3)  ctitle(D) addtext(year FE, YES)
reg D dummy_1  l人均GDP元_1  l人口万人_1 lGDP增速_1  l城镇居民人均可支配收入元_1 l工业增加值亿元_1 财政自给率_1 if year==2017,r 
outreg2 using 断点回归.doc,append  bdec(3)  ctitle(D) addtext(year FE, YES)
reg D dummy_1  l人均GDP元_1  l人口万人_1 lGDP增速_1  l城镇居民人均可支配收入元_1 l工业增加值亿元_1 财政自给率_1 if year==2018,r 
outreg2 using 断点回归.doc,append  bdec(3)  ctitle(D) addtext(year FE, YES)
reg D dummy_1  l人均GDP元_1  l人口万人_1 lGDP增速_1  l城镇居民人均可支配收入元_1 l工业增加值亿元_1 财政自给率_1 if year==2019,r 
outreg2 using 断点回归.doc,append  bdec(3)  ctitle(D) addtext(year FE, YES)

rdplot D 负债率宽口径_1 if year==2010, c(60) graph_options
rdplot D 负债率宽口径_1 if year==2011, c(60) graph_options
rdplot D 负债率宽口径_1 if year==2012, c(60)  graph_options
rdplot D 负债率宽口径_1 if year==2013, c(60) graph_options
rdplot D 负债率宽口径_1 if year==2014, c(60) graph_options
rdplot D 负债率宽口径_1 if year==2015, c(60) graph_options
rdplot D 负债率宽口径_1 if year==2016, c(60) graph_options
rdplot D 负债率宽口径_1 if year==2017, c(60) graph_options
rdplot D 负债率宽口径_1 if year==2018, c(60) graph_options
rdplot D 负债率宽口径_1 if year==2019, c(60) graph_options

predict x_hat