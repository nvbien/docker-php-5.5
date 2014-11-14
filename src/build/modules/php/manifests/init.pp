class php {
  require php::packages
  require php::phpfarm
  require php::supervisor

  file { '/phpfarm/src/php-5.5.18.tar.gz':
    ensure => present,
    source => 'puppet:///modules/php/phpfarm/src/php-5.5.18.tar.gz'
  }

  exec { 'zcat php-5.5.18.tar.gz | tar xzf -':
    cwd => '/phpfarm/src',
    path => ['/bin'],
    require => File['/phpfarm/src/php-5.5.18.tar.gz']
  }

  file { '/phpfarm/src/custom/options-5.5.18.sh':
    ensure => present,
    source => 'puppet:///modules/php/phpfarm/src/custom/options-5.5.18.sh',
    mode => 755,
    require => Exec['zcat php-5.5.18.tar.gz | tar xzf -']
  }

  exec { '/phpfarm/src/main.sh 5.5.18':
    timeout => 0,
    require => File['/phpfarm/src/custom/options-5.5.18.sh']
  }

  exec { 'rm -rf /phpfarm/src/php-5.5.18':
    path => ['/bin'],
    require => Exec['/phpfarm/src/main.sh 5.5.18']
  }

  file { '/phpfarm/inst/php-5.5.18/etc/php-fpm.conf':
    ensure => present,
    source => 'puppet:///modules/php/phpfarm/inst/php-5.5.18/etc/php-fpm.conf',
    mode => 644,
    require => Exec['/phpfarm/src/main.sh 5.5.18']
  }

  file { '/phpfarm/inst/php-5.5.18/lib/php.ini':
    ensure => present,
    source => 'puppet:///modules/php/phpfarm/inst/php-5.5.18/lib/php.ini',
    mode => 644,
    require => Exec['/phpfarm/src/main.sh 5.5.18']
  }

  exec { '/bin/bash -l -c "switch-phpfarm 5.5.18"':
    require => Exec['/phpfarm/src/main.sh 5.5.18']
  }
}