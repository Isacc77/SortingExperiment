#lang racket

;;1.Make a rational
(define (make-rational . args)
  (cond [(= (length args) 1)
            (list 'rational (first args) 1)
        ]
        [(= (length args) 2)
            (if (= (second args) 0)(error "invalid denominator")(apply list 'rational args))
        ]
        ))

(make-rational 9 5)
(make-rational 9)
(make-rational 9 2)

;;2. Get the numerator
(define r-numerator second)

(r-numerator (make-rational 9 5))

;;3.Get the denominator
(define r-denominator third)
(r-denominator (make-rational 9 5))


;;4.Get the numerator and denominator as a pair
(define num-denom rest)
(num-denom (make-rational 9 5))

;;5.Convert to a string
(define (to-string p)
  (string-append (~s (r-numerator p)) "/" (~s (r-denominator p))))

(to-string (make-rational 3 7))

;;6.Convert the fraction to a floating point value 
(define (to-float p)
  (/ (* (r-numerator p) 1.0) (r-denominator p))
  )

(to-float (make-rational 3 7))
(to-float (make-rational 1 2))
(to-float (make-rational 2 4))

;;7.Test for equality 
(define (r= p q)
  (= (to-float p) (to-float q)))

(r= (make-rational 1 2) (make-rational 2 4))
(r= (make-rational 3 2) (make-rational 2 4))

;;8.Test for order: less than
(define (r< p q)
  (< (to-float p) (to-float q)))

;;9.Test if an integer
(define (is-int? p)
  (integer? (to-float p))
  )

(is-int? (make-rational 3 7))
(is-int? (make-rational 8 2))
(is-int? (make-rational 4 4))

;;gcd 
(define (gcd num1 num2)
  (if (= (remainder num1 num2) 0) num2 (gcd num2 (remainder num1 num2)))
)

;;14.Reduce to lowest terms 
(define (to-lowest-terms p)
 (make-rational (/ (r-numerator p) (gcd (r-numerator p) (r-denominator p)))  (/ (r-denominator p) (gcd (r-numerator p) (r-denominator p))))
)

;;10.Add 
(define (r+ p q)
  (if (= (r-denominator p) (r-denominator q))
      (to-lowest-terms (make-rational (+ (r-numerator p) (r-numerator q)) (r-denominator q)))
       (to-lowest-terms (make-rational
       (+ (* (r-numerator p) (r-denominator q)) (* (r-numerator q) (r-denominator p)))
       (* (r-denominator p) (r-denominator q))))
       ))

'add
(r+ (make-rational 1 4) (make-rational 2 4))
(r+ (make-rational 3 5) (make-rational 2 7))
(r+ (make-rational 0 4) (make-rational 2 4))
(r+ (make-rational 2 4) (make-rational 4 8))
(r+ (make-rational 5 10) (make-rational 3 10))
'end

;;11.Multiply 
(define (r* p q)
  (to-lowest-terms (make-rational (* (r-numerator p) (r-numerator q)) (* (r-denominator p) (r-denominator q))))
)
'multiply
(r* (make-rational 1 4) (make-rational 2 4))
(r* (make-rational 3 5) (make-rational 2 7))
(r* (make-rational 0 4) (make-rational 2 4))
(r* (make-rational 5 25) (make-rational 5 5))
'end

;;13.Invert 
(define (invert p)
(if (= (r-numerator p) 0)
    (error "Cannot invert, invalid denominator")
    (make-rational (r-denominator p) (r-numerator p))
    )
)

(invert (make-rational 3 7))
(invert (make-rational 1 2))
;;(invert (make-rational 0 4))


;;12.Divide
(define (r/ p q)
  (to-lowest-terms(r* p (invert q)))
)

'divide
(r/ (make-rational 1 4) (make-rational 2 4))
(r/ (make-rational 3 5) (make-rational 2 7))
(r/ (make-rational 0 4) (make-rational 2 4))
'end 

 
'to-lowest-terms
(to-lowest-terms (make-rational 4 16))
(to-lowest-terms (make-rational 25 225))
(to-lowest-terms (make-rational 16 16))
'end 

;;15.Harmonic sum    
(define (harmonic-sum-helper n)
  (if (= n 1)
      1
      (if (> n 1)
          (+ (/ 1 n) (harmonic-sum-helper (- n 1)))
          (error 'undefined))))

(define (harmonic-sum n)
  (make-rational (numerator (harmonic-sum-helper n)) (denominator (harmonic-sum-helper n))))

'Harmonic-sum 
(harmonic-sum 1)
(harmonic-sum 2)
(harmonic-sum 3)
(harmonic-sum 4)
(harmonic-sum 5)
 'end

;;Insertion sort 

;;1.numbers 
(define (insertNum L M)
  (if (null? L) M
    (if (null? M) L
      (if (< (first L) (first M))
        (cons (first L) (insertNum (rest L) M))
        (cons (first M) (insertNum (rest M) L))
      )
    )
  )
)

(define (insertionSortNum L)
  (if (null? L) '()
    (insertNum (list (first L)) (insertionSortNum (rest L)))
  )
)


;;2.string
(define (insertionSortString-helper los sorted-los)
  (cond [(empty? sorted-los) (list los)]
        [(string<=? los (first sorted-los))
         (cons los sorted-los)]
        [else (cons (first sorted-los)
                    (insertionSortString-helper los (rest sorted-los)))]))

(define (insertionSortString los)
  (cond [(empty? los) empty]
        [else (insertionSortString-helper (first los) (insertionSortString (rest los)))]))

;;-------------------------
(insertionSortString (list "ZBDAB" "ZABCA" "BCE" "ADE"))

;;3.rational type
(define (insertRationalNum-helper L M)
  (if (null? L) M
    (if (null? M) L
      (if (r< (first L) (first M))
        (cons (first L) (insertRationalNum-helper (rest L) M))
        (cons (first M) (insertRationalNum-helper (rest M) L))
      )
    )
  )
)

(define (insertRationalNum L)
  (if (null? L) '()
    (insertRationalNum-helper (list (first L)) (insertRationalNum (rest L)))
  )
)

(insertRationalNum '((make-rational 2 5) (make-rational 4 8) (make-rational 1 5) (make-rational 7 8) (make-rational 1 8)))


;;Generate data
;; 1. num
(define (random-list n)
  (unless (exact-nonnegative-integer? n)
    (raise-argument-error 'make-list "exact-nonnegative-integer?" 0 n)
  )
  (let loop ([n n] [r '()])
    (if (zero? n) r 
      (loop (sub1 n) (cons (random 131072) r))
    )
  )
)

(insertionSortNum (random-list 10))

;; 2.string
(define charset (or (getenv "CHARSET")
                    "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"))

(define (select-random-item seq)
  (sequence-ref seq (random (sequence-length seq))))

(define (random-string [len 5])
  (list->string
    (map (λ (x) (select-random-item charset))
         (make-list len #f))))


(define (string-list len)
    (let loop ((len len) [r '()])
    (if (zero? len) r 
      (loop (sub1 len) (cons (random-string) r))
    )
  )
)

(string-list 5)
(insertionSortString (string-list 10))

;; 3.rational type
(define (random-list-rationalType n)
  (unless (exact-nonnegative-integer? n)
    (raise-argument-error 'make-list "exact-nonnegative-integer?" 0 n)
  )
  (let loop ([n n] [r '()])
    (if (zero? n) r 
      (loop (sub1 n) (cons (make-rational (random 6553611) (random 6553611) ) r))
    )
  )
)

;; time
;; Num

;;(time(random-list 10000)(void))
;;(time(string-list 10000)(void))
;;(time(random-list-rationalType 10000)(void))
 

'Num
'1000-times 
(time (insertionSortNum (random-list 1000))(void))
'2000-times 
(time (insertionSortNum (random-list 2000))(void))
'3000-times 
(time (insertionSortNum (random-list 3000))(void))
'4000-times 
(time (insertionSortNum (random-list 4000))(void))
'5000-times 
(time (insertionSortNum (random-list 5000))(void))
'6000-times 
(time (insertionSortNum (random-list 6000))(void))
'7000-times 
(time (insertionSortNum (random-list 7000))(void))
'8000-times 
(time (insertionSortNum (random-list 8000))(void))
'9000-times 
(time (insertionSortNum (random-list 9000))(void))
'10000-times 
(time (insertionSortNum (random-list 10000))(void))


;; string
'string
'1000-times 
(time (insertionSortString (string-list 1000))(void))
'2000-times 
(time (insertionSortString (string-list 2000))(void))
'3000-times
(time (insertionSortString (string-list 3000))(void))
'4000-times 
(time (insertionSortString (string-list 4000))(void))
'5000-times 
(time (insertionSortString (string-list 5000))(void))
'6000-times 
(time (insertionSortString (string-list 6000))(void))
'7000-times 
(time (insertionSortString (string-list 7000))(void))
'8000-times 
(time (insertionSortString (string-list 8000))(void))
'9000-times 
(time (insertionSortString (string-list 9000))(void))
'10000-times 
(time (insertionSortString (string-list 10000))(void))


;;rational type
'rational
'1000-times 
(time (insertRationalNum (random-list-rationalType 1000))(void))
'2000-times
(time (insertRationalNum (random-list-rationalType 2000))(void))
'3000-times
(time (insertRationalNum (random-list-rationalType 3000))(void))
'4000-times
(time (insertRationalNum (random-list-rationalType 4000))(void))
'5000-times
(time (insertRationalNum (random-list-rationalType 5000))(void))
'6000-times
(time (insertRationalNum (random-list-rationalType 6000))(void))
'7000-times
(time (insertRationalNum (random-list-rationalType 7000))(void))
'8000-times
(time (insertRationalNum (random-list-rationalType 8000))(void))
'9000-times
(time (insertRationalNum (random-list-rationalType 9000))(void))
'10000-times 
(time (insertRationalNum (random-list-rationalType 10000))(void))

