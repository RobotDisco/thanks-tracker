;;;; The data storage logic for kudos-tracker.

(defpackage thanks-tracker-db
  (:documentation "The data storage logic for kudos-tracker.")
  (:use :cl)
  (:export #:add-kudos
	   #:to-markdown))

(in-package :thanks-tracker-db)

;; Since I don't know what I'm doing, use a list for the databases to start.
(defvar *db*
  '()
  "database for kudos, currently a basic list")

(defun add-kudos (id message)
  "Add a new message of gratitude to the DB"
  (push (cons id message) *db*))

(defun kudos-to-markdown-table-row (kudos)
  (let ((id (car kudos))
	(message (cdr kudos)))
    (format nil "| ~A | ~A |" id message)))

(defun to-markdown ()
  (let ((header (format nil "~A~%~A"
			"Here are all the people who have thanked you!"
			"| Thanker | Message |"))
	(table-content (format nil "~A"
			       (mapcar #'kudos-to-markdown-table-row
				     *db*))))
    (format nil "~A~%~A~%" header table-content)))

