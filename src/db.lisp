;;;; The data storage logic for kudos-tracker.

(defpackage thanks-tracker-db
  (:documentation "The data storage logic for kudos-tracker.")
  (:use :cl)
  (:export #:add-kudos))

(in-package :thanks-tracker-db)

;; Since I don't know what I'm doing, use a list for the databases to start.
(defvar *db*
  '()
  "database for kudos, currently a basic list")

(defun add-kudos (id message)
  "Add a new message of gratitude to the DB"
  (push (cons id message) *db*))


