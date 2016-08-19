#
# Cookbook Name:: hosts
# Recipe:: default
#
# Copyright 2016 , HealthSeq Asia Pvt. Ltd.
#
# All rights reserved - Do Not Redistribute
#
# TO DO : Change the template for hosts.erb
template "/etc/hosts" do
  mode "444"
  owner "root"
  group "root"
  source "hosts.erb"
  variables(
  )
  action :create
end

