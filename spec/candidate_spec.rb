require "#{File.dirname(__FILE__)}/spec_helper"

describe 'Voting::Candidate' do
  before(:each) do
    @candidate = Factory.build(:candidate_a)
  end

  specify 'should be valid' do
    @candidate.should be_valid
  end

  specify 'should require a name' do
    @candidate.name = nil
    @candidate.save.should be_false
    @candidate.errors[:name].should include("Name must not be blank")
  end

  specify 'should require an election' do
    @candidate.election = nil
    @candidate.save.should be_false
    @candidate.errors[:election].should include("Election must not be blank")
  end

  specify 'should require a unique name within the election' do
    @candidate.save
    @candidate_2 = Voting::Candidate.new(:name => @candidate.name, :election => @candidate.election)
    @candidate_2.save.should be_false
    @candidate_2.errors[:name].should include("Name is already taken")
  end
end
