(in-package #:tempc)

(deftemp html-arg (name val)
  " " name (if val (concatenate 'string "=" "\"" (princ-to-string val) "\"")))

(defun html-arg* (&rest args)
  (when args
    (if (evenp (length args))
        (mapcam #'html-arg 2 args)
        (error "HTML-ARG* takes only even number of arguments!"))))

(deftemp one-side-tag (name &rest args)
  "<" name (when args (apply #'html-arg* args)) ">")

(deftemp two-side-tags (name body &optional args)
  "<" name (when args (apply #'html-arg* args)) ">"
  body
  "</" name ">")

(defun html (body &rest args)
  (two-side-tags "html" body args))
(defun head (body &rest args)
  (two-side-tags "head" body args))
(defun body (body &rest args)
  (two-side-tags "body" body args))
(defun title (title)
  (two-side-tags "title" title))
(defun div (body &rest args)
  (two-side-tags "div" body args))
(defun li (item &rest args)
  (two-side-tags "li" item args))
(defun ul (lst &rest args)
  (two-side-tags "ul"
                 (mapcar #'(lambda (x)
                             (if (listp x)
                                 (apply #'li x)
                                 (li x)))
                         lst)
                 args))
