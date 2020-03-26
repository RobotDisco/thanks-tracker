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

(defun add-kudos (thankee message thanker)
  "Add a new message of gratitude to the DB"
  (push (pairlis
	 '(thankee message thanker)
	 (list thankee message thanker))
	*db*))

(defun kudos-to-markdown-table-row (kudos)
  (let ((id (cdr (assoc 'thanker kudos)))
	(message (cdr (assoc 'message kudos))))
    (format nil "| ~A | ~A |" id message)))

(defun to-markdown (user_name)
  (let* ((header (format nil "~A~%~A"
			"Here are all the people who have thanked you!"
			"| Thanker | Message |"))
	 (table-content (mapcar #'kudos-to-markdown-table-row
				(remove-if-not
				 (lambda (x) (equal (cdr (assoc 'thankee x))
						    user_name))
				 *db*))))
    (format nil "~A~%~{~A~}~%" header table-content)))

