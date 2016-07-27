name             'nova-glance-pdc'
maintainer       'Laboratory for Advanced Computing'
maintainer_email 'rpowell1@uchicago.edu'
license          'All rights reserved'
description      'Installs/Configures keystone'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.3.3'


attribute 'cloud',
          :display_name => 'cloud',
          :description  => 'The clouds variables',
          :type         => 'array'

attribute 'keystone',
          :display_name => 'keystone',
          :description  => 'The keystoen variables',
          :type         => 'array'

attribute 'mysql',
          :display_name => 'mysql',
          :description  => 'mysql settings',
          :type         => 'array'

attribute 'rabbitmq',
          :display_name => 'rabbitmq',
          :description  => 'The rabbitmqvariables',
          :type         => 'array'

attribute 'glance',
          :display_name => 'glance',
          :description  => 'The glance variables',
          :type         => 'array'
