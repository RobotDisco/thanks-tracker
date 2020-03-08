(defpackage thanks-tracker/tests/thanks-tracker
  (:use :cl
	:thanks-tracker
	:rove))

(in-package :thanks-tracker/tests/thanks-tracker)

;; NOTE: To run this test file, execute `(asdf:test-system :thanks-tracker)' in your Lisp.
(defparameter gaelan-doc (thanks-tracker:make-doc "gaelan@example.com"))
(defparameter gaelan-kudos (make-kudos "gaelan@example.com"
				       "for doing absolutely nothing."
				       '(2020 3 7)))

(deftest new-doc
  (testing "should have a thankee of gaelan@example.com"
    (ok (string= "gaelan@example.com" (thanks-tracker:thankee gaelan-doc))))
  (testing "should start with an empty kudos list"
    (ok (null (thanks-tracker:kudos gaelan-doc)))))

(deftest new-kudos
  (testing "should have the appropriate mandatory fields set."
    (ok (string= "gaelan@example.com" (thanks-tracker:kudos-thanker gaelan-kudos)))
    (ok (string= "for doing absolutely nothing."
		 (thanks-tracker:kudos-message gaelan-kudos)))
    (ok (equal '(2020 3 7)
	       (thanks-tracker:kudos-date gaelan-kudos)))))

(deftest add-kudos
  (testing "should add a single entry into the kudos list"
    (let ((oldsize (length (thanks-tracker:kudos gaelan-doc)))
	  (newsize (length (thanks-tracker:kudos (thanks-tracker:add-kudos gaelan-doc
									   gaelan-kudos)))))
      (ok (= newsize (1+ oldsize))))))
