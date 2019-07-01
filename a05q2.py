## *****************************************************
## CS 116 Assignment 05, Question 2
## JunHao Jia 
## (CS116 Grade Calculation)
## *****************************************************

import math
import check

## cs116_grade: Int Int Int Int -> Int
## Conditions:
##     PRE: consumes four integers between 0 and 100.
##     POST: produced value <= 100.
## Purpose: Produces the integer grade in CS116 according to the
##          specified rules.
## Examples:
##     cs116_grade(80,90,75,77) => 78
##     cs116_grade(20,0,50,40)=> 37

def cs116_grade(assignments, clickers, midterm, exam):
    weighted_exam = (midterm * 0.3 + exam * 0.45)
    standard_calculation = midterm * 0.3 + exam * 0.45 \
    + assignments * 0.2 + clickers * 0.05
    if weighted_exam >= 37.5:
        return int(round(standard_calculation))
    else:
        return int(round(min(weighted_exam / 75 * 100, standard_calculation)))

## Tests for cs116_grade
## Test 1: Pass the weighted exam average(WEA) with at least 50%
check.expect("Q2T1", cs116_grade(80, 90, 75, 77), 78)
## Test 2: Fail the WEA and WEA is smaller than standard calculation(SC)
check.expect("Q2T2", cs116_grade(100, 100, 40, 40), 40)
## Test 3: Fail the WEA and SC is smaller than WEA
check.expect("Q2T3", cs116_grade(0, 0, 40, 40), 30)
## Test 4: General case 
check.expect("Q2T4", cs116_grade(20, 0, 50, 40), 37)
## Test 5: General case 
check.expect("Q2T5", cs116_grade(100, 95, 50, 75), 74)       
        
    