;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname a04q2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ())))
;; *****************************************************
;; CS 116 Assignment 04, Question 2
;; JunHao Jia 
;; (Top3 Calculation)
;; *****************************************************

;; A Top3 is a structure (make-top3 f s t), where
;; f,s,t, are each positive numbers, where f <= s <= t,
;; and correspond to the first fastest, second fastest,
;; and third fastest times for some event.
(define-struct top3 (first second third))

;; update-top3: Top3 Num -> Symbol
;; Precondition: new-time > 0
;; Purpose: Produces a Symbol(one of 'first 'second 'third 
;; 'not-ranked) indicating new-time's placement in current3.
;; Effects: Mutates current3 to include new-time in
;; the appropriate Top3 position. 
;;    If current3 is (make-top3 f s t), then update-top3 will:
;; * Produce 'first and mutate current3 to (make-top3 new-time f s)
;; if new-time <= f.
;; * Produce 'second and mutate current3 to (make-top3 f new-time s)
;; if f < new-time <= s.
;; * Produce 'third and mutate current3 to (make-top3 f new-time s) 
;; if s < new-time <= t.
;; * Produce 'not-ranked if new-time > t.
;; Examples: 
;; If my3 is (make-top3 9.95 10.01 10.02), calling (update-top3 my3 9.87)
;; => 'first and mutates my3 to (make-top3 9.87 9.95 10.01)
;; If my3 is (make-top3 19.80 19.97 19.99), calling (update-top3 my3 19.87)
;; => 'second and mutates my3 to (make-top3 19.80 19.87 19.97)
;; If my3 is (make-top3 40.0 40.1 40.2), calling (update-top3 my 52.4) =>
;; 'not-ranked and does not change my3.

(define (update-top3 current3 new-time)
  (local
    (;; print: (void) -> Symbol
     ;; Purpose: produces a Symbol indicating new-time's placement in 
     ;; current3.
     (define (print)
       (cond
         ((equal? new-time (top3-first current3)) 'first)
         ((equal? new-time (top3-second current3)) 'second)
         ((equal? new-time (top3-third current3)) 'third)
         (else 'not-ranked)))
     ;; rank: (void) -> (void)
     ;; Purpose: mutates current3 to include new-time in the appropriate 
     ;; Top3 position.
     (define (rank)
       (cond
         ((<= new-time (top3-first current3))
          (begin
          (set-top3-third! current3 (top3-second current3))
          (set-top3-second! current3 (top3-first current3))
          (set-top3-first! current3 new-time)))
         ((<= new-time (top3-second current3))
          (begin
          (set-top3-third! current3 (top3-second current3))
          (set-top3-second! current3 new-time)))
         ((<= new-time (top3-third current3))
          (set-top3-third! current3 new-time))
         (else
          (void)))))
     (begin
       (rank)
       (print))))

;; Tests for update-top3
;; define constants for testing
(define my3 (void))

;; Test new-time <= (top3-first my3)
(check-expect 
 (begin
   (set! my3 (make-top3 9.95 10.01 10.02))
   (list (update-top3 my3 9.87) my3))
 (list 'first (make-top3 9.87 9.95 10.01)))

;; Test f < new-time <= (top3-second my3)
(check-expect
 (begin
   (set! my3 (make-top3 19.80 19.97 19.99))
   (list (update-top3 my3 19.87) my3))
 (list 'second (make-top3 19.80 19.87 19.97)))

;; Test s < new-time <= (top3-third my3)
(check-expect
 (begin
   (set! my3 (make-top3 19.80 19.97 19.99))
   (list (update-top3 my3 19.98) my3))
 (list 'third (make-top3 19.80 19.97 19.98)))

;; Test new-time > (top3-third my3)
(check-expect
 (begin
   (set! my3 (make-top3 40.0 40.1 40.2))
   (list (update-top3 my3 52.4) my3))
 (list 'not-ranked (make-top3 40.0 40.1 40.2)))
   
  