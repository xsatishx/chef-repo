#
# Cookbook Name:: mysql-server
# Recipe:: default
#
# Copyright 2016, HealthSeq Asia Pvt. Ltd.
# Maintainer <satish@healthseq.com>
# All rights reserved - Do Not Redistribute
#

default['mysql-server']['passwd'] = 'healthseq'
default['mysql-server']['host'] = 'devcontroller'