echo "Creating nova-compute user..."
openstack user create --domain default --password <%= node['nova-compute']['endpoint_pass'] %> <%= node['nova-compute']['endpoint_user'] %>

echo "Adding admin role to nova-compute user ... "
openstack role add --project service --user  <%= node['nova-compute']['endpoint_user'] %> admin

echo "Adding the openstack compute service ... "
openstack service create --name <%= node['nova-compute']['endpoint_user'] %>  --description "OpenStack Compute" compute

echo "Creating compute endpoints ..."
openstack endpoint create --region RegionOne compute public http://<%= node['nova-compute']['host_ip'] %>:8774/v2/%\(tenant_id\)s
openstack endpoint create --region RegionOne compute internal http://<%= node['nova-compute']['host_ip'] %>:8774/v2/%\(tenant_id\)s
openstack endpoint create --region RegionOne compute admin http://<%= node['nova-compute']['host_ip'] %>:8774/v2/%\(tenant_id\)s