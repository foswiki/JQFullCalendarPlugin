FOSWIKI_ROOT?=~/foswiki/trunk/core
TARGET=build/pkg.js build/pkg.css

PKG_JS_SOURCE=lib/main.js src/foswiki.js
PKG_CSS_SOURCE=lib/main.css src/foswiki.css

-include $(FOSWIKI_ROOT)/pub/System/JQueryPlugin/Makefile.include

clean:
	rm -f $(TARGET) *.gz

build/pkg.uncompressed.js: $(PKG_JS_SOURCE)
	@echo generating $@
	@cat $^ > $@

build/pkg.uncompressed.css: $(PKG_CSS_SOURCE)
	@echo generating $@
	@cat $^ > $@
