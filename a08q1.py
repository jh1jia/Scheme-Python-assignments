## *****************************************************
## CS 116 Assignment 08, Question 1
## JunHao Jia 
## (Participation Mark Calculation)
## *****************************************************

import check
import math

# clicker_grade: (listof Str) (listof Str) -> Float
# Conditions:
#     PRE: master is a list of strings(one of 'A','B','C','D','E')
#          student is a list of strings(one of 'A','B','C','D','E' ' ')
#          two consumed lists are assumed to be of the same length and 
#          contain at least 2 answers.
#     POST: 0 <= produced value <= 100
# Purpose: produces a Float corresponding to the student's results.
# Effects: None
# Examples: 
# clicker_grade(['A','B'],['A','B']) => 100.0
# clicker_grade(['A','A'],['B','C']) => 50.0
# clicker_grade(['A','C'],[' ',' ']) => 0.0

def clicker_grade(master, student):
    index = 0
    correct = 0
    incorrect = 0
    unanswered = 0
    need = math.floor(len(master) * 0.75)
    total = need * 2
    while index < len(master):
        if master[index] == student[index]:
            correct += 1
            index += 1
        elif student[index] == ' ':
            index += 1
            unanswered += 1
        else:
            index += 1
            incorrect += 1
    if correct >= need:
        earned = total
    elif need-correct >= incorrect:
        earned = correct*2 + incorrect * 1
    else:
        earned = correct*2 + need-correct * 1    
    return 100 * ((earned) / total)

# Constant for tests
master1 = ['A','A','B','C','A','D','E','A','D','B']
master2 = ['A','A','B','C','A']
student1 = ['A','A','B','C','A','D','E','A','D','B']
student2 = ['A','A','B','C','D','E','A','E','B',' ']
student3 = ['A','B','A',' ',' ','D',' ','A',' ','B']
student4 = ['E','E',' ',' ',' ']
student5 = ['A',' ',' ','C',' ']

# Tests1: contain only correct answers
check.expect("Q1T1", clicker_grade(master1,student1), 100.0)
# Tests2: contain correct and incorrect answers
check.within("Q1T2", clicker_grade(master1,student2),78.57143, 0.00001)
# Tests3: contain all types of answers
check.within("Q1T3", clicker_grade(master1,student3),71.42857, 0.00001)
# Tests4: contain only incorrect answers
check.expect("Q1T4", clicker_grade(['A','A'],['B','C']), 50.0)
# Tests5: contain incorrect and unanswered answers
check.within("Q1T5", clicker_grade(master2,student4), 33.3333, 0.0001)
# Tests6: contain only unanswered answers
check.expect("Q1T6", clicker_grade(['A','C'],[' ',' ']), 0.0)
# Tests7: contain only correct and unanswered answers
check.within("Q1T7", clicker_grade(master2,student5), 66.6666, 0.0001)
        
        
            
        
            
            
    