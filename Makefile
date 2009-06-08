# auto generated - do not edit

default: all

all:\
errno_int errno_int.o posix-ada.a posix-error.ali posix-error.o posix-file.ali \
posix-file.o posix-permissions.ali posix-permissions.o posix.ali posix.o \
posix_error.o posix_file posix_file.o spark_conf spark_conf.ali spark_conf.o \
type-discrete type-discrete.o

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
errno_int.c:    \
errno_int.c.lua \
errno_to_ada.map
	./errno_int.c.lua < errno_to_ada.map > errno_int.c.tmp
	mv errno_int.c.tmp errno_int.c

errno_int.o:\
cc-compile errno_int.c
	./cc-compile errno_int.c

# errno_to_int.map.mff
errno_to_int.map: \
errno_int         \
errno.map         \
errno_to_int.sh
	./errno_to_int.sh > errno_to_int.map.tmp
	mv errno_to_int.map.tmp errno_to_int.map

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
cc-slib posix-ada.sld posix_error.o posix-error.o posix-file.o posix.o \
posix-permissions.o
	./cc-slib posix-ada posix_error.o posix-error.o posix-file.o posix.o \
	posix-permissions.o

# posix-error.adb.mff
posix-error.adb:    \
errno_constants.lua \
errno_map.lua       \
errno_to_ada.map    \
errno_to_int.map    \
LICENSE             \
posix-error.adb.sh  \
posix-error.ads
	./posix-error.adb.sh > posix-error.adb.tmp
	mv posix-error.adb.tmp posix-error.adb

# posix-error.ads.mff
posix-error.ads:   \
enum_type.lua      \
errno_to_ada.map   \
LICENSE            \
posix-error.ads.sh \
type-discrete
	./posix-error.ads.sh > posix-error.ads.tmp
	mv posix-error.ads.tmp posix-error.ads

posix-error.ali:\
ada-compile posix-error.adb posix.ali posix-error.ads
	./ada-compile posix-error.adb

posix-error.o:\
posix-error.ali

# posix-file.ads.mff
posix-file.ads:       \
LICENSE               \
posix-error.ads       \
posix_file            \
posix-file.ads.sh     \
posix-permissions.ads \
type-discrete
	./posix-file.ads.sh > posix-file.ads.tmp
	mv posix-file.ads.tmp posix-file.ads

posix-file.ali:\
ada-compile posix-file.adb posix.ali posix-file.ads
	./ada-compile posix-file.adb

posix-file.o:\
posix-file.ali

# posix-permissions.ads.mff
posix-permissions.ads:   \
posix-permissions.ads.sh \
type-discrete            \
LICENSE
	./posix-permissions.ads.sh > posix-permissions.ads.tmp
	mv posix-permissions.ads.tmp posix-permissions.ads

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

posix_file:\
cc-link posix_file.ld posix_file.o
	./cc-link posix_file posix_file.o

posix_file.o:\
cc-compile posix_file.c
	./cc-compile posix_file.c

spark_conf:\
ada-bind ada-link spark_conf.ald spark_conf.ali
	./ada-bind spark_conf.ali
	./ada-link spark_conf spark_conf.ali

spark_conf.ali:\
ada-compile spark_conf.adb
	./ada-compile spark_conf.adb

spark_conf.o:\
spark_conf.ali

type-discrete:\
cc-link type-discrete.ld type-discrete.o
	./cc-link type-discrete type-discrete.o

type-discrete.o:\
cc-compile type-discrete.c
	./cc-compile type-discrete.c

clean-all: obj_clean ext_clean
clean: obj_clean
obj_clean:
	rm -f errno_int errno_int.c errno_int.o posix-ada.a posix-error.adb \
	posix-error.ads posix-error.ali posix-error.o posix-file.ads posix-file.ali \
	posix-file.o posix-permissions.ads posix-permissions.ali posix-permissions.o \
	posix.ali posix.o posix_error.o posix_file posix_file.o spark_conf \
	spark_conf.ali spark_conf.o type-discrete type-discrete.o
ext_clean:
	rm -f conf-adatype conf-cctype conf-ldtype conf-systype mk-ctxt

regen:\
ada-srcmap ada-srcmap-all
	./ada-srcmap-all
	cpj-genmk > Makefile.tmp && mv Makefile.tmp Makefile
