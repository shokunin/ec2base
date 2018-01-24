require 'spec_helper'
describe 'ec2base' do
  context 'with default values for all parameters' do
    it { should contain_class('ec2base') }
  end
end
