#!/bin/bash

set -e

VENDOR=oneplus
DEVICE=bacon
DEVBASE=../../../vendor/$VENDOR/$DEVICE/proprietary
echo "Deleting $DEVBASE"
rm -rf $DEVBASE

function extract() {
  local _file=$1
  local _basedir=$2
  [ ! -f "$_file" ] && {
    echo "[$_file] must be passed and exist"
    return 1
  }
  [ ! -d "$_basedir" ] && {
    mkdir -p $_basedir
  }

  local _optional=no
  local _filepath=
  local _dirpath=
  local _filename=
  OIFS="$IFS"
  while IFS= read -r _line
  do
      _optional=no
      if [[ $_line == \#* ]] || [[ "$_line" == "" ]]
      then
          continue
      elif [[ $_line == -* ]]
      then
          _filepath=${_line:1}
          _optional=yes
      else
          _filepath=${_line}
      fi
      OIFS2="$IFS"
      IFS=":"
      for _p in ${_filepath[@]}    # traverse through elements
      do
        local _relpath=${_p}
        _filename="${_p##*/}"
        if [[ $_p == *"/"* ]]
        then
          _dirpath="${_p%/*}"
          if [ ! -d $_dirpath ]
          then
              mkdir -p "${_basedir}"/"${_dirpath}"
          fi
        else
          _dirpath=""
        fi
        echo -n "Attempt to extract /system/${_relpath} -> ${_basedir}/${_relpath} "
        adb pull /system/${_relpath} ${_basedir}/${_relpath} || \
          echo " (SKIPPED)"
      done
  done < "$_file"
  IFS="$OIFS"
}



extract proprietary-blobs.txt $DEVBASE

