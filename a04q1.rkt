;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname a04q1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ())))
;; *****************************************************
;; CS 116 Assignment 04, Question 1
;; JunHao Jia 
;; (State Variables Modification)
;; *****************************************************

(define-struct node (left value right))
;; A Node is a structure (make-node l v r), where
;; l,v,r are of Any type.

;; s,t,l,r are several defined variables for this question.
(define s (void))
(define t (void))
(define l (void))
(define r (void))


;; part-a: (void) -> (void)
;; Purpose: produces (void)
;; Effects: Sets the values to global variables s,t,l,r as noted on the 
;; assignment page: s to 3, l to (make-node (void) 25 (void)), r to
;; (make-node (void) 75 (void)), t to (make-node l 50 r).
(define (part-a)
  (begin
    (set! s 3)
    (set! l (make-node (void) 25 (void)))
    (set! r (make-node (void) 75 (void)))
    (set! t (make-node l 50 r))))
;; Test for part-a
(check-expect
 (begin
   (set! s (void)) (set! t (void)) (set! l (void)) (set! r (void))
   (part-a)
   (list s l r t))
 (list 3 (make-node (void) 25 (void)) (make-node (void) 75 (void))
       (make-node (make-node (void) 25 (void)) 50 
                  (make-node (void) 75 (void)))))


;; part-b: (void) -> (void)
;; Purpose: produces (void)
;; Effects: Changes the values of s,t,l,r as follows:
;; s is "?", t is (make-node (make-node 50 0 50) 1 (make-node "!" 2 "?")), 
;; l is (make-node "!" 2 "?"), r is (lambda (x) (even? (+ 1 x)))
(define (part-b)
  (begin
    (set-node-left! t 50)
    (set-node-value! t 0)
    (set-node-right! t 50)
    (set-node-left! r "!")
    (set-node-value! r 2)
    (set-node-right! r "?")
    (set-node-left! l t)
    (set-node-value! l 1)
    (set-node-right! l r)
    (set! s (node-right r))
    (set! t l)
    (set! l r)
    (set! r (lambda (x) (even? (+ 1 x))))))
;; Test for part-b
(check-expect
 (begin
   (set! s (void)) (set! t (void)) (set! l (void)) (set! r (void))
   (part-a)
   (part-b)
   (list s t l (r 1)))
 (list "?" (make-node (make-node 50 0 50) 1 (make-node "!" 2 "?"))
       (make-node "!" 2 "?") true))

