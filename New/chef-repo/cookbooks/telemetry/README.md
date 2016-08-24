# telemetry Cookbook

Telemetry 

1) Controller 


# Install nosql database (mongodb)
- apt-get install mongodb-server mongodb-clients python-pymongo -y
- add the following to /etc/mongodb.conf
bind_ip = 10.0.2.13
smallfiles = true

-service mongodb stop
-rm /var/lib/mongodb/journal/prealloc.*
-service mongodb start

# install cielometer

mongo --host devcontroller --eval '
  db = db.getSiblingDB("ceilometer");
  db.addUser({user: "ceilometer",
  pwd: "healthseq",
  roles: [ "readWrite", "dbAdmin" ]})'


# endpoint
source creds
openstack user create --domain default --password healthseq ceilometer
openstack role add --project service --user ceilometer admin

openstack service create --name ceilometer --description "Telemetry" metering

openstack endpoint create --region RegionOne metering public http://10.1.0.13:8777
openstack endpoint create --region RegionOne metering internal http://10.0.2.13:8777
openstack endpoint create --region RegionOne metering admin http://10.0.2.13:8777

apt-get install ceilometer-api ceilometer-collector \
  ceilometer-agent-central ceilometer-agent-notification \
  ceilometer-alarm-evaluator ceilometer-alarm-notifier \
  python-ceilometerclient

vi /etc/ceilometer/ceilometer.conf
 -- take backup of this file to template it.

service ceilometer-agent-central restart
service ceilometer-agent-notification restart
service ceilometer-api restart
service ceilometer-collector restart
service ceilometer-alarm-evaluator restart
service ceilometer-alarm-notifier restart


##### configure glance to use ceilometer ####
again template glance-api.conf and glance-registry.conf
service glance-registry restart
service glance-api restart


#### Enable compute meters ###

apt-get install ceilometer-agent-compute  --> on each compute nodee

modify /etc/ceilometer/ceilometer.conf and /etc/nova/nova.conf

service ceilometer-agent-compute restart

service nova-compute restart


# cinder ##
add this is /etc/cinder/cinder.conf 
notification_driver = messagingv2

service cinder-api restart
service cinder-scheduler restart
service cinder-volume restart

