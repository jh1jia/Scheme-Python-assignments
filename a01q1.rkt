;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname a01q1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; *****************************************************
;; CS 116 Assignment 01, Question 1
;; JunHao Jia 
;; (Referenda Calculation)
;; *****************************************************

;; passed?: (listof Symbol) Num -> Boolean
;; Postcondition: Symbol is one of 'Yes, 'No, 'Abstain.
;;                required is a Num between 0 and 100,inclusive.
;; Purpose: consumes votes(a list of symbols) and required(a Num), produces 
;; true if the result of the function is greater than required, and produces
;; false in all other circumstances(including if there are no 'Yes or 'No votes).
;; Examples: 
;; (passed? (list 'Yes 'Yes 'No 'Abstain) 50) => true
;; (passed? (list 'Yes 'Yes 'No 'Yes) 75) => false

(define (passed? votes required)
  (local
    (;; Yes?: Symbol -> Boolean
     ;; Purpose: true if v equals symbol 'Yes.
     (define (Yes? v)
       (symbol=? 'Yes v))
     
     ;; No?: Symbol -> Boolean
     ;; Purpose: true if v equals symbol 'No.
     (define (No? v)
       (symbol=? 'No v))
     
     ;; Sum-of-Y is the number of votes of 'Yes.
     (define Sum-of-Y (length (filter Yes? votes)))
     
     ;; Sum-of-N is the number of votes of 'No.
     (define Sum-of-N (length (filter No? votes))))
    
    (cond
      ((empty? votes) false)
      ((and (equal? Sum-of-Y 0)
            (equal? Sum-of-N 0)) false)
      (else
       (> (* (/ Sum-of-Y (+ Sum-of-Y Sum-of-N)) 100) required)))))

;; Tests for passed?
(check-expect (passed? (list 'Yes 'Yes 'No 'Abstain) 50) true)
(check-expect (passed? (list 'Yes 'Yes 'No 'Yes) 75) false)
(check-expect (passed? empty 75) false)
(check-expect (passed? (list 'Abstain 'Abstain 'Abstain) 50) false)
(check-expect (passed? (list 'Yes 'Yes 'Yes 'Yes) 99) true)
(check-expect (passed? (list 'Abstain 'Abstain 'No) 22) false)


