# Class: ec2base::bashrc
# ===========================
class ec2base::bashrc inherits ec2base {

  if $::virtual == 'virtualbox' {
    $base_user = 'vagrant'
  } else {
    $base_user = 'ubuntu'
  }

  file { "/home/${base_user}/.bashrc":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///modules/ec2base/bash.bashrc',
  }

  file { "/home/${base_user}/.bash_profile":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///modules/ec2base/bash.profile',
  }

}
