#
# Cookbook Name:: openstack-prep
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template '/root/scripts/createdb.sh' do
  source 'createdb.sh.erb'
  owner 'root'
  group 'root'
  mode '0644'
end