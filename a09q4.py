## *****************************************************
## CS 116 Assignment 09, Question 4
## JunHao Jia 
## (Produces a new dictionary by given conditions)
## *****************************************************

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

doi2 = {2014: [inductee("The E Street Band", 2014, "Musical Excellence", "Bruce Springsteen"),
               inductee("Brian Epstein", 2014, "Lifetime Achievement", ""),
               inductee("Kiss", 2014, "Performer", "Tom Morello")], 
        2006: [inductee("Blondie", 2006, "Performer", "Shirley Manson"), 
               inductee("Miles Davis", 2006, "Performer", ""),
               inductee("Herb Alpert and Jerry Moss", 2006, "Lifetime Achievement", "")], 
        2009: [inductee("Wanda Jackson", 2009, "Early Influence", "Rosanne Cash"), 
               inductee("Run-D.M.C.", 2009, "Performer", "Eninem")]}
doi3 = {2014: [inductee("The E Street Band", 2014, "Performer", "Bruce Springsteen")], 
        2006: [inductee("Blondie", 2006, "Performer", "Shirley Manson")], 
        2009: [inductee("Wanda Jackson", 2009, "Performer", "Rosanne Cash")]}
doi4 = {2014: [inductee("The E Street Band", 2014, "Lifetime Achievement", "Bruce Springsteen"),
               inductee("Brian Epstein", 2014, "Lifetime Achievement", ""),
               inductee("Kiss", 2014, "Lifetime Achievement", "Tom Morello")]} 

## category_by_year: (dictof Int (listof Inductee)) 
##                                    -> (dictof Str (dictof Int Int (PRE: >=0)))
## Conditions: 
##        PRE: The keys for hof_members >= 1986
##        POST: The keys for the "inner" dictionaries >= 1986
##              The keys for the produced dictionary are nonempty strings.
##              The values for the produced dictionary are dictionaries.
## Purpose: produces a new dictionary with the given properties.
## Effects: None
## Examples: category_by_year(doi2) => {"Musical Excellence":{2014:1},
## "Early Influence":{2009:1},"Performer":{2014:1,2006:2,2009:1},
## "Lifetime Achievement":{2014:1,2006:1}}

def category_by_year(hof_members):
    dic = dict()
    if hof_members == {}:
        return {}
    for n in hof_members:
        for i in hof_members[n]:
            if i.category in dic.keys():
                if n in dic[i.category].keys():
                    dic[i.category][n] += 1
                else:
                    dic[i.category][n] = 1
            else:
                dic[i.category] = {n:1}
    return dic

## Tests for category_by_year
check.expect("Q4T1",category_by_year(doi2), 
{"Musical Excellence":{2014:1},"Early Influence":{2009:1},
 "Performer":{2014:1,2006:2,2009:1},"Lifetime Achievement":{2014:1,2006:1}})

check.expect("Q4T2",category_by_year({}),{})

check.expect("Q4T3",category_by_year(doi3),{"Performer":{2014:1,2006:1,2009:1}})

check.expect("Q4T4",category_by_year(doi4),{"Lifetime Achievement":{2014:3}})
            