;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname a02q3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; *****************************************************
;; CS 116 Assignment 02, Question 3
;; JunHao Jia 
;; (Replace the character of string)
;; *****************************************************

;; replace-char-fn: (String -> Function) Char Char -> Stirng
;; Postcondition: The produced function consumess two character parameters,
;;                old and new.
;; Purpose: produces a string which have the same length as s, but with all 
;;          occurrences(if any) of old replaced with new.
;; Examples: 
;; ((replace-char-fn "HOLLY") #\L #\P) => "HOPPY"
;; ((replace-char-fn "abc") #\A #\x) => "abc"


(define (replace-char-fn s)
  (lambda (old new)
    (list->string (map (lambda (c)
                         (cond
                           ((equal? c old) new) (else c))) 
                       (string->list s)))))



;; Tests for replace-char-fn
(check-expect ((replace-char-fn "ABBA") #\A #\a) "aBBa")
(check-expect ((replace-char-fn "ABBA") #\a #\Z) "ABBA")
(check-expect ((replace-char-fn "") #\a #\Z) "")
(check-expect ((replace-char-fn "abc") #\a #\A) "Abc")
(check-expect ((replace-char-fn "ABB") #\B #\A) "AAA")
(check-expect ((replace-char-fn "HOLLY") #\L #\P) "HOPPY")
(check-expect ((replace-char-fn "abc") #\A #\x) "abc")