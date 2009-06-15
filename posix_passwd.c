#include <errno.h>
#include <string.h>
#include "posix_passwd.h"

enum posix_passwd_result_t
posix_getpwnam (const char *name, struct posix_passwd_t *pw)
/*@globals errno; @*/
/*@modifies errno; @*/
{
  int r;
  errno = 0;

  r = getpwnam_r
    (name,
    &pw->storage,
     pw->string_buffer,
     sizeof (pw->string_buffer),
    &pw->result_ptr);

  /* No error, user record found. */
  if ((r == 0) && (pw->result_ptr != NULL)) {
    return POSIX_PASSWD_RESULT_OK;
  }

  /* No error, no user record found. */
  if ((r == 0) && (pw->result_ptr == NULL)) {
    return POSIX_PASSWD_RESULT_NO_USER;
  }

  /* Error occurred. */
  return POSIX_PASSWD_RESULT_ERROR;
}

enum posix_passwd_result_t
posix_getpwuid (uid_t uid, struct posix_passwd_t *pw)
/*@globals errno; @*/
/*@modifies errno; @*/
{
  errno = 0;
  return POSIX_PASSWD_RESULT_ERROR;
}

uid_t                      
posix_passwd_get_uid (const struct posix_passwd_t *pw)
{
  return pw->result_ptr->pw_uid;
}

gid_t                      
posix_passwd_get_gid (const struct posix_passwd_t *pw)
{
  return pw->result_ptr->pw_gid;
}

void
posix_passwd_get_pw_name (const struct posix_passwd_t *pw,
  char *data, unsigned int *data_length)
{
  const char *name          = pw->result_ptr->pw_name;
  const unsigned int length = strlen (name);

  (void) memcpy (data, name, length);
  *data_length = length;
}

void
posix_passwd_get_pw_dir (const struct posix_passwd_t *pw,
  char *data, unsigned int *data_length)
{
  const char *dir           = pw->result_ptr->pw_dir;
  const unsigned int length = strlen (dir);

  (void) memcpy (data, dir, length);
  *data_length = length;
}

void
posix_passwd_get_pw_shell (const struct posix_passwd_t *pw,
  char *data, unsigned int *data_length)
{
  const char *shell         = pw->result_ptr->pw_shell;
  const unsigned int length = strlen (shell);

  (void) memcpy (data, shell, length);
  *data_length = length;
}
