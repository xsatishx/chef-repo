#
# Cookbook Name:: keystone
# Recipe:: default
#
# Copyright 2016, HealthSe Asia Pvt. Ltd.
# Maintainer Satish Balakrishnan <satish@healthseq.com>
#
# All rights reserved - Do Not Redistribute
#

# MANUAL STEPS :  dbsync and endpoint creation

# Prevent keystone service from starting automatically after installation
bash 'prevent-keystone-service-startup' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
    echo "manual" > /etc/init/keystone.override
  EOH
end

# Install Packages

package 'keystone' do
  action :install
  action :upgrade
end

package 'apache2' do
  action :install
  action :upgrade
end

package 'libapache2-mod-wsgi' do
  action :install
  action :upgrade
end

package 'memcached' do
  action :install
  action :upgrade
end

package 'python-memcache' do
  action :install
  action :upgrade
end

template "/etc/keystone/keystone.conf" do 
  mode "0644"
  owner "root"
  group "root"
  source "keystone.conf.erb"
end

# This Step may not  work always -better do it manually 
#Populate the database
# bash 'Populate-keystone-database' do
#   user 'root'
#   cwd '/tmp'
#   code <<-EOH
#     su -s /bin/sh -c "keystone-manage db_sync" keystone
#   EOH
# end

#  Alternative to above command

# cmdString = "su -s /bin/sh -c 'keystone-manage db_sync' keystone"
#   Chef::Log.info("CMD> "+cmdString)
#   IO.popen(cmdString).each do |line|
#   Chef::Log.info("OUT> "+line.chomp)
# end


bash 'add-server-name-to-apacheconf' do
  user 'root'
  cwd '/etc/apache2'
  code <<-EOH
   grep -q -F "ServerName  #{node['hostname']}" /etc/apache2/apache2.conf || echo "ServerName  #{node['hostname']}" >> /etc/apache2/apache2.conf
  EOH
end

cookbook_file '/etc/apache2/sites-available/wsgi-keystone.conf' do
  source 'wsgi-keystone.conf'
  owner 'root'
  group 'root'
  mode '0644'
end

bash 'enable virtual hosts' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
    ln -sf /etc/apache2/sites-available/wsgi-keystone.conf /etc/apache2/sites-enabled
  EOH
end

service 'apache2' do
  supports :status => true, :restart => true, :reload => true
  action [:enable]
end

bash 'delete sqlite database' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
    rm -f /var/lib/keystone/keystone.db
  EOH
end

template '/root/scripts/initial_creds' do
  source 'initial_creds.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/root/scripts/creds' do
  source 'creds.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/root/scripts/2keystone_endpoints.sh' do
  source '2keystone_endpoints.sh.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

template '/root/scripts/1keystone_dbsync.sh' do
  source '1keystone_dbsync.sh.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

service 'keystone' do
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable]
end

service 'mysql' do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end

# bash 'endpoint creation...' do
#   user 'root'
#   cwd '/root/scripts/'
#   not_if { node.attribute?('keystone_init') }
#   code <<-EOH
#     source initial_creds
#     sh keystone_endpoints.sh
#   EOH
# end

# ruby_block "keystone_init" do
#   block do
#     node.set['keystone_init'] = true
#     node.save
#   end
#   action :nothing
# end

