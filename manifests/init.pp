# Class: ec2base
# ===========================
class ec2base {

  include ec2base::packages
  include ec2base::bootstrap
  include ec2base::bashrc
  include ec2base::sysctl

}
