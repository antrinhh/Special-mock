include $(TOPDIR)/rule.mk

PKG_NAME:=python-check
PKG_VERSION:=1.0
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/python-check
  SECTION:=utils
  CATEGORY:=Custom packages
  TITLE:=Checking python version
endef

define Package/python-check/description
  To check python version.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./*.c $(PKG_BUILD_DIR)/
endef

define Build/Compile
	$(TARGET_CC) $(TARGET_CFLAGS) -o $(PKG_BUILD_DIR)/check_python $(PKG_BUILD_DIR)/check_python.C
endef

define Package/python-check/install
	$(INCLUDE_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/check-python $(1)/usr/bin
endef

$(eval $(call BuildPackage,check-python))
