
#!/usr/bin/env sh
# author: Andrea Foletto @nullndr

set -o pipefail
set -u

usage() {
  echo "Usage: $0 [command]"
}

print_version() {
  echo "$0 v0.1"
  echo "This is a free software; There is NO warranty."
  echo "See the source for more."
}

main() {
  
  if [[ $# -eq 0 || $# -gt 1 ]]; then
    usage $@
    exit 1
  fi

  if [[ $1 == "--version" ]]; then
    print_version $0
    exit 0
  fi
  
  $1 > /dev/null 2>&1

  if [ $? -eq 127 ]; then
    echo "$0: command not found: $1"
  else
   
    $1 --version | read output    

 
    if [ $? -ne 0 ]; then
      echo "Command $1 does not have a '--version' flag"
      exit 0
    fi

    echo $output
  fi
  
  exit 0
}

main $@
