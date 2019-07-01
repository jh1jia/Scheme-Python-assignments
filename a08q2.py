## *****************************************************
## CS 116 Assignment 08, Question 2
## JunHao Jia 
## (Password Check)
## *****************************************************

import check
import math

# Constans
prompt = "Enter password (%d tries remaining): "

# check_password: Str Int(PRE: >=0) -> Bool
# Conditions:
#     PRE: password is a nonempty string.
# Purpose: produces True if the user enters the correct 
#          password in limit attempts, and False otherwise.
# Effects: The user enters a string,password when prompted. And
#          if the correct password is entered by the user, no more
#          attempts are given.
# Examples: If the user enters "abc" when check_password("abc",2) is
#           called, True is produced.
#           If the user enters "ccc" when check_password("abc",1) is
#           called, False is produced.

def check_password(password, limit):
    index = limit
    while index != 0:
        s = raw_input(prompt % index)
        if password == s:
                return True
        else: index -= 1
    return False

# Tests:
check.set_input(['abc'])
check.expect("Q2T1", check_password('abc',4),True)

check.set_input(['aeo'])
check.expect("Q2T2", check_password('abc',1),False)

check.expect("Q3T3", check_password('tt',0),False)