(defpackage thanks-tracker/tests/thanks-tracker
  (:use :cl
	:thanks-tracker
	:rove))

(in-package :thanks-tracker/tests/thanks-tracker)

;; NOTE: To run this test file, execute `(asdf:test-system :thanks-tracker)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
