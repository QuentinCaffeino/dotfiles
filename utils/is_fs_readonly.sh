#!/usr/bin/env sh

set -ex

# NOTE: was not tested
# inspired by steamos-readonly script

is_extfs_readonly() {
  if tune2fs -l "$ROOTDEV" | grep -q '^Filesystem features: .*read-only.*$'
  then
    printf "yes"
    return
  else
    printf "no"
    return 1
  fi
}

is_btrfs_readonly() {
  prop_val=$(btrfs property get / ro)

  if [ $prop_val == "ro=true" ];
  then
    printf "yes"
  else
    printf "no"
    return 1
  fi
}

is_fs_readonly() {
  . $(chezmoi source-path)/detect_fs.sh

  local fstype=$(detect_fs)

  case "$fstype" in
    ext4)
      ;;
    btrfs)
      ;;
    *)
      echo "Unrecognized root filesystem type $fstype"
      exit 1
    esac

  is_$fstype_readonly
}
