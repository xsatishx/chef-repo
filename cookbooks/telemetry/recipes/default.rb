#
# Cookbook Name:: telemetry
# Recipe:: default
#
# Copyright 2016, HealthSeq Asia Pvt. Ltd.
# Maintainer Satish Balakrishnan <satish@healthseq.com>
#
# All rights reserved - Do Not Redistribute
#

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

template '/root/scripts/ceilometer_endpoints.sh' do
  source 'ceilometer_endpoints.sh.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

bash 'Set-Ceilometer-endpoints' do
  user 'root'
  cwd '/root/scripts'
  code <<-EOH
    source creds
    sh ceilometer_endpoints.sh
  EOH
end

for packages in [ "ceilometer-api", "ceilometer-collector", "ceilometer-agent-central", "ceilometer-agent-notification", "ceilometer-alarm-evaluator", "ceilometer-alarm-notifier", "python-ceilometerclient"] do
  package packages do
    action :install
  end
end

template '/etc/ceilometer/ceilometer.conf' do
  source 'ceilometer.conf.erb'
  owner 'ceilometer'
  group 'ceilometer'
  mode '0644'
end

for services in [ "ceilometer-api", "ceilometer-collector", "ceilometer-agent-central", "ceilometer-agent-notification", "ceilometer-alarm-evaluator", "ceilometer-alarm-notifier", "python-ceilometerclient"] do
  service services do
    supports :status => true, :restart => true, :reload => true
    action [:enable]
  end
end
