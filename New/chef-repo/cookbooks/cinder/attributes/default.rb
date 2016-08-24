#
# Cookbook Name:: cinder
# Attributes:: default
#
# Copyright 2016, HealthSeq Asia Pvt. Ltd.
# Maintainer Satish Balakrishnan <satish@healthseq.com>
#
# All rights reserved - Do Not Redistribute
#


default['cinder']['host_ip'] = '10.0.2.13'
default['cinder']['management_ip'] = '10.1.0.13'

default['cinder']['endpoint_user'] = 'cinder'
default['cinder']['endpoint_pass'] = 'healthseq'
default['cinder']['endpoint_project'] = 'admin'
default['cinder']['endpoint_tenant'] = 'admin'

default['cinder']['db_name'] = 'cinder'
default['cinder']['db_user'] = 'cinder'
default['cinder']['db_pass'] = 'healthseq'