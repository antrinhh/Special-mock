IMAGE_NAME = openwrt-image
CONTAINER_NAME = openwrt-build
MOCK_DATA_DIR = /home/antrinh/mock-data
OUTPUT_DIR = $(PWD)/output

.PHONY: docker-image build clean

docker-image:
	docker build -t $(IMAGE_NAME) -f Dockerfile .

build:
	docker run --rm --name $(CONTAINER_NAME) \
		-v $(MOCK_DATA_DIR):/mock-data \
		-v $(OUTPUT_DIR):/src/openwrt/bin \
		$(IMAGE_NAME) \
		bash -c "\
			sed -i '/telephony/d' feeds.conf.default && \
			sed -i '/video/d' feeds.conf.default && \
			sed -i '/routing/d' feeds.conf.default && \
			sed -i '/luci/d' feeds.conf.default && \
			echo 'src-link custompackages /mock-data' >> feeds.conf.default && \
			./scripts/feeds update -a && \
			./scripts/feeds install -a && \
			cp /mock-data/.config .config && \
			make -j8 \
		"