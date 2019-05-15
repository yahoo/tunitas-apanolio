# This is a GNU -*- Makefile -*- fragment, so treat it as such

#
# Usage:
#
#     example/directory/file.conf : example/templates/directory/file.conf
#         $(SUBSTITUTE_ALL_VARIABLES)
#
# Variables Substituted:
#
#     PERCENT        (actually substitutes $*)
#     PWD
#     ServerRoot
#     ServerPort
#     ServerName
#     SERVICE_HOSTONLY
#     SERVICE_HOSTPORT
#

# n.b. frequently, files containing lists have a *.list suffix
#      the files with the '.list' suffix do not have a comment character
define sed_keep_the_statement
$(if $(call sed_comment_start_by_suffix,$1),$2)
endef
define sed_comment_start_by_suffix
$(if $(filter %.js,$1),//,$(if $(filter %.sql,$1),\--,$(if $(filter %.sh,$1),\#,$(if $(filter %.html,$1),<!--,$(if $(filter %.list,$1),$(empty),\#-default-$1-default-)))))
endef
define sed_comment_end_by_suffix
$(if $(filter %.html,$1),-->,$(newline))
endef


# executable files remain executable
# @PERCENT@ gets bound to $* which is typically the % thing in the pattern rule
SUBSTITUTE_ALL_VARIABLES = \
	{ mkdir -p $(@D); \
	  tmpfile=$(@D)/t99.$$$$.$(@F)~; \
	  sed \
	    $(call sed_keep_the_statement,$<,-e '2 i\$(call sed_comment_start_by_suffix,$<)'" Automatically created at $$(date --rfc-3339=seconds) from .../$<"'$(call sed_comment_end_by_suffix,$<)') \
	    -e 's,@PERCENT@,$*,g' \
	    -e 's,@PWD@,$(PWD),g' \
	    -e 's,@ServerName@,$(ServerName),g' \
	    -e 's,@ServerPort@,$(ServerPort),g' \
	    -e 's,@ServerRoot@,$(ServerRoot),g' \
	    -e 's,@SERVICE_HOSTONLY@,$(SERVICE_HOSTONLY),g' \
	    -e 's,@SERVICE_HOSTPORT@,$(SERVICE_HOSTPORT),g' \
	    < $< > $${tmpfile}; \
	  chmod a=r $${tmpfile}; \
	  mv -f $${tmpfile} $@; \
	  if test -x $< ; then chmod a+x $@; fi; }

# end
