# auto generated - do not edit

default: all

all:\
errno_int errno_int.o posix-ada.a posix-error.ali posix-error.o posix-file.ali \
posix-file.o posix-file_thin.ali posix-file_thin.o posix-permissions.ali \
posix-permissions.o posix.ali posix.o posix_error.o

# -- SYSDEPS start
flags-c_string:
	@echo SYSDEPS c_string-flags run create flags-c_string 
	@(cd SYSDEPS/modules/c_string-flags && ./run)
libs-c_string-S:
	@echo SYSDEPS c_string-libs-S run create libs-c_string-S 
	@(cd SYSDEPS/modules/c_string-libs-S && ./run)


c_string-flags_clean:
	@echo SYSDEPS c_string-flags clean flags-c_string 
	@(cd SYSDEPS/modules/c_string-flags && ./clean)
c_string-libs-S_clean:
	@echo SYSDEPS c_string-libs-S clean libs-c_string-S 
	@(cd SYSDEPS/modules/c_string-libs-S && ./clean)


sysdeps_clean:\
c_string-flags_clean \
c_string-libs-S_clean \


# -- SYSDEPS end


ada-bind:\
conf-adabind conf-systype conf-adatype conf-adabflags conf-adafflist

ada-compile:\
conf-adacomp conf-adatype conf-systype conf-adacflags conf-adafflist

ada-link:\
conf-adalink conf-adatype conf-systype conf-adaldflags conf-aldfflist

ada-srcmap:\
conf-adacomp conf-adatype conf-systype

ada-srcmap-all:\
ada-srcmap conf-adacomp conf-adatype conf-systype

cc-compile:\
conf-cc conf-cctype conf-systype conf-cflags

cc-link:\
conf-ld conf-ldtype conf-systype

cc-slib:\
conf-systype

conf-adatype:\
mk-adatype
	./mk-adatype > conf-adatype.tmp && mv conf-adatype.tmp conf-adatype

conf-cctype:\
conf-cc conf-cc mk-cctype
	./mk-cctype > conf-cctype.tmp && mv conf-cctype.tmp conf-cctype

conf-ldtype:\
conf-ld conf-ld mk-ldtype
	./mk-ldtype > conf-ldtype.tmp && mv conf-ldtype.tmp conf-ldtype

conf-systype:\
mk-systype
	./mk-systype > conf-systype.tmp && mv conf-systype.tmp conf-systype

errno_int:\
cc-link errno_int.ld errno_int.o
	./cc-link errno_int errno_int.o

# errno_int.c.mff
errno_int.c: errno_int.c.lua errno_to_ada.map
	./errno_int.c.lua < errno_to_ada.map > errno_int.c.tmp && mv errno_int.c.tmp errno_int.c

errno_int.o:\
cc-compile errno_int.c
	./cc-compile errno_int.c

# errno_to_int.map.mff
errno_to_int.map: errno_to_int.sh errno_int errno.map
	./errno_to_int.sh > errno_to_int.map.tmp && mv errno_to_int.map.tmp errno_to_int.map

mk-adatype:\
conf-adacomp conf-systype

mk-cctype:\
conf-cc conf-systype

mk-ctxt:\
mk-mk-ctxt
	./mk-mk-ctxt

mk-ldtype:\
conf-ld conf-systype conf-cctype

mk-mk-ctxt:\
conf-cc conf-ld

mk-systype:\
conf-cc conf-ld

posix-ada.a:\
cc-slib posix-ada.sld posix-error.o posix-file.o posix-file_thin.o \
posix-permissions.o posix.o posix_error.o
	./cc-slib posix-ada posix-error.o posix-file.o posix-file_thin.o \
	posix-permissions.o posix.o posix_error.o

# posix-error.adb.mff
posix-error.adb: posix-error.adb.sh errno_constants.lua errno_to_int.map errno_map.lua posix-error.ads errno_to_ada.map
	./posix-error.adb.sh > posix-error.adb.tmp && mv posix-error.adb.tmp posix-error.adb

# posix-error.ads.mff
posix-error.ads: posix-error.ads.sh
	./posix-error.ads.sh > posix-error.ads.tmp && mv posix-error.ads.tmp posix-error.ads

posix-error.ali:\
ada-compile posix-error.adb
	./ada-compile posix-error.adb

posix-error.o:\
posix-error.ali

posix-file.ads:\
posix.ali posix-error.ali posix-file_thin.ali posix-permissions.ali

posix-file.ali:\
ada-compile posix-file.adb posix.ali posix-file.ads
	./ada-compile posix-file.adb

posix-file.o:\
posix-file.ali

posix-file_thin.ali:\
ada-compile posix-file_thin.ads posix-file_thin.ads
	./ada-compile posix-file_thin.ads

posix-file_thin.o:\
posix-file_thin.ali

posix-permissions.ali:\
ada-compile posix-permissions.ads posix.ali posix-permissions.ads
	./ada-compile posix-permissions.ads

posix-permissions.o:\
posix-permissions.ali

posix.ali:\
ada-compile posix.ads posix.ads
	./ada-compile posix.ads

posix.o:\
posix.ali

posix_error.o:\
cc-compile posix_error.c
	./cc-compile posix_error.c

clean-all: sysdeps_clean obj_clean ext_clean
clean: obj_clean
obj_clean:
	rm -f errno_int errno_int.c errno_int.o posix-ada.a posix-error.adb \
	posix-error.ads posix-error.ali posix-error.o posix-file.ali posix-file.o \
	posix-file_thin.ali posix-file_thin.o posix-permissions.ali posix-permissions.o \
	posix.ali posix.o posix_error.o
ext_clean:
	rm -f conf-adatype conf-cctype conf-ldtype conf-systype mk-ctxt

regen:\
ada-srcmap ada-srcmap-all
	./ada-srcmap-all
	cpj-genmk > Makefile.tmp && mv Makefile.tmp Makefile
