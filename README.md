# OpenWRT image builder for Raspberry Pi 4

## How to use
### 1. Clone repo
```bash
git clone https://github.com/antrinhh/Special-mock.git
git checkout feature/python-version-check
```

### 2. Build Docker image
```bash
make docker-image
```
### 3. Create container
```bash
make create
```
### 4. Build image with custom package and flash to board
```bash
make build
```
##### Output should be in /ouput/targets/bcm27xx/bcm2711/openwrt-bcm27xx-bcm2711-rpi-4-ext4-factory.img.gz
#### Unzip and flash to SD card
```bash
gzip -d openwrt-bcm27xx-bcm2711-rpi-4-ext4-factory.img.gz
sudo dd if=output/openwrt-bcm27xx-bcm2711-rpi-4-ext4-factory.img of=/dev/sdX bs=4M status=progress conv=fsync
```
##### sdX is SD card device
#### After boot, executable file will be in /usr/bin/check-python

### 5. Generate .apk of package
```bash
make package
```
