#
# Cookbook Name:: nova-compute
# Recipe:: controller.rb
#
# Copyright 2016, HealthSeq Asia Pvt. Ltd.
# Maintainer Satish Balakrishnan <satish@healthseq.com>
#
# All rights reserved - Do Not Redistribute
#
template '/root/scripts/controller_endpoints.sh' do
  source 'controller_endpoints.sh.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

bash 'set-nova-controller-endpoints' do
  user 'root'
  cwd '/root/scripts'
  code <<-EOH
    source creds
    sh controller_endpoints.sh
  EOH
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
bash 'Populate-nova-database' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
    su -s /bin/sh -c "nova-manage db_sync" nova
  EOH
end

for packages in [ "nova-api", "nova-cert", "nova-conductor", "nova-consoleauth", "nova-novncproxy", "nova-scheduler", "python-novaclient"] do
  service packages do
    supports :status => true, :restart => true, :reload => true
    action [:enable]
  end
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

