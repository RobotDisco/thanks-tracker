(defpackage thanks-tracker
  (:use :cl)
  (:export :make-doc
	   :thankee
	   :kudos
	   :-main))

(in-package :thanks-tracker)

(defun -main (&optional args)
  (format t "~a~%" "I dont do much yet."))

(defparameter gaelan-doc '((_id . "gaelan@tulip.com")
			   (kudos . (((_id . "gaelan@tulip.com")
				      (message . "for doing absolutely nothing.")
				      (date . (2020 3 7)))))))

(defun make-doc (id)
  (list (cons '_id id)
	(cons 'kudos ())))

(defun thankee (doc)
  (cdr (assoc '_id doc)))

(defun kudos (doc)
  (cdr (assoc 'kudos doc)))

;; TODO find a reasonable way to map two symbols to the same lambda (thankee and kudos-thanker are the same function right now)
(defun kudos-thanker (doc)
  (thankee doc))

(defun kudos-message (doc)
  (cdr (assoc 'message doc)))

(defun kudos-date (doc)
  (cdr (assoc 'date doc)))

