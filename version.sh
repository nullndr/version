#!/usr/bin/env bash
# author: @nullndr

set -o pipefail
set -u

usage() {
  echo "Usage: version [[command] [options]]"
  echo "where Options:"
  echo -e "\t--version: print software's version"
  echo -e "\t--help, -h: print this page"
}

print_version() {
  echo "version v0.1"
  echo "This is a free software; There is NO warranty."
  echo "See the source for more."
}

main() {

  if [[ $# -lt 1 || $# -gt 2 || $1 == "--help" || $1 == "-h" ]]; then
    usage
    exit 1
  fi

  if [[ $1 == "--version" ]]; then
    print_version
    exit 0
  fi

  if ! which "$1" > /dev/null 2> /dev/null ; then
    echo "version: command not found: $1"
  else

		first_flag=1
    if $1 --version > /dev/null 2> /dev/null; then first_flag=0; fi

    second_flag=1
    if $1 -version > /dev/null 2> /dev/null; then second_flag=0; fi

    if [[ $first_flag -eq 0 ]] && [[ $second_flag -eq 0 ]]; then
    	echo "Command $1 does not have a --version or -version flag :("
    	exit 0
  	fi

    if [[ $first_flag -eq 0 ]]; then $1 --version; exit 0; fi
    if [[ $second_flag -eq 0 ]]; then $1 -version; exit 0; fi
  fi
  
  exit 0
}

main "$@"
