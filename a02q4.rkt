;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname a02q4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; *****************************************************
;; CS 116 Assignment 02, Question 4
;; JunHao Jia 
;; (Average Amount of Taxes Calculation)
;; *****************************************************

;; A Taxpayer is a structure (make-taxpayer inc c), where
;; inc is a non-negative number (the taxpayer's income), and
;; c is a function (Num -> Num) that consumes an nonnegative
;;   income and produces the nonnegative amount of taxes 
;;   owed on that income
(define-struct taxpayer (income calculation))


;; average-taxes: (listof Taxpayer) -> Num
;; Precondition: If lotp is empty, then 0 is produced.
;; Purpose: Produces the average amount of taxes owed for all taxpayers in lotp.
;; Examples: 
;; (average-taxes (list 
;;                 (make-taxpayer 70000 (lambda (a) (+ 6593 (* 0.22 (- a 43953)))))
;;                 (make-taxpayer 0 (lambda (a) (* 0.15 a)))
;;                 (make-taxpayer 140000 (lambda (a) (+ 28837 
;;                                                      (* 0.29 (- a 136270)))))))
;;              => 14080.68
;; (average-taxes empty) => 0

(define (average-taxes lotp)
  (cond
    ((empty? lotp) 0)
    (else
     (/ (foldr + 0 (map (lambda (i) ((taxpayer-calculation i) (taxpayer-income i))) lotp))
        (length lotp)))))

;; Tests for average-taxes
(check-expect (average-taxes 
               (list 
                (make-taxpayer 70000 (lambda (a) (+ 6593 (* 0.22 (- a 43953)))))
                (make-taxpayer 0 (lambda (a) (* 0.15 a)))
                (make-taxpayer 140000 (lambda (a) (+ 28837 
                                                     (* 0.29 (- a 136270)))))))
              14080.68)
(check-expect (average-taxes empty) 0)
(check-within (average-taxes 
               (list 
                (make-taxpayer 5678 (lambda (a) (+ 659 (* 0.22 (- a 4395)))))
                (make-taxpayer 0 (lambda (a) (* 99 a))))) 470.6 0.1)
(check-within (average-taxes 
               (list 
                (make-taxpayer 3333 (lambda (a) (* 0.15 a)))
                (make-taxpayer 223453 (lambda (a) (+ 232
                                                     (* 0.29 (- a 216270))))))) 1407.5 0.1)

