# Class: ec2base::packages
# ===========================
class ec2base::packages inherits ec2base {

  # These will go everywhere
  $default_pkgs = [ 'htop', 'tcpdump', 'telnet', 'sysstat' ]
  $ec2base_pkgs = hiera_array('ec2base_packages', [])
  $final_pkgs = unique(concat($default_pkgs, $ec2base_pkgs))

  each($final_pkgs) |$pkg| {
    ensure_packages($pkg)
  }

}
