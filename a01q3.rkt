;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname a01q3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; *****************************************************
;; CS 116 Assignment 01, Question 3
;; JunHao Jia 
;; (Find the animals that arrived after a date)
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


;; arrived-since: (listof Animal) Date -> (listof String)
;; Postcondition: the names in the produced list should occur in the
;; same relative order they appear in pets.
;; Purpose: produces a list of the names of all the animals in pets that
;; arrived after since.
;; Examples: 
;; (arrived-since (list (make-animal "Max" "cat" (make-date 2013 10 7))
;;                     (make-animal "Slytherin" "snake" (make-date 2014 2 5))
;;                     (make-animal "Kitty" "dog" (make-date 2013 12 30)))
;;               (make-date 2013 10 7)) => (list "Slytherin" "Kitty")
;; (arrived-since (list (make-animal "Max" "cat" (make-date 2013 10 7))
;;                     (make-animal "Slytherin" "snake" (make-date 2013 2 5))
;;                     (make-animal "Kitty" "dog" (make-date 2013 5 30)))
;;               (make-date 2013 10 7)) => empty

(define (arrived-since pets since)
  (local
    (;; after?: Animal -> Boolean
     ;; Purpose: produces true if the animals in str that arrived after since,
     ;; and false otherwise.
     (define (after? str)
       (or (> (date-year (animal-arrival str)) (date-year since))
           (and (= (date-year (animal-arrival str)) (date-year since))
                (> (date-month (animal-arrival str)) (date-month since)))
           (and (= (date-year (animal-arrival str)) (date-year since))
                (= (date-month (animal-arrival str)) (date-month since))
                (> (date-day (animal-arrival str)) (date-day since))))))
    
    (map animal-name (filter after? pets))))

;; Tests for arrived-since
(check-expect (arrived-since
               (list (make-animal "Max" "cat" (make-date 2013 10 7))
                     (make-animal "Slytherin" "snake" (make-date 2014 2 5))
                     (make-animal "Kitty" "dog" (make-date 2013 12 30)))
               (make-date 2013 10 7)) (list "Slytherin" "Kitty"))
(check-expect (arrived-since (list (make-animal "Max" "dragon" (make-date 2013 10 7))
                                   (make-animal "Slytherin" "snake" (make-date 2013 2 5))
                                   (make-animal "Kitty" "dog" (make-date 2013 5 30)))
                             (make-date 2013 10 7)) empty)
(check-expect (arrived-since
               (list (make-animal "Max" "cat" (make-date 2013 10 8))
                     (make-animal "Slytherin" "snake" (make-date 2014 2 5))
                     (make-animal "Kitty" "dog" (make-date 2013 12 30)))
               (make-date 2013 10 7)) (list "Max" "Slytherin" "Kitty"))