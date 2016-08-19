#
# Cookbook Name:: ntp
# Recipe:: default
#
# Copyright 2016, HealthSeq Asia Pvt. Ltd.
# Maintainer <satish@healthseq.com>
#
# All rights reserved - Do Not Redistribute
#
# TO DO : Change the ntp servers under attributes.

package 'ntp' do
  action :install
end

template '/etc/ntp.conf' do
  source 'ntp.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

service 'ntp' do
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable]
end
