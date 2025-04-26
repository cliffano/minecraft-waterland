ci: deps gen-villages-maps resource-packs-package

clean:
	rm -rf stage

stage:
	mkdir -p stage

define python_venv
	. .venv/bin/activate && $(1)
endef

deps:
	python3 -m venv .venv
	$(call python_venv,python3 -m pip install -r requirements.txt)

deps-upgrade:
	python3 -m venv .venv
	$(call python_venv,python3 -m pip install -r requirements-dev.txt)
	$(call python_venv,pip-compile --upgrade)

lint:
	$(call python_venv,yamllint .github/workflows/*.yaml config/*.yaml data/*.yaml)

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
	$(call python_venv,python3 scripts/gen-villages-maps.py)

gen-versions-list: stage
	$(call python_venv,python3 scripts/gen-versions-list.py)

update-versions-list-gist:
	gh gist edit 77a982a7503669c3e1acb0a0cf6127e9 -f minecraft-server-jar-downloads.md stage/versions-list.md

.PHONY: ci clean stage deps deps-upgrade gen-villages-maps resource-packs resource-packs-package resource-packs-install-mac gen-versions-list update-versions-list-gist