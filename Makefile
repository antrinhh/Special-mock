ROOT_DIR = /home/antrinh/mock
IMAGE_NAME = openwrt-image
CONTAINER_NAME = openwrt-build
MOCK_DATA_DIR = $(PWD)/mock-data
OUTPUT_DIR = $(ROOT_DIR)/output
PKG_OUTPUT = $(ROOT_DIR)/package-output

.PHONY: docker-image build clean

docker-image:
	docker build -t $(IMAGE_NAME) -f Dockerfile .


create:
	docker create -it --name $(CONTAINER_NAME) \
		-v $(MOCK_DATA_DIR):/mock-data \
		-v $(OUTPUT_DIR):/src/openwrt/bin \
		-v $(PKG_OUTPUT):/src/pkg-output \
		$(IMAGE_NAME) bash

build:
	docker start $(CONTAINER_NAME)
	docker exec -it $(CONTAINER_NAME) bash -c "\
			cd /src/openwrt && \
			sed -i '/custompackages/d' feeds.conf.default && \
			echo 'src-link custompackages /mock-data' >> feeds.conf.default && \
			./scripts/feeds update -a && \
			./scripts/feeds install -a && \
			cp /mock-data/.config .config && \
			make -j8 \
		"

package:
	docker start $(CONTAINER_NAME)
	docker exec -it $(CONTAINER_NAME) bash -c "\
			cd /src/openwrt/bin/packages/aarch64_cortex-a72/custompackages && \
			cp *.apk /src/pkg-output \
		"