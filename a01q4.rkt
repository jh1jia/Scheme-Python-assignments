;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname a01q4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; *****************************************************
;; CS 116 Assignment 01, Question 4
;; JunHao Jia 
;; (Animals calculated by type)
;; *****************************************************

;; A Date is a structure (make-date y m d), where
;; y is positive integer (year),
;; m is an integer between 1 and 12 (month),
;; d is an integer between 1 and 31 (day of the month).
(define-struct date (year month day))

;; An Animal is a structure (make-structure n t a), where
;; n is a nonempty string (name of animal),
;; t is a nonempty string (type of animal),
;; a is a Date (date animal arrived at the shelter).
(define-struct animal (name type arrival))


;; count-by-type: (listof Animal) -> (listof List)
;; Postcondition: The elements in the produced list are each of length 2, and
;;               have the form (list c s), where the list pets contains c animals 
;;               of type s;
;;               Each animal type will only occur once in the produced list;
;;               The produced list will be in decreasing order by count;
;;               In the case of ties, order the tied pairs with the animal types
;;               in increasing alphabetical order.
;;               If pets is empty, the produced list is empty as well.
;; Purpose: produces a list of lists which count the animals by different types.
;; Examples: 
;; (count-by-type
;;    (list
;;         (make-animal "Slytherin" "snake" (make-date 2013 8 23))
;;         (make-animal "Toby" "dog" (make-date 2014 3 20))
;;         (make-animal "Curly" "dog" (make-date 2014 1 18))
;;         (make-animal "Maximus" "cat" (make-date 2013 10 7))
;;         (make-animal "Mia" "cat" (make-date 2013 10 7))))
;;       => (list (list 2 "cat") (list 2 "dog") (list 1 "snake")))
;; (count-by-type empty) => empty
(define (count-by-type pets)
  (local
    (;; Ani-tp: Animal -> String
     ;; Purpose: produces the type of the animal.
     (define (Ani-tp str)
       (animal-type str))
     
     ;; count: String (listof List) -> (listof List)
     ;; purpose: count the total quantity of each type of animals.
     (define (count st n)
       (cond
         ((empty? n) (cons (list 1 st) empty))
         ((string=? st (second (first n)))
          (cons (list (+ 1 (first (first n))) st) (rest n)))
         (else (cons (list 1 st) n))))
     
     ;; contrast: (list Num String) (list Num String) -> Boolean
     ;; purpose: compare the sum of two types of animal, and produces true
     ;; if the sum of animals in a is greater than the sum of animals in b.
     (define (contrast a b)
       (> (first a) (first b))))
    
    (quicksort (foldr count empty (quicksort (map Ani-tp pets) string<=?)) contrast)))

;; Tests for count-by-type
(check-expect (count-by-type
               (list
                (make-animal "Slytherin" "snake" (make-date 2013 8 23))
                (make-animal "Toby" "dog" (make-date 2014 3 20))
                (make-animal "Curly" "dog" (make-date 2014 1 18))
                (make-animal "Maximus" "cat" (make-date 2013 10 7))
                (make-animal "Mia" "cat" (make-date 2013 10 7))))
              (list (list 2 "cat") (list 2 "dog") (list 1 "snake")))
(check-expect (count-by-type empty) empty)
(check-expect (count-by-type
               (list
                (make-animal "Slytherin" "snake" (make-date 2013 8 23))
                (make-animal "Toby" "dog" (make-date 2014 3 20))
                (make-animal "Curly" "dog" (make-date 2014 1 18))
                (make-animal "Maximus" "dragon" (make-date 2013 10 7))
                (make-animal "Mia" "cat" (make-date 2013 10 7))))
              (list 
               (list 2 "dog") (list 1 "cat") (list 1 "dragon") (list 1 "snake")))
(check-expect (count-by-type
               (list
                (make-animal "Slytherin" "snake" (make-date 2013 8 23))
                (make-animal "Toby" "bird" (make-date 2014 3 20))
                (make-animal "Curly" "dog" (make-date 2014 1 18))
                (make-animal "Maximus" "dragon" (make-date 2013 10 7))
                (make-animal "Mia" "cat" (make-date 2013 10 7))))
              (list 
               (list 1 "bird") (list 1 "cat") (list 1 "dog") (list 1 "dragon") (list 1 "snake")))
(check-expect (count-by-type
               (list
                (make-animal "Slytherin" "snake" (make-date 2013 8 23))
                (make-animal "Super" "snake" (make-date 2013 9 23))
                (make-animal "erin" "zombie" (make-date 2013 8 23))
                (make-animal "in" "zombie" (make-date 2013 8 23))
                (make-animal "herin" "zombie" (make-date 2013 8 23))
                (make-animal "Toby" "bird" (make-date 2014 3 20))
                (make-animal "Curly" "dog" (make-date 2014 1 18))
                (make-animal "Maximus" "dragon" (make-date 2013 10 7))
                (make-animal "Mia" "cat" (make-date 2013 10 7))))
              (list 
               (list 3 "zombie") (list 2 "snake") (list 1 "bird") 
               (list 1 "cat") (list 1 "dog") (list 1 "dragon")))
