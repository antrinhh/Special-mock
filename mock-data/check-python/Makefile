#chua cac bien moi truong, quy tac build
include $(TOPDIR)/rules.mk 

#thong tin package
PKG_NAME:=python-check
PKG_VERSION:=1.0
PKG_RELEASE:=1

#chua cac ham build
include $(INCLUDE_DIR)/package.mk

#thong tin package hien trong menuconfig
define Package/python-check
  SECTION:=utils
  CATEGORY:=Custom packages
  TITLE:=Checking python version
endef

define Package/python-check/description
  To check python version.
endef

#tao thu muc build cho package va copy source code
define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./*.c $(PKG_BUILD_DIR)/
endef

#build voi cross compiler
define Build/Compile
	$(TARGET_CC) $(TARGET_CFLAGS) -o $(PKG_BUILD_DIR)/check-python $(PKG_BUILD_DIR)/check_python.c
endef

#install package vao /usr/bin
define Package/python-check/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/check-python $(1)/usr/bin
endef

#goi ham build de build package
$(eval $(call BuildPackage,python-check))
