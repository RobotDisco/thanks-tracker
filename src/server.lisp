;;;; The server handlers for kudos-tracker.

(defpackage thanks-tracker-server
  (:documentation "The server handlers for kudos-tracker.")
  (:use :cl)
  (:export #:main))

(in-package :thanks-tracker-server)

(defvar *handler* nil)

(defun handle-request (command text user_name)
  (cond ((equal command "/thank") (dispatch-thanks text user_name))
	((equal command "/view-thanks") (dispatch-get-thanks user_name))
	(t (dispatch-help command))))

(defun parse-string (text)
  (let ((words (str:words text)))
    (values (first words) text)))

(defun dispatch-thanks (thanks user_name)
  (setf (hunchentoot:content-type*) "application/json")
  (multiple-value-bind (thankee message) (parse-string thanks)
    (thanks-tracker-db:add-kudos thankee message user_name)
    (json:encode-json-alist-to-string (list
				       (cons 'text
					     (format nil
						     "Your gratitude for ~A has been stored! Thank you for being thankful :)"
						     thankee))
				       (cons 'username "thanks-tracker")))))

(defun dispatch-get-thanks (user_name)
  (setf (hunchentoot:content-type*) "application/json")
  (json:encode-json-alist-to-string
   (list
    (cons 'username "thanks-tracker")
    (cons 'text (thanks-tracker-db:to-markdown user_name)))))

(defun dispatch-help (command)
  (setf (hunchentoot:content-type*) "application/json")
  (json:encode-json-alist-to-string
   (list
    (cons 'username "thanks-tracker")
    (cons 'text
	  (format nil
		  "I'm sorry, I don't understand the command ~A :("
		  command)))))

(defun start-app ()
  (unless *handler*
    (setq *handler* (make-instance 'hunchentoot:easy-acceptor :port 5000)))
  (hunchentoot:start *handler*)
  (hunchentoot:define-easy-handler (slash-command :uri "/") (command
							     text
							     user_name)
    (handle-request command text user_name)))

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
    (error (c) (format t "ERROR: Unknown error occured:~&~a~&" c))))
