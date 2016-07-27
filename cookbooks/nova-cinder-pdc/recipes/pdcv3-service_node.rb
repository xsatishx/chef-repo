#
# Cookbook Name:: nova-cinder-pdc
# Recipe:: service_node
#
# Copyright 2016, HealthSeq Asia Pvt. Ltd.
#
# All rights reserved - Do Not Redistribute
#

package "cinder-volume" do
  action :install
  action :upgrade
end

package "tgt" do
  action :install
  action :upgrade
end

package "python-mysqldb" do
  action :install
  action :upgrade
end

service "cinder-volume" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :stop => true, :start => true
  action [:enable]
end

service "tgt" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :stop => true, :start => true
  action [:enable]
end

template "/etc/cinder/cinder.conf" do 
  mode "700"
  owner "cinder"
  group "cinder"
  source "#{node.cloud.chef_version}/cinder.conf.erb"
  notifies :restart, "service[cinder-volume]"
  notifies :restart, "service[tgt]"
end
