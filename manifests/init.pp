# == Class: iptables_persistent
#
# Full description of class iptables_persistent here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { iptables_persistent:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2013 Your name here, unless otherwise noted.
#
class iptables_persistent (
  $inbound = [ 22 ]
) {

  package { 'iptables-persistent': ensure => present }

  file { '/etc/iptables/rules.v4':
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => template('iptables_persistent/rules.v4.erb'),
    notify  => Service['iptables-persistent'],
    require => Package['iptables-persistent'],
  }

  file { '/etc/iptables/rules.v6':
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => template('iptables_persistent/rules.v6.erb'),
    notify  => Service['iptables-persistent'],
    require => Package['iptables-persistent'],
  }

  service { 'iptables-persistent':
    enable    => true,
    hasstatus => false,
    status    => '/sbin/iptables -L',
  }
}
