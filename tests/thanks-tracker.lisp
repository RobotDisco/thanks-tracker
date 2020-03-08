;;;; The main test collection for kudos-tracker.
;;;;
;;;; To run this test file, execute `(asdf:test-system :thanks-tracker)' in your Lisp.

(defpackage thanks-tracker/tests/thanks-tracker
  (:documentation "The main test collection for kudos-tracker")
  (:use :cl
	:thanks-tracker
	:rove))

(in-package :thanks-tracker/tests/thanks-tracker)

;;; Commonly used test input
(defparameter +gaelan-doc+ (make-doc "gaelan@example.com"))
(defparameter +gaelan-kudos+ (make-kudos "gaelan@example.com"
				       "for doing absolutely nothing."
				       '(2020 3 7)))

(deftest new-doc
  (testing "should have a thankee of gaelan@example.com"
    (ok (string= "gaelan@example.com" (thankee +gaelan-doc+))))
  (testing "should start with an empty kudos list"
    (ok (null (kudos +gaelan-doc+)))))

(deftest new-kudos
  (testing "should have the appropriate mandatory fields set."
    (ok (string= "gaelan@example.com" (kudos-thanker +gaelan-kudos+)))
    (ok (string= "for doing absolutely nothing."
		 (kudos-message +gaelan-kudos+)))
    (ok (equal '(2020 3 7)
	       (kudos-date +gaelan-kudos+)))))

(deftest add-kudos
  (testing "should add a single entry into the kudos list"
    (let ((oldsize (length (kudos +gaelan-doc+)))
	  (newsize (length (kudos (add-kudos +gaelan-doc+
					     +gaelan-kudos+)))))
      (ok (= newsize (1+ oldsize))))))
