## *****************************************************
## CS 116 Assignment 05, Question 3
## JunHao Jia 
## (Day of The Week Calculation)
## *****************************************************

import math
import check

## constants
sun = "Sunday"
mon = "Monday"
tue = "Tuesday"
wed = "Wednesday"
thu = "Thursday"
fri = "Friday"
sat = "Saturday"

## day_of_the_week: Int Int Int -> Str
## Conditions:
##     PRE: year >= 1582
##          1 <= month <= 12
##          1 <= day <= 31
## Purpose: Produces a string(one of "Sunday", "Monday", "Tuesday", 
##          "Wednesday", "Thursday", "Friday", "Saturday").
## Examples:
##     day_of_the_week(2014,6,18) => "Wednesday"
##     day_of_the_week(2014,5,1)=> "Tuesday"

def day_of_the_week (year, month, day):
    
    if month == 1:
        year = year - 1
        month = 11
    elif month == 2:
        year = year - 1
        month = 12
    else:
        month = month - 2  
        
    m = month
    y = year % 100
    c = year / 100
    d = day    
    w = int((d + math.floor(2.6 * m  - 0.2) + y + math.floor(y/4) \
         + math.floor(c/4) - 2 * c)) % 7
    
    if w == 0:
        return sun
    if w == 1:
        return mon
    if w == 2:
        return tue
    if w == 3:
        return wed
    if w == 4:
        return thu
    if w == 5:
        return fri
    if w == 6:
        return sat

## Tests for day_of_the_week
check.expect("Q3T1", day_of_the_week(2014,6,18), "Wednesday")     
check.expect("Q3T2", day_of_the_week(2014,5,2), "Friday")
check.expect("Q3T3", day_of_the_week(2133,7,2), "Thursday")
check.expect("Q3T4", day_of_the_week(1996,6,18), "Tuesday")
check.expect("Q3T5", day_of_the_week(1997,7,19), "Saturday")
check.expect("Q3T6", day_of_the_week(2000,11,19), "Sunday")
check.expect("Q3T7", day_of_the_week(2001,11,19), "Monday")