# Class: ec2base::sysctl
# ===========================
class ec2base::sysctl inherits ec2base {

  $sysctl_entries = hiera_hash('sysctl', {})

  file { '/etc/sysctl.conf':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('ec2base/sysctl.conf.erb'),
    notify  => Exec['update_sysctl'],
  }

  exec { 'update_sysctl':
    command     => '/sbin/sysctl -e -p /etc/sysctl.conf',
    refreshonly => true,
  }

}
