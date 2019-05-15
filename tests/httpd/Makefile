# This is a GNU -*- Makefile -*- fragment that is included by Automake
# Copyright 2019-2019, Oath Inc.
# Licensed under the terms of the Apache-2.0 license.
# See the LICENSE file in https://github.com/yahoo/tunitas-apanolio/blob/master/LICENSE for terms.

default:
all:
check:
clean:
distclean:
realclean:

default: all
all: all-objects
check: all
realclean: distclean

# recompute this ... we got it from the calling shell (bash)
# and it will be incorrect if "make -C $directory" is used.
export PWD := $(shell pwd)

httpd_srcdir = ./templates
httpd_objdir = .

httpd_SOURCES = \
  $(httpd_srcdir)/conf/httpd.conf \
  $(end)
httpd_OBJECTS = \
  $(patsubst $(httpd_srcdir)/%,$(httpd_objdir)/%, \
             $(httpd_SOURCES)) \
  $(end)

# or /build/useful/apache-httpd-api/lib/.libs/libapache-httpd-module.so
# or ../../external/apache-httpd-api/lib/.libs/libapache-httpd-module.so
# NOT NEEDED export LD_LIBRARY_PATH = ../../external/apache-httpd-api/lib/.libs

BASELINE_MODULES = \
  mod_alias \
  mod_auth_basic \
  mod_auth_digest \
  mod_authn_core \
  mod_authn_anon \
  mod_authz_core \
  mod_authz_host \
  mod_log_config \
  mod_mime_magic \
  mod_mime \
  mod_mpm_event \
  mod_negotiation \
  mod_rewrite \
  mod_unixd \
  mod_version \
  $(end)
MODULES_BASELINE_SET = $(addprefix modules/, $(addsuffix .so,$(BASELINE_MODULES)))
STANDARD_ServerRoot = /etc/httpd
all-objects: $(MODULES_BASELINE_SET)
$(MODULES_BASELINE_SET):
	ln -f -s $(STANDARD_ServerRoot)/$@ $@
	test -L $@ && readlink $@
	set -o pipefail; if file $@ | grep -qe broken; then exit 1; fi
clean: clean-MODULES_BASELINE_SET
clean-MODULES_BASELINE_SET:
	rm -f $(MODULES_BASELINE_SET)

all-objects: modules/mod_apanolio.so
modules/mod_apanolio.so : ../../lib/.libs/libmod_apanolio.so
	ln -f -s ../$< $@
	test -L $@ && readlink $@
	set -o pipefail; if file $@ | grep -qe broken; then exit 1; fi
clean: clean-mod_apanolio
clean-mod_apanolio:
	rm -f modules/mod_apanolio.so

all-objects: $(httpd_OBJECTS)
clean: clean-httpd_OBJECTS
clean-httpd_OBJECTS:
	rm -f $(httpd_OBJECTS)

ServerRoot = $(PWD)
ServerPort = 8888
ServerName = apanolio.example
SERVICE_HOSTONLY = $(ServerName)
SERVICE_HOSTPORT = $(ServerName):$(ServerPort)
include mk/substitute-all-variables.mk
$(httpd_OBJECTS) : $(httpd_objdir)/% : $(httpd_srcdir)/%
	$(SUBSTITUTE_ALL_VARIABLES)
	ls -ld $@
distclean: distclean-httpd_OBJECTS
distclean-httpd_OBJECTS:
	rm -f $(httpd_OBJECTS)

.PHONY: start apachectl_start
start: apachectl_start
apachectl_start: apachectl_restart

.PHONY: restart apachectl_restart
restart: apachectl_restart
apachectl_restart: all-objects
	if ! ./apachectl ; then tail ./logs/error_log ; exit 1; fi

.PHONY: stop apachectl_stop
stop: apachectl_stop
apachectl_stop: all-objects
	if ! ./apachectl ; then tail ./logs/error_log ; exit 1; fi

check: all-objects
	if ! ./apachectl restart ; then tail ./logs/error_log ; exit 1; fi
	echo -n "Give it a few seconds to restart ... " ; sleep 3; echo "continuing";
	: begin -- these are the tests on the server running at $(SERVICE_HOSTPORT) in $(ServerRoot) ; \
	./ping-local ; \
	: end -- OK
	if ! ./apachectl stop ; then tail ./logs/error_log ; exit 1; fi

#end
