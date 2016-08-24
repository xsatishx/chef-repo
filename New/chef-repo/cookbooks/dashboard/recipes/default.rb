#
# Cookbook Name:: dashboard
# Recipes:: default
#
# Copyright 2016, HealthSeq Asia Pvt. Ltd.
# Maintainer Satish Balakrishnan <satish@healthseq.com>
#
# All rights reserved - Do Not Redistribute
#

package 'openstack-dashboard' do
  action :install
end

template '/etc/openstack-dashboard/local_settings.py' do
  source 'local_settings.py.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

service 'apache2' do
  supports :status => true, :restart => true, :reload => true
  action [:enable]
end

