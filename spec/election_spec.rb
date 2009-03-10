require "#{File.dirname(__FILE__)}/spec_helper"

describe 'Election' do
  before(:each) do
    @election = Election.new(:name => 'Election')
  end

  specify 'should be valid' do
    @election.should be_valid
  end

  specify 'should require a name' do
    @election = Election.new
    @election.save.should be_false
    @election.errors[:name].should include("Name must not be blank")
  end
end
