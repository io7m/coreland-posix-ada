# auto generated - do not edit

default: all

all:\
local UNIT_TESTS/t_em1 UNIT_TESTS/t_em1.ali UNIT_TESTS/t_em1.o \
UNIT_TESTS/t_error1 UNIT_TESTS/t_error1.ali UNIT_TESTS/t_error1.o \
UNIT_TESTS/t_io1 UNIT_TESTS/t_io1.ali UNIT_TESTS/t_io1.o UNIT_TESTS/t_open1 \
UNIT_TESTS/t_open1.ali UNIT_TESTS/t_open1.o UNIT_TESTS/t_open2 \
UNIT_TESTS/t_open2.ali UNIT_TESTS/t_open2.o UNIT_TESTS/t_perm1 \
UNIT_TESTS/t_perm1.ali UNIT_TESTS/t_perm1.o UNIT_TESTS/t_stat1 \
UNIT_TESTS/t_stat1.ali UNIT_TESTS/t_stat1.o UNIT_TESTS/t_stat2 \
UNIT_TESTS/t_stat2.ali UNIT_TESTS/t_stat2.o UNIT_TESTS/t_symlink1 \
UNIT_TESTS/t_symlink1.ali UNIT_TESTS/t_symlink1.o UNIT_TESTS/t_symlink2 \
UNIT_TESTS/t_symlink2.ali UNIT_TESTS/t_symlink2.o UNIT_TESTS/t_symlink3 \
UNIT_TESTS/t_symlink3.ali UNIT_TESTS/t_symlink3.o UNIT_TESTS/t_udb_ge1 \
UNIT_TESTS/t_udb_ge1.ali UNIT_TESTS/t_udb_ge1.o UNIT_TESTS/t_udb_ge2 \
UNIT_TESTS/t_udb_ge2.ali UNIT_TESTS/t_udb_ge2.o UNIT_TESTS/t_udb_ge3 \
UNIT_TESTS/t_udb_ge3.ali UNIT_TESTS/t_udb_ge3.o UNIT_TESTS/t_udb_ge4 \
UNIT_TESTS/t_udb_ge4.ali UNIT_TESTS/t_udb_ge4.o UNIT_TESTS/t_udb_ge5 \
UNIT_TESTS/t_udb_ge5.ali UNIT_TESTS/t_udb_ge5.o UNIT_TESTS/t_udb_ge6 \
UNIT_TESTS/t_udb_ge6.ali UNIT_TESTS/t_udb_ge6.o UNIT_TESTS/t_unlink1 \
UNIT_TESTS/t_unlink1.ali UNIT_TESTS/t_unlink1.o UNIT_TESTS/test.a \
UNIT_TESTS/test.ali UNIT_TESTS/test.o constants constants.o ctxt/bindir.o \
ctxt/ctxt.a ctxt/dlibdir.o ctxt/fakeroot.o ctxt/incdir.o ctxt/repos.o \
ctxt/slibdir.o ctxt/version.o deinstaller deinstaller.o errno_int errno_int.o \
install-core.o install-error.o install-posix.o install-win32.o install.a \
installer installer.o instchk instchk.o insthier.o posix-ada-conf \
posix-ada-conf.o posix-ada.a posix-c_types.ali posix-c_types.o \
posix-directory.ali posix-directory.o posix-errno.ali posix-errno.o \
posix-error.ali posix-error.o posix-file.ali posix-file.o posix-file_status.ali \
posix-file_status.o posix-io-control.ali posix-io-control.o posix-io.ali \
posix-io.o posix-path.ali posix-path.o posix-permissions.ali \
posix-permissions.o posix-process_info.ali posix-process_info.o \
posix-symlink.ali posix-symlink.o posix-user_db.ali posix-user_db.o posix.ali \
posix.o posix_error.o posix_file posix_file.o posix_passwd.o posix_stat.o \
spark_config spark_config.ali spark_config.o test_config.ali test_config.o \
type-discrete type-discrete.o type-mode type-mode.o type-offset type-offset.o \
type-passwd type-passwd.o type-status type-status.o

# Mkf-deinstall
deinstall: deinstaller conf-sosuffix
	./deinstaller
deinstall-dryrun: deinstaller conf-sosuffix
	./deinstaller dryrun

# Mkf-install
install: installer postinstall conf-sosuffix
	./installer
	./postinstall

install-dryrun: installer conf-sosuffix
	./installer dryrun

# Mkf-instchk
install-check: instchk conf-sosuffix
	./instchk

# Mkf-local
#
# XXX:
# This target is required because the makefile generator is incapable
# of determining the dependencies of generated files. This target ensures
# that the library is built before any of the test suite.
#

local: posix-ada.a
local_clean:

# Mkf-test
tests:
	(cd UNIT_TESTS && make)
tests_clean:
	(cd UNIT_TESTS && make clean)

# -- SYSDEPS start
flags-c_string:
	@echo SYSDEPS c_string-flags run create flags-c_string 
	@(cd SYSDEPS/modules/c_string-flags && ./run)
libs-c_string-S:
	@echo SYSDEPS c_string-libs-S run create libs-c_string-S 
	@(cd SYSDEPS/modules/c_string-libs-S && ./run)
_sd_streams.h:
	@echo SYSDEPS sd-streams run create _sd_streams.h 
	@(cd SYSDEPS/modules/sd-streams && ./run)
_sysinfo.h:
	@echo SYSDEPS sysinfo run create _sysinfo.h 
	@(cd SYSDEPS/modules/sysinfo && ./run)


c_string-flags_clean:
	@echo SYSDEPS c_string-flags clean flags-c_string 
	@(cd SYSDEPS/modules/c_string-flags && ./clean)
c_string-libs-S_clean:
	@echo SYSDEPS c_string-libs-S clean libs-c_string-S 
	@(cd SYSDEPS/modules/c_string-libs-S && ./clean)
sd-streams_clean:
	@echo SYSDEPS sd-streams clean _sd_streams.h 
	@(cd SYSDEPS/modules/sd-streams && ./clean)
sysinfo_clean:
	@echo SYSDEPS sysinfo clean _sysinfo.h 
	@(cd SYSDEPS/modules/sysinfo && ./clean)


sysdeps_clean:\
c_string-flags_clean \
c_string-libs-S_clean \
sd-streams_clean \
sysinfo_clean \


# -- SYSDEPS end


UNIT_TESTS/t_em1:\
ada-bind ada-link UNIT_TESTS/t_em1.ald UNIT_TESTS/t_em1.ali UNIT_TESTS/test.ali \
test_config.ali posix-error.ali posix-ada.a
	./ada-bind UNIT_TESTS/t_em1.ali
	./ada-link UNIT_TESTS/t_em1 UNIT_TESTS/t_em1.ali posix-ada.a

UNIT_TESTS/t_em1.ali:\
ada-compile UNIT_TESTS/t_em1.adb posix-error.ali
	./ada-compile UNIT_TESTS/t_em1.adb

UNIT_TESTS/t_em1.o:\
UNIT_TESTS/t_em1.ali

UNIT_TESTS/t_error1:\
ada-bind ada-link UNIT_TESTS/t_error1.ald UNIT_TESTS/t_error1.ali \
UNIT_TESTS/test.ali test_config.ali posix-error.ali posix-errno.ali posix-ada.a
	./ada-bind UNIT_TESTS/t_error1.ali
	./ada-link UNIT_TESTS/t_error1 UNIT_TESTS/t_error1.ali posix-ada.a

UNIT_TESTS/t_error1.ali:\
ada-compile UNIT_TESTS/t_error1.adb posix-error.ali UNIT_TESTS/test.ali
	./ada-compile UNIT_TESTS/t_error1.adb

UNIT_TESTS/t_error1.o:\
UNIT_TESTS/t_error1.ali

UNIT_TESTS/t_io1:\
ada-bind ada-link UNIT_TESTS/t_io1.ald UNIT_TESTS/t_io1.ali UNIT_TESTS/test.ali \
test_config.ali posix-error.ali posix-file.ali posix-io.ali \
posix-permissions.ali posix-ada.a
	./ada-bind UNIT_TESTS/t_io1.ali
	./ada-link UNIT_TESTS/t_io1 UNIT_TESTS/t_io1.ali posix-ada.a

UNIT_TESTS/t_io1.ali:\
ada-compile UNIT_TESTS/t_io1.adb posix-error.ali posix-file.ali posix-io.ali \
posix-permissions.ali UNIT_TESTS/test.ali
	./ada-compile UNIT_TESTS/t_io1.adb

UNIT_TESTS/t_io1.o:\
UNIT_TESTS/t_io1.ali

UNIT_TESTS/t_open1:\
ada-bind ada-link UNIT_TESTS/t_open1.ald UNIT_TESTS/t_open1.ali \
UNIT_TESTS/test.ali test_config.ali posix-error.ali posix-file.ali \
posix-permissions.ali posix-ada.a
	./ada-bind UNIT_TESTS/t_open1.ali
	./ada-link UNIT_TESTS/t_open1 UNIT_TESTS/t_open1.ali posix-ada.a

UNIT_TESTS/t_open1.ali:\
ada-compile UNIT_TESTS/t_open1.adb posix-error.ali posix-file.ali \
posix-permissions.ali UNIT_TESTS/test.ali
	./ada-compile UNIT_TESTS/t_open1.adb

UNIT_TESTS/t_open1.o:\
UNIT_TESTS/t_open1.ali

UNIT_TESTS/t_open2:\
ada-bind ada-link UNIT_TESTS/t_open2.ald UNIT_TESTS/t_open2.ali \
UNIT_TESTS/test.ali test_config.ali posix-error.ali posix-file.ali posix-ada.a
	./ada-bind UNIT_TESTS/t_open2.ali
	./ada-link UNIT_TESTS/t_open2 UNIT_TESTS/t_open2.ali posix-ada.a

UNIT_TESTS/t_open2.ali:\
ada-compile UNIT_TESTS/t_open2.adb posix-error.ali posix-file.ali \
UNIT_TESTS/test.ali
	./ada-compile UNIT_TESTS/t_open2.adb

UNIT_TESTS/t_open2.o:\
UNIT_TESTS/t_open2.ali

UNIT_TESTS/t_perm1:\
ada-bind ada-link UNIT_TESTS/t_perm1.ald UNIT_TESTS/t_perm1.ali \
UNIT_TESTS/test.ali test_config.ali posix-permissions.ali posix-ada.a
	./ada-bind UNIT_TESTS/t_perm1.ali
	./ada-link UNIT_TESTS/t_perm1 UNIT_TESTS/t_perm1.ali posix-ada.a

UNIT_TESTS/t_perm1.ali:\
ada-compile UNIT_TESTS/t_perm1.adb posix-permissions.ali
	./ada-compile UNIT_TESTS/t_perm1.adb

UNIT_TESTS/t_perm1.o:\
UNIT_TESTS/t_perm1.ali

UNIT_TESTS/t_stat1:\
ada-bind ada-link UNIT_TESTS/t_stat1.ald UNIT_TESTS/t_stat1.ali \
UNIT_TESTS/test.ali test_config.ali posix-error.ali posix-file_status.ali \
posix-file.ali posix-permissions.ali posix-ada.a
	./ada-bind UNIT_TESTS/t_stat1.ali
	./ada-link UNIT_TESTS/t_stat1 UNIT_TESTS/t_stat1.ali posix-ada.a

UNIT_TESTS/t_stat1.ali:\
ada-compile UNIT_TESTS/t_stat1.adb posix-error.ali posix-file.ali \
posix-file_status.ali UNIT_TESTS/test.ali
	./ada-compile UNIT_TESTS/t_stat1.adb

UNIT_TESTS/t_stat1.o:\
UNIT_TESTS/t_stat1.ali

UNIT_TESTS/t_stat2:\
ada-bind ada-link UNIT_TESTS/t_stat2.ald UNIT_TESTS/t_stat2.ali \
UNIT_TESTS/test.ali test_config.ali posix-error.ali posix-file_status.ali \
posix-file.ali posix-permissions.ali posix-ada.a
	./ada-bind UNIT_TESTS/t_stat2.ali
	./ada-link UNIT_TESTS/t_stat2 UNIT_TESTS/t_stat2.ali posix-ada.a

UNIT_TESTS/t_stat2.ali:\
ada-compile UNIT_TESTS/t_stat2.adb posix-error.ali posix-file.ali \
posix-file_status.ali UNIT_TESTS/test.ali
	./ada-compile UNIT_TESTS/t_stat2.adb

UNIT_TESTS/t_stat2.o:\
UNIT_TESTS/t_stat2.ali

UNIT_TESTS/t_symlink1:\
ada-bind ada-link UNIT_TESTS/t_symlink1.ald UNIT_TESTS/t_symlink1.ali \
UNIT_TESTS/test.ali test_config.ali posix-error.ali posix-file.ali \
posix-symlink.ali posix-ada.a
	./ada-bind UNIT_TESTS/t_symlink1.ali
	./ada-link UNIT_TESTS/t_symlink1 UNIT_TESTS/t_symlink1.ali posix-ada.a

UNIT_TESTS/t_symlink1.ali:\
ada-compile UNIT_TESTS/t_symlink1.adb posix-error.ali posix-file.ali \
posix-symlink.ali UNIT_TESTS/test.ali
	./ada-compile UNIT_TESTS/t_symlink1.adb

UNIT_TESTS/t_symlink1.o:\
UNIT_TESTS/t_symlink1.ali

UNIT_TESTS/t_symlink2:\
ada-bind ada-link UNIT_TESTS/t_symlink2.ald UNIT_TESTS/t_symlink2.ali \
UNIT_TESTS/test.ali test_config.ali posix-error.ali posix-file.ali \
posix-symlink.ali posix-ada.a
	./ada-bind UNIT_TESTS/t_symlink2.ali
	./ada-link UNIT_TESTS/t_symlink2 UNIT_TESTS/t_symlink2.ali posix-ada.a

UNIT_TESTS/t_symlink2.ali:\
ada-compile UNIT_TESTS/t_symlink2.adb posix-error.ali posix-file.ali \
posix-symlink.ali UNIT_TESTS/test.ali
	./ada-compile UNIT_TESTS/t_symlink2.adb

UNIT_TESTS/t_symlink2.o:\
UNIT_TESTS/t_symlink2.ali

UNIT_TESTS/t_symlink3:\
ada-bind ada-link UNIT_TESTS/t_symlink3.ald UNIT_TESTS/t_symlink3.ali \
UNIT_TESTS/test.ali test_config.ali posix-error.ali posix-file.ali \
posix-symlink.ali posix-ada.a
	./ada-bind UNIT_TESTS/t_symlink3.ali
	./ada-link UNIT_TESTS/t_symlink3 UNIT_TESTS/t_symlink3.ali posix-ada.a

UNIT_TESTS/t_symlink3.ali:\
ada-compile UNIT_TESTS/t_symlink3.adb posix-error.ali posix-file.ali \
posix-symlink.ali UNIT_TESTS/test.ali
	./ada-compile UNIT_TESTS/t_symlink3.adb

UNIT_TESTS/t_symlink3.o:\
UNIT_TESTS/t_symlink3.ali

UNIT_TESTS/t_udb_ge1:\
ada-bind ada-link UNIT_TESTS/t_udb_ge1.ald UNIT_TESTS/t_udb_ge1.ali \
UNIT_TESTS/test.ali test_config.ali posix-error.ali posix-user_db.ali \
posix-ada.a
	./ada-bind UNIT_TESTS/t_udb_ge1.ali
	./ada-link UNIT_TESTS/t_udb_ge1 UNIT_TESTS/t_udb_ge1.ali posix-ada.a

UNIT_TESTS/t_udb_ge1.ali:\
ada-compile UNIT_TESTS/t_udb_ge1.adb posix-error.ali posix-user_db.ali \
UNIT_TESTS/test.ali
	./ada-compile UNIT_TESTS/t_udb_ge1.adb

UNIT_TESTS/t_udb_ge1.o:\
UNIT_TESTS/t_udb_ge1.ali

UNIT_TESTS/t_udb_ge2:\
ada-bind ada-link UNIT_TESTS/t_udb_ge2.ald UNIT_TESTS/t_udb_ge2.ali \
UNIT_TESTS/test.ali test_config.ali posix-error.ali posix-user_db.ali \
posix-ada.a
	./ada-bind UNIT_TESTS/t_udb_ge2.ali
	./ada-link UNIT_TESTS/t_udb_ge2 UNIT_TESTS/t_udb_ge2.ali posix-ada.a

UNIT_TESTS/t_udb_ge2.ali:\
ada-compile UNIT_TESTS/t_udb_ge2.adb posix-error.ali posix-user_db.ali \
UNIT_TESTS/test.ali
	./ada-compile UNIT_TESTS/t_udb_ge2.adb

UNIT_TESTS/t_udb_ge2.o:\
UNIT_TESTS/t_udb_ge2.ali

UNIT_TESTS/t_udb_ge3:\
ada-bind ada-link UNIT_TESTS/t_udb_ge3.ald UNIT_TESTS/t_udb_ge3.ali \
UNIT_TESTS/test.ali test_config.ali posix-error.ali posix-user_db.ali \
posix-ada.a
	./ada-bind UNIT_TESTS/t_udb_ge3.ali
	./ada-link UNIT_TESTS/t_udb_ge3 UNIT_TESTS/t_udb_ge3.ali posix-ada.a

UNIT_TESTS/t_udb_ge3.ali:\
ada-compile UNIT_TESTS/t_udb_ge3.adb posix-error.ali posix-user_db.ali \
UNIT_TESTS/test.ali
	./ada-compile UNIT_TESTS/t_udb_ge3.adb

UNIT_TESTS/t_udb_ge3.o:\
UNIT_TESTS/t_udb_ge3.ali

UNIT_TESTS/t_udb_ge4:\
ada-bind ada-link UNIT_TESTS/t_udb_ge4.ald UNIT_TESTS/t_udb_ge4.ali \
UNIT_TESTS/test.ali test_config.ali posix-error.ali posix-user_db.ali \
posix-ada.a
	./ada-bind UNIT_TESTS/t_udb_ge4.ali
	./ada-link UNIT_TESTS/t_udb_ge4 UNIT_TESTS/t_udb_ge4.ali posix-ada.a

UNIT_TESTS/t_udb_ge4.ali:\
ada-compile UNIT_TESTS/t_udb_ge4.adb posix-error.ali posix-user_db.ali \
UNIT_TESTS/test.ali
	./ada-compile UNIT_TESTS/t_udb_ge4.adb

UNIT_TESTS/t_udb_ge4.o:\
UNIT_TESTS/t_udb_ge4.ali

UNIT_TESTS/t_udb_ge5:\
ada-bind ada-link UNIT_TESTS/t_udb_ge5.ald UNIT_TESTS/t_udb_ge5.ali \
UNIT_TESTS/test.ali test_config.ali posix-error.ali posix-user_db.ali \
posix-ada.a
	./ada-bind UNIT_TESTS/t_udb_ge5.ali
	./ada-link UNIT_TESTS/t_udb_ge5 UNIT_TESTS/t_udb_ge5.ali posix-ada.a

UNIT_TESTS/t_udb_ge5.ali:\
ada-compile UNIT_TESTS/t_udb_ge5.adb posix-error.ali posix-user_db.ali \
UNIT_TESTS/test.ali
	./ada-compile UNIT_TESTS/t_udb_ge5.adb

UNIT_TESTS/t_udb_ge5.o:\
UNIT_TESTS/t_udb_ge5.ali

UNIT_TESTS/t_udb_ge6:\
ada-bind ada-link UNIT_TESTS/t_udb_ge6.ald UNIT_TESTS/t_udb_ge6.ali \
UNIT_TESTS/test.ali test_config.ali posix-error.ali posix-user_db.ali \
posix-ada.a
	./ada-bind UNIT_TESTS/t_udb_ge6.ali
	./ada-link UNIT_TESTS/t_udb_ge6 UNIT_TESTS/t_udb_ge6.ali posix-ada.a

UNIT_TESTS/t_udb_ge6.ali:\
ada-compile UNIT_TESTS/t_udb_ge6.adb posix-error.ali posix-user_db.ali \
UNIT_TESTS/test.ali
	./ada-compile UNIT_TESTS/t_udb_ge6.adb

UNIT_TESTS/t_udb_ge6.o:\
UNIT_TESTS/t_udb_ge6.ali

UNIT_TESTS/t_unlink1:\
ada-bind ada-link UNIT_TESTS/t_unlink1.ald UNIT_TESTS/t_unlink1.ali \
UNIT_TESTS/test.ali test_config.ali posix-file.ali posix-permissions.ali \
posix-ada.a
	./ada-bind UNIT_TESTS/t_unlink1.ali
	./ada-link UNIT_TESTS/t_unlink1 UNIT_TESTS/t_unlink1.ali posix-ada.a

UNIT_TESTS/t_unlink1.ali:\
ada-compile UNIT_TESTS/t_unlink1.adb posix-error.ali posix-file.ali \
posix-permissions.ali UNIT_TESTS/test.ali
	./ada-compile UNIT_TESTS/t_unlink1.adb

UNIT_TESTS/t_unlink1.o:\
UNIT_TESTS/t_unlink1.ali

UNIT_TESTS/test.a:\
cc-slib UNIT_TESTS/test.sld UNIT_TESTS/test.o
	./cc-slib UNIT_TESTS/test UNIT_TESTS/test.o

UNIT_TESTS/test.ali:\
ada-compile UNIT_TESTS/test.adb UNIT_TESTS/test.ads
	./ada-compile UNIT_TESTS/test.adb

UNIT_TESTS/test.o:\
UNIT_TESTS/test.ali

ada-bind:\
conf-adabind conf-systype conf-adatype conf-adabflags conf-adafflist flags-cwd \
	flags-c_string

ada-compile:\
conf-adacomp conf-adatype conf-systype conf-adacflags conf-adafflist flags-cwd \
	flags-c_string

ada-link:\
conf-adalink conf-adatype conf-systype conf-adaldflags conf-aldfflist \
	libs-c_string-S

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

conf-sosuffix:\
mk-sosuffix
	./mk-sosuffix > conf-sosuffix.tmp && mv conf-sosuffix.tmp conf-sosuffix

conf-systype:\
mk-systype
	./mk-systype > conf-systype.tmp && mv conf-systype.tmp conf-systype

constants:\
cc-link constants.ld constants.o
	./cc-link constants constants.o

constants.o:\
cc-compile constants.c posix_config.h posix_ioctl.h
	./cc-compile constants.c

# ctxt/bindir.c.mff
ctxt/bindir.c: mk-ctxt conf-bindir
	rm -f ctxt/bindir.c
	./mk-ctxt ctxt_bindir < conf-bindir > ctxt/bindir.c

ctxt/bindir.o:\
cc-compile ctxt/bindir.c
	./cc-compile ctxt/bindir.c

ctxt/ctxt.a:\
cc-slib ctxt/ctxt.sld ctxt/bindir.o ctxt/dlibdir.o ctxt/incdir.o ctxt/repos.o \
ctxt/slibdir.o ctxt/version.o ctxt/fakeroot.o
	./cc-slib ctxt/ctxt ctxt/bindir.o ctxt/dlibdir.o ctxt/incdir.o ctxt/repos.o \
	ctxt/slibdir.o ctxt/version.o ctxt/fakeroot.o

# ctxt/dlibdir.c.mff
ctxt/dlibdir.c: mk-ctxt conf-dlibdir
	rm -f ctxt/dlibdir.c
	./mk-ctxt ctxt_dlibdir < conf-dlibdir > ctxt/dlibdir.c

ctxt/dlibdir.o:\
cc-compile ctxt/dlibdir.c
	./cc-compile ctxt/dlibdir.c

# ctxt/fakeroot.c.mff
ctxt/fakeroot.c: mk-ctxt conf-fakeroot
	rm -f ctxt/fakeroot.c
	./mk-ctxt ctxt_fakeroot < conf-fakeroot > ctxt/fakeroot.c

ctxt/fakeroot.o:\
cc-compile ctxt/fakeroot.c
	./cc-compile ctxt/fakeroot.c

# ctxt/incdir.c.mff
ctxt/incdir.c: mk-ctxt conf-incdir
	rm -f ctxt/incdir.c
	./mk-ctxt ctxt_incdir < conf-incdir > ctxt/incdir.c

ctxt/incdir.o:\
cc-compile ctxt/incdir.c
	./cc-compile ctxt/incdir.c

# ctxt/repos.c.mff
ctxt/repos.c: mk-ctxt conf-repos
	rm -f ctxt/repos.c
	./mk-ctxt ctxt_repos < conf-repos > ctxt/repos.c

ctxt/repos.o:\
cc-compile ctxt/repos.c
	./cc-compile ctxt/repos.c

# ctxt/slibdir.c.mff
ctxt/slibdir.c: mk-ctxt conf-slibdir
	rm -f ctxt/slibdir.c
	./mk-ctxt ctxt_slibdir < conf-slibdir > ctxt/slibdir.c

ctxt/slibdir.o:\
cc-compile ctxt/slibdir.c
	./cc-compile ctxt/slibdir.c

# ctxt/version.c.mff
ctxt/version.c: mk-ctxt VERSION
	rm -f ctxt/version.c
	./mk-ctxt ctxt_version < VERSION > ctxt/version.c

ctxt/version.o:\
cc-compile ctxt/version.c
	./cc-compile ctxt/version.c

deinstaller:\
cc-link deinstaller.ld deinstaller.o insthier.o install.a ctxt/ctxt.a
	./cc-link deinstaller deinstaller.o insthier.o install.a ctxt/ctxt.a

deinstaller.o:\
cc-compile deinstaller.c install.h ctxt.h
	./cc-compile deinstaller.c

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

install-core.o:\
cc-compile install-core.c install.h
	./cc-compile install-core.c

install-error.o:\
cc-compile install-error.c install.h
	./cc-compile install-error.c

install-posix.o:\
cc-compile install-posix.c install.h
	./cc-compile install-posix.c

install-win32.o:\
cc-compile install-win32.c install.h
	./cc-compile install-win32.c

install.a:\
cc-slib install.sld install-core.o install-posix.o install-win32.o \
install-error.o
	./cc-slib install install-core.o install-posix.o install-win32.o \
	install-error.o

install.h:\
install_os.h

installer:\
cc-link installer.ld installer.o insthier.o install.a ctxt/ctxt.a
	./cc-link installer installer.o insthier.o install.a ctxt/ctxt.a

installer.o:\
cc-compile installer.c ctxt.h install.h
	./cc-compile installer.c

instchk:\
cc-link instchk.ld instchk.o insthier.o install.a ctxt/ctxt.a
	./cc-link instchk instchk.o insthier.o install.a ctxt/ctxt.a

instchk.o:\
cc-compile instchk.c ctxt.h install.h
	./cc-compile instchk.c

insthier.o:\
cc-compile insthier.c ctxt.h install.h
	./cc-compile insthier.c

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

mk-sosuffix:\
conf-systype

mk-systype:\
conf-cc conf-ld

posix-ada-conf:\
cc-link posix-ada-conf.ld posix-ada-conf.o ctxt/ctxt.a
	./cc-link posix-ada-conf posix-ada-conf.o ctxt/ctxt.a

posix-ada-conf.o:\
cc-compile posix-ada-conf.c ctxt.h _sysinfo.h
	./cc-compile posix-ada-conf.c

posix-ada.a:\
cc-slib posix-ada.sld posix-c_types.o posix-directory.o posix-errno.o \
posix-error.o posix-file.o posix-file_status.o posix-io-control.o posix-io.o \
posix-path.o posix-permissions.o posix-process_info.o posix-symlink.o \
posix-user_db.o posix.o posix_error.o posix_passwd.o posix_stat.o
	./cc-slib posix-ada posix-c_types.o posix-directory.o posix-errno.o \
	posix-error.o posix-file.o posix-file_status.o posix-io-control.o posix-io.o \
	posix-path.o posix-permissions.o posix-process_info.o posix-symlink.o \
	posix-user_db.o posix.o posix_error.o posix_passwd.o posix_stat.o

# posix-c_types.ads.mff
posix-c_types.ads:   \
auto-warn.txt        \
posix-c_types.ads.sh \
type-discrete        \
LICENSE
	./posix-c_types.ads.sh > posix-c_types.ads.tmp
	mv posix-c_types.ads.tmp posix-c_types.ads

posix-c_types.ali:\
ada-compile posix-c_types.ads
	./ada-compile posix-c_types.ads

posix-c_types.o:\
posix-c_types.ali

# posix-directory.ads.mff
posix-directory.ads:   \
auto-warn.txt          \
posix-error.ads        \
posix-error.adb        \
posix-file.ads         \
posix-file.adb         \
posix-directory.ads.sh \
LICENSE
	./posix-directory.ads.sh > posix-directory.ads.tmp
	mv posix-directory.ads.tmp posix-directory.ads

posix-directory.ali:\
ada-compile posix-directory.adb posix.ali posix-directory.ads
	./ada-compile posix-directory.adb

posix-directory.o:\
posix-directory.ali

# posix-errno.ads.mff
posix-errno.ads:    \
auto-warn.txt       \
errno_enum_type.lua \
errno_to_ada.map    \
LICENSE             \
posix-errno.ads.sh  \
type-discrete
	./posix-errno.ads.sh > posix-errno.ads.tmp
	mv posix-errno.ads.tmp posix-errno.ads

posix-errno.ali:\
ada-compile posix-errno.ads
	./ada-compile posix-errno.ads

posix-errno.o:\
posix-errno.ali

# posix-error.adb.mff
posix-error.adb:    \
auto-warn.txt       \
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
posix-error.ads:    \
auto-warn.txt       \
errno_enum_type.lua \
errno_to_ada.map    \
LICENSE             \
posix-error.ads.sh  \
posix-errno.ads     \
type-discrete
	./posix-error.ads.sh > posix-error.ads.tmp
	mv posix-error.ads.tmp posix-error.ads

posix-error.ali:\
ada-compile posix-error.adb
	./ada-compile posix-error.adb

posix-error.o:\
posix-error.ali

# posix-file.ads.mff
posix-file.ads:       \
auto-warn.txt         \
LICENSE               \
posix-c_types.ads     \
posix-error.ads       \
posix_file            \
posix-file.ads.sh     \
posix-path.ads        \
posix-permissions.adb \
posix-permissions.ads \
posix-user_db.ads     \
type-discrete         \
type-offset
	./posix-file.ads.sh > posix-file.ads.tmp
	mv posix-file.ads.tmp posix-file.ads

posix-file.ali:\
ada-compile posix-file.adb posix.ali posix-file.ads
	./ada-compile posix-file.adb

posix-file.o:\
posix-file.ali

# posix-file_status.ads.mff
posix-file_status.ads:   \
auto-warn.txt            \
posix-error.adb          \
posix-error.ads          \
posix-file.adb           \
posix-file.ads           \
posix-file_status.ads.sh \
posix-permissions.ads    \
posix-user_db.adb        \
posix-user_db.ads        \
type-discrete            \
type-status              \
LICENSE
	./posix-file_status.ads.sh > posix-file_status.ads.tmp
	mv posix-file_status.ads.tmp posix-file_status.ads

posix-file_status.ali:\
ada-compile posix-file_status.adb posix-file_status.ads posix-c_types.ali
	./ada-compile posix-file_status.adb

posix-file_status.o:\
posix-file_status.ali

# posix-io-control.ads.mff
posix-io-control.ads:   \
auto-warn.txt           \
constants               \
posix-error.ads         \
posix-error.adb         \
posix-file.ads          \
posix-io.ads            \
posix-io-control.ads.sh \
type-discrete           \
LICENSE
	./posix-io-control.ads.sh > posix-io-control.ads.tmp
	mv posix-io-control.ads.tmp posix-io-control.ads

posix-io-control.ali:\
ada-compile posix-io-control.adb posix-io.ali posix-io-control.ads \
posix-c_types.ali
	./ada-compile posix-io-control.adb

posix-io-control.o:\
posix-io-control.ali

# posix-io.ads.mff
posix-io.ads:   \
auto-warn.txt   \
posix-error.ads \
posix-error.adb \
posix-file.ads  \
posix-file.adb  \
posix-io.ads.sh \
type-discrete   \
LICENSE
	./posix-io.ads.sh > posix-io.ads.tmp
	mv posix-io.ads.tmp posix-io.ads

posix-io.ali:\
ada-compile posix-io.adb posix.ali posix-io.ads posix-c_types.ali
	./ada-compile posix-io.adb

posix-io.o:\
posix-io.ali

# posix-path.ads.mff
posix-path.ads:  \
auto-warn.txt    \
constants        \
LICENSE          \
posix-path.ads.sh
	./posix-path.ads.sh > posix-path.ads.tmp
	mv posix-path.ads.tmp posix-path.ads

posix-path.ali:\
ada-compile posix-path.ads
	./ada-compile posix-path.ads

posix-path.o:\
posix-path.ali

# posix-permissions.ads.mff
posix-permissions.ads:   \
auto-warn.txt            \
constants                \
posix-permissions.ads.sh \
type-discrete            \
type-mode                \
LICENSE
	./posix-permissions.ads.sh > posix-permissions.ads.tmp
	mv posix-permissions.ads.tmp posix-permissions.ads

posix-permissions.ali:\
ada-compile posix-permissions.adb posix.ali posix-permissions.ads
	./ada-compile posix-permissions.adb

posix-permissions.o:\
posix-permissions.ali

# posix-process_info.ads.mff
posix-process_info.ads:   \
auto-warn.txt             \
posix-error.ads           \
posix-error.adb           \
posix-user_db.ads         \
posix-user_db.adb         \
posix-process_info.ads.sh \
type-discrete             \
LICENSE
	./posix-process_info.ads.sh > posix-process_info.ads.tmp
	mv posix-process_info.ads.tmp posix-process_info.ads

posix-process_info.ali:\
ada-compile posix-process_info.adb posix-process_info.ads
	./ada-compile posix-process_info.adb

posix-process_info.o:\
posix-process_info.ali

# posix-symlink.ads.mff
posix-symlink.ads:    \
auto-warn.txt         \
LICENSE               \
posix-error.ads       \
posix-file.ads        \
posix-symlink.ads.sh  \
posix-path.ads        \
type-discrete
	./posix-symlink.ads.sh > posix-symlink.ads.tmp
	mv posix-symlink.ads.tmp posix-symlink.ads

posix-symlink.ali:\
ada-compile posix-symlink.adb posix.ali posix-symlink.ads posix-path.ali
	./ada-compile posix-symlink.adb

posix-symlink.o:\
posix-symlink.ali

# posix-user_db.ads.mff
posix-user_db.ads:   \
auto-warn.txt        \
constants            \
posix-c_types.ads    \
posix-user_db.ads.sh \
type-discrete        \
type-passwd          \
LICENSE
	./posix-user_db.ads.sh > posix-user_db.ads.tmp
	mv posix-user_db.ads.tmp posix-user_db.ads

posix-user_db.ali:\
ada-compile posix-user_db.adb posix-c_types.ali
	./ada-compile posix-user_db.adb

posix-user_db.o:\
posix-user_db.ali

posix.ali:\
ada-compile posix.ads posix.ads
	./ada-compile posix.ads

posix.o:\
posix.ali

posix_error.o:\
cc-compile posix_error.c posix_config.h
	./cc-compile posix_error.c

posix_file:\
cc-link posix_file.ld posix_file.o
	./cc-link posix_file posix_file.o

posix_file.o:\
cc-compile posix_file.c posix_config.h
	./cc-compile posix_file.c

posix_ioctl.h:\
_sd_streams.h

posix_passwd.o:\
cc-compile posix_passwd.c posix_config.h posix_passwd.h
	./cc-compile posix_passwd.c

posix_stat.o:\
cc-compile posix_stat.c posix_config.h
	./cc-compile posix_stat.c

spark_config:\
ada-bind ada-link spark_config.ald spark_config.ali
	./ada-bind spark_config.ali
	./ada-link spark_config spark_config.ali

spark_config.ali:\
ada-compile spark_config.adb
	./ada-compile spark_config.adb

spark_config.o:\
spark_config.ali

# test_config.ads.mff
test_config.ads:   \
test_config.ads.sh \
conf-T-gid         \
conf-T-root_dir    \
conf-T-shell       \
conf-T-uid         \
conf-T-user
	./test_config.ads.sh > test_config.ads.tmp
	mv test_config.ads.tmp test_config.ads

test_config.ali:\
ada-compile test_config.ads
	./ada-compile test_config.ads

test_config.o:\
test_config.ali

type-discrete:\
cc-link type-discrete.ld type-discrete.o
	./cc-link type-discrete type-discrete.o

type-discrete.o:\
cc-compile type-discrete.c posix_config.h
	./cc-compile type-discrete.c

type-mode:\
cc-link type-mode.ld type-mode.o
	./cc-link type-mode type-mode.o

type-mode.o:\
cc-compile type-mode.c posix_config.h
	./cc-compile type-mode.c

type-offset:\
cc-link type-offset.ld type-offset.o
	./cc-link type-offset type-offset.o

type-offset.o:\
cc-compile type-offset.c
	./cc-compile type-offset.c

type-passwd:\
cc-link type-passwd.ld type-passwd.o
	./cc-link type-passwd type-passwd.o

type-passwd.o:\
cc-compile type-passwd.c posix_config.h posix_passwd.h
	./cc-compile type-passwd.c

type-status:\
cc-link type-status.ld type-status.o
	./cc-link type-status type-status.o

type-status.o:\
cc-compile type-status.c posix_config.h
	./cc-compile type-status.c

clean-all: sysdeps_clean tests_clean local_clean obj_clean ext_clean
clean: obj_clean
obj_clean:
	rm -f UNIT_TESTS/t_em1 UNIT_TESTS/t_em1.ali UNIT_TESTS/t_em1.o \
	UNIT_TESTS/t_error1 UNIT_TESTS/t_error1.ali UNIT_TESTS/t_error1.o \
	UNIT_TESTS/t_io1 UNIT_TESTS/t_io1.ali UNIT_TESTS/t_io1.o UNIT_TESTS/t_open1 \
	UNIT_TESTS/t_open1.ali UNIT_TESTS/t_open1.o UNIT_TESTS/t_open2 \
	UNIT_TESTS/t_open2.ali UNIT_TESTS/t_open2.o UNIT_TESTS/t_perm1 \
	UNIT_TESTS/t_perm1.ali UNIT_TESTS/t_perm1.o UNIT_TESTS/t_stat1 \
	UNIT_TESTS/t_stat1.ali UNIT_TESTS/t_stat1.o UNIT_TESTS/t_stat2 \
	UNIT_TESTS/t_stat2.ali UNIT_TESTS/t_stat2.o UNIT_TESTS/t_symlink1 \
	UNIT_TESTS/t_symlink1.ali UNIT_TESTS/t_symlink1.o UNIT_TESTS/t_symlink2 \
	UNIT_TESTS/t_symlink2.ali UNIT_TESTS/t_symlink2.o UNIT_TESTS/t_symlink3 \
	UNIT_TESTS/t_symlink3.ali UNIT_TESTS/t_symlink3.o UNIT_TESTS/t_udb_ge1 \
	UNIT_TESTS/t_udb_ge1.ali UNIT_TESTS/t_udb_ge1.o UNIT_TESTS/t_udb_ge2 \
	UNIT_TESTS/t_udb_ge2.ali UNIT_TESTS/t_udb_ge2.o UNIT_TESTS/t_udb_ge3 \
	UNIT_TESTS/t_udb_ge3.ali UNIT_TESTS/t_udb_ge3.o UNIT_TESTS/t_udb_ge4 \
	UNIT_TESTS/t_udb_ge4.ali UNIT_TESTS/t_udb_ge4.o UNIT_TESTS/t_udb_ge5 \
	UNIT_TESTS/t_udb_ge5.ali UNIT_TESTS/t_udb_ge5.o
	rm -f UNIT_TESTS/t_udb_ge6 UNIT_TESTS/t_udb_ge6.ali UNIT_TESTS/t_udb_ge6.o \
	UNIT_TESTS/t_unlink1 UNIT_TESTS/t_unlink1.ali UNIT_TESTS/t_unlink1.o \
	UNIT_TESTS/test.a UNIT_TESTS/test.ali UNIT_TESTS/test.o constants constants.o \
	ctxt/bindir.c ctxt/bindir.o ctxt/ctxt.a ctxt/dlibdir.c ctxt/dlibdir.o \
	ctxt/fakeroot.c ctxt/fakeroot.o ctxt/incdir.c ctxt/incdir.o ctxt/repos.c \
	ctxt/repos.o ctxt/slibdir.c ctxt/slibdir.o ctxt/version.c ctxt/version.o \
	deinstaller deinstaller.o errno_int errno_int.c errno_int.o install-core.o \
	install-error.o install-posix.o install-win32.o install.a installer installer.o \
	instchk instchk.o insthier.o posix-ada-conf posix-ada-conf.o posix-ada.a \
	posix-c_types.ads posix-c_types.ali posix-c_types.o posix-directory.ads \
	posix-directory.ali posix-directory.o posix-errno.ads posix-errno.ali \
	posix-errno.o posix-error.adb posix-error.ads posix-error.ali posix-error.o \
	posix-file.ads posix-file.ali posix-file.o posix-file_status.ads \
	posix-file_status.ali posix-file_status.o posix-io-control.ads \
	posix-io-control.ali posix-io-control.o posix-io.ads posix-io.ali posix-io.o
	rm -f posix-path.ads posix-path.ali posix-path.o posix-permissions.ads \
	posix-permissions.ali posix-permissions.o posix-process_info.ads \
	posix-process_info.ali posix-process_info.o posix-symlink.ali posix-symlink.o \
	posix-user_db.ads posix-user_db.ali posix-user_db.o posix.ali posix.o \
	posix_error.o posix_file posix_file.o posix_passwd.o posix_stat.o spark_config \
	spark_config.ali spark_config.o test_config.ads test_config.ali test_config.o \
	type-discrete type-discrete.o type-mode type-mode.o type-offset type-offset.o \
	type-passwd type-passwd.o type-status type-status.o
ext_clean:
	rm -f conf-adatype conf-cctype conf-ldtype conf-sosuffix conf-systype mk-ctxt

regen:\
ada-srcmap ada-srcmap-all
	./ada-srcmap-all
	cpj-genmk > Makefile.tmp && mv Makefile.tmp Makefile
