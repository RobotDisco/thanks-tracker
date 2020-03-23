.POSIX:

CL ?= "sbcl"

help:	## Show help message
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/\\##//'

.PHONY: build
build:	## Create a self-hosting binary
	$(CL) \
		--eval '(ql:quickload :thanks-tracker)' \
		--eval '(asdf:make :thanks-tracker)' \
		--eval '(quit)'

.PHONY: test
test:	## Run unit tests
	$(CL) --eval '(asdf:test-system "thanks-tracker")' --quit
