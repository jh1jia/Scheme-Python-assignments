## *****************************************************
## CS 116 Assignment 05, Question 4
## JunHao Jia 
## (Collatz conjecture Calculation)
## *****************************************************

import math
import check

## next: Int -> Int
## Conditions:
##     PRE: n > 1
##     POST: Produced Int >= 1
## Purpose: Produces the generate Cj+1.

def next(n):
    if n%2 == 0:
        return n/2
    else:
        return 3 * n + 1
    
    
## count_steps: Int Int (PRE: >=0) -> Int (PRE: >=0)
## Conditions:
##     PRE: n >= 1
## Purpose: Produces the number of steps needed to reach 1.

def count_steps(n,b):
    if n == 1:
        return b
    else:
        return count_steps(next(n),b+1)
    
    
## collatz_steps: Int -> Int (PRE: >=0)
## Conditions:
##     PRE: 0 < n < 100,000,000
## Purpose: Produces the number of steps needed to reach 1.
## Examples:
##     collatz_steps(1) => 0
##     collatz_steps(6) => 8

def collatz_steps(n):
    return count_steps(n,0)

## Tests for collatz_steps
## Test 1: Base case
check.expect("Q4T1", collatz_steps (1), 0)
## Test 2: Even int
check.expect("Q4T2", collatz_steps (6), 8)
## Test 3: Odd int
check.expect("Q4T3", collatz_steps (15), 17)
## Test 4: Large int
check.expect("Q4T4", collatz_steps (1234567), 111)