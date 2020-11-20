#!/bin/bash
#: Title     : Bash CML Parameters
#: Data      : 2020-11-19
#: Author    : "Uchechukwu Onyekwuluje" <email@email.com>
#: Version   : 1.0
#: Description  : Testing Command Line Parameters
#: Options   : CML Parameters

printf "The number of arguments is %s\n" "$#"
printf "Arguments are %s \n %s" "$1 $2"

# Print everything on cml
printf "\n\nExpand Args => %s" "$*"

# Print this line by line as is
printf "\n\nExpand Args => %s" "$@"
printf "\n"

printf "Current Script is %s\n" "$0"
