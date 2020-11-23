#!/bin/bash
#: Title         : repo-clone 
#: Description   : This script cleans out your directory and clones your git repositories 
#: Options       : None
#: Assumptions   : This script assumes the following
#:               : [1] You have configured and setup SSH correctly
#:               : [2] All clone actions will be in the current folder
#:               : [3] Cloning as is

GIT_REPO_NAMES=
GIT_REPO_SSHURLS=
# Update USER_NAME with your GitHub username
# -------------------------------------------
USER_NAME=""
# -------------------------------------------

# Retrieve Git Repository Names and SSH URLS
getGitRepoNames() {
  GIT_REPO_NAMES=$(curl -s "https://api.github.com/users/${USER_NAME}/repos" | jq -r '.[] | .name')
  GIT_REPO_SSHURLS=$(curl -s "https://api.github.com/users/${USER_NAME}/repos" | jq -r '.[] | .ssh_url')
}

# Delete and Clone Repositories
cleanupClone() {
  declare -a GIT_REPO_NAMES_ARRAY=(${GIT_REPO_NAMES})
  declare -a GIT_REPO_SSHURLS_ARRAY=(${GIT_REPO_SSHURLS})
  
  # Loop through names and delete repo folders
  for repo_dir in "${GIT_REPO_NAMES_ARRAY[@]}"
  do
   if [ -d  ${repo_dir} ];
   then
     printf "${repo_dir} Directory exists. Deleting now\n"
     rm -rf ${repo_dir}
   else
     printf "${repo_dir} Directory Does Not Exist\n" 
   fi
  done


  # Loop through links and clone
  for repo_dir in "${GIT_REPO_SSHURLS_ARRAY[@]}"
  do
    git clone ${repo_dir}
  done
}


# Main Driver
# -------------
getGitRepoNames
cleanupClone
