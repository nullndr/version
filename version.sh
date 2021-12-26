#!/usr/bin/env bash
# author: @nullndr <andrea@yaaaw.it>

set -o pipefail
set -u

print_usage() {
  echo "Usage: version <command>"
  echo "       version <option> "
  echo "where Options:"
  echo -e "\t--version: print software's version"
  echo -e "\t--help, -h: print this page"
}

print_version() {
  version="0.1"
  echo "version $version"
  echo "This is a free software; There is NO warranty."
  echo "See the source for more."
}

check_args() {

  if [[ $# -ne 1  ]]; then
    print_usage
    exit 128
  fi

  case $1 in
   	'--help' | '-h' ) print_usage; exit 0 ;;
  	'--version' ) print_version; exit 0 ;;
  esac
}

main() {

  check_args "$@"

  if ! which "$1" > /dev/null 2> /dev/null ; then
    echo "version: command $1 not found"
  else

		first_flag=1
    if $1 --version > /dev/null 2> /dev/null; then first_flag=0; fi

    second_flag=1
    if $1 -version > /dev/null 2> /dev/null; then second_flag=0; fi

    if [[ $first_flag -eq 0 ]] && [[ $second_flag -eq 0 ]]; then
    	echo "Command $1 does not have a --version or -version flag :("
    else
      if [[ $first_flag -eq 0 ]]; then
        $1 --version
      elif [[ $second_flag -eq 0 ]]; then
        $1 -version
      fi
  	fi
  fi

  exit 0
}

main "$@"
