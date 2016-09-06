#
# Cookbook Name:: nova-compute
# Recipe:: compute2.rb
#
# Copyright 2016, HealthSeq Asia Pvt. Ltd.
# Maintainer Satish Balakrishnan <satish@healthseq.com>
#
# All rights reserved - Do Not Redistribute
#

package 'nova-compute' do
  action :install
end

package 'sysfsutils' do
  action :install
end

package 'nova-network' do
  action :install
end

package 'nova-api-metadata' do
  action :install
end


template '/etc/nova/nova.conf' do
  source 'novacompute2.conf.erb'
  owner 'nova'
  group 'nova'
  mode '0644'
end

service 'nova-compute' do
  supports :status => true, :restart => true, :reload => true
  action [:enable]
end


bash 'remove nova sqlite database' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
    if [ -f /var/lib/nova/nova.sqlite ] then
       rm -f /var/lib/nova/nova.sqlite
    fi
  EOH
end

service 'nova-network' do
  supports :status => true, :restart => true, :reload => true
  action [:enable]
end

service 'nova-api-metadata' do
  supports :status => true, :restart => true, :reload => true
  action [:enable]
end

service 'nova-compute' do
  supports :status => true, :restart => true, :reload => true
  action [:enable]
end

