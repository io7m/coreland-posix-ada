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

/* XXX: Platforms rarely provide a compile-time constant for this.
 *      However, the constant is used in these bindings to specify
 *      a buffer size for getpwnam_r which corresponds directly to
 *      the length of a single line in /etc/passwd.
 */

#define POSIX_PASSWD_BUFFER_SIZE LINE_MAX

struct posix_passwd_t {
  char string_buffer [POSIX_PASSWD_BUFFER_SIZE];
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

gid_t
posix_passwd_get_gid (const struct posix_passwd_t *);

void
posix_passwd_get_pw_name (const struct posix_passwd_t *, char *, unsigned int *);

void
posix_passwd_get_pw_dir (const struct posix_passwd_t *, char *, unsigned int *);

void
posix_passwd_get_pw_shell (const struct posix_passwd_t *, char *, unsigned int *);

#endif
