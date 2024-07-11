ci: deps gen-villages-maps resource-packs-package

clean:
	rm -rf stage

stage:
	mkdir -p stage

deps:
	pip3 install -r requirements.txt

resource-packs: resource-packs-package resource-packs-install-mac

resource-packs-package: stage
	mkdir -p stage/skins-mapped/
	cp images/skins/ranger.png stage/skins-mapped/sunny.png
	cp images/skins/king-kakashi-gladiators.png stage/skins-mapped/kai.png
	cp images/skins/old-knight-soren.png stage/skins-mapped/noor.png
	cp images/skins/the-loyal.png stage/skins-mapped/alex.png
	cp images/skins/husar-peasant.png stage/skins-mapped/ari.png
	cp images/skins/husar-peasant.png stage/skins-mapped/efe.png
	cp images/skins/husar-peasant.png stage/skins-mapped/makena.png
	cp images/skins/husar-peasant.png stage/skins-mapped/steve.png
	cp images/skins/husar-peasant.png stage/skins-mapped/zuri.png
	mkdir -p stage/resource-packs/Waterland/assets/minecraft/textures/entity/player/
	cd stage/resource-packs/Waterland/assets/minecraft/textures/entity/player/ && mkdir -p slim/ wide/
	cp -R stage/skins-mapped/* stage/resource-packs/Waterland/assets/minecraft/textures/entity/player/slim/
	cp -R stage/skins-mapped/* stage/resource-packs/Waterland/assets/minecraft/textures/entity/player/wide/
	cp -R config/pack.mcmeta stage/resource-packs/Waterland/
	cp -R images/pack.png stage/resource-packs/Waterland/

resource-packs-install-mac:
	cp -R stage/resource-packs/Waterland "/Users/$(USER)/Library/Application Support/minecraft/resourcepacks/"

gen-villages-maps:
	python3 scripts/gen-villages-maps.py

gen-versions-list: stage
	python3 scripts/gen-versions-list.py

.PHONY: ci clean stage deps gen-villages-maps resource-packs resource-packs-package resource-packs-install-mac gen-versions-list