#
# Cookbook Name:: glance
# Recipe:: default
#
# Copyright 2016, HealthSeq Asia Pvt. Ltd.
# Maintainer Satish Balakrishnan <satish@healthseq.com>
#
# All rights reserved - Do Not Redistribute
#

template '/root/scripts/glance_endpoints.sh' do
  source 'glance_endpoints.sh.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

# bash 'set-glance-endpoints' do
#   user 'root'
#   cwd '/root/scripts'
#   code <<-EOH
#     source creds
#     sh glance_endpoints.sh
#   EOH
# end

package 'glance' do
  action :install
end

package 'python-glanceclient' do
  action :install
end

template '/etc/glance/glance-api.conf' do
  source 'glance-api.conf.erb'
  owner 'glance'
  group 'glance'
  mode '0644'
end

#Populate the database
bash 'Populate-glance-database' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
    su -s /bin/sh -c "glance-manage db_sync" glance
  EOH
end

service 'glance-registry' do
  supports :status => true, :restart => true, :reload => true
  action [:enable]
end

service 'glance-api' do
  supports :status => true, :restart => true, :reload => true
  action [:enable]
end

bash 'remove-sqlite-db' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
   
       rm -f /var/lib/glance/glance.sqlite
 
  EOH
end
