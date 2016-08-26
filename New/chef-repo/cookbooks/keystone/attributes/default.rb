
#
# Cookbook Name:: keystone
#
# Copyright 2016, HealthSe Asia Pvt. Ltd.
# Maintainer Satish Balakrishnan <satish@healthseq.com>
#
# All rights reserved - Do Not Redistribute
#

default['keystone']['host_ip'] = '10.0.2.13'
default['keystone']['management_ip'] = '10.1.0.13'
default['keystone']['db_name'] = 'keystone'
default['keystone']['db_user'] = 'keystone'
default['keystone']['db_pass'] = 'healthseq'
default['keystone']['mysql_root_user'] = 'root'
default['keystone']['mysql_root_pass'] = 'healthseq'
default['keystone']['os_token'] = 'healthseq'


default['keystone']['endpoint_user'] = 'admin'
default['keystone']['endpoint_pass'] = 'healthseq'
default['keystone']['endpoint_project'] = 'admin'
default['keystone']['endpoint_tenant'] = 'admin'