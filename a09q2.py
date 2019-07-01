## ***************************************************
## CS 116 Assignment 09, Question 2
## JunHao Jia 
## (Produces a new dictionary by given conditions)
## ***************************************************

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

## Constans for testing
loi = [inductee("Bruce Springsteen", 1999, "Performer", "Bono"), 
       inductee("Billy Joel", 1999, "Performer", "Ray Charles"),
       inductee("Mahalia Jackson", 1997, "Early Influence", ""),
       inductee("Rush", 2013, "Performer", "") ]
loi2 = [inductee("Bruce Springsteen", 2002, "Performer", "Bono"),     
        inductee("Billy Joel", 2002, "Performer", "Ray Charles"),
        inductee("Mahalia Jackson", 2002, "Early Influence", ""),
        inductee("Rush", 2002, "Performer", "")]
loi3 = [inductee("Bruce Springsteen", 1999, "Performer", "Bono"),     
        inductee("Bruce Spring", 1999, "Performer", "Ray Charles"),
        inductee("Zoe", 2001, "Early Influence", ""),
        inductee("Mahalia Barnes", 2001, "Performer", "")]
loi4 = [inductee("Bruce Springsteen", 2002, "Performer", "Bono"),     
        inductee("Billy Joel", 1998, "Performer", "Ray Charles"),
        inductee("Mahalia Jackson", 2008, "Early Influence", ""),
        inductee("Rush", 2013, "Performer", "")]


## create_by_year: (listof Inductee) -> (dictof Int (listof Str))
## Conditions: 
##       PRE: members is a list of Inductee objects.
##       POST: The keys of the produced dictionary >= 1986
## Purpose: produces a dictionary in which the keys are the years Inductees 
##          were inducted, and the values are the list of the names of the 
##          Inductees in each year in alphabetical order.
## Effects: None
## Examples: create_by_year(loi) => 
##           {2013: ['Rush'], 1997: ['Mahalia Jackson'], 
##           1999: ['Billy Joel', 'Bruce Springsteen']}
def create_by_year(members):
    dic = dict()
    index = 0
    if members == []:
        return {}
    while index != len(members):
        if members[index].year in dic:
            dic[members[index].year].append(members[index].name)
            dic[members[index].year].sort()
            index += 1
        else:
            dic[members[index].year] = [members[index].name]
            index += 1
    return dic

## Test1: All inductees were inducted in the same year
check.expect("Q2T1", create_by_year(loi2), {2002: ['Billy Joel', 
             'Bruce Springsteen','Mahalia Jackson','Rush']})
## Test2: Some inductees were inducted in the same year
check.expect("Q2T2", create_by_year(loi3), {2001: ['Mahalia Barnes', 
             'Zoe'], 1999: ['Bruce Spring', 'Bruce Springsteen']})
## Test3: All inductees were inducted in different years
check.expect("Q2T3", create_by_year(loi4), {2013: ['Rush'], 
            2008: ['Mahalia Jackson'], 1998: ['Billy Joel'], 
            2002: ['Bruce Springsteen']})
## Test4: General test 
check.expect("Q2T4", create_by_year(loi), {2013: ['Rush'],
             1997: ['Mahalia Jackson'], 
             1999: ['Billy Joel', 'Bruce Springsteen']})
## Test5: Consumes a empty list
check.expect("Q2T5", create_by_year([]), {})
        