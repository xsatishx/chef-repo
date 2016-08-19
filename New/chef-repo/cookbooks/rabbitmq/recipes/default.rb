#
# Cookbook Name:: rabbitmq
# Recipe:: default
#
# Copyright 2016, HealthSeq Asia Pvt. Ltd.
# Maintainer <satish@healthseq.com>
# All rights reserved - Do Not Redistribute
#


package 'rabbitmq-server' do
  action :install
end

bash 'Add rabbitmq user' do
  user 'root'
  code <<-EOH
     rabbitmqctl add_user openstack RABBIT_PASS rabbitmqctl add_user openstack healthseq
  EOH
end

bash 'Set permissions' do
  user 'root'
  code <<-EOH
    rabbitmqctl set_permissions openstack ".*" ".*" ".*"
  EOH
end