#
# Cookbook Name:: mysql-server
# Recipe:: default
#
# Copyright 2016, HealthSeq Asia Pvt. Ltd.
# Maintainer <satish@healthseq.com>
# All rights reserved - Do Not Redistribute
#

# TO DO: Modify files/mysql-seed with the password
# TO DO: Modify templates/mysqld_openstack.cnf.erb with the bind ip

bash "update-apt-repository" do
  user "root"
  code <<-EOH
  apt-get update
  EOH
end

cookbook_file '/tmp/mysql-seed' do
  source 'mysql-seed'
  owner 'root'
  group 'root'
  mode '0644'
end

# No template or cookbook file found for response file  = just use bash as below
package "mysql-server-5.5" do
  action :install
  response_file '/tmp/mysql-seed'
  notifies :create, "template[/etc/mysql/conf.d/mysqld_openstack.cnf]", :immediately
end


# bash 'install-mysql-server' do
#   user 'root'
#   code <<-EOH
#     sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password healthseq'
#     sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password healthseq'
#     sudo apt-get -y install mysql-server-5.5
#   EOH
# end


template '/etc/mysql/conf.d/mysqld_openstack.cnf' do
  source 'mysqld_openstack.cnf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

# test run could not find this package on aws
package 'python-pymysql' do
  action :install
end


service "mysql" do
  provider Chef::Provider::Service::Init::Debian
  supports :status => true, :restart => true, :stop => true, :start => true
  action [:enable]
end

bash 'secure installation' do
  user 'root'
  code <<-EOH
  mysql_secure_installation
  EOH
end