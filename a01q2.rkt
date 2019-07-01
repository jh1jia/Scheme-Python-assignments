;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname a01q2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; *****************************************************
;; CS 116 Assignment 01, Question 2
;; JunHao Jia 
;; (Replace the character of string)
;; *****************************************************

;; replace-char: String Char Char -> String
;; Purpose: consumes a string(original) and two characters
;; (original-ch and replace-ch, and produces a new string
;; that all occurrences of original-ch are relpaced with replace-ch.
;; Examples: 
;; (replace-char "ABBA" #\A #\a) => "aBBa"
;; (replace-char "ABBA" #\a #\Z) => "ABBA"

(define (replace-char original original-ch replace-ch)
  (local
    (;; change: Char -> Char
     ;; Purpose: consumes a character(char) and produces replace-ch
     ;; if the char is equal to original-ch, otherwise produces char.
     (define (change char)
       (cond
         ((equal? char original-ch) replace-ch)
         (else char))))
    
    (list->string (map change (string->list original)))))

;; Tests for replace-char
(check-expect (replace-char "ABBA" #\A #\a) "aBBa")
(check-expect (replace-char "ABBA" #\a #\Z) "ABBA")
(check-expect (replace-char "" #\a #\Z) "")
(check-expect (replace-char "abc" #\a #\A) "Abc")
(check-expect (replace-char "ABB" #\B #\A) "AAA")
                            
             
         