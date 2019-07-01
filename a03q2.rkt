;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname a03q2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ())))
;; *****************************************************
;; CS 116 Assignment 03, Question 2
;; JunHao Jia 
;; (Longest Unbeaten Streak Calculation)
;; *****************************************************

;; longest-unbeaten-streak: (listof Symbol) -> Nat
;; Precondition: Symbol is one of 'win, 'loss, 'tie.
;; Purpose: consumes results(a list of symbols), produces the length
;; of the longest unbeaten streak in the results.
;; Examples: 
;; (longest-unbeaten-streak (list 'loss 'loss)) => 0
;; (longest-unbeaten-streak (list 'loss 'tie 'loss)) => 1
;; (longest-unbeaten-streak (list 'loss 'win 'win 'tie 'loss
;;                                              'tie 'win)) => 3

(define (longest-unbeaten-streak results)
  (local
    (;; longest: (listof Symbol) Nat Nat -> Nat
     ;; produces the length of the longest unbeaten streak 
     ;; in the results.
     (define (longest results unbeaten-streak-one unbeaten-streak-two)
       (cond
         ((empty? results) 
          (max unbeaten-streak-one unbeaten-streak-two))
         ((equal? (first results) 'loss)
          (longest (rest results) 0 
                   (max unbeaten-streak-one unbeaten-streak-two)))
         (else
          (longest (rest results) 
                   (+ unbeaten-streak-one 1) unbeaten-streak-two)))))
    
    (longest results 0 0)))

;; Tests for longest-unbeaten-streak
(check-expect (longest-unbeaten-streak (list 'loss 'loss)) 0)
(check-expect (longest-unbeaten-streak (list 'loss 'tie 'loss)) 1)
(check-expect (longest-unbeaten-streak (list 'loss 'win 'win 'tie 'loss
                                             'tie 'win)) 3)
(check-expect (longest-unbeaten-streak (list 'loss)) 0)
(check-expect (longest-unbeaten-streak empty) 0)
(check-expect (longest-unbeaten-streak (list 'win)) 1)
(check-expect (longest-unbeaten-streak (list 'loss 'win 'loss 'tie 'tie
                                             'tie 'win 'loss)) 4)
