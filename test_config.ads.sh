#!/bin/sh

conf_group_id=`head -n 1 conf-T-gid`      || exit 1
conf_root_dir=`head -n 1 conf-T-root_dir` || exit 1
   conf_shell=`head -n 1 conf-T-shell`    || exit 1
    conf_user=`head -n 1 conf-T-user`     || exit 1
 conf_user_id=`head -n 1 conf-T-uid`      || exit 1

cat <<EOF
package Test_Config is
  pragma Pure (Test_Config);

  User_Directory : constant String := "${conf_root_dir}";
  User_GID       : constant        := ${conf_group_id};
  User_ID        : constant        := ${conf_user_id};
  User_Name      : constant String := "${conf_user}";
  User_Shell     : constant String := "${conf_shell}";

end Test_Config;
EOF
