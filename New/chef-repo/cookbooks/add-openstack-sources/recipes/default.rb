#
# Cookbook Name:: add-openstack-sources
# Recipe:: default
#
# Copyright 2016, HealthSeq Asia Pvt. Ltd.
# Maintainer <satish@healthseq.com>
#
# All rights reserved - Do Not Redistribute
#
# TO DO : Change the ntp servers under attributes.
#
# Cookbook Name:: add-openstack-sources
# Recipe:: default
#
# Copyright 2016, HealthSeq Asia Pvt. Ltd.
# Maintainer <satish@healthseq.com>
# All rights reserved - Do Not Redistribute
#


package 'software-properties-common' do
  action :install
end

include_recipe 'apt'

package 'python-openstackclient' do
  action :install
end

# To store all our scripts and creds files
directory '/root/scripts' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

for packages in [ "wget", "python-dev", "python-pip", "git", "wget", "curl", "apache2"] do
  package packages do
    action :install
  end
end