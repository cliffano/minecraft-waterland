deps:
	pip3 install -r requirements.txt

build:
	python3 scripts/build-3dplot.py

.PHONY: deps build