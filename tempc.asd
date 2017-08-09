(in-package :asdf)

(defsystem #:tempc
  :name "TempC"
  :version '(0 0 1)
  :author "Z-Shang <shangzhanlin@gmail.com>"
  :description "A Template Combinator Library for Common Lisp"
  :depends-on (:common-lisp)
  :components ((:file "package")
               (:file "core")
               (:file "html-basic")
               )
  )
