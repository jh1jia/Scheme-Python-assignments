## ********************************************************
## CS 116 Assignment 09, Question 1
## JunHao Jia 
## (Calculate the Number of People by specific conditions)
## ********************************************************

import check

## Constans for testing
d1 = {2010: ['ABBA', 'Genesis', 'Jimmy Cliff', 'The Stooges'], 
      2014: ['Kiss', 'Linda Ronstadt', 'Nirvana', 'The E Street Band'],
      2011: ['Alice Cooper', 'Love', 'Tom Waits'], 
      2013: ['Heart', 'Public Enemy', 'Quincy Jones', 'Rush'] }
d2 = {1990: ['Aoe', 'Genesis', 'Jimmy Cliff', 'The Stooges'], 
      1991: ['Kiss', 'Linda Ronstadt', 'DK', 'Dean'],
      1992: ['Alice Cooper', 'Darlene Love', 'Tom Waits'], 
      1993: ['Heart', 'Public Enemy', 'Quincy Jones', 'Rush']}
d3 = {2010: ['A', 'Genesis', 'Sam'], 
      1999: ['Kiss', 'Linda', 'Nirvana'],
      2003: ['Alice', 'GG', 'Tom', 'DK'], 
      2009: ['Heart']}
d4 = {1986: ['A'], 
      2000: ['B', 'C','Queen','King'],
      1988: ['D', 'E', 'F','M','L','N'], 
      2014: ['G', 'H', 'I', 'J', 'K']}

## inductees_since: (dictof Int (listof Str)) Int -> Int(PRE: >=0)
## Pre-Conditions: yr_since >= 1986
##                 The keys for the membership >= 1986
## Purpose: produces the number of people in membership who were 
## inducted in yr_since or later.
## Effects: None
## Examples: inductees_since(d1, 2013) => 8
##           inductees_since(d2, 2000) => 0
##           inductees_since(d3, 2010) => 3
def inductees_since(membership, yr_since):
    index = 0
    count = 0
    since = 1986
    if membership == {}:
        return 0
    while index != len(membership):
        if since in membership:
            if since >= yr_since:
                count += len(membership[since])
                index += 1
                since += 1
            else:
                index += 1
                since += 1
        else:
            since += 1
    return count

## Tests for inductees_since
## Test1: There is no new members in or after yr_since
check.expect("Q1T1", inductees_since(d2, 2000), 0)
## Test2: There are new members in yr_since but not after yr_since
check.expect("Q1T2", inductees_since(d3, 2010), 3)
## Test3: There are new members after yr_since but not in yr_since
check.expect("Q1T3", inductees_since(d3, 2008), 4) 
## Test4: There are new members in and after yr_since
check.expect("Q1T4", inductees_since(d1, 2013), 8)
## Test5: General test 
check.expect("Q1T5", inductees_since(d4, 2001), 5)
## Test6: Consumes a empty dictionary
check.expect("Q1T6", inductees_since({}, 2000),0)
