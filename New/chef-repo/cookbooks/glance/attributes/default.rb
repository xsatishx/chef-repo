#
# Cookbook Name:: glance
# Attributes:: default
#
# Copyright 2016, HealthSeq Asia Pvt. Ltd.
# Maintainer Satish Balakrishnan <satish@healthseq.com>
#
# All rights reserved - Do Not Redistribute
#

default['glance']['host_ip'] = '10.0.2.13'
default['glance']['management_ip'] = '10.1.0.13'

default['glance']['endpoint_user'] = 'glance'
default['glance']['endpoint_pass'] = 'healthseq'
default['glance']['endpoint_project'] = 'admin'
default['glance']['endpoint_tenant'] = 'admin'

default['glance']['db_name'] = 'glance'
default['glance']['db_user'] = 'glance'
default['glance']['db_pass'] = 'healthseq'