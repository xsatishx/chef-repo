#
# Cookbook Name:: add-openstack-sources
# Recipe:: default
#
# Copyright 2018, HealthSeq Asia Pvt. Ltd.
# Maintainer Satish Balakrishnan <satish@healthseq.com>
#
# All rights reserved - Do Not Redistribute
#

package 'software-properties-common' do
  action :install
end

bash 'add-apt-repo' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
    add-apt-repository cloud-archive:pike
    apt-key update
  EOH
end

bash 'apt-update-updgrade' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
    apt-get update -y && apt-get dist-upgrade -y 
  EOH
end


for packages in [ "git", "wget", "curl"] do
  package packages do
    action :install
  end
end

package 'python-openstackclient' do
  action :install
  action :upgrade
end

