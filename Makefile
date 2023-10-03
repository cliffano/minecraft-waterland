ci: deps villages-map

clean:
	rm -rf stage

stage:
	mkdir -p stage

deps:
	pip3 install -r requirements.txt

villages-map:
	python3 scripts/build-3dplot.py

.PHONY: ci clean stage deps villages-map