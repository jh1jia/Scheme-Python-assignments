;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname a03q1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ())))
;; *****************************************************
;; CS 116 Assignment 03, Question 1
;; JunHao Jia 
;; (Referenda Calculation)
;; *****************************************************

;; passed?: (listof Symbol) Num -> Boolean
;; Precondition: Symbol is one of 'Yes, 'No, 'Abstain.
;;               required is a Num between 0 and 100,inclusive.
;; Purpose: consumes votes(a list of symbols) and required(a number), produces 
;; true if the result of the function is greater than required, and produces
;; false in all other circumstances(including if there are no 'Yes or 'No votes).
;; Examples: 
;; (passed? (list 'Yes 'Yes 'No 'Abstain) 50) => true
;; (passed? (list 'Yes 'Yes 'No 'Yes) 75) => false

(define (passed? votes required)
  (local
    (;; list-Y-A: (listof Symbol) Nat Nat -> (list Nat Nat)
     ;; Purpose: produce a list of two natural numbers which sum-yes is the 
     ;; sum of the symbol 'Yes and sum-abstain is the sum of the symbol 'Abstain. 
     (define (list-Y-A votes sum-yes sum-abstain)
       (cond
         ((empty? votes) (list sum-yes sum-abstain))
         ((equal? (first votes) 'Yes)
          (list-Y-A (rest votes) (+ sum-yes 1) sum-abstain))
         ((equal? (first votes) 'Abstain)
          (list-Y-A (rest votes) sum-yes (+ sum-abstain 1)))
         (else
          (list-Y-A (rest votes) sum-yes sum-abstain))))
     
     ;; judge: (list Nat Nat) -> Boolean
     ;; Purpose: produces true if the result of the function is greater
     ;; than required, and produces false otherwise.
     (define (judge ls)
       (cond
         ((zero? (- (length votes) (second ls))) false)
         (else
          (> (* (/ (first ls) (- (length votes) (second ls))) 100)
             required)))))
    
    (judge (list-Y-A votes 0 0))))

;; Tests for passed?
(check-expect (passed? (list 'Yes 'Yes 'No 'Abstain) 50) true)
(check-expect (passed? (list 'Yes 'Yes 'No 'Yes) 75) false)
(check-expect (passed? empty 75) false)
(check-expect (passed? (list 'Abstain 'Abstain 'Abstain) 50) false)
(check-expect (passed? (list 'Yes 'Yes 'Yes 'Yes) 99) true)
(check-expect (passed? (list 'Abstain 'Abstain 'No) 22) false)
