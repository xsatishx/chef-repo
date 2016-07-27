name             'dnsmasq'
maintainer       'Laboratory for Advanced Computing'
maintainer_email 'rpowell1@uchicago.edu'
license          'All rights reserved'
description      'Installs/Configures neutron'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'


attribute 'cloud',
          :display_name => 'cloud',
          :description  => 'The clouds variables',
          :type         => 'array'

attribute 'dnsmasq',
          :display_name => 'dnsmasq',
          :description  => 'The dnsmasq vars',
          :type         => 'array'
