VER := 0.8.0
PKG_NAME := stretcher
BINARY_NAME := $(PKG_NAME)-v$(VER)-linux-amd64
ARCHIVE := $(BINARY_NAME).zip
PWD=$(shell pwd)
BUILD_DIR := $(PWD)/build

.PHONY:	all build setup $(ARCHIVE) debuild clean install

all:	$(ARCHIVE) build clean
build:	debuild clean

setup:
	apt-get install -y curl unzip devscripts build-essential lintian debhelper

$(ARCHIVE):
	curl -SL https://github.com/fujiwara/stretcher/releases/download/v$(VER)/$(ARCHIVE) -O
	unzip $(ARCHIVE)
	mv $(BINARY_NAME) $(BUILD_DIR)/$(PKG_NAME)

debuild:
	cd $(BUILD_DIR) && \
	dpkg-buildpackage -us -uc

clean:
	rm -f $(ARCHIVE)
	rm -rf $(BUILD_DIR)/usr

install:
	dpkg -i $(PKG_NAME)_$(VER)_amd64.deb
