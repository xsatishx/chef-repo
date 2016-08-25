#
# Cookbook Name:: nova-compute
# Recipe:: default
#
# Copyright 2016, HealthSe Asia Pvt. Ltd.
# Maintainer Satish Balakrishnan <satish@healthseq.com>
#
# All rights reserved - Do Not Redistribute
#
# Use controller.rb for setting up a controller node and compute.rb for compute nodes.
# Also takes care of nova-network (legacy)
# May not need compute2.rb , just use compute1.rb and change the ipaddress

# source creds
# nova network-create demo-net --bridge br100 --multi-host T --fixed-range-v4 NETWORK_CIDR
# nova network-create demo-net --bridge br100 --multi-host T --fixed-range-v4 203.0.113.24/29