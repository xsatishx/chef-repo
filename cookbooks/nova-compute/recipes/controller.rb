#
# Cookbook Name:: nova-compute
# Recipe:: controller.rb
#
# Copyright 2016, HealthSeq Asia Pvt. Ltd.
# Maintainer Satish Balakrishnan <satish@healthseq.com>
#
# All rights reserved - Do Not Redistribute
#
template '/root/scripts/1nova_endpoints.sh' do
  source '1nova_endpoints.sh.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

template '/root/scripts/2nova_dbsync.sh' do
  source '2nova_dbsync.sh.erb'
  owner 'root'
  group 'root'
  mode '0755'
end


for packages in [ "nova-api", "nova-cert", "nova-conductor", "nova-consoleauth", "nova-novncproxy", "nova-scheduler", "python-novaclient"] do
  package packages do
    action :install
  end
end

template '/etc/nova/nova.conf' do
  source 'nova.conf.erb'
  owner 'nova'
  group 'nova'
  mode '0644'
end

#Populate the database
# bash 'Populate-nova-database' do
#   user 'root'
#   cwd '/tmp'
#   code <<-EOH
#     su -s /bin/sh -c "nova-manage db_sync" nova
#   EOH
# end

for packages in [ "nova-api", "nova-cert", "nova-conductor", "nova-consoleauth", "nova-novncproxy", "nova-scheduler"] do
  service packages do
    supports :status => true, :restart => true, :reload => true
    action [:enable]
  end
end

bash 'remove nova sqlite database' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
   
       rm -f /var/lib/nova/nova.sqlite
 
  EOH
end

