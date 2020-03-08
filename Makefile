.POSIX:

CL ?= "sbcl"

help:	## Show help message
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/\\##//'

.PHONY: test
test:	## Run unit tests
	$(CL) --eval '(asdf:test-system "thanks-tracker")' --quit
