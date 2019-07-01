;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname a03q4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ())))
;; *****************************************************
;; CS 116 Assignment 03, Question 4
;; JunHao Jia 
;; (Most Popular Film Genre Calculation)
;; *****************************************************

;; A Movie is a structure (make-movie t g s), where
;; t is a nonempty string (title of the movie)
;; g is a nonempty string (genre of the movie, e.g. "drama", "comedy", 
;;   "family", etc.) 
;; s is a list of nonempty strings (stars of the movie)
(define-struct movie (title genre stars))

;; favourite-genre: (listof Movie) -> String
;; Precondition: consumes a nonempty list of Movie structures.
;;               assumes that no ties for the most popular genre.
;; Purpose: consumes a nonempty list of Movie structures, and produces a String
;; corresponding to the genre that occurs most often in collection.
;; Examples: 
;; (favourite-genre (list (make-movie "Casablanca" "drama"
;;                                    (list "Humphrey bogart" "Ingrid Bergman"
;;                                          "Peter Lorre"))
;;                        (make-movie "North by Northwest" "drama"
;;                                    (list "Cary Grant" "Eva Marie Saint"
;;                                          "James Mason"))
;;                        (make-movie "Arsenic and Old Lace" "comedy"
;;                                    (list "Cary Grant" "Priscilla Lane"
;;                                          "Peter Lorre")))) => "drama"

(define (favourite-genre collection)
  (local
    (;; biggest: (list String Nat) (list String Nat) -> (list String Nat)
     ;; Purpose: produce the list which the Number in the list is bigger than 
     ;; another. 
     (define (biggest list-a list-b)
       (cond
         ((> (second list-a) (second list-b)) list-a)
         (else list-b)))
     
     ;; g-list is the list of movie genres(String) which in the alphabetic order.
     (define g-list
       (local
         (;; all-genre: (listof Movie) -> (listof String)
          ;; Purpose: produces a list of movie genres(String).
          (define (all-genre c)
            (cond
              ((empty? c) empty)
              (else
               (cons (movie-genre (first c))
                     (all-genre (rest c)))))))
         (quicksort (all-genre collection) string<?)))
     
     ;; count: (listof String) (list String Nat) (list String Nat) 
     ;;                                                    -> (list String Nat)
     ;; Purpose: produce the list which the genre(String) is most popular.
     (define (count g-list ac1 ac2)
       (cond
         ((empty? (rest g-list)) (biggest ac1 ac2))
         ((equal? (first g-list) (second g-list))
          (count (rest g-list) (list (first ac1) (+ 1 (second ac1))) ac2))
         (else
          (count (rest g-list) (list (second g-list) 1) (biggest ac1 ac2))))))
    
    (first (count g-list (list (first g-list) 1) (list (first g-list) 0)))))

;; Tests for favourite-genre
(check-expect 
 (favourite-genre (list 
                   (make-movie "Casablanca" "drama"
                               (list "Humphrey bogart" "Ingrid Bergman"
                                     "Peter Lorre"))
                   (make-movie "North by Northwest" "drama"
                               (list "Cary Grant" "Eva Marie Saint"
                                     "James Mason"))
                   (make-movie "Arsenic and Old Lace" "comedy"
                               (list "Cary Grant" "Priscilla Lane"
                                     "Peter Lorre")))) "drama")
(check-expect 
 (favourite-genre (list               
                   (make-movie "Arsenic and Old Lace" "comedy"
                               (list "Cary Grant" "Priscilla Lane"
                                     "Peter Lorre")))) "comedy")
(check-expect 
 (favourite-genre (list 
                   (make-movie "Maleficent" "Action"
                               (list "Angelina Jolie" "Elle Fanning"
                                     "Brenton Thwaites"))
                   (make-movie "Casablanca" "drama"
                               (list "Humphrey bogart" "Ingrid Bergman"
                                     "Peter Lorre"))
                   (make-movie "North by Northwest" "drama"
                               (list "Cary Grant" "Eva Marie Saint"
                                     "James Mason"))
                   (make-movie "Godzilla" "Action"
                               (list "Bryan Cranston" "Aaron Taylor"
                                     "Elizabeth Olsen"))
                   (make-movie "Arsenic and Old Lace" "comedy"
                               (list "Cary Grant" "Priscilla Lane"
                                     "Peter Lorre"))
                   (make-movie "Spiderman" "Action"
                               (list "Andrew Garfield" "Emma Stone"
                                     "Dane DeHaan")))) "Action")
