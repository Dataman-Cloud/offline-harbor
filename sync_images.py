#!/usr/bin/env python
# Function: sync harbor registry
# Author: jyliu jyliu@dataman-inc.com
# Date: 2017-1-20

import requests
import json
import subprocess

stage_harbor_domain="dockerimg.sephora.cn"
prod_harbor_domain="prddockerimg.sephora.cn"
stage_harbor_url = "http://%s" %stage_harbor_domain
prod_harbor_url = "http://%s" %prod_harbor_domain
user = "admin"
password = "Harbor12345"

def get_repos(base_url,project_id):
	r = requests.get("%s/api/repositories?project_id=%s" %(base_url,project_id))
	return json.loads(r.text)

def get_repo_tag(base_url,repo_name):
	r = requests.get("%s/api/repositories/tags?repo_name=%s" %(base_url,repo_name))
	return json.loads(r.text)



stage_repos = get_repos(stage_harbor_url,1)

for repo in stage_repos:
	stage_tags = get_repo_tag(stage_harbor_url,repo)
	prod_tags = get_repo_tag(prod_harbor_url,repo)


	tags = list(set(stage_tags).difference(set(prod_tags)))
	if tags:
		print "sync %s %s ." %(repo,tags)
	else:
		print "%s is the latest." %(repo)
	for tag in tags:
		stage_img_name="%s/%s:%s" %(stage_harbor_domain, repo, tag)
		prod_img_name="%s/%s:%s" %(prod_harbor_domain, repo, tag)
		print stage_img_name
		cmd1 = "docker pull %s" %stage_img_name
		subprocess.Popen(cmd1, shell=True)
		cmd2 = "docker tag %s %s" %(stage_img_name, prod_img_name)
		subprocess.Popen(cmd2, shell=True)
		cmd3 = "docker push %s " %(prod_img_name)  ## docker rmi %s %s " %(prod_img_name, stage_img_name, prod_img_name)
		subprocess.Popen(cmd3, shell=True)
