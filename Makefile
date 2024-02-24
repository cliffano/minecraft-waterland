ci: deps villages-map

clean:
	rm -rf stage

stage:
	mkdir -p stage

deps:
	pip3 install -r requirements.txt

villages-map:
	python3 scripts/build-3dplot.py

resource-packs: resource-packs-package resource-packs-install-mac

resource-packs-package: stage
	mkdir -p stage/skins-mapped/
	cp skins/ranger.png stage/skins-mapped/sunny.png
	cp skins/king-kakashi-gladiators.png stage/skins-mapped/kai.png
	cp skins/old-knight-soren.png stage/skins-mapped/noor.png
	cp skins/the-loyal.png stage/skins-mapped/alex.png
	cp skins/husar-peasant.png stage/skins-mapped/ari.png
	cp skins/husar-peasant.png stage/skins-mapped/efe.png
	cp skins/husar-peasant.png stage/skins-mapped/makena.png
	cp skins/husar-peasant.png stage/skins-mapped/steve.png
	cp skins/husar-peasant.png stage/skins-mapped/zuri.png
	mkdir -p stage/resource-packs/Waterland/assets/minecraft/textures/entity/player/
	cd stage/resource-packs/Waterland/assets/minecraft/textures/entity/player/ && mkdir -p slim/ wide/
	cp -R stage/skins-mapped/* stage/resource-packs/Waterland/assets/minecraft/textures/entity/player/slim/
	cp -R stage/skins-mapped/* stage/resource-packs/Waterland/assets/minecraft/textures/entity/player/wide/
	cp -R config/resource-packs/pack.mcmeta stage/resource-packs/Waterland/
	cp -R config/resource-packs/pack.png stage/resource-packs/Waterland/

resource-packs-install-mac:
	cp -R stage/resource-packs/Waterland "/Users/$(USER)/Library/Application Support/minecraft/resourcepacks/"


.PHONY: ci clean stage deps villages-map resource-packs resource-packs-package resource-packs-install-mac