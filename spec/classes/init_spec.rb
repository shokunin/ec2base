require 'spec_helper'
describe 'ec2base' do
    let(:facts) do
    {
      'fqdn'                   => 'testjenkinsbox',
      'osfamily'               => 'Debian',
      'operatingsystem'        => 'Ubuntu',
      'operatingsystemrelease' => '16.04',
      'ipaddress_lo'           => '127.0.0.1',
      'ipaddress'              => '192.168.0.1',
      'architecture'           => 'amd64',
      'staging_http_get'       => 'wget',
      'path'                   => '/tmp',
      'root_home'              => '/tmp',
      'kernel'                 => 'Linux',
      'lsbdistid'              => 'Ubuntu',
      'lsbdistcodename'        => 'xenial',
      'virtual'                => 'xen',
      'os' => {
        'name'    => 'Ubuntu',
        'family'  => 'Debian',
        'release' => { 'major' => '16.04', 'full' => '16.04' },
        'lsb'     =>
                              {
                                'distcodename'    => 'xenial',
                                'distid'          => 'Ubuntu',
                                'distdescription' => 'Ubuntu 16.04.3 LTS',
                                'distrelease'     => '16.04',
                                'majdistrelease'  => '16.04'
                              }
      }
    }
  end
  context 'with default values for all parameters' do
    it { should contain_class('ec2base') }
  end
end
