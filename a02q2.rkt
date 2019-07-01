;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname a02q2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; *****************************************************
;; CS 116 Assignment 02, Question 2
;; JunHao Jia 
;; (Produces a list by a specified way)
;; *****************************************************

;; tridiagonal: Int -> (listof List)
;; Precondition: n > 2
;; Purpose: Produces a list containing n lists, where each of the element
;; lists have length n, and have at most 3 nonzero values.
;; Examples: 
;; (tridiagonal 3) => (list (list 2 1 0) (list 1 2 1) (list 0 1 2))
;; (tridiagonal 5) => (list (list 2 1 0 0 0) (list 1 2 1 0 0) 
;;                    (list 0 1 2 1 0) (list 0 0 1 2 1) (list 0 0 0 1 2))

(define (tridiagonal n)
  (build-list n (lambda (i) 
                  (build-list n (lambda (ii) 
                                  (cond
                                    ((= i (- ii 1)) 1)
                                    ((= i ii) 2)
                                    ((= i (+ ii 1)) 1)
                                    (else 0)))))))

;; Tests for tridiagonal
(check-expect (tridiagonal 3)
              (list (list 2 1 0) (list 1 2 1) (list 0 1 2)))
(check-expect (tridiagonal 5)
              (list (list 2 1 0 0 0) (list 1 2 1 0 0) (list 0 1 2 1 0)
                    (list 0 0 1 2 1) (list 0 0 0 1 2)))
(check-expect (tridiagonal 8)
              (list (list 2 1 0 0 0 0 0 0) (list 1 2 1 0 0 0 0 0) (list 0 1 2 1 0 0 0 0)
                    (list 0 0 1 2 1 0 0 0) (list 0 0 0 1 2 1 0 0) (list 0 0 0 0 1 2 1 0)
                    (list 0 0 0 0 0 1 2 1) (list 0 0 0 0 0 0 1 2)))
