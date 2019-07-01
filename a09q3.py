## **********************************************************
## CS 116 Assignment 09, Question 3
## JunHao Jia 
## (Find the names of inductees who math the given order.)
## **********************************************************

import check

## Begin - Inductee
class inductee:
    'fields: name, year, category, presented_by'
    # inductee(name, year, category, presented_by) is of type Inductee, where
    # * name is a nonempty Str, for the name of the person or group 
    # * year is an Int >= 1986, for the year the inductee was inducted
    # * category is a nonempty Str, for the category in which the inductee
    #   was honoured, for example, "Performer", "Lifetime Achievement", etc.
    # * presented_by is a Str, for the name of the person(s) who introduced the
    #   inductee at their awards ceremony. (It may be the empty string.)
    
    # __init__: Str Int Str Str -> Inductee
    # PRE-Conditions: 
    #     len(who) > 0
    #     yr >= 1986
    #     len(area) > 0
    # inductee(who, yr, area, by) produces an Inductee, as described in the
    # data definition above. 
    # Note: Do not call __init__ directly
    def __init__(self, who, yr, area, by):
        self.name = who
        self.year = yr
        self.category = area
        self.presented_by = by
    
    # __repr__: Inductee -> Str
    # Produces a string representation of self.
    # Note: Do not call __repr__ directly. It is called indirectly when you
    # print an Inductee object (or print a list containing Inductees).
    def __repr__(self):
        if self.presented_by != "":
            return "%s: %s (%d) <%s>" % (self.name, self.category, self.year, self.presented_by)
        else:
            return "%s: %s (%d)" % (self.name, self.category, self.year)
    
    # __eq__: Inductee Inductee -> Bool
    # Produces True if self and other are both Inductees and all fields are equal,
    # and otherwise produces False.
    # Note: Do not call __eq__ directly. It is called indirectly when you 
    # call x == y, where at least one of x and y is an Inductee. 
    def __eq__(self, other):
        return isinstance(other) and \
               self.name == other.name and \
               self.year == other.year and \
               self.category == other.category and \
               self.presented_by == other.presented_by
    
    #__ne__: Inductee Inductee -> Bool
    # Produces True if self and other are not identical field-by-field, and
    # produces False if they are identical.
    # Note: Do not call __ne__ directly. It is called indirectly by x != y, where
    # at least one of x, y is an Inductee object. It is used by check.expect
    # when the expected/actual values are of type Inductee.
    def __ne__(self, other):
        return not (self == other)  
#---- end Inductee

# Question 3 
doi1 =   {1994: [inductee("Bob Marley", 1994, "Performer", "Bono")],
          1997: [inductee("Mahalia Jackson", 1997, "Early Influence", "")],
          1999: [inductee("Bruce Springsteen", 1999, "Performer", "Bono"), 
                 inductee("Billy Joel", 1999, "Performer", "Ray Charles")], 
          2011: [inductee("Quincy Jones", 2011, "Lifetime Achievement", "")],
          1998: [inductee("The Beatles", 1998, "Performer", ""), 
                 inductee("Bob Dylan", 1998, "Performer", "Bruce Springsteen")], 
          1986: [inductee("Ray Charles", 1986, "Performer", "Quincy Jones")] }

doi2 = {1994: [inductee("Bob Marley", 1994, "Performer", "Bono")],
        1997: [inductee("Mahalia Jackson", 1997, "Early Influence", "Ray Charles")],
        1999: [inductee("Bruce Springsteen", 1999, "Performer", "Bono"), 
                inductee("Billy Joel", 1999, "Performer", "Ray Charles")], 
        2003: [inductee("Quincy Jones", 2003, "Lifetime Achievement", "Quincy Jones")],
        1938: [inductee("The Beatles", 1938, "Performer", "Bruce Springsteen"), 
                inductee("Bob Dylan", 1938, "Performer", "Bruce Springsteen")], 
        1996: [inductee("Ray Charles", 1996, "Performer", "Quincy Jones")]}

doi3 = {1994: [inductee("Bob Marley", 1994, "Performer", "Bono")],
        1997: [inductee("Mahalia Jackson", 1997, "Early Influence", "")],
        1999: [inductee("Bruce Springsteen", 1999, "Performer", "Bono"), 
                inductee("Billy Joel", 1999, "Performer", "Ray Charles")]}

doi4 = {1986: [inductee("F", 1986, "Performer", "Zoe")],
        1987: [inductee("E", 1987, "Early Influence", "Y")],
        1993: [inductee("D", 1993, "Performer", "E")], 
        2010: [inductee("Zoe", 2010, "Lifetime Achievement", "F")],
        2002: [inductee("B", 2002, "Performer", "")], 
        2012: [inductee("A", 2012, "Performer", "B")]}

doi5 = {1986: [inductee("FF", 1986, "Performer", "Z")],
        1987: [inductee("E", 1987, "Early Influence", "Y")],
        1999: [inductee("EAE", 1999, "Performer", "E")], 
        2003: [inductee("C", 2003, "Lifetime Achievement", "F")],
        2002: [inductee("B", 2002, "Performer", "ET")], 
        2013: [inductee("A", 2013, "Performer", "B")]}

## dual_roles: (dictof Int (listof Inductee)) -> (listof Str)
## Conditions: 
##        PRE: The keys for hof_members >= 1986
##             No one is inducted into the Hall of Fame multiple times as 
##             an individual.
##        POST: A person's name can only appear once in the produced list.
##              Produced list is in alphabetical order according to Python's
##              < ordering.
## Purpose: produces a list of strings which contain the names of all Hall
##          of Fame inductees whose name match the presented_by field for
##          another Inductee.
## Effects: None
## Examples: dual_roles(doi1) => 
##           ['Bruce Springsteen', 'Quincy Jones', 'Ray Charles']

def dual_roles(hof_members):
    lis1 = []
    lis2 = []
    lis3 = []
    if hof_members == {}:
        return []
    for n in hof_members.keys():
        for i in hof_members[n]:
            lis1.append(i.name)
            if not i.presented_by in lis2:
                lis2.append(i.presented_by)
    for b in lis2:
        if b in lis1:
            lis3.append(b)
    lis3.sort()
    return lis3

## Test1: All inductees who meet requirement only represent new members once
check.expect("Q3T1", dual_roles(doi1), ['Bruce Springsteen', 
                                        'Quincy Jones', 'Ray Charles'])
## Test2: Some inductees represent new members more than once     
check.expect("Q3T2", dual_roles(doi2), ['Bruce Springsteen', 
                                        'Quincy Jones', 'Ray Charles'])
## Test3: There is no such inductee
check.expect("Q3T3", dual_roles(doi3), [])
## Test4: Consumes a empty dictionary
check.expect("Q3T4", dual_roles({}), [])
## Test5: General test 1
check.expect("Q3T5", dual_roles(doi4), ['B', 'E', 'F','Zoe'])
    
            
            
            
                       
                       
    
    
