#
# Cookbook Name:: mysql-server
# Recipe:: default
#
# Copyright 2016, HealthSeq Asia Pvt. Ltd.
# Maintainer Satish Balakrishnan <satish@healthseq.com>
# All rights reserved - Do Not Redistribute
#

# TO DO: Modify files/mysql-seed with the password - cant template (bug)

package 'python-pymysql' do
  action :install
  action :upgrade
end

package 'python-mysqldb' do
  action :install
  action :upgrade
end

cookbook_file 'mysql-seed' do
  source 'mysql-seed'
  owner 'root'
  group 'root'
  mode '0644'
end

package "mysql-server-5.5" do
  action :install
  response_file 'mysql-seed'
#  notifies :create, "template[/etc/mysql/conf.d/mysqld_openstack.cnf]", :immediately
end

template '/etc/mysql/conf.d/mysqld_openstack.cnf' do
  source 'mysqld_openstack.cnf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

 # service 'mysql' do
 #   supports :status => true, :restart => true, :reload => true
 #   action [:restart]
 # end

template '/tmp/secure.sh' do
  source 'secure.sh.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

bash 'secure-mysql-installation' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
    sh secure.sh 
  EOH
end

service 'mysql' do
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable]
end