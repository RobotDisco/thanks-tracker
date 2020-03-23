;;;; The server handlers for kudos-tracker.

(defpackage thanks-tracker-server
  (:documentation "The server handlers for kudos-tracker.")
  (:use :cl)
  (:export #:main))

(in-package :thanks-tracker-server)

(defvar *handler* nil)

(defun start-app ()
  (unless *handler*
    (setq *handler* (make-instance 'hunchentoot:easy-acceptor :port 5000)))
  (hunchentoot:start *handler*)
  (hunchentoot:define-easy-handler (slash-command :uri "/") (command text)
    (setf (hunchentoot:content-type*) "application/json")
    (json:encode-json-alist-to-string (list
				       (cons 'text "Your gratitude has been stored :)")
				       (cons 'username "thanks-tracker")))))

(defun stop-app ()
  (when *handler*
    (hunchentoot:stop *handler*)))

(defun main ()
  ;; Start the webserver
  (start-app)
  ;; wait for all threads to finissh
  (handler-case (bt:join-thread (find-if (lambda (th)
					    (search "hunchentoot" (bt:thread-name th)))
					  (bt:all-threads)))
    ;; Catch a user's C-c
    (#+sbcl sb-sys:interactive-interrupt
      #+ccl ccl:interrupt-signal-condition
      #+clisp systme:simple-interrupt-condition
      #+ecl ext:interactive-interrupt
      #+allegro excl:interrupt-signal
      () (progn
	   (format *error-output* "Aborting.~&")
           (stop-app)
	   (uiop:quit)))
    (error (c) (format t "ERROR: Unknown error occured:~&~&~&" c))))
