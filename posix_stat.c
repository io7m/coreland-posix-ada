#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

dev_t
posix_stat_st_dev (const struct stat *st)
{
  return st->st_dev;
}

ino_t
posix_stat_st_ino (const struct stat *st)
{
  return st->st_ino;
}

mode_t
posix_stat_st_mode (const struct stat *st)
{
  return st->st_mode;
}

nlink_t
posix_stat_st_nlink (const struct stat *st)
{
  return st->st_nlink;
}

uid_t
posix_stat_st_uid (const struct stat *st)
{
  return st->st_uid;
}

gid_t
posix_stat_st_gid (const struct stat *st)
{
  return st->st_gid;
}

dev_t
posix_stat_st_rdev (const struct stat *st)
{
  return st->st_rdev;
}

off_t
posix_stat_st_size (const struct stat *st)
{
  return st->st_size;
}

size_t
posix_stat_st_blksize (const struct stat *st)
{
  return st->st_blksize;
}

blkcnt_t
posix_stat_st_blocks (const struct stat *st)
{
  return st->st_blocks;
}

time_t
posix_stat_st_atime (const struct stat *st)
{
  return st->st_atime;
}

time_t
posix_stat_st_mtime (const struct stat *st)
{
  return st->st_mtime;
}

time_t
posix_stat_st_ctime (const struct stat *st)
{
  return st->st_ctime;
}

