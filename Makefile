
.DEFAULT_GOAL := test

.PHONY: run
run:
	@ruby -I./src/main/ ./src/main/main.rb

.PHONY: test
test:
	@ruby -I./src/main/ ./src/test/test_forth.rb

