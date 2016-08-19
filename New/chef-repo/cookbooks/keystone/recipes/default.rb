#
# Cookbook Name:: keystone
# Recipe:: default
#
# Copyright 2016, HealthSe Asia Pvt. Ltd.
# Maintainer Satish Balakrishnan <satish@healthseq.com>
#
# All rights reserved - Do Not Redistribute
#

# TO DO - Change the Attributes
# TO DO - Check if the single quotes in templates gets resolved , then uncomment the execution part below.
# ###########TO DO - Edit the /etc/apache2/apache2.conf file and configure the ServerName option to reference the controller node:###########################
# Check attribute node ipaddress resolvation?

ServerName controller

template '/root/scripts/keystone.sh' do
  source 'keystone.sh.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

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
end

package 'apache2' do
  action :install
end

package 'libapache2-mod-wgsi' do
  action :install
end

package 'memcached' do
  action :install
end

package 'python-memcache' do
  action :install
end

template "/etc/keystone/keystone.conf" do 
  mode "440"
  owner "keystone"
  group "keystone"
  source "keystone.conf.erb"
  variables(
  )
  notifies :restart, "service[keystone]"
end

#Populate the database
bash 'Populate-keystone-database' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
    su -s /bin/sh -c "keystone-manage db_sync" keystone
  EOH
end

### PLEASE DO THE STEP IN TODO 3 #######################

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
    ln -s /etc/apache2/sites-available/wsgi-keystone.conf /etc/apache2/sites-enabled
  EOH
end

service 'apache2' do
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable]
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

template '/root/scripts/keystone_endpoints.sh' do
  source 'keystone_endpoints.sh.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

bash 'endpoint creation...' do
  user 'root'
  cwd '/root/scripts/'
  code <<-EOH
    source initial_creds
    sh keystone_endpoints.sh
  EOH
end

template '/root/scripts/keystone_users_projects.sh' do
  source 'keystone_users_projects.sh.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

bash 'Create project-user-roles' do
  user 'root'
  cwd '/root/scripts/'
  code <<-EOH
    sh keystone_users_projects.sh
  EOH
end