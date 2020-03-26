;;;; The server handlers for kudos-tracker.

(defpackage thanks-tracker-server
  (:documentation "The server handlers for kudos-tracker.")
  (:use :cl)
  (:export #:main))

(in-package :thanks-tracker-server)

(defvar *handler* nil)

(defun handle-request (command text user_name)
  (cond ((equal command "/thank") (dispatch-thanks text user_name))
	((equal command "/view-thanks") (dispatch-get-thanks))
	(t (dispatch-help command))))

(defun dispatch-thanks (thanks user_name)
  (setf (hunchentoot:content-type*) "application/json")
  (thanks-tracker-db:add-kudos "user@example.com" "sample text" user_name)
  (json:encode-json-alist-to-string (list
				     (cons 'text "Your gratitude has been stored :)")
				     (cons 'username "thanks-tracker"))))

(defun dispatch-get-thanks ()
  (setf (hunchentoot:content-type*) "application/json")
  (json:encode-json-alist-to-string
   (list
    (cons 'username "thanks-tracker")
    (cons 'text (thanks-tracker-db:to-markdown)))))

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
  (hunchentoot:define-easy-handler (slash-command :uri "/") (command text user_name)
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
