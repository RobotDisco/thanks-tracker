(defpackage thanks-tracker/tests/thanks-tracker
  (:use :cl
	:thanks-tracker
	:rove))

(in-package :thanks-tracker/tests/thanks-tracker)

;; NOTE: To run this test file, execute `(asdf:test-system :thanks-tracker)' in your Lisp.
(defparameter gaelan-doc (thanks-tracker:make-doc "gaelan@example.com"))

(deftest new-doc
  (testing "should have a thankee of gaelan@example.com"
    (ok (string= "gaelan@example.com" (thanks-tracker:thankee gaelan-doc)))
    (ok (null (thanks-tracker:kudos gaelan-doc)))))
