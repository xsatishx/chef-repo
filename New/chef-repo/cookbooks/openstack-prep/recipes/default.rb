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
  mode '0755'
end

bash 'Create-all-database' do
  user 'root'
  cwd '/root/scripts'
  code <<-EOH
    sh createdb.sh
  EOH
end

bash 'pip upgrade' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
     sudo pip install --upgrade python-openstackclient
  EOH
end