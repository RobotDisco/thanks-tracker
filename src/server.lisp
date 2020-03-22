;;;; The server handlers for kudos-tracker.

(defpackage thanks-tracker-server
  (:documentation "The server handlers for kudos-tracker.")
  (:use :cl)
  (:export #:-run))

(in-package :thanks-tracker-server)

(defun -run ()
  (hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 5000))
  (hunchentoot:define-easy-handler (slash-command :uri "/") (command text)
    (setf (hunchentoot:content-type*) "application/json")
    (json:encode-json-alist-to-string (list
				       (cons 'text "Your gratitude has been stored :)")
				       (cons 'username "thanks-tracker")))))

; (defun -stop ())
