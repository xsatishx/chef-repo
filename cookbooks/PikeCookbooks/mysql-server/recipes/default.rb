#
# Cookbook Name:: mysql-server
# Recipe:: default
#
# Copyright 2018, HealthSeq Asia Pvt. Ltd.
# Maintainer Satish Balakrishnan <satish@healthseq.com>
# All rights reserved - Do Not Redistribute
#

# Edit the conf file and add the ip address  
# Edit the secure.sh script to add the password


package 'python-pymysql' do
  action :install
  action :upgrade
end

package 'mariadb-server' do
  action :install
  action :upgrade
end

template '/etc/mysql/mariadb.conf.d/99-openstack.cnf' do
  source 'mysqld_openstack.cnf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

service 'mysql' do
    supports :status => true, :restart => true, :reload => true
    action [:restart]
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
     sh /tmo/secure.sh
   EOH
 end

service 'mysql' do
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable]
end