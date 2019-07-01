## *****************************************************
## CS 116 Assignment 08, Question 3
## JunHao Jia 
## (Posn coordinates mutating and calculation)
## *****************************************************

import check
import math

# A Posn is a list of length two [x,y], where
# x and y are both Float values, corresponding to the
# x and y coordinates of the point, respectively. 

# make_posn:(union Int Float) (union Int Float) -> Posn
# Purpose: make a Posn structure.
def make_posn(x_coord,y_coord):
    return [x_coord, y_coord]
# posn_x: Posn -> (union Int Float)
# Purposn: draw the x value from consumed Posn.
def posn_x(p):
    return p[0]
# posn_y: Posn -> (union Int Float)
# Purposn: draw the y value from consumed Posn.
def posn_y(p):
    return p[1]
# set_posn_x: Posn (union Int Float) -> Posn
# Purposn: set the x value of consumed Posn to the new x value.
def set_posn_x(p,new_x):
    p[0] = new_x
    return p
# set_posn_y: Posn (union Int Float) -> Posn
# Purposn: set the y value of consumed Posn to the new y value.
def set_posn_y(p,new_y):
    p[1] = new_y
    return p

# Constants for tests:
my_posn_list = [[3.0,4.0],[8.0,-1.0],[0.0,2.0],[2.0,10.0],[-1.0,12.0]]

# align: (listof Posn) (union Float Int)  -> Int(PRE: >=0)
# Conditions:
#     PRE: max_diff is a positive number.
# Purpose: produces the total number of x- and y-coordinates which
# were mutated.
# Effects: For each Posn value in points:
#   If its x-coordinate is outside the range,then mutate the x-coordinate to 
# the closer endpoint of that interval.
#   If its y-coordinate is outside the range,then mutate the y-coordinate to 
# the closer endpoint of that interval.
# Examples: 
# align(my_posn_list,2.5) => 6
# align([],5) => 0
def align(points, max_diff):
    sumx = 0.0
    sumy = 0.0
    count_posn = len(points)
    if points == []:
        return 0
    for posn in points:
        sumx += posn_x(posn)
    for posn in points:
        sumy += posn_y(posn)
    x_avg = sumx / count_posn
    y_avg = sumy / count_posn
    x_range =[x_avg - max_diff, x_avg + max_diff]
    y_range =[y_avg - max_diff, y_avg + max_diff]

    n = 0
    b = 0
    total_mutated = 0
    
    while n != count_posn:
        if posn_x(points[n]) < x_range[0]:
            set_posn_x(points[n],x_range[0])
            n += 1
            total_mutated += 1
        elif posn_x(points[n]) > x_range[1]:
            set_posn_x(points[n],x_range[1])
            n += 1
            total_mutated += 1
        else: n += 1
        
    while b != count_posn:
        if posn_y(points[b]) < y_range[0]:
            set_posn_y(points[b],y_range[0])
            b += 1
            total_mutated += 1
        elif posn_y(points[b]) > y_range[1]:
            set_posn_y(points[b],y_range[1])
            b += 1
            total_mutated += 1
        else: b += 1
    
    return total_mutated

# Tests for align:
check.expect("Q3T1", align(my_posn_list,2.5), 6)
check.expect("Q3T2", align([],5), 0)
check.expect("Q3T3", align([[2.0,3.0],[4.0,1.0]],1),0)
check.expect("Q3T4", align([[2.0,9.0],[8.0,1.0],[-4.0,-4.0]],2),4)