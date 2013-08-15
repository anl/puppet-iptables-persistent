# Include this module
class { 'iptables_persistent':
  limit_out => [ {
    'port'  => 25,
    'rate'  => '1/minute',
    'burst' => 2
  } ],
  permit_in => [ 22, 80, 443 ],
}
