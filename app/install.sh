#! /usr/bin/env bash

# Public Domain (-) 2018-present, The Elko Authors.
# See the Elko UNLICENSE file for details.

# NOTE: This script has only been tested in the context of a modern Bash shell
# on Ubuntu Linux and macOS. Any patches to make it work under alternative Unix
# shells, versions, and platforms will be very welcome. Thank you!
#
# Source: https://github.com/elko/website/blob/master/app/install.sh

function domsg {
  printf "\033[34m$1\033[0m\n"
}

function errmsg {
  printf "\033[31m!! ERROR: $1 !!\033[0m\n"
}

function exitmsg {
  echo
  errmsg "$1"
  exit
}

function notice {
  printf "\033[31m$1\033[0m\n\n"
}

function success {
  printf "\033[32m$1\033[0m\n\n"
}

function install {

  cat << EOF


                 ┏━╸╻  ╻┏ ┏━┓
                 ┣╸ ┃  ┣┻┓┃ ┃
                 ┗━╸┗━╸╹ ╹┗━┛

EOF

  os="$(uname -s | tr 'A-Z' 'a-z')"
  case $os in
    darwin)
      digest="%(darwin)s";;
    linux)
      digest="%(linux)s";;
    *)
      exitmsg "Sorry, the $os operating system is not supported by this script. Patches welcome!";;
  esac

  tmpdir="$(mktemp -d -t elko.install)" || exitmsg "Unable to create temp directory"
  tmpfile="$tmpdir/$digest.tar"
  url="https://storage.googleapis.com/elko.io/release/$digest.tar"

  echo
  domsg ">> Downloading the latest Elko release"
  domsg "   $url"
  echo

  curl -#f $url > "$tmpfile" || exitmsg "Unable to download the Elko release file"

  echo
  domsg ">> Validating file integrity"

  cd "$tmpdir"
  echo "$digest  $digest.tar" > elko.checksum
  shasum -a 512256 -c elko.checksum -s || exitmsg "Integrity check failed on the downloaded Elko release file"

  echo
  domsg ">> Installing the Elko binary to /usr/local/bin/elko"
  echo

  tar xf "$digest.tar" || exitmsg "Unable to untar the downloaded Elko release file"
  mkdir -p /usr/local/bin || exitmsg "Unable to create /usr/local/bin. Please re-run script as sudo"
  mv elko /usr/local/bin/elko || exitmsg "Unable to create /usr/local/bin/elko. Please re-run script as sudo"

  rm -rf "$tmpdir"  

  if [[ ":$PATH:" != *":/usr/local/bin:"* ]]; then
    notice "PLEASE NOTE: You need to add /usr/local/bin to your \$PATH"
  fi

  success "✔  Elko installed successfully!!"

}

install "$@"
