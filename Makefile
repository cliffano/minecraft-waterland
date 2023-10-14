ci: deps villages-map

clean:
	rm -rf stage

stage:
	mkdir -p stage

deps:
	pip3 install -r requirements.txt

villages-map:
	python3 scripts/build-3dplot.py

respacks: respacks-package respacks-install-mac

respacks-package: stage
	mkdir -p stage/skins-mapped/
	cp skins/ranger.png stage/skins-mapped/sunny.png
	cp skins/king-kakashi-gladiators.png stage/skins-mapped/kai.png
	cp skins/golom-butler.png stage/skins-mapped/noor.png
	cp skins/astronaut-2.png stage/skins-mapped/alex.png
	cp skins/husar-peasant.png stage/skins-mapped/ari.png
	cp skins/husar-peasant.png stage/skins-mapped/efe.png
	cp skins/husar-peasant.png stage/skins-mapped/makena.png
	cp skins/husar-peasant.png stage/skins-mapped/steve.png
	cp skins/husar-peasant.png stage/skins-mapped/zuri.png
	mkdir -p stage/respacks/Waterland/assets/minecraft/textures/entity/player/
	cd stage/respacks/Waterland/assets/minecraft/textures/entity/player/ && mkdir -p slim/ wide/
	cp -R stage/skins-mapped/* stage/respacks/Waterland/assets/minecraft/textures/entity/player/slim/
	cp -R stage/skins-mapped/* stage/respacks/Waterland/assets/minecraft/textures/entity/player/wide/
	cp -R config/respacks/pack.mcmeta stage/respacks/Waterland/
	cp -R config/respacks/pack.png stage/respacks/Waterland/

respacks-install-mac:
	cp -R stage/respacks/Waterland "/Users/$(USER)/Library/Application Support/minecraft/resourcepacks/"
	

.PHONY: ci clean stage deps villages-map respacks respacks-package respacks-install-mac