;-*-Lisp-*-

;; Axion is currently a source only lisp variant that should be able to be
;; interpreted by any other lisp or an already running Axion REPL. Currently
;; the minimum feature set is that of [sectorlisp](https://github.com/jart/sectorlisp),
;; and the default function names in the REPL are taken from it.
;; Compatibility is mostly dependent on basic functions defined in the Lisp 1.5
;; Programmer's Manual. These functions are listed here for completeness:
;; (cons car cdr quote cond lambda atom eq)
;;
;; Additionally the following functions (or equivalents) are needed for the REPL:
;; (read print)



;; The REPL implementation.
;; rprint and rread are named this way to avoid possible conflicts with
;; the base lisp print and read functions.
((lambda (assoc evcon pairlis evlis apply eval rprint rread)
  (rprint (eval (rread) ())))

;; The function definitions for the REPL
 ;; assoc
 (quote (lambda (x y)
   (cond
     ((eq y ()) ())
     ((eq x (car (car y))) (cdr (car y)))
     ((quote t) (assoc x (cdr y))))))

 ;; evcon
 (quote (lambda (c a)
          (cond
            ((eval (car (car c)) a) (eval (car (cdr (car c))) a))
            ((quote t) (evcon (cdr c) a)))))

 ;; pairlis
 (quote (lambda (x y a)
          (cond
            ((eq x ()) a)
            ((quote t) (cons (cons (car x) (car y))
                             (pairlis (cdr x) (cdr y) a))))))

 ;; evlis
 (quote (lambda (m a)
          (cond
            ((eq m ()) ())
            ((quote t) (cons (eval (car m) a)
                             (evlis (cdr m) a))))))

 ;; apply
 (quote (lambda (fn x a)
          (cond
            ((atom fn)
             (cond
               ((eq fn (quote car))  (car  (car x)))
               ((eq fn (quote cdr))  (cdr  (car x)))
               ((eq fn (quote atom)) (atom (car x)))
               ((eq fn (quote cons)) (cons (car x) (car (cdr x))))
               ((eq fn (quote eq))   (eq   (car x) (car (cdr x))))
               ((quote t)            (apply (eval fn a) x a))))
            ((eq (car fn) (quote lambda))
             (eval (car (cdr (cdr fn))) (pairlis (car (cdr fn)) x a))))))

 ;; eval
 (quote (lambda (e a)
          (cond
            ((atom e) (assoc e a))
            ((atom (car e)) (cond
                              ((eq (car e) (quote quote)) (car (cdr e)))
                              ((eq (car e) (quote cond)) (evcon (cdr e) a))
                              ((quote t) (apply (car e) (evlis (cdr e) a) a))))
            ((quote t) (apply (car e) (evlis (cdr e) a) a)))))

 ;; rprint
 (quote print)

 ;; rread
 (quote read)
)
