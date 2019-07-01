;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname a02q1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; *****************************************************
;; CS 116 Assignment 02, Question 1
;; JunHao Jia 
;; (A List of Date Calculation)
;; *****************************************************

;; A Date is a structure (make-date y m d), where
;; y is positive integer (year),
;; m is an integer between 1 and 12 (month),
;; d is an integer between 1 and 31 (day of the month).
(define-struct date (year month day))


;; build-dates: Int Int Nat -> (listof Date)
;; Conditions:
;;    PRE: 1 <= month <= 12
;;         0 <= num-days <= 31
;;    POST: If num-days is 0, the empty list is produced.
;; Purpose: Produces a list of Date structures corresponding to the first
;;          num-days of the specified month in the specified year.
;; Examples: 
;; (build-dates 2014 5 3) => (list (make-date 2014 5 1) (make-date 2014 5 2) 
;; (make-date 2014 5 3))
;; (build-dates 2014 6 0) => empty

(define (build-dates year month num-days)
  (build-list num-days (lambda (i) (make-date year month (+ i 1)))))

;; Tests for build-dates
(check-expect (build-dates 2014 5 3) 
              (list (make-date 2014 5 1) (make-date 2014 5 2) (make-date 2014 5 3)))
(check-expect (build-dates 2014 6 0) empty)
(check-expect (build-dates 2000 12 5)
              (list (make-date 2000 12 1) (make-date 2000 12 2) (make-date 2000 12 3)
                    (make-date 2000 12 4) (make-date 2000 12 5)))
(check-expect (build-dates 2222 1 1) (list (make-date 2222 1 1)))