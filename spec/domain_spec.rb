require "#{File.dirname(__FILE__)}/spec_helper"

describe 'Voting::Domain' do
  before(:each) do
    @domain = Factory.build(:domain)
  end

  specify 'should be valid' do
    @domain.should be_valid
  end

  specify 'should require a name' do
    @domain = Voting::Domain.new
    @domain.save.should be_false
    @domain.errors[:name].should include("Name must not be blank")
  end

  specify 'should require a unique name' do
    @domain.save
    @domain = Voting::Domain.new(:name => 'zerosum.org')
    @domain.save.should be_false
    @domain.errors[:name].should include("Name is already taken")
  end
end
