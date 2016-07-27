#
# Cookbook Name:: nova-cinder-pdc
# Recipe:: default
#
# Copyright 2016, HealthSeq Asia Pvt. Ltd.

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
  action [:enable, :start, :restart]
end

service "tgt" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :stop => true, :start => true
  action [:enable, :start, :restart]
end

template "/etc/cinder/cinder.conf" do 
  mode "700"
  owner "cinder"
  group "cinder"
  source "#{node.chef_environment}/cinder.conf.erb"
  variables(
        :chef_environment => "#{node.chef_environment}"
  )
  notifies :restart, "service[cinder-volume]"
  notifies :restart, "service[tgt]"
end
