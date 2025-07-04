all: build

.PHONY: all build test run clean

build:
	@echo "No build needed!"

test:
	coverage run -m pytest --junitxml=report.xml ./tests
	coverage report

clean:
	rm -rf .pytest_cache/ htmlcov/ .coverage report.xml
