#
# Cookbook Name:: mysql-server
# Recipe:: default
#
# Copyright 2016, HealthSeq Asia Pvt. Ltd.
# Maintainer <satish@healthseq.com>
# All rights reserved - Do Not Redistribute
#

# TO DO: Modify files/mysql-seed with the password - cant template (bug)

bash "update-apt-repository" do
  user "root"
  code <<-EOH
  apt-get update
  EOH
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
  notifies :create, "template[/etc/mysql/conf.d/mysqld_openstack.cnf]", :immediately
end

template '/etc/mysql/conf.d/mysqld_openstack.cnf' do
  source 'mysqld_openstack.cnf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

service "mysql" do
  provider Chef::Provider::Service::Init::Debian
  supports :status => true, :restart => true, :stop => true, :start => true
  action [:enable]
end

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
  action [:enable]
end
