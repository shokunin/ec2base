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
  

}
