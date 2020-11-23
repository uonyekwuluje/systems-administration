#!/usr/bin/env python

from github import Github
from pathlib import Path
import shutil
import os
import requests
import git


def list_repositories(githuburl,githubuser):
    """
    List all repositories for given user
    """
    user_link = githuburl+"/users/"+ githubuser
    try:
        request = requests.get(user_link+"/repos")
        json = request.json()
	for i in range(0,len(json)):
	    print("Project Number:",i+1)
	    print("Project Name:", str(json[i]['name']))
	    print("Project HTTP URL:", str(json[i]['svn_url']))
	    print("Project SSH URL:", str(json[i]['ssh_url']))
    except:
        print 'Failed to get api request for %s' % user_link 


def clone_repositories(githuburl,githubuser,githubtoken):
    """
    Delete existing directories and clone all repositories for the given user
    """
    github_token = Github(githubtoken)
    user = github_token.get_user() 
    repos = github_token.get_user(githubuser).get_repos() 
    for repo in repos:
        repo_path = Path(repo.name)
        if (repo_path.exists() and repo_path.is_dir()):
            shutil.rmtree(str(repo_path)) 

    for repo in repos:
        print("Cloning {}".format(repo.ssh_url))
        git.Repo.clone_from(repo.ssh_url, repo.name)
        #print(repo.name) 
        #print(repo.ssh_url) 





if __name__ == '__main__':
    GITHUB_USERNAME=os.getenv('GITHUB_USER')
    GITHUB_API_TOKEN=os.getenv('GITHUB_TOKEN')
    GITHUB_API_URL='https://api.github.com'
    list_repositories(GITHUB_API_URL, GITHUB_USERNAME)
    clone_repositories(GITHUB_API_URL, GITHUB_USERNAME, GITHUB_API_TOKEN)
