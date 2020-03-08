(defpackage thanks-tracker
  (:use :cl)
  (:export :make-doc
	   :make-kudos
	   :thankee
	   :kudos
	   :kudos-thanker
	   :kudos-message
	   :kudos-date
	   :add-kudos))

(in-package :thanks-tracker)

(defparameter gaelan-doc '((_id . "gaelan@tulip.com")
			   (kudos . (((_id . "gaelan@tulip.com")
				      (message . "for doing absolutely nothing.")
				      (date . (2020 3 7)))))))



(defun make-doc (id)
  (list (cons '_id id)
	(cons 'kudos ())))

(defun make-kudos (thanker msg date)
  (list (cons '_id thanker)
	(cons 'message msg)
	(cons 'date date)))

(defun add-kudos (doc entry)
  (let ((newkudos (cons entry (kudos doc))))
    (acons 'kudos newkudos doc)))

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

