name             'nova-cloudcontroller-pdc'
maintainer       'HealthSeq Asia Pvt. Ltd.'
maintainer_email 'arun@healthseq.com'
license          'All rights reserved'
description      'Installs/Configures keystone'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.3.0'
depends          'apt'

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

attribute 'nova',
          :display_name => 'nova',
          :description  => 'The nova variables',
          :type         => 'array'
