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
	mkdir -p skins-mapped/
	cp skins/ranger.png skins-mapped/sunny.png
	cp skins/king-kakashi-gladiators.png skins-mapped/kai.png
	cp skins/golom-butler.png skins-mapped/noor.png
	cp skins/astronaut-2.png skins-mapped/alex.png
	cp skins/husar-peasant.png skins-mapped/ari.png
	cp skins/husar-peasant.png skins-mapped/efe.png
	cp skins/husar-peasant.png skins-mapped/makena.png
	cp skins/husar-peasant.png skins-mapped/steve.png
	cp skins/husar-peasant.png skins-mapped/zuri.png
	mkdir -p stage/respacks/Waterland/assets/minecraft/textures/entity/player/
	cd stage/respacks/Waterland/assets/minecraft/textures/entity/player/ && mkdir -p slim/ wide/
	cp -R skins-mapped/* stage/respacks/Waterland/assets/minecraft/textures/entity/player/slim/
	cp -R skins-mapped/* stage/respacks/Waterland/assets/minecraft/textures/entity/player/wide/
	cp -R config/respacks/pack.mcmeta stage/respacks/Waterland/
	cp -R config/respacks/pack.png stage/respacks/Waterland/

respacks-install-mac:
	cp -R stage/respacks/Waterland "/Users/$(USER)/Library/Application Support/minecraft/resourcepacks/"
	

.PHONY: ci clean stage deps villages-map respacks respacks-package respacks-install-mac