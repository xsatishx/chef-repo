#
# Cookbook Name:: openstack-prep
# Recipe:: default
#
# Copyright 2016, HealthSeq Asia Pvt. Ltd.
# Maintainer Satish Balakrishnan <satish@healthseq.com>
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

service "mysql" do
  supports :status => true, :restart => true, :stop => true, :start => true
  action [:restart]
end