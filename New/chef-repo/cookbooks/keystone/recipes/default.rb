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
# ServerName controller needs to be added to apache 2


# Step to create keystone db is in openstack-prep cookbook

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

package 'libapache2-mod-wgsi' do
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

#Populate the database
bash 'Populate-keystone-database' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
    su -s /bin/sh -c "keystone-manage db_sync" keystone
  EOH
end

service 'keystone' do
  supports :status => true, :restart => true, :reload => true
  action [:enable]
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
  action [:enable]
end

bash 'delete sqlite database' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
     if [ -f /var/lib/keystone/keystone.db ] then
       rm -f /var/lib/keystone/keystone.db
     fi
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

