# Class: ec2base::resolv
# ===========================
class ec2base::resolv inherits ec2base {

  #adds some options to resolv.conf to behave better in a cloud environment

  file { '/etc/resolvconf/resolv.conf.d/head':
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///modules/ec2base/resolv_head',
  }

  file { '/etc/gai.conf':
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///modules/ec2base/gai.conf',
  }
  
 file { '/lib/systemd/system/disable-ipv6.service':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    source => 'puppet:///modules/ec2base/disable-ipv6.service',
    notify  => Exec['systemctl_reload_disable-ipv6', 'hard_disable-ipv6'],
  }

  exec { 'systemctl_reload_disable-ipv6':
    command     =>  '/bin/systemctl daemon-reload',
    refreshonly => true,
  }

  exec { 'hard_disable-ipv6':
    command     =>  '/bin/echo 1 > /proc/sys/net/ipv6/conf/eth0/disable_ipv6'
    refreshonly => true,
  }

  file { '/etc/systemd/system/multi-user.target.wants/disable-ipv6.service':
    ensure  => link,
    target  => '/lib/systemd/system/disable-ipv6.service',
    require => File['/lib/systemd/system/disable-ipv6.service']
  }

	service { 'disable-ipv6':
		ensure  => running,
		enable  => true,
		require => [File['/etc/systemd/system/multi-user.target.wants/disable-ipv6.service'],
								Exec['systemctl_reload_disable-ipv6']]
	}


}
