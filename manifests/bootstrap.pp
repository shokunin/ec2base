# Class: ec2base::bootstrap
# ===========================
class ec2base::bootstrap inherits ec2base {

  include stdlib

  file { '/usr/local/bin/parse_user_data':
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0755',
    source => 'puppet:///modules/ec2base/parse_user_data.rb',
  }

  file { '/usr/local/bin/ec2_bootstrap':
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0755',
    source => 'puppet:///modules/ec2base/bootstrap.sh',
  }

  file { '/lib/systemd/system/bootstrap.service':
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///modules/ec2base/bootstrap.service',
    notify =>  Exec['systemctl_reload_bootstrap'],
  }

  exec { 'systemctl_reload_bootstrap':
    command     =>  '/bin/systemctl daemon-reload',
    refreshonly => true,
  }

  file { '/etc/systemd/system/multi-user.target.wants/bootstrap.service':
    ensure  => link,
    target  => '/lib/systemd/system/bootstrap.service',
    require => File['/lib/systemd/system/bootstrap.service']
  }

  file_line { 'blank_hosts':
    ensure            => absent,
    path              => '/etc/hosts',
    match             => "^ ${::hostname} ${::fqdn}",
    match_for_absence => true,
  }

  file_line { 'bad_hosts':
    ensure            => absent,
    path              => '/etc/hosts',
    match             => '^ -[a-f0-9]{14,17} -[a-f0-9]{14,17}',
    match_for_absence => true,
  }

  file_line { 'hostfile_entry':
    ensure => present,
    path   => '/etc/hosts',
    line   => "${::ipaddress} ${::hostname} ${::fqdn}",
  }


}
