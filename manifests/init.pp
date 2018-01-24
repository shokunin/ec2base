# Class: ec2base
# ===========================
class ec2base {

  notify { "class ec2base included": }

  include ec2base::packages
  include ec2base::bootstrap
  include ec2base::bashrc

}
