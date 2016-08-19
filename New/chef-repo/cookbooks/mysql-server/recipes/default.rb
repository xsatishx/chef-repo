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

package "mysql-server-5.5" do
  action :install
  response_file "mysql-seed.erb"
  notifies :create, "template[/etc/mysql/conf.d/mysqld_openstack.cnf]", :immediately
end

package 'python-pymysql' do
  action :install
end

template "/etc/mysql/conf.d/mysqld_openstack.cnf" do
  mode "440"
  owner "root"
  group "root"
  source "mysql_overrides.cnf.#{node.chef_environment}.erb"
  variables(
  )
  action :create
  notifies :restart , "service[mysql]", :immediately
end

service "mysql" do
  provider Chef::Provider::Service::Init::Debian
  supports :status => true, :restart => true, :stop => true, :start => true
  action [:enable, :start]
end

bash 'secure installation' do
  user 'root'
  code <<-EOH
  mysql_secure_installation
  EOH
endmys