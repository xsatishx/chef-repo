#
# Cookbook Name:: telemetry
# Recipe:: default
#
# Copyright 2016, HealthSe Asia Pvt. Ltd.
# Maintainer Satish Balakrishnan <satish@healthseq.com>
#
# All rights reserved - Do Not Redistribute
#
- apt-get install mongodb-server mongodb-clients python-pymongo -y
- add the following to /etc/mongodb.conf
bind_ip = 10.0.2.13
smallfiles = true

package 'mongodb-server' do
  action :install
end

package 'mongodb-clients' do
  action :install
end

package 'python-pymongo' do
  action :install
end

template '/etc/mongodb.conf' do
  source 'mongodb.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/root/scripts/ceilometerdb.sh' do
  source 'ceilometerdb.sh.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

bash 'Create-ceilometer-db' do
  user 'root'
  cwd '/root/scripts'
  code <<-EOH
    sh ceilometerdb.sh
  EOH
end