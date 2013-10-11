#
# Cookbook Name:: git-server
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#
include_recipe 'apt'
include_recipe 'git'
include_recipe 'gitolite'

gitolite_user node.gitolite.username do
  home node.gitolite.home
  version node.gitolite.version
  ssh_key node.misc.ssh_key
end

include_recipe 's3cmd'
include_recipe 'cron'

cron_d 'backup_git_repos_to_s3' do
  minute  0
  hour    3
  command "s3cmd sync #{node.gitolite.home}/repositories s3://git-server-repos/"
end
