#
# Cookbook Name:: chef-support
# Recipes:: default
#
# Copyright 2016, HealthSeq Asia Pvt. Ltd.
# Maintainer Satish Balakrishnan <satish@healthseq.com>
#
# All rights reserved - Do Not Redistribute
#

template "/etc/sysctl.d/99-ceph.conf" do
  mode "440"
  owner "root"
  group "root"
  source "sysctl99-ceph.conf.erb"
  action :create
end

template "/etc/security/limits.d/99-ceph.conf" do
  mode "440"
  owner "root"
  group "root"
  source "limits.d99-ceph.conf.erb"
  action :create
end

template "/etc/sysctl.d/99-fasterdata.es.net.conf" do
  mode "444"
  owner "root"
  group "root"
  source "99-fasterdata.es.net.conf.erb"
  action :create
end

directory '/var/log/radosgw' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end
