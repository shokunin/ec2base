# Class: ec2base::bootstrap
# ===========================
class ec2base::bootstrap inherits ec2base {

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


}
