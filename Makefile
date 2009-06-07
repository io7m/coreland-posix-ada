# auto generated - do not edit

default: all

all:\
errno_int errno_int.o posix-error.ali posix-error.o posix.ali posix.o

ada-bind:\
conf-adabind conf-systype conf-adatype

ada-compile:\
conf-adacomp conf-adatype conf-systype

ada-link:\
conf-adalink conf-adatype conf-systype

ada-srcmap:\
conf-adacomp conf-adatype conf-systype

ada-srcmap-all:\
ada-srcmap conf-adacomp conf-adatype conf-systype

cc-compile:\
conf-cc conf-cctype conf-systype

cc-link:\
conf-ld conf-ldtype conf-systype

cc-slib:\
conf-systype

conf-adatype:\
mk-adatype
	./mk-adatype > conf-adatype.tmp && mv conf-adatype.tmp conf-adatype

conf-cctype:\
conf-cc mk-cctype
	./mk-cctype > conf-cctype.tmp && mv conf-cctype.tmp conf-cctype

conf-ldtype:\
conf-ld mk-ldtype
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

posix.ali:\
ada-compile posix.ads posix.ads
	./ada-compile posix.ads

posix.o:\
posix.ali

clean-all: obj_clean ext_clean
clean: obj_clean
obj_clean:
	rm -f errno_int errno_int.c errno_int.o posix-error.adb posix-error.ads \
	posix-error.ali posix-error.o posix.ali posix.o
ext_clean:
	rm -f conf-adatype conf-cctype conf-ldtype conf-systype mk-ctxt

regen:\
ada-srcmap ada-srcmap-all
	./ada-srcmap-all
	cpj-genmk > Makefile.tmp && mv Makefile.tmp Makefile
