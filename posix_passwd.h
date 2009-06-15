#ifndef POSIX_PASSWD_H
#define POSIX_PASSWD_H

#include <sys/types.h>
#include <limits.h>
#include <pwd.h>
#include <unistd.h>

enum posix_passwd_result_t {
  POSIX_PASSWD_RESULT_OK      = 0,
  POSIX_PASSWD_RESULT_NO_USER = 1,
  POSIX_PASSWD_RESULT_ERROR   = 2,
};

struct posix_passwd_t {
  char string_buffer [_SC_GETPW_R_SIZE_MAX];
  struct passwd storage;
  struct passwd *result_ptr;
};

enum posix_passwd_result_t
posix_getpwnam (const char *, struct posix_passwd_t *)
/*@globals errno; @*/
/*@modifies errno; @*/
;

enum posix_passwd_result_t
posix_getpwuid (uid_t uid, struct posix_passwd_t *)
/*@globals errno; @*/
/*@modifies errno; @*/
;

uid_t
posix_passwd_get_uid (const struct posix_passwd_t *);

void
posix_passwd_get_pw_name (const struct posix_passwd_t *, char *, unsigned int *);

#endif
