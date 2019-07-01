;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname a04q4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ())))
;; *****************************************************
;; CS 116 Assignment 04, Question 4
;; JunHao Jia 
;; (Game Mastermind)
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


;; State variables:
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

;; process-guess: (list Colour Colour Colour Colour) -> (union String History)
;; Precondition: new-code is a list containing 4 different Colour.
;; Purpose: Produces either a message about the outcome of the game or a list
;; of all guesses.
;; Effects: If new-code matches secret exactly, then a winning message is produced:
;; "Congratulations - you are correct!"
;;          If new-code does not match secret exactly, and the new value of remaining-
;; guesses is 0, a losing message is produced: "Sorry - you ran out of guesses."
;;          If new-code does not match secret exactly, and there are guesses remaining,
;; then history is produced by process-guess.
;; Examples: 
;; Suppose history is empty, remaining-guesses is 15, and secret is (list 'red 'blue
;; 'black 'green)), then (process-guess (list 'red 'blue 'black 'green)) => Sets 
;; remaining-guesses to 14. Sets history to (list (make-guess (list 'red 'blue 'black
;; 'green) 4 0)), and produces "Congratulations - you are correct!"

;; Suppose history is (list (make-guess (list 'red 'orange 'green 'white) 1 1), 
;; remaining-guesses is 4, and secret is (list 'red 'blue
;; 'black 'green)), then (process-guess (list 'yellow 'orange 'white 'red)) => Sets 
;; remaining-guesses to 3. Sets history to (list (make-guess (list 'yellow 'orange 
;; 'white 'red) 0 1) (make-guess (list 'red 'orange 'green 'white) 1 1)), and produces
;; history.

(define (process-guess new-code)
  (local
    (;; string messages for end of game
     (define won "Congratulations - you are correct!")
     (define lost "Sorry - you ran out of guesses.")
     ;; guess-result: (void) -> (void)
     ;; Purpose: Produces a list of a Guess structure.
     (define (guess-result)
       (local
         ((define (count new-code secret a b new-code-copy secret-copy)
            (cond
              ((empty? new-code)
               (list  (make-guess new-code-copy a b)))
              ((equal? (first new-code) (first secret))
               (count (rest new-code) (rest secret) (+ 1 a) b new-code-copy secret-copy))
              ((member? (first new-code) secret-copy)
               (count (rest new-code) (rest secret) a (+ 1 b) new-code-copy secret-copy))
              (else
               (count (rest new-code) (rest secret) a b new-code-copy secret-copy)))))
         (count new-code secret 0 0 new-code secret)))
     ;; final-result: (void) -> (void)
     ;; purpose: Produces either a message about the outcome of the game or a list of all
     ;; guesses.
     (define (final-result)
       (cond
         ((= (guess-exact (first history)) 4) won)
         ((= remaining-guesses 0) lost)
         (else history))))
    (begin
      (set! remaining-guesses (- remaining-guesses 1))
      (set! history (append (guess-result) history))
      (final-result))))

;; Tests for process-guess
(check-expect 
 (begin
   (set! history empty)
   (set! remaining-guesses 15)
   (set! secret (list 'red 'blue 'black 'green))
   (list (process-guess (list 'red 'blue 'black 'green)) remaining-guesses
         history)) (list "Congratulations - you are correct!" 14 
                         (list (make-guess (list 'red 'blue 'black 'green) 4 0))))

(check-expect 
 (begin
   (set! history empty)
   (set! remaining-guesses 1)
   (set! secret (list 'red 'orange 'black 'green))
   (list (process-guess (list 'red 'orange 'black 'green)) remaining-guesses
         history)) (list "Congratulations - you are correct!" 0
                         (list (make-guess (list 'red 'orange 'black 'green) 4 0))))

(check-expect
 (begin
   (set! history (list (make-guess (list 'red 'orange 'green 'white) 1 1)))
   (set! remaining-guesses 4)
   (set! secret (list 'red 'blue 'black 'green))
   (list (process-guess (list 'yellow 'orange 'white 'red)) remaining-guesses))
 (list (list (make-guess (list 'yellow 'orange 'white 'red) 0 1) 
             (make-guess (list 'red 'orange 'green 'white) 1 1)) 3))

(check-expect 
 (begin
   (set! history empty)
   (set! remaining-guesses 1)
   (set! secret (list 'red 'blue 'black 'green))
   (list (process-guess (list 'red 'orange 'black 'green)) remaining-guesses
         history)) (list "Sorry - you ran out of guesses." 0
                         (list (make-guess (list 'red 'orange 'black 'green) 3 0))))




