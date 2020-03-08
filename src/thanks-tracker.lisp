;;;; The main logic for kudos-tracker.

(defpackage thanks-tracker
  (:documentation "The main logic for kudos-tracker.")
  (:use :cl)
  (:export make-doc
	   make-kudos
	   thankee
	   kudos
	   kudos-thanker
	   kudos-message
	   kudos-date
	   add-kudos))

(in-package :thanks-tracker)

;;;; Data constructors
(defun make-doc (id)
  "Create the document object containing the kudos for a given user ID."
  (list (cons '_id id)
	(list 'kudos)))

(defun make-kudos (thanker message date)
  "Create a kudos entry with a THANKER id, MESSAGE of thanks and Y-M-D tuple DATE."
  (list (cons '_id thanker)
	(cons 'message message)
	(cons 'date date)))

(defun add-kudos (doc entry)
  "Return a new kudos DOC with new kudos ENTRY added to kudos list."
  (let ((newkudos (cons entry (kudos doc))))
    (acons 'kudos newkudos doc)))

(defun thankee (doc)
  "Return the THANKEE id for a given kudos DOC."
  (cdr (assoc '_id doc)))

(defun kudos (doc)
  "Return the list of KUDOS from a given kudos DOC."
  (cdr (assoc 'kudos doc)))

;; TODO find a reasonable way to map two symbols to the same lambda
;; (thankee and kudos-thanker are the same function right now)
(defun kudos-thanker (entry)
  "Return the thankee ID for a given kudos ENTRY."
  (thankee entry))

(defun kudos-message (entry)
  "Return the MESSAGE of thanks from a given kudos ENTRY."
  (cdr (assoc 'message entry)))

(defun kudos-date (entry)
  "Return the Y-M-D DATE of thanks for a given kudos ENTRY."
  (cdr (assoc 'date entry)))

