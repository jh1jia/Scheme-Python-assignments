;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname a03q3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ())))
;; *********************************************************
;; CS 116 Assignment 03, Question 3
;; JunHao Jia 
;; (Produces a list of movies in which the performer stars)
;; *********************************************************

;; A Movie is a structure (make-movie t g s), where
;; t is a nonempty string (title of the movie)
;; g is a nonempty string (genre of the movie, e.g. "drama", "comedy", 
;;   "family", etc.) 
;; s is a list of nonempty strings (stars of the movie)
(define-struct movie (title genre stars))


;; starring-in: (listof Movie) String -> (listof String)
;; Postcondition: The movie titles in the produced list must be in the same
;; relative order as they appear in collection.
;; Purpose: consumes collection(a list of Movie),performer(a string), and 
;; produces the list of movies in collection in which the performer stars.
;; Example: 
;; (starring-in (list 
;;               (make-movie "Casablanca" "drama"
;;                           (list "Humphrey bogart" "Ingrid Bergman"
;;                                 "Peter Lorre"))
;;               (make-movie "North by Northwest" "drama"
;;                           (list "Cary Grant" "Eva Marie Saint"
;;                                 "James Mason"))
;;               (make-movie "Arsenic and Old Lace" "comedy"
;;                           (list "Cary Grant" "Priscilla Lane"
;;                                 "Peter Lorre")))
;;              "Peter Lorre") =>
;; (list "Casablanca" "Arsenic and Old Lace")

(define (starring-in collection performer)
  (local
    (;; find-movies: (listof Movie) (listof String) -> (listof String)
     ;; Purpose: produces the list of movies in collection in which the 
     ;; performer stars.
     (define (find-movies collection list-movie)
       (cond
         ((empty? collection) list-movie)
         ((member? performer (movie-stars (first collection)))
          (find-movies (rest collection) 
                       (append list-movie 
                               (list (movie-title (first collection))))))
         (else
          (find-movies (rest collection) list-movie)))))
    
    (find-movies collection empty)))

;; Tests for starring-in
(check-expect 
 (starring-in (list 
               (make-movie "Casablanca" "drama"
                           (list "Humphrey bogart" "Ingrid Bergman"
                                 "Peter Lorre"))
               (make-movie "North by Northwest" "drama"
                           (list "Cary Grant" "Eva Marie Saint"
                                 "James Mason"))
               (make-movie "Arsenic and Old Lace" "comedy"
                           (list "Cary Grant" "Priscilla Lane"
                                 "Peter Lorre")))
              "Peter Lorre")
 (list "Casablanca" "Arsenic and Old Lace"))
(check-expect (starring-in empty "Max") empty)
(check-expect 
 (starring-in (list 
               (make-movie "Casablanca" "drama"
                           (list "Humphrey bogart"))) "Bob") empty)
(check-expect 
 (starring-in (list 
               (make-movie "Casablanca" "drama"
                           (list "Humphrey bogart" "Ingrid Bergman"
                                 "Peter Lorre"))
               (make-movie "North by Northwest" "drama"
                           (list "Cary Grant" "Eva Marie Saint"
                                 "James Mason"))
               (make-movie "Arsenic and Old Lace" "comedy"
                           (list "Cary Grant" "Priscilla Lane"
                                 "Peter Lorre"))) "James Mason")
 (list "North by Northwest"))
 
 
 
 