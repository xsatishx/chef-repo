
#
# Cookbook Name:: openstack_prep
#
# Copyright 2016, HealthSe Asia Pvt. Ltd.
# Maintainer Satish Balakrishnan <satish@healthseq.com>
#
# All rights reserved - Do Not Redistribute
#

# mysql root username and password - depends on the mysql-seed file in mysql cookbook
default['openstack_prep']['mysql_root_user'] = 'root'
default['openstack_prep']['mysql_root_pass'] = 'healthseq'

default['openstack_prep']['keystone_db_name'] = 'keystone'
default['openstack_prep']['keystone_db_user'] = 'keystone'
default['openstack_prep']['keystone_db_pass'] = 'healthseq'
#default['openstack_prep']['keystone_db_file'] = 'keystone.sh'


default['openstack_prep']['glance_db_name'] = 'glance'
default['openstack_prep']['glance_db_user'] = 'glance'
default['openstack_prep']['glance_db_pass'] = 'healthseq'
#default['openstack_prep']['glance_db_file'] = 'glance.sh'

default['openstack_prep']['novacompute_db_name'] = 'nova'
default['openstack_prep']['novacompute_db_user'] = 'nova'
default['openstack_prep']['novacompute_db_pass'] = 'healthseq'
#default['openstack_prep']['novacompute_db_file'] = 'novacompue.sh'

default['openstack_prep']['cinder_db_name'] = 'cinder'
default['openstack_prep']['cinder_db_user'] = 'cinder'
default['openstack_prep']['cinder_db_pass'] = 'healthseq'
#default['openstack_prep']['cinder_db_file'] = 'cinder.sh'