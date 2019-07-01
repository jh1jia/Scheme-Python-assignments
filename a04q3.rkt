;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname a04q3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ())))
;; *****************************************************
;; CS 116 Assignment 04, Question 3
;; JunHao Jia 
;; (Reset the Game Mastermind)
;; *****************************************************

;; A Colour is one of the Symbols
;; 'red 'blue 'green 'yellow 'orange 'black 'white 'purple

;; A Guess is a (make-guess c e cl), where
;; * c is a (listof Colour) of length 4, containing 
;;   the player's guess at the secret code
;; * e is a Nat <= 4, correspondng to the number of 
;;   places in which guess and secret are the same colour
;; * cl is a Nat <= 4, corresponding to the number
;;   of colours in common between this guess and exact
;;   in different positions (does not include exact matches)
;; Additional conditions: 
;; * 0 <= e+cl <= 4
;; * A colour can only appear once in c
(define-struct guess (code exact colours))

;; remaining-guesses - of type Nat 
;; - number of guesses remaining for the current game
(define remaining-guesses (void))
;; secret - of type (list Colour Colour Colour Colour)
;; - secret code to be guesses
;; - contains 4 different colours
(define secret (void))
;; history - of type (listof Guess)
;; - all guesses (codes and feedback hints of exact and colour matches)
;; - most recent guess is at the front of the list
(define history (void))

;; reset: Symbol Secret -> (void)
;; Purpose: Produces (void)
;; Effects: As a result of calling reset, the following mutations occur:
;; * secret is set to secret-code
;; * history is set to empty
;; * remaining-guesses is set to 20 if level is 'Easy, 15 if level is 'Medium,
;; 10 if level is 'Advanced, and 5 if level is 'Expert.
;; Examples: 
;; If level is 'Easy, secret-code is (list 'red 'blue 'green 'yellow), calling
;; (reset 'Easy (list 'red 'blue 'green 'yellow))
;; => (void) and secret is set to (list 'red 'blue 'green 'yellow), history is 
;; set to empty, and remaining-guesses is set to 20.

;; If level is 'Expert, secret-code is (list 'orange 'black 'white 'purple), calling
;; (reset 'Easy (list 'orange 'black 'white 'purple))
;; => (void) and secret is set to (list 'orange 'black 'white 'purple), history is 
;; set to empty, and remaining-guesses is set to 5.

(define (reset level secret-code)
  (begin
  (set! secret secret-code)
  (set! history empty)
  (set! remaining-guesses
        (cond
          ((equal? level 'Easy) 20)
          ((equal? level 'Medium) 15)
          ((equal? level 'Advanced) 10)
          (else 5)))))

;; Tests for reset
(check-expect
 (begin
   (set! secret (void)) (set! history (void)) (set! remaining-guesses (void))
   (reset 'Easy (list 'red 'blue 'green 'yellow))
   (list secret history remaining-guesses))
 (list (list 'red 'blue 'green 'yellow) empty 20))
(check-expect
 (begin
   (set! secret (void)) (set! history (void)) (set! remaining-guesses (void))
   (reset 'Expert (list 'orange 'black 'white 'purple))
   (list secret history remaining-guesses))
 (list (list 'orange 'black 'white 'purple) empty 5))
(check-expect
 (begin
   (set! secret (void)) (set! history (void)) (set! remaining-guesses (void))
   (reset 'Medium (list 'orange 'green 'white 'purple))
   (list secret history remaining-guesses))
 (list (list 'orange 'green 'white 'purple) empty 15))
(check-expect
 (begin
   (set! secret (void)) (set! history (void)) (set! remaining-guesses (void))
   (reset 'Advanced (list 'blue 'black 'white 'red))
   (list secret history remaining-guesses))
 (list (list 'blue 'black 'white 'red) empty 10))

   
 
 