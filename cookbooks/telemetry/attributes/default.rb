
#
# Cookbook Name:: telemetry
#
# Copyright 2016, HealthSe Asia Pvt. Ltd.
# Maintainer Satish Balakrishnan <satish@healthseq.com>
#
# All rights reserved - Do Not Redistribute
#

default['telemetry']['host_ip'] = '10.0.2.13'
default['telemetry']['management_ip'] = '10.1.0.13'
default['telemetry']['db_name'] = 'ceilometer'
default['telemetry']['db_user'] = 'ceilometer'
default['telemetry']['db_pass'] = 'healthseq'

default['telemetry']['endpoint_user'] = 'ceilometer'
default['telemetry']['endpoint_pass'] = 'healthseq'