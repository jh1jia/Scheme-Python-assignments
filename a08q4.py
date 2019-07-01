## *****************************************************
## CS 116 Assignment 08, Question 4
## JunHao Jia 
## (A Game of Connect Four)
## *****************************************************

import check
import math

# A Connect4_board is a (listof (listof (union 'X' 'O' '-'))) of
# length 6, and in which each element list has length 7. 

# Constants for testing
sample_board_one = [ [ 'X', 'X', 'X', 'X', 'O', 'O', 'O'], 
                     [ 'X', 'O', 'X', 'X', 'O', 'X', 'O'], 
                     [ 'X', 'X', 'X', 'O', 'O', 'O', 'O'], 
                     [ 'O', 'X', 'O', 'X', 'O', 'X', 'X'], 
                     [ 'O', 'O', 'O', 'X', 'O', 'X', 'X'], 
                     [ 'O', 'O', 'X', 'O', 'O', 'O', 'X'] ]

sample_board_two = [ [ 'X', 'X', 'X', '_', 'O', 'O', 'O'], 
                     [ 'X', 'O', 'X', 'X', 'O', 'X', 'O'], 
                     [ 'X', 'X', 'X', 'O', '_', 'O', 'O'], 
                     [ 'O', 'X', '_', 'X', 'O', 'X', 'X'], 
                     [ 'O', 'O', 'O', 'X', 'O', 'X', 'X'], 
                     [ 'O', 'O', 'X', 'O', 'O', 'O', 'X'] ]


# winner: Connect4_board Str -> Bool
# Conditions:
#     PRE: piece is a string(one of 'X'or'O')
# Purpose: produces True if board contains a winning sequence of
# piece values,and False if it does not.
# Effects: None
# Examples: 
# winner(sample_board_one,'O') => True
# winner(sample_board_one,'X') => True
# winner(sample_board_two,'O') => False
def winner(board, piece):
    for row in range(6):
        for cum in range(4):
                if board[row][cum] == piece and\
                   board[row][cum] == board[row][cum+1] ==\
                   board[row][cum+2] == board[row][cum+3]:
                    return True
    for row in range(3):
        for cum in range(7):                
                if board[row][cum] == piece and\
                   board[row][cum] == board[row+1][cum] ==\
                   board[row+2][cum] == board[row+3][cum]:
                    return True
    for row in range(3):
        for cum in range(4):                
                if board[row][cum] == piece and\
                   board[row][cum] == board[row+1][cum+1] ==\
                   board[row+2][cum+2] == board[row+3][cum+3]:
                    return True
    for row in range(3,6):
        for cum in range(4):
                if board[row][cum] == piece and\
                   board[row][cum] == board[row-1][cum+1] ==\
                   board[row-2][cum+2] == board[row-3][cum+3]:
                    return True
    return False


## Tests for winner
check.expect("Q4T1", winner(sample_board_one,'O'),True)
check.expect("Q4T2", winner(sample_board_one,'X'),True)
check.expect("Q4T3", winner(sample_board_two,'O'),False)

