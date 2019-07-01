## *****************************************************
## CS 116 Assignment 05, Question 1
## JunHao Jia 
## (Cost of Making cookies)
## *****************************************************

import math
import check

## cookie_cost: Int (PRE: >=0) Int (PRE: >=0) -> Float
## Purpose: Produces a Float for the cost of buying the needed amounts of 
## flour, sugar, chocolate chips and eggs.
## Examples:
##     cookie_cost(100,3) => 48.5
##     cookie_cost(2,20)=> 14.5
    
def cookie_cost(num_people, cookies_per_person):
    sum = num_people * cookies_per_person
    batters = math.ceil(sum / 24.0)
    flour_cost = math.ceil(batters * 400 / 5000) * 6
    sugar_cost = math.ceil(batters * 200 / 1000) * 1.50
    chocolate_cost = batters * 2
    egg_cost = math.ceil(batters / 12) * 3
    cost = flour_cost + sugar_cost + chocolate_cost + egg_cost
    return cost

## Tests for cookie_cost
## Test 1: One batch of cookie batter
check.expect("Q1T1", cookie_cost(1, 1), 12.5)
## Test 2: Two batches of cookie batter
check.expect("Q1T2", cookie_cost(2, 34), 16.5)
## Test 3: Many batches of cookie batter
check.expect("Q1T3", cookie_cost(888, 80), 8971.0) 
## Test 4: No cookies needed
check.expect("Q1T4", cookie_cost(123, 0), 0)
## Test 5: General case
check.expect("Q1T5", cookie_cost(100, 3), 48.5)