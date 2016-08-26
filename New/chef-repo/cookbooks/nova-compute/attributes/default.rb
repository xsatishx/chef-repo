#
# Cookbook Name:: nova-compute
# Attributes:: default
#
# Copyright 2016, HealthSe Asia Pvt. Ltd.
# Maintainer Satish Balakrishnan <satish@healthseq.com>
#
# All rights reserved - Do Not Redistribute
#
default['nova-compute']['host_ip'] = '10.0.2.13'
default['nova-compute']['management_ip'] = '10.1.0.13'

default['nova-compute']['compute_host_ip'] = '10.0.2.51'
default ['nova-compute']['compute_management_ip'] = '10.1.0.51'

default['nova-compute']['endpoint_user'] = 'nova'
default['nova-compute']['endpoint_pass'] = 'healthseq'
default['nova-compute']['endpoint_project'] = 'admin'
default['nova-compute']['endpoint_tenant'] = 'admin'

default['nova-compute']['db_name'] = 'nova'
default['nova-compute']['db_user'] = 'nova'
default['nova-compute']['db_pass'] = 'healthseq'

default['nova-compute']['flat_interface'] = 'eth1'
default['nova-compute']['public_interface'] = 'eth1'
default['nova-compute']['flat_network_bridge'] = 'br-ex'