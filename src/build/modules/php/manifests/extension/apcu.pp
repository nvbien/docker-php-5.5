class php::extension::apcu {
  require php

  file { '/tmp/apcu-4.0.7.tgz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/apcu-4.0.7.tgz'
  }

  exec { 'tar xzf apcu-4.0.7.tgz':
    cwd => '/tmp',
    path => ['/bin'],
    require => File['/tmp/apcu-4.0.7.tgz']
  }

  exec { 'phpize-5.5.18 apcu':
    command => '/phpfarm/inst/bin/phpize-5.5.18',
    cwd => '/tmp/apcu-4.0.7',
    require => Exec['tar xzf apcu-4.0.7.tgz']
  }

  exec { '/bin/su - root -c "cd /tmp/apcu-4.0.7 && ./configure --with-php-config=/phpfarm/inst/bin/php-config-5.5.18"':
    timeout => 0,
    require => Exec['phpize-5.5.18 apcu']
  }

  exec { '/bin/su - root -c "cd /tmp/apcu-4.0.7 && make"':
    timeout => 0,
    require => Exec['/bin/su - root -c "cd /tmp/apcu-4.0.7 && ./configure --with-php-config=/phpfarm/inst/bin/php-config-5.5.18"']
  }

  exec { '/bin/su - root -c "cd /tmp/apcu-4.0.7 && make install"':
    timeout => 0,
    require => Exec['/bin/su - root -c "cd /tmp/apcu-4.0.7 && make"']
  }
}
