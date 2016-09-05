#
# Cookbook Name:: cinder
# Recipe:: default
#
# Copyright 2016, HealthSeq Asia Pvt. Ltd.
# Maintainer Satish Balakrishnan <satish@healthseq.com>
#
# All rights reserved - Do Not Redistribute
#


package 'cinder-api' do
  action :install
end

package 'cinder-scheduler' do
  action :install
end

package 'python-cinderclient' do
  action :install
end

package 'cinder-volume' do
  action :install
end

package 'python-mysqldb' do
   action :install
 end

package 'tgt' do
  action :install
end

# need to check if this should be owned by cinder user or root
template '/etc/cinder/cinder.conf' do
  source 'cinder.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/root/scripts/cinder_endpoints.sh' do
  source 'cinder_endpoints.sh.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

# Run Manually

# bash 'set-cinder-endpoints' do
#   user 'root'
#   cwd '/root/scripts'
#   code <<-EOH
#     source creds
#     sh cinder_endpoints.sh
#   EOH
# end

#Populate the database
# bash 'Populate-cinder-database' do
#   user 'root'
#   cwd '/tmp'
#   code <<-EOH
#     su -s /bin/sh -c "cinder-manage db sync" cinder
#   EOH
# end


service 'cinder-scheduler' do
  supports :status => true, :restart => true, :reload => true
  action [:enable]
end

service 'cinder-api' do
  supports :status => true, :restart => true, :reload => true
  action [:enable]
end

service 'tgt' do
  supports :status => true, :restart => true, :reload => true
  action [:enable]
end

service 'cinder-volume' do
  supports :status => true, :restart => true, :reload => true
  action [:enable]
end


bash 'remove-cinder-sqlite-db' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
    rm -f /var/lib/cinder/cinder.sqlite
  EOH
end


# pending cinder storage node