(in-package #:tempc)

(defun mapcam (f n lst)
  (if (null lst)
      nil
      (if (not (zerop (mod (length lst) n)))
          (error "The length of list: ~A is not a multiple of number: ~A" (length lst) n)
          (cons (apply f (subseq lst 0 n))
                (mapcam f n (nthcdr n lst))))))

(defun flatten (lst)
  (if (null lst)
      nil
      (if (atom (car lst))
          (cons (car lst) (flatten (cdr lst)))
          (append (flatten (car lst)) (flatten (cdr lst))))))

(defmacro with-gensyms ((&rest sym) &body body)
  `(let ,(loop :for s :in sym :collect `(,s (gensym)))
     ,@body))

;;; Basic Syntax
;;; (deftemp name (arg1 arg2)
;;;     "str"
;;;     (f arg1)
;;;     (g arg2))

(defmacro deftemp (name (&rest args) &body body)
  `(defun ,name (,@args)
     (concatenate
      'string
      ,@(loop :for s :in body
              :collect (cond ((stringp s) s)
                             (t `(princ-to-string (cond
                                                    ((null ,s) "")
                                                    (t ,s)))))))))

(defmacro -> (&body body)
  `(list ,@(loop :for s :in body :collect s)))
