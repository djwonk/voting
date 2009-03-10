require "#{File.dirname(__FILE__)}/spec_helper"

describe 'Candidate' do
  before(:each) do
    @candidate = Candidate.new(:name => 'Candidate')
  end

  specify 'should be valid' do
    @candidate.should be_valid
  end

  specify 'should require a name' do
    @candidate = Candidate.new
    @candidate.save.should be_false
    @candidate.errors[:name].should include("Name must not be blank")
  end
end
